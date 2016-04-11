unit Unmonitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,math,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdCustomTCPServer,
  IdTCPServer, IdContext,Generics.Collections,System.Generics.Defaults,
  Vcl.OleServer, OPCAutomation_TLB,Data.DB, IdScheduler,
  IdSchedulerOfThread, IdSchedulerOfThreadDefault, Vcl.ComCtrls,IdGlobal;

type
  TScanTCP = class(TThread)
  private
    { Private declarations }

  protected
    procedure Execute; override;
end;

type
  TReadPLC = class(TThread)
  private
 { Private declarations }
    procedure UpdateDEVStatus;
  protected
    procedure Execute; override;
  public
end;
//mainline
type
  TCarPosi = record // 小车位置信息
  POSIID: Integer; // 位置编号 1 - 64
  GUID00: Integer; // 从 PLC 读取的唯一码
  CARID: Integer; // 小车编号
  OUTID: Integer;
  OUTCode: string; // 出口编号
  OPCCARID: string; // OPC ITEM ID
  OPCOUTID: string; // OPC ITEM ID
  OPCGUID: string; // OPC ITEM ID
end;
//out
type
  TOuter = record // 出口信息
  AutoID: Integer; // 自动编号
  CODE00: string; // 代码
  MAX000: Integer; // 容量
  COUNT0: Integer; // 数量
  TARCODE: string; // 目的地代码
  TARNAME: string; // 目的地名称
  OPCMAX: string; // OPC ITEM ID 出口容量
  OPCCOU: string; // OPC ITEM ID 已出物件数量
  OPCCHG: string; // OPC ITEM ID 出口更换包装袋
  OPCOUTBEGIN: string; // OPC ITEM ID 出口动作完成，可以读取唯一码
  OPCOUTEND: string; // OPC ITEM ID 已读取唯一码
  OPCOUTGUID: string; // OPC ITEM ID 唯一码
  PRINTIP: string; // 出口打印机 PC IP
end;

//in
type
  TInner = record // 出口信息
  AutoID: Integer; // 自动编号
  CODE00: string; // 代码
  IPADDR: string; // ip 地址
  READPLC: string; // OPC 读 item id
  WRITEPLC: string; // OPC 写 ITEM ID
  ATTR00: Integer; // 属性
end;

type
  TPrint = record // 出口打印单据信息
  OUTCode: string; // 出口编号
  Cou: Integer; // 包含货件量
  TARCODE: string; // 目的地代码
  TARNAME: string; // 目的地名称
  BarCode: string; // 条码
end;

type
  TFormmonitor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Memo1: TMemo;
    LBClientIP: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ShapePlcConn: TShape;
    Label4: TLabel;
    ShapeHeart: TShape;
    IdTCPClient1: TIdTCPClient;
    IdTCPServer1: TIdTCPServer;
    OPCServer1: TOPCServer;
    OPCGroupErrBegin: TOPCGroup;
    OPCGroupMain: TOPCGroup;
    OPCGCarEnter: TOPCGroup;
    OPCGroupWrite: TOPCGroup;
    LabelState: TLabel;
    IdSchedulerOfThreadDefault1: TIdSchedulerOfThreadDefault;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    //IdSchedulerOfThreadDefault.pas implements the default thread-based scheduler
    //used in TIdTCPServer and descendant classes.
    procedure FormShow(Sender: TObject);
    procedure IdTCPServer1Connect(AContext: TIdContext);
    procedure IdTCPServer1Disconnect(AContext: TIdContext);
    procedure IdTCPServer1Exception(AContext: TIdContext;
      AException: Exception);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure IdTCPServer1ListenException(AThread: TIdListenerThread;
      AException: Exception);
    procedure OPCServer1ServerShutDown(ASender: TObject;
      const Reason: WideString);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IdTCPClient1Connected(Sender: TObject);
  private
    { Private declarations }
    READPLC: TReadPLC;
    READSCAN:TScanTCP;
    //basic

    procedure BarCodeNoReadNotifyInner;
    procedure UpdateDBByBarCode;

    //Scan
    procedure ScanReceiver;
    procedure Scanconn;
    //mainline
    procedure CreateMainLine;
    procedure CreateIn;
    procedure CreateOut;
    //READPLC
    procedure ReadMain;
    procedure ShowMain;



    //OPC below
    procedure PLCMainItemWrite(itemid: string; val: OleVariant);
    procedure PLCItemWrite(itemid: string; val: OleVariant);

    procedure WriteHeart0;
    procedure WriteHeart1;
    procedure WriteDevParam;

    function MainItemRead(itemid: string): OleVariant;
    function ErrBeginItemRead(itemid: string): OleVariant;


  public
    { Public declarations }
     procedure WriteMemo(memo: string);
     procedure PrintLabel;
     //opc
     procedure WriteOuterForInter; //
     procedure WriteOuterForMain; //
     //TCP server
     //delete by dendi in 2016/4/2
     //procedure MsgAvail(Sender: TRecContextData);

     //common
     procedure OutUpdate(guid: Integer; OUTCode: string);
     procedure OutPrintUpdate(OUTCode: string; LabBarCode: string);
     function findopcitem(itemid: string):string;
     function GetMaxSeq(OUTCode: string): string; // 获取出口最大顺序号
     function GetPcs(OUTCode: string): string; // 获取出口包装袋内物件数量
  end;
const
  c_carHeight = 35; // 小车高度
  c_arc = 8; // 半弧形 小车个数
  c_gap = 5; // 小车间隙
  c_InHeight = 35; // 入口高度
  c_InGap = 5; // 入口间隙
  c_OutHeight = 35; // 出口高度
  c_OutGap = 5; // 出口间隙
  PLCProgID = 'KEPware.KEPServerEx.V4';
var
  Formmonitor: TFormmonitor;
  Scanread:string;

  c_carWidth: Integer; // 小车宽度
  M_DevInit: Integer = 0; // 设备初始化参数是否已下传 1 是 0 否
  M_Cars: Integer; // 小车总数
  M_MaxRound: Integer; // 主线最大转圈数
  PLCNode: string; // PLC IP 地址
  M_InNum: Integer; // 入口个数
  M_OunNum_usual: Integer; // 正常出口个数
  M_OunNum_unusual: Integer; // 异常出口个数

  M_Carry: array of TPanel; // 小车
  M_In: array of TPanel; // 入口
  M_Out: array of TPanel; // 出口
  M_Carry_Lab: array of TLabel; // 小车标签
  M_Out_Lab: array of TLabel; // 出口标签

  M_CarPosi: array of TCarPosi; // 位置信息
  M_Outer: array of TOuter; // 出口信息
  M_Inner: array of TInner; // 入口信息
  M_Errors: array of string; // plc 报警
  M_InnerIP: System.TArray<string>; // 入口 IP

  M_Online: Integer; // 设备运行状态
  M_DevState: string; // 设备运行状态

  M_CurCarID: Integer; // 光电检测后小车编号
  M_CurGuid: Integer; // 光电检测后唯一码
  M_CurOuter: Integer; // 光电检测后小车物件对应出口

  l2top: Integer;
  l2left: Integer;
  R_rate: Integer;
//  LockReadEnd: TCriticalSection;
  M_PrintQueue: TQueue<TPrint>; // 打印队列

 //OPC items
  MainOPCItems: OPCItems;
  CarEnterOPCItems: OPCItems;
  CarLeaveOPCItems: OPCItems;
  ErrBeginOPCItems: OPCItems;
  WriteOPCItems: OPCItems;

  OPCITEMID_CARENTER: string; // 主线小车进入光电开关
  OPCITEMID_CARLEAVE: string; // 主线小车离开光电开关
  OPCITEMID_CURCARID: string; // 主线光电位置当前小车编号
  OPCITEMID_CURGUID: string; // 主线光电位置当前唯一编号
  OPCITEMID_CUROUTER: string; // 主线光电位置当前唯一编号
  OPCITEMID_ONLINE: string; // PLC 在线
  OPCITEMID_PLCRUN1: string; // PLC 运行状态 正常
  OPCITEMID_PLCRUN2: string; // PLC 运行状态 急停
  OPCITEMID_PLCRUN3: string; // PLC 运行状态 异常
  OPCITEMID_WRITEHEART: string; // 心跳写入
  OPCITEMID_WRITEROUNDMAX: string; // 转圈最大数
  OPCITEMID_WRITEGUID: string; // 主线扫码件唯一码
  OPCITEMID_WRITEOUTID: string; // 主线扫码件出口编号
  OPCITEMID_ERRBEGIN: string; // 可以开始读取报警信息
  OPCITEMID_ERREND: string; // 报警信息读取完成

