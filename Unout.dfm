object Formout: TFormout
  Left = 0
  Top = 0
  Caption = #20986#21475#31649#29702
  ClientHeight = 483
  ClientWidth = 1279
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
    Width = 1279
    Height = 90
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 62
      Width = 115
      Height = 28
      Caption = #21253#35013#21333#21015#34920
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 406
      Top = 56
      Width = 253
      Height = 28
      Caption = #36873#20013#21253#35013#21333#23545#24212#19994#21153#25968#25454
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
    Width = 1279
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Caption = #20986#21475#31649#29702
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -47
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Btnrefresh: TButton
    Left = 8
    Top = 71
    Width = 153
    Height = 50
    Caption = #21047#26032
    TabOrder = 1
    OnClick = BtnrefreshClick
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
    Height = 328
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
      DataController.DataSource = DM.DSouta
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1POUT2: TcxGridDBColumn
        Caption = #23454#38469#20986#21475
        DataBinding.FieldName = 'POUT2'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 113
      end
      object cxGrid1DBTableView1labbarcode: TcxGridDBColumn
        Caption = #26631#31614#26465#24418#30721
        DataBinding.FieldName = 'labbarcode'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 280
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Btnprint: TButton
    Left = 167
    Top = 71
    Width = 153
    Height = 50
    Caption = #25171#21360
    TabOrder = 5
    OnClick = BtnprintClick
  end
  object cxGrid2: TcxGrid
    Left = 400
    Top = 155
    Width = 879
    Height = 328
    Align = alClient
    TabOrder = 6
    object cxGrid2DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = DM.DSoutb
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGrid2DBTableView1BARCODE: TcxGridDBColumn
        Caption = #26465#24418#30721
        DataBinding.FieldName = 'BARCODE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 188
      end
      object cxGrid2DBTableView1POUT: TcxGridDBColumn
        Caption = #20998#37197#20986#21475
        DataBinding.FieldName = 'POUT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid2DBTableView1GUID: TcxGridDBColumn
        Caption = #21807#19968#30721
        DataBinding.FieldName = 'GUID'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid2DBTableView1PLENGTH: TcxGridDBColumn
        Caption = #38271
        DataBinding.FieldName = 'PLENGTH'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid2DBTableView1PWIDTH: TcxGridDBColumn
        Caption = #23485
        DataBinding.FieldName = 'PWIDTH'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid2DBTableView1PHEIGHT: TcxGridDBColumn
        Caption = #39640
        DataBinding.FieldName = 'PHEIGHT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid2DBTableView1VOLUME: TcxGridDBColumn
        Caption = #20307#31215
        DataBinding.FieldName = 'VOLUME'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid2DBTableView1TOADDR: TcxGridDBColumn
        Caption = #25509#25910#22320
        DataBinding.FieldName = 'TOADDR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
      object cxGrid2DBTableView1PCOST: TcxGridDBColumn
        Caption = #20215#20540
        DataBinding.FieldName = 'PCOST'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 150
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
  end
end
