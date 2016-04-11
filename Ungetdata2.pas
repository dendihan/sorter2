unit Ungetdata2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  cxNavigator, Data.DB, cxDBData, cxLabel, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.StdCtrls, Vcl.ExtCtrls, NativeXML, CPort;

type
  TFormgetdata2 = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Btnget: TButton;
    Btnquery: TButton;
    Btnclose: TButton;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1PSTATE: TcxGridDBColumn;
    cxGrid1DBTableView1BARCODE: TcxGridDBColumn;
    cxGrid1DBTableView1POUT2: TcxGridDBColumn;
    cxGrid1DBTableView1POUT: TcxGridDBColumn;
    cxGrid1DBTableView1TONAME: TcxGridDBColumn;
    cxGrid1DBTableView1TOADDR: TcxGridDBColumn;
    cxGrid1DBTableView1TOCO: TcxGridDBColumn;
    cxGrid1DBTableView1TODETAIL: TcxGridDBColumn;
    cxGrid1DBTableView1TOTEL: TcxGridDBColumn;
    cxGrid1DBTableView1PWEIGHT: TcxGridDBColumn;
    cxGrid1DBTableView1PLENGTH: TcxGridDBColumn;
    cxGrid1DBTableView1PWIDTH: TcxGridDBColumn;
    cxGrid1DBTableView1PHEIGHT: TcxGridDBColumn;
    cxGrid1DBTableView1VOLUME: TcxGridDBColumn;
    cxGrid1DBTableView1LabBarCode: TcxGridDBColumn;
    cxGrid1DBTableView1CODEIN: TcxGridDBColumn;
    cxGrid1DBTableView1USERCODE: TcxGridDBColumn;
    cxGrid1DBTableView1USERNAME: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    ComPort1: TComPort;
    Btnsure: TButton;
    Btncancel: TButton;
    Button3: TButton;
    Label2: TLabel;
    POUT: TEdit;
    Label3: TLabel;
    BARCODE: TEdit;
    Label4: TLabel;
    FROMNAME: TEdit;
    Label5: TLabel;
    FROMADDR: TEdit;
    Label6: TLabel;
    FROMCO: TEdit;
    Label7: TLabel;
    FROMTEL: TEdit;
    Label8: TLabel;
    TONAME: TEdit;
    Label9: TLabel;
    TOADDR: TEdit;
    Label10: TLabel;
    TOCO: TEdit;
    Label11: TLabel;
    TODETAIL: TEdit;
    Label12: TLabel;
    TOTEL: TEdit;
    Label13: TLabel;
    TOZIPCODE: TEdit;
    Label14: TLabel;
    PNAME: TEdit;
    Label15: TLabel;
    PNUMBER: TEdit;
    Memo1: TMemo;
    procedure BtncloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtngetClick(Sender: TObject);
    procedure BtnqueryClick(Sender: TObject);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure BtncancelClick(Sender: TObject);
    procedure POUTKeyPress(Sender: TObject; var Key: Char);
    procedure BARCODEKeyPress(Sender: TObject; var Key: Char);
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
    procedure BtnsureClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formgetdata2: TFormgetdata2;
  beginFlag_data : Integer = 1;

implementation

{$R *.dfm}

uses Unglobal, UnDM;

procedure TFormgetdata2.BtncloseClick(Sender: TObject);
begin
  Formgetdata2.Close;
end;

procedure TFormgetdata2.BtngetClick(Sender: TObject);
var
  nodeList: TsdNodeList; //XML
  node: TXmlNode;
  i: Integer;
  xml: TNativeXml;
  sqlstr, bcStr, sdt: string;
