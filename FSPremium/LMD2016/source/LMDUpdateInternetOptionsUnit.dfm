object LMDUpdateInternetOptions: TLMDUpdateInternetOptions
  Left = 378
  Top = 229
  BorderStyle = bsToolWindow
  Caption = 'Internet Options'
  ClientHeight = 272
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 233
    Height = 233
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'URL'
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 25
        Height = 13
        Caption = 'URL:'
      end
      object edURL: TEdit
        Left = 8
        Top = 24
        Width = 137
        Height = 21
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Modem'
      ImageIndex = 1
      object gbEnableDUN: TGroupBox
        Left = 8
        Top = 8
        Width = 209
        Height = 129
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 27
          Height = 13
          Caption = 'DUN:'
        end
        object Label2: TLabel
          Left = 8
          Top = 56
          Width = 36
          Height = 13
          Caption = 'Retries:'
        end
        object cbUseModem: TCheckBox
          Left = 8
          Top = -1
          Width = 121
          Height = 17
          Caption = 'Use Modem Connection'
          TabOrder = 0
          OnClick = cbUseModemClick
        end
        object cbDUN: TComboBox
          Left = 48
          Top = 22
          Width = 153
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
        end
        object edRetries: TEdit
          Left = 48
          Top = 54
          Width = 41
          Height = 21
          TabOrder = 2
          Text = '0'
          OnKeyPress = edRetriesKeyPress
        end
        object UpDown1: TUpDown
          Left = 91
          Top = 54
          Width = 16
          Height = 21
          TabOrder = 3
          OnClick = UpDown1Click
        end
        object cbAutoDial: TCheckBox
          Left = 48
          Top = 80
          Width = 73
          Height = 17
          Caption = 'Auto Dial'
          TabOrder = 4
        end
        object cbAutoClose: TCheckBox
          Left = 48
          Top = 104
          Width = 97
          Height = 17
          Caption = 'Auto Close'
          TabOrder = 5
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Proxy Settings'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 209
        Height = 193
        TabOrder = 0
        object Label4: TLabel
          Left = 8
          Top = 25
          Width = 25
          Height = 13
          Caption = 'Host:'
        end
        object Label5: TLabel
          Left = 8
          Top = 51
          Width = 22
          Height = 13
          Caption = 'Port:'
        end
        object Label7: TLabel
          Left = 8
          Top = 163
          Width = 56
          Height = 13
          Caption = 'Proxy Type:'
        end
        object cbUseProxy: TCheckBox
          Left = 8
          Top = -1
          Width = 73
          Height = 17
          Caption = 'Use Proxy'
          TabOrder = 0
          OnClick = cbUseProxyClick
        end
        object edHost: TEdit
          Left = 37
          Top = 22
          Width = 164
          Height = 21
          TabOrder = 1
        end
        object edPort: TEdit
          Left = 36
          Top = 48
          Width = 37
          Height = 21
          TabOrder = 2
          OnKeyPress = edPortKeyPress
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 80
          Width = 193
          Height = 73
          TabOrder = 3
          object Label6: TLabel
            Left = 8
            Top = 18
            Width = 25
            Height = 13
            Caption = 'User:'
          end
          object lbPWD: TLabel
            Left = 8
            Top = 43
            Width = 49
            Height = 13
            Caption = 'Password:'
          end
          object cbProxyAuth: TCheckBox
            Left = 8
            Top = -2
            Width = 113
            Height = 17
            Caption = 'Proxy Authorization'
            TabOrder = 0
            OnClick = cbProxyAuthClick
          end
          object edUser: TEdit
            Left = 64
            Top = 15
            Width = 121
            Height = 21
            TabOrder = 1
          end
          object edPWD: TEdit
            Left = 64
            Top = 40
            Width = 121
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
        end
        object cmbProxyType: TComboBox
          Left = 72
          Top = 160
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
          Items.Strings = (
            'HTTP Proxy'
            'Sock4'
            'Sock5')
        end
      end
    end
  end
  object Button1: TButton
    Left = 40
    Top = 240
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 120
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object LMDRAS1: TLMDRAS
    Left = 352
    Top = 56
  end
end
