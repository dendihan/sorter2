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
  TCarPosi = record // С��λ����Ϣ
  POSIID: Integer; // λ�ñ�� 1 - 64
  GUID00: Integer; // �� PLC ��ȡ��Ψһ��
  CARID: Integer; // С�����
  OUTID: Integer;
  OUTCode: string; // ���ڱ��
  OPCCARID: string; // OPC ITEM ID
  OPCOUTID: string; // OPC ITEM ID
  OPCGUID: string; // OPC ITEM ID
end;
//out
type
  TOuter = record // ������Ϣ
  AutoID: Integer; // �Զ����
  CODE00: string; // ����
  MAX000: Integer; // ����
  COUNT0: Integer; // ����
  TARCODE: string; // Ŀ�ĵش���
  TARNAME: string; // Ŀ�ĵ�����
  OPCMAX: string; // OPC ITEM ID ��������
  OPCCOU: string; // OPC ITEM ID �ѳ��������
  OPCCHG: string; // OPC ITEM ID ���ڸ�����װ��
  OPCOUTBEGIN: string; // OPC ITEM ID ���ڶ�����ɣ����Զ�ȡΨһ��
  OPCOUTEND: string; // OPC ITEM ID �Ѷ�ȡΨһ��
  OPCOUTGUID: string; // OPC ITEM ID Ψһ��
  PRINTIP: string; // ���ڴ�ӡ�� PC IP
end;

//in
type
  TInner = record // ������Ϣ
  AutoID: Integer; // �Զ����
  CODE00: string; // ����
  IPADDR: string; // ip ��ַ
  READPLC: string; // OPC �� item id
  WRITEPLC: string; // OPC д ITEM ID
  ATTR00: Integer; // ����
end;

type
  TPrint = record // ���ڴ�ӡ������Ϣ
  OUTCode: string; // ���ڱ��
  Cou: Integer; // ����������
  TARCODE: string; // Ŀ�ĵش���
  TARNAME: string; // Ŀ�ĵ�����
  BarCode: string; // ����
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
     function GetMaxSeq(OUTCode: string): string; // ��ȡ�������˳���
     function GetPcs(OUTCode: string): string; // ��ȡ���ڰ�װ�����������
  end;
const
  c_carHeight = 35; // С���߶�
  c_arc = 8; // �뻡�� С������
  c_gap = 5; // С����϶
  c_InHeight = 35; // ��ڸ߶�
  c_InGap = 5; // ��ڼ�϶
  c_OutHeight = 35; // ���ڸ߶�
  c_OutGap = 5; // ���ڼ�϶
  PLCProgID = 'KEPware.KEPServerEx.V4';
var
  Formmonitor: TFormmonitor;
  Scanread:string;

  c_carWidth: Integer; // С�����
  M_DevInit: Integer = 0; // �豸��ʼ�������Ƿ����´� 1 �� 0 ��
  M_Cars: Integer; // С������
  M_MaxRound: Integer; // �������תȦ��
  PLCNode: string; // PLC IP ��ַ
  M_InNum: Integer; // ��ڸ���
  M_OunNum_usual: Integer; // �������ڸ���
  M_OunNum_unusual: Integer; // �쳣���ڸ���

  M_Carry: array of TPanel; // С��
  M_In: array of TPanel; // ���
  M_Out: array of TPanel; // ����
  M_Carry_Lab: array of TLabel; // С����ǩ
  M_Out_Lab: array of TLabel; // ���ڱ�ǩ

  M_CarPosi: array of TCarPosi; // λ����Ϣ
  M_Outer: array of TOuter; // ������Ϣ
  M_Inner: array of TInner; // �����Ϣ
  M_Errors: array of string; // plc ����
  M_InnerIP: System.TArray<string>; // ��� IP

  M_Online: Integer; // �豸����״̬
  M_DevState: string; // �豸����״̬

  M_CurCarID: Integer; // ������С�����
  M_CurGuid: Integer; // ������Ψһ��
  M_CurOuter: Integer; // ������С�������Ӧ����

  l2top: Integer;
  l2left: Integer;
  R_rate: Integer;
