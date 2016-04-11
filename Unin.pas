unit Unin;

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
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxLabel, cxCheckBox, dxGDIPlusClasses,
  IdTCPConnection, IdTCPClient, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdTCPServer, IdCmdTCPServer, IdExplicitTLSClientServerBase, IdFTPServer, CPort,
  System.SyncObjs,System.Generics.Collections;


type
  TReadTCP = class(TThread)
  private
    { Private declarations }

  protected
    procedure Execute; override;
end;

type
  TImg = class(TThread)
  private
    { Private declarations }
    next:boolean;
  protected
    procedure Execute; override;
end;

type
  TFormin = class(TForm)
    Panel1: TPanel;
    Btnclose: TButton;
    Panel2: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Btnsure: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    StatusBar1: TStatusBar;
    Image1: TImage;
    Editout: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    Editbarcode: TEdit;
    cxGrid1DBTableView1OUT000: TcxGridDBColumn;
    cxGrid1DBTableView1PROPER: TcxGridDBColumn;
    cxGrid1DBTableView1DESC00: TcxGridDBColumn;
    Panel4: TPanel;
    Panel5: TPanel;
    ComPort1: TComPort;
    IdFTPServer1: TIdFTPServer;
    Labtask: TLabel;
    IdTCPClient1: TIdTCPClient;
    Timer1: TTimer;
    StatusBar2: TStatusBar;
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
    procedure BtnsureClick(Sender: TObject);
    procedure BtnrefreshClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Imagresize;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
    procedure IdFTPServer1ChangeDirectory(ASender: TIdFTPServerContext;
      var VDirectory: string);
    procedure IdFTPServer1DeleteFile(ASender: TIdFTPServerContext;
      const APathName: string);
    procedure IdFTPServer1GetFileSize(ASender: TIdFTPServerContext;
      const AFilename: string; var VFileSize: Int64);
    procedure IdFTPServer1MakeDirectory(ASender: TIdFTPServerContext;
      var VDirectory: string);
    procedure IdFTPServer1RetrieveFile(ASender: TIdFTPServerContext;
      const AFileName: string; var VStream: TStream);
    procedure IdFTPServer1StoreFile(ASender: TIdFTPServerContext;
      const AFileName: string; AAppend: Boolean; var VStream: TStream);
    procedure IdFTPServer1UserLogin(ASender: TIdFTPServerContext;
      const AUsername, APassword: string; var AAuthenticated: Boolean);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure EditoutKeyPress(Sender: TObject; var Key: Char);
    procedure EditbarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);

  private
    { Private declarations }
    READTCP: TReadTCP; // 读 tcp 线程
    imgFTP:Timg;
    function ReplaceChars(APath: String): String;
    function GetSizeOfFile(AFile: String): Integer;
    procedure TcpConn;
    procedure TcpReceiver;
    procedure RefreshImg;
  public
    { Public declarations }
  end;
//procedure Execute123;
var
  Formin: TFormin;
  save:integer;
  imgh:integer;
  imgw:integer;
  imgmove:boolean;
  scale:real;

  AppDir: String;
  HaveLog: Integer;
  tc, td: Integer;
  LockGuid: TCriticalSection;
  LockFile: TCriticalSection;
  I_NoReadGuidQueue: TQueue<string>; // 未扫码识别的 guid
  I_FtpRecFileQueue: TQueue<string>; // ftp 接收的文件名
  I_Guid: string;
  I_Filename: string;
  I_OverTask: Integer; // 完成任务
  I_AllTask: Integer; // 所有任务
  I_TcpRec: string;
  I_OpcItemID: string;     //in opcid for address which uesd to write out code
  beginFlag : Integer = 1;//comport begin

implementation

{$R *.dfm}

uses UnDM, UnMain, Unglobal;


procedure TImg.Execute;
var
  I: Integer;
begin
  while not Terminated do
    begin
      next:=false;
       //检测队列
//      sleep(50);
      try
        if ((I_NoReadGuidQueue.Count > 0) and (I_FtpRecFileQueue.Count > 0)) then
//          if (I_NoReadGuidQueue.Count > 0) then
          begin
          //  sleep(1000);
            LockGuid.Acquire;
            I_Guid := I_NoReadGuidQueue.Dequeue;