begin
    sdt := formatdatetime('yyyy-mm-dd', DateTimePicker1.Date);
  try
    sqlstr:='exec pfjdataBackup ''' + sdt + '''';
    SQLexec(sqlstr,DM.ADO_temp_query);
    //with DM.ADO_temp_query do
    //begin
    //  if Active = True then
    //    Close;
    //    SQL.Clear;
    //    SQL.Add('exec pfjdataBackup ''' + sdt + '''');
    //   ExecSQL;
    //end;
  except
    Application.MessageBox('无法连接数据库服务器！','提示', MB_OK);
  end;


 xml:= TNativeXml.Create(Self);
 xml.LoadFromFile(GlobalXMLFile);
 xml.XmlFormat := xfReadable;
 node := xml.Root;
 nodeList := TsdNodeList.Create(False);
 node.FindNodes('ITEM', nodeList);
// ITEM is NODE NAME XML like this
//<?xml version="1.0" encoding="utf-8"?>
//<root>
//  <rows>
//	<ITEM BARCODE='5000011755017' FROMDATE='2015-05-08' FROMNAME='张三1' FROMADDR='厦门1' FROMCO='厦门长亨信息科技1' FROMDETAIL='厦门厦禾路888号1' FROMTEL='13912345671' FROMZIPCODE='361000' TONAME='Jackson1' TOADDR='宁波1' TOCO='宁波亿普瑞1' TODETAIL='宁波开发区' TOTEL='13950100001' TOZIPCODE='361001' PNAME='文件资料1' PNUMBER='1' PWEIGHT='2.66' PLENGTH='20' PWIDTH='11' PHEIGHT='11' PCOST='123.02' />
//	<ITEM BARCODE='5000011755018' FROMDATE='2015-05-08' FROMNAME='张三2' FROMADDR='厦门2' FROMCO='厦门长亨信息科技2' FROMDETAIL='厦门厦禾路888号2' FROMTEL='13912345672' FROMZIPCODE='361000' TONAME='Jackson2' TOADDR='宁波2' TOCO='宁波亿普瑞2' TODETAIL='宁波开发区' TOTEL='13950100002' TOZIPCODE='361002' PNAME='文件资料2' PNUMBER='2' PWEIGHT='4.66' PLENGTH='30' PWIDTH='12' PHEIGHT='12' PCOST='124.02' />
//	<ITEM BARCODE='5000011755019' FROMDATE='2015-05-08' FROMNAME='张三3' FROMADDR='厦门3' FROMCO='厦门长亨信息科技3' FROMDETAIL='厦门厦禾路888号3' FROMTEL='13912345673' FROMZIPCODE='361000' TONAME='Jackson3' TOADDR='宁波3' TOCO='宁波亿普瑞3' TODETAIL='宁波开发区' TOTEL='13950100003' TOZIPCODE='361003' PNAME='文件资料3' PNUMBER='3' PWEIGHT='5.66' PLENGTH='40' PWIDTH='13' PHEIGHT='13' PCOST='155.02' />
//  </rows>
//</root>
//
 for i := 0 to nodeList.Count - 1 do
 begin
 // ShowMessage(nodeList[i].AttributeByName['FROMNAME'].Value);
 bcStr := nodeList[i].AttributeByName['BARCODE'].Value;
 //nodeList[i].AttributeByName['BARCODE'].Value;
 //find AttributeByName
 sqlstr := 'DECLARE @BCC INT ' + 'SELECT @BCC=COUNT(BARCODE) FROM FJDATA WHERE BARCODE=''' + bcStr + ''' ' +
 'IF (@BCC=0) ' + 'BEGIN ' +
 'INSERT INTO FJDATA(BARCODE,FJDATE,FROMDATE,FROMNAME,FROMADDR,FROMCO,FROMDETAIL,FROMTEL,FROMZIPCODE,' +
'TONAME,TOADDR,TOCO,TODETAIL,TOTEL,TOZIPCODE,PNAME,PNUMBER,PWEIGHT,PLENGTH,PWIDTH,PHEIGHT,PCOST,GUID,PSTATE,POUT) '
+ 'VALUES(''' + bcStr + ''',GETDATE(),''' + nodeList[i].AttributeByName['FROMDATE'].Value + '''' + ',''' +
 nodeList[i].AttributeByName['FROMNAME'].Value + '''' + ',''' + nodeList[i].AttributeByName['FROMADDR'].Value +
 '''' + ',''' + nodeList[i].AttributeByName['FROMCO'].Value + '''' + ',''' + nodeList[i].AttributeByName
 ['FROMDETAIL'].Value + '''' + ',''' + nodeList[i].AttributeByName['FROMTEL'].Value + '''' + ',''' +
 nodeList[i].AttributeByName['FROMZIPCODE'].Value + '''' + ',''' + nodeList[i].AttributeByName['TONAME'].Value +
 '''' + ',''' + nodeList[i].AttributeByName['TOADDR'].Value + '''' + ',''' + nodeList[i].AttributeByName['TOCO']
 .Value + '''' + ',''' + nodeList[i].AttributeByName['TODETAIL'].Value + '''' + ',''' + nodeList[i].AttributeByName
 ['TOTEL'].Value + '''' + ',''' + nodeList[i].AttributeByName['TOZIPCODE'].Value + '''' + ',''' +
 nodeList[i].AttributeByName['PNAME'].Value + '''' + ',''' + nodeList[i].AttributeByName['PNUMBER'].Value + '''' +
 ',''' + nodeList[i].AttributeByName['PWEIGHT'].Value + '''' + ',''' + nodeList[i].AttributeByName['PLENGTH'].Value
 + '''' + ',''' + nodeList[i].AttributeByName['PWIDTH'].Value + '''' + ',''' + nodeList[i].AttributeByName
 ['PHEIGHT'].Value + '''' + ',''' + nodeList[i].AttributeByName['PCOST'].Value + '''' + ',0,0,''''' +
 '); ' + 'END';


  try
    SQLexec(sqlstr,DM.ADO_temp_query);
  //  with DM.ADO_temp_query do
  //  begin
  //  if Active = True then
  //    Close;
  //  SQL.Clear;
  //  SQL.Add(sqlstr);
  //  ExecSQL;
  //  end;
  except
    Application.MessageBox('无法连接数据库服务器！','提示', MB_OK);
  end;

  end;

  //nodeList.Free;
  Freeandnil(nodelist);
  Freeandnil(xml);
  RecordLog('获取业务数据');
  BtnQuery.Click;
