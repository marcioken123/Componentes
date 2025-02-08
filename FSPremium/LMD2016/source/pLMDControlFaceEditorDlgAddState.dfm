object frmStateAddingDlg: TfrmStateAddingDlg
  Left = 411
  Top = 279
  BorderStyle = bsDialog
  Caption = 'Add state(s)'
  ClientHeight = 205
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSplitterPanel1: TLMDSplitterPanel
    Left = 0
    Top = 0
    Width = 296
    Height = 205
    Bevel.Mode = bmCustom
    Bars = <
      item
        OldPosition = -1
        Position = 193
        PosPercent = 66
        Locked = True
      end>
    Align = alClient
    TabOrder = 0
    object LMDSplitterPane1: TLMDSplitterPane
      Bevel.Mode = bmCustom
      object notUsedStates: TLMDCheckListBox
        Left = 0
        Top = 0
        Width = 193
        Height = 205
        Align = alClient
        ItemHeight = 16
        TabOrder = 0
        CtlXP = False
        SelectByClick = True
        ItemIndex = -1
        Layout.Alignment = agTopLeft
      end
    end
    object LMDSplitterPane2: TLMDSplitterPane
      object LMDButton1: TLMDButton
        Left = 12
        Top = 10
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Caption = 'Select all'
        TabOrder = 0
        OnClick = LMDButton1Click
        CtlXP = False
      end
      object LMDButton2: TLMDButton
        Left = 12
        Top = 40
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Caption = 'Select none'
        TabOrder = 1
        OnClick = LMDButton2Click
        CtlXP = False
      end
      object LMDButton3: TLMDButton
        Left = 12
        Top = 140
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Caption = 'Ok'
        Default = True
        ModalResult = 1
        TabOrder = 2
        CtlXP = False
      end
      object LMDButton4: TLMDButton
        Left = 12
        Top = 170
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 3
        CtlXP = False
      end
    end
  end
end
