object LMDShfrmSelectDriveDialog: TLMDShfrmSelectDriveDialog
  Left = 324
  Top = 374
  ActiveControl = lbdisk
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 185
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Instruction: TLabel
    Left = 7
    Top = 10
    Width = 3
    Height = 13
  end
  object lbdisk: TLMDShellDriveListBox
    Left = 8
    Top = 26
    Width = 141
    Height = 146
    ShowDriveType = [dtsRemovable, dtsFixed]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = lbdiskClick
    OnDblClick = lbdiskDblClick
  end
  object btnOK: TButton
    Left = 155
    Top = 25
    Width = 75
    Height = 24
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 155
    Top = 54
    Width = 75
    Height = 24
    Cancel = True
    ModalResult = 2
    TabOrder = 2
  end
end
