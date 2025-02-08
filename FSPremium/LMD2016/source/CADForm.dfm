object frmCAD: TfrmCAD
  Left = 374
  Top = 245
  ActiveControl = eTitle
  BorderStyle = bsDialog
  Caption = 'Construct A Dialog'
  ClientHeight = 341
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    555
    341)
  PixelsPerInch = 96
  TextHeight = 13
  object bHelp: TButton
    Left = 472
    Top = 308
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 2
    Visible = False
  end
  object bOK: TButton
    Left = 391
    Top = 308
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object bCancel: TButton
    Left = 472
    Top = 308
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object bPreview: TButton
    Left = 8
    Top = 308
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Preview'
    TabOrder = 3
    OnClick = bPreviewClick
  end
  object cbDefault: TCheckBox
    Left = 8
    Top = 312
    Width = 145
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = '&Default'
    TabOrder = 4
    Visible = False
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 539
    Height = 291
    ActivePage = tsTaskDialog
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
    OnChange = PageControl1Change
    object tsTaskDialog: TTabSheet
      Caption = '&TaskDialog'
      object Label1: TLabel
        Left = 123
        Top = 35
        Width = 81
        Height = 13
        Caption = 'M&ain Instruction:'
        FocusControl = eInstruction
      end
      object Label2: TLabel
        Left = 125
        Top = 78
        Width = 43
        Height = 13
        Caption = '&Content:'
        FocusControl = mContent
      end
      object iMainIcon: TImage
        Left = 39
        Top = 16
        Width = 43
        Height = 38
        AutoSize = True
      end
      object Label3: TLabel
        Left = 123
        Top = 11
        Width = 24
        Height = 13
        Caption = 'Tit&le:'
        FocusControl = eTitle
      end
      object gbCommonButtons: TGroupBox
        Left = 123
        Top = 179
        Width = 400
        Height = 73
        Caption = ' &Buttons '
        TabOrder = 3
        object cbcbYes: TCheckBox
          Left = 12
          Top = 21
          Width = 85
          Height = 17
          Caption = 'Yes'
          TabOrder = 0
          OnClick = cbcbYesClick
        end
        object cbcbNo: TCheckBox
          Tag = 1
          Left = 103
          Top = 21
          Width = 85
          Height = 17
          Caption = 'No'
          TabOrder = 1
          OnClick = cbcbYesClick
        end
        object cbcbOK: TCheckBox
          Tag = 2
          Left = 194
          Top = 21
          Width = 85
          Height = 17
          Caption = 'OK'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = cbcbYesClick
        end
        object cbcbCancel: TCheckBox
          Tag = 3
          Left = 285
          Top = 20
          Width = 85
          Height = 17
          Caption = 'Cancel'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = cbcbYesClick
        end
        object cbcbRetry: TCheckBox
          Tag = 5
          Left = 12
          Top = 44
          Width = 85
          Height = 17
          Caption = 'Retry'
          TabOrder = 4
          OnClick = cbcbYesClick
        end
        object cbcbClose: TCheckBox
          Tag = 11
          Left = 103
          Top = 44
          Width = 85
          Height = 17
          Caption = 'Close'
          TabOrder = 5
          OnClick = cbcbYesClick
        end
      end
      object eInstruction: TEdit
        Left = 123
        Top = 51
        Width = 400
        Height = 21
        TabOrder = 1
      end
      object mContent: TMemo
        Left = 123
        Top = 94
        Width = 400
        Height = 79
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object rgMainIcon: TRadioGroup
        Left = 8
        Top = 60
        Width = 109
        Height = 192
        Caption = ' &Icon '
        ItemIndex = 3
        Items.Strings = (
          'None'
          'Warning'
          'Error'
          'Information'
          'Confirmation'
          'Shield')
        TabOrder = 4
        OnClick = rgMainIconClick
      end
      object eTitle: TEdit
        Left = 153
        Top = 8
        Width = 370
        Height = 21
        TabOrder = 0
      end
    end
    object tsMessageDlg: TTabSheet
      Caption = '&MessageDlg'
      ImageIndex = 1
      object Image1: TImage
        Left = 39
        Top = 16
        Width = 43
        Height = 38
        AutoSize = True
      end
      object Label4: TLabel
        Left = 123
        Top = 11
        Width = 43
        Height = 13
        Caption = '&Content:'
        FocusControl = Memo1
      end
      object rgMsgDlgType: TRadioGroup
        Left = 8
        Top = 60
        Width = 109
        Height = 192
        Caption = ' &Icon '
        ItemIndex = 2
        Items.Strings = (
          'Warning'
          'Error'
          'Information'
          'Confirmation'
          'Custom')
        TabOrder = 2
        OnClick = rgMsgDlgTypeClick
      end
      object Memo1: TMemo
        Left = 123
        Top = 27
        Width = 400
        Height = 127
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object gbDlgButtons: TGroupBox
        Left = 123
        Top = 160
        Width = 400
        Height = 92
        Caption = ' &Buttons '
        TabOrder = 1
        object cbmbYes: TCheckBox
          Left = 12
          Top = 21
          Width = 85
          Height = 17
          Caption = 'Yes'
          TabOrder = 0
          OnClick = cbcbYesClick
        end
        object cbmbNo: TCheckBox
          Tag = 1
          Left = 103
          Top = 21
          Width = 85
          Height = 17
          Caption = 'No'
          TabOrder = 1
          OnClick = cbcbYesClick
        end
        object cbmbOK: TCheckBox
          Tag = 2
          Left = 193
          Top = 21
          Width = 85
          Height = 17
          Caption = 'OK'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = cbcbYesClick
        end
        object cbmbCancel: TCheckBox
          Tag = 3
          Left = 284
          Top = 21
          Width = 85
          Height = 17
          Caption = 'Cancel'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = cbcbYesClick
        end
        object cbmbAbort: TCheckBox
          Tag = 4
          Left = 12
          Top = 44
          Width = 85
          Height = 17
          Caption = 'Abort'
          TabOrder = 4
          OnClick = cbcbYesClick
        end
        object cbmbRetry: TCheckBox
          Tag = 5
          Left = 103
          Top = 44
          Width = 85
          Height = 17
          Caption = 'Retry'
          TabOrder = 5
          OnClick = cbcbYesClick
        end
        object cbmbIgnore: TCheckBox
          Tag = 6
          Left = 194
          Top = 44
          Width = 85
          Height = 17
          Caption = 'Ignore'
          TabOrder = 6
          OnClick = cbcbYesClick
        end
        object cbmbAll: TCheckBox
          Tag = 7
          Left = 284
          Top = 44
          Width = 85
          Height = 17
          Caption = 'All'
          TabOrder = 7
          OnClick = cbcbYesClick
        end
        object cbmbNoToAll: TCheckBox
          Tag = 8
          Left = 12
          Top = 67
          Width = 85
          Height = 17
          Caption = 'NoToAll'
          TabOrder = 8
          OnClick = cbcbYesClick
        end
        object cbmbYesToAll: TCheckBox
          Tag = 9
          Left = 103
          Top = 67
          Width = 85
          Height = 17
          Caption = 'YesToAll'
          TabOrder = 9
          OnClick = cbcbYesClick
        end
        object cbmbHelp: TCheckBox
          Tag = 10
          Left = 194
          Top = 67
          Width = 85
          Height = 17
          Caption = 'Help'
          TabOrder = 10
          OnClick = cbcbYesClick
        end
        object cbmbClose: TCheckBox
          Tag = 11
          Left = 285
          Top = 67
          Width = 85
          Height = 17
          Caption = 'Close'
          TabOrder = 11
          OnClick = cbcbYesClick
        end
      end
    end
    object tsJSDialog: TTabSheet
      Caption = 'JSDialog'
      ImageIndex = 2
    end
    object TabSheet1: TTabSheet
      Caption = '&VerifyMessage'
      ImageIndex = 3
      object Label5: TLabel
        Left = 124
        Top = 11
        Width = 81
        Height = 13
        Caption = 'M&ain Instruction:'
        FocusControl = eInstructionVerifyMessage
      end
      object Label6: TLabel
        Left = 126
        Top = 54
        Width = 43
        Height = 13
        Caption = '&Content:'
        FocusControl = mContentVerifyMessage
      end
      object iVerifyMessage: TImage
        Left = 39
        Top = 16
        Width = 43
        Height = 38
        AutoSize = True
      end
      object Label7: TLabel
        Left = 123
        Top = 138
        Width = 82
        Height = 13
        Caption = 'V&erification Text:'
      end
      object eInstructionVerifyMessage: TEdit
        Left = 124
        Top = 27
        Width = 400
        Height = 21
        TabOrder = 0
      end
      object mContentVerifyMessage: TMemo
        Left = 124
        Top = 70
        Width = 400
        Height = 59
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object rgVerifyMessage: TRadioGroup
        Left = 8
        Top = 60
        Width = 109
        Height = 192
        Caption = ' &Icon '
        ItemIndex = 4
        Items.Strings = (
          'None'
          'Warning'
          'Error'
          'Information'
          'Confirmation'
          'Shield')
        TabOrder = 4
        OnClick = rgVerifyMessageClick
      end
      object GroupBox1: TGroupBox
        Left = 123
        Top = 160
        Width = 401
        Height = 92
        Caption = ' &Buttons '
        TabOrder = 3
        object cbvmYes: TCheckBox
          Left = 12
          Top = 21
          Width = 85
          Height = 17
          Caption = 'Yes'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbcbYesClick
        end
        object cbvmNo: TCheckBox
          Tag = 1
          Left = 103
          Top = 21
          Width = 85
          Height = 17
          Caption = 'No'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = cbcbYesClick
        end
        object cbvmOK: TCheckBox
          Tag = 2
          Left = 193
          Top = 21
          Width = 85
          Height = 17
          Caption = 'OK'
          TabOrder = 2
          OnClick = cbcbYesClick
        end
        object cbvmCancel: TCheckBox
          Tag = 3
          Left = 284
          Top = 21
          Width = 85
          Height = 17
          Caption = 'Cancel'
          TabOrder = 3
          OnClick = cbcbYesClick
        end
        object cbvmAbort: TCheckBox
          Tag = 4
          Left = 12
          Top = 44
          Width = 85
          Height = 17
          Caption = 'Abort'
          TabOrder = 4
          OnClick = cbcbYesClick
        end
        object cbvmRetry: TCheckBox
          Tag = 5
          Left = 103
          Top = 44
          Width = 85
          Height = 17
          Caption = 'Retry'
          TabOrder = 5
          OnClick = cbcbYesClick
        end
        object cbvmIgnore: TCheckBox
          Tag = 6
          Left = 194
          Top = 44
          Width = 85
          Height = 17
          Caption = 'Ignore'
          TabOrder = 6
          OnClick = cbcbYesClick
        end
        object cbvmAll: TCheckBox
          Tag = 7
          Left = 284
          Top = 44
          Width = 85
          Height = 17
          Caption = 'All'
          TabOrder = 7
          OnClick = cbcbYesClick
        end
        object cbvmNoToAll: TCheckBox
          Tag = 8
          Left = 12
          Top = 67
          Width = 85
          Height = 17
          Caption = 'NoToAll'
          TabOrder = 8
          OnClick = cbcbYesClick
        end
        object cbvmYesToAll: TCheckBox
          Tag = 9
          Left = 103
          Top = 67
          Width = 85
          Height = 17
          Caption = 'YesToAll'
          TabOrder = 9
          OnClick = cbcbYesClick
        end
        object cbvmHelp: TCheckBox
          Tag = 10
          Left = 194
          Top = 67
          Width = 85
          Height = 17
          Caption = 'Help'
          TabOrder = 10
          OnClick = cbcbYesClick
        end
        object cbvmClose: TCheckBox
          Tag = 11
          Left = 285
          Top = 67
          Width = 85
          Height = 17
          Caption = 'Close'
          TabOrder = 11
          OnClick = cbcbYesClick
        end
      end
      object eVerifyText: TEdit
        Left = 211
        Top = 135
        Width = 313
        Height = 21
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = '&Wrapper Functions'
      ImageIndex = 4
      object Label8: TLabel
        Left = 3
        Top = 122
        Width = 71
        Height = 13
        Caption = 'Me&ssage Text:'
      end
      object rgWrapperMethod: TRadioGroup
        Left = 3
        Top = 3
        Width = 525
        Height = 110
        Caption = ' M&ethod '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'ShowMessage'
          'ShowMessageFmt'
          'ShowInfoMessage'
          'ShowErrorMessage'
          'ShowConfirmMessage'
          'ShowWarningMessage')
        TabOrder = 0
      end
      object eWrapperMessage: TEdit
        Left = 80
        Top = 119
        Width = 448
        Height = 21
        TabOrder = 1
      end
    end
  end
end
