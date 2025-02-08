inherited frmCustomiseEditDialog: TfrmCustomiseEditDialog
  Caption = 'Customise Edit Dialog'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    object tsEdit: TTabSheet
      Caption = 'Edit'
      ImageIndex = 10
      object Label46: TLabel
        Left = 19
        Top = 15
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'Caption:'
      end
      object Label47: TLabel
        Left = 446
        Top = 15
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = 'Coverage:'
      end
      object Label48: TLabel
        Left = 495
        Top = 100
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Height:'
      end
      object Label49: TLabel
        Left = 30
        Top = 127
        Width = 30
        Height = 13
        Caption = 'Value:'
      end
      object rgEditPropertiesCaptionPosition: TRadioGroup
        Left = 68
        Top = 39
        Width = 253
        Height = 80
        Caption = ' Caption Position '
        Columns = 2
        TabOrder = 1
      end
      object rgEditPropertiesCoverageType: TRadioGroup
        Left = 446
        Top = 35
        Width = 211
        Height = 57
        Caption = ' Coverage Type '
        Columns = 2
        TabOrder = 5
      end
      object rgEditPropertiesEditType: TRadioGroup
        Left = 4
        Top = 146
        Width = 317
        Height = 215
        Caption = ' Edit Type '
        Columns = 2
        TabOrder = 3
      end
      object eEditPropertiesCoverage: TEdit
        Left = 503
        Top = 12
        Width = 154
        Height = 21
        TabOrder = 4
      end
      object eEditPropertiesCaption: TEdit
        Left = 68
        Top = 12
        Width = 253
        Height = 21
        TabOrder = 0
      end
      object cbEditPropertiesAllowDoubleClickToClose: TCheckBox
        Left = 446
        Top = 124
        Width = 211
        Height = 17
        Caption = 'Allow Double Click to Close'
        TabOrder = 7
      end
      object eEditPropertiesHeight: TEdit
        Left = 536
        Top = 97
        Width = 121
        Height = 21
        TabOrder = 6
        Text = '100'
      end
      object eEditPropertiesValue: TEdit
        Left = 68
        Top = 125
        Width = 253
        Height = 21
        TabOrder = 2
      end
      object gbEditPropertiesItems: TGroupBox
        Left = 327
        Top = 147
        Width = 330
        Height = 214
        Caption = ' Items '
        TabOrder = 8
        object lbEditPropertiesItems: TListBox
          Left = 16
          Top = 18
          Width = 217
          Height = 184
          ItemHeight = 13
          TabOrder = 0
        end
        object bEditPropertiesItemsAdd: TButton
          Left = 244
          Top = 18
          Width = 75
          Height = 25
          Caption = 'Add...'
          TabOrder = 1
          OnClick = bEditPropertiesItemsAddClick
        end
        object bEditPropertiesItemsRemove: TButton
          Left = 244
          Top = 52
          Width = 75
          Height = 25
          Caption = 'Remove'
          TabOrder = 2
          OnClick = bEditPropertiesItemsRemoveClick
        end
        object bEditPropertiesItemsClear: TButton
          Left = 244
          Top = 105
          Width = 75
          Height = 25
          Caption = 'Clear'
          TabOrder = 3
          OnClick = bEditPropertiesItemsClearClick
        end
      end
    end
  end
  object JSEditDialog1: TJSEditDialog
    Left = 360
    Top = 88
  end
end
