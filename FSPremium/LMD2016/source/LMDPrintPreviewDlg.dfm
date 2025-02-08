object LMDPrintPreviewForm: TLMDPrintPreviewForm
  Left = 241
  Top = 120
  Width = 662
  Height = 473
  Caption = 'Print Preview'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ShowHint = True
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pp: TLMDPrintPreviewPanel
    Left = 0
    Top = 32
    Width = 654
    Height = 388
    Scale = 100
    Mode = pmExactScale
    Align = alClient
  end
  object LMDPrintStatusBar1: TLMDPrintStatusBar
    Left = 0
    Top = 420
    Width = 654
    Height = 19
    PreviewPanel = pp
    ControlGap = 3
    Bevel.BorderInnerWidth = 2
    Bevel.Mode = bmCustom
  end
  object LMDPrintToolBar1: TLMDPrintToolBar
    Left = 0
    Top = 0
    Width = 654
    Height = 32
    Align = alTop
    BorderWidth = 3
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    DisplayItems = [tbPrint, tbPrintSetup, tbPageSettings, tbSave, tbZoom100, tbZoomTextWidth, tbWholePage, tbTwoPages, tbMultiPages, tbZoomOut, tbZoomIn, tbPageFirst, tbPagePrev, tbPageNext, tbPageLast, tbPageSpin, tbScaleCombo, tbClose]
    PreviewPanel = pp
  end
end
