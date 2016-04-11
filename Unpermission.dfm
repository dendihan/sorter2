object Formpermission: TFormpermission
  Left = 0
  Top = 0
  Caption = #26435#38480#31649#29702
  ClientHeight = 467
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
      Caption = #35282#33394#21015#34920
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 406
      Top = 62
      Width = 92
      Height = 28
      Caption = #26435#38480#21015#34920
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
    Caption = #26435#38480#31649#29702
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
    Caption = #28155#21152#26435#38480
    TabOrder = 1
    OnClick = BtnaddClick
  end
  object Btnclose: TButton
    Left = 326
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
    Width = 400
    Height = 312
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
      DataController.DataSource = DM.DSrole
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1CODE00: TcxGridDBColumn
        Caption = #35282#33394#20195#30721
        DataBinding.FieldName = 'CODE00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 118
      end
      object cxGrid1DBTableView1NAME00: TcxGridDBColumn
        Caption = #35282#33394#21517#31216
        DataBinding.FieldName = 'NAME00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 151
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Btnsave: TButton
    Left = 167
    Top = 71
    Width = 153
    Height = 50
    Caption = #20445#23384
    TabOrder = 5
    OnClick = BtnsaveClick
  end
  object cxGrid2: TcxGrid
    Left = 400
    Top = 155
    Width = 882
    Height = 312
    Align = alClient
    TabOrder = 6
    object cxGrid2DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = DM.DSaction
      DataController.DetailKeyFieldNames = 'CODE00'
      DataController.Filter.Active = True
      DataController.MasterKeyFieldNames = 'CODE00'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid2DBTableView1CNNAME: TcxGridDBColumn
        Caption = #21151#33021#21517#31216
        DataBinding.FieldName = 'CNNAME'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 200
      end
      object cxGrid2DBTableView1CHOOSE: TcxGridDBColumn
        Caption = #25805#20316#26435#38480
        DataBinding.FieldName = 'CHOOSE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        Width = 212
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
  end
end
