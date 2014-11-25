unit RelChequesEmisssao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, DB, IBCustomDataSet, IBQuery, QRCtrls;

type
  TFmRelChequesEmissao = class(TForm)
    IbqChequeEmissao: TIBQuery;
    IbqChequeEmissaoNOME: TIBStringField;
    IbqChequeEmissaoCNPJ: TIBStringField;
    IbqChequeEmissaoBANCO: TSmallintField;
    IbqChequeEmissaoAGENCIA: TSmallintField;
    IbqChequeEmissaoCONTA: TSmallintField;
    IbqChequeEmissaoNUMERO: TSmallintField;
    IbqChequeEmissaoVALOR: TFloatField;
    IbqChequeEmissaoEMISSAO: TDateField;
    IbqChequeEmissaoALINEA: TSmallintField;
    QrChequesEmissao: TQuickRep;
    QrbHeader: TQRBand;
    QRLabel1: TQRLabel;
    QrlPeriodo: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QrbSummary: TQRBand;
    QrlTotal: TQRLabel;
    QrbDetail: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QrgData: TQRGroup;
    QRDBText1: TQRDBText;
    QrbRodapeGroup: TQRBand;
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
  with IbqChequeEmissao do
  begin
    Active := False;
    With FmReports do
    begin
      ParamByName('st').Value := DtpInicio.Date;
      ParamByName('ed').Value := DtpFim.Date;
    end;
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
  QrlTotalDia.Caption := Format('Total do dia: %m', [TotalDia]);
end;

procedure TFmRelChequesEmissao.QrbSummaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrlTotal.Caption := Format('Total do período: %m', [TotalGeral]);
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
