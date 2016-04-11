unit UnDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADO_temp_query: TADOQuery;
    ADO_VFJD_query: TADOQuery;
    DSvfjd: TDataSource;
    ADO_VFJD_queryBARCODE: TStringField;
    ADO_VFJD_queryFJDATE: TDateTimeField;
    ADO_VFJD_queryFROMDATE: TDateTimeField;
    ADO_VFJD_queryFROMNAME: TStringField;
    ADO_VFJD_queryFROMADDR: TStringField;
    ADO_VFJD_queryFROMCO: TStringField;
    ADO_VFJD_queryFROMDETAIL: TStringField;
    ADO_VFJD_queryFROMTEL: TStringField;
    ADO_VFJD_queryFROMZIPCODE: TStringField;
    ADO_VFJD_queryTONAME: TStringField;
    ADO_VFJD_queryTOADDR: TStringField;
    ADO_VFJD_queryTOCO: TStringField;
    ADO_VFJD_queryTODETAIL: TStringField;
    ADO_VFJD_queryTOTEL: TStringField;
    ADO_VFJD_queryTOZIPCODE: TStringField;
    ADO_VFJD_queryPNAME: TStringField;
    ADO_VFJD_queryPNUMBER: TIntegerField;
    ADO_VFJD_queryPWEIGHT: TBCDField;
    ADO_VFJD_queryPLENGTH: TBCDField;
    ADO_VFJD_queryPWIDTH: TBCDField;
    ADO_VFJD_queryPHEIGHT: TBCDField;
    ADO_VFJD_queryVOLUME: TBCDField;
    ADO_VFJD_queryPCOST: TBCDField;
    ADO_VFJD_queryGUID: TIntegerField;
    ADO_VFJD_queryPSTATE: TIntegerField;
    ADO_VFJD_queryLabBarCode: TStringField;
    ADO_VFJD_queryCODEIN: TStringField;
    ADO_VFJD_queryUSERCODE: TStringField;
    ADO_VFJD_queryPOUT2: TStringField;
    ADO_VFJD_queryPOUT: TStringField;
    ADO_VFJD_queryUSERNAME: TStringField;
    ADO_VFJD2_query: TADOQuery;
    StringField1: TStringField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    IntegerField1: TIntegerField;
    BCDField1: TBCDField;
    BCDField2: TBCDField;
    BCDField3: TBCDField;
    BCDField4: TBCDField;
    BCDField5: TBCDField;
    BCDField6: TBCDField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    StringField15: TStringField;
    StringField16: TStringField;
    StringField17: TStringField;
    StringField18: TStringField;
    StringField19: TStringField;
    StringField20: TStringField;
    DSvfjd2: TDataSource;
    DScommon: TDataSource;
    ADO_URLG_query: TADOQuery;
    DSuserlog: TDataSource;
    ADO_ERLG_query: TADOQuery;
    DSerrorlog: TDataSource;
    ADO_INST_query: TADOQuery;
    ADO_URGP_query: TADOQuery;
    DSrole: TDataSource;
    ADO_USER_query: TADOQuery;
    DSuser: TDataSource;
    ADO_ACTI_query: TADOQuery;
    DSaction: TDataSource;
    ADO_PROP_query: TADOQuery;
    DSproper: TDataSource;
    ADO_POUT_query: TADOQuery;
    DSout: TDataSource;
    ADO_PAIN_query: TADOQuery;
    DSin: TDataSource;
    ADO_PARA_query: TADOQuery;
    DSparam: TDataSource;
    ADO_OUTA_query: TADOQuery;
    DSouta: TDataSource;
    ADO_OUTB_query: TADOQuery;
    DSoutb: TDataSource;
    ADO_INDA_query: TADOQuery;
    DSindata: TDataSource;
    ADO_THRD_query: TADOQuery;
    ADO_MONI_query: TADOQuery;
    procedure ADO_VFJD_queryPSTATEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure ADO_URGP_queryAfterScroll(DataSet: TDataSet);
    procedure ADO_POUT_queryAfterScroll(DataSet: TDataSet);
    procedure ADO_OUTA_queryAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.ADO_OUTA_queryAfterScroll(DataSet: TDataSet);
begin
  ADO_OUTB_query.Filter:='labbarcode='+''''+ADO_OUTA_query.FieldByName('labbarcode').AsString+'''';
end;

procedure TDM.ADO_POUT_queryAfterScroll(DataSet: TDataSet);
begin
  ADO_PROP_query.Filter:='OUT000='+''''+ADO_POUT_query.FieldByName('CODE00').AsString+'''';
end;

procedure TDM.ADO_URGP_queryAfterScroll(DataSet: TDataSet);
begin
  ADO_ACTI_query.Filter:='CODE00='+''''+ADO_URGP_query.FieldByName('CODE00').AsString+'''';
end;

procedure TDM.ADO_VFJD_queryPSTATEGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  //in DB the value may be 0,1,2 and so on
  //in GRID we want to dispaly string like 'begin' 'end' 'go on'
  // use GETTEST to change display as follow
  // add by dendi 2016/2/1

  if sender.AsInteger=0 then
    text:='未开始'
  else if sender.AsInteger=1 then
    text:='已扫描'
  else if sender.AsInteger=2 then
    text:='已分拣'
  else
    text:='已打印'

end;

end.
