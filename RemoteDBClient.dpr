program RemoteDBClient;

uses
  Vcl.Forms,
  ClientMainForm in 'ClientMainForm.pas' {fmClientMain},
  BaseController in '..\..\Farmacia\Common\BaseController.pas' {dmBaseController: TDataModule},
  DBConnection in '..\..\Farmacia\Common\DBConnection.pas',
  DMCommon in '..\..\Farmacia\Common\DMCommon.pas' {FDMCommon: TDataModule},
  Metropolis_GM in '..\..\Farmacia\Common\Metropolis_GM.pas',
  MetropolisDark in '..\..\Farmacia\Common\MetropolisDark.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFDMCommon, FDMCommon);
  Application.CreateForm(TfmClientMain, fmClientMain);
  Application.Run;
end.
