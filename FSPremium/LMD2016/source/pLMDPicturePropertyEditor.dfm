object LMDPicturePropertyEditorDlg: TLMDPicturePropertyEditorDlg
  Left = 526
  Top = 234
  Width = 511
  Height = 464
  Caption = 'Picture editor dialog'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    495
    426)
  PixelsPerInch = 96
  TextHeight = 14
  object Bevel1: TBevel
    Left = 9
    Top = 9
    Width = 382
    Height = 370
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object Panel1: TPanel
    Left = 18
    Top = 18
    Width = 362
    Height = 353
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    TabOrder = 0
    object Image: TImage
      Left = 0
      Top = 0
      Width = 358
      Height = 349
      Align = alClient
      Center = True
    end
  end
  object Button1: TButton
    Left = 406
    Top = 9
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 406
    Top = 43
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 9
    Top = 389
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Load'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 95
    Top = 389
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Save'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 181
    Top = 389
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Clear'
    TabOrder = 5
    OnClick = Button5Click
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 280
    Top = 80
  end
  object SavePictureDialog: TSavePictureDialog
    Left = 288
    Top = 144
  end
end
