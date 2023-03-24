object frmEcoTeste: TfrmEcoTeste
  Left = 192
  Top = 108
  Width = 928
  Height = 480
  Caption = 'Cadastro de Pessoa'
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
    Left = 126
    Top = 80
    Width = 26
    Height = 16
    Caption = 'CPF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblNome: TLabel
    Left = 126
    Top = 112
    Width = 34
    Height = 16
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblObs: TLabel
    Left = 126
    Top = 144
    Width = 24
    Height = 16
    Caption = 'Obs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object chkAtivo: TCheckBox
    Left = 270
    Top = 79
    Width = 56
    Height = 17
    Alignment = taLeftJustify
    BiDiMode = bdLeftToRight
    Caption = 'Ativo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 1
  end
  object txtNome: TEdit
    Left = 168
    Top = 110
    Width = 377
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 2
  end
  object btnNovo: TButton
    Left = 136
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 3
    OnClick = btnNovoClick
  end
  object btnGravar: TButton
    Left = 248
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = btnGravarClick
  end
  object btnPesquisa: TButton
    Left = 363
    Top = 312
    Width = 73
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 5
    OnClick = btnPesquisaClick
  end
  object mskCPF: TMaskEdit
    Left = 168
    Top = 80
    Width = 87
    Height = 21
    EditMask = '###.###.###.##;0'
    MaxLength = 14
    TabOrder = 0
    OnExit = mskCPFExit
  end
  object txtObs: TEdit
    Left = 168
    Top = 140
    Width = 681
    Height = 21
    MaxLength = 100
    TabOrder = 6
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
    Left = 600
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