implementation

{$R *.dfm}

uses UnMain, UnDM, Unglobal;
//~~~~~~~~~~~~~~~~~~common use module~~~~~~~~~~~~~
procedure TFormMonitor.PrintLabel;
var
  ZPLCode,printer :string;
  i :integer;
begin
  try
    // frxOuterLabel.PrintOptions.ShowDialog := true;
    // frxOuterLabel.PrepareReport();
    // frxOuterLabel.print;
    GlobalPrint_ip := '';
      for i := Low(M_Outer) to High(M_Outer) do
        begin
          if (M_Outer[i].CODE00 = GlobalPrint_out) then
            begin
              GlobalPrint_ip := M_Outer[i].PRINTIP;
            end;
        end;
    //printer:='\\'+GlobalPrint_ip+'\'+'ZDesigner ZM400 300 dpi (ZPL)';
    printer:='\\'+printer+'\'+GlobalPrint_name;
    ZPLCode := MakeZPLCode(GlobalPrint_barcode, GlobalPrint_dest, GlobalPrint_pcs, GlobalPrint_origin);
//    StringToPrinter(ZPLCode);
    WriteRawStringToPrinter(printer,ZPLcode);
    writememo('补打出口包装袋标签：' + GlobalPrint_barcode);
    RecordLog('补打出口包装袋标签：' + GlobalPrint_barcode);
  except
    on e: Exception do
      Application.MessageBox(pwidechar('打印错误：' + e.Message), '提示', MB_OK);
  end;
end;
procedure TFormMonitor.OutUpdate(guid: Integer; OUTCode: string);
var
  sqlstr: string;