//            I_Filename:='123.jpg';
            I_Filename := I_FtpRecFileQueue.Dequeue;
            I_NoReadGuidQueue.TrimExcess;
            I_FtpRecFileQueue.TrimExcess;
            LockGuid.Release;
    //         显示图片
    //        showmessage(I_Filename);
            sleep(800);    //wait for FTP receive file
            Synchronize(FormIn.RefreshImg);
            for I := 0 to 6 do  //display time for one picture
              begin
                if next then
                  break;
                sleep(500);
              end;
          //  sleep(5000);
          end
          else
            sleep(1000);
        except
      on e: exception do
        begin
          ErrorLog('入口队列处理异常： ' + e.Message);
          LockGuid.Release;
        end;

    end;

    end;
end;
{ TReadTCP setting below }
procedure TReadTCP.Execute;
begin
  { Place thread code here }

//  if tc<>0 then
//    sleep(1000);
//     Synchronize(FormIn.Tcpconn);

  while not Terminated do
    begin
      if FormIn.IdTCPClient1.Connected then
        begin
          sleep(100);
//      Application.ProcessMessages;
          if FormIn.IdTCPClient1.IOHandler.Readable(1000) then
            Synchronize(FormIn.TcpReceiver);
        end
      else
        begin
          sleep(10000);
          Synchronize(FormIn.TcpConn);
        end;
//      showmessage('1');
    end;

end;


procedure TFormin.TcpReceiver;
var
  msg,tmpstr,sqlstr:string;
//  c,r:Integer;
  p1,p2:integer;
begin
//  showmessage('2');
//
//  if IdTCPClient1.Connected then
//    begin
//      try
//        if (IdTCPClient1.IOHandler.Readable(1000)) then
//          begin
//            I_TcpRec := IdTCPClient1.IOHandler.ReadLn();
//            showmessage('123');
//          end;
//      except
//        on e: exception do
//          StatusBar1.Panels[2].Text := e.Message;
//      end;
//    end
//  else
//    begin
//      TcpConn;
//    end;


      try
        I_TcpRec := IdTCPClient1.IOHandler.ReadLn();
      except
        on e: exception do
          StatusBar1.Panels[2].Text := e.Message;
      end;

//if (tc=0) AND (I_TcpRec <> '') then
//begin

//  td:=td+1;
//  if td>99 then
//  td:=1;
//  StatusBar1.Panels[0].Text := Inttostr(td);

  if I_TcpRec <> '' then
    begin
      td:=td+1;
      if td>99 then
        td:=1;
      StatusBar1.Panels[0].Text := Inttostr(td);
      try
//        StatusBar1.Panels[2].Text :=I_TcpRec;
        p1 := I_TcpRec.IndexOf('[STX]');
        p2 := I_TcpRec.IndexOf('[ETX]');
        if ((p1 >= 0) and ((p2 - p1) > 5)) then
          begin
            msg := copy(I_TcpRec, p1 + 6, p2 - p1 - 5);
            I_TcpRec := '';
            if UpperCase(msg).StartsWith('NR:') then
   // 入口发送条码 [STX]BC:OPC ITEM ID,条码[ETX]
              begin
              //for test
//                StatusBar1.Panels[1].Text :=msg;
                tmpStr := copy(msg, 4, length(msg) - 3);
                LockGuid.Acquire;
                try
                  I_NoReadGuidQueue.Enqueue(tmpStr);
                  I_NoReadGuidQueue.TrimExcess;
//                  StatusBar1.Panels[2].Text := I_TcpRec;
                  StatusBar1.Panels[2].Text :='[STX]'+msg+'[ETX]' + '(' +
                  Inttostr(I_NoReadGuidQueue.Count) + ')' + ' ,I_Guid=' + I_NoReadGuidQueue.Peek;
                finally
                  LockGuid.Release;
                end;
              end;
            end;
      except
        on e: exception do
           ErrorLog('入口接收数据处理异常： ' + e.Message);
        end;
    end;
