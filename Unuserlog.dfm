object Formuserlog: TFormuserlog
  Left = 0
  Top = 0
  Caption = #20107#20214#26085#24535
  ClientHeight = 439
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
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1282
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Caption = #20107#20214#26085#24535
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
    Left = 703
    Top = 71
    Width = 153
    Height = 50
    Caption = #25968#25454#26597#35810
    TabOrder = 3
    OnClick = BtnqueryClick
  end
  object Btnclose: TButton
    Left = 872
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
    Width = 1282
    Height = 309
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
      DataController.DataSource = DM.DSuserlog
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1ID0000: TcxGridDBColumn
        Caption = #32534#21495
        DataBinding.FieldName = 'ID0000'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 100
      end
      object cxGrid1DBTableView1USER00: TcxGridDBColumn
        Caption = #29992#25143
        DataBinding.FieldName = 'USER00'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 100
      end
      object cxGrid1DBTableView1DATE00: TcxGridDBColumn
        Caption = #26102#38388
        DataBinding.FieldName = 'DATE00'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 225
      end
      object cxGrid1DBTableView1OPERAT: TcxGridDBColumn
        Caption = #25805#20316
        DataBinding.FieldName = 'OPERAT'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 433
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
end
