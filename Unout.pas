unit Unout;

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
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxLabel, cxCheckBox;

type
  TFormout = class(TForm)
    Panel1: TPanel;
    Btnrefresh: TButton;
    Btnclose: TButton;
    Panel2: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Btnprint: TButton;
    Label1: TLabel;
    Label2: TLabel;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid1DBTableView1POUT2: TcxGridDBColumn;
    cxGrid1DBTableView1labbarcode: TcxGridDBColumn;
    cxGrid2DBTableView1BARCODE: TcxGridDBColumn;
    cxGrid2DBTableView1TOADDR: TcxGridDBColumn;
    cxGrid2DBTableView1PLENGTH: TcxGridDBColumn;
    cxGrid2DBTableView1PWIDTH: TcxGridDBColumn;
    cxGrid2DBTableView1PHEIGHT: TcxGridDBColumn;
    cxGrid2DBTableView1VOLUME: TcxGridDBColumn;
    cxGrid2DBTableView1PCOST: TcxGridDBColumn;
    cxGrid2DBTableView1GUID: TcxGridDBColumn;
    cxGrid2DBTableView1POUT: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtncloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGrid1DBTableView1FocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGrid1DBTableView1FocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure BtnprintClick(Sender: TObject);
    procedure BtnrefreshClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formout: TFormout;
  save:integer;

implementation

{$R *.dfm}

uses UnDM, UnMain, Unglobal;

procedure TFormout.BtnrefreshClick(Sender: TObject);
begin
//  DM.ADO_OUTA_query.Refresh;
    DM.ADO_OUTA_query.Close;
    DM.ADO_OUTA_query.Open;

    DM.ADO_OUTB_query.Close;
    DM.ADO_OUTB_query.Open;
//  DM.ADO_OUTB_query.Refresh;
end;

procedure TFormout.BtncloseClick(Sender: TObject);
begin
//  Btnsave.Click;
  Formout.close;
end;



procedure TFormout.BtnprintClick(Sender: TObject);
var
  sqlstr, ZPLCode,printer: string;
  o_barcode,o_pcs,o_dest:string;
begin
//  cxGrid2DBTableView1.DataController.FocusedRecordIndex := 1;
//  cxGrid2DBTableView1.DataController.FocusedRecordIndex := 0;
  o_barcode := DM.ADO_OUTA_query.FieldByName('LabBarCode').AsString;

  if (length(o_barcode) >= 12) then
  begin
    o_pcs := Inttostr(strtoint(copy(o_barcode, 10, 3)));
  end
  else
  begin
    o_pcs := '';
  end;

  sqlstr := 'select TARNAME,PRINTIP from PARAMOUT where CODE00=''' + DM.ADO_OUTA_query.FieldByName('POUT2').AsString + '''';
//  if DM.ADOQuery.Active = True then
//    DM.ADOQuery.close;
//  DM.ADOQuery.SQL.Clear;
//  DM.ADOQuery.SQL.Add(sqlstring);
//  DM.ADOQuery.Active := True;
  with DM.ADO_temp_query do
    begin
   //   if active = true then
   //     close;
   //   SQL.Clear;
   //   SQL.Add(sqlstr);
   //   open;
      SQLquery(sqlstr,DM.ADO_temp_query);
      if RecordCount > 0 then
        begin
          o_dest := FieldByName('TARNAME').AsString;
          printer := FieldByName('PRINTIP').AsString;
        end
      else
        begin
          o_dest := '';
          printer := '';
        end;
    end;


  try
    // frxOuterLabel.PrintOptions.ShowDialog := true;
    // frxOuterLabel.PrepareReport();
    // frxOuterLabel.print;
    //printer must be shared firstly \\IP\printer name
    //printer:='\\'+printer+'\'+'ZDesigner ZM400 300 dpi (ZPL)';
    printer:='\\'+printer+'\'+GlobalPrint_name;

    ZPLCode := MakeZPLCode(o_barcode, o_dest, o_pcs, GlobalPrint_origin);
//    StringToPrinter(ZPLCode);
    WriteRawStringToPrinter(printer,ZPLcode);
    RecordLog('补打出口包装袋标签：' + o_barcode);
  except
    on e: Exception do
      Application.MessageBox(pwidechar('打印错误：' + e.Message), '提示', MB_OK);
  end;


end;

procedure TFormout.cxGrid1DBTableView1FocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
//  DM.ADO_ACTI_query.Close;
//  DM.ADO_ACTI_query.Parameters.ParamByName('code').Value:=DM.ADO_URGP_query.FieldByName('CODE00').AsString;
  //DM.ADO_ACTI_query.Close;
//  DM.ADO_ACTI_query.Open;
end;

procedure TFormout.cxGrid1DBTableView1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  //showmessage('1');
//  if DM.ADO_URGP_query.Active then
//    begin
//      DM.ADO_ACTI_query.Close;
//      DM.ADO_ACTI_query.Parameters.ParamByName('code').Value:=DM.ADO_URGP_query.FieldByName('CODE00').AsString;
//      //DM.ADO_ACTI_query.Close;
//      DM.ADO_ACTI_query.Open;
//    end;
end;

procedure TFormout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Formout.Free;
   Formout:=nil;
end;

procedure TFormout.FormCreate(Sender: TObject);
begin
//  DateTimePicker1.Date:=now();
//  DateTimePicker2.Date:=now();
end;

procedure TFormout.FormShow(Sender: TObject);
begin
  if not DM.ADO_OUTA_query.Active then
  begin
    try
      SQLquery(DM.ADO_OUTA_query);
//      with DM.ADO_OUTA_query do
//        begin
//          close;
//          sql.Clear;
  //        sql.Add('select * from VALARMS');
//          sql.Add('select * from USERGROUPS');
//          open;
//         end;
    except
       Application.MessageBox('无法连接数据库1','提示', MB_OK);
    end;
  end;

  try
    SQLquery(DM.ADO_OUTB_query);
//      with DM.ADO_OUTB_query do
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

//    cxGrid2DBTableView1.DataController.Filter.Root.Clear;
//    cxGrid2DBTableView1.DataController.Filter.Root.AddItem(cxGrid2DBTableView1.GetColumnByFieldName('CODE00'),folike,DM.ADO_URGP_query.FieldByName('CODE00').AsString,DM.ADO_URGP_query.FieldByName('CODE00').AsString);
//    cxGrid2DBTableView1.DataController.Filter.Active:=true;

//      DM.ADO_ACTI_query.Filter:='CODE00='+''''+DM.ADO_URGP_query.FieldByName('CODE00').AsString+'''';
//      DM.ADO_ACTI_query.Filtered:=true;

end;


end.