begin
  try
    sqlstr := 'UPDATE FJDATA SET PSTATE=2,POUT2=''' + OUTCode + ''' WHERE PSTATE=1 AND GUID=' + Inttostr(guid);
    with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        ExecSQL;
      end;
    //    if DM.ADOQuery.Active = True then
//      DM.ADOQuery.Close;
//    DM.ADOQuery.SQL.Clear;
//    DM.ADOQuery.SQL.Add(sqlstring);
//    DM.ADOQuery.ExecSQL;
  except
    on e: Exception do
      WriteMemo('OutUpdate 异常： ' + e.Message);
 end;

end;

procedure TFormMonitor.OutPrintUpdate(OUTCode: string; LabBarCode: string);
var
  sqlstr: string;
begin
  try
    sqlstr := 'UPDATE FJDATA SET PSTATE=3,LabBarCode=''' + LabBarCode +
      ''' WHERE PSTATE=2 and isnull(LabBarCode,'''')='''' AND POUT2=''' + OUTCode + '''';
    with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        ExecSQL;
      end;
// if DM.ADOQuery.Active = True then
// DM.ADOQuery.Close;
// DM.ADOQuery.SQL.Clear;
// DM.ADOQuery.SQL.Add(sqlstring);
// DM.ADOQuery.ExecSQL;
  except
    on e: Exception do
      WriteMemo('OutPrintUpdate 异常： ' + e.Message);
  end;
end;

function TFormMonitor.GetMaxSeq(OUTCode: string): string; // 获取出口最大顺序号
var
 sqlstr, r: string;
begin
  try
    sqlstr := 'SELECT MAX(RIGHT(LABBARCODE,4))+1 MAXSEQ FROM FJDATA WHERE POUT2=''' + OUTCode + '''';
    with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        Open;
        if ((RecordCount = 0) or (length(FieldByName('MAXSEQ').AsString) = 0)) then
          begin
            GetMaxSeq := '0001';
          end
        else
          begin
            r := FieldByName('MAXSEQ').AsString;
            while length(r) < 4 do
              begin
                r := '0' + r;
              end;
            GetMaxSeq := r;
          end;
      end;

  except
    on e: Exception do
      WriteMemo('GetMaxSeq 异常： ' + e.Message);
  end;
end;

function TFormMonitor.GetPcs(OUTCode: string): string; // 获取出口包装袋内物件数量
var
  sqlstr, r: string;
begin
  try
    sqlstr := 'SELECT COUNT(BARCODE) COU FROM FJDATA WHERE PSTATE=2 AND ISNULL(LabBarCode,'''')='''' AND POUT2=''' +OUTCode + '''';
    with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        Open;
        r := Inttostr(FieldByName('COU').AsInteger);
      end;
// if DM.ADOQuery.Active = True then
// DM.ADOQuery.Close;
// DM.ADOQuery.SQL.Clear;
// DM.ADOQuery.SQL.Add(sqlstring);
// DM.ADOQuery.Active := True;


    while length(r) < 3 do
      begin
        r := '0' + r;
      end;
    GetPcs := r;
  except
    on e: Exception do
      WriteMemo('GetPcs 异常： ' + e.Message);
  end;
end;

function TFormMonitor.Findopcitem(itemid: string):string;
begin
  if DM.ADO_MONI_query.Locate('NAME00', itemid, [loCaseInsensitive]) then
    begin
      DM.ADO_MONI_query.Locate('NAME00', itemid, [loCaseInsensitive]);
      result := DM.ADO_MONI_query.FieldByName('ITEMID').AsString;
    end
  else
    result :='';
end;

procedure TFormMonitor.WriteMemo(memo: string);
begin
 Memo1.Lines.Insert(0, Formatdatetime('yyyy-mm-dd HH:nn:ss', now()) + ' -> ' + trim(memo));
end;
//~~~~~~~~~~~~~~~~~~common use module~~~~~~~~~~~~~
procedure TFormMonitor.BarCodeNoReadNotifyInner;
var
  InnerList: TList;
  i, num: Integer;
  connIp: string;
begin
  // 没接收到条码， 发信息到入口计算机 [STX]NR:GUID[ETX]
  InnerList := IdTCPServer1.Contexts.LockList;
  try
    for i := 0 to InnerList.Count - 1 do
      try
        connIp := TIdContext(InnerList.Items[i]).Connection.Socket.Binding.PeerIP;
        if TArray.BinarySearch<string>(M_InnerIP, connIp, num, TStringComparer.Ordinal) then
          TIdContext(InnerList.Items[i]).Connection.IOHandler.WriteLn('[STX]NR:' + GlobalIndex + '[ETX]');
        // TIdContext(InnerList.Items[i]).Connection.IOHandler.WriteLn('[STX]NR:' + Inttostr(M_CurGuid) + '[ETX]');
      except
        on e: Exception do
          WriteMemo('WriteDevParam 参数初始化异常：' + e.Message);
      end;
  finally
    GlobalIndex := '0';
    IdTCPServer1.Contexts.UnlockList;
  end;
end;
procedure TFormMonitor.UpdateDBByBarCode;
var
  sqlstr: string;
  outer: string;
begin
  try
    // Guid 还未记录到数据库 ： 获取出口  下发PLC  更新数据库
    //if not GuidExist then
    begin
      sqlstr := 'SELECT TOP 1 POUT FROM FJDATA WHERE BARCODE=''' + GlobalBarCode + '''';
      with  DM.ADO_MONI_query do
        begin
          if active then
            close;
          SQL.Clear;
          SQL.Add(sqlstr);
          open;
          outer:=FieldByName('POUT').AsString;
        end;


//      if DM.ADOQuery.Active = True then
//        DM.ADOQuery.Close;
//      DM.ADOQuery.SQL.Clear;
//      DM.ADOQuery.SQL.Add(sqlstring);
//      DM.ADOQuery.Active := True;
//      outer := DM.ADOQuery.FieldByName('POUT').AsString;

      if (GlobalIndex = '') then
        GlobalIndex := '0';
      if (outer = '') then
        outer := '0';
      if (GlobalLength = '') then
        GlobalLength := '0';
      if (GlobalWidth = '') then
        GlobalWidth := '0';
      if (GlobalHeight = '') then
        GlobalHeight := '0';
      if (GlobalVolume = '') then
        GlobalVolume := '0';

      // PLCItemWrite(OPCITEMID_WRITEGUID, M_CurGuid);
      PLCItemWrite(OPCITEMID_WRITEGUID, GlobalIndex);
      PLCItemWrite(OPCITEMID_WRITEOUTID, outer);
      PLCItemWrite(OPCITEMID_ERRBEGIN, 1);
      // sqlstring := 'UPDATE FJDATA SET PLENGTH=' + GlobalLength + ',PWIDTH=' + GlobalWidth + ',PHEIGHT=' + GlobalHeight +
      // ',VOLUME=' + GlobalVolume + ',GUID=''' + Inttostr(M_CurGuid) + ''',PSTATE=1 ' + ' WHERE BARCODE=''' + GlobalBarCode + '''';

      sqlstr := 'UPDATE FJDATA SET PLENGTH=' + GlobalLength + ',PWIDTH=' + GlobalWidth + ',PHEIGHT=' + GlobalHeight +
        ',VOLUME=' + GlobalVolume + ',GUID=''' + GlobalIndex + ''',PSTATE=1 ' + ' WHERE BARCODE=''' +
        GlobalBarCode + '''';
//      if DM.ADOQuery.Active = True then
//        DM.ADOQuery.Close;
//      DM.ADOQuery.SQL.Clear;
//      DM.ADOQuery.SQL.Add(sqlstring);
//      DM.ADOQuery.ExecSQL;
      with  DM.ADO_MONI_query do
        begin
          if active then
            close;
          SQL.Clear;
          SQL.Add(sqlstr);
          ExecSQL;
        end;

      WriteMemo('条码=' + GlobalBarCode + ', 小车号=' + GlobalIndex + ', 出口=' + outer);

      GlobalIndex := '0';
      outer := '0';
      GlobalBarCode := '';
    end;
  except
    on e: Exception do
      ErrorLog('UpdateDBByBarCode 异常：' + sqlstr + '。 ' + e.Message);
  end;
end;

procedure TFormMonitor.WriteOuterForMain;
begin
  if ((GlobalGuid <> '') and (GlobalOuter <> '')) then
  begin
    try
      PLCItemWrite(OPCITEMID_WRITEGUID, GlobalGuid);
      PLCItemWrite(OPCITEMID_WRITEOUTID, GlobalOuter);
      WriteMemo('供包台扫码结果写PLC，唯一码：' + GlobalGuid + ' PLC(OPC):' + OPCITEMID_WRITEGUID + '; 出口：' + GlobalOuter + ' PLC(OPC):' + OPCITEMID_WRITEOUTID);
      GlobalGuid := '';
      GlobalOuter := '';
    except
      on e: Exception do
        ErrorLog('WriteOuterForMain 异常：' + GlobalGuid + ' -> ' + GlobalOuter + ' . ' + e.Message);
    end;
  end;
end;

function TFormMonitor.MainItemRead(itemid: string): OleVariant;
var
  myValue, myQuality, myTimeStamp: OleVariant;
begin
  try
    MainOPCItems.item(itemid).Read(1, myValue, myQuality, myTimeStamp);
    if myValue = True then
      begin
        MainItemRead := 1;
      end
    else if myValue = False then
      begin
        MainItemRead := 0;
      end
    else
      begin
        MainItemRead := myValue;
      end;
  except
    on e: Exception do
      WriteMemo('读 PLC ' + itemid + ' 异常: ' + e.Message);
    end;
end;











{ TScanTCP setting below }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
procedure TScanTCP.Execute;
begin
  { Place thread code here }

//  if tc<>0 then
//    sleep(1000);
//     Synchronize(FormIn.Tcpconn);

  while not Terminated do
    begin
      if Formmonitor.IdTCPClient1.Connected then
        begin
          sleep(100);
//      Application.ProcessMessages;
          if Formmonitor.IdTCPClient1.IOHandler.Readable(1000) then
            begin
            Synchronize(Formmonitor.ScanReceiver);
            end;
        //    showmessage('1');
        end
      else
        begin
          sleep(10000);
          Synchronize(Formmonitor.ScanConn);
        end;
//      showmessage('1');
    end;
end;


procedure TFormmonitor.ScanConn;
begin
  try
    if not IdTCPClient1.Connected then
      begin
        Application.ProcessMessages;
        IdTCPClient1.Connect;
       end;
  except
    on e:exception do
      begin
        IdTCPClient1.Disconnect;
      end;
  end;
end;
procedure TFormmonitor.ScanReceiver;
// 显示到页面
  // 控制器发送信息： [STX]条码，长度，宽度，高度，体积[ETX]    [STX]NoRead[ETX]
  // 入口发送信息：   [STX]BC:条码[ETX]
var
  msg,tmpstr,sqlstr:string;
//  c,r:Integer;
  p1,p2,p3,p4,ind,readlen:integer;
begin
  try
    IdTCPClient1.IOHandler.CheckForDataOnSource;
    Scanread := IdTCPClient1.IOHandler.InputBufferAsString();
//    Scanread := IdTCPClient1.IOHandler.ReadLn();
//    readlen:= IdTCPClient1.IOHandler.InputBuffer.Size;
//    Scanread := IdTCPClient1.IOHandler.Readstring(readlen);
//    readlen:=IdTCPClient1.IOHandler.readin
//    readlen := IdTCPClient1.IOHandler.RecvBufferSize;
  except
    on e: exception do
    //  showmessage('error');
  end;


//  showmessage(Scanread);

  //  IdTCPClient1.IOHandler.writeLn(Scanread);



  if Scanread <> '' then
    begin
      try

//        showmessage('1');
        p1 := Scanread.IndexOf(#02);
   //       p1 := Scanread.IndexOf('@');
   //       p2 := Scanread.IndexOf('#');
        p2 := Scanread.IndexOf(#03);
        if ((p1 >= 0) and ((p2 - p1) > 5)) then
          begin
            msg := copy(Scanread, p1 + 2, p2 - p1 - 1);
            WriteMemo(msg);
            Scanread := '';
            ind := UpperCase(msg).IndexOf('NOREAD');
            if ind >= 0 then // 控制器 未读取条码
              begin
                GlobalBarCode := '';
                GlobalLength := '';
                GlobalWidth := '';
                GlobalHeight := '';
                GlobalVolume := '';
                GlobalIsBarCodeRead := 0;
                //WriteMemo('没读取到条码');

                p3 := msg.IndexOf(','); // Pos(',', msg)
                GlobalIndex := copy(msg, 0, p3);
                sleep(50);
                BarCodeNoReadNotifyInner;
              end
            else
              begin
                GlobalBarCode := '';
                GlobalLength := '';
                GlobalWidth := '';
                GlobalHeight := '';
                GlobalVolume := '';
                GlobalIsBarCodeRead := 1;
                try
                  p3 := msg.IndexOf(','); // Pos(',', msg)
                  GlobalIndex := copy(msg, 0, p3);
                  tmpStr := copy(msg, p3 + 2, length(msg) - p3);

                  p3 := tmpStr.IndexOf(',');
                  GlobalBarCode := copy(tmpStr, 0, p3);

        // 可能出现多个条码 条码1/条码2/条码3...
                  p4 := GlobalBarCode.IndexOf('/');
                  if (p4 >= 0) then
                    begin
                      GlobalBarCode := copy(GlobalBarCode, 0, p4);
                    end;
                  tmpStr := copy(tmpStr, p3 + 2, length(tmpStr) - p3);

                  p3 := tmpStr.IndexOf(',');
                  GlobalLength := copy(tmpStr, 0, p3);
                  tmpStr := copy(tmpStr, p3 + 2, length(tmpStr) - p3);

                  p3 := tmpStr.IndexOf(',');
                  GlobalWidth := copy(tmpStr, 0, p3);
                  tmpStr := copy(tmpStr, p3 + 2, length(tmpStr) - p3);

                  p3 := tmpStr.IndexOf(',');
                  GlobalHeight := copy(tmpStr, 0, p3);
                  GlobalVolume := copy(tmpStr, p3 + 2, length(tmpStr) - p3);

                  WriteMemo('Index=' + GlobalIndex + ',条码=' + GlobalBarCode + ',长度=' + GlobalLength + ',宽度=' + GlobalWidth +
                  ',高度=' + GlobalHeight + ',体积=' + GlobalVolume);
                  //notify!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  UpdateDBByBarCode;
              except
                on e: Exception do
                  ErrorLog('控制器数据解析：' + msg + ' -> ' + e.Message);
              end;
      // UpdateDBByBarCode;
            end;
        end;
      except
        on e: exception do
          ErrorLog('监控接收数据处理异常： ' + e.Message);
        end;
    end;
end;
{ TReadTCP setting above}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


//~~~~~~~~~~~~~~~~~~~~~OPC below~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
procedure TFormMonitor.PLCMainItemWrite(itemid: string; val: OleVariant);
begin
  try
    MainOPCItems.item(itemid).Write(val);
  except
    on e: Exception do
      WriteMemo('PLCMainItemWrite 异常： (' + itemid + ')' + e.Message);
  end;
end;

procedure TFormmonitor.PLCItemWrite(itemid: string; val: OleVariant);
begin
  try
    WriteOPCItems.item(itemid).Write(val);
  except
    on e: Exception do
      WriteMemo('PLCItemWrite 异常： (' + itemid + ')' + e.Message);
  end;
end;

procedure TFormMonitor.WriteOuterForInter;
var
  outer, sqlstr: string;
begin
  // 根据入口扫码写出口代码到PLC
  try
    if ((GlobalBarCodeIn <> '') and (GlobalOPCItemIn <> '')) then
    begin
      sqlstr := 'SELECT TOP 1 POUT FROM FJDATA WHERE BARCODE=''' + GlobalBarCodeIn + '''';
      with DM.ADO_MONI_query do
        begin
          if active then
            close;
          SQL.Clear;
          SQL.Add(sqlstr);
          Open;
          outer := FieldByName('POUT').AsString;
        end;
//      if DM.ADOQuery.Active = True then
//        DM.ADOQuery.Close;
//      DM.ADOQuery.SQL.Clear;
//      DM.ADOQuery.SQL.Add(sqlstring);
//      DM.ADOQuery.Active := True;
//      outer := DM.ADOQuery.FieldByName('POUT').AsString;
      PLCItemWrite(GlobalOPCItemIn, outer);
      //showmessage(GlobalOPCItemIn+'   '+outer);
      GlobalBarCodeIn := '';
      GlobalOPCItemIn := '';
      WriteMemo('供包台扫码结果写PLC，出口：' + outer + ' PLC(OPC):' + GlobalOPCItemIn);
    end;
  except
    on e: Exception do
      ErrorLog('WriteOuterForInter 异常：' + GlobalOPCItemIn + ' -> ' + outer + ' . ' + e.Message);
  end;
end;

function TFormMonitor.ErrBeginItemRead(itemid: string): OleVariant;
var
  myValue, myQuality, myTimeStamp: OleVariant;
begin
  try
    ErrBeginOPCItems.item(itemid).Read(1, myValue, myQuality, myTimeStamp);
    if myValue = True then
      begin
        ErrBeginItemRead := 1;
      end
    else if myValue = False then
      begin
        ErrBeginItemRead := 0;
      end
    else
      begin
        ErrBeginItemRead := myValue;
      end;
    except
      on e: Exception do
        WriteMemo('读 PLC ERROR ITEM ' + itemid + ' 异常： ' + e.Message);
      end;
end;

// wirte PLC heart
procedure TFormMonitor.WriteHeart1;
begin
  try
    PLCItemWrite(OPCITEMID_WRITEHEART, 1);
  except
    on e: Exception do
      WriteMemo('WriteHeart1 异常： ' + e.Message);
  end;
end;

procedure TFormMonitor.WriteHeart0;
begin
  try
    PLCItemWrite(OPCITEMID_WRITEHEART, 0);
  except
    on e: Exception do
      WriteMemo('WriteHeart1 异常： ' + e.Message);
 end;
end;

procedure TFormMonitor.WriteDevParam;
var
  i: Integer;
begin
  try
    PLCItemWrite(OPCITEMID_WRITEROUNDMAX, M_MaxRound);
    for i := Low(M_Outer) to High(M_Outer) do
      begin
        if not(M_Outer[i].OPCMAX.IsEmpty) then
          begin
            PLCItemWrite(M_Outer[i].OPCMAX, M_Outer[i].MAX000);
          end;
      end;
    M_DevInit := 1;
  except
    on e: Exception do
      begin
        M_DevInit := 0;
        WriteMemo('WriteDevParam 参数初始化异常： ' + e.Message);
 end;
 end;
end;

procedure TFormMonitor.OPCServer1ServerShutDown(ASender: TObject; const Reason: WideString);
begin
//  showmessage('close');
  if Assigned(OPCServer1) then
    begin
      if Assigned(OPCGroupErrBegin) then
        begin
          OPCServer1.OPCGroups.RemoveAll;
          OPCGroupErrBegin.Free;
          OPCGroupErrBegin := nil;
          OPCGroupMain.Free;
          OPCGroupMain := nil;
          OPCGCarEnter.Free;
          OPCGCarEnter := nil;
          OPCGroupWrite.Free;
          OPCGroupWrite := nil;
        end;
    ErrBeginOPCItems := nil;
    MainOPCItems := nil;
    CarLeaveOPCItems := nil;
    ErrBeginOPCItems := nil;
    WriteOPCItems := nil;
    OPCServer1.Disconnect1;
    OPCServer1.Free;
    OPCServer1 := nil;
//    showmessage('close1');
  end;
end;


//~~~~~~~~~~~~~~~~~~~~~OPC above~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//             TCP server below
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

//delete by dendi in 2016/4/2
//procedure TFormMonitor.MsgAvail(Sender: TRecContextData);
//var
// s: string;
//begin
//   s := Sender.Pop;
//end;

procedure TFormmonitor.IdTCPClient1Connected(Sender: TObject);
begin
  WriteMemo('连接到扫描系统Socket服务端');
end;

procedure TFormmonitor.IdTCPServer1Connect(AContext: TIdContext);
var
  Context: TIdContext;
  i: Integer;
  IP: String;
begin
  //delete and modify  by dendi in 2016/4/2
  AContext.Connection.IOHandler.DefStringEncoding := IndyUTF8Encoding;

//  AContext.Data := TRecContextData.Create;

//  TRecContextData(AContext.Data).OnMsgAvail := MsgAvail;
  IP := AContext.Connection.Socket.Binding.PeerIP;
  WriteMemo(IP + ' 连接');
  LBClientIP.Items.Add(IP);
end;


procedure TFormmonitor.IdTCPServer1Disconnect(AContext: TIdContext);
var
  Context: TIdContext;
  i: Integer;
  IP: String;
begin
  AContext.Data.Free;
  AContext.Data := nil;
  IP := AContext.Connection.Socket.Binding.PeerIP;
  WriteMemo(IP + ' 断开连接');
  i := LBClientIP.Items.IndexOf(IP);
  if i >= 0 then
    begin
      LBClientIP.Items.Delete(i);
    end;
end;

procedure TFormmonitor.IdTCPServer1Exception(AContext: TIdContext;
  AException: Exception);
begin
  AContext.Data.Free;
  AContext.Data := nil;
  WriteMemo('Socket 服务:' + AException.ToString());
end;

procedure TFormmonitor.IdTCPServer1Execute(AContext: TIdContext);
begin
  Application.ProcessMessages;
  CheckMsg(AContext);

  //TRecContextData(AContext.Data).CheckMsg(AContext);
end;

procedure TFormmonitor.IdTCPServer1ListenException(AThread: TIdListenerThread;
  AException: Exception);
begin
  WriteMemo('Socket 监听:' + AException.ToString());
end;

//             TCP server above
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


//create mainline/in/out below
procedure TFormmonitor.CreateMainLine;
var
  i, i1, i2, i3, i4, i5: Integer;
  top0: Integer;
  left0: Integer;
  mod8 : Integer;
  lineCount: Integer;
  posright: Integer;
  posleft: Integer;
  ctop: Integer;
  cleft: Integer;
begin
  i1 := 0;
  i2 := 0;
  i3 := 0;
  i4 := 0;
  i5 := 0;
  posright :=0;
  posleft :=0;
  ctop :=0;
  cleft :=0;
  lineCount := floor((M_Cars - (c_arc * 4)) / 2);
  top0 := 100;
  left0 := (c_carWidth + c_gap) * c_arc;
  SetLength(M_Carry, M_Cars);
  SetLength(M_Carry_Lab, M_Cars);
  for i := low(M_Carry) to high(M_Carry) do
    begin
      M_Carry[i] := TPanel.Create(self);
      M_Carry[i].parent := Panel1;
      M_Carry[i].VerticalAlignment := taAlignTop;
      M_Carry[i].AutoSize := False;
      M_Carry[i].Width := c_carWidth;
      M_Carry[i].Height := c_carHeight;
      M_Carry[i].ParentColor := False;
      M_Carry[i].ParentBackground := False;
//      mod8 := floor(i/8) mod 2;
//      if mod8 = 0 then
//        begin
//          M_Carry[i].Color := clGray;
//        end
//      else
//        begin
//          M_Carry[i].Color := clHighlight;
//        end;
      //M_Carry[i].Caption := (i + 1).ToString();
      //change position of cars

      if 47-i<=0 then
        M_Carry[i].Caption := (47 - i+64).ToString()
      else
        M_Carry[i].Caption := (47 - i).ToString();
      M_Carry[i].Font.Size := 12;

      if (i < lineCount) then
        begin // 上
          M_Carry[i].Top := top0;
          M_Carry[i].Left := i * (c_carWidth + c_gap) + left0;
        end
      else if ((i >= lineCount) and (i < lineCount + c_arc)) then
        begin // 右上弧形
          i1 := i1 + 1;
          M_Carry[i].Top := i1 * floor(c_carHeight / 2 ) + top0;
          M_Carry[i].Left := i * (c_carWidth + c_gap) + left0;
          posright := i * (c_carWidth + c_gap) + left0; // 最右
        end
      else if ((i >= lineCount + c_arc) and (i < lineCount + (c_arc * 2))) then
        begin // 右下弧形
          i1 := i1 + 1;
          M_Carry[i].Top := i1 * floor(c_carHeight / 2 ) + top0 + floor(c_carHeight / 2);
          M_Carry[i].Left := posright - i2 * (c_carWidth + c_gap);
          i2 := i2 + 1;
          ctop := M_Carry[i].Top;
          cleft := M_Carry[i].Left;
        end
      else if ((i >= lineCount + (c_arc * 2)) and (i < lineCount + (c_arc * 2) + lineCount)) then
        begin // 下
          i3 := i3 + 1;
          M_Carry[i].Top := ctop + floor(c_carHeight / 2 );
          M_Carry[i].Left := cleft - i3 * (c_carWidth + c_gap);
          l2top := M_Carry[i].Top;
          l2left := M_Carry[i].Left;
        end
      else if ((i >= lineCount + (c_arc * 2) + lineCount) and (i < lineCount + (c_arc * 3) + lineCount)) then
        begin // 左下弧形
          i4 := i4 + 1;
          M_Carry[i].Top := l2top - i4 * floor(c_carHeight / 2 );
          M_Carry[i].Left := l2left - i4 * (c_carWidth + c_gap);
          posleft := M_Carry[i].Left;
        end
      else
        begin
          i4 := i4 + 1;
          M_Carry[i].Top := l2top - i4 * floor(c_carHeight / 2) - floor(c_carHeight / 2);
          M_Carry[i].Left := posleft + i5 * (c_carWidth + c_gap);
          i5 := i5 + 1;
        end;
  end;

  for i := low(M_Carry_Lab) to high(M_Carry_Lab) do
  begin
    M_Carry_Lab[i] := TLabel.Create(self);
      if 46-i<0 then
        M_Carry_Lab[i].parent := M_Carry[46-i+64]
      else
        M_Carry_Lab[i].parent := M_Carry[46-i];
      M_Carry_Lab[i].Name := 'M_CarLabel' + i.ToString();
      M_Carry_Lab[i].Align := alBottom;
      M_Carry_Lab[i].Caption := '0';
      M_Carry_Lab[i].Font.Color := clYellow;
      M_Carry_Lab[i].Alignment := taCenter;
  end;
end;

procedure TFormMonitor.CreateIn;
var
  i: Integer;
begin
  SetLength(M_In, M_InNum);
  for i := low(M_In) to high(M_In) do
    begin
      M_In[i] := TPanel.Create(self);
      M_In[i].parent := Panel1;
      M_In[i].AutoSize := False;
      M_In[i].Width := c_carWidth;
      M_In[i].Height := c_carHeight;
      M_In[i].ParentColor := False;
      M_In[i].ParentBackground := False;
      M_In[i].Color := clTeal;
      M_In[i].Caption := (i + 1).ToString();
      M_In[i].Font.Size := 12;
      M_In[i].Top := l2top - c_gap - c_InHeight;
      M_In[i].Left := l2left + i * (c_carWidth + c_InGap) + (c_carWidth + c_InGap) * 2;
    end;
end;

procedure TFormMonitor.CreateOut;
var
  i, i1, j: Integer;
  len, lineCount, rpos: Integer;
begin
  i1 := 0;
  rpos:=0;
  len := M_OunNum_usual + M_OunNum_unusual;
  SetLength(M_Out, len);
  SetLength(M_Out_Lab, len);
  lineCount := floor((M_Cars - (c_arc * 4)) / 2);
  j := floor(abs(lineCount - M_OunNum_usual) / 2);
  for i := low(M_Out) to high(M_Out) do
    begin
      M_Out[i] := TPanel.Create(self);
      M_Out[i].parent := Panel1;
      M_Out[i].VerticalAlignment := taAlignTop;
      M_Out[i].AutoSize := False;
      M_Out[i].Width := c_carWidth;
      M_Out[i].Height := c_carHeight;
      M_Out[i].ParentColor := False;
      M_Out[i].ParentBackground := False;
      M_Out[i].Color := clHighLight;
      M_Out[i].Caption := (i + 1).ToString();
      M_Out[i].Font.Size := 12;
      M_Out_Lab[i] := TLabel.Create(self);
      M_Out_Lab[i].parent := M_Out[i];
      M_Out_Lab[i].Align := alBottom;
      M_Out_Lab[i].Caption := '0';
      M_Out_Lab[i].Font.Color := clRed;
      M_Out_Lab[i].Alignment := taCenter;
      if (i < M_OunNum_usual) then
        begin
          M_Out[i].Top := M_Carry[j].Top - c_gap - c_OutHeight;
          M_Out[i].Left := M_Carry[j].Left + i * (c_carWidth + c_OutGap);
          rpos := M_Out[i].Left;
        end
      else
        begin
          M_Out[i].Top := M_Carry[j].Top + c_gap + c_OutHeight;
          M_Out[i].Left := rpos - i1 * (c_carWidth + c_OutGap);
          i1 := i1 + 1;
        end;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~READPLC BELOW~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~READPLC BELOW~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~READPLC BELOW~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

procedure TReadPLC.Execute;
var
  i, heartRate: Integer;
  printInfo: TPrint;
begin
  heartRate := 0;
  while not Terminated do
    begin

  Application.ProcessMessages;
 // 发送心跳
      sleep(50);
      heartRate := heartRate + 1;
      try
        if (heartRate = 5) then
          begin
            heartRate := 0;
            Synchronize(FormMonitor.WriteHeart1);
          end;
        {
        if (heartRate = 100) then
          begin
            heartRate := 0;
            Synchronize(FormMonitor.WriteHeart0);
          end;
          }
      except
        on e: Exception do
          ErrorLog('线程写 PLC 心跳异常： ' + e.Message);
      end;
    // 设备参数
      if (M_DevInit = 0) then
        begin
          try
            Synchronize(FormMonitor.WriteDevParam);
          except
            on e: Exception do
              ErrorLog('线程写 PLC 设备参数异常： ' + e.Message);
          end;
        end;

    // 读主线位置小车编号 出口编号 出口数量 PLC 工作状态
      try
        Synchronize(FormMonitor.ReadMain);
      except
        on e: Exception do
          ErrorLog('线程读 PLC 设备状态异常： ' + e.Message);
      end;
//打印信息
    try
      M_PrintQueue.TrimExcess;
      if M_PrintQueue.Count > 0 then
        begin
//           有打印数据
          printInfo := M_PrintQueue.Dequeue;
          M_PrintQueue.TrimExcess;
          GlobalPrint_pcs := Inttostr(printInfo.Cou);
          GlobalPrint_dest := printInfo.TARNAME;
          GlobalPrint_barcode := printInfo.BarCode;
          GlobalPrint_out := printInfo.OUTCode;
          Synchronize(FormMonitor.PrintLabel);

        end;
      except
        on e: Exception do
          ErrorLog('线程打印信息入队列异常： ' + e.Message);
      end;
 // 刷新页面
      try
        Synchronize(UpdateDEVStatus);
      except
        on e: Exception do
          ErrorLog('线程显示设备在线状态异常： ' + e.Message);
      end;

      try
        Synchronize(FormMonitor.ShowMain);
      except
        on e: Exception do
          ErrorLog('线程显示设备主线状态异常： ' + e.Message);
      end;
    end;
 // sleep(50);
end;

procedure TReadPLC.UpdateDEVStatus;
var
  i: Integer;
begin
// 工作状态
  FormMonitor.LabelState.Caption := M_DevState;
//  showmessage('1');
// 心跳
  R_rate := R_rate + 1;
  if R_rate = 20 then
    begin
      R_rate := 1;
      if FormMonitor.ShapeHeart.Brush.Color = clGreen then
        begin
          FormMonitor.ShapeHeart.Brush.Color := clSilver;
    //      showmessage('111');
        end
      else
        begin
    //      showmessage('222');
          FormMonitor.ShapeHeart.Brush.Color := clGreen;
        end;
    end;
  if (M_Online = 1) then
    begin
      FormMonitor.shapePlcConn.Brush.Color := clGreen;
 //     showmessage('1');
    end
  else
    begin
      FormMonitor.shapePlcConn.Brush.Color := clRed;
  //    showmessage('0');
    end;
end;

procedure TFormMonitor.ReadMain;
var
  i, st1, st2, st3, outGuid: Integer;
  chg, outAction: bool;
  printInfo: TPrint;
  oc, TARCODE, maxseq, pcs, LabBarCode: string;
begin

  for i := Low(M_CarPosi) to High(M_CarPosi) do
    begin
      M_CarPosi[i].CARID := MainItemRead(M_CarPosi[i].OPCCARID);
      M_CarPosi[i].OUTID := MainItemRead(M_CarPosi[i].OPCOUTID);
    end;

  for i := Low(M_Outer) to High(M_Outer) do
    begin
      M_Outer[i].COUNT0 := MainItemRead(M_Outer[i].OPCCOU);
 // 读取出口换包信息
      chg := MainItemRead(M_Outer[i].OPCCHG);
//     chg:=false;
      if chg = True then
        begin
 // 加入打印队列
          printInfo.OUTCode := M_Outer[i].CODE00;
          printInfo.Cou := M_Outer[i].COUNT0;
          printInfo.TARCODE := M_Outer[i].TARCODE;
          printInfo.TARNAME := M_Outer[i].TARNAME;
          oc := M_Outer[i].CODE00;
          if (length(oc) < 2) then
            oc := '0' + oc;
          TARCODE := M_Outer[i].TARCODE;
          while length(TARCODE) < 6 do
            begin
              TARCODE := '0' + TARCODE;
            end;
          pcs := GetPcs(M_Outer[i].CODE00);
          maxseq := GetMaxSeq(M_Outer[i].CODE00);
   // 2 位出口 + 6 位目的地编码（邮编） + 3 位 PCS + 2 位年 + 2 位月 + 2 位日 + 4 位顺序号
          LabBarCode := oc + TARCODE + pcs + Formatdatetime('yymmdd', now) + maxseq;
          printInfo.BarCode := LabBarCode;
          OutPrintUpdate(M_Outer[i].CODE00,LabBarCode);
          M_PrintQueue.Enqueue(printInfo);
          M_PrintQueue.TrimExcess;
          PLCMainItemWrite(M_Outer[i].OPCCHG, 0);
        end;
        // 检测 物件从主线 -> 包装袋
      outAction := MainItemRead(M_Outer[i].OPCOUTBEGIN);
//      outAction :=false;
      if (outAction = True) then
        begin
          outGuid := MainItemRead(M_Outer[i].OPCOUTGUID);
          // 更新数据库对应记录
          OutUpdate(outGuid, M_Outer[i].CODE00);
          // 读取完成
          PLCItemWrite(M_Outer[i].OPCOUTEND, 1);
        end;
    end;

  M_Online := MainItemRead(OPCITEMID_ONLINE);
  st1 := MainItemRead(OPCITEMID_PLCRUN1);
  st2 := MainItemRead(OPCITEMID_PLCRUN2);
  st3 := MainItemRead(OPCITEMID_PLCRUN3);

  M_DevState := '';
  if (st1 = 1) then
    begin
      M_DevState := '正常运行';
    end;
  if (st2 = 1) then
    begin
      M_DevState := '急停';
    end;
  if (st3 = 1) then
    begin
      M_DevState := '报警';
    end;

end;


procedure TFormMonitor.ShowMain;
var
  i,mod8: Integer;
begin
  for i := Low(M_CarPosi) to High(M_CarPosi) do
    begin
      if M_CarPosi[i].OUTID > 0 then
        begin
          M_Carry_Lab[i].Caption := M_CarPosi[i].CARID.ToString() + ':' + M_CarPosi[i].OUTID.ToString();
          M_Carry_Lab[i].Font.Color := clLime;
        end
      else
        begin
          M_Carry_Lab[i].Caption := M_CarPosi[i].CARID.ToString();
          M_Carry_Lab[i].Font.Color := clYellow;
        end;
 // Application.ProcessMessages;

  //dendi add in 2016/4/5

     mod8 := floor((M_CarPosi[i].CARID-1)/8) mod 2;
     if mod8 = 0 then
      begin
        Tpanel(M_Carry_Lab[i].Parent).Color := clGray;
      end
     else
      begin
        Tpanel(M_Carry_Lab[i].Parent).Color := clPurple;
      end;
  end;

  for i := Low(M_Outer) to High(M_Outer) do
    begin
      M_Out_Lab[i].Caption := M_Outer[i].COUNT0.ToString();
 // Application.ProcessMessages;
    end;
end;



//~~~~~~~~~~~~~~~~~~~~~~~READPLC~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~READPLC~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~READPLC~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//~~~~~~~~~~~~~~~~~~~~~~~READPLC~~~~~~~~~~~~~~~~~~~~~~~~~~~~//



//~~~~~~~~~~~~~~~~~~~~~~formclose below~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TFormmonitor.FormClose(Sender: TObject; var Action: TCloseAction);
var
  InnerList: TList;
  i: Integer;
begin
  try
//    showmessage('1');
    READPLC.Terminate;
    READSCAN.Terminate;
    M_PrintQueue.Free;
//    showmessage('2');
    InnerList := IdTCPServer1.Contexts.LockList;
    try
      for i := 0 to InnerList.Count - 1 do
        try
          TIdContext(InnerList.Items[i]).Connection.Disconnect;
        except
        end;
//        showmessage('3');
    finally
      IdTCPServer1.Contexts.UnlockList;
    end;
    IdTCPServer1.Active := False;
//    OPCserver1.Destroy;
    OPCserver1.OnServerShutDown(OPCserver1,'');

    Formmonitor.free;
    Formmonitor:=nil;
//    showmessage('4');

  except
    on e: Exception do
      ErrorLog('FormClose 异常： ' + e.Message);
  end;
end;





//~~~~~~~~~~~~~~~~formshow below~~~~~~~~~~~~~~~
procedure TFormmonitor.FormShow(Sender: TObject);
var
  sqlstr: string;
  i, rc, mainitemcount: Integer;
begin

//get parameter
  try
    try
      sqlstr := 'SELECT * FROM PARAMETER';
      with DM.ADO_MONI_query do
        begin
          if active then
            close;
          SQL.Clear;
          SQL.Add(sqlstr);
          Open;
          M_Cars := FieldByName('CARS').AsInteger;
          M_MaxRound := FieldByName('ROUNDMAX').AsInteger;
          PLCNode := FieldByName('PLCIP').AsString;
  // GlobalCtrlIP := DM.ADOQuery.FieldByName('CTRLIP').AsString;
  // GlobalPort := DM.ADOQuery.FieldByName('PORT00').AsInteger;
  // GlobalPrint_origin := DM.ADOQuery.FieldByName('ADDRESS').AsString;
        end;
    except
       Application.MessageBox('无法连接数据库','提示', MB_OK);
    end;

    try
      sqlstr := 'SELECT COUNT(*) COU FROM PARAMIN';
      with DM.ADO_MONI_query do
        begin
          if active then
            close;
          SQL.Clear;
          SQL.Add(sqlstr);
          Open;
          M_InNum := FieldByName('COU').AsInteger;
          end;
    except
       Application.MessageBox('无法连接数据库','提示', MB_OK);
    end;

    try
      sqlstr := 'select cou1,cou2 from (SELECT 1 id,COUNT(*) COU1 FROM PARAMOUT WHERE TYPE00=''正常出口'') a,(SELECT 1 id,COUNT(*) COU2 FROM PARAMOUT WHERE TYPE00=''异常出口'') b where a.id=b.id';
      with DM.ADO_MONI_query do
        begin
          if active then
            close;
          SQL.Clear;
          SQL.Add(sqlstr);
          Open;
          M_OunNum_usual  := FieldByName('COU1').AsInteger;
          M_OunNum_unusual  := FieldByName('COU2').AsInteger;
          end;
    except
       Application.MessageBox('无法连接数据库','提示', MB_OK);
    end;

  //主线小车
    sqlstr := 'SELECT * FROM POSIINFO ORDER BY POSIID';
    with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        Open;
      M_Cars := RecordCount;
      SetLength(M_CarPosi, M_Cars);
      for i := Low(M_CarPosi) to High(M_CarPosi) do
        begin
          M_CarPosi[i].POSIID := FieldByName('POSIID').AsInteger;
          M_CarPosi[i].GUID00 := 0;
          M_CarPosi[i].CARID := 0;
          M_CarPosi[i].OUTID := 0;
          M_CarPosi[i].OUTCode := '';
          M_CarPosi[i].OPCCARID := trim(FieldByName('OPCCARID').AsString);
          M_CarPosi[i].OPCOUTID := trim(FieldByName('OPCOUTID').AsString);
          M_CarPosi[i].OPCGUID := trim(FieldByName('OPCGUID').AsString);
          Next;
        end;
      end;

  // 出口
   sqlstr := 'SELECT * FROM PARAMOUT ORDER BY ID0000';
   with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        Open;
        rc := RecordCount;
        SetLength(M_Outer, rc);
        for i := Low(M_Outer) to High(M_Outer) do
          begin
            M_Outer[i].AutoID := FieldByName('ID0000').AsInteger;
            M_Outer[i].CODE00 := trim(FieldByName('CODE00').AsString);
            M_Outer[i].MAX000 := FieldByName('MAX000').AsInteger;
            M_Outer[i].TARCODE := trim(FieldByName('TARCODE').AsString);
            M_Outer[i].TARNAME := FieldByName('TARNAME').AsString;
            M_Outer[i].COUNT0 := 0;
            M_Outer[i].OPCMAX := trim(FieldByName('OPCITEMIDMAX').AsString);
            M_Outer[i].OPCCOU := trim(FieldByName('OPCITEMIDCOU').AsString);
            M_Outer[i].OPCCHG := trim(FieldByName('OPCITEMIDCHG').AsString);
            M_Outer[i].OPCOUTBEGIN := trim(FieldByName('OPCITEMBEGIN').AsString);
            M_Outer[i].OPCOUTEND := trim(FieldByName('OPCITEMEND').AsString);
            M_Outer[i].OPCOUTGUID := trim(FieldByName('OPCITEMGUID').AsString);
            M_Outer[i].PRINTIP := trim(FieldByName('PRINTIP').AsString);
            Next;
          end;
      end;


  // 入口
    sqlstr := 'SELECT * FROM PARAMIN ORDER BY CODE00';
  //  if DM.ADOQuery.Active = True then
  //  DM.ADOQuery.Close;
  // DM.ADOQuery.SQL.Clear;
  // DM.ADOQuery.SQL.Add(sqlstring);
  // DM.ADOQuery.Active := True;
    with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        Open;
        rc := RecordCount;
        SetLength(M_Inner, rc);
        SetLength(M_InnerIP, rc);
        for i := Low(M_Inner) to High(M_Inner) do
          begin
            M_Inner[i].AutoID := FieldByName('ID0000').AsInteger;
            M_Inner[i].CODE00 := trim(FieldByName('CODE00').AsString);
            M_Inner[i].IPADDR := trim(FieldByName('IPADDR').AsString);
            M_Inner[i].READPLC := trim(FieldByName('READPLC').AsString);
            M_Inner[i].WRITEPLC := trim(FieldByName('WRITEPLC').AsString);
            M_Inner[i].ATTR00 := FieldByName('ATTR00').AsInteger;
            M_InnerIP[i] := trim(FieldByName('IPADDR').AsString);
            Next;
          end;
      end;
    TArray.Sort<string>(M_InnerIP, TStringComparer.Ordinal);

  //其他OPC赋值

    sqlstr := 'SELECT * FROM OPCITEM WHERE NAME00<>''ERROR''';
    with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        Open;
      end;
    OPCITEMID_CARENTER :=findopcitem('CARENTER');
    OPCITEMID_CARLEAVE :=findopcitem('CARLEAVE');
    OPCITEMID_CURCARID :=findopcitem('CURCARID');
    OPCITEMID_CURGUID :=findopcitem('CURGUID');
    OPCITEMID_CUROUTER :=findopcitem('CUROUTER');
    OPCITEMID_ONLINE :=findopcitem('ONLINE');
    OPCITEMID_PLCRUN1 :=findopcitem('PLCRUN1');
    OPCITEMID_PLCRUN2 :=findopcitem('PLCRUN2');
    OPCITEMID_PLCRUN3 :=findopcitem('PLCRUN3');
    OPCITEMID_WRITEHEART :=findopcitem('WRITEHEART');
    OPCITEMID_WRITEROUNDMAX :=findopcitem('WRITEROUNDMAX');
    OPCITEMID_WRITEGUID :=findopcitem('WRITEGUID');
    OPCITEMID_WRITEOUTID :=findopcitem('WRITEOUTID');
    OPCITEMID_ERRBEGIN :=findopcitem('ERRBEGIN');
    OPCITEMID_ERREND :=findopcitem('ERREND');



  //报警OPC

    sqlstr := 'SELECT * FROM OPCITEM WHERE NAME00=''ERROR''';
    with DM.ADO_MONI_query do
      begin
        if active then
          close;
        SQL.Clear;
        SQL.Add(sqlstr);
        Open;
        rc := RecordCount;
        SetLength(M_Errors, rc);
        for i := Low(M_Errors) to High(M_Errors) do
          begin
            M_Errors[i] := trim(FieldByName('ITEMID').AsString);
            Next;
          end;
      end;
  except
    on e: Exception do
      ErrorLog('监控主页面参数设置异常： ' + e.Message);
  end;

  //create mainline/in/out below
  try
    c_carWidth := floor((Screen.Width-95) * 2 / M_Cars) - c_gap;
    CreateMainLine;
    CreateIn;
    CreateOut;
    panel1.Height:=M_CARRY[49].top+70;
  except
    on e: Exception do
      begin
        ErrorLog('监控主页面创建页面对象异常： ' + e.Message);
        Application.MessageBox(PWideChar('不能创建页面对象'),'提示',MB_OK);
      end;

  end;