//  LockReadEnd: TCriticalSection;
  M_PrintQueue: TQueue<TPrint>; // ��ӡ����

 //OPC items
  MainOPCItems: OPCItems;
  CarEnterOPCItems: OPCItems;
  CarLeaveOPCItems: OPCItems;
  ErrBeginOPCItems: OPCItems;
  WriteOPCItems: OPCItems;

  OPCITEMID_CARENTER: string; // ����С�������翪��
  OPCITEMID_CARLEAVE: string; // ����С���뿪��翪��
  OPCITEMID_CURCARID: string; // ���߹��λ�õ�ǰС�����
  OPCITEMID_CURGUID: string; // ���߹��λ�õ�ǰΨһ���
  OPCITEMID_CUROUTER: string; // ���߹��λ�õ�ǰΨһ���
  OPCITEMID_ONLINE: string; // PLC ����
  OPCITEMID_PLCRUN1: string; // PLC ����״̬ ����
  OPCITEMID_PLCRUN2: string; // PLC ����״̬ ��ͣ
  OPCITEMID_PLCRUN3: string; // PLC ����״̬ �쳣
  OPCITEMID_WRITEHEART: string; // ����д��
  OPCITEMID_WRITEROUNDMAX: string; // תȦ�����
  OPCITEMID_WRITEGUID: string; // ����ɨ���Ψһ��
  OPCITEMID_WRITEOUTID: string; // ����ɨ������ڱ��
  OPCITEMID_ERRBEGIN: string; // ���Կ�ʼ��ȡ������Ϣ
  OPCITEMID_ERREND: string; // ������Ϣ��ȡ���

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
    writememo('������ڰ�װ����ǩ��' + GlobalPrint_barcode);
    RecordLog('������ڰ�װ����ǩ��' + GlobalPrint_barcode);
  except
    on e: Exception do
      Application.MessageBox(pwidechar('��ӡ����' + e.Message), '��ʾ', MB_OK);
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
      WriteMemo('OutUpdate �쳣�� ' + e.Message);
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
      WriteMemo('OutPrintUpdate �쳣�� ' + e.Message);
  end;
end;

function TFormMonitor.GetMaxSeq(OUTCode: string): string; // ��ȡ�������˳���
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
      WriteMemo('GetMaxSeq �쳣�� ' + e.Message);
  end;
end;

function TFormMonitor.GetPcs(OUTCode: string): string; // ��ȡ���ڰ�װ�����������
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
      WriteMemo('GetPcs �쳣�� ' + e.Message);
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
  // û���յ����룬 ����Ϣ����ڼ���� [STX]NR:GUID[ETX]
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
          WriteMemo('WriteDevParam ������ʼ���쳣��' + e.Message);
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
    // Guid ��δ��¼�����ݿ� �� ��ȡ����  �·�PLC  �������ݿ�
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

      WriteMemo('����=' + GlobalBarCode + ', С����=' + GlobalIndex + ', ����=' + outer);

      GlobalIndex := '0';
      outer := '0';
      GlobalBarCode := '';
    end;
  except
    on e: Exception do
      ErrorLog('UpdateDBByBarCode �쳣��' + sqlstr + '�� ' + e.Message);
  end;
end;

procedure TFormMonitor.WriteOuterForMain;
begin
  if ((GlobalGuid <> '') and (GlobalOuter <> '')) then
  begin
    try
      PLCItemWrite(OPCITEMID_WRITEGUID, GlobalGuid);
      PLCItemWrite(OPCITEMID_WRITEOUTID, GlobalOuter);
      WriteMemo('����̨ɨ����дPLC��Ψһ�룺' + GlobalGuid + ' PLC(OPC):' + OPCITEMID_WRITEGUID + '; ���ڣ�' + GlobalOuter + ' PLC(OPC):' + OPCITEMID_WRITEOUTID);
      GlobalGuid := '';
      GlobalOuter := '';
    except
      on e: Exception do
        ErrorLog('WriteOuterForMain �쳣��' + GlobalGuid + ' -> ' + GlobalOuter + ' . ' + e.Message);
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
      WriteMemo('�� PLC ' + itemid + ' �쳣: ' + e.Message);
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
// ��ʾ��ҳ��
  // ������������Ϣ�� [STX]���룬���ȣ���ȣ��߶ȣ����[ETX]    [STX]NoRead[ETX]
  // ��ڷ�����Ϣ��   [STX]BC:����[ETX]
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
            if ind >= 0 then // ������ δ��ȡ����
              begin
                GlobalBarCode := '';
                GlobalLength := '';
                GlobalWidth := '';
                GlobalHeight := '';
                GlobalVolume := '';
                GlobalIsBarCodeRead := 0;
                //WriteMemo('û��ȡ������');

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

        // ���ܳ��ֶ������ ����1/����2/����3...
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

                  WriteMemo('Index=' + GlobalIndex + ',����=' + GlobalBarCode + ',����=' + GlobalLength + ',���=' + GlobalWidth +
                  ',�߶�=' + GlobalHeight + ',���=' + GlobalVolume);
                  //notify!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  UpdateDBByBarCode;
              except
                on e: Exception do
                  ErrorLog('���������ݽ�����' + msg + ' -> ' + e.Message);
              end;
      // UpdateDBByBarCode;
            end;
        end;
      except
        on e: exception do
          ErrorLog('��ؽ������ݴ����쳣�� ' + e.Message);
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
      WriteMemo('PLCMainItemWrite �쳣�� (' + itemid + ')' + e.Message);
  end;
