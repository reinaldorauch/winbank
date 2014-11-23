unit RelBancos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls;

type
  TFmRelBancos = class(TForm)
    QrBancos: TQuickRep;
    QrbHeader: TQRBand;
    QRLabel1: TQRLabel;
    QrbDetalhes: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmRelBancos: TFmRelBancos;

implementation

uses Modulo;

{$R *.dfm}

end.
