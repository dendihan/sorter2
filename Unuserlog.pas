unit Unuserlog;

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
  TFormuserlog = class(TForm)
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Btnquery: TButton;
    Btnclose: TButton;
    Panel2: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1ID0000: TcxGridDBColumn;
    cxGrid1DBTableView1USER00: TcxGridDBColumn;
    cxGrid1DBTableView1DATE00: TcxGridDBColumn;
    cxGrid1DBTableView1OPERAT: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtncloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnqueryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formuserlog: TFormuserlog;

implementation

{$R *.dfm}

uses UnDM, UnMain, Unglobal;

procedure TFormuserlog.BtnqueryClick(Sender: TObject);
var
  sqlstr:string;
begin
  try
    //sqlstr:='select * from USERLOG';
    sqlstr:=format('select * from USERLOG where convert(varchar(10),DATE00,23) between ''%s'' and ''%s''',[formatdatetime('yyyy-mm-dd',DateTimePicker1.Date),formatdatetime('yyyy-mm-dd',DateTimePicker2.Date)]);
    SQLquery(sqlstr,DM.ADO_URLG_query);
    //SQLquery(DM.ADO_URLG_query);
//    with DM.ADO_URLG_query do
//      begin
//        close;
//        sql.Clear;
//        sql.Add('select * from USERLOG where convert(varchar(10),DATE00,23) between :fjdt1 and :fjdt2');
//        Parameters.ParamByName('fjdt1').Value:=formatdatetime('yyyy-mm-dd',DateTimePicker1.Date);
//        Parameters.ParamByName('fjdt2').Value:=formatdatetime('yyyy-mm-dd',DateTimePicker2.Date);
//        open;
//       end;
  //dendi comment:convert(varchar(10),DATE00,23) to output DB datetime   as  yyyy-mm-dd
  except
     Application.MessageBox('无法连接数据库','提示', MB_OK);
  end;
end;

procedure TFormuserlog.BtncloseClick(Sender: TObject);
begin
  Formuserlog.close;
end;

procedure TFormuserlog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Formuserlog.Free;
   Formuserlog:=nil;
end;

procedure TFormuserlog.FormCreate(Sender: TObject);
begin
//  DateTimePicker1.Date:=now();
//  DateTimePicker2.Date:=now();
end;

procedure TFormuserlog.FormShow(Sender: TObject);
begin
  DateTimePicker1.Date:=now();
  DateTimePicker2.Date:=now();
  Btnquery.Click;
//  TDateTimefield(DM.ADO_VFJD_query.Fields[2]).displayformat:='yyyy-mm-dd';
end;

end.
