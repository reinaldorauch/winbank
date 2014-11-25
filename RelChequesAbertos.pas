unit RelChequesAbertos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, IBCustomDataSet, IBQuery;

type
  TFmRelChequesAbertos = class(TForm)
    QrChequesAbertos: TQuickRep;
    QrbHeader: TQRBand;
    QRLabel1: TQRLabel;
    QrlPeriodo: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel4: TQRLabel;
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
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QrgData: TQRGroup;
    QrbRodapeGroup: TQRBand;
    QrlTotalPessoa: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel5: TQRLabel;
    IbqChequesAbertos: TIBQuery;
    IbqChequesAbertosNOME: TIBStringField;
    IbqChequesAbertosCNPJ: TIBStringField;
    IbqChequesAbertosCNPJ1: TIBStringField;
    IbqChequesAbertosBANCO: TSmallintField;
    IbqChequesAbertosAGENCIA: TSmallintField;
    IbqChequesAbertosCONTA: TSmallintField;
    IbqChequesAbertosNUMERO: TSmallintField;
    IbqChequesAbertosVALOR: TFloatField;
    IbqChequesAbertosEMISSAO: TDateField;
    IbqChequesAbertosALINEA: TSmallintField;
    IbqChequesAbertosDATAPGTO: TDateField;
    IbqChequesAbertosJUROSPAGOS: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure QrChequesAbertosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QrbDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrgDataBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
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
  FmRelChequesAbertos: TFmRelChequesAbertos;

implementation

uses Modulo, DlgReports;

{$R *.dfm}

var
    TotalGeral, TotalPessoa: Currency;

procedure TFmRelChequesAbertos.FormCreate(Sender: TObject);
begin
  with IbqChequesAbertos do
  begin
    Active := False;
    with FmReports do
    begin
      ParamByName('st').Value := DtpInicio.Date;
      ParamByName('ed').Value := DtpFim.Date;
    end;
    Active := True;
  end;
end;

procedure TFmRelChequesAbertos.QrbDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotalGeral := TotalGeral + IbqChequesAbertosVALOR.Value;
  TotalPessoa := TotalPessoa + IbqChequesAbertosVALOR.Value;
end;

procedure TFmRelChequesAbertos.QrbRodapeGroupBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrlTotalPessoa.Caption := Format('%m', [TotalPessoa]);
end;

procedure TFmRelChequesAbertos.QrbSummaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrlTotal.Caption := Format('%m', [TotalGeral]);
end;

procedure TFmRelChequesAbertos.QrChequesAbertosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  TotalGeral := 0;

  with FmReports do
    QrlPeriodo.Caption := 'Período: ' + DateToStr(DtpInicio.Date) +
      ' a ' + DateToStr(DtpFim.Date);
end;

procedure TFmRelChequesAbertos.QrgDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotalPessoa := 0;
end;

end.
