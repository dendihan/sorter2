object Formrole: TFormrole
  Left = 0
  Top = 0
  Caption = #35282#33394#31649#29702
  ClientHeight = 434
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
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1282
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Caption = #35282#33394#31649#29702
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
    Caption = #28155#21152
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
    Top = 130
    Width = 1282
    Height = 304
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
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
      object cxGrid1DBTableView1REMARK: TcxGridDBColumn
        Caption = #22791#27880
        DataBinding.FieldName = 'REMARK'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 400
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
    Caption = #20462#25913
    TabOrder = 5
    OnClick = BtneditClick
  end
  object Btndel: TButton
    Left = 326
    Top = 71
    Width = 153
    Height = 50
    Caption = #21024#38500
    TabOrder = 6
    OnClick = BtndelClick
  end
end
