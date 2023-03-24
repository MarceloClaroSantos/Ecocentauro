unit EcoTeste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, DB, SqlExpr, StdCtrls, Mask, FMTBcd, DBCtrls,
  DBClient, SimpleDS, Grids, DBGrids, Provider;

type
  TfrmEcoTeste = class(TForm)
    lblCPF: TLabel;
    lblNome: TLabel;
    lblObs: TLabel;
    chkAtivo: TCheckBox;
    txtNome: TEdit;
    btnNovo: TButton;
    btnGravar: TButton;
    btnPesquisa: TButton;
    mskCPF: TMaskEdit;
    txtObs: TEdit;
    dataSet: TSimpleDataSet;
    dtsPessoa: TDataSource;
    dataSetID: TIntegerField;
    dataSetATIVO: TStringField;
    dataSetCPF: TFMTBCDField;
    dataSetNOME: TStringField;
    dataSetOBS: TStringField;
    SQLConnection1: TSQLConnection;
    SQLQuery: TSQLQuery;
    procedure mskCPFExit(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure mskCPFEnter(Sender: TObject);
  private
    { Private declarations }
  strCPF, strAltera: String;
  strID: Integer;
  public
    { Public declarations }

  end;

var
  frmEcoTeste: TfrmEcoTeste;

function ValidarCpf(CPF: string): boolean;

function Gravar(Ativo: Boolean; Cpf, Nome, Obs : string): boolean;

function BuscaCpf(CPF : String) : boolean;

implementation

uses StrUtils, Pesquisa;

{$R *.dfm}

procedure TfrmEcoTeste.mskCPFExit(Sender: TObject);
//var strCPF: String;
begin
   strCPF := trim(stringReplace(mskCPF.Text, '.', '', [rfReplaceAll, rfIgnoreCase]));
   if length(strCPF) <> 11 then
      mskCPF.SetFocus();

   if strCPF = '' then
   begin
      frmPesquisa.ShowModal;
      exit;
   end;

   if not ValidarCpf(strCPF) then
   begin
     showMessage('Cpf inválido');
     mskCPF.SetFocus();
   end;

   BuscaCpf(strCPF);

end;

function ValidarCpf(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin

// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              ValidarCpf := false;
              exit;
            end;

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then ValidarCpf := true
    else ValidarCpf := false;
  except
    ValidarCpf := false
  end;
end;

procedure TfrmEcoTeste.btnNovoClick(Sender: TObject);
begin
  chkAtivo.Checked := False;
  mskCPF.Text := '';
  txtObs.Text := '';
  txtNome.Text := '';
end;

procedure TfrmEcoTeste.btnGravarClick(Sender: TObject);
begin

   if trim(txtNome.Text) = '' then
   begin
      showMessage('Informe o Nome da Pessoa');
      frmEcoTeste.txtNome.SetFocus;
      exit;
   end;

   Gravar(chkAtivo.Checked, strCPF, trim(txtNome.Text), trim(txtObs.Text));
   btnNovoClick(nil);
   chkAtivo.SetFocus();
end;

function Gravar(Ativo : Boolean; Cpf, Nome, Obs : string) : Boolean;
var TD: TTransactionDesc;
begin

   TD.TransactionID:=1;
   TD.IsolationLevel:=xilREADCOMMITTED;
   frmEcoTeste.SQLConnection1.StartTransaction(TD);

   try

     if frmEcoTeste.strAltera = 'N' then
        frmEcoTeste.dataSet.Append
     else
        frmEcoTeste.dataSet.Edit;

     frmEcoTeste.dataSetID.Value := frmEcoTeste.strID;
     frmEcoTeste.dataSetATIVO.AsBoolean := Ativo;
     frmEcoTeste.dataSetCPF.AsBCD := StrToBcd(CPF);
     frmEcoTeste.dataSetNOME.Value := Nome;
     frmEcoTeste.dataSetOBS.Value := Obs;
     frmEcoTeste.dataSet.Post;

     frmEcoTeste.SQLConnection1.Commit(TD);
     frmEcoTeste.dataSet.ApplyUpdates(-1);
   except
     Showmessage('Erro ao Gravar Registro');
    end;
     Showmessage('Registro gravado com Sucesso');

     frmEcoTeste.SQLConnection1.CloneConnection;
   result := true;

end;

function BuscaCpf(CPF : String) : boolean;
begin
  result := True;
  frmEcoTeste.SQLQuery.SQL.Text := 'SELECT * FROM PESSOA WHERE CPF = ' + CPF;
  frmEcoTeste.SQLQuery.Open;
  frmEcoTeste.strAltera := 'N';

  if frmECoTeste.SQLQuery.RecordCount > 0 then
  begin
     frmEcoTeste.strID            := frmEcoTeste.SQLQuery.FieldByName('ID').AsInteger;
     frmEcoTeste.chkAtivo.Checked := frmEcoTeste.SQLQuery.FieldByName('ATIVO').AsBoolean;
     frmEcoTeste.txtNome.Text     := frmEcoTeste.SQLQuery.FieldByName('NOME').AsString;
     frmEcoteste.txtObs.Text      := frmEcoTeste.SQLQuery.FieldByName('OBS').AsString;
     frmEcoTeste.strAltera        := 'S';
     frmEcoTeste.Refresh();
     frmEcoTeste.chkAtivo.SetFocus();
     exit;
  end;

  frmEcoTeste.SQLQuery.Close;

  frmEcoTeste.SQLQuery.SQL.Text := 'SELECT MAX(ID)+1 AS ID FROM PESSOA';
  frmEcoTeste.SQLQuery.Open;

  frmEcoTeste.strID := frmEcoTeste.SQLQuery.FieldByName('ID').AsInteger;
  frmEcoTeste.chkAtivo.SetFocus();
  result := false;

end;


procedure TfrmEcoTeste.btnPesquisaClick(Sender: TObject);
begin
   frmPesquisa.ShowModal;
end;

procedure TfrmEcoTeste.mskCPFEnter(Sender: TObject);
begin 

   strCPF := trim(stringReplace(mskCPF.Text, '.', '', [rfReplaceAll, rfIgnoreCase]));
   if length(strCPF) <> 11 then
      mskCPF.SetFocus();

   if strCPF = '' then
   begin
      frmPesquisa.ShowModal;
      exit;
   end;

   if not ValidarCpf(strCPF) then
   begin
     showMessage('Cpf inválido');
     mskCPF.SetFocus();
   end;

   BuscaCpf(strCPF);

end;

end.
