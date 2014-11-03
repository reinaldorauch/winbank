unit princ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ActnList, ImgList, Grids, DBGrids, StdCtrls,
  DBCtrls;

type
  TFmPrinc = class(TForm)
    MainMenu: TMainMenu;
    PageControl: TPageControl;
    TsClientes: TTabSheet;
    Opes1: TMenuItem;
    TbClientes: TToolBar;
    IlPrinc: TImageList;
    DbgClientes: TDBGrid;
    AcExit: TAction;
    AcCreateClient: TAction;
    AcEditClient: TAction;
    AcDeleteClient: TAction;
    AlClientes: TActionList;
    Sair1: TMenuItem;
    N1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Cliente1: TMenuItem;
    Adicionar3: TMenuItem;
    Editar1: TMenuItem;
    AcDelete1: TMenuItem;
    Banco1: TMenuItem;
    TSBanco: TTabSheet;
    TbBancos: TToolBar;
    AlBancos: TActionList;
    DbgBancos: TDBGrid;
    PmBancos: TPopupMenu;
    AcCreateBank: TAction;
    AcEditBank: TAction;
    AcDeleteBank: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    AcCreateBank1: TMenuItem;
    Editar3: TMenuItem;
    Deletar1: TMenuItem;
    PmClientes: TPopupMenu;
    Adicionar2: TMenuItem;
    Editar2: TMenuItem;
    AcDelete2: TMenuItem;
    Adicionar1: TMenuItem;
    Editar4: TMenuItem;
    Remover1: TMenuItem;
    AcOpenCheques: TAction;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    N2: TMenuItem;
    Cheques1: TMenuItem;
    N3: TMenuItem;
    Cheques2: TMenuItem;
    TsConsCheques: TTabSheet;
    DbgConsCheques: TDBGrid;
    EdAgencia: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BtnBusca: TButton;
    DtpInicio: TDateTimePicker;
    DtpFim: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    DblbBancos: TDBListBox;
    procedure AcExitExecute(Sender: TObject);
    procedure AcCreateClientExecute(Sender: TObject);
    procedure AcEditClientExecute(Sender: TObject);
    procedure AcDeleteClientExecute(Sender: TObject);
    procedure AcCreateBankExecute(Sender: TObject);
    procedure AcEditBankExecute(Sender: TObject);
    procedure AcDeleteBankExecute(Sender: TObject);
    procedure AcOpenChequesExecute(Sender: TObject);
    procedure AcBuscarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmPrinc: TFmPrinc;

implementation

uses Modulo, Cliente, Banco, Cheque;

{$R *.dfm}

var
  FmClientes: TFmClientes;
  FmCheques:  TFmCheques;
  FmBancos:   TFmBancos;

procedure TFmPrinc.AcBuscarExecute(Sender: TObject);
begin
  with DmWinBank, IbqConsulta do
  begin
    Active := False;
    Sql.Clear;
    Sql.Add('SELECT ');
    Sql.Add('cli.nome nomeCliente, ');
    Sql.Add('cli.cnpj, ');
    Sql.Add('ban.nome nomeBanco, ');
    Sql.Add('che.*, ');
    Sql.Add('(che.valor + che.jurosPagos) valorPago ');
    Sql.Add('FROM ');
    Sql.Add('CLIENTES cli, ');
    Sql.Add('CHEQUES che, ');
    Sql.Add('BANCOS ban ');
    Sql.Add('WHERE che.cnpj = cli.cnpj AND che.banco = ban.codigo ');

    Sql.Add('AND che.emissao BETWEEN :DtInicio AND :DtFim');

    //if EdBanco.Text <> '' then
      //Sql.Add('AND che.banco = ' + EdBanco.Text + ' ');

    Sql.Add('ORDER BY emissao');

    ParamByName('DtInicio').AsDate := DtpInicio.Date;
    ParamByName('DtFim').AsDate := DtpFim.Date;

    Active := True;

  end;
end;

procedure TFmPrinc.AcCreateBankExecute(Sender: TObject);
begin
  FmBancos := TFmBancos.Create(Self);

  with FmBancos, DmWinBank do
  begin
    IbtBancos.Insert;
    Caption := 'Criação de banco';
    ShowModal;
  end;
end;

procedure TFmPrinc.AcCreateClientExecute(Sender: TObject);
begin
  // Abre o form de edit para criar um registro no banco de dados
  FmClientes := TFmClientes.Create(Self);

  with FmClientes, DmWinBank do
  begin
    IbtClientes.Insert;
    Caption := 'Criação de cliente';
    ShowModal;
  end;
end;

procedure TFmPrinc.AcDeleteBankExecute(Sender: TObject);
begin
  with DmWinBank do
  begin
    if(mrYes = MessageDlg('Tem certeza que deseja excluir o banco?', mtConfirmation, [mbYes,mbNo], 0)) then
    try
      IbtBancos.Delete;
    except
      on e: Exception do
      begin
        if (pos('FOREIGN', e.Message) <> 0) then
          ShowMessage('Já há cheques relacionados à este Banco')
        else
          ShowMessage('Erro no banco de dados:' + #13 + e.Message);
      end;
    end;
  end;
end;

procedure TFmPrinc.AcDeleteClientExecute(Sender: TObject);
begin
  with DmWinBank do
  begin
    if(mrYes = MessageDlg('Tem certeza que deseja excluir o cliente?', mtConfirmation, [mbYes,mbNo], 0)) then
    try
      IbtClientes.Delete;
    except
      on e: Exception do
      begin
        if (pos('FOREIGN', e.Message) <> 0) then
          ShowMessage('Já há cheques relacionados à este cliente')
        else
          ShowMessage('Erro no banco de dados:' + #13 + e.Message);
      end;
    end;
  end;
end;

procedure TFmPrinc.AcEditBankExecute(Sender: TObject);
begin
  FmBancos := TFmBancos.Create(Self);

  with FmBancos, DmWinBank do
  begin
    IbtBancos.Edit;
    Caption := 'Edição de cliente';
    ShowModal;
  end;
end;

procedure TFmPrinc.AcEditClientExecute(Sender: TObject);
begin
  // Abre o form para edição do registro selecionado
  FmClientes := TFmClientes.Create(Self);

  with FmClientes, DmWinBank do
  begin
    IbtClientes.Edit;
    Caption := 'Edição de cliente';
    ShowModal;
  end;
end;

procedure TFmPrinc.AcExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFmPrinc.AcOpenChequesExecute(Sender: TObject);
begin

  FmCheques := TFmCheques.Create(self);

  with FmCheques, DmWinBank do
  begin
    Caption := 'Cheques de ' + IbtClientesNOME.Value +
      ' - CPF/CNPJ: ' + IbtClientesCNPJ.Value;
    ShowModal;
  end;

end;

end.