end;

procedure TFormmonitor.PLCItemWrite(itemid: string; val: OleVariant);
begin
  try
    WriteOPCItems.item(itemid).Write(val);
  except
    on e: Exception do
      WriteMemo('PLCItemWrite �쳣�� (' + itemid + ')' + e.Message);
  end;
end;

procedure TFormMonitor.WriteOuterForInter;
var
  outer, sqlstr: string;
begin
  // �������ɨ��д���ڴ��뵽PLC
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
      WriteMemo('����̨ɨ����дPLC�����ڣ�' + outer + ' PLC(OPC):' + GlobalOPCItemIn);
    end;
  except
    on e: Exception do
      ErrorLog('WriteOuterForInter �쳣��' + GlobalOPCItemIn + ' -> ' + outer + ' . ' + e.Message);
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
        WriteMemo('�� PLC ERROR ITEM ' + itemid + ' �쳣�� ' + e.Message);
      end;
end;

// wirte PLC heart
procedure TFormMonitor.WriteHeart1;
begin
  try
    PLCItemWrite(OPCITEMID_WRITEHEART, 1);
  except
    on e: Exception do
      WriteMemo('WriteHeart1 �쳣�� ' + e.Message);
  end;
end;

procedure TFormMonitor.WriteHeart0;
begin
  try
    PLCItemWrite(OPCITEMID_WRITEHEART, 0);
  except
    on e: Exception do
      WriteMemo('WriteHeart1 �쳣�� ' + e.Message);
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
        WriteMemo('WriteDevParam ������ʼ���쳣�� ' + e.Message);
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
  WriteMemo('���ӵ�ɨ��ϵͳSocket�����');
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
  WriteMemo(IP + ' ����');
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
  WriteMemo(IP + ' �Ͽ�����');
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
  WriteMemo('Socket ����:' + AException.ToString());
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
  WriteMemo('Socket ����:' + AException.ToString());
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
        begin // ��
          M_Carry[i].Top := top0;
          M_Carry[i].Left := i * (c_carWidth + c_gap) + left0;
        end
      else if ((i >= lineCount) and (i < lineCount + c_arc)) then
        begin // ���ϻ���
          i1 := i1 + 1;
          M_Carry[i].Top := i1 * floor(c_carHeight / 2 ) + top0;
          M_Carry[i].Left := i * (c_carWidth + c_gap) + left0;
          posright := i * (c_carWidth + c_gap) + left0; // ����
        end
      else if ((i >= lineCount + c_arc) and (i < lineCount + (c_arc * 2))) then
        begin // ���»���
          i1 := i1 + 1;
          M_Carry[i].Top := i1 * floor(c_carHeight / 2 ) + top0 + floor(c_carHeight / 2);
          M_Carry[i].Left := posright - i2 * (c_carWidth + c_gap);
          i2 := i2 + 1;
          ctop := M_Carry[i].Top;
          cleft := M_Carry[i].Left;
        end
      else if ((i >= lineCount + (c_arc * 2)) and (i < lineCount + (c_arc * 2) + lineCount)) then
        begin // ��
          i3 := i3 + 1;
          M_Carry[i].Top := ctop + floor(c_carHeight / 2 );
          M_Carry[i].Left := cleft - i3 * (c_carWidth + c_gap);
          l2top := M_Carry[i].Top;
          l2left := M_Carry[i].Left;
        end
      else if ((i >= lineCount + (c_arc * 2) + lineCount) and (i < lineCount + (c_arc * 3) + lineCount)) then
        begin // ���»���
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
 // ��������
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
          ErrorLog('�߳�д PLC �����쳣�� ' + e.Message);
      end;
    // �豸����
      if (M_DevInit = 0) then
        begin
          try
            Synchronize(FormMonitor.WriteDevParam);
          except
            on e: Exception do
              ErrorLog('�߳�д PLC �豸�����쳣�� ' + e.Message);
          end;
        end;

    // ������λ��С����� ���ڱ�� �������� PLC ����״̬
      try
        Synchronize(FormMonitor.ReadMain);
      except
        on e: Exception do
          ErrorLog('�̶߳� PLC �豸״̬�쳣�� ' + e.Message);
      end;
//��ӡ��Ϣ
    try
      M_PrintQueue.TrimExcess;
      if M_PrintQueue.Count > 0 then
        begin
