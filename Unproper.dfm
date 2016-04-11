object Formproper: TFormproper
  Left = 0
  Top = 0
  Caption = #20986#21475#29305#24449#30721
  ClientHeight = 485
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
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 1282
    Height = 90
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 62
      Width = 92
      Height = 28
      Caption = #20986#21475#21015#34920
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 800
      Top = 62
      Width = 115
      Height = 28
      Caption = #29305#24449#30721#21015#34920
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1282
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Caption = #20986#21475#29305#24449#30721
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -47
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Btnadd: TButton
    Left = 8
    Top = 71
    Width = 153
    Height = 50
    Caption = #28155#21152#29305#24449#30721
    TabOrder = 1
    OnClick = BtnaddClick
  end
  object Btnclose: TButton
    Left = 485
    Top = 71
    Width = 153
    Height = 50
    Caption = #20851#38381
    TabOrder = 2
    OnClick = BtncloseClick
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 155
    Width = 800
    Height = 330
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnFocusedItemChanged = cxGrid1DBTableView1FocusedItemChanged
      OnFocusedRecordChanged = cxGrid1DBTableView1FocusedRecordChanged
      DataController.DataSource = DM.DSout
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1CODE00: TcxGridDBColumn
        Caption = #20195#30721
        DataBinding.FieldName = 'CODE00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1TYPE00: TcxGridDBColumn
        Caption = #20986#21475#31867#22411
        DataBinding.FieldName = 'TYPE00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1NAME00: TcxGridDBColumn
        Caption = #21517#31216
        DataBinding.FieldName = 'NAME00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1MAX000: TcxGridDBColumn
        Caption = #23481#37327
        DataBinding.FieldName = 'MAX000'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid1DBTableView1STAT00: TcxGridDBColumn
        Caption = #21551#29992
        DataBinding.FieldName = 'STAT00'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ReadOnly = False
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Btnedit: TButton
    Left = 167
    Top = 71
    Width = 153
    Height = 50
    Caption = #20462#25913#29305#24449#30721
    TabOrder = 5
    OnClick = BtneditClick
  end
  object cxGrid2: TcxGrid
    Left = 800
    Top = 155
    Width = 482
    Height = 330
    Align = alClient
    TabOrder = 6
    object cxGrid2DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = DM.DSproper
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGrid2DBTableView1PROPER: TcxGridDBColumn
        Caption = #29305#24449#30721
        DataBinding.FieldName = 'PROPER'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid2DBTableView1DESC00: TcxGridDBColumn
        Caption = #25551#36848
        DataBinding.FieldName = 'DESC00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 315
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
  end
  object Btndel: TButton
    Left = 326
    Top = 71
    Width = 153
    Height = 50
    Caption = #21024#38500#29305#24449#30721
    TabOrder = 7
    OnClick = BtndelClick
  end
end
