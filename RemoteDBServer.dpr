program RemoteDBServer;

uses
  FastMM4,
  madExcept,
  madListProcesses,
  madListModules,
  Vcl.SvcMgr,
  Vcl.Forms,
  System.SysUtils,
  ServerMainForm in 'ServerMainForm.pas' {frmServer},
  ServiceU in 'ServiceU.pas' {RemoteDB_Service: TService},
  WorkerThread in 'WorkerThread.pas' {dmWorkerThread: TDataModule};

{$R *.res}

begin

  if FindCmdLineSwitch('GUI', ['/'], True) then
  begin
//    ReportMemoryLeaksOnShutdown := DebugHook<>0;
    Vcl.Forms.Application.Initialize;
    Vcl.Forms.Application.MainFormOnTaskbar := True;
    Vcl.Forms.Application.Title := 'RemoteDB Server';
    Application.CreateForm(TfrmServer, frmServer);
  Vcl.Forms.Application.Run;
  end
  else
  begin
    if not Vcl.SvcMgr.Application.DelayInitialize or Vcl.SvcMgr.Application.Installing then
      Vcl.SvcMgr.Application.Initialize;
    Vcl.SvcMgr.Application.CreateForm(TRemoteDB_Service, RemoteDB_Service);
    Vcl.SvcMgr.Application.Run;
  end;

end.
