unit Unerrorlog;

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
  TFormerrorlog = class(TForm)
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
    cxGrid1DBTableView1FROM00: TcxGridDBColumn;
    cxGrid1DBTableView1ID0000: TcxGridDBColumn;
    cxGrid1DBTableView1AlarmTime: TcxGridDBColumn;
    cxGrid1DBTableView1AlarmText: TcxGridDBColumn;
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
  Formerrorlog: TFormerrorlog;

implementation

{$R *.dfm}

uses UnDM, UnMain, Unglobal;

procedure TFormerrorlog.BtnqueryClick(Sender: TObject);
var
  sqlstr:string;
begin

//can't query PLC VALARMS yet
  try

    sqlstr:=format('select * from VALARMS where convert(varchar(10),AlarmTime,23) between ''%s'' and ''%s''',[formatdatetime('yyyy-mm-dd',DateTimePicker1.Date),formatdatetime('yyyy-mm-dd',DateTimePicker2.Date)]);
    SQLquery(sqlstr,DM.ADO_ERLG_query);
 //   with DM.ADO_ERLG_query do
 //     begin
//        close;
//        sql.Clear;
////        sql.Add('select * from VALARMS');
//        sql.Add('select * from VALARMS where convert(varchar(10),AlarmTime,23) between :fjdt1 and :fjdt2');
//        Parameters.ParamByName('fjdt1').Value:=formatdatetime('yyyy-mm-dd',DateTimePicker1.Date);
//        Parameters.ParamByName('fjdt2').Value:=formatdatetime('yyyy-mm-dd',DateTimePicker2.Date);
//        open;
//       end;
  except
     Application.MessageBox('无法连接数据库','提示', MB_OK);
  end;
end;

procedure TFormerrorlog.BtncloseClick(Sender: TObject);
begin
  Formerrorlog.close;
end;

procedure TFormerrorlog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // or use Action := cafree;
   Formerrorlog.Free;
   Formerrorlog:=nil;
end;

procedure TFormerrorlog.FormCreate(Sender: TObject);
begin
//  DateTimePicker1.Date:=now();
//  DateTimePicker2.Date:=now();
end;

procedure TFormerrorlog.FormShow(Sender: TObject);
begin
  DateTimePicker1.Date:=now();
  DateTimePicker2.Date:=now();
  Btnquery.Click;
//  TDateTimefield(DM.ADO_VFJD_query.Fields[2]).displayformat:='yyyy-mm-dd';
end;

end.
