unit Unglobal;

interface
uses
  SyncObjs,Vcl.Forms,IdComponent,System.Classes, DB, SysUtils,
  Windows, winsock, IdGlobal, Generics.Collections, WinSpool,
  Data.Win.ADODB,IdContext,IdSync;


  function RecordLog(loginfo: string):Integer;
  function ErrorLog(loginfo: string):Integer;
  function OpenForm(Formclass:TComponentClass;var Form):Integer;
  function SQLquery(sqlstr: string;ADOQuery: TADOQuery):Integer;overload;
  function SQLquery(ADOQuery: TADOQuery):Integer;overload;
  function SQLexec(sqlstr: string;ADOQuery: TADOQuery):Integer;
  function WriteRawStringToPrinter(PrinterName: String; S: String) : integer;
  function PrtChnStr(x, y: Integer; fontname: ansistring; height, xmf, ymf: Integer; chnstr: ansistring): ansistring;
  function MakeZPLCode(code128, dest, pcs, origin: ansistring): ansistring;
  function GETFONTHEX(chnstr: ansistring; fontname: ansistring; orient: Integer; height: Integer; width: Integer;
  bold: Integer; italic: Integer; hexbuf: ansistring): Integer; stdcall; external 'fnthex32.dll';
  procedure CheckMsg(AContext: TIdContext);
  procedure CheckForMsg(S: string);
  procedure MainShow;

var
  Globaluser:string;
  Globaluserid:string;
  connstr:string;
  GlobalXMLFile:string;
  GloballocalIP:string;
  GlobalCtrlIP:string;
  GlobalBarCode :string;
  GlobalLength :string;
  GlobalWidth :string;
  GlobalHeight :string;
  GlobalVolume :string;
  Globalindex :string;
  GlobalBarCodeIn :string;
  GlobalOPCItemIn :string;
  GlobalGuid :string;
  GlobalOuter :string;
  GlobalRec :string;
  GlobalScanIP :string;
  GlobalPrint_origin:string;
  GlobalPrint_pcs :string;
  GlobalPrint_dest :string;
  GlobalPrint_barcode :string;
  GlobalPrint_out :string;
  GlobalPrint_ip: string;
  GlobalPrint_name: string = 'ZDesigner ZM400 300 dpi (ZPL)';
  GlobalScanPort :integer;
  GlobalIsBarCodeRead :integer;
  GlobalPort:integer;
  Encoding: TEncoding;

implementation

uses UnDM, Unmonitor;



function RecordLog(loginfo: string):Integer;
var
  sqlstr:string;
begin
  sqlstr:=format('insert into USERLOG(USER00,DATE00,OPERAT) values(''%s'',''%s'',''%s'')',[Globaluser,datetimetostr(now()),loginfo]);
  SQLexec(sqlstr,DM.ADO_temp_query);
  //with DM.ADO_temp_query do
  //    begin
  //      close;
  //      sql.Clear;
  //      sql.Add('insert into USERLOG(USER00,DATE00,OPERAT) values(:user,:date,:operat)');
  //      Parameters.ParamByName('user').Value:=Globaluser;
  //      Parameters.ParamByName('date').Value:=now();
  //      Parameters.ParamByName('operat').Value:=loginfo;
  //      ExecSQL;
  //    end;
end;
function ErrorLog(loginfo: string):Integer;
var
  sqlstr:string;
begin

  sqlstr:=format('insert into PCALARMS(FROM00,AlarmTime,AlarmText) values(''%s'',''%s'',''%s'')',[GloballocalIP,datetimetostr(now()),loginfo]);
  SQLexec(sqlstr,DM.ADO_temp_query);

end;

function OpenForm(Formclass:TComponentClass;var Form):Integer;
begin
  try
    if not assigned(Tform(Form)) then
      Application.CreateForm(Formclass, Form)
    else
      Tform(Form).Show;
      result := 1;
  except
    result := 0;
  end;
end;

function SQLquery(ADOQuery: TADOQuery):Integer;overload;
begin
  try
    if  ADOQuery.Active = True then
      ADOQuery.Close;
    ADOQuery.open;
  except
    result := 0;
  end;
end;

function SQLquery(sqlstr: string;ADOQuery: TADOQuery):Integer;overload;
begin
  try
    if  ADOQuery.Active = True then
      ADOQuery.Close;
    ADOQuery.sql.Clear;
    ADOQuery.sql.Add(sqlstr);
    ADOQuery.open;
  except
    result := 0;
  end;
end;

function SQLexec(sqlstr: string;ADOQuery: TADOQuery):Integer;
begin
  try
    if  ADOQuery.Active = True then
      ADOQuery.Close;
    ADOQuery.sql.Clear;
    ADOQuery.sql.Add(sqlstr);
    ADOQuery.ExecSQL;
  except
    result := 0;
  end;
end;

