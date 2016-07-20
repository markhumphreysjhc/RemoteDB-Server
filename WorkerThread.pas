unit WorkerThread;

{$IFDEF FIREDAC}
   {$DEFINE DBMONITOR}
{$ENDIF}

interface

uses
  System.SysUtils, System.Classes, Vcl.SvcMgr, Data.DB, dxmdaset,
  RemoteDB.Server.Module, Sparkle.HttpSys.Server, RemoteDB.Drivers.Interfaces,
  {$IFDEF DBMONITOR}
  FireDAC.Moni.RemoteClient,
  {$ENDIF}
  FMX.Overbyte.IniFiles, Sparkle.Logger;

type

  TgmLogger = class(TInterfacedObject, ILogEngine)
  private
     FEventLogger: TEventLogger;
  public
     procedure Log(const Msg: string);
     constructor Create(AEventLogger: TEventLogger);
  end;

  TgmRemoteDBModule = class(TRemoteDBModule);

  TgmDBConnectionFactory = class(TInterfacedObject, IDBConnectionFactory)
  strict private
    FCreateProc: TFunc<string,string,string,string,IDBConnection>;
  private
    FServer: string;
    FDB: string;
    FUser: string;
    FPswd: string;
  public
    constructor Create(const ACreateProc: TFunc<string,string,string,string,IDBConnection>);
    function CreateConnection: IDBConnection;
    property Server: string read FServer write FServer;
    property DB: string read FDB write FDB;
    property User: string read FUser write FUser;
    property Pswd: string read FPswd write FPswd;
  end;

  TdmWorkerThread = class(TDataModule)
    dxMemDatabases: TdxMemData;
    dxMemDatabasesSERVER: TStringField;
    dxMemDatabasesDB: TStringField;
    dxMemDatabasesUSER: TStringField;
    dxMemDatabasesPSWD: TStringField;
    dxMemDatabasesURL: TStringField;
    dxMemDatabasesSTARTED: TIntegerField;
    dxMemDatabasesERRORE: TStringField;
    dxMemDatabasesATTIVO: TIntegerField;
    dxMemDatabasesDRIVER: TStringField;
    dxMemDatabasesConnesso: TIntegerField;
    dxMemDatabasesURLDOC: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dxMemDatabasesNewRecord(DataSet: TDataSet);
    procedure dxMemDatabasesCalcFields(DataSet: TDataSet);
  private
    FConfig: string;
    FServer: THttpSysServer;
    FgmLogger: TgmLogger;
    FUDPin: integer;
    FUDPout: integer;
    FUDPCheck: boolean;
    FHost: string;
    FPorta: integer;
    FMonitor: boolean;
    FEventLogger: TEventLogger;
    FService: TService;
    FIniFile: TIniFile;
{$IFDEF DBMONITOR}
    FDMonitor: TFDMoniRemoteClientLink;
{$ENDIF}

    function GetUrl: string;
    procedure SetTracing(Sender: TObject);
    function GetServerIsRunning: boolean;
  public

    procedure StartServer;
    procedure StopServer;
    function CreateIDBConnection(const server:string; const db:string; const user:string; const pswd:string): IDBConnection;

    property Config: string read FConfig write FConfig;
    property Host: string read FHost write FHost;
    property Porta: integer read FPorta write FPorta;
    property Monitor: boolean read FMonitor write FMonitor;
    property EventLogger: TEventLogger read FEventLogger write FEventLogger;
    property Service: TService read FService write FService;
    property Server: THttpSysServer read FServer write FServer;
    property IniFile: TIniFile read FIniFile write FIniFile;
    property ServerIsRunning: boolean read GetServerIsRunning;
  end;

  TWorkerThread = class(TThread)
  private
    FPaused: Boolean;
    Fdm: TdmWorkerThread;

  protected
    procedure Execute; override;
  public
    destructor Destroy; override;
    procedure Pause;
    procedure Continue;
    function IsPaused: Boolean;

    property dm: TdmWorkerThread read Fdm write Fdm;
  end;


implementation
uses Soap.XSBuiltIns, System.DateUtils, System.ioutils, Winapi.ActiveX, Vcl.Dialogs,
     ObjectsMappers, // -- helper per LoadJSONFromFile
  RemoteDB.Drivers.Base
{$IF Defined(FIREDAC)}
  ,RemoteDB.Drivers.FireDac,
//  Aurelius.Drivers.FireDac,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  {$IFDEF DBMSSQL}
//  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL,
  {$ENDIF}
  {$IFDEF DBPOSTGRESQL}
  FireDAC.Phys.PG,
  {$ENDIF}
  FireDAC.Comp.Client,
//  FireDAC.FMXUI.Wait,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.DApt
{$IFEND}
  ,Winapi.Windows, uCMDLineOptions, ServiceU;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TgmLogger.Create(AEventLogger: TEventLogger);
