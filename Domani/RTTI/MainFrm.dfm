object Form1: TForm1
  Left = 299
  Top = 146
  Width = 401
  Height = 412
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 56
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Show AcRTTI'
    TabOrder = 0
    OnClick = Button1Click
  end
  object PageControl1: TPageControl
    Left = 40
    Top = 48
    Width = 289
    Height = 193
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object Edit1: TEdit
        Left = 32
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 40
        Top = 32
        Width = 185
        Height = 89
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
    end
  end
end