//OPC connect
  try
    OPCServer1.Connect1(PLCProgID);
    OPCGroupMain.ConnectTo(OPCServer1.OPCGroups.Add('main'));
    OPCGroupMain.IsActive := True;
    OPCGroupMain.IsSubscribed := False;
    MainOPCItems := OPCGroupMain.OPCItems;

    for i := Low(M_CarPosi) to High(M_CarPosi) do
      begin
        mainitemcount := MainOPCItems.Count;
        if not(M_CarPosi[i].OPCCARID.IsEmpty) then
          begin
            MainOPCItems.AddItem(M_CarPosi[i].OPCCARID, mainitemcount + 1);
          end;
        mainitemcount := MainOPCItems.Count;
        if not(M_CarPosi[i].OPCOUTID.IsEmpty) then
          begin
            MainOPCItems.AddItem(M_CarPosi[i].OPCOUTID, mainitemcount + 1);
          end;
      end;

    for i := Low(M_Outer) to High(M_Outer) do
      begin
        mainitemcount := MainOPCItems.Count;
        if not(M_Outer[i].OPCCOU.IsEmpty) then
          begin
            MainOPCItems.AddItem(M_Outer[i].OPCCOU, mainitemcount + 1);
          end;
      end;

    for i := Low(M_Outer) to High(M_Outer) do
      begin
        mainitemcount := MainOPCItems.Count;
        if not(M_Outer[i].OPCCHG.IsEmpty) then
          begin
            MainOPCItems.AddItem(M_Outer[i].OPCCHG, mainitemcount + 1);
          end;
      end;

    for i := Low(M_Outer) to High(M_Outer) do
      begin
        mainitemcount := MainOPCItems.Count;
        if not(M_Outer[i].OPCOUTBEGIN.IsEmpty) then
          begin
            MainOPCItems.AddItem(M_Outer[i].OPCOUTBEGIN, mainitemcount + 1);
          end;
      end;

    for i := Low(M_Outer) to High(M_Outer) do
      begin
        mainitemcount := MainOPCItems.Count;
        if not(M_Outer[i].OPCOUTGUID.IsEmpty) then
          begin
            MainOPCItems.AddItem(M_Outer[i].OPCOUTGUID, mainitemcount + 1);
          end;
      end;

    for i := Low(M_Errors) to High(M_Errors) do
      begin
        mainitemcount := MainOPCItems.Count;
        if not(M_Errors[i].IsEmpty) then
          begin
            MainOPCItems.AddItem(M_Errors[i], mainitemcount + 1);
          end;
      end;

    mainitemcount := MainOPCItems.Count;
    MainOPCItems.AddItem(OPCITEMID_ONLINE, mainitemcount + 1);
    MainOPCItems.AddItem(OPCITEMID_PLCRUN1, mainitemcount + 2);
    MainOPCItems.AddItem(OPCITEMID_PLCRUN2, mainitemcount + 3);
    MainOPCItems.AddItem(OPCITEMID_PLCRUN3, mainitemcount + 4);
    MainOPCItems.AddItem(OPCITEMID_CURCARID, mainitemcount + 5);
    MainOPCItems.AddItem(OPCITEMID_CURGUID, mainitemcount + 6);
    MainOPCItems.AddItem(OPCITEMID_CUROUTER, mainitemcount + 7);

    // 主线扫码前光电检测
    OPCGCarEnter.ConnectTo(OPCServer1.OPCGroups.Add('carEnter'));
    OPCGCarEnter.IsActive := True;
    OPCGCarEnter.IsSubscribed := True;
    CarEnterOPCItems := OPCGCarEnter.OPCItems;
    CarEnterOPCItems.AddItem(OPCITEMID_CARENTER, 1);


    //ERROR
    OPCGroupErrBegin.ConnectTo(OPCServer1.OPCGroups.Add('errBegin'));
    OPCGroupErrBegin.IsActive := True;
    OPCGroupErrBegin.IsSubscribed := True;
    ErrBeginOPCItems := OPCGroupErrBegin.OPCItems;
    ErrBeginOPCItems.AddItem(OPCITEMID_ERRBEGIN, 1);

    // 写入 PLC
    OPCGroupWrite.ConnectTo(OPCServer1.OPCGroups.Add('writePlc'));
    OPCGroupWrite.IsActive := True;
    OPCGroupWrite.IsSubscribed := False;
    WriteOPCItems := OPCGroupWrite.OPCItems;

    WriteOPCItems.AddItem(OPCITEMID_WRITEHEART, 1);
    WriteOPCItems.AddItem(OPCITEMID_WRITEROUNDMAX, 2);
    WriteOPCItems.AddItem(OPCITEMID_WRITEGUID, 3);
    WriteOPCItems.AddItem(OPCITEMID_WRITEOUTID, 4);
    WriteOPCItems.AddItem(OPCITEMID_ERREND, 5);
    WriteOPCItems.AddItem(OPCITEMID_CARLEAVE, 6);
    WriteOPCItems.AddItem(OPCITEMID_ERRBEGIN, 7);

    for i := Low(M_Inner) to High(M_Inner) do
    begin
      mainitemcount := WriteOPCItems.Count;
      WriteOPCItems.AddItem(M_Inner[i].WRITEPLC, mainitemcount + 1);
    end;

    for i := Low(M_Outer) to High(M_Outer) do
      begin
        mainitemcount := WriteOPCItems.Count;
        WriteOPCItems.AddItem(M_Outer[i].OPCMAX, mainitemcount + 1);
      end;
    for i := Low(M_Outer) to High(M_Outer) do
      begin
        mainitemcount := WriteOPCItems.Count;
        WriteOPCItems.AddItem(M_Outer[i].OPCOUTEND, mainitemcount + 1);
      end;

  except
    on e: Exception do
      ErrorLog('监控主页面 OPC 通讯设置异常： ' + e.Message);
  end;

