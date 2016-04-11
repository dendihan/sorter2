object Formgetdata: TFormgetdata
  Left = 0
  Top = 0
  Caption = #25968#25454#33719#21462
  ClientHeight = 680
  ClientWidth = 882
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
    Left = 8
    Top = 78
    Width = 84
    Height = 33
    Caption = #26085#26399#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 882
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitLeft = 8
    ExplicitTop = 71
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 882
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Caption = #19994#21153#25968#25454
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -47
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Btnget: TButton
    Left = 360
    Top = 71
    Width = 153
    Height = 50
    Caption = #25968#25454#33719#21462
    TabOrder = 2
    OnClick = BtngetClick
  end
  object Btnquery: TButton
    Left = 529
    Top = 71
    Width = 153
    Height = 50
    Caption = #25968#25454#26597#35810
    TabOrder = 3
    OnClick = BtnqueryClick
  end
  object Btnclose: TButton
    Left = 697
    Top = 71
    Width = 153
    Height = 50
    Caption = #39029#38754#20851#38381
    TabOrder = 4
    OnClick = BtncloseClick
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 130
    Width = 882
    Height = 550
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGrid1DBTableView1CustomDrawCell
      DataController.DataSource = DM.DSvfjd
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
        Width = 106
      end
      object cxGrid1DBTableView1BARCODE: TcxGridDBColumn
        Caption = #26465#24418#30721
        DataBinding.FieldName = 'BARCODE'
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
  object DateTimePicker1: TDateTimePicker
    Left = 89
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
end
