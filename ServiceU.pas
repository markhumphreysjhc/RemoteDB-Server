unit ServiceU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  WorkerThread;

type
  TRemoteDB_Service = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceAfterUnInstall(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
 //   procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceShutdown(Sender: TService);

  private
    FWorkerThread: TWorkerThread;
    FEventLogger: TEventLogger;
  public
    function GetServiceController: TServiceController; override;
    procedure StopService;
  end;

{$R *.dfm}

// -- attivare per risorse nell'.exe
{.$R MyServiceMessageResource.res}

const
  lDescService = 'RemoteDB Server';
  STR_INFO_SVC_BEGIN = 'Service begin';
  STR_INFO_SVC_STARTED = 'Service started';
  STR_INFO_SVC_STOPPED = 'Service stopped';
  STR_INFO_SVC_CONTINUE = 'Service continued';
  STR_INFO_SVC_PAUSE = 'Service paused';
  STR_INFO_SVC_STARTFAIL = 'Service start error: %s';
  STR_INFO_SVC_STOPFAIL = 'Service stop error: %s';
  STR_INFO_SVC_FAIL = 'Service error: %s';

var
  RemoteDB_Service: TRemoteDB_Service;

implementation

uses
  System.Win.Registry, System.ioutils, uCMDLineOptions, Winapi.WinSvc;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  RemoteDB_Service.Controller(CtrlCode);
end;

function TRemoteDB_Service.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TRemoteDB_Service.ServiceCreate(Sender: TObject);
begin
  DisplayName  := TPath.GetFileNameWithoutExtension(GetModuleName(HInstance));
  FEventLogger := TEventLogger.Create(DisplayName);
{$IFDEF DEBUG}
  FEventLogger.LogMessage('Logger attivato', EVENTLOG_INFORMATION_TYPE,0,2);
{$ENDIF}
//  TCMDLineOptions.ReadCMDParameters;
{$IFDEF DEBUG}
//  FEventLogger.LogMessage('Parametri caricati', EVENTLOG_INFORMATION_TYPE,0,2);
{$ENDIF}
end;

procedure TRemoteDB_Service.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
  Key: string;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + self.name, false) then
    begin
      Reg.WriteString('Description', lDescService);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;

  // Create registry entries so that the event viewer show messages properly when we use the LogMessage method.
  Key := '\SYSTEM\CurrentControlSet\Services\Eventlog\Application\' + DisplayName;
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey(Key, True) then
    begin
//      Reg.WriteString('EventMessageFile', ParamStr(0));    // -- risorse nell'.exe
      Reg.WriteString('EventMessageFile', TPath.ChangeExtension(GetModuleName(HInstance),'.dll'));    // -- risorse nella .Dll
      Reg.WriteInteger('TypesSupported', 7);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;

end;

procedure TRemoteDB_Service.ServiceAfterUnInstall(Sender: TService);
var
  Reg: TRegistry;
  Key: string;
begin
  // Delete registry entries for event viewer.
  Key := '\SYSTEM\CurrentControlSet\Services\Eventlog\Application\' + DisplayName;
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.KeyExists(Key) then
      Reg.DeleteKey(Key);
  finally
    Reg.Free;
  end;
end;

procedure TRemoteDB_Service.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  FEventLogger.LogMessage(STR_INFO_SVC_CONTINUE, EVENTLOG_INFORMATION_TYPE,0,2);
  FWorkerThread.Continue;
  Continued := True;
end;

procedure TRemoteDB_Service.ServicePause(Sender: TService; var Paused: Boolean);
begin
  FEventLogger.LogMessage(STR_INFO_SVC_PAUSE, EVENTLOG_INFORMATION_TYPE,0,2);
  FWorkerThread.Pause;
  Paused := True;
end;

procedure TRemoteDB_Service.ServiceStart(Sender: TService; var Started: Boolean);
begin
{$IFDEF DEBUG}
  FEventLogger.LogMessage(STR_INFO_SVC_BEGIN, EVENTLOG_INFORMATION_TYPE,0,2);
{$ENDIF}
  Started := False;
  try
    FWorkerThread := TWorkerThread.Create(True);
    FWorkerThread.FreeOnTerminate:= True;
    FWorkerThread.dm := TdmWorkerThread.Create(nil);
    FWorkerThread.dm.Service := self;
    FWorkerThread.dm.EventLogger := FEventLogger;

    FWorkerThread.Start;
    FEventLogger.LogMessage(STR_INFO_SVC_STARTED, EVENTLOG_INFORMATION_TYPE,0,2);
    Started := True;
  except
    on E : Exception do
    begin
      // add event in eventlog with reason why the service couldn't start
      FEventLogger.LogMessage(Format(STR_INFO_SVC_STARTFAIL, [E.Message]), EVENTLOG_ERROR_TYPE,0,2);
    end;
  end;
end;

procedure TRemoteDB_Service.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  try
    Stopped := True; // always stop service, even if we had exceptions, this is to prevent "stuck" service (must reboot then)
    FWorkerThread.Terminate;
(*
    // give MyThread 60 seconds to terminate
    if WaitForSingleObject(FWorkerThread.ThreadEvent, 60000) = WAIT_OBJECT_0 then
    begin
      FreeAndNil(FWorkerThread);
      FEventLogger.LogMessage(STR_INFO_SVC_STOPPED, EVENTLOG_INFORMATION_TYPE,0,2);
      FEventLogger.Free;
    end;
*)
    FWorkerThread.WaitFor;
    FreeAndNil(FWorkerThread);
    FEventLogger.LogMessage(STR_INFO_SVC_STOPPED, EVENTLOG_INFORMATION_TYPE,0,2);
    FEventLogger.Free;
    Stopped := True;

  except
    on E : Exception do
    begin
      // add event in eventlog with reason why the service couldn't stop
      FEventLogger.LogMessage(Format(STR_INFO_SVC_STOPFAIL, [E.Message]), EVENTLOG_ERROR_TYPE,0,4);
    end;
  end;

end;

{
procedure TRemoteDB_Service.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
    if (FWorkerThread<>nil) and (FWorkerThread.dm<>nil) then
       FWorkerThread.dm.WriteLog('ServiceExecute');
    ServiceThread.ProcessRequests(false);
    TThread.Sleep(1000);
  end;
end;
}

procedure TRemoteDB_Service.ServiceShutdown(Sender: TService);
var
  Stopped : boolean;
begin
  // is called when windows shuts down
  ServiceStop(Self, Stopped);
end;

procedure TRemoteDB_Service.StopService;
var
  Ctrl: TServiceController;
begin
  Ctrl := ServiceController;
  Ctrl(SERVICE_CONTROL_STOP);
end;

end.