//socket setup
  IdTCPServer1.DefaultPort := GlobalPort;
  IdTCPServer1.Active := True;
  IdTCPClient1.Host := GlobalScanIP;
  IdTCPClient1.Port := GlobalScanPort;
  ScanConn;
  WriteMemo('Socket 服务启动');
// 打印出口包装单队列
  M_PrintQueue := TQueue<TPrint>.Create();
//创建READPLC 线程
  try
    READPLC := TReadPLC.Create(False { true suspended } );
    READPLC.FreeOnTerminate := True;
  except
    on e: Exception do
      begin
        READPLC := nil;
        ErrorLog('系统错误，无法创建 ReadPLC 线程');
      end;
 // raise EError.Create('系统错误，无法创建 ReadPLC 线程')
  end;
  READPLC.Priority := tpNormal; // tpNormal;tpHighest tpHigher

//创建READSCAN 线程
  try
    READSCAN := TScanTCP.Create(False { true suspended } );
    READSCAN.FreeOnTerminate := True;
  except
    on e: Exception do
      begin
        READSCAN := nil;
        ErrorLog('系统错误，无法创建 ReadSCAN 线程');
      end;
//  raise EError.Create('系统错误，无法创建 ReadPLC 线程')
  end;
  READSCAN.Priority := tpNormal; // tpNormal;tpHighest tpHigher
  // 启动 socket 服务

end;



end.
