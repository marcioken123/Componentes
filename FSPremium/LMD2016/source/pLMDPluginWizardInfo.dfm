object LMDPluginWizardInfo: TLMDPluginWizardInfo
  Left = 192
  Top = 110
  BorderStyle = bsDialog
  Caption = 'LMD Plugin Wizard'
  ClientHeight = 178
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 273
    Height = 177
    TabOrder = 0
    object grpPluginInfo: TGroupBox
      Left = 8
      Top = 8
      Width = 257
      Height = 73
      Caption = 'Plugin Information'
      TabOrder = 0
      object lblAuthor: TLabel
        Left = 8
        Top = 19
        Width = 34
        Height = 13
        Caption = 'Author:'
      end
      object Label1: TLabel
        Left = 8
        Top = 43
        Width = 38
        Height = 13
        Caption = 'Version:'
      end
      object edAuthor: TEdit
        Left = 48
        Top = 16
        Width = 201
        Height = 21
        TabOrder = 0
      end
      object edMajor: TEdit
        Left = 48
        Top = 40
        Width = 70
        Height = 21
        TabOrder = 1
        Text = '0'
        OnKeyPress = edMajorKeyPress
      end
      object udMajor: TUpDown
        Left = 121
        Top = 40
        Width = 17
        Height = 21
        TabOrder = 2
        OnClick = udMajorClick
      end
      object edMinor: TEdit
        Left = 160
        Top = 40
        Width = 70
        Height = 21
        TabOrder = 3
        Text = '0'
        OnKeyPress = edMajorKeyPress
      end
      object udMinor: TUpDown
        Left = 233
        Top = 40
        Width = 17
        Height = 21
        TabOrder = 4
        OnClick = udMinorClick
      end
    end
    object grpProjectFolder: TGroupBox
      Left = 8
      Top = 88
      Width = 257
      Height = 49
      Caption = 'Project Folder'
      TabOrder = 1
      object edProjectFolder: TEdit
        Left = 8
        Top = 18
        Width = 209
        Height = 21
        TabOrder = 0
      end
      object btnChooseFolder: TButton
        Left = 221
        Top = 18
        Width = 28
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = btnChooseFolderClick
      end
    end
    object btnOK: TButton
      Left = 72
      Top = 144
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 2
    end
    object btnCancel: TButton
      Left = 155
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 3
    end
  end
end
