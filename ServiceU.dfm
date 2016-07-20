object RemoteDB_Service: TRemoteDB_Service
  OldCreateOrder = False
  OnCreate = ServiceCreate
  Dependencies = <
    item
      IsGroup = False
    end>
  DisplayName = 'RemoteDB Server'
  AfterInstall = ServiceAfterInstall
  AfterUninstall = ServiceAfterUnInstall
  OnContinue = ServiceContinue
  OnPause = ServicePause
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 349
  Width = 577
end
