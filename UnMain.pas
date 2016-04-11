unit UnMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, IdComponent, IdIPWatch,
  IdBaseComponent, IdAntiFreezeBase, Vcl.IdAntiFreeze, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, shellapi, WinSkinData, Vcl.ToolWin,
  Vcl.ExtCtrls, dxGDIPlusClasses,Data.DB, Data.Win.ADODB;

type
  TFormMain = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    ImageList1: TImageList;
    IdAntiFreeze1: TIdAntiFreeze;
    IdIPWatch1: TIdIPWatch;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    SkinData1: TSkinData;
    Actgetdata: TAction;
    N5: TMenuItem;
    Actmonitor: TAction;
    Actin: TAction;
    Actout: TAction;
    Actquery: TAction;
    Actevent: TAction;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    Actalert: TAction;
    Actrole: TAction;
    Actuser: TAction;
    Actpermission: TAction;
    Actparam: TAction;
    Actproper: TAction;
    Acthelp: TAction;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    Imagebg: TImage;
    procedure ActgetdataExecute(Sender: TObject);
    procedure ActmonitorExecute(Sender: TObject);
    procedure ActinExecute(Sender: TObject);
    procedure ActoutExecute(Sender: TObject);
    procedure ActqueryExecute(Sender: TObject);
    procedure ActeventExecute(Sender: TObject);
    procedure ActalertExecute(Sender: TObject);
    procedure ActroleExecute(Sender: TObject);
    procedure ActuserExecute(Sender: TObject);
    procedure ActpermissionExecute(Sender: TObject);
    procedure ActparamExecute(Sender: TObject);
    procedure ActproperExecute(Sender: TObject);
    procedure ActhelpExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure enableaction;

  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses Unglobal, UnDM, Unlogin, Ungetdata, Ungetdata2, Undatacompute, Unuserlog,
  Unerrorlog, Unrole, Unuser, Unpermission, Unproper, Unparam, Unout, Unin,
  Unmonitor;

//------------------showaction below------------
//check whcih action is enable in DB
//use actionlist to manage
procedure TFormMain.enableaction;
var
  group:string;
  i: Integer;
  sqlstr:string;
begin
    group:=DM.ADO_temp_query.FieldByName('GROUP0').AsString;
//    group:='SYS';
//    showmessage(inttostr(DM.ADOQuery1.RecordCount));
    try
    with DM.ADO_temp_query do
      begin
        sqlstr:=format('select * from GROUPACT where CODE00=''%s''',[group]);
        SQLquery(sqlstr,DM.ADO_temp_query);
        //close;
        //sql.Clear;
        //sql.Add('select * from GROUPACT where CODE00=:group');
        //Parameters.ParamByName('group').Value:=group;
        //open;
      end;
    except
      Application.MessageBox('�޷��������ݿ��������','��ʾ', MB_OK);
    end;

//    showmessage(inttostr(DM.ADOQuery1.RecordCount));

    for i := 0 to actionlist1.ActionCount-1 do
      begin
        TAction( actionlist1.Actions[i]).enabled:=false;

        if DM.ADO_temp_query.Locate('ACTNAME',TAction( actionlist1.Actions[i]).Name,[locaseinsensitive])=true  then
          begin
             if DM.ADO_temp_query.FieldByName('CHOOSE').AsInteger=1 then
              begin
                TAction( actionlist1.Actions[i]).enabled:=true;
              end;
          end;
      end;
end;


procedure TFormMain.ActqueryExecute(Sender: TObject);
begin
  RecordLog('�� ����ͳ�� ҳ��');
  OpenForm(TFormdatacompute, Formdatacompute);
end;

procedure TFormMain.ActalertExecute(Sender: TObject);
begin
  RecordLog('�鿴������Ϣ');
  OpenForm(TFormerrorlog, Formerrorlog);
end;

procedure TFormMain.ActgetdataExecute(Sender: TObject);
begin
  RecordLog('�� ���ݻ�ȡ ҳ��');
  //OpenForm(TFormgetdata, Formgetdata);
  OpenForm(TFormgetdata2, Formgetdata2);
  //if not assigned(Form1) then
  //    Application.CreateForm(TForm1, Form1)
  //  else
  //    Form1.Show;
end;

