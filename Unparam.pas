unit Unparam;

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
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxLabel, cxCheckBox, Vcl.Mask,
  Vcl.DBCtrls;

type
  TFormparam = class(TForm)
    Panel1: TPanel;
    Btnedit: TButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    GroupBox1: TGroupBox;
    Btnsave: TButton;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    GroupBox2: TGroupBox;
    Btnaddin: TButton;
    Btninedit: TButton;
    Btnindel: TButton;
    Panel2: TPanel;
    cxGrid1DBTableView1CODE00: TcxGridDBColumn;
    cxGrid1DBTableView1IPADDR: TcxGridDBColumn;
    cxGrid1DBTableView1READPLC: TcxGridDBColumn;
    cxGrid1DBTableView1WRITEPLC: TcxGridDBColumn;
    cxGrid1DBTableView1ATTR00: TcxGridDBColumn;
    Btnclose: TButton;
    GroupBox3: TGroupBox;
    Panel3: TPanel;
    Btnaddout: TButton;
    Btnoutedit: TButton;
    Btnoutdel: TButton;
    cxGrid2DBTableView1CODE00: TcxGridDBColumn;
    cxGrid2DBTableView1NAME00: TcxGridDBColumn;
    cxGrid2DBTableView1TARCODE: TcxGridDBColumn;
    cxGrid2DBTableView1TARNAME: TcxGridDBColumn;
    cxGrid2DBTableView1MAX000: TcxGridDBColumn;
    cxGrid2DBTableView1TYPE00: TcxGridDBColumn;
    cxGrid2DBTableView1OPCITEMIDMAX: TcxGridDBColumn;
    cxGrid2DBTableView1OPCITEMIDCOU: TcxGridDBColumn;
    cxGrid2DBTableView1OPCITEMIDCHG: TcxGridDBColumn;
    cxGrid2DBTableView1OPCITEMBEGIN: TcxGridDBColumn;
    cxGrid2DBTableView1OPCITEMGUID: TcxGridDBColumn;
    cxGrid2DBTableView1OPCITEMEND: TcxGridDBColumn;
    cxGrid2DBTableView1PRINTIP: TcxGridDBColumn;
    cxGrid2DBTableView1STAT00: TcxGridDBColumn;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtncloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtndelClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BtneditClick(Sender: TObject);
    procedure BtnsaveClick(Sender: TObject);
    procedure BtnindelClick(Sender: TObject);
    procedure BtnoutdelClick(Sender: TObject);
    procedure BtnaddinClick(Sender: TObject);
    procedure BtnineditClick(Sender: TObject);
    procedure BtnaddoutClick(Sender: TObject);
    procedure BtnouteditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formparam: TFormparam;
  save:integer;

implementation

{$R *.dfm}

uses UnDM, UnMain, Unparaminedit,Unparamoutedit, Unglobal;

procedure TFormparam.BtneditClick(Sender: TObject);
begin
  DM.ADO_PARA_query.Edit;
  DBEdit1.Enabled:=true;
  DBEdit2.Enabled:=true;
  DBEdit3.Enabled:=true;
  DBEdit4.Enabled:=true;
  DBEdit5.Enabled:=true;
  DBEdit6.Enabled:=true;
  DBEdit7.Enabled:=true;
  DBEdit8.Enabled:=true;
end;

procedure TFormparam.BtnaddinClick(Sender: TObject);
begin
 DM.ADO_PAIN_query.Append;
  if not assigned(Formparaminedit) then
    begin
     Application.CreateForm(TFormparaminedit, Formparaminedit);
     Formparaminedit.ShowModal;
    end
  else
    Formparaminedit.ShowModal;
//    DM.ADO_URGP_query.Edit;
    //freeandnil(Formshowcol);
    if save=1 then
      RecordLog('添加入口:'+DM.ADO_PAIN_query.FieldByName('CODE00').AsString);
    Formparaminedit.Free;
    Formparaminedit:=nil;
end;

procedure TFormparam.BtnaddoutClick(Sender: TObject);
begin
DM.ADO_POUT_query.Append;
  if not assigned(Formparamoutedit) then
    begin
     Application.CreateForm(TFormparamoutedit, Formparamoutedit);
     Formparamoutedit.ShowModal;
    end
  else
    Formparamoutedit.ShowModal;
//    DM.ADO_URGP_query.Edit;
    //freeandnil(Formshowcol);
    if save=1 then
      RecordLog('添加出口:'+DM.ADO_POUT_query.FieldByName('CODE00').AsString);
    Formparamoutedit.Free;
    Formparamoutedit:=nil;
end;

procedure TFormparam.BtncloseClick(Sender: TObject);
begin
//  Btnsave.Click;
 // Formproper.close;
end;

procedure TFormparam.BtndelClick(Sender: TObject);
begin
//


end;

procedure TFormparam.BtnsaveClick(Sender: TObject);
begin
  if DBEdit1.Enabled=true then
    begin
      DM.ADO_PARA_query.Post;
      DBEdit1.Enabled:=false;
      DBEdit2.Enabled:=false;
      DBEdit3.Enabled:=false;
      DBEdit4.Enabled:=false;
      DBEdit5.Enabled:=false;
      DBEdit6.Enabled:=false;
      DBEdit7.Enabled:=false;
      DBEdit8.Enabled:=false;
  end;