//    StatusBar1.Panels[2].Text := I_TcpRec;
//     StatusBar1.Panels[2].Text := Inttostr(I_NoReadGuidQueue.Count);
 // StatusBar1.Panels[2].Text := I_TcpRec + '(' +Inttostr(I_NoReadGuidQueue.Count) + ')' + ' ,I_Guid=' + I_NoReadGuidQueue.Peek;



//end;
end;

procedure TFormin.Timer1Timer(Sender: TObject);
var
  c,r:Integer;
begin
  try
    r := 0;
    // 任务进度显示
    with DM.ADO_THRD_query  do
      begin
        //update by dendi in 2016/4/1
        SQLquery(DM.ADO_THRD_query);
        //close;
        //open;
//        showmessage(c);
        c := FieldByName('cou1').AsInteger;
        if (c <> I_OverTask) then
          begin
            I_OverTask := c;
            r:=1;
          end;
        c := FieldByName('cou2').AsInteger;
        if (c <> I_AllTask) then
          begin
          I_AllTask := c;
          r:=2;
          end;
      end;

    if (r <>0) then
      begin
        Formin.LabTask.Caption := Inttostr(I_OverTask) + '/' + Inttostr(I_AllTask);
      end;
  except
    on e: exception do
      ErrorLog('入口页面显示异常： ' + e.Message);
  end;

end;

procedure TFormin.TcpConn;
begin
  try
    if not IdTCPClient1.Connected then
      begin
        Application.ProcessMessages;
        IdTCPClient1.Connect;
        StatusBar1.Panels[1].Text := 'SOCKET 已连接';
      end;
  except
    on e:exception do
      begin
        tc := tc + 1;
        if tc > 99 then
          tc := 1;
        IdTCPClient1.Disconnect;
        StatusBar1.Panels[1].Text := 'SOCKET 连接...(' + Inttostr(tc) + ')';
        if havelog=0 then
          begin
            havelog:=1;
            ErrorLog('Socket 服务器连接异常： ' + e.Message);
          end;
      end;
  end;
end;
{ TReadTCP setting above}

{ftp and image below}
function Tformin.ReplaceChars(APath: String): String;
var
  s: string;
