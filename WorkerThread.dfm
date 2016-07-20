object dmWorkerThread: TdmWorkerThread
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 448
  Width = 611
  object dxMemDatabases: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0300000014000000010005004E6F6D650004000000
      030007004E756D65726F0004000000090005004461746100}
    SortOptions = []
    OnCalcFields = dxMemDatabasesCalcFields
    OnNewRecord = dxMemDatabasesNewRecord
    Left = 202
    Top = 97
    object dxMemDatabasesSERVER: TStringField
      DisplayLabel = 'Server'
      FieldName = 'SERVER'
      Required = True
      Size = 50
    end
    object dxMemDatabasesDB: TStringField
      FieldName = 'DB'
      Required = True
      Size = 50
    end
    object dxMemDatabasesUSER: TStringField
      DisplayLabel = 'User'
      FieldName = 'USER'
    end
    object dxMemDatabasesPSWD: TStringField
      DisplayLabel = 'Pswd'
      FieldName = 'PSWD'
    end
    object dxMemDatabasesURL: TStringField
      FieldName = 'URL'
      Size = 150
    end
    object dxMemDatabasesURLDOC: TStringField
      DisplayLabel = 'Url Doc'
      FieldKind = fkCalculated
      FieldName = 'URLDOC'
      Size = 150
      Calculated = True
    end
    object dxMemDatabasesSTARTED: TIntegerField
      DisplayLabel = 'Started'
      FieldName = 'STARTED'
    end
    object dxMemDatabasesERRORE: TStringField
      DisplayLabel = 'Errore'
      FieldName = 'ERRORE'
      Size = 300
    end
    object dxMemDatabasesATTIVO: TIntegerField
      FieldName = 'ATTIVO'
    end
    object dxMemDatabasesDRIVER: TStringField
      DisplayLabel = 'Driver'
      FieldName = 'DRIVER'
      Size = 50
    end
    object dxMemDatabasesConnesso: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Connesso'
      Calculated = True
    end
  end
end