end;

procedure TFormparam.BtnindelClick(Sender: TObject);
begin
  if DM.ADO_PAIN_query.RecordCount>0 then
    begin
      if Application.MessageBox('确定删除选定入口？ ','确认',MB_YESNO) = 6 then
        begin
        RecordLog('删除入口:'+DM.ADO_PAIN_query.FieldByName('CODE00').AsString);
        DM.ADO_PAIN_query.Delete;
      end;
    end;
end;

procedure TFormparam.BtnineditClick(Sender: TObject);
begin
if DM.ADO_PAIN_query.RecordCount>0 then
BEGIN
  DM.ADO_PAIN_query.Edit;
  if not assigned(Formparaminedit) then
    begin
     Application.CreateForm(TFormparaminedit, Formparaminedit);
     Formparaminedit.ShowModal;
    end
  else
    Formparaminedit.ShowModal;
//    DM.ADO_URGP_query.Edit;
    //freeandnil(Formshowcol);
    if save=1 then
      RecordLog('编辑入口:'+DM.ADO_PAIN_query.FieldByName('CODE00').AsString);
    Formparaminedit.Free;
    Formparaminedit:=nil;
END;
end;

procedure TFormparam.BtnoutdelClick(Sender: TObject);
begin
 if DM.ADO_POUT_query.RecordCount>0 then
    begin
      if Application.MessageBox('确定删除选定出口？ ','确认',MB_YESNO) = 6 then
        begin
        RecordLog('删除出口:'+DM.ADO_POUT_query.FieldByName('CODE00').AsString);
        DM.ADO_POUT_query.Delete;
      end;
    end;
end;

procedure TFormparam.BtnouteditClick(Sender: TObject);
begin
if DM.ADO_POUT_query.RecordCount>0 then
BEGIN
  DM.ADO_POUT_query.Edit;
  if not assigned(Formparamoutedit) then
    begin
     Application.CreateForm(TFormparamoutedit, Formparamoutedit);
     Formparamoutedit.ShowModal;
    end
  else
    Formparamoutedit.ShowModal;
//    DM.ADO_URGP_query.Edit;
    //freeandnil(Formshowcol);
    if save=1 then
      RecordLog('编辑出口:'+DM.ADO_POUT_query.FieldByName('CODE00').AsString);
    Formparamoutedit.Free;
    Formparamoutedit:=nil;
END;
end;

procedure TFormparam.Button5Click(Sender: TObject);
begin
  Btnsave.Click;
  Formparam.close;
end;

procedure TFormparam.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Formparam.Free;
   Formparam:=nil;
end;

procedure TFormparam.FormCreate(Sender: TObject);
begin
//  DateTimePicker1.Date:=now();
//  DateTimePicker2.Date:=now();
end;

procedure TFormparam.FormShow(Sender: TObject);
begin
//  Panel2.Parent:=GroupBox2;
//  Panel2.Align:=alTop;
  cxgrid1.Parent:=GroupBox2;
  cxgrid1.Align:=alclient;
//  Panel3.Parent:=GroupBox3;
//  Panel3.Align:=alTop;
  cxgrid2.Parent:=GroupBox3;
  cxgrid2.Align:=alclient;
  if not DM.ADO_PARA_query.Active then
  begin
    try
      SQLquery(DM.ADO_PARA_query);
//      with DM.ADO_PARA_query do
//        begin
//          close;
//          sql.Clear;
  //        sql.Add('select * from VALARMS');
//          sql.Add('select * from USERGROUPS');
          //open;
//         end;
    except
       Application.MessageBox('无法连接数据库1','提示', MB_OK);
    end;
  end;

  try
    SQLquery(DM.ADO_POUT_query);
//      with DM.ADO_POUT_query do
//        begin
//          close;
  //        sql.Clear;
 //         sql.Add('select * from GROUPACT');
  //        sql.Add('select * from GROUPACT where CODE00=:code');
  //        Parameters.ParamByName('code').Value:=DM.ADO_URGP_query.FieldByName('CODE00').AsString;
//          open;
//         end;
    except
       Application.MessageBox('无法连接数据库2','提示', MB_OK);
    end;

    try
      SQLquery(DM.ADO_PAIN_query);
//      with DM.ADO_PAIN_query do
//        begin
//          close;
  //        sql.Clear;
 //         sql.Add('select * from GROUPACT');
  //        sql.Add('select * from GROUPACT where CODE00=:code');
  //        Parameters.ParamByName('code').Value:=DM.ADO_URGP_query.FieldByName('CODE00').AsString;
//          open;
//         end;
    except
       Application.MessageBox('无法连接数据库3','提示', MB_OK);
    end;

//    cxGrid2DBTableView1.DataController.Filter.Root.Clear;
//    cxGrid2DBTableView1.DataController.Filter.Root.AddItem(cxGrid2DBTableView1.GetColumnByFieldName('CODE00'),folike,DM.ADO_URGP_query.FieldByName('CODE00').AsString,DM.ADO_URGP_query.FieldByName('CODE00').AsString);
//    cxGrid2DBTableView1.DataController.Filter.Active:=true;

//      DM.ADO_ACTI_query.Filter:='CODE00='+''''+DM.ADO_URGP_query.FieldByName('CODE00').AsString+'''';
//      DM.ADO_ACTI_query.Filtered:=true;

end;


end.
