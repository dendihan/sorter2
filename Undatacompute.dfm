object Formdatacompute: TFormdatacompute
  Left = 0
  Top = 0
  Caption = #25968#25454#26597#35810
  ClientHeight = 431
  ClientWidth = 1282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 33
  object Label1: TLabel
    Left = 0
    Top = 79
    Width = 120
    Height = 33
    Caption = #26085#26399' '#20174#65306
  end
  object Label2: TLabel
    Left = 391
    Top = 79
    Width = 28
    Height = 33
    Caption = #21040
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 1282
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1282
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Caption = #32479#35745#26597#35810
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -47
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object DateTimePicker1: TDateTimePicker
    Left = 120
    Top = 71
    Width = 265
    Height = 50
    Date = 42376.463848067130000000
    Time = 42376.463848067130000000
    DateFormat = dfLong
    DoubleBuffered = False
    ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object DateTimePicker2: TDateTimePicker
    Left = 424
    Top = 71
    Width = 265
    Height = 50
    Date = 42376.463848067130000000
    Time = 42376.463848067130000000
    DateFormat = dfLong
    DoubleBuffered = False
    ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
  end
  object Btnquery: TButton
    Left = 705
    Top = 71
    Width = 153
    Height = 50
    Caption = #25968#25454#26597#35810
    TabOrder = 3
    OnClick = BtnqueryClick
  end
  object Btncol: TButton
    Left = 872
    Top = 71
    Width = 153
    Height = 50
    Caption = #33258#23450#20041#21015
    TabOrder = 4
    OnClick = BtncolClick
  end
  object Btnclose: TButton
    Left = 1040
    Top = 71
    Width = 153
    Height = 50
    Caption = #39029#38754#20851#38381
    TabOrder = 5
    OnClick = BtncloseClick
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 130
    Width = 1282
    Height = 301
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DM.DSvfjd2
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1PSTATE: TcxGridDBColumn
        Caption = #29366#24577
        DataBinding.FieldName = 'PSTATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1BARCODE: TcxGridDBColumn
        Caption = #26465#24418#30721
        DataBinding.FieldName = 'BARCODE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1FJDATE: TcxGridDBColumn
        Caption = #20998#25315#26085#26399
        DataBinding.FieldName = 'FJDATE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1FROMDATE: TcxGridDBColumn
        Caption = #23492#20214#26085#26399
        DataBinding.FieldName = 'FROMDATE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1FROMTEL: TcxGridDBColumn
        Caption = #23492#20214#30005#35805
        DataBinding.FieldName = 'FROMTEL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1FROMNAME: TcxGridDBColumn
        Caption = #23492#20214#20154#22995#21517
        DataBinding.FieldName = 'FROMNAME'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1FROMADDR: TcxGridDBColumn
        Caption = #23492#20214#22320#22336
        DataBinding.FieldName = 'FROMADDR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1FROMDETAIL: TcxGridDBColumn
        Caption = #23492#20214#35814#22336
        DataBinding.FieldName = 'FROMDETAIL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1FROMZIPCODE: TcxGridDBColumn
        Caption = #23492#20214#37038#32534
        DataBinding.FieldName = 'FROMZIPCODE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1FROMCO: TcxGridDBColumn
        Caption = #23492#20214#21333#20301
        DataBinding.FieldName = 'FROMCO'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1TONAME: TcxGridDBColumn
        Caption = #25910#20214#20154#22995#21517
        DataBinding.FieldName = 'TONAME'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1TOADDR: TcxGridDBColumn
        Caption = #25910#20214#22320#22336
        DataBinding.FieldName = 'TOADDR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1TOCO: TcxGridDBColumn
        Caption = #25910#20214#21333#20301
        DataBinding.FieldName = 'TOCO'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1TODETAIL: TcxGridDBColumn
        Caption = #25910#20214#35814#32454#22320#22336
        DataBinding.FieldName = 'TODETAIL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1TOTEL: TcxGridDBColumn
        Caption = #25910#20214#20154#30005#35805
        DataBinding.FieldName = 'TOTEL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1TOZIPCODE: TcxGridDBColumn
        Caption = #25910#20214#37038#32534
        DataBinding.FieldName = 'TOZIPCODE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1PNAME: TcxGridDBColumn
        Caption = #29289#21697#21517#31216
        DataBinding.FieldName = 'PNAME'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1PNUMBER: TcxGridDBColumn
        Caption = #25968#37327
        DataBinding.FieldName = 'PNUMBER'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1PWEIGHT: TcxGridDBColumn
        Caption = #37325#37327
        DataBinding.FieldName = 'PWEIGHT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1PLENGTH: TcxGridDBColumn
        Caption = #38271
        DataBinding.FieldName = 'PLENGTH'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1PWIDTH: TcxGridDBColumn
        Caption = #23485
        DataBinding.FieldName = 'PWIDTH'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1PHEIGHT: TcxGridDBColumn
        Caption = #39640
        DataBinding.FieldName = 'PHEIGHT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1VOLUME: TcxGridDBColumn
        Caption = #20307#31215
        DataBinding.FieldName = 'VOLUME'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1PCOST: TcxGridDBColumn
        Caption = #36164#36153
        DataBinding.FieldName = 'PCOST'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1GUID: TcxGridDBColumn
        Caption = #21807#19968#35782#21035#30721
        DataBinding.FieldName = 'GUID'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1LabBarCode: TcxGridDBColumn
        Caption = #26631#31614#26465#30721
        DataBinding.FieldName = 'LabBarCode'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1CODEIN: TcxGridDBColumn
        Caption = #20837#21475#32534#21495
        DataBinding.FieldName = 'CODEIN'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1USERCODE: TcxGridDBColumn
        Caption = #25805#20316#21592#20195#30721
        DataBinding.FieldName = 'USERCODE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1POUT2: TcxGridDBColumn
        Caption = #23454#38469#20986#21475
        DataBinding.FieldName = 'POUT2'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1POUT: TcxGridDBColumn
        Caption = #29702#35770#20986#21475
        DataBinding.FieldName = 'POUT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1USERNAME: TcxGridDBColumn
        Caption = #25805#20316#21592#22995#21517
        DataBinding.FieldName = 'USERNAME'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
end
