unit Modulo;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IBCustomDataSet, IBTable, Dialogs, IBQuery,
  RegularExpressions, RegularExpressionsCore;

type
  TDmWinBank = class(TDataModule)
    IdbWinbank: TIBDatabase;
    IbtWbTrans: TIBTransaction;
    IbtClientes: TIBTable;
    DsClientes: TDataSource;
    IbtClientesCNPJ: TIBStringField;
    IbtClientesNOME: TIBStringField;
    IbtClientesFONE: TIBStringField;
    IbtClientesDTULTALT: TDateField;
    IbtBancos: TIBTable;
    IbtBancosCODIGO: TSmallintField;
    IbtBancosNOME: TIBStringField;
    DsBancos: TDataSource;
    IbtCheques: TIBTable;
    IbtChequesCNPJ: TIBStringField;
    IbtChequesBANCO: TSmallintField;
    IbtChequesAGENCIA: TSmallintField;
    IbtChequesCONTA: TSmallintField;
    IbtChequesNUMERO: TSmallintField;
    IbtChequesVALOR: TFloatField;
    IbtChequesEMISSAO: TDateField;
    IbtChequesALINEA: TSmallintField;
    IbtChequesDATAPGTO: TDateField;
    IbtChequesJUROSPAGOS: TFloatField;
    DsCheques: TDataSource;
    IbtAlineas: TIBTable;
    IbtAlineasCODIGO: TSmallintField;
    IbtAlineasDESCRICAO: TIBStringField;
    DsAlineas: TDataSource;
    IbtChequesNOMEBANCO: TStringField;
    IbtChequesVALORPAGO: TFloatField;
    IbtChequesATRASO: TDateField;
    IbqConsulta: TIBQuery;
    DsConsulta: TDataSource;
    IbqConsultaNOMECLIENTE: TIBStringField;
    IbqConsultaCNPJ: TIBStringField;
    IbqConsultaNOMEBANCO: TIBStringField;
    IbqConsultaCNPJ1: TIBStringField;
    IbqConsultaBANCO: TSmallintField;
    IbqConsultaAGENCIA: TSmallintField;
    IbqConsultaCONTA: TSmallintField;
    IbqConsultaNUMERO: TSmallintField;
    IbqConsultaVALOR: TFloatField;
    IbqConsultaEMISSAO: TDateField;
    IbqConsultaALINEA: TSmallintField;
    IbqConsultaDATAPGTO: TDateField;
    IbqConsultaJUROSPAGOS: TFloatField;
    IbqConsultaVALORPAGO: TFloatField;
    IbqChequeUpdate: TIBQuery;
    IbtClientesNomePrimeiraParte: TStringField;
    IbtClientesNomeSobrenome: TStringField;
    procedure IbtChequesCalcFields(DataSet: TDataSet);
    procedure IbtClientesCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmWinBank: TDmWinBank;

implementation

{$R *.dfm}

procedure TDmWinBank.IbtChequesCalcFields(DataSet: TDataSet);
begin
  IbtChequesATRASO.Value := Trunc(Date - IbtChequesEMISSAO.Value);

  if IbtChequesDATAPGTO.Value <> 0 then
    IbtChequesVALORPAGO.Value := IbtChequesVALOR.Value + IbtChequesJUROSPAGOS.Value;
end;


procedure TDmWinBank.IbtClientesCalcFields(DataSet: TDataSet);
var
  I, Ls: Integer;

begin
  if(Length(IbtClientesNOME.Value) > 0) then
    If(Pos(' ', IbtClientesNOME.Value) > 0) then
      begin
        for i := 0 to Length(IbtClientesNOME.Value) - 1 do
          if(IbtClientesNOME.Value[i] = ' ') then
            Ls := i;

        IbtClientesNomePrimeiraParte.Value := Copy(IbtClientesNOME.Value, 0, Ls);
        IbtClientesNomeSobreNome.Value     := Copy(IbtClientesNOME.Value, Ls + 1, Length(IbtClientesNOME.Value));
      end
    else
      IbtClientesNomePrimeiraParte.Value := IbtClientesNOME.Value;
end;

end.
