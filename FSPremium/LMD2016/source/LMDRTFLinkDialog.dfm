object LMDRichfrmLinkDialog: TLMDRichfrmLinkDialog
  Left = 8
  Top = 8
  BorderStyle = bsDialog
  Caption = 'Link'
  ClientHeight = 174
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcLinkType: TPageControl
    Left = 7
    Top = 7
    Width = 350
    Height = 129
    ActivePage = tabURL
    TabOrder = 0
    object tabURL: TTabSheet
      Caption = 'URL'
      object URLAddress: TEdit
        Left = 8
        Top = 8
        Width = 317
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = LINKAddressChange
      end
    end
    object tabLink: TTabSheet
      Caption = 'Link'
      ImageIndex = 1
      object LINKAddress: TComboBox
        Left = 8
        Top = 8
        Width = 245
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 0
        TabOrder = 0
        OnChange = LINKAddressChange
      end
    end
  end
  object btnOK: TButton
    Left = 195
    Top = 144
    Width = 75
    Height = 24
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnDelete: TButton
    Left = 110
    Top = 144
    Width = 75
    Height = 24
    Caption = 'Delete'
    Enabled = False
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnCancel: TButton
    Left = 281
    Top = 144
    Width = 75
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