end;

procedure TFormgetdata2.BtnqueryClick(Sender: TObject);
var
  sqlstr:string;
begin
  try
    sqlstr:=format('select * from V_FJDATA where convert(varchar(10),FJDATE,23)=''%s''',[formatdatetime('yyyy-mm-dd',DateTimePicker1.Date)]);
    SQLquery(sqlstr,DM.ADO_VFJD_query);
//    with DM.ADO_VFJD_query do
//      begin
//        close;
 //       sql.Clear;
 //       sql.Add('select * from V_FJDATA where convert(varchar(10),FJDATE,23)=:fjdt');
 //       Parameters.ParamByName('fjdt').Value:=formatdatetime('yyyy-mm-dd',DateTimePicker1.Date);
  //      open;
//       end;
  except
     Application.MessageBox('无法连接数据库','提示', MB_OK);
  end;
end;

procedure TFormgetdata2.BtnsureClick(Sender: TObject);
var
  sqlstr:string;
  a:Array [1..14] of string;
begin
  if (POUT.Text<>'') and (BARCODE.Text<>'') then
  begin

    //a[1]:=strtoint(trim(POUT.Text));
    a[1]:=trim(POUT.Text);
    a[2]:=trim(BARCODE.Text);
    a[3]:=trim(FROMNAME.Text);
    a[4]:=trim(FROMADDR.Text);
    a[5]:=trim(FROMCO.Text);
    a[6]:=trim(FROMTEL.Text);
    a[7]:=trim(TONAME.Text);
    a[8]:=trim(TOADDR.Text);
    a[9]:=trim(TOCO.Text);
    a[10]:=trim(TODETAIL.Text);
    a[11]:=trim(TOTEL.Text);
    a[12]:=trim(TOZIPCODE.Text);
    a[13]:=trim(PNAME.Text);
    a[14]:=trim(PNUMBER.Text);
    sqlstr:=format('INSERT INTO FJDATA(POUT,BARCODE,FJDATE,FROMDATE,FROMNAME,FROMADDR,FROMCO,FROMDETAIL,FROMTEL,FROMZIPCODE,TONAME,TOADDR,TOCO,TODETAIL,TOTEL,TOZIPCODE,PNAME,PNUMBER) '
    +'VALUES(''%s'',''%s'',GETDATE(),GETDATE(),''%s'',''%s'',''%s'','''',''%s'','''',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'')',[a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14]]);
    try
      SQLexec(sqlstr,DM.ADO_INST_query);
      memo1.Lines.Add('插入'+BARCODE.Text+'成功');
    except
      memo1.Lines.Add('插入'+BARCODE.Text+'失败，数据已经存在');
    end;
  end
  else
    Application.MessageBox('请输入出口和条码！','提示', MB_OK);
