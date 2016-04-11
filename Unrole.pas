unit Unrole;

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
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxLabel;

type
  TFormrole = class(TForm)
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
    cxGrid1DBTableView1REMARK: TcxGridDBColumn;
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
  Formrole: TFormrole;
  save:integer;

implementation

{$R *.dfm}

uses UnDM, UnMain, Unroleedit, Unglobal;

procedure TFormrole.BtnaddClick(Sender: TObject);
begin
  DM.ADO_URGP_query.Append;
  //DM.ADO_URGP_query.Insert;
  if not assigned(Formroleedit) then
    begin
     Application.CreateForm(TFormroleedit, Formroleedit);
     Formroleedit.ShowModal;
    end
  else
    Formroleedit.ShowModal;
//    DM.ADO_URGP_query.Edit;
    //freeandnil(Formshowcol);
    if save=1 then
      RecordLog('添加角色:'+DM.ADO_URGP_query.FieldByName('NAME00').AsString);
    Formroleedit.Free;
    Formroleedit:=nil;
end;

procedure TFormrole.BtncloseClick(Sender: TObject);
begin
  Formrole.close;
end;

procedure TFormrole.BtndelClick(Sender: TObject);
var
  sqlstr:string;
begin
  if DM.ADO_URGP_query.RecordCount>0 then
    begin
      if Application.MessageBox('确定删除选定角色？ ','确认',MB_YESNO) = 6 then
        begin

      //---------delete action with role-------------------
      //---------should delete all of action
          try
            sqlstr:=format('delete from GROUPACT where CODE00=''%s''',[DM.ADO_URGP_query.FieldByName('CODE00').AsString]);
            SQLexec(sqlstr,DM.ADO_temp_query);

      //      with DM.ADOQuery1 do
      //        begin
      //          close;
      //          sql.Clear;
      //          sql.Add('delete from GROUPACT where CODE00=:code ');
      //          Parameters.ParamByName('code').Value:=DM.ADO_URGP_query.FieldByName('CODE00').AsString;
      //          ExecSQL;
      //        end;
          except
            Application.MessageBox('无法连接数据库3','提示', MB_OK);
          end;


        RecordLog('删除角色:'+DM.ADO_URGP_query.FieldByName('NAME00').AsString);
        DM.ADO_URGP_query.Delete;

        end;
    end;

end;

procedure TFormrole.BtneditClick(Sender: TObject);
begin
//  FormMain.RecordLog('更改自定义列');
if DM.ADO_URGP_query.RecordCount>0 then
BEGIN
  DM.ADO_URGP_query.Edit;
  if not assigned(Formroleedit) then
    begin
     Application.CreateForm(TFormroleedit, Formroleedit);
     Formroleedit.ShowModal;
    end
  else
    Formroleedit.ShowModal;
//    DM.ADO_URGP_query.Edit;
    //freeandnil(Formshowcol);
    if save=1 then
      RecordLog('编辑角色:'+DM.ADO_URGP_query.FieldByName('NAME00').AsString);
    Formroleedit.Free;
    Formroleedit:=nil;
END;
end;

procedure TFormrole.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Formrole.Free;
   Formrole:=nil;
end;

procedure TFormrole.FormCreate(Sender: TObject);
begin
//  DateTimePicker1.Date:=now();
//  DateTimePicker2.Date:=now();
end;

procedure TFormrole.FormShow(Sender: TObject);
var
  sqlstr:string;
begin
  try
    sqlstr:='select * from USERGROUPS';
    SQLquery(sqlstr,DM.ADO_URGP_query);
//    with DM.ADO_URGP_query do
//      begin
//        close;
//        sql.Clear;
////        sql.Add('select * from VALARMS');
//        sql.Add('select * from USERGROUPS');
//        open;
//       end;
  except
     Application.MessageBox('无法连接数据库','提示', MB_OK);
  end;
end;

end.
