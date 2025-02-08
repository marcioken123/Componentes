object fmJSPasswordDialog: TfmJSPasswordDialog
  Left = 0
  Top = 0
  Width = 320
  Height = 24
  TabOrder = 0
  DesignSize = (
    320
    24)
  object lNewPasswordLabel: TLabel
    Left = 27
    Top = 3
    Width = 79
    Height = 13
    Alignment = taRightJustify
    Caption = '&Enter Password:'
    FocusControl = eNewPassword
  end
  object eNewPassword: TEdit
    Left = 112
    Top = 0
    Width = 205
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = '*'
    TabOrder = 0
  end
end
