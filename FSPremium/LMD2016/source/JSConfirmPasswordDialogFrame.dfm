inherited fmJSConfirmPasswordDialog: TfmJSConfirmPasswordDialog
  Height = 51
  ParentFont = False
  object lConfirmPasswordLabel: TLabel [1]
    Left = 16
    Top = 30
    Width = 90
    Height = 13
    Alignment = taRightJustify
    Caption = '&Confirm Password:'
    FocusControl = eConfirmPassword
  end
  inherited eNewPassword: TEdit
    OnChange = eNewPasswordChange
  end
  object eConfirmPassword: TEdit
    Left = 112
    Top = 27
    Width = 205
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = '*'
    TabOrder = 1
    OnChange = eConfirmPasswordChange
  end
end
