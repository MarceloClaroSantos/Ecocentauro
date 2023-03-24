object frmPesquisa: TfrmPesquisa
  Left = 216
  Top = 125
  Width = 904
  Height = 480
  Caption = 'Pesquisa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblCPF: TLabel
    Left = 39
    Top = 56
    Width = 35
    Height = 20
    Caption = 'CPF:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object txtCPF: TEdit
    Left = 103
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
    OnExit = txtCPFExit
  end
  object pnlPesquisa: TPanel
    Left = 40
    Top = 96
    Width = 801
    Height = 297
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 8
      Top = 8
      Width = 785
      Height = 281
      DataSource = dtsPessoa
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'Conexao'
    DriverName = 'UIB FireBird15'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpUIBfire15.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=UIB FireBird15'
      'BlobSize=-1'
      'CommitRetain=False'
      'Database=localhost:D:\ECOCENTAURO\EcoTeste.FDB'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Password=masterkey'
      'RoleName=RoleName'
      'ServerCharSet='
      'SQLDialect=3'
      'Interbase TransIsolation=ReadCommited'
      'User_Name=SYSDBA'
      'WaitOnLocks=True')
    VendorLib = 'fbclient.dll'
    Connected = True
    Left = 640
    Top = 24
  end
  object dataSet: TSimpleDataSet
    Active = True
    Aggregates = <>
    Connection = SQLConnection1
    DataSet.CommandText = 'select  *  from PESSOA'
    DataSet.DataSource = dtsPessoa
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 648
    Top = 64
    object dataSetID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object dataSetATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      FixedChar = True
      Size = 10
    end
    object dataSetCPF: TFMTBCDField
      FieldName = 'CPF'
      Required = True
      Precision = 15
      Size = 0
    end
    object dataSetNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object dataSetOBS: TStringField
      FieldName = 'OBS'
      Size = 100
    end
  end
  object dtsPessoa: TDataSource
    DataSet = dataSet
    Left = 696
    Top = 64
  end
  object SQLQuery: TSQLQuery
    Active = True
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM PESSOA')
    SQLConnection = SQLConnection1
    Left = 752
    Top = 64
  end
end
