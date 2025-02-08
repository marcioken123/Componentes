object LMDFrmDateTimeEditor: TLMDFrmDateTimeEditor
  Left = 245
  Top = 274
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'DateTime Editor'
  ClientHeight = 188
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object LMDButton1: TButton
    Left = 3
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Current Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = LMDButton1Click
  end
  object LMDGroupBox1: TGroupBox
    Left = 3
    Top = 13
    Width = 185
    Height = 108
    Caption = 'Date'
    TabOrder = 1
    object LMDSimpleLabel1: TLabel
      Left = 25
      Top = 19
      Width = 22
      Height = 13
      Caption = 'Day:'
    end
    object LMDSimpleLabel2: TLabel
      Left = 25
      Top = 51
      Width = 33
      Height = 13
      Caption = 'Month:'
    end
    object LMDSimpleLabel3: TLabel
      Left = 25
      Top = 83
      Width = 25
      Height = 13
      Caption = 'Year:'
    end
    object DayEdit: TLMDShSpinEdit
      Left = 81
      Top = 14
      Width = 60
      Height = 21
      MaxValue = 31
      MinValue = 1
      TabOrder = 0
    end
    object MonthEdit: TLMDShSpinEdit
      Left = 81
      Top = 46
      Width = 60
      Height = 21
      MaxValue = 12
      MinValue = 1
      TabOrder = 1
    end
    object YearEdit: TLMDShSpinEdit
      Left = 81
      Top = 78
      Width = 60
      Height = 21
      MaxValue = 3000
      MinValue = 1900
      TabOrder = 2
    end
  end
  object LMDGroupBox2: TGroupBox
    Left = 193
    Top = 13
    Width = 185
    Height = 108
    Caption = 'Time'
    TabOrder = 2
    object LMDSimpleLabel4: TLabel
      Left = 31
      Top = 19
      Width = 26
      Height = 13
      Caption = 'Hour:'
    end
    object LMDSimpleLabel5: TLabel
      Left = 31
      Top = 51
      Width = 35
      Height = 13
      Caption = 'Minute:'
    end
    object LMDSimpleLabel6: TLabel
      Left = 31
      Top = 83
      Width = 40
      Height = 13
      Caption = 'Second:'
    end
    object HourEdit: TLMDShSpinEdit
      Left = 87
      Top = 14
      Width = 60
      Height = 21
      MaxValue = 23
      TabOrder = 0
    end
    object MinuteEdit: TLMDShSpinEdit
      Left = 87
      Top = 46
      Width = 60
      Height = 21
      MaxValue = 59
      TabOrder = 1
    end
    object SecondEdit: TLMDShSpinEdit
      Left = 87
      Top = 78
      Width = 60
      Height = 21
      MaxValue = 59
      TabOrder = 2
    end
  end
  object LMDButton2: TButton
    Left = 194
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Current Time'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = LMDButton2Click
  end
  object Button1: TButton
    Left = 224
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 304
    Top = 160
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
end
