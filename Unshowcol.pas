unit Unshowcol;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox;

type
  TFormshowcol = class(TForm)
    Panel1: TPanel;
    Btnquery: TButton;
    Btnclose: TButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1COLCAP: TcxGridDBColumn;
    cxGrid1DBTableView1SHOW00: TcxGridDBColumn;
    procedure BtncloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnqueryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formshowcol: TFormshowcol;
  tempcol:array of Integer;
  count:integer;

implementation

{$R *.dfm}

uses UnDM, UnMain, Undatacompute, Unglobal;

procedure TFormshowcol.BtncloseClick(Sender: TObject);
var
  I: Integer;
  a:string;
begin
//  Formshowcol.Closemodal;
//  cxGrid1DBTableView1.DataController.BeginUpdate;
//  DM.ADOQuery1.close;
//  DM.ADOQuery1.Open;
//  DM.ADOQuery1.first;
//  DM.ADOQuery1.edit;
//  for I := 0 to count-1 do

//  while not DM.ADOQuery1.Eof  do
  {
  DM.ADOQuery1.First;
  for I := 0 to count-1 do
    begin
      DM.ADOQuery1.Edit;
      DM.ADOQuery1.Fieldbyname('SHOW00').AsInteger:=tempcol[i];
      DM.ADOQuery1.Post;
      DM.ADOQuery1.Next;
    end;
  }

//reload DB DATA from trmpcol arrar if click cancel
  with DM.ADO_temp_query do
    begin
      First;
      for I := 0 to count-1 do
        begin
          Edit;
          Fieldbyname('SHOW00').AsInteger:=tempcol[i];
          Post;
          Next;
        end;
    end;
//  DM.ADOQuery1.Cancel;
  Formshowcol.Close;
      //      DM.ADO_SC_query.Next;


     // cxGrid1DBTableView1.DataController.Values[i, 1]:=tempcol[i];
//      DM.ADOQuery1.edit;
//      DM.ADOQuery1.Fieldbyname('SHOW00').AsInteger:=1;
//      cxGrid1DBTableView1.DataController.BeginUpdate;
//      cxGrid1DBTableView1.DataController.SetValue(i,1,1);
//      cxGrid1DBTableView1.DataController.EndUpdate;
//      cxGrid1DBTableView1.DataController.post;
      //      DM.ADOQuery1.Post;
//      DM.ADOQuery1.Next;
     // cxGrid1DBTableView1.DataController.SetValue(i,1,1);
      //DM.ADOQuery1.edit;
      //cxGrid1DBTableView1.DataController.Values[i, 1]:=tempcol[i];
//      cxGrid1DBTableView1.DataController.Edit;
       //cxGrid1DBTableView1.DataController.FocusedRecordIndex := i;
      //cxGrid1DBTableView1.DataController.Values[i, 1]:=1;
//      cxGrid1DBTableView1.DataController.Post;

//      a:=a+inttostr(tempcol[i]);
      //DM.ADOQuery1.Post;
      //cxGrid1DBTableView1.DataController.PostEditingData;
//    end;
//  DM.ADOQuery1.Post;
//  cxGrid1DBTableView1.DataController.EndUpdate;
//  cxGrid1DBTableView1.DataController.post();
//  DM.ADOQuery1.edit;
//  DM.ADOQuery1.Post;
//  cxGrid1DBTableView1.DataController.PostEditingData;
//  cxGrid1DBTableView1.DataController.FocusedRecordIndex := 1;
//  cxGrid1DBTableView1.DataController.FocusedRecordIndex := 0;
//  showmessage(a);
//  cxGrid1DBTableView1.DataController.post();
//  DM.ADOQuery1.Refresh;
//  Formshowcol.Close;
  //  Formshowcol.Free;
//  Formshowcol:=nil;
//  freeandnil(Formshowcol);
end;

procedure TFormshowcol.BtnqueryClick(Sender: TObject);
begin
//  cxGrid1DBTableView1.DataController.UpdateData;
//  cxGrid1DBTableView1.ViewData.Records[1].Selected;
//  cxGrid1DBTableView1.ViewData.Records[2].Selected;
//  if DM.ADOQuery1.State <> dsBrowse then
//  DM.ADOQuery1.Post;
  cxGrid1DBTableView1.DataController.FocusedRecordIndex := 1;
  cxGrid1DBTableView1.DataController.FocusedRecordIndex := 0; //change FocusedRecord to post DB data
//  DM.ADOQuery1.Refresh;
  Formdatacompute.showcolumn;//refresh
  Formshowcol.Close;
end;

procedure TFormshowcol.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  freeandnil(Formshowcol);
end;

procedure TFormshowcol.FormShow(Sender: TObject);
var
  I: Integer;
  sqlstr:string;
begin


  //move to undatacompute
  //add by dendi will cause error because common datasource;
  try
    sqlstr:=format('select * from USERSHOWCOL where USERID=''%s''',[Globaluserid]);
    SQLquery(sqlstr,DM.ADO_temp_query);
  //  with DM.ADO_temp_query do
  //    begin
  //      close;
  //      sql.Clear;
  //      sql.Add('select * from USERSHOWCOL');
  //      open;
  //     end;
  except
     Application.MessageBox('无法连接数据库','提示', MB_OK);
  end;

  count:=cxGrid1DBTableView1.DataController.RowCount;
  setlength(tempcol,count);

//tempcol[i] to record initial value of showcol
  for I := 0 to count-1 do
    tempcol[i]:=cxGrid1DBTableView1.DataController.Values[i, 1];
//    DM.ADOQuery1.first;

//  cxGrid1DBTableView1.DataController.FocusedRecordIndex := 0;
//    showmessage(cxGrid1DBTableView1.DataController.Values[i,1]);
end;

end.
