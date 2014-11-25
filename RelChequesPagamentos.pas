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
    QrbDetail: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText1: TQRDBText;
    QrbRodapeGroup: TQRBand;
    QrlTotalDia: TQRLabel;
    QrbGroupFooterName: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel10: TQRLabel;
    QrlTotalPessoa: TQRLabel;
    QrlTotalJurosPagosPessoa: TQRLabel;
    QrlTotalValorPagoPessoa: TQRLabel;
    QrlTotalJurosPagosDia: TQRLabel;
    QrlTotalValorPagoDia: TQRLabel;
    QrlTotal: TQRLabel;
    QrlTotalJurosPagos: TQRLabel;
    QrlTotalValorPago: TQRLabel;
    procedure IbqChequesPagamentosCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure QrChequesPagamentosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QrgDataBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QrGroupNomeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrbDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrbGroupFooterNameBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrbRodapeGroupBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrbSummaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
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

var
  TotalValor,      TotalValorDia,      TotalValorPessoa,
  TotalJurosPagos, TotalJurosPagosDia, TotalJurosPagosPessoa,
  TotalValorPago,  TotalValorPagoDia,  TotalValorPagoPessoa: Currency;

procedure TFmRelChequesPagamentos.FormCreate(Sender: TObject);
begin
  with IbqChequesPagamentos do
  begin
    Active := False;
    with FmReports do
    begin
      ParamByName('st').AsDate := DtpInicio.Date;
      ParamByName('ed').AsDate := DtpFim.Date;
    end;
    Active := True;
  end;
end;

procedure TFmRelChequesPagamentos.IbqChequesPagamentosCalcFields(
  DataSet: TDataSet);
begin
  IbqChequesPagamentosVALORPAGO.Value := IbqChequesPagamentosJUROSPAGOS.Value +
    IbqChequesPagamentosVALOR.Value;
end;

procedure TFmRelChequesPagamentos.QrbDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotalValor      := TotalValor      + IbqChequesPagamentosVALOR.Value;
  TotalJurosPagos := TotalJurosPagos + IbqChequesPagamentosJUROSPAGOS.Value;
  TotalValorPago  := TotalValorPago  + IbqChequesPagamentosVALORPAGO.Value;
  TotalValorDia      := TotalValorDia      + IbqChequesPagamentosVALOR.Value;
  TotalJurosPagosDia := TotalJurosPagosDia + IbqChequesPagamentosJUROSPAGOS.Value;
  TotalValorPagoDia  := TotalValorPagoDia  + IbqChequesPagamentosVALORPAGO.Value;
  TotalValorPessoa      := TotalValorPessoa      + IbqChequesPagamentosVALOR.Value;
  TotalJurosPagosPessoa := TotalJurosPagosPessoa + IbqChequesPagamentosJUROSPAGOS.Value;
  TotalValorPagoPessoa  := TotalValorPagoPessoa  + IbqChequesPagamentosVALORPAGO.Value;
end;

procedure TFmRelChequesPagamentos.QrbGroupFooterNameBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QrlTotalPessoa.Caption := Format('%m', [TotalValorPessoa]);
  QrlTotalJurosPagosPessoa.Caption := Format('%m', [TotalJurosPagosPessoa]);
  QrlTotalValorPagoPessoa.Caption := Format('%m', [TotalValorPagoPessoa]);
end;

procedure TFmRelChequesPagamentos.QrbRodapeGroupBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QrlTotalDia.Caption := Format('%m', [TotalValorDia]);
  QrlTotalJurosPagosDia.Caption := Format('%m', [TotalJurosPagosDia]);
  QrlTotalValorPagoDia.Caption := Format('%m', [TotalValorPagoDia]);
end;

procedure TFmRelChequesPagamentos.QrbSummaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrlTotal.Caption := Format('%m', [TotalValor]);
  QrlTotalJurosPagos.Caption := Format('%m', [TotalJurosPagos]);
  QrlTotalValorPago.Caption := Format('%m', [TotalValorPago]);
end;

procedure TFmRelChequesPagamentos.QrChequesPagamentosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  TotalValor      := 0;
  TotalJurosPagos := 0;
  TotalValorPago  := 0;
end;

procedure TFmRelChequesPagamentos.QrgDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotalValorDia      := 0;
  TotalJurosPagosDia := 0;
  TotalValorPagoDia  := 0;
end;

procedure TFmRelChequesPagamentos.QrGroupNomeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotalValorPessoa      := 0;
  TotalJurosPagosPessoa := 0;
  TotalValorPagoPessoa  := 0;
end;

end.