begin
  FEventLogger := AEventLogger;
end;

procedure TgmLogger.Log(const Msg: string);
var
  Log: TStreamWriter;
  LogFileName: string;
begin
  if FindCmdLineSwitch('GUI', ['/'], True) then
     ShowMessage( Msg );

  if FEventLogger=nil then
  begin
     LogFileName := TPath.ChangeExtension(GetModuleName(HInstance),'.log');
     Log := TStreamWriter.Create(LogFileName, True {fmCreate or fmShareDenyWrite});
     try
        Log.WriteLine(TimeToStr(now) + ': ' + Msg);
     finally
        Log.Free;
     end;
  end
  else
     FEventLogger.LogMessage(Format(STR_INFO_SVC_FAIL, [Msg]), EVENTLOG_ERROR_TYPE,0,2);
end;

{ TDBConnectionFactory }

constructor TgmDBConnectionFactory.Create(const ACreateProc: TFunc<string,string,string,string,IDBConnection>);
begin
  FCreateProc := ACreateProc;
end;

function TgmDBConnectionFactory.CreateConnection: IDBConnection;
begin
  Result := FCreateProc(Server,DB,User,Pswd);
end;


{ TdmWorkerThread }

procedure TdmWorkerThread.DataModuleCreate(Sender: TObject);
var
  ss: TStringStream;
begin

//  if not Assigned(FIniFile) then
     FIniFile := TIniFile.Create(TPath.ChangeExtension(GetModuleName(HInstance),'.ini'));

  FUDPin := FIniFile.ReadInteger('UDP', 'Ingresso', 8888);
  FUDPout := FIniFile.ReadInteger('UDP', 'Uscita', 9999);
  FUDPCheck := FIniFile.ReadBool('UDP', 'On', True);
  FHOST := FIniFile.ReadString('RemoteDB', 'Host', '');
  FPORTA := FIniFile.ReadInteger('RemoteDB', 'Porta', 2001);

  if not dxMemDatabases.Active then
     dxMemDatabases.Open;

  FConfig := TPath.ChangeExtension(GetModuleName(HInstance),'.config');
  if FileExists(FConfig) then
  begin
//     dxMemDatabases.LoadJSONFromFile(FConfig);

    dxMemDatabases.DisableControls;
    ss := TStringStream.Create;
    try
      ss.LoadFromFile(FConfig);
      dxMemDatabases.LoadFromJSONArrayString(ss.DataString);
    finally
      ss.Free;
      dxMemDatabases.First;
      dxMemDatabases.EnableControls;
    end;

  end;
end;

procedure TdmWorkerThread.DataModuleDestroy(Sender: TObject);
begin
   FreeAndNil(FIniFile);
end;

procedure TdmWorkerThread.dxMemDatabasesCalcFields(DataSet: TDataSet);
begin
  if (dxMemDatabasesSTARTED.AsInteger=1) and ServerIsRunning then
     dxMemDatabasesConnesso.AsInteger := 1
  else
     dxMemDatabasesConnesso.AsInteger := 0;
end;

procedure TdmWorkerThread.dxMemDatabasesNewRecord(DataSet: TDataSet);
begin
  dxMemDatabasesATTIVO.AsInteger := 1;
end;

procedure TdmWorkerThread.StartServer;
var
  partiti: integer;
  FRemoteModule: TgmRemoteDBModule;
  FgmConnFactory: TgmDBConnectionFactory;
begin
  // just try to connect in the database before starting the server
  // to make sure the connection string is correct. If not, an exception will be raised

  CoInitializeEx(nil, COINIT_MULTITHREADED);

  partiti := 0;
  if not dxMemDatabases.IsEmpty then
  begin
    FServer := THttpSysServer.Create;
    FgmLogger := TgmLogger.Create(self.EventLogger);
    FServer.LogEngine := FgmLogger;
    try
      try
        dxMemDatabases.DisableControls;
        dxMemDatabases.First;
        while not dxMemDatabases.Eof do
        begin
          // -- prova di connessione...
//          CreateIDBConnection.Connect;
          dxMemDatabases.Edit;
          try
          if dxMemDatabasesATTIVO.AsInteger=1 then
          begin
            FgmConnFactory := TgmDBConnectionFactory.Create(function(server:string; db:string; user:string; pswd:string): IDBConnection
                                                            begin
                                                              Result := CreateIDBConnection(server,db,user,pswd);
                                                            end);
            FgmConnFactory.Server := dxMemDatabasesSERVER.AsString;
            FgmConnFactory.DB := dxMemDatabasesDB.AsString;
            FgmConnFactory.User := dxMemDatabasesUSER.AsString;
            FgmConnFactory.Pswd := dxMemDatabasesPSWD.AsString;

            FRemoteModule := TgmRemoteDBModule.Create(GetURL, FgmConnFactory);
            FServer.AddModule(FRemoteModule);

            partiti := partiti+1;
            dxMemDatabasesSTARTED.AsInteger := 1;
            dxMemDatabasesERRORE.AsString := '';
          end
          else
            dxMemDatabasesSTARTED.AsInteger := 0;

          except
            on E:Exception do
            begin
             dxMemDatabasesSTARTED.AsInteger := 0;
             dxMemDatabasesERRORE.AsString := E.Message;
            end;
          end;
          dxMemDatabases.Post;
          dxMemDatabases.Next;
        end;

        if partiti>0 then
        begin
           FServer.Start;
        end;

      finally
        dxMemDatabases.First;
        dxMemDatabases.EnableControls;
      end;

    except
      on E:Exception do
      begin