begin
  s := StringReplace(APath, '/', '\', [rfReplaceAll]);
  s := StringReplace(s, '\\', '\', [rfReplaceAll]);
  Result := s;
end;

function TFormin.GetSizeOfFile(AFile: String): Integer;
var
  FStream: TFileStream;
begin
  Try
    FStream := TFileStream.Create(AFile, fmOpenRead);
    Try
      Result := FStream.Size;
    Finally
      FreeAndNil(FStream);
    End;
  Except
    Result := 0;
  End;
end;


//refreshing image when received new file;
procedure Tformin.RefreshImg;
begin
  try
    image1.Picture.LoadFromFile(I_Filename);
    StatusBar1.Panels[3].Text := '载入图片： ' + I_Filename;

    //set image  size to normal,imgmove must be false add by dendi
    panel5.Align:=alclient;
    image1.Align:=alclient;
    imgmove:=false;
  except
    on e:exception do
      begin
        StatusBar1.Panels[3].Text := '载入图片异常： ' + e.Message;
        ErrorLog('载入图片异常： ' + e.Message);
      end;

  end;
end;

//FTP server setting
 procedure TFormin.IdFTPServer1ChangeDirectory(ASender: TIdFTPServerContext;
  var VDirectory: string);
begin
  ASender.CurrentDir := VDirectory;
end;


procedure TFormin.IdFTPServer1DeleteFile(ASender: TIdFTPServerContext;
  const APathName: string);
begin
  DeleteFile(ReplaceChars(AppDir + ASender.CurrentDir + '\' + APathName));
end;

procedure TFormin.IdFTPServer1GetFileSize(ASender: TIdFTPServerContext;
  const AFilename: string; var VFileSize: Int64);
Var
  LFile: String;
begin
  LFile := ReplaceChars(AppDir + AFileName);
  try
    If FileExists(LFile) then
      VFileSize := GetSizeOfFile(LFile)
    else
      VFileSize := 0;
  except
    VFileSize := 0;
  end;
end;


procedure TFormin.IdFTPServer1MakeDirectory(ASender: TIdFTPServerContext;
  var VDirectory: string);
begin
  if not ForceDirectories(ReplaceChars(AppDir + VDirectory)) then
    begin
      Raise exception.Create('不能创建目录');
    end;
end;



procedure TFormin.IdFTPServer1RetrieveFile(ASender: TIdFTPServerContext;
  const AFileName: string; var VStream: TStream);
begin
  VStream := TFileStream.Create(ReplaceChars(AppDir + AFileName), fmOpenRead);
  Image1.Picture.LoadFromFile(AppDir + AFileName);
end;



procedure TFormin.IdFTPServer1StoreFile(ASender: TIdFTPServerContext;
  const AFileName: string; AAppend: Boolean; var VStream: TStream);
var
  fsize: Int64;
  fn: string;
begin
  fn := ReplaceChars(AppDir + AFileName);
  if not AAppend then
    VStream := TFileStream.Create(fn, fmCreate)
  else
    VStream := TFileStream.Create(fn, fmOpenWrite);
    LockFile.Acquire; { lock out other threads }
  try
    if fn.EndsWith('jpg') then
      begin
        I_FtpRecFileQueue.Enqueue(fn);
        I_FtpRecFileQueue.TrimExcess;
        StatusBar1.Panels[3].Text := '接收文件： ' + fn + '(' +
        Inttostr(I_FtpRecFileQueue.Count) + ')';
      end;
  finally
    LockFile.Release;
  end;
end;


procedure TFormin.IdFTPServer1UserLogin(ASender: TIdFTPServerContext;
  const AUsername, APassword: string; var AAuthenticated: Boolean);
begin
  AAuthenticated := True;
end;




{ftp image above}

{comport below}
procedure TFormin.ComPort1RxChar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  if (beginFlag = 1) then
    begin
      EditBarCode.Text := '';
    end;
    ComPort1.ReadStr(Str, Count);
    beginFlag := 0;
    if (Str.EndsWith(#10)) then
      begin
        beginFlag := 1;
      end;
      EditBarCode.Text := EditBarCode.Text + Str;
end;
{comport above}

{TCP above}
procedure TFormin.IdTCPClient1Connected(Sender: TObject);
begin
  tc := 0;
  StatusBar1.Panels[1].Text := 'SOCKET 已连接';
end;

procedure TFormin.IdTCPClient1Disconnected(Sender: TObject);
begin
  tc := 1;
  StatusBar1.Panels[1].Text := 'SOCKET 未连接';
end;
{TCP below}



procedure TFormin.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//showmessage('test');
//ues win API to move img F012( sc_move(F010) or 2) and low 4bit is inactive
//so F012 =F010(SC_MOVE)
//SC_SIZE
releaseCapture;
panel5.Perform(WM_SYSCOMMAND,$F012,0);
end;

procedure TFormin.Imagresize;
begin
if  not imgmove then
  begin
     //image1.Align:=alcustom;
    scale:=image1.Width / image1.Height ;
    //showmessage(floattostr(scale));
    panel5.Align:=alnone;
    image1.Align:=alnone;
    image1.Width:=Formin.Width-600;
    image1.Height:=cxgrid1.Height;
    image1.Left:=0;
    imgmove:=true;
  end;
end;
procedure TFormin.BtnrefreshClick(Sender: TObject);
begin
//  DM.ADO_OUTA_query.Refresh;
    DM.ADO_OUTA_query.Close;
    DM.ADO_OUTA_query.Open;

    DM.ADO_OUTB_query.Close;
    DM.ADO_OUTB_query.Open;
//  DM.ADO_OUTB_query.Refresh;
end;

procedure TFormin.BtncloseClick(Sender: TObject);
begin
//  Btnsave.Click;
  Formin.close;
end;



procedure TFormin.BtnsureClick(Sender: TObject);
var
  tmp,outcode:string;
begin
//  cxGrid2DBTableView1.DataController.FocusedRecordIndex := 1;
//  cxGrid2DBTableView1.DataController.FocusedRecordIndex := 0;
//image1.Align:=alclient;
//panel5.Align:=alclient;
//image1.Align:=alclient;
//imgmove:=false;
//image1.Picture.LoadFromFile('123.jpg');
  outcode:=trim(EditOut.Text);
  if (I_Guid <> '') and (outcode <> '') then
    begin
      tmp := '[STX]BM:' + I_Guid + ',' + outcode + '[ETX]';
      if IdTCPClient1.Connected then
        begin
          try
            IdTCPClient1.IOHandler.WriteLn(tmp);
            imgFTP.next:=true;
            I_Guid := '';
            I_Filename := '';
            EditBarCode.Text := '';
            EditOut.Text := '';
            StatusBar2.Panels[0].Text := '发送： ' + tmp;
          except
            on e: exception do
              StatusBar2.Panels[1].Text := '发送异常： ' + e.Message;
          end;
        end
    else
      begin
        Application.MessageBox('未连接到服务端', '提示', MB_OK);
        Exit;
      end;
    end
  else
    begin
      if outcode = '' then
        Application.MessageBox('请输入出口 ', '提示', MB_OK)
      else
        Application.MessageBox('未接到服务端出口请求', '提示', MB_OK);
    end;
  EditBarCode.SetFocus;
end;






procedure TFormin.cxGrid1DBTableView1FocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
//  DM.ADO_ACTI_query.Close;
//  DM.ADO_ACTI_query.Parameters.ParamByName('code').Value:=DM.ADO_URGP_query.FieldByName('CODE00').AsString;
  //DM.ADO_ACTI_query.Close;
//  DM.ADO_ACTI_query.Open;
end;

procedure TFormin.cxGrid1DBTableView1FocusedRecordChanged(
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

procedure TFormin.EditbarcodeKeyPress(Sender: TObject; var Key: Char);
var
  s, sqlstr, outcode, tmp: String;
begin
  if Key = #13 then
    begin
      s := trim(EditBarCode.Text);
      Key := #0;

      sqlstr := 'SELECT POUT FROM FJDATA WHERE BARCODE=''' + s + '''';

      with DM.ADO_temp_query do
        begin
         //update by dendi in 2016/4/1
         SQLquery(sqlstr,DM.ADO_temp_query);

         // if Active = True then
         //   close;
         //   SQL.Clear;
         //   SQL.Add(sqlstr);
         //   Active := True;
            outcode := FieldByName('POUT').AsString;
        end;
         //showmessage();
      if (outcode = '0') or (outcode = '') then
        begin
          Application.MessageBox('没找到分配出口 ', '提示', MB_OK);
          Exit;
        end
      else
        begin
          EditOut.Text := outcode;
          if (I_Guid = '') then
            begin
              tmp := '[STX]BC:' + I_OpcItemID + ',' + s + '[ETX]';
            end
          else
            begin
              tmp := '[STX]BM:' + I_Guid + ',' + outcode + '[ETX]';
            end;

      if IdTCPClient1.Connected then
        begin
          try
            IdTCPClient1.IOHandler.WriteLn(tmp);
            imgFTP.next:=true;
            I_Guid := '';
            I_Filename := '';
            EditBarCode.Text := '';
            StatusBar2.Panels[0].Text := '发送： ' + tmp;
          except
            on e: exception do
              StatusBar2.Panels[1].Text := '发送异常： ' + e.Message;
          end;
        end
      else
        begin
          Application.MessageBox('未连接到服务端', '提示', MB_OK);
          Exit;
        end;
    end;
  end;
end;

procedure TFormin.EditoutKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      BtnSure.Click;
    end;
end;

procedure TFormin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//close thread
  try
    READTCP.Terminate;
    IdFTPServer1.Active := False;
    if IdTCPClient1.Connected then
      IdTCPClient1.Disconnect;
      I_NoReadGuidQueue.Free;
      I_FtpRecFileQueue.Free;
      LockGuid.Free;
      LockFile.Free;
  except
    on e:exception do
      ErrorLog('入口操作台关闭异常： ' + e.Message);
  end;
//close comport
  if ComPort1.Connected then
    ComPort1.Close;

//close form
  Formin.Free;
  Formin:=nil;
end;

procedure TFormin.FormCreate(Sender: TObject);
begin
//  DateTimePicker1.Date:=now();
//  DateTimePicker2.Date:=now();
end;

procedure TFormin.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
//  Image1.Align:=alNone;
  Imagresize;
  image1.Height:=trunc(image1.Height*0.97);
  //image1.Width:= trunc(image1.width*0.95);
  image1.Width:= trunc(scale*image1.Height);

  panel5.Height:=image1.Height;
  panel5.width:=image1.width;
end;

procedure TFormin.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
//  Image1.Align:=alNone;
  Imagresize;
  image1.Height:=trunc(image1.Height*1.03092784);
  //image1.Width:= trunc(image1.width*1.0526);
  image1.Width:= trunc(scale*image1.Height);
  panel5.Height:=image1.Height;
  panel5.width:=image1.width;
end;

procedure TFormin.FormShow(Sender: TObject);
var
  sqlstr: string;
begin

//add var scale to zoom picture to fix bug
//by dendi in 2016/4/1


  imgmove:=false;

//var init
  HaveLog := 0;
  I_OverTask := 0;
  I_AllTask := 0;
  td := 0;
  I_Guid := '';
//create section
  LockGuid := TCriticalSection.Create;
  LockFile := TCriticalSection.Create;
  I_NoReadGuidQueue := TQueue<string>.Create();
  I_FtpRecFileQueue := TQueue<string>.Create();

//    imgw:=image1.Width;
//    imgh:=image1.Height;
//    image1.Align:=alnone;
//    image1.Width:=Formin.Width-600;
//    image1.Height:=cxgrid1.Height;
    try
    //update by dendi in 2016/4/1
      SQLquery(DM.ADO_INDA_query);
    //  with DM.ADO_INDA_query do
    //    begin
    //      close;
    //      open;
    //     end;
    except
       Application.MessageBox('无法连接数据库1','提示', MB_OK);
    end;

  sqlstr := 'SELECT WRITEPLC FROM PARAMIN WHERE IPADDR='''+GlobalLocalIP +'''';

  //update by dendi in 2016/4/1
  with DM.ADO_temp_query do
    begin
    //  if active then
    //    close;
   //   SQL.Clear;
   //   SQL.Add(sqlstr);
   //   open;
      SQLquery(sqlstr,DM.ADO_temp_query);
      I_OpcItemID := FieldByName('WRITEPLC').AsString;
    end;

  IdTCPClient1.Host := GlobalCtrlIP;
  IdTCPClient1.Port := GlobalPort;

  try
    tc := 0;

    Application.ProcessMessages;
    IdTCPClient1.Connect;
    StatusBar1.Panels[1].Text := 'SOCKET 已连接';

  except
    on e:exception do
      begin
        tc := 1;
        IdTCPClient1.Disconnect;
        StatusBar1.Panels[1].Text := 'SOCKET 连接...(' + Inttostr(tc) + ')';
        if havelog=0 then
          begin
            havelog:=1;
            ErrorLog('Socket 服务器连接异常： ' + e.Message);
          end;
      end;
  end;

  try
   // READTCP := TReadTCP.Create(False { true suspended } );
    READTCP := TReadTCP.Create(false);
    READTCP.FreeOnTerminate := True;
    ImgFTP:=Timg.Create(false);
    ImgFTP.FreeOnTerminate := True;
  except
    on e: exception do
      begin
        READTCP := nil;
        ImgFTP:=nil;
        ErrorLog('系统异常. 无法创建 ReadTCP 线程: ' + e.Message);
      end;
  end;
  ImgFTP.Priority := tpLowest;
  READTCP.Priority := tpLower; // tpLower； tpNormal;tpHighest tpHigher
  //  READTCP.Priority := tpLowest;
  AppDir := ExtractFilePath(Application.Exename) + 'Img\';
  try
    IdFTPServer1.Active := True;
  except
    on e: exception do
      begin
        Application.MessageBox(PWideChar('ftp 服务启动异常(请检查处理后重启 )： ' + e.Message),'提示', MB_OK);
        Exit;
      end;
  end;

  try
    ComPort1.Open;
  except
    Application.MessageBox(PWideChar('不能打开串口，请检查处理后重新打开应用程序。 '),'提示',MB_OK);
  end;

  EditBarCode.SetFocus;


end;




end.