procedure TFormMain.ActhelpExecute(Sender: TObject);
begin
  RecordLog('�鿴ά��ָ��');
  try
    ShellExecute(application.Handle,nil,'�����Զ����ּ���Ϣϵͳʹ��˵����.chm',nil,nil,sw_shownormal);
  except
    Application.MessageBox('�޷��򿪰����ĵ����ļ����ڱ�ʹ�ã�','��ʾ', MB_OK);
  end;
end;

procedure TFormMain.ActinExecute(Sender: TObject);
begin
  RecordLog('�� ��ڲ��� ҳ��');
  OpenForm(TFormin, Formin);
end;

procedure TFormMain.ActuserExecute(Sender: TObject);
begin
  RecordLog('�� �û����� ҳ��');
  OpenForm(TFormuser, Formuser);
end;

procedure TFormMain.ActeventExecute(Sender: TObject);
begin
  RecordLog('�鿴�¼���־');
  OpenForm(TFormuserlog, Formuserlog);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if assigned(Formmonitor) then
    Formmonitor.Close;

end;

procedure TFormMain.FormShow(Sender: TObject);
var
  TextFileVar:Textfile;
  sqlstr:string;
begin
  //XML file path
  GlobalXMLFile:='XML\FJDATA.XML';
  GloballocalIP:=IdIPWatch1.LocalIP;
  //get connect string for SQL
  try
    AssignFile(TextFileVar,'Para.ini');
    Reset(TextFileVar);
    Readln(TextFileVar,connstr);
  finally
    CloseFile(TextFileVar);
  end;

  try
    DM.ADOConnection1.ConnectionString:=connstr;
    DM.ADOConnection1.Open;
    //DM.ADOQuery1.Open;
//    DM.ADO_VFJD_query.Open;
  except
    Application.MessageBox('�޷��������ݿ��������','��ʾ', MB_OK);
  end;
  //login form
  Application.CreateForm(Tformlogin,formlogin);
  formlogin.ShowModal;
  formlogin.Free;
  formlogin:=nil;

  if loginpass then
    begin
      enableaction;
      RecordLog('�û���¼');
  //use statusbar to display IP,USER and date by dendi
      statusbar1.Panels[1].Text:=GloballocalIP;
      statusbar1.Panels[3].Text:=Globaluser;
      statusbar1.Panels[5].Text:=Datetimetostr(now());
      imagebg.Picture.LoadFromFile('bg.jpg'); //loading bcakground image
      try
        with DM.ADO_temp_query do
          begin
            sqlstr:='select * from PARAMETER';
            SQLquery(sqlstr,DM.ADO_temp_query);
            //close;
            //sql.Clear;
            //sql.Add('select * from PARAMETER');
            //open;
            GlobalCtrlIP := FieldByName('CTRLIP').AsString;
            GlobalPort := FieldByName('PORT00').AsInteger;
            GlobalScanIP := FieldByName('BARCODEIP').AsString;;
            GlobalScanPort := FieldByName('BARCODEPORT').AsInteger;
            GlobalPrint_origin:=FieldByName('ADDRESS').AsString;;
          end;
      except
        Application.MessageBox('�޷��������ݿ��������','��ʾ', MB_OK);
    end;
    end;




end;

procedure TFormMain.N4Click(Sender: TObject);
begin
  RecordLog('�û��˳�');
  Formmain.Close;
  //if assigned(Formmonitor) then
  //  Formmonitor.Close;
 //application.Terminate;
end;

procedure TFormMain.ActmonitorExecute(Sender: TObject);
begin
  RecordLog('�� �ּ��� ҳ��');
  OpenForm(TFormmonitor, Formmonitor);
end;

procedure TFormMain.ActoutExecute(Sender: TObject);
begin
  RecordLog('�� ���ڹ��� ҳ��');
  OpenForm(TFormout, Formout);
end;

procedure TFormMain.ActparamExecute(Sender: TObject);
begin
  RecordLog('�� �������� ҳ��');
  OpenForm(TFormparam, Formparam);
end;

procedure TFormMain.ActpermissionExecute(Sender: TObject);
begin
  RecordLog('�� Ȩ�޹��� ҳ��');
  OpenForm(TFormpermission, Formpermission);
end;

procedure TFormMain.ActproperExecute(Sender: TObject);
begin
  RecordLog('�� �������� ҳ��');
  OpenForm(TFormproper, Formproper);
end;

procedure TFormMain.ActroleExecute(Sender: TObject);
begin
  RecordLog('�� ��ɫ���� ҳ��');
  OpenForm(TFormrole, Formrole);
end;

end.