//        FreeAndNil(FServer);
          FgmLogger.Log(Format(STR_INFO_SVC_STARTFAIL, [E.Message]));
		      raise;
      end;
    end;
  end;
end;

procedure TdmWorkerThread.StopServer;
begin
  FServer.Stop;
  dxMemDatabases.DisableControls;
  dxMemDatabases.First;
  dxMemDatabases.EnableControls;

//  FgmLogger.Free;   // -- Interfaccia! Non fare Free...
  {$IFDEF DBMONITOR}
  FreeAndNil(FDMonitor);
  {$ENDIF}

  FServer.Free;
  FServer := nil;

  CoUninitialize;
end;

function TdmWorkerThread.CreateIDBConnection(const server:string; const db:string; const user:string; const pswd:string): IDBConnection;
var
  conn: TFDConnection;
begin

  {$IFDEF DBMONITOR}
  FDMonitor := TFDMoniRemoteClientLink.Create(nil);
  FDMonitor.Tracing := FMonitor;
  {$ENDIF}

  conn := TFDConnection.Create(nil);
  conn.Params.Add(format('Database=%s',[db]));
  conn.Params.Add(format('User_Name=%s',[user]));
  conn.Params.Add(format('Password=%s',[pswd]));
  conn.Params.Add(format('Server=%s',[server]));

  if dxMemDatabasesDRIVER.AsString='' then
     conn.Params.Add('DriverID=MSSQL')
  else
     conn.Params.Add('DriverID='+dxMemDatabasesDRIVER.AsString);

  {$IFDEF DBPOSTGRESQL}
//DriverID=PG
//Server=pgsrv
     conn.Params.Add('Port=5432');
//     conn.Params.Add('CharacterSet=utf8');
//MetaDefSchema=MySchema
     conn.Params.Add('ExtendedMetadata=False');
  {$ENDIF}

  {$IFDEF DBMONITOR}
  if FMonitor then
     conn.Params.Add('MonitorBy=Remote');
  {$ENDIF}

  conn.AfterConnect := SetTracing;

  Result := TFireDacConnectionAdapter.Create( conn, true );
end;

function TdmWorkerThread.GetUrl: string;
begin
  if (FHost<>'') and (FPorta<>0) and (dxMemDatabasesDB.Text<>'') then
     result := format('http://%s:%d/%s/',[FHost,FPorta,dxMemDatabasesDB.AsString])
  else
     result := '';
end;

procedure TdmWorkerThread.SetTracing(Sender: TObject);
begin
  TFDConnection(Sender).ConnectionIntf.Tracing := FMonitor;
end;

function TdmWorkerThread.GetServerIsRunning: boolean;
begin
  result := (FServer<>nil) and FServer.IsRunning;
end;


{ --  TWorkerThread -- }

destructor TWorkerThread.Destroy;
begin
  if dm<>nil then
     dm.Free;
  inherited;
end;

procedure TWorkerThread.Continue;
begin
  FPaused := False;
end;

procedure TWorkerThread.Execute;
begin
{$IFDEF DEBUG}
    dm.EventLogger.LogMessage('Thread executed', EVENTLOG_INFORMATION_TYPE,0,2);
{$ENDIF}
  try
    dm.StartServer;

    while not Terminated do
    begin
      if not FPaused then
      begin
//        dm.WriteLog('Message from thread: ' + TimeToStr(now));
      end;
      TThread.Sleep(1000);
    end;
  except
    on E: Exception do
    begin
//      TFile.WriteAllText(TPath.Combine(ExePath, 'CRASH_LOG.TXT'), E.ClassName + ' ' + E.Message);
//        dm.WriteLog('*** Error ***');
//        dm.WriteLog(E.ClassName + ' ' + E.Message);
        dm.EventLogger.LogMessage(E.ClassName + ' ' + E.Message, EVENTLOG_ERROR_TYPE,0,4);
//        raise;
    end
  end;
end;

function TWorkerThread.IsPaused: Boolean;
begin
  Result := FPaused;
end;

procedure TWorkerThread.Pause;
begin
  FPaused := True;
end;


end.
