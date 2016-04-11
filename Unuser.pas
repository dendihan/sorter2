unit Unuser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.Grids, Vcl.DBGrids,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxLabel, cxDBLookupComboBox;

type
  TFormuser = class(TForm)
    Panel1: TPanel;
    Btnadd: TButton;
    Btnclose: TButton;
    Panel2: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Btnedit: TButton;
    Btndel: TButton;
    cxGrid1DBTableView1CODE00: TcxGridDBColumn;
    cxGrid1DBTableView1NAME00: TcxGridDBColumn;
    cxGrid1DBTableView1NAME00_1: TcxGridDBColumn;
    cxGrid1DBTableView1DATE00: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtncloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtndelClick(Sender: TObject);
    procedure BtneditClick(Sender: TObject);
    procedure BtnaddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formuser: TFormuser;
  save:integer;

implementation

{$R *.dfm}

uses UnDM, UnMain, Unuseredit, Unglobal;

procedure TFormuser.BtnaddClick(Sender: TObject);
begin
  DM.ADO_USER_query.Append;
  if not assigned(Formuseredit) then
    begin
     Application.CreateForm(TFormuseredit, Formuseredit);
     Formuseredit.ShowModal;
    end
  else
    Formuseredit.ShowModal;
//    DM.ADO_URGP_query.Edit;
    //freeandnil(Formshowcol);
   //var save to indicate whether new user save or not
    if save=1 then
      RecordLog('添加用户:'+DM.ADO_USER_query.FieldByName('NAME00').AsString);
    Formuseredit.Free;
    Formuseredit:=nil;
end;

procedure TFormuser.BtncloseClick(Sender: TObject);
begin
  Formuser.close;
end;

procedure TFormuser.BtndelClick(Sender: TObject);
begin
  if DM.ADO_USER_query.RecordCount>0 then
    begin
      if Application.MessageBox('确定删除选定用户？ ','确认',MB_YESNO) = 6 then
        begin
        RecordLog('删除用户:'+DM.ADO_USER_query.FieldByName('NAME00').AsString);
        DM.ADO_USER_query.Delete;
      end;
    end;

end;

procedure TFormuser.BtneditClick(Sender: TObject);
begin
//  FormMain.RecordLog('更改自定义列');
if DM.ADO_USER_query.RecordCount>0 then
BEGIN
  DM.ADO_USER_query.Edit;
  if not assigned(Formuseredit) then
    begin
     Application.CreateForm(TFormuseredit, Formuseredit);
     Formuseredit.ShowModal;
    end
  else
    Formuseredit.ShowModal;
//    DM.ADO_URGP_query.Edit;
    //freeandnil(Formshowcol);
    if save=1 then
      RecordLog('编辑用户:'+DM.ADO_USER_query.FieldByName('NAME00').AsString);
    Formuseredit.Free;
    Formuseredit:=nil;
END;
end;

procedure TFormuser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Formuser.Free;
   Formuser:=nil;
end;

procedure TFormuser.FormCreate(Sender: TObject);
begin
//  DateTimePicker1.Date:=now();
//  DateTimePicker2.Date:=now();
end;

procedure TFormuser.FormShow(Sender: TObject);
var
  sqlstr:string;
begin
  try
    sqlstr:='select * from USERS';
    SQLquery(sqlstr,DM.ADO_USER_query);
//    with DM.ADO_USER_query do
//      begin
//        close;
//        sql.Clear;
//         sql.Add('select * from USERS');
////        sql.Add('select * from VALARMS');
////        sql.Add('select A.CODE00,A.NAME00,A.PASSWD,A.GROUP0,B.NAME00,DATE00 from USERS A LEFT JOIN USERGROUPS B on A.GROUP0=B.CODE00');
//        open;
//       end;
  except
     Application.MessageBox('无法连接数据库','提示', MB_OK);
  end;

  if NOT DM.ADO_URGP_query.Active then
  begin
    try
    sqlstr:='select * from USERGROUPS';
    SQLquery(sqlstr,DM.ADO_URGP_query);
//      with DM.ADO_URGP_query do
//        begin
//          close;
//          sql.Clear;
////        sql.Add('select * from VALARMS');
//          sql.Add('select * from USERGROUPS');
//          open;
//        end;
    except
      Application.MessageBox('无法连接数据库','提示', MB_OK);
    end;
  end;
end;

end.
