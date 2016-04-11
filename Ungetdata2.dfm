object Formgetdata2: TFormgetdata2
  Left = 0
  Top = 0
  Caption = 'Formgetdata2'
  ClientHeight = 755
  ClientWidth = 1082
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
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 33
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1082
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
  object PageControl1: TPageControl
    Left = 0
    Top = 65
    Width = 1082
    Height = 690
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Style = tsButtons
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #25209#37327#33719#21462
      ExplicitTop = 38
      ExplicitHeight = 648
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1074
        Height = 70
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = -2
          Top = 16
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
        object DateTimePicker1: TDateTimePicker
          Left = 88
          Top = 10
          Width = 265
          Height = 41
          Date = 42376.463848067130000000
          Time = 42376.463848067130000000
          DateFormat = dfLong
          DoubleBuffered = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
          ParentDoubleBuffered = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
        end
        object Btnget: TButton
          Left = 376
          Top = 9
          Width = 153
          Height = 50
          Caption = #25968#25454#33719#21462
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = BtngetClick
        end
        object Btnquery: TButton
          Left = 551
          Top = 9
          Width = 153
          Height = 50
          Caption = #25968#25454#26597#35810
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = BtnqueryClick
        end
        object Btnclose: TButton
          Left = 726
          Top = 9
          Width = 153
          Height = 50
          Caption = #39029#38754#20851#38381
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = BtncloseClick
        end
      end
      object cxGrid1: TcxGrid
        Left = 0
        Top = 70
        Width = 1074
        Height = 569
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        ExplicitHeight = 578
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
    end
    object TabSheet2: TTabSheet
      Caption = #25163#21160#24405#20837
      ImageIndex = 1
      ExplicitTop = 38
      ExplicitHeight = 648
      object Label10: TLabel
        Left = 17
        Top = 325
        Width = 140
        Height = 33
        Caption = #25910#20214#21333#20301#65306
      end
      object Label11: TLabel
        Left = 17
        Top = 391
        Width = 140
        Height = 33
        Caption = #25910#20214#35814#22336#65306
      end
      object Label12: TLabel
        Left = 17
        Top = 451
        Width = 140
        Height = 33
        Caption = #25910#20214#30005#35805#65306
      end
      object Label13: TLabel
        Left = 448
        Top = 446
        Width = 140
        Height = 33
        Caption = #25910#20214#37038#32534#65306
      end
      object Label14: TLabel
        Left = 17
        Top = 513
        Width = 140
        Height = 33
        Caption = #20869#20214#21517#31216#65306
      end
      object Label15: TLabel
        Left = 448
        Top = 513
        Width = 140
        Height = 33
        Caption = #29289#20214#25968#37327#65306
      end
      object Label2: TLabel
        Left = 17
        Top = 72
        Width = 84
        Height = 33
        Caption = #20986#21475#65306
      end
      object Label3: TLabel
        Left = 448
        Top = 72
        Width = 84
        Height = 33
        Caption = #26465#30721#65306
      end
      object Label4: TLabel
        Left = 17
        Top = 134
        Width = 112
        Height = 33
        Caption = #23492#20214#20154#65306
      end
      object Label5: TLabel
        Left = 448
        Top = 129
        Width = 140
        Height = 33
        Caption = #23492#20986#22320#22336#65306
      end
      object Label6: TLabel
        Left = 17
        Top = 196
        Width = 140
        Height = 33
        Caption = #23492#20986#21333#20301#65306
      end
      object Label7: TLabel
        Left = 448
        Top = 191
        Width = 140
        Height = 33
        Caption = #23492#20214#30005#35805#65306
      end
      object Label8: TLabel
        Left = 17
        Top = 258
        Width = 112
        Height = 33
        Caption = #25910#20214#20154#65306
      end
      object Label9: TLabel
        Left = 448
        Top = 253
        Width = 140
        Height = 33
        Caption = #25910#20214#22320#22336#65306
      end
      object Btnsure: TButton
        Left = 200
        Top = 4
        Width = 153
        Height = 50
        Caption = #30830#23450#36755#20837
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BtnsureClick
      end
      object Btncancel: TButton
        Left = 406
        Top = 4
        Width = 153
        Height = 50
        Caption = #21462#28040#36755#20837
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BtncancelClick
      end
      object Button3: TButton
        Left = 614
        Top = 4
        Width = 153
        Height = 50
        Caption = #39029#38754#20851#38381
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = BtncloseClick
      end
      object BARCODE: TEdit
        Left = 576
        Top = 69
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 3
        OnKeyPress = BARCODEKeyPress
      end
      object FROMADDR: TEdit
        Left = 576
        Top = 116
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 4
        Text = #23492#20986#22320#22336
      end
      object FROMCO: TEdit
        Left = 144
        Top = 188
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 5
        Text = #23492#20986#21333#20301
      end
      object FROMNAME: TEdit
        Left = 144
        Top = 126
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 6
        Text = #23492#20214#20154'1'
      end
      object FROMTEL: TEdit
        Left = 576
        Top = 188
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 7
        Text = '13500000000'
      end
      object PNAME: TEdit
        Left = 144
        Top = 510
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 8
        Text = #25991#20214
      end
      object PNUMBER: TEdit
        Left = 576
        Top = 510
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 9
        Text = '1'
      end
      object POUT: TEdit
        Left = 144
        Top = 69
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 10
        OnKeyPress = POUTKeyPress
      end
      object TOADDR: TEdit
        Left = 576
        Top = 250
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 11
        Text = #27993#27743#30465#23425#27874#38215#28023
      end
      object TOCO: TEdit
        Left = 144
        Top = 317
        Width = 675
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 12
        Text = #23425#27874#20159#26222#29790#29289#27969#33258#21160#21270#20998#25315#35774#22791#26377#38480#20844#21496
      end
      object TODETAIL: TEdit
        Left = 144
        Top = 383
        Width = 675
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 13
        Text = #27993#27743#30465#23425#27874#24066#38215#28023#21306#34527#24029#34903#36947#37329#38170#36335'666'#21495
      end
      object TONAME: TEdit
        Left = 144
        Top = 250
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 14
        Text = #25910#20214#20154
      end
      object TOTEL: TEdit
        Left = 144
        Top = 443
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 15
        Text = '400-6369119'#36716'03363164'
      end
      object TOZIPCODE: TEdit
        Left = 576
        Top = 443
        Width = 243
        Height = 41
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        TabOrder = 16
        Text = '315200'
      end
      object Memo1: TMemo
        Left = 832
        Top = 60
        Width = 190
        Height = 482
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        Lines.Strings = (
          '')
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 17
      end
    end
  end
  object ComPort1: TComPort
    BaudRate = Br9600
    Port = 'COM1'
    Parity.Bits = PrNone
    StopBits = SbOneStopBit
    DataBits = DbEight
    Events = [EvRxChar, EvTxEmpty, EvRxFlag, EvRing, EvBreak, EvCTS, EvDSR, EvError, EvRLSD, EvRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = DtrDisable
    FlowControl.ControlRTS = RtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [SpBasic]
    TriggersOnRxChar = True
    OnRxChar = ComPort1RxChar
    Left = 680
    Top = 32
  end
end
