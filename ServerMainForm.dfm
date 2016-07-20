object frmServer: TfrmServer
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'RemoteDB Server'
  ClientHeight = 479
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 425
    Width = 680
    Height = 54
    Align = alBottom
    TabOrder = 0
    object btStart: TcxButton
      Left = 112
      Top = 16
      Width = 75
      Height = 25
      Action = aStart
      TabOrder = 1
    end
    object btStop: TcxButton
      Left = 200
      Top = 16
      Width = 75
      Height = 25
      Action = aStop
      TabOrder = 0
    end
  end
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 680
    Height = 425
    Align = alClient
    TabOrder = 1
    object cxGridDatabases: TcxGrid
      Left = 10
      Top = 96
      Width = 660
      Height = 319
      TabOrder = 3
      object cxGridDatabasesDBLayoutView1: TcxGridDBLayoutView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Refresh.Visible = False
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Visible = False
        Navigator.Visible = True
        DataController.DataSource = dsDatabases
        DataController.KeyFieldNames = 'DB'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsCustomize.ItemFiltering = False
        OptionsView.ShowOnlyEntireRecords = False
        OptionsView.ViewMode = lvvmMultiColumn
        object cxGridDatabasesDBLayoutView1RecId: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'RecId'
          PropertiesClassName = 'TcxLabelProperties'
          Visible = False
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem1
        end
        object cxGridDatabasesDBLayoutView1SERVER: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'SERVER'
          PropertiesClassName = 'TcxMaskEditProperties'
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem4
        end
        object cxGridDatabasesDBLayoutView1DB: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'DB'
          PropertiesClassName = 'TcxMaskEditProperties'
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem8
        end
        object cxGridDatabasesDBLayoutView1USER: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'USER'
          PropertiesClassName = 'TcxMaskEditProperties'
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem6
        end
        object cxGridDatabasesDBLayoutView1PSWD: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'PSWD'
          PropertiesClassName = 'TcxMaskEditProperties'
          Properties.EchoMode = eemPassword
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem7
        end
        object cxGridDatabasesDBLayoutView1URL: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'URL'
          PropertiesClassName = 'TcxMaskEditProperties'
          OnGetDisplayText = cxGridDatabasesDBLayoutView1URLGetDisplayText
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem9
        end
        object cxGridDatabasesDBLayoutView1Connesso: TcxGridDBLayoutViewItem
          Caption = 'Started'
          DataBinding.FieldName = 'Connesso'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.ImageAlign = iaRight
          Properties.Images = ImageList1
          Properties.Items = <
            item
              Description = 'Ok'
              ImageIndex = 0
              Value = 1
            end
            item
              Description = 'Errore'
              ImageIndex = 1
              Value = 0
            end>
          Properties.ShowDescriptions = False
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem2
          Options.Editing = False
          Options.ShowEditButtons = isebNever
        end
        object cxGridDatabasesDBLayoutView1ERRORE: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'ERRORE'
          PropertiesClassName = 'TcxMemoProperties'
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem3
        end
        object cxGridDatabasesDBLayoutView1URLDOC: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'URLDOC'
          PropertiesClassName = 'TcxMaskEditProperties'
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem12
        end
        object cxGridDatabasesDBLayoutView1ATTIVO: TcxGridDBLayoutViewItem
          Caption = 'Attivo'
          DataBinding.FieldName = 'ATTIVO'
          PropertiesClassName = 'TdxToggleSwitchProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem10
        end
        object cxGridDatabasesDBLayoutView1DRIVER: TcxGridDBLayoutViewItem
          DataBinding.FieldName = 'DRIVER'
          RepositoryItem = cxRepComboDrivers
          LayoutItem = cxGridDatabasesDBLayoutView1LayoutItem11
        end
        object cxGridDatabasesDBLayoutView1Group_Root: TdxLayoutGroup
          AlignHorz = ahLeft
          AlignVert = avTop
          CaptionOptions.Text = 'Template Card'
          ButtonOptions.Buttons = <>
          Hidden = True
          ShowBorder = False
          Index = -1
        end
        object cxGridDatabasesDBLayoutView1LayoutItem1: TcxGridLayoutItem
          Index = -1
        end
        object cxGridDatabasesDBLayoutView1LayoutItem4: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group_Root
          AlignHorz = ahLeft
          SizeOptions.Width = 328
          Index = 0
        end
        object cxGridDatabasesDBLayoutView1LayoutItem6: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group1
          AlignHorz = ahLeft
          AlignVert = avTop
          SizeOptions.Width = 182
          Index = 0
        end
        object cxGridDatabasesDBLayoutView1LayoutItem7: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group1
          AlignHorz = ahLeft
          AlignVert = avClient
          SizeOptions.Width = 147
          Index = 1
        end
        object cxGridDatabasesDBLayoutView1LayoutItem8: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group3
          AlignHorz = ahLeft
          AlignVert = avTop
          SizeOptions.Width = 325
          Index = 0
        end
        object cxGridDatabasesDBLayoutView1LayoutItem9: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group_Root
          AlignHorz = ahLeft
          SizeOptions.Width = 332
          Index = 2
        end
        object cxGridDatabasesDBLayoutView1Group3: TdxLayoutAutoCreatedGroup
          Parent = cxGridDatabasesDBLayoutView1Group_Root
          AlignHorz = ahLeft
          Index = 1
          AutoCreated = True
        end
        object cxGridDatabasesDBLayoutView1LayoutItem2: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group7
          AlignHorz = ahLeft
          SizeOptions.Width = 96
          Index = 0
        end
        object cxGridDatabasesDBLayoutView1LayoutItem3: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group6
          CaptionOptions.AlignVert = tavTop
          SizeOptions.Height = 50
          SizeOptions.Width = 186
          Index = 1
        end
        object cxGridDatabasesDBLayoutView1LayoutItem10: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group7
          Index = 1
        end
        object cxGridDatabasesDBLayoutView1LayoutItem11: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group_Root
          AlignHorz = ahLeft
          AlignVert = avTop
          SizeOptions.Width = 185
          Index = 3
        end
        object cxGridDatabasesDBLayoutView1LayoutItem12: TcxGridLayoutItem
          Parent = cxGridDatabasesDBLayoutView1Group_Root
          AlignHorz = ahLeft
          SizeOptions.Width = 335
          Index = 4
        end
        object cxGridDatabasesDBLayoutView1Group6: TdxLayoutAutoCreatedGroup
          Parent = cxGridDatabasesDBLayoutView1Group_Root
          LayoutDirection = ldHorizontal
          Index = 5
          AutoCreated = True
        end
        object cxGridDatabasesDBLayoutView1Group7: TdxLayoutAutoCreatedGroup
          Parent = cxGridDatabasesDBLayoutView1Group6
          AlignHorz = ahLeft
          Index = 0
          AutoCreated = True
        end
        object cxGridDatabasesDBLayoutView1Group1: TdxLayoutAutoCreatedGroup
          Parent = cxGridDatabasesDBLayoutView1Group3
          AlignVert = avTop
          LayoutDirection = ldHorizontal
          Index = 1
          AutoCreated = True
        end
      end
      object cxGridDatabasesLevel1: TcxGridLevel
        GridView = cxGridDatabasesDBLayoutView1
      end
    end
    object cxHost: TcxMaskEdit
      Left = 79
      Top = 28
      AutoSize = False
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 0
      Height = 31
      Width = 292
    end
    object cxPorta: TcxSpinEdit
      Left = 408
      Top = 28
      AutoSize = False
      ParentFont = False
      Properties.MaxValue = 65535.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      TabOrder = 1
      Value = 2001
      Height = 32
      Width = 83
    end
    object cxCheckMonitor: TcxCheckBox
      Left = 497
      Top = 28
      Caption = 'Monitor'
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 2
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Visible = False
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutControl1Item8: TdxLayoutItem
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Databases'
      CaptionOptions.Layout = clTop
      Control = cxGridDatabases
      ControlOptions.OriginalHeight = 252
      ControlOptions.OriginalWidth = 660
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Group2: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'Server'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      Index = 0
    end
    object dxLayoutControl1Item4: TdxLayoutItem
      Parent = dxLayoutControl1Group2
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Nome Host'
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = True
      SizeOptions.SizableVert = True
      SizeOptions.Width = 349
      Control = cxHost
      ControlOptions.OriginalHeight = 31
      ControlOptions.OriginalWidth = 292
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item5: TdxLayoutItem
      Parent = dxLayoutControl1Group2
      CaptionOptions.Text = 'Porta'
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = True
      SizeOptions.SizableVert = True
      SizeOptions.Height = 32
      SizeOptions.Width = 114
      Control = cxPorta
      ControlOptions.OriginalHeight = 32
      ControlOptions.OriginalWidth = 83
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = dxLayoutControl1Group2
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = cxCheckMonitor
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 60
      ControlOptions.ShowBorder = False
      Index = 2
    end
  end
  object ActionList1: TActionList
    Left = 264
    Top = 216
    object aStart: TAction
      Caption = 'Start'
      OnExecute = aStartExecute
    end
    object aStop: TAction
      Caption = 'Stop'
      OnExecute = aStopExecute
    end
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 184
    Top = 152
    Bitmap = {
      494C010103000500040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4B8A7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4B8A7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000066FFFF0066FFFF0066
      FFFF0066FFFF0066FFFF0066FFFF0066FFFF0066FFFF0066FFFF0066FFFF0066
      FFFF0066FFFF0066FFFF08080909000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4B8A7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4B8A7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005E6B7E7E0069FFFF0069FFFF0069
      FFFF0069FFFF0069FFFF0069FFFF87BCFEFF0069FFFF0069FFFF0069FFFF0069
      FFFF0069FFFF0069FFFF4B80C9C9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4B8A7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4B8A7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000028292A2A006DFFFF006DFFFF006D
      FFFF006DFFFF006DFFFFBFDFFEFFE6F5FEFFBCDEFEFF006DFFFF006DFFFF006D
      FFFF006DFFFF006DFFFF5F6E8181000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4B8A7FF0000
      0000000000000000000000000000000000004246444800BB6BFF24CF85FF7DDE
      A8F6202020210000000000000000000000000000000000000000C4B8A7FF0000
      000000000000000000000000000000000000424347481446EBFF1D5BF6FF3170
      F5F620202021000000000000000000000000000000000474FCFC0072FFFF0072
      FFFF0072FFFF0072FFFF298CFFFFEBF7FEFF2489FFFF0072FFFF0072FFFF0072
      FFFF0072FFFF0072FFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B2BBA3FF0000
      000000000000000000000000000038A977DE00AF60FF00BB6BFF24CF85FF78E7
      A8FF57D48DFF0000000000000000000000000000000000000000ABA7B0FF0000
      00000000000000000000000000003E58C9DE0E36E2FF1446EBFF1D5BF6FF236A
      FEFF1D5AF6FF000000000000000000000000000000001A1A1B1B0076FFFF0076
      FFFF0076FFFF0076FFFF0076FFFF90C5FFFF077BFFFF0076FFFF0076FFFF0076
      FFFF0076FFFF4E545A5A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040CD88FF79E7
      A8FF6AC692E73EC97DFF1EBA6EFF04B062FF00AF60FF00BB6BFF24CF85FF78E7
      A8FF57D48DFF0000000000000000000000000000000000000000113FE7FF2164
      FBFF4378E6E71B58F4FF1242E8FF0D34E1FF0E36E2FF1446EBFF1D5BF6FF236A
      FEFF1D5AF6FF00000000000000000000000000000000000000001F85EDED007C
      FFFF007CFFFF007CFFFFA7D4FFFFF6FBFFFFF3FAFFFF007CFFFF007CFFFF007C
      FFFF007CFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040CD88FF79E7
      A8FF58D48DFF3EC97DFF1EBA6EFF04B062FF00AF60FF00BB6BFF24CF85FF78E7
      A8FF57D48DFF0000000000000000000000000000000000000000113FE7FF2164
      FBFF2368FEFF1B58F4FF1242E8FF0D34E1FF0E36E2FF1446EBFF1D5BF6FF236A
      FEFF1D5AF6FF0000000000000000000000000000000000000000050506060083
      FFFF0083FFFF0083FFFFBEE1FFFFFAFDFFFFFAFDFFFF0083FFFF0083FFFF0083
      FFFF2B2C2D2D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040CD88FF79E7
      A8FF58D48DFF3EC97DFF1EBA6EFF04B062FF00AF60FF00BB6BFF24CF85FF78E7
      A8FF57D48DFF0000000000000000000000000000000000000000113FE7FF2164
      FBFF2368FEFF1B58F4FF1242E8FF0D34E1FF0E36E2FF1446EBFF1D5BF6FF236A
      FEFF1D5AF6FF000000000000000000000000000000000000000000000000458F
      CFCF0088FFFF0088FFFFC0E2FFFFFDFEFFFFFDFEFFFF0088FFFF0088FFFF158B
      F3F3000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040CD88FF79E7
      A8FF58D48DFF3EC97DFF1EBA6EFF04B062FF00AF60FF00BB6BFF24CF85FF78E7
      A8FF57D48DFF0000000000000000000000000000000000000000113FE7FF2164
      FBFF2368FEFF1B58F4FF1242E8FF0D34E1FF0E36E2FF1446EBFF1D5BF6FF236A
      FEFF1D5AF6FF0000000000000000000000000000000000000000000000000000
      0000008EFFFF008EFFFFB9E1FFFFFFFFFFFFFFFFFFFF008EFFFF008EFFFF0B0B
      0C0C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040CD88FF79E7
      A8FF58D48DFF3EC97DFF1EBA6EFF04B062FF00AF60FF00BB6BFF24CF85FF78E7
      A8FF57D48DFF0000000000000000000000000000000000000000113FE7FF2164
      FBFF2368FEFF1B58F4FF1242E8FF0D34E1FF0E36E2FF1446EBFF1D5BF6FF236A
      FEFF1D5AF6FF0000000000000000000000000000000000000000000000000000
      00006087A5A50092FFFF0495FFFFDBF0FFFF24A3FFFF0092FFFF3B95D8D80000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040CD88FF79E7
      A8FF58D48DFF3EC97DFF1EBA6EFF04B062FF00AF60FF00BB6BFF24CF85FF78E7
      A8FF57D48DFF0000000000000000000000000000000000000000113FE7FF2164
      FBFF2368FEFF1B58F4FF1242E8FF0D34E1FF0E36E2FF1446EBFF1D5BF6FF236A
      FEFF1D5AF6FF0000000000000000000000000000000000000000000000000000
      0000000000000097FFFF0097FFFF0097FFFF0097FFFF0097FFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040CD88FF79E7
      A8FF58D48DFF3EC97DFF1EBA6EFF04B062FF6187769900000000000000000000
      000078A28AB10000000000000000000000000000000000000000113FE7FF2164
      FBFF2368FEFF1B58F4FF1242E8FF0D34E1FF656D929900000000000000000000
      0000657AADB10000000000000000000000000000000000000000000000000000
      0000000000005D6D7878009BFFFF009BFFFF009BFFFF5F8BA8A8000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004FCB8CFF79E7
      A8FF58D48DFF3EC97DFF1EBA6EFF262626270000000000000000000000000000
      0000000000000000000000000000000000000000000000000000264DE0FF2164
      FBFF2368FEFF1B58F4FF1242E8FF262626270000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000109EF6F6009EFFFF009EFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000262626270000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000262626270000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      DFFFDFFF80010000DFFFDFFF00010000DFFFDFFF00010000DF07DF0780030000
      DE07DE0780030000C007C007C0070000C007C007C0070000C007C007E00F0000
      C007C007F00F0000C007C007F01F0000C007C007F83F0000C077C077F83F0000
      C0FFC0FFFC7F0000F7FFF7FFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object TrayIcon1: TTrayIcon
    Icons = ImageList1
    OnBalloonClick = TrayIcon1BalloonClick
    OnClick = TrayIcon1BalloonClick
    OnDblClick = TrayIcon1BalloonClick
    Left = 360
    Top = 152
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    OnMinimize = ApplicationEvents1Minimize
    Left = 248
    Top = 152
  end
  object dsDatabases: TDataSource
    DataSet = dmWorkerThread.dxMemDatabases
    Left = 408
    Top = 200
  end
  object cxEditRepository1: TcxEditRepository
    Left = 512
    Top = 192
    object cxRepComboDrivers: TcxEditRepositoryComboBoxItem
      Properties.Sorted = True
    end
  end
end
