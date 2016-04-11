object DM: TDM
  OldCreateOrder = False
  Height = 441
  Width = 665
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User' +
      ' ID=sa;Initial Catalog=yprproj;Data Source=YPR-PC\SQLExpress;Use' +
      ' Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Wo' +
      'rkstation ID=YPR-PC;Use Encryption for Data=False;Tag with colum' +
      'n collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 80
    Top = 40
  end
  object ADO_temp_query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from USERS')
    Left = 80
    Top = 96
  end
  object ADO_VFJD_query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from V_FJDATA')
    Left = 72
    Top = 168
    object ADO_VFJD_queryBARCODE: TStringField
      FieldName = 'BARCODE'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryFJDATE: TDateTimeField
      FieldName = 'FJDATE'
      ReadOnly = True
    end
    object ADO_VFJD_queryFROMDATE: TDateTimeField
      FieldName = 'FROMDATE'
      ReadOnly = True
    end
    object ADO_VFJD_queryFROMNAME: TStringField
      FieldName = 'FROMNAME'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryFROMADDR: TStringField
      FieldName = 'FROMADDR'
      ReadOnly = True
      Size = 256
    end
    object ADO_VFJD_queryFROMCO: TStringField
      FieldName = 'FROMCO'
      ReadOnly = True
      Size = 256
    end
    object ADO_VFJD_queryFROMDETAIL: TStringField
      FieldName = 'FROMDETAIL'
      ReadOnly = True
      Size = 256
    end
    object ADO_VFJD_queryFROMTEL: TStringField
      FieldName = 'FROMTEL'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryFROMZIPCODE: TStringField
      FieldName = 'FROMZIPCODE'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryTONAME: TStringField
      FieldName = 'TONAME'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryTOADDR: TStringField
      FieldName = 'TOADDR'
      ReadOnly = True
      Size = 256
    end
    object ADO_VFJD_queryTOCO: TStringField
      FieldName = 'TOCO'
      ReadOnly = True
      Size = 256
    end
    object ADO_VFJD_queryTODETAIL: TStringField
      FieldName = 'TODETAIL'
      ReadOnly = True
      Size = 256
    end
    object ADO_VFJD_queryTOTEL: TStringField
      FieldName = 'TOTEL'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryTOZIPCODE: TStringField
      FieldName = 'TOZIPCODE'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryPNAME: TStringField
      FieldName = 'PNAME'
      ReadOnly = True
      Size = 128
    end
    object ADO_VFJD_queryPNUMBER: TIntegerField
      FieldName = 'PNUMBER'
      ReadOnly = True
    end
    object ADO_VFJD_queryPWEIGHT: TBCDField
      FieldName = 'PWEIGHT'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object ADO_VFJD_queryPLENGTH: TBCDField
      FieldName = 'PLENGTH'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object ADO_VFJD_queryPWIDTH: TBCDField
      FieldName = 'PWIDTH'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object ADO_VFJD_queryPHEIGHT: TBCDField
      FieldName = 'PHEIGHT'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object ADO_VFJD_queryVOLUME: TBCDField
      FieldName = 'VOLUME'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object ADO_VFJD_queryPCOST: TBCDField
      FieldName = 'PCOST'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object ADO_VFJD_queryGUID: TIntegerField
      FieldName = 'GUID'
      ReadOnly = True
    end
    object ADO_VFJD_queryPSTATE: TIntegerField
      FieldName = 'PSTATE'
      ReadOnly = True
      OnGetText = ADO_VFJD_queryPSTATEGetText
    end
    object ADO_VFJD_queryLabBarCode: TStringField
      FieldName = 'LabBarCode'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryCODEIN: TStringField
      FieldName = 'CODEIN'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryUSERCODE: TStringField
      FieldName = 'USERCODE'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryPOUT2: TStringField
      FieldName = 'POUT2'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryPOUT: TStringField
      FieldName = 'POUT'
      ReadOnly = True
      Size = 32
    end
    object ADO_VFJD_queryUSERNAME: TStringField
      FieldName = 'USERNAME'
      Size = 64
    end
  end
  object DSvfjd: TDataSource
    DataSet = ADO_VFJD_query
    Left = 176
    Top = 168
  end
  object ADO_VFJD2_query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from V_FJDATA')
    Left = 72
    Top = 232
    object StringField1: TStringField
      FieldName = 'BARCODE'
      ReadOnly = True
      Size = 32
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'FJDATE'
      ReadOnly = True
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'FROMDATE'
      ReadOnly = True
    end
    object StringField2: TStringField
      FieldName = 'FROMNAME'
      ReadOnly = True
      Size = 32
    end
    object StringField3: TStringField
      FieldName = 'FROMADDR'
      ReadOnly = True
      Size = 256
    end
    object StringField4: TStringField
      FieldName = 'FROMCO'
      ReadOnly = True
      Size = 256
    end
    object StringField5: TStringField
      FieldName = 'FROMDETAIL'
      ReadOnly = True
      Size = 256
    end
    object StringField6: TStringField
      FieldName = 'FROMTEL'
      ReadOnly = True
      Size = 32
    end
    object StringField7: TStringField
      FieldName = 'FROMZIPCODE'
      ReadOnly = True
      Size = 32
    end
    object StringField8: TStringField
      FieldName = 'TONAME'
      ReadOnly = True
      Size = 32
    end
    object StringField9: TStringField
      FieldName = 'TOADDR'
      ReadOnly = True
      Size = 256
    end
    object StringField10: TStringField
      FieldName = 'TOCO'
      ReadOnly = True
      Size = 256
    end
    object StringField11: TStringField
      FieldName = 'TODETAIL'
      ReadOnly = True
      Size = 256
    end
    object StringField12: TStringField
      FieldName = 'TOTEL'
      ReadOnly = True
      Size = 32
    end
    object StringField13: TStringField
      FieldName = 'TOZIPCODE'
      ReadOnly = True
      Size = 32
    end
    object StringField14: TStringField
      FieldName = 'PNAME'
      ReadOnly = True
      Size = 128
    end
    object IntegerField1: TIntegerField
      FieldName = 'PNUMBER'
      ReadOnly = True
    end
    object BCDField1: TBCDField
      FieldName = 'PWEIGHT'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object BCDField2: TBCDField
      FieldName = 'PLENGTH'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object BCDField3: TBCDField
      FieldName = 'PWIDTH'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object BCDField4: TBCDField
      FieldName = 'PHEIGHT'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object BCDField5: TBCDField
      FieldName = 'VOLUME'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object BCDField6: TBCDField
      FieldName = 'PCOST'
      ReadOnly = True
      Precision = 8
      Size = 2
    end
    object IntegerField2: TIntegerField
      FieldName = 'GUID'
      ReadOnly = True
    end
    object IntegerField3: TIntegerField
      FieldName = 'PSTATE'
      ReadOnly = True
      OnGetText = ADO_VFJD_queryPSTATEGetText
    end
    object StringField15: TStringField
      FieldName = 'LabBarCode'
      ReadOnly = True
      Size = 32
    end
    object StringField16: TStringField
      FieldName = 'CODEIN'
      ReadOnly = True
      Size = 32
    end
    object StringField17: TStringField
      FieldName = 'USERCODE'
      ReadOnly = True
      Size = 32
    end
    object StringField18: TStringField
      FieldName = 'POUT2'
      ReadOnly = True
      Size = 32
    end
    object StringField19: TStringField
      FieldName = 'POUT'
      ReadOnly = True
      Size = 32
    end
    object StringField20: TStringField
      FieldName = 'USERNAME'
      Size = 64
    end
  end
  object DSvfjd2: TDataSource
    DataSet = ADO_VFJD2_query
    Left = 168
    Top = 232
  end
  object DScommon: TDataSource
    DataSet = ADO_temp_query
    Left = 176
    Top = 96
  end
  object ADO_URLG_query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from USERLOG')
    Left = 72
    Top = 296
  end
  object DSuserlog: TDataSource
    DataSet = ADO_URLG_query
    Left = 168
    Top = 296
  end
  object ADO_ERLG_query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from VALARMS')
    Left = 72
    Top = 352
  end
  object DSerrorlog: TDataSource
    DataSet = ADO_ERLG_query
    Left = 168
    Top = 360
  end
  object ADO_INST_query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from V_FJDATA')
    Left = 176
    Top = 40
  end
  object ADO_URGP_query: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterScroll = ADO_URGP_queryAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select * from USERGROUPS')
    Left = 280
    Top = 40
  end
  object DSrole: TDataSource
    DataSet = ADO_URGP_query
    Left = 376
    Top = 40
  end
  object ADO_USER_query: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 280
    Top = 96
  end
  object DSuser: TDataSource
    DataSet = ADO_USER_query
    Left = 376
    Top = 96
  end
  object ADO_ACTI_query: TADOQuery
    Connection = ADOConnection1
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      'select * from GROUPACT')
    Left = 280
    Top = 152
  end
  object DSaction: TDataSource
    DataSet = ADO_ACTI_query
    Left = 368
    Top = 152
  end
  object ADO_PROP_query: TADOQuery
    Connection = ADOConnection1
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      'select * from OUTPROPER')
    Left = 272
    Top = 224
  end
  object DSproper: TDataSource
    DataSet = ADO_PROP_query
    Left = 368
    Top = 224
  end
  object ADO_POUT_query: TADOQuery
    Connection = ADOConnection1
    AfterScroll = ADO_POUT_queryAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select * from PARAMOUT')
    Left = 272
    Top = 280
  end
  object DSout: TDataSource
    DataSet = ADO_POUT_query
    Left = 368
    Top = 280
  end
  object ADO_PAIN_query: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'select * from PARAMIN')
    Left = 272
    Top = 344
  end
  object DSin: TDataSource
    DataSet = ADO_PAIN_query
    Left = 360
    Top = 344
  end
  object ADO_PARA_query: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'select * from PARAMETER')
    Left = 480
    Top = 40
  end
  object DSparam: TDataSource
    DataSet = ADO_PARA_query
    Left = 576
    Top = 40
  end
  object ADO_OUTA_query: TADOQuery
    Connection = ADOConnection1
    AfterScroll = ADO_OUTA_queryAfterScroll
    Parameters = <>
    SQL.Strings = (
      
        'select distinct POUT2,labbarcode from V_FJDATA where POUT2 is no' +
        't null and LabBarCode is not null and PSTATE<3')
    Left = 480
    Top = 96
  end
  object DSouta: TDataSource
    DataSet = ADO_OUTA_query
    Left = 576
    Top = 96
  end
  object ADO_OUTB_query: TADOQuery
    Connection = ADOConnection1
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      'select * from V_FJDATA where PSTATE<3')
    Left = 480
    Top = 152
  end
  object DSoutb: TDataSource
    DataSet = ADO_OUTB_query
    Left = 576
    Top = 152
  end
  object ADO_INDA_query: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'select * from OUTPROPER')
    Left = 480
    Top = 216
  end
  object DSindata: TDataSource
    DataSet = ADO_INDA_query
    Left = 576
    Top = 216
  end
  object ADO_THRD_query: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      
        'select cou1,cou2 from (SELECT '#39'1'#39' id,count(BARCODE) cou1 FROM FJ' +
        'DATA where PSTATE>1) a,(SELECT '#39'1'#39' id,count(BARCODE) cou2 FROM F' +
        'JDATA) b where a.id=b.id')
    Left = 472
    Top = 280
  end
  object ADO_MONI_query: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'select * from PARAMETER')
    Left = 472
    Top = 336
  end
end