//---------------------printer-------------------------
function WriteRawStringToPrinter(PrinterName: String; S: String) : integer;
var
  Handle: THandle;
  n: DWORD;
  DocInfo1: TDocInfo1;
  PS: ansistring;
begin
  PS := S;
  if not OpenPrinter(PChar(PrinterName), Handle, nil) then
    begin
      Result := -1;
    end;
  with DocInfo1 do
    begin
      pDocName := PChar('PrintLabel');
      pOutputFile := nil;
      pDataType := 'RAW';
    end;
  StartDocPrinter(Handle, 1, @DocInfo1);
  StartPagePrinter(Handle);
  WritePrinter(Handle, PAnsiChar(PS), Length(PS), n);
  EndPagePrinter(Handle);
  EndDocPrinter(Handle);
  ClosePrinter(Handle);
  Result := 0;
end;
// use GETFONTHEX in 'fnthex32.dll' to print chinese
function PrtChnStr(x, y: Integer; fontname: ansistring; height, xmf, ymf: Integer; chnstr: ansistring): ansistring;
var
  ret: ansistring;
  count: Integer;
  buf: ansistring;
//  dataname: ansistring;
begin
//  dataname:='OUTSTR01';
  result := '';
  if chnstr <> '' then
  begin
    setlength(buf, 21 * 1024);//must be allocate first add by dendi
    count := GETFONTHEX(chnstr, fontname,0, height, 0, 1, 0, buf);
    //orient=0 height=height width=0 bold=1 italic=0 buf=buf
    if count > 0 then //count>0 means success
    begin
      ret := Copy(buf, 1, count);
      result := ret + '^FO' + inttostr(x) + ',' + inttostr(y) + '^XGOUTSTR01,' + inttostr(xmf) + ',' +
        inttostr(ymf) + '^FS';
    end;
  end;
end;

function MakeZPLCode(code128, dest, pcs, origin: ansistring): ansistring;
var
  prtstr, tempstr, code: ansistring;
  fontname: ansistring;
  fontsize1, fontsize2: Integer;
begin
  // 字体
  fontname := '黑体';
  fontsize1 := 22;
  fontsize2 := 45;
  // 128码
  prtstr := '^XA^LL540^PW1080^IA6^XZ^FS^XA^FS^MD10^BY3,3^LH20,23^FS';
      // ^XA^LL540^PW1080^IA6^XZ setting printer
  tempstr := '^FO400,50^BC,150^FD';
  prtstr := prtstr + tempstr;
  tempstr := code128 + '^FS';
  prtstr := prtstr + tempstr;

  tempstr := '^FO400,280^BC,150^FD';
  prtstr := prtstr + tempstr;
  tempstr := code128 + '^FS';
  prtstr := prtstr + tempstr;

  prtstr := prtstr + PrtChnStr(50, 50, fontname, fontsize1, 1, 2, '目的地');
  prtstr := prtstr + PrtChnStr(50, 120, fontname, fontsize1, 1, 2, 'Destination');
  prtstr := prtstr + PrtChnStr(180, 50, fontname, fontsize2, 1, 2, dest);

  prtstr := prtstr + PrtChnStr(50, 280, fontname, fontsize1, 1, 2, '件数');
  prtstr := prtstr + PrtChnStr(50, 320, fontname, fontsize1, 1, 2, 'Pcs');
  prtstr := prtstr + PrtChnStr(180, 280, fontname, fontsize2, 1, 2, pcs);

  prtstr := prtstr + PrtChnStr(50, 400, fontname, fontsize1, 1, 2, '始发地');
  prtstr := prtstr + PrtChnStr(50, 450, fontname, fontsize1, 1, 2, 'Origin');
  prtstr := prtstr + PrtChnStr(180, 400, fontname, fontsize2, 1, 2, origin);

  tempstr := '^PQ1^FS'; // 打印1份
  prtstr := prtstr + tempstr;

  tempstr := '^PRC^FS^XZ^FS^XA^EG^XZ'; // 打印结束
  prtstr := prtstr + tempstr;

  result := prtstr;
end;
//---------------------TCPserver-------------------------
procedure CheckForMsg(S: string);
var
  sCommand, msg, tmpStr: string;
  p1, p2, p3: Integer;
