unit RelChequesPagamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, DB, IBCustomDataSet, IBQuery, QRCtrls;

type
  TFmRelChequesPagamentos = class(TForm)
    QrChequesPagamentos: TQuickRep;
    IbqChequesPagamentos: TIBQuery;
    IbqChequesPagamentosNOME: TIBStringField;
    IbqChequesPagamentosCNPJ: TIBStringField;
    IbqChequesPagamentosBANCO: TSmallintField;
    IbqChequesPagamentosAGENCIA: TSmallintField;
    IbqChequesPagamentosCONTA: TSmallintField;
    IbqChequesPagamentosNUMERO: TSmallintField;
    IbqChequesPagamentosVALOR: TFloatField;
    IbqChequesPagamentosEMISSAO: TDateField;
    IbqChequesPagamentosALINEA: TSmallintField;
    IbqChequesPagamentosDATAPGTO: TDateField;
    IbqChequesPagamentosJUROSPAGOS: TFloatField;
    IbqChequesPagamentosVALORPAGO: TCurrencyField;
    QrbHeader: TQRBand;
    QRLabel1: TQRLabel;
    QrlPeriodo: TQRLabel;
    QRSysData1: TQRSysData;
    QrbSummary: TQRBand;
    QrlTotal: TQRLabel;
    QrbDetail: TQRBand;
    QRDBText3: TQRDBText;
    QrgData: TQRGroup;
    QRDBText1: TQRDBText;
    QrbRodapeGroup: TQRBand;
    QrlTotalDia: TQRLabel;
    QrGroupNome: TQRGroup;
    QrbGroupFooterName: TQRBand;
    QRDBText2: TQRDBText;
    procedure IbqChequesPagamentosCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmRelChequesPagamentos: TFmRelChequesPagamentos;

implementation

uses Modulo, DlgReports;

{$R *.dfm}

procedure TFmRelChequesPagamentos.FormCreate(Sender: TObject);
begin
  with IbqChequesPagamentos, FmReports do
  begin
    Active := False;
    ParamByName('st').AsDate := DtpInicio.Date;
    ParamByName('ed').AsDate := DtpFim.Date;
    Active := True;
  end;
end;

procedure TFmRelChequesPagamentos.IbqChequesPagamentosCalcFields(
  DataSet: TDataSet);
begin
  IbqChequesPagamentosVALORPAGO.Value := IbqChequesPagamentosJUROSPAGOS.Value +
    IbqChequesPagamentosVALOR.Value;
end;

end.
