unit Unproperedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  TFormproperedit = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Btncancel: TBitBtn;
    DBEcode: TDBEdit;
    DBEdit2: TDBEdit;
    procedure BtnsaveClick(Sender: TObject);
    procedure BtncancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formproperedit: TFormproperedit;
//  insertoredit:integer;

implementation

{$R *.dfm}

uses UnDM, Unproper;

procedure TFormproperedit.BtnsaveClick(Sender: TObject);
begin
  DM.ADO_PROP_query.Post;
  save:=1;
  Formproperedit.close;
end;

procedure TFormproperedit.BtncancelClick(Sender: TObject);
begin
  DM.ADO_PROP_query.Cancel;
  save:=0;
  Formproperedit.close;
end;

end.