begin

  if S<>'' then
  begin
    sCommand := S;
    GlobalRec := '接收：' + sCommand;
     //TIdSync.SynchronizeMethod(MainShow);
    MainShow;
    // 控制器发送信息： [STX]条码，长度，宽度，高度，体积[ETX]    [STX]NoRead[ETX]
    // 入口发送信息：   [STX]BC:条码[ETX]
    p1 := sCommand.IndexOf('[STX]');
    p2 := sCommand.IndexOf('[ETX]');
    if ((p1 > 0) and ((p2 - p1) > 5)) then
    begin
      msg := copy(sCommand, p1 + 6, p2 - p1 - 5);
      if UpperCase(msg) = 'NOREAD' then // 控制器 未读取条码
      begin
        {GlobalBarCode := '';
        GlobalLength := '';
        GlobalWidth := '';
        GlobalHeight := '';
        GlobalVolume := '';
        GlobalIsBarCodeRead := 0;

        sleep(GlobalDelayTime);
        TIdSync.SynchronizeMethod(FrmMonitor.BarCodeNoReadNotifyInner);
        }
      end
      else if UpperCase(msg).StartsWith('BC:') then // 入口发送条码  [STX]BC:OPC ITEM ID,条码[ETX]
      begin
        tmpStr := Copy(msg,4,length(msg)-3);
        try
          p3 := tmpStr.IndexOf(',');
          GlobalOPCItemIn := copy(tmpStr, 0, p3);
          GlobalBarCodeIn := copy(tmpStr, p3 + 2, Length(tmpStr) - p3);

          TIdSync.SynchronizeMethod(FormMonitor.WriteOuterForInter);
          //TIdSync.SynchronizeMethod(FormMonitor.WriteMemo('1234'));
        except
          on e: exception do
            ErrorLog('入口数据解析：' + msg + ' -> ' + e.Message);
        end;
      end
      else if UpperCase(msg).StartsWith('BM:') then // 主线未识别，入口补输入，发送  [STX]BM:唯一码,出口编码[ETX]
      begin
        tmpStr := Copy(msg,4,length(msg)-3);
        try
          p3 := tmpStr.IndexOf(',');
          GlobalGuid := copy(tmpStr, 0, p3);
          GlobalOuter := copy(tmpStr, p3 + 2, Length(tmpStr) - p3);

          TIdSync.SynchronizeMethod(FormMonitor.WriteOuterForMain);
        except
          on e: exception do
            ErrorLog('条码未识别，补录入数据解析：' + msg + ' -> ' + e.Message);
        end;
      end
      else // 控制器 读取条码 等
      begin
        {GlobalBarCode := '';
        GlobalLength := '';
        GlobalWidth := '';
        GlobalHeight := '';
        GlobalVolume := '';
        GlobalIsBarCodeRead := 1;

        try
          p3 := msg.IndexOf(',');
          GlobalIndex := copy(msg, 0, p3);
          tmpStr := copy(msg, p3 + 2, Length(msg) - p3);

          p3 := tmpStr.IndexOf(',');
          GlobalBarCode := copy(tmpStr, 0, p3);
          tmpStr := copy(tmpStr, p3 + 2, Length(tmpStr) - p3);

          p3 := tmpStr.IndexOf(',');
          GlobalLength := copy(tmpStr, 0, p3);
          tmpStr := copy(tmpStr, p3 + 2, Length(tmpStr) - p3);

          p3 := tmpStr.IndexOf(',');
          GlobalWidth := copy(tmpStr, 0, p3);
          tmpStr := copy(tmpStr, p3 + 2, Length(tmpStr) - p3);

          p3 := tmpStr.IndexOf(',');
          GlobalHeight := copy(tmpStr, 0, p3);
          GlobalVolume := copy(tmpStr, p3 + 2, Length(tmpStr) - p3);
        except
          on e: exception do
            ErrorLog('控制器数据解析：' + msg + ' -> ' + e.Message);
        end;

        TIdSync.SynchronizeMethod(FrmMonitor.UpdateDBByBarCode);
        }
      end;

    end;
  end;
end;

procedure CheckMsg(AContext: TIdContext);
var
  S, Swp, IP: string;
  i: Integer;
begin
  //dendi update for TCPserver receive data
  //1 check for buffer
  //2 check for data on source
  //3 check for dis connect
  try
  if AContext.Connection.IOHandler.InputBufferIsEmpty then
  begin
    if not AContext.Connection.IOHandler.CheckForDataOnSource(100) then Exit;
      AContext.Connection.IOHandler.CheckForDisconnect;
  end;
  S := Trim(AContext.Connection.IOHandler.ReadLn);
  IP := AContext.Connection.Socket.Binding.PeerIP;
  S := IP + ',' + S;
  CheckForMsg(S);
  finally
    //pass
  end;



//  try
//    AContext.Connection.IOHandler.CheckForDisconnect(True, True);
//    i := AContext.Connection.IOHandler.RecvBufferSize;
//    if i >= 1 then
//    begin
//      IP := AContext.Connection.Socket.Binding.PeerIP;
//      S := AContext.Connection.IOHandler.ReadLn();
//      S := IP + ',' + S;
//      CheckForMsg(S);
//    end;

//  finally

//  end;
end;

procedure MainShow;
begin
  // 显示到页面
  FormMonitor.WriteMemo(GlobalRec);
 //Synchronize(FormMonitor.WriteMemo(GlobalRec));
  //TIdSync.SynchronizeMethod(FormMonitor.WriteMemo(GlobalRec));
  //TIdSync.SynchronizeMethod(FormMonitor.WriteOuterForInter);
end;


end.
