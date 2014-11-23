unit RelClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, ActnList;

type
  TFmRelClientes = class(TForm)
    QRClientes: TQuickRep;
    QrbHeader: TQRBand;
    QRLabel2: TQRLabel;
    QRSysData1: TQRSysData;
    QrbDetalhes: TQRBand;
    QrdbtCnpj: TQRDBText;
    QrdbtNome: TQRDBText;
    QrdbtTelefone: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QrbSummary: TQRBand;
    QrlTotal: TQRLabel;
    procedure QRClientesBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QrbDetalhesAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QrbSummaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRClientesAfterPrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmRelClientes: TFmRelClientes;

implementation

uses Modulo;

{$R *.dfm}

var ClientCount: Word;

procedure TFmRelClientes.QrbDetalhesAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Inc(ClientCount);
end;

procedure TFmRelClientes.QrbSummaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrlTotal.Caption := Copy(QrlTotal.Caption, 0, Pos(':', QrlTotal.Caption) + 1) + IntToStr(ClientCount);
end;

procedure TFmRelClientes.QRClientesAfterPrint(Sender: TObject);
begin
  DmWinBank.IbtClientes.IndexName := '';
end;

procedure TFmRelClientes.QRClientesBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  ClientCount := 0;

  with DmWinBank.IbtClientes do
    IndexName := IndexDefs.Items[1].Name;
end;

end.
