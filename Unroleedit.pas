unit Unroleedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  TFormroleedit = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Btncancel: TBitBtn;
    DBEcode: TDBEdit;
    DBEdit2: TDBEdit;
    DBMemo1: TDBMemo;
    procedure BtnsaveClick(Sender: TObject);
    procedure BtncancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formroleedit: TFormroleedit;
//  insertoredit:integer;

implementation

{$R *.dfm}

uses UnDM, Unrole;

procedure TFormroleedit.BtnsaveClick(Sender: TObject);
begin
  DM.ADO_URGP_query.Post;
  save:=1;
  Formroleedit.close;
end;

procedure TFormroleedit.BtncancelClick(Sender: TObject);
begin
  DM.ADO_URGP_query.Cancel;
  save:=0;
  Formroleedit.close;
end;

end.
