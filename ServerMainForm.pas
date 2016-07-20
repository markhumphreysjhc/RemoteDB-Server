unit ServerMainForm;

interface

uses Vcl.Forms, System.SysUtils, WorkerThread,{}cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxStyles, cxCustomData, Data.DB,
  cxDBData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxLabel,
  cxMaskEdit, cxImageComboBox, cxMemo, cxCheckBox, dxToggleSwitch, cxContainer,
  dxLayoutContainer, dxLayoutcxEditAdapters, cxEditRepositoryItems,
  Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.ImgList, Vcl.Controls, System.Classes,
  System.Actions, Vcl.ActnList, cxTextEdit, cxSpinEdit, cxGridLevel,
  cxGridViewLayoutContainer, cxGridLayoutView, cxGridCustomTableView,
  cxGridDBLayoutView, cxClasses, cxGridCustomView, cxGridCustomLayoutView,
  cxGrid, dxLayoutControl, Vcl.StdCtrls, cxButtons, System.ImageList,
  cxButtonEdit, dxSkinsCore, dxSkinscxPCPainter;

type
  TfrmServer = class(TForm)
    btStop: TcxButton;
    btStart: TcxButton;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    Panel1: TPanel;
    ActionList1: TActionList;
    aStart: TAction;
    aStop: TAction;
    ImageList1: TImageList;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    dsDatabases: TDataSource;
    cxGridDatabasesLevel1: TcxGridLevel;
    cxGridDatabases: TcxGrid;
    dxLayoutControl1Item8: TdxLayoutItem;
    cxGridDatabasesDBLayoutView1Group_Root: TdxLayoutGroup;
    cxGridDatabasesDBLayoutView1: TcxGridDBLayoutView;
    cxGridDatabasesDBLayoutView1LayoutItem1: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1RecId: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1LayoutItem4: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1SERVER: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1LayoutItem6: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1USER: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1LayoutItem7: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1PSWD: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1LayoutItem8: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1DB: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1LayoutItem9: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1URL: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1Group3: TdxLayoutAutoCreatedGroup;
    dxLayoutControl1Group2: TdxLayoutGroup;
    dxLayoutControl1Item4: TdxLayoutItem;
    dxLayoutControl1Item5: TdxLayoutItem;
    cxHost: TcxMaskEdit;
    cxPorta: TcxSpinEdit;
    cxGridDatabasesDBLayoutView1LayoutItem2: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1Connesso: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1LayoutItem3: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1ERRORE: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1LayoutItem10: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1ATTIVO: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1LayoutItem11: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1DRIVER: TcxGridDBLayoutViewItem;
    cxEditRepository1: TcxEditRepository;
    cxRepComboDrivers: TcxEditRepositoryComboBoxItem;
    cxCheckMonitor: TcxCheckBox;
    cxGridDatabasesDBLayoutView1LayoutItem12: TcxGridLayoutItem;
    cxGridDatabasesDBLayoutView1URLDOC: TcxGridDBLayoutViewItem;
    cxGridDatabasesDBLayoutView1Group6: TdxLayoutAutoCreatedGroup;
    cxGridDatabasesDBLayoutView1Group7: TdxLayoutAutoCreatedGroup;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aStartExecute(Sender: TObject);
    procedure aStopExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1BalloonClick(Sender: TObject);
    procedure cxCheckDebugPropertiesEditValueChanged(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure cxGridDatabasesDBLayoutView1URLGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    wt: TdmWorkerThread;
    function GetUrl: string;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmServer: TfrmServer;

implementation

uses
  madexcept,
//  Modules.RBExecute,
  ObjectsMappers, // -- helper per LoadJSONFromFile
  FMX.Overbyte.IniFiles,
  Winapi.ActiveX,
  Winapi.Windows,
  Vcl.Dialogs,
  System.UITypes,
  cxDropDownEdit;

{$R *.dfm}

constructor TfrmServer.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TfrmServer.aStartExecute(Sender: TObject);
begin
  wt.Monitor := cxCheckMonitor.Checked;
  wt.StartServer;
end;

procedure TfrmServer.aStopExecute(Sender: TObject);
begin
  wt.StopServer;
end;

procedure TfrmServer.cxCheckDebugPropertiesEditValueChanged(Sender: TObject);
begin
//  MESettings.AutoSend := not cxCheckDebug.Checked;
end;

procedure TfrmServer.cxGridDatabasesDBLayoutView1URLGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := GetURL;
end;

function TfrmServer.GetUrl: string;
begin
  if (cxHost.Text<>'') and (cxPorta.Value<>0) and (wt.dxMemDatabasesDB.Text<>'') then
     result := format('http://%s:%s/%s/',[cxHost.Text,cxPorta.Value,wt.dxMemDatabasesDB.AsString])
  else
     result := '';
end;


procedure TfrmServer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (wt=nil) or not wt.ServerIsRunning or (MessageDlg('Confermi chiusura Server ?',mtConfirmation,[mbYes,mbNo],0,mbNo)=mrYes);
end;

procedure TfrmServer.FormCreate(Sender: TObject);
var
  FTempIni: TIniFile;
  i: integer;
  lList: TStringList;
begin

//  MESettings.AutoSend := True;
  MESettings.AutoShowBugReport := true;
  wt := TdmWorkerThread.Create(nil);

  dsDatabases.DataSet := wt.dxMemDatabases;
  cxHOST.Text := wt.Host;
  cxPORTA.Value := wt.Porta;

{$IFDEF DBMSSQL}
  TcxComboBoxProperties(cxRepComboDrivers.Properties).Items.Add('MSSQL');
{$ENDIF}
{$IFDEF DBPOSTGRESQL}
  TcxComboBoxProperties(cxRepComboDrivers.Properties).Items.Add('PG');
{$ENDIF}

  if FileExists('FDDrivers.ini') then
  begin
     lList := TStringList.Create;
     FTempIni := TIniFile.Create(ExtractFilePath(Paramstr(0))+'FDDrivers.ini');
     try
       FTempIni.ReadSections(lList);
       for i:=0 to lList.Count-1 do
         if lList[i]<>'FDDrivers.ini' then
            TcxComboBoxProperties(cxRepComboDrivers.Properties).Items.Add(lList[i]);
     finally
       FTempIni.Free;
       lList.Free;
     end;
  end;

//  wt.StartServer;

end;

procedure TfrmServer.FormDestroy(Sender: TObject);
var
  ss: TStringStream;
begin

  if wt<>nil then
  begin

    if Assigned(wt.IniFile) then
    begin
        wt.IniFile.WriteString('RemoteDB', 'Host', cxHOST.Text);
        wt.IniFile.WriteInteger('RemoteDB', 'Porta', cxPORTA.Value);
    end;

    if wt.ServerIsRunning then
       wt.StopServer;

//    wt.dxMemDatabases.SaveJSONToFile(wt.Config);
    wt.dxMemDatabases.DisableControls;
    wt.dxMemDatabases.First;
    ss := TStringStream.Create( wt.dxMemDatabases.AsJSONArrayString );
    try
      ss.Seek(0, soFromBeginning);  // -- serve ???
      ss.SaveToFile(wt.Config);
    finally
      ss.Free;
      wt.dxMemDatabases.EnableControls;
    end;

    FreeAndNil(wt);

  end;

end;


procedure TfrmServer.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  aStart.Enabled := (wt<>nil) and not wt.ServerIsRunning and not wt.dxMemDatabases.IsEmpty;
  aStop.Enabled  := (wt<>nil) and wt.ServerIsRunning;
end;

procedure TfrmServer.ApplicationEvents1Minimize(Sender: TObject);
begin
  TrayIcon1.Visible := True;
  TrayIcon1.BalloonTitle := 'RemoteDB Server';
  TrayIcon1.BalloonHint :=
    'RemoteDB Server is still running in the tray.' + sLineBreak + 'Reactivate it with a double click on the tray icon';
  TrayIcon1.BalloonFlags := bfInfo;
  TrayIcon1.ShowBalloonHint;
  TrayIcon1.IconIndex := 0;
  Hide;
end;

procedure TfrmServer.TrayIcon1BalloonClick(Sender: TObject);
begin
  Visible := True;
  TrayIcon1.Visible := False;
  WindowState := wsNormal;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
  SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
end;

end.