end;

procedure TFormgetdata2.ComPort1RxChar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  if (beginFlag_data = 1) then
    begin
      BARCODE.Text := '';
    end;
  ComPort1.ReadStr(Str, Count);
  beginFlag_data := 0;
  if (Str.EndsWith(#10)) then
    begin
      beginFlag_data := 1;
    end;
  BARCODE.Text := BARCODE.Text + Str;
end;

procedure TFormgetdata2.BARCODEKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Btnsure.Click;
end;

procedure TFormgetdata2.BtncancelClick(Sender: TObject);
begin
  POUT.Text:='';
  BARCODE.Text:='';
end;

procedure TFormgetdata2.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

var
  vStr ,O1,O2: string;
begin
  vStr := Trim(VarAsType(AViewInfo.GridRecord.DisplayTexts[cxGrid1DBTableView1PSTATE.Index], varString));
  if vStr = '已分拣' then
  begin
    ACanvas.Canvas.Brush.Color := clSkyBlue;
    ACanvas.Canvas.Font.Color := clblack;
  end
  else if vStr = '已打印' then
  begin
    ACanvas.Canvas.Brush.Color := clMoneyGreen;
    ACanvas.Canvas.Font.Color := clblack;
  end
  else if vStr = '已扫描' then
  begin
    ACanvas.Canvas.Brush.Color := clYellow;
    ACanvas.Canvas.Font.Color := clblack;
  end;
  O1 := Trim(VarAsType(AViewInfo.GridRecord.DisplayTexts[cxGrid1DBTableView1POUT.Index], varString));
  O2 := Trim(VarAsType(AViewInfo.GridRecord.DisplayTexts[cxGrid1DBTableView1POUT2.Index], varString));

  if ((vStr ='已打印') or (vStr ='已分拣')) and (O1 <> O2) then
  begin
    ACanvas.Canvas.Brush.Color := clRed;
    ACanvas.Canvas.Font.Color := clblack;
  end;

  if AViewInfo.Selected then
  begin
    ACanvas.Canvas.Font.Color := clwhite;
    ACanvas.Canvas.Brush.Color := clNavy;
  end;
end;

procedure TFormgetdata2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Formgetdata2.Free;
  Formgetdata2:=nil;
end;

procedure TFormgetdata2.FormShow(Sender: TObject);
begin
  DateTimePicker1.date:=now();
  Btnget.SetFocus;
  Btnquery.Click;

  try
    ComPort1.Open;
  except
    Application.MessageBox(PWideChar('不能打开串口，请检查处理后重新打开应用程序。 '),'提示',MB_OK);
  end;
end;

procedure TFormgetdata2.POUTKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Btnsure.Click;
end;

end.
