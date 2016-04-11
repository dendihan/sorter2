object Formshowcol: TFormshowcol
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  Caption = #33258#23450#20041#21015#36873#25321
  ClientHeight = 705
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 33
  object Panel1: TPanel
    Left = 447
    Top = 0
    Width = 185
    Height = 705
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object Btnquery: TButton
      Left = 16
      Top = 527
      Width = 153
      Height = 50
      Caption = #30830#23450
      TabOrder = 0
      OnClick = BtnqueryClick
    end
  end
  object Btnclose: TButton
    Left = 463
    Top = 615
    Width = 153
    Height = 50
    Caption = #21462#28040
    TabOrder = 1
    OnClick = BtncloseClick
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 447
    Height = 705
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DM.DScommon
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1COLCAP: TcxGridDBColumn
        Caption = #21015#21517#31216
        DataBinding.FieldName = 'COLCAP'
        HeaderAlignmentHorz = taCenter
        Width = 216
      end
      object cxGrid1DBTableView1SHOW00: TcxGridDBColumn
        Caption = #36873#25321
        DataBinding.FieldName = 'SHOW00'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.DisplayChecked = 'true'
        Properties.DisplayUnchecked = 'false'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
end
