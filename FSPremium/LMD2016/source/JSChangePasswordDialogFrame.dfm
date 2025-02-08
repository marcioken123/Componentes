inherited fmJSChangePasswordDialog: TfmJSChangePasswordDialog
  Height = 78
  inherited lNewPasswordLabel: TLabel
    Top = 30
  end
  inherited lConfirmPasswordLabel: TLabel
    Top = 57
  end
  object lOldPasswordLabel: TLabel [2]
    Left = 37
    Top = 3
    Width = 69
    Height = 13
    Alignment = taRightJustify
    Caption = '&Old Password:'
    FocusControl = eOldPassword
  end
  inherited eNewPassword: TEdit
    Top = 27
    TabOrder = 1
  end
  inherited eConfirmPassword: TEdit
    Top = 54
    TabOrder = 2
  end
  object eOldPassword: TEdit
    Left = 112
    Top = 0
    Width = 205
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = '*'
    TabOrder = 0
    OnChange = eNewPasswordChange
  end
end
