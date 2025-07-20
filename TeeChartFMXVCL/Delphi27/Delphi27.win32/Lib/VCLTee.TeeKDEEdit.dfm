object KDEEditor: TKDEEditor
  Left = 0
  Top = 0
  Caption = 'KDEEditor'
  ClientHeight = 321
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 421
    Height = 321
    ActivePage = TabViolin
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 64
    ExplicitTop = 40
    ExplicitWidth = 289
    ExplicitHeight = 193
    object TabViolin: TTabSheet
      Caption = 'Violin'
      ExplicitWidth = 281
      ExplicitHeight = 165
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 413
        Height = 293
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 216
        ExplicitTop = 160
        ExplicitWidth = 185
        ExplicitHeight = 105
        object Label5: TLabel
          Left = 18
          Top = 34
          Width = 41
          Height = 13
          Alignment = taRightJustify
          Caption = '&Position:'
          FocusControl = IntPos
          Layout = tlCenter
        end
        object IntPos: TEdit
          Left = 62
          Top = 31
          Width = 63
          Height = 21
          HelpContext = 46
          MaxLength = 32767
          TabOrder = 0
          Text = '0'
          OnChange = IntPosChange
        end
      end
    end
    object TabKDE: TTabSheet
      Caption = 'KDE'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 413
        Height = 293
        Align = alClient
        TabOrder = 0
        object LRes: TLabel
          Left = 25
          Top = 45
          Width = 48
          Height = 13
          Alignment = taRightJustify
          Caption = '&Resolution:'
          FocusControl = IntRes
          Layout = tlCenter
        end
        object Label1: TLabel
          Left = 25
          Top = 72
          Width = 54
          Height = 13
          Alignment = taRightJustify
          Caption = '&Bandwidth:'
          FocusControl = IntBandW
          Layout = tlCenter
        end
        object Label2: TLabel
          Left = 47
          Top = 100
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = '&Width:'
          FocusControl = IntWidth
          Layout = tlCenter
        end
        object lblClamp: TLabel
          Left = 46
          Top = 129
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = '&Clamp:'
          FocusControl = cbClamp
          Layout = tlCenter
        end
        object Label3: TLabel
          Left = 30
          Top = 160
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Caption = 'C&lampMin:'
          FocusControl = EdiClampMin
          Layout = tlCenter
        end
        object Label4: TLabel
          Left = 26
          Top = 188
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Clamp&Max:'
          FocusControl = EdiClampMax
          Layout = tlCenter
        end
        object IntRes: TEdit
          Left = 82
          Top = 42
          Width = 63
          Height = 21
          HelpContext = 46
          MaxLength = 32767
          TabOrder = 0
          Text = '0'
          OnChange = IntResChange
        end
        object CheckBox1: TCheckBox
          Left = 32
          Top = 19
          Width = 97
          Height = 17
          Alignment = taLeftJustify
          Caption = '&ShowViolin:'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 1
        end
        object IntBandW: TEdit
          Left = 82
          Top = 69
          Width = 63
          Height = 21
          HelpContext = 46
          MaxLength = 32767
          TabOrder = 2
          Text = '0'
          OnChange = IntBandWChange
        end
        object IntWidth: TEdit
          Left = 82
          Top = 97
          Width = 63
          Height = 21
          HelpContext = 46
          MaxLength = 32767
          TabOrder = 3
          Text = '0'
          OnChange = IntWidthChange
        end
        object cbClamp: TComboBox
          Left = 83
          Top = 126
          Width = 94
          Height = 21
          ItemIndex = 0
          TabOrder = 4
          Text = 'MinMax'
          OnChange = cbClampChange
          Items.Strings = (
            'MinMax'
            'Manual')
        end
        object EdiClampMin: TEdit
          Left = 82
          Top = 157
          Width = 95
          Height = 21
          HelpContext = 46
          MaxLength = 32767
          TabOrder = 5
          Text = '0'
          OnChange = EdiClampMinChange
        end
        object EdiClampMax: TEdit
          Left = 82
          Top = 185
          Width = 95
          Height = 21
          HelpContext = 46
          MaxLength = 32767
          TabOrder = 6
          Text = '0'
          OnChange = EdiClampMaxChange
        end
      end
    end
  end
end
