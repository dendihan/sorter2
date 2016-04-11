object Formmonitor: TFormmonitor
  Left = 0
  Top = 0
  Caption = #20998#25315#30417#25511
  ClientHeight = 679
  ClientWidth = 1182
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 55
    Width = 1182
    Height = 624
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Style = tsButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #36890#35759#28040#24687
      object LBClientIP: TListBox
        Left = 1000
        Top = 30
        Width = 174
        Height = 543
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Tahoma'
        Font.Style = []
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        ItemHeight = 28
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 1100
        ExplicitWidth = 74
      end
      object Memo1: TMemo
        Left = 0
        Top = 30
        Width = 1000
        Height = 543
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Tahoma'
        Font.Style = []
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        Lines.Strings = (
          '')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1174
        Height = 30
        Align = alTop
        TabOrder = 2
        object Label2: TLabel
          Left = 900
          Top = 2
          Width = 221
          Height = 28
          Caption = 'SOCKET'#36830#25509#23458#25143#31471#65306
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -23
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 207
          Height = 28
          Caption = #35774#22791#23454#26102#36890#35759#20449#24687#65306
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -23
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #27169#25311#29615#32447
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1174
        Height = 500
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1182
    Height = 55
    Align = alTop
    TabOrder = 1
    object Label3: TLabel
      Left = 64
      Top = 14
      Width = 165
      Height = 40
      Caption = 'PLC'#36830#25509#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 408
      Top = 14
      Width = 165
      Height = 40
      Caption = 'PLC'#24515#36339#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelState: TLabel
      Left = 696
      Top = 14
      Width = 68
      Height = 40
      Caption = #27491#24120
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMenuHighlight
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ShapeHeart: TShape
      Left = 568
      Top = 0
      Width = 40
      Height = 65
      Brush.Color = clSilver
      Shape = stCircle
    end
    object ShapePlcConn: TShape
      Left = 224
      Top = 0
      Width = 40
      Height = 65
      Brush.Color = clSilver
      Shape = stCircle
    end
  end
  object IdTCPClient1: TIdTCPClient
    OnConnected = IdTCPClient1Connected
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = 1000
    Left = 760
    Top = 80
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnConnect = IdTCPServer1Connect
    OnDisconnect = IdTCPServer1Disconnect
    OnException = IdTCPServer1Exception
    OnListenException = IdTCPServer1ListenException
    Scheduler = IdSchedulerOfThreadDefault1
    OnExecute = IdTCPServer1Execute
    Left = 680
    Top = 80
  end
  object OPCServer1: TOPCServer
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnServerShutDown = OPCServer1ServerShutDown
    Left = 752
    Top = 136
  end
  object OPCGroupErrBegin: TOPCGroup
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 688
    Top = 184
  end
  object OPCGroupMain: TOPCGroup
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 760
    Top = 184
  end
  object OPCGCarEnter: TOPCGroup
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 832
    Top = 184
  end
  object OPCGroupWrite: TOPCGroup
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 912
    Top = 184
  end
  object IdSchedulerOfThreadDefault1: TIdSchedulerOfThreadDefault
    MaxThreads = 100
    Left = 880
    Top = 56
  end
end
