object fmClientMain: TfmClientMain
  Left = 0
  Top = 0
  Caption = 'TMS RemoteDB - Basic Demo Client'
  ClientHeight = 522
  ClientWidth = 638
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 161
    Width = 638
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 65
    ExplicitWidth = 407
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 638
    Height = 161
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      638
      161)
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 128
      Height = 13
      Caption = 'TMS RemoteDB Server Url:'
    end
    object edServerUri: TEdit
      Left = 142
      Top = 7
      Width = 402
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      TabOrder = 0
      Text = 'edServerUri'
    end
    object mmSQL: TMemo
      Left = 8
      Top = 34
      Width = 536
      Height = 117
      Anchors = [akLeft, akTop, akRight]
      Lines.Strings = (
        'SELECT *'
        'FROM '
        '  <table>'
        'WHERE '
        '  <condition>')
      TabOrder = 1
      WordWrap = False
    end
    object btExecute: TButton
      Left = 550
      Top = 63
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Execute SQL'
      TabOrder = 2
      OnClick = btExecuteClick
    end
    object btOpen: TButton
      Left = 550
      Top = 34
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Open SQL'
      TabOrder = 3
      OnClick = btOpenClick
    end
    object btConnect: TButton
      Left = 550
      Top = 5
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Connect'
      TabOrder = 4
      OnClick = btConnectClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 164
    Width = 638
    Height = 358
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      638
      358)
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 638
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object DBNavigator1: TDBNavigator
        Left = 8
        Top = 6
        Width = 240
        Height = 25
        DataSource = DataSource1
        TabOrder = 0
      end
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 37
      Width = 622
      Height = 313
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DataSource1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object DataSource1: TDataSource
    DataSet = XDataset1
    Left = 136
    Top = 216
  end
  object XDataset1: TXDataset
    Database = FDMCommon.gmDatabase
    Params = <>
    Left = 136
    Top = 272
  end
end
