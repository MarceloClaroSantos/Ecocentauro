unit Pesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBXpress, FMTBcd, SqlExpr, DB, DBClient,
  SimpleDS, Grids, DBGrids;

type
  TfrmPesquisa = class(TForm)
    lblCPF: TLabel;
    txtCPF: TEdit;
    pnlPesquisa: TPanel;
    DBGrid1: TDBGrid;
    SQLConnection1: TSQLConnection;
    dataSet: TSimpleDataSet;
    dataSetID: TIntegerField;
    dataSetATIVO: TStringField;
    dataSetCPF: TFMTBCDField;
    dataSetNOME: TStringField;
    dataSetOBS: TStringField;
    dtsPessoa: TDataSource;
    SQLQuery: TSQLQuery;
    procedure txtCPFExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

procedure TfrmPesquisa.txtCPFExit(Sender: TObject);
begin
   frmPesquisa.dataSet.Locate('CPF',Vararrayof([txtCPF.Text]),[loPartialKey,LocaseInsensitive]);

end;

end.
