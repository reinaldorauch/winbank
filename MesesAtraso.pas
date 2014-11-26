unit MesesAtraso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DateUtils, ComCtrls, StdCtrls;

type
  TFmMesesAtraso = class(TForm)
    DtpData: TDateTimePicker;
    BtnCalc: TButton;
  function MesesAtraso(Data: TDate): Integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnCalcClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMesesAtraso: TFmMesesAtraso;

implementation

{$R *.dfm}

{ TForm1 }

procedure TFmMesesAtraso.BtnCalcClick(Sender: TObject);
begin
  ShowMessage('A diferença, em meses, entre ' + DateToStr(DtpData.Date) +
    ' e hoje é de:' + #13 + #13 + IntToStr(MesesAtraso(DtpData.Date)));
end;

procedure TFmMesesAtraso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFmMesesAtraso.FormCreate(Sender: TObject);
begin
  DtpData.Date := Date();
end;

function TFmMesesAtraso.MesesAtraso(Data: TDate): Integer;
begin
  Result := Abs(MonthsBetween(Now(), Data));
end;

end.
