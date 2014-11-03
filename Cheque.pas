unit Cheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, Grids, DBGrids, ImgList, ActnList, Menus, ToolWin, ComCtrls;

type
  TFmCheques = class(TForm)
    DbgCheques: TDBGrid;
    MainMenu: TMainMenu;
    PopupMenu: TPopupMenu;
    ActionList: TActionList;
    ImageList: TImageList;
    ToolBar1: TToolBar;
    AcCreate: TAction;
    AcEdit: TAction;
    AcDelete: TAction;
    Adicionar1: TMenuItem;
    Remover1: TMenuItem;
    Editar1: TMenuItem;
    Opes1: TMenuItem;
    Adicionar2: TMenuItem;
    Editar2: TMenuItem;
    Remover2: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    AcQuitar: TAction;
    AcEstornar: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    N1: TMenuItem;
    Quitar1: TMenuItem;
    AcEstornar1: TMenuItem;
    N2: TMenuItem;
    AcEstornar2: TMenuItem;
    AcEstornar3: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AcCreateExecute(Sender: TObject);
    procedure AcEditExecute(Sender: TObject);
    procedure AcDeleteExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmCheques: TFmCheques;

implementation

uses Modulo, CreateCheque;

var
  FmCreateCheque: TFmCreateCheque;

{$R *.dfm}

procedure TFmCheques.AcCreateExecute(Sender: TObject);
begin
  FmCreateCheque := TFmCreateCheque.Create(Self);

  with FmCreateCheque, DmWinBank do
  begin
    IbtCheques.Insert;
    IbtChequesCNPJ.Value := IbtClientesCNPJ.Value;
    Caption := 'Adição de cheque para: ' + IbtClientesNOME.Value +
      ' - CPF/CNPJ: ' + IbtClientesCNPJ.Value;
    ShowModal;
  end;
end;

procedure TFmCheques.AcDeleteExecute(Sender: TObject);
begin
  with DmWinBank do
  begin
    if IbtChequesDATAPGTO.Value <> 0 then
      ShowMessage('Não é possível apagar cheques pagos, exstorne-o e tente novamente')
    else
      if(mrYes = MessageDlg('Tem certeza que deseja excluir o cheque?', mtConfirmation, [mbYes,mbNo], 0)) then
      try
        IbtCheques.Delete;
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

procedure TFmCheques.AcEditExecute(Sender: TObject);
begin
  FmCreateCheque := TFmCreateCheque.Create(Self);

  with FmCreateCheque, DmWinBank do
  begin
    IbtCheques.Edit;
    Caption := 'Editar cheque';
    ShowModal;
  end;
end;

procedure TFmCheques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
