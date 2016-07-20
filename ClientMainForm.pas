unit ClientMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  RemoteDB.Client.Dataset, RemoteDB.Client.Database;

//const
//  ServerUrl = 'http://localhost:2001/tms/business/remotedb/basic/';
//  ServerUrl = 'http://xe6:2001/fstile/';
//  ServerUrl = 'http://54.76.253.29:2001/fstile/';
type
  TfmClientMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Label1: TLabel;
    edServerUri: TEdit;
    mmSQL: TMemo;
    btExecute: TButton;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    XDataset1: TXDataset;
    btOpen: TButton;
    btConnect: TButton;
    procedure btConnectClick(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
    procedure btExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Connect;
  public
    procedure InitiateAction; override;
  end;

var
  fmClientMain: TfmClientMain;

implementation
uses DBConnection, DMCommon;

{$R *.dfm}

{ TForm2 }

procedure TfmClientMain.btConnectClick(Sender: TObject);
begin
  Connect;
end;

procedure TfmClientMain.btExecuteClick(Sender: TObject);
begin
  Connect;
  XDataset1.SQL := mmSQL.Lines;
  XDataset1.Execute;
end;

procedure TfmClientMain.btOpenClick(Sender: TObject);
begin
  Connect;
  XDataset1.SQL := mmSQL.Lines;
  XDataset1.Open;
end;

procedure TfmClientMain.Connect;
begin
  if not FDMCommon.gmDatabase.Connected then
  begin
//    RemoteDBDatabase1.ServerUri := edServerUri.Text;
    FDMCommon.gmDatabase.Connected := true;
  end;
end;

procedure TfmClientMain.FormCreate(Sender: TObject);
begin
  edServerUri.Text := TDBConnection.FXDB.ServerUri;
end;

procedure TfmClientMain.InitiateAction;
begin
  inherited;
  btConnect.Enabled := not FDMCommon.gmDatabase.Connected;
end;

end.
