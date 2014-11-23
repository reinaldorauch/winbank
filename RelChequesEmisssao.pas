unit RelChequesEmisssao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, DB, IBCustomDataSet, IBQuery, QRCtrls;

type
  TFmRelChequesEmissao = class(TForm)
    QrChequesEmissao: TQuickRep;
    IbqChequeEmissao: TIBQuery;
    QrbHeader: TQRBand;
    QrbSummary: TQRBand;
    QrbDetail: TQRBand;
    QRLabel1: TQRLabel;
    QrlPeriodo: TQRLabel;
    QRSysData1: TQRSysData;
    IbqChequeEmissaoNOME: TIBStringField;
    IbqChequeEmissaoCNPJ: TIBStringField;
    IbqChequeEmissaoBANCO: TSmallintField;
    IbqChequeEmissaoAGENCIA: TSmallintField;
    IbqChequeEmissaoCONTA: TSmallintField;
    IbqChequeEmissaoNUMERO: TSmallintField;
    IbqChequeEmissaoVALOR: TFloatField;
    IbqChequeEmissaoEMISSAO: TDateField;
    IbqChequeEmissaoALINEA: TSmallintField;
    QrlTotal: TQRLabel;
    QrgData: TQRGroup;
    QrbRodapeGroup: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QrlTotalDia: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure QrChequesEmissaoBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QrbDetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QrbSummaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrbRodapeGroupBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrgDataBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmRelChequesEmissao: TFmRelChequesEmissao;

implementation

uses Modulo, DlgReports;

{$R *.dfm}

var
  TotalGeral, TotalDia: Currency;


procedure TFmRelChequesEmissao.FormCreate(Sender: TObject);
begin
  with IbqChequeEmissao, FmReports do
  begin
    Active := False;
    ParamByName('st').Value := DtpInicio.Date;
    ParamByName('ed').Value := DtpFim.Date;
    Active := True;
  end;
end;

procedure TFmRelChequesEmissao.QrbDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with IbqChequeEmissaoVALOR do
  begin
    TotalGeral := TotalGeral + Value;
    TotalDia   := TotalDia + Value;
  end;
end;

procedure TFmRelChequesEmissao.QrbRodapeGroupBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrlTotalDia.Caption := Format('%m', [TotalDia]);
end;

procedure TFmRelChequesEmissao.QrbSummaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrlTotal.Caption := Format('%m', [TotalGeral]);
end;

procedure TFmRelChequesEmissao.QrChequesEmissaoBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  TotalGeral := 0;

  with FmReports do
    QrlPeriodo.Caption := 'Período: ' + DateToStr(DtpInicio.Date) +
      ' a ' + DateToStr(DtpFim.Date);
end;

procedure TFmRelChequesEmissao.QrgDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotalDia := 0;
end;

end.
