program EcoNovo;

uses
  Forms,
  EcoTeste in 'C:\Program Files (x86)\Borland\Delphi7\Projects\EcoTeste.pas' {frmEcoTeste},
  Pesquisa in 'Pesquisa.pas' {frmPesquisa};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmEcoTeste, frmEcoTeste);
  Application.CreateForm(TfrmPesquisa, frmPesquisa);
  Application.Run;
end.
