unit DlgReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ActnList;

type
  TFmReports = class(TForm)
    RgReports: TRadioGroup;
    DtpInicio: TDateTimePicker;
    DtpFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    BtnPreview: TButton;
    BtnPrint: TButton;
    BtnClose: TButton;
    AlReports: TActionList;
    AcPreview: TAction;
    AcPrint: TAction;
    AcClose: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RgReportsClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure InvokeBancos;
    procedure InvokeClientes;
    procedure DeactivateFilters;
    procedure ActivateFilters;
    procedure AcPreviewExecute(Sender: TObject);
    procedure AlReportsExecute(Action: TBasicAction; var Handled: Boolean);
    procedure AcCloseExecute(Sender: TObject);
    procedure InvokeChequesEmissao;
    procedure InvokeChequesPagamentos;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmReports: TFmReports;

implementation

uses RelBancos, RelClientes, RelChequesEmisssao, RelChequesPagamentos;

{$R *.dfm}

procedure TFmReports.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFmReports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFmReports.FormCreate(Sender: TObject);
begin
  DtpInicio.Date := Date;
  DtpFim.Date    := Date;
end;

procedure TFmReports.InvokeBancos;
begin
  FmRelBancos :=  TFmRelBancos.Create(Self);

  with FmRelBancos do
  begin
    QrBancos.Preview;
    Free;
  end;
end;

procedure TFmReports.InvokeChequesEmissao;
begin
  FmRelChequesEmissao :=  TFmRelChequesEmissao.Create(Self);

  with FmRelChequesEmissao do
  begin
    QrChequesEmissao.Preview;
    Free;
  end;
end;

procedure TFmReports.InvokeChequesPagamentos;
begin
  FmRelChequesPagamentos :=  TFmRelChequesPagamentos.Create(Self);

  with FmRelChequesPagamentos do
  begin
    QrChequesPagamentos.Preview;
    Free;
  end;
end;

procedure TFmReports.InvokeClientes;
begin
  FmRelClientes :=  TFmRelClientes.Create(Self);

  with FmRelClientes do
  begin
    QrClientes.Preview;
    Free;
  end;
end;

procedure TFmReports.AcCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFmReports.AcPreviewExecute(Sender: TObject);
begin
  case RgReports.ItemIndex of
    0: InvokeBancos;
    1: InvokeClientes;
    2: InvokeChequesEmissao;
    3: InvokeChequesPagamentos;
  end;
end;

procedure TFmReports.ActivateFilters;
begin
  DtpInicio.Enabled := True;
  DtpFim.Enabled := True;
end;

procedure TFmReports.AlReportsExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  // Print
end;

procedure TFmReports.DeactivateFilters;
begin
  DtpInicio.Enabled := False;
  DtpFim.Enabled := False;
end;

procedure TFmReports.RgReportsClick(Sender: TObject);
begin
  case RgReports.ItemIndex of
    0, 1: DeactivateFilters;
    else ActivateFilters;
  end;
end;

end.
