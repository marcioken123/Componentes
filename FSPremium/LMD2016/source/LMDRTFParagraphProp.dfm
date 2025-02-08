object LMDRichfrmParagraph: TLMDRichfrmParagraph
  Left = 113
  Top = 61
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Paragraph'
  ClientHeight = 240
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDefault
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblJustify: TLabel
    Left = 6
    Top = 16
    Width = 32
    Height = 13
    Caption = '&Justify:'
    FocusControl = cbxJustify
  end
  object lblHeading: TLabel
    Left = 204
    Top = 20
    Width = 43
    Height = 13
    Caption = '&Heading:'
    Visible = False
  end
  object Bevel1: TBevel
    Left = 52
    Top = 46
    Width = 345
    Height = 3
    Shape = bsTopLine
  end
  object lblMargins: TLabel
    Left = 6
    Top = 41
    Width = 37
    Height = 13
    Caption = 'Margins'
  end
  object lblLeftMargin: TLabel
    Left = 52
    Top = 60
    Width = 17
    Height = 13
    Caption = 'left:'
  end
  object lblRightMargin: TLabel
    Left = 52
    Top = 88
    Width = 23
    Height = 13
    Caption = 'right:'
  end
  object lblFirstLine: TLabel
    Left = 198
    Top = 58
    Width = 38
    Height = 13
    Caption = 'first line:'
    FocusControl = cbxIndent
  end
  object lblIndentAt: TLabel
    Left = 312
    Top = 56
    Width = 12
    Height = 13
    Caption = 'at:'
    FocusControl = edtIndentAt
  end
  object Bevel2: TBevel
    Left = 52
    Top = 130
    Width = 345
    Height = 3
    Shape = bsTopLine
  end
  object lblIntervals: TLabel
    Left = 6
    Top = 125
    Width = 40
    Height = 13
    Caption = 'Intervals'
  end
  object lblBefore: TLabel
    Left = 52
    Top = 144
    Width = 33
    Height = 13
    Caption = 'before:'
  end
  object lblAfter: TLabel
    Left = 52
    Top = 172
    Width = 24
    Height = 13
    Caption = 'after:'
  end
  object lblLineSpacing: TLabel
    Left = 198
    Top = 141
    Width = 59
    Height = 13
    Caption = 'line spacing:'
    FocusControl = cbxLineSpacing
  end
  object lblValue: TLabel
    Left = 312
    Top = 140
    Width = 29
    Height = 13
    Caption = 'value:'
    FocusControl = edtLineSpacingValue
  end
  object Bevel3: TBevel
    Left = 4
    Top = 198
    Width = 396
    Height = 3
    Shape = bsTopLine
  end
  object btnTabstops: TButton
    Left = 6
    Top = 210
    Width = 75
    Height = 24
    Anchors = [akLeft, akBottom]
    Caption = '&Tabstops'
    ModalResult = 6
    TabOrder = 10
  end
  object btnCancel: TButton
    Left = 326
    Top = 210
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 12
  end
  object btnOK: TButton
    Left = 246
    Top = 210
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 11
  end
  object cbxJustify: TComboBox
    Left = 91
    Top = 11
    Width = 129
    Height = 24
    Style = csOwnerDrawFixed
    ItemHeight = 18
    TabOrder = 0
    OnDrawItem = cbxJustifyDrawItem
    Items.Strings = (
      'Left'
      'Center'
      'Right')
  end
  object cbxHeading: TComboBox
    Left = 264
    Top = 16
    Width = 133
    Height = 24
    Style = csOwnerDrawFixed
    ItemHeight = 18
    TabOrder = 1
    Visible = False
    OnDrawItem = cbxHeadingDrawItem
    Items.Strings = (
      'Normal text'
      'Heading 1'
      'Heading 2'
      'Heading 3'
      'Heading 4'
      'Heading 5'
      'Heading 6'
      'Heading 7'
      'Heading 8'
      'Heading 9')
  end
  object edtLeftMargin: TEdit
    Left = 92
    Top = 56
    Width = 65
    Height = 21
    TabOrder = 2
    Text = '0'
    OnKeyPress = edtDigitsKeyPress
  end
  object edtRightMargin: TEdit
    Left = 92
    Top = 84
    Width = 65
    Height = 21
    TabOrder = 3
    Text = '0'
    OnKeyPress = edtDigitsKeyPress
  end
  object udLeftMargin: TUpDown
    Left = 157
    Top = 56
    Width = 15
    Height = 21
    Associate = edtLeftMargin
    Min = 0
    Max = 10000
    Position = 0
    TabOrder = 13
    Wrap = False
    OnChangingEx = udLeftMarginChangingEx
  end
  object udRightMargin: TUpDown
    Left = 157
    Top = 84
    Width = 15
    Height = 21
    Associate = edtRightMargin
    Min = 0
    Max = 1000
    Position = 0
    TabOrder = 14
    Wrap = False
  end
  object cbxIndent: TComboBox
    Left = 198
    Top = 73
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = cbxIndentChange
    Items.Strings = (
      '(none)'
      'indent'
      'unindent')
  end
  object edtIndentAt: TEdit
    Left = 312
    Top = 72
    Width = 69
    Height = 21
    Enabled = False
    TabOrder = 5
    Text = '0'
    OnKeyPress = edtDigitsKeyPress
  end
  object udIndentAt: TUpDown
    Left = 381
    Top = 72
    Width = 15
    Height = 21
    Associate = edtIndentAt
    Min = 0
    Max = 1000
    Position = 0
    TabOrder = 15
    Wrap = False
  end
  object edtBeforeInterval: TEdit
    Left = 92
    Top = 140
    Width = 65
    Height = 21
    TabOrder = 6
    Text = '0'
    OnKeyPress = edtDigitsKeyPress
  end
  object edtAfterInterval: TEdit
    Left = 92
    Top = 168
    Width = 65
    Height = 21
    TabOrder = 7
    Text = '0'
    OnKeyPress = edtDigitsKeyPress
  end
  object udBeforeInterval: TUpDown
    Left = 157
    Top = 140
    Width = 15
    Height = 21
    Associate = edtBeforeInterval
    Min = 0
    Position = 0
    TabOrder = 16
    Wrap = False
  end
  object udAfterInterval: TUpDown
    Left = 157
    Top = 168
    Width = 15
    Height = 21
    Associate = edtAfterInterval
    Min = 0
    Position = 0
    TabOrder = 17
    Wrap = False
  end
  object cbxLineSpacing: TComboBox
    Left = 198
    Top = 157
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 8
    OnChange = cbxLineSpacingChange
    Items.Strings = (
      'single'
      'one-and-half'
      'double'
      'minimum'
      'exactly'
      'multiplier')
  end
  object edtLineSpacingValue: TEdit
    Left = 312
    Top = 156
    Width = 69
    Height = 21
    TabOrder = 9
    Text = '0'
    OnKeyPress = edtDigitsKeyPress
  end
  object udLineSpacingValue: TUpDown
    Left = 381
    Top = 156
    Width = 15
    Height = 21
    Associate = edtLineSpacingValue
    Min = 0
    Max = 1000
    Position = 0
    TabOrder = 18
    Wrap = False
  end
end
