object LMDSendKeysEditorDlg: TLMDSendKeysEditorDlg
  Left = 317
  Top = 163
  ActiveControl = m
  BorderStyle = bsDialog
  Caption = 'SendKeys Test-Editor'
  ClientHeight = 342
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 345
    Top = 2
    Width = 72
    Height = 25
    Caption = 'Start App'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Close: TButton
    Left = 423
    Top = 2
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 1
    OnClick = CloseClick
  end
  object window: TPageControl
    Left = 4
    Top = 5
    Width = 204
    Height = 333
    ActivePage = keys
    TabOrder = 2
    object keys: TTabSheet
      Caption = 'Supported Keys'
      object lb2: TLMDListBox
        Left = 3
        Top = 3
        Width = 184
        Height = 299
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        TabOrder = 0
        OnDblClick = lb2DblClick
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        HeaderSections = <
          item
            ImageIndex = -1
            Text = 'Key'
            Width = 80
          end
          item
            ImageIndex = -1
            Text = 'Description'
            Width = 97
          end>
        ItemHeight = 16
        Items.Strings = (
          '+;Shift'
          '^;Control'
          '%;Alt'
          '~;Enter'
          '{BACKSPACE};Backspace'
          '{BS};Backspace'
          '{BKSP};Backspace'
          '{SPACE};Space'
          '{BREAK};PAUSE'
          '{CAPSLOCK};CapsLock'
          '{DELETE};Delete'
          '{DEL};Delete'
          '{DOWN};Arrow down'
          '{END};End'
          '{ENTER};Enter'
          '{ESC};Escape'
          '{HELP};Help or F1'
          '{HOME};Home'
          '{INSERT};Insert'
          '{INS};Insert'
          '{LEFT};Arrow left'
          '{NUMLOCK};NUMLOCK'
          '{PGDN};Page down'
          '{PGUP};Page up'
          '{PRTSC};Print Screen'
          '{RIGHT};Arrow right'
          '{SCROLLLOCK};ScrollLock'
          '{SNAPSHOT};Snapshot'
          '{TAB};Tab'
          '{UP};Arrow up'
          '{F1};F1'
          '{F2};F2'
          '{F3};F3'
          '{F4};F4'
          '{F5};F5'
          '{F6};F6'
          '{F7};F7'
          '{F8};F8'
          '{F9};F9'
          '{F10};F10'
          '{F11};F11'
          '{F12};F12'
          '{F13};F13'
          '{F14};F14'
          '{F15};F15'
          '{F16};F16')
        CtlXP = False
      end
    end
    object Windows: TTabSheet
      Caption = 'Available Windows'
      object lb: TListBox
        Left = 3
        Top = 6
        Width = 189
        Height = 269
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = lbDblClick
      end
      object Update: TButton
        Left = 117
        Top = 281
        Width = 75
        Height = 21
        Caption = 'Update List'
        TabOrder = 1
        OnClick = UpdateClick
      end
    end
  end
  object Macro: TGroupBox
    Left = 214
    Top = 27
    Width = 285
    Height = 310
    Caption = 'Macro'
    TabOrder = 3
    object LMDDockLabel1: TLMDDockLabel
      Left = 8
      Top = 76
      Width = 56
      Height = 15
      Caption = 'KeyStrokes'
      Position = dpTop
      ReflectOwnChanges = True
    end
    object LMDDockLabel2: TLMDDockLabel
      Left = 10
      Top = 33
      Width = 56
      Height = 15
      FocusControl = wnd
      Caption = 'Send To...'
      Position = dpTop
      ReflectOwnChanges = True
    end
    object m: TLMDMemo
      Left = 8
      Top = 92
      Width = 268
      Height = 212
      Bevel.Mode = bmWindows
      Caret.BlinkRate = 530
      CtlXP = False
      TabOrder = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = skVertical
      HorizScrollBar.Back.Style = sfBrush
      HorizScrollBar.Back.Brush.Color = clBlue
      HorizScrollBar.Bevel.Mode = bmStandard
      VertScrollBar.Back.Style = sfBrush
      VertScrollBar.Back.Brush.Color = clBlue
      VertScrollBar.Bevel.Mode = bmStandard
    end
    object wnd: TEdit
      Left = 10
      Top = 49
      Width = 268
      Height = 21
      TabOrder = 1
    end
    object Button3: TButton
      Left = 130
      Top = 16
      Width = 72
      Height = 25
      Caption = 'Send'
      Default = True
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object last: TLMDCheckBox
    Left = 216
    Top = 8
    Width = 105
    Height = 17
    CtlXP = False
    Caption = 'Load Last App'
    Alignment.Alignment = agTopLeft
    Alignment.Spacing = 4
    TabOrder = 4
  end
  object dlg: TOpenDialog
    DefaultExt = '*.exe'
    FileName = '*.exe'
    Filter = 'EXE-Files|*.exe'
    Options = [ofHideReadOnly, ofFileMustExist]
    Left = 253
    Top = 44
  end
  object ini: TLMDIniCtrl
    Left = 293
    Top = 41
  end
  object sk: TLMDSendKeys
    RaiseException = True
    Left = 201
    Top = 14
  end
end