//           �д�ӡ����
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
          ErrorLog('�̴߳�ӡ��Ϣ������쳣�� ' + e.Message);
      end;
 // ˢ��ҳ��
      try
        Synchronize(UpdateDEVStatus);
      except
        on e: Exception do
          ErrorLog('�߳���ʾ�豸����״̬�쳣�� ' + e.Message);
      end;

      try
        Synchronize(FormMonitor.ShowMain);
      except
        on e: Exception do
          ErrorLog('�߳���ʾ�豸����״̬�쳣�� ' + e.Message);
      end;
    end;
 // sleep(50);
end;

procedure TReadPLC.UpdateDEVStatus;
var
  i: Integer;
begin
// ����״̬
  FormMonitor.LabelState.Caption := M_DevState;
//  showmessage('1');
// ����
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
 // ��ȡ���ڻ�����Ϣ
      chg := MainItemRead(M_Outer[i].OPCCHG);
//     chg:=false;
      if chg = True then
        begin
 // �����ӡ����
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
   // 2 λ���� + 6 λĿ�ĵر��루�ʱࣩ + 3 λ PCS + 2 λ�� + 2 λ�� + 2 λ�� + 4 λ˳���
          LabBarCode := oc + TARCODE + pcs + Formatdatetime('yymmdd', now) + maxseq;
          printInfo.BarCode := LabBarCode;
          OutPrintUpdate(M_Outer[i].CODE00,LabBarCode);
          M_PrintQueue.Enqueue(printInfo);
          M_PrintQueue.TrimExcess;
          PLCMainItemWrite(M_Outer[i].OPCCHG, 0);
        end;
        // ��� ��������� -> ��װ��
      outAction := MainItemRead(M_Outer[i].OPCOUTBEGIN);
//      outAction :=false;
      if (outAction = True) then
        begin
          outGuid := MainItemRead(M_Outer[i].OPCOUTGUID);
          // �������ݿ��Ӧ��¼
          OutUpdate(outGuid, M_Outer[i].CODE00);
          // ��ȡ���
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
      M_DevState := '��������';
    end;
  if (st2 = 1) then
    begin
      M_DevState := '��ͣ';
    end;
  if (st3 = 1) then
    begin
      M_DevState := '����';
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
      ErrorLog('FormClose �쳣�� ' + e.Message);
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
       Application.MessageBox('�޷��������ݿ�','��ʾ', MB_OK);
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
       Application.MessageBox('�޷��������ݿ�','��ʾ', MB_OK);
    end;

    try
      sqlstr := 'select cou1,cou2 from (SELECT 1 id,COUNT(*) COU1 FROM PARAMOUT WHERE TYPE00=''��������'') a,(SELECT 1 id,COUNT(*) COU2 FROM PARAMOUT WHERE TYPE00=''�쳣����'') b where a.id=b.id';
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
       Application.MessageBox('�޷��������ݿ�','��ʾ', MB_OK);
    end;

  //����С��
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

  // ����
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


  // ���
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

  //����OPC��ֵ

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



  //����OPC

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
      ErrorLog('�����ҳ����������쳣�� ' + e.Message);
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
        ErrorLog('�����ҳ�洴��ҳ������쳣�� ' + e.Message);
        Application.MessageBox(PWideChar('���ܴ���ҳ�����'),'��ʾ',MB_OK);
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

    // ����ɨ��ǰ�����
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

    // д�� PLC
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
      ErrorLog('�����ҳ�� OPC ͨѶ�����쳣�� ' + e.Message);
  end;

//socket setup
  IdTCPServer1.DefaultPort := GlobalPort;
  IdTCPServer1.Active := True;
  IdTCPClient1.Host := GlobalScanIP;
  IdTCPClient1.Port := GlobalScanPort;
  ScanConn;
  WriteMemo('Socket ��������');
// ��ӡ���ڰ�װ������
  M_PrintQueue := TQueue<TPrint>.Create();
//����READPLC �߳�
  try
    READPLC := TReadPLC.Create(False { true suspended } );
    READPLC.FreeOnTerminate := True;
  except
    on e: Exception do
      begin
        READPLC := nil;
        ErrorLog('ϵͳ�����޷����� ReadPLC �߳�');
      end;
 // raise EError.Create('ϵͳ�����޷����� ReadPLC �߳�')
  end;
  READPLC.Priority := tpNormal; // tpNormal;tpHighest tpHigher

//����READSCAN �߳�
  try
    READSCAN := TScanTCP.Create(False { true suspended } );
    READSCAN.FreeOnTerminate := True;
  except
    on e: Exception do
      begin
        READSCAN := nil;
        ErrorLog('ϵͳ�����޷����� ReadSCAN �߳�');
      end;
//  raise EError.Create('ϵͳ�����޷����� ReadPLC �߳�')
  end;
  READSCAN.Priority := tpNormal; // tpNormal;tpHighest tpHigher
  // ���� socket ����

end;



end.
