object LMDShellPathFrame: TLMDShellPathFrame
  Left = 0
  Top = 0
  Width = 415
  Height = 354
  TabOrder = 0
  OnResize = FrameResize
  object UpBtn: TSpeedButton
    Left = 383
    Top = 116
    Width = 26
    Height = 25
    Anchors = [akRight, akBottom]
    Flat = True
    Glyph.Data = {
      6E000000424D6E000000000000003E000000280000000C0000000C0000000100
      010000000000300000000000000000000000020000000200000000000000FFFF
      FF00FFF00000FFF00000F8F00000F8F00000F8F00000E0300000F0700000F8F0
      0000FDF00000FFF00000FFF00000FFF00000}
    OnClick = UpBtnClick
  end
  object DownBtn: TSpeedButton
    Left = 383
    Top = 148
    Width = 26
    Height = 25
    Anchors = [akRight, akBottom]
    Flat = True
    Glyph.Data = {
      6E000000424D6E000000000000003E000000280000000C0000000C0000000100
      010000000000300000000000000000000000020000000200000000000000FFFF
      FF00FFF00000FFF00000FFF00000FDF00000F8F00000F0700000E0300000F8F0
      0000F8F00000F8F00000FFF00000FFF00000}
    OnClick = DownBtnClick
  end
  object FirstBtn: TSpeedButton
    Left = 383
    Top = 91
    Width = 26
    Height = 25
    Anchors = [akRight, akBottom]
    Flat = True
    Glyph.Data = {
      CE000000424DCE000000000000007600000028000000090000000B0000000100
      0400000000005800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888000
      0000888000888000000088800088800000008880008880000000800000008000
      0000880000088000000088800088800000008888088880000000888888888000
      000080000000800000008888888880000000}
    OnClick = FirstBtnClick
  end
  object LastBtn: TSpeedButton
    Left = 383
    Top = 173
    Width = 26
    Height = 25
    Anchors = [akRight, akBottom]
    Flat = True
    Glyph.Data = {
      CE000000424DCE000000000000007600000028000000090000000B0000000100
      0400000000005800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888000
      0000800000008000000088888888800000008888088880000000888000888000
      0000880000088000000080000000800000008880008880000000888000888000
      000088800088800000008888888880000000}
    OnClick = LastBtnClick
  end
  object PathListBox: TListBox
    Left = 8
    Top = 8
    Width = 370
    Height = 269
    Anchors = [akLeft, akTop, akRight, akBottom]
    DragMode = dmAutomatic
    ItemHeight = 13
    Style = lbOwnerDrawFixed
    TabOrder = 0
    OnClick = PathListBoxClick
    OnDragDrop = PathListBoxDragDrop
    OnDragOver = PathListBoxDragOver
    OnDrawItem = PathListBoxDrawItem
    OnStartDrag = PathListBoxStartDrag
  end
  object DeleteBtn: TButton
    Left = 151
    Top = 318
    Width = 67
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Delete'
    TabOrder = 5
    OnClick = DeleteBtnClick
  end
  object AddBtn: TButton
    Left = 79
    Top = 318
    Width = 67
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Add'
    TabOrder = 4
    OnClick = AddBtnClick
  end
  object ReplaceBtn: TButton
    Left = 7
    Top = 318
    Width = 67
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Replace'
    TabOrder = 3
    OnClick = ReplaceBtnClick
  end
  object PathEdit: TEdit
    Left = 8
    Top = 292
    Width = 338
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    OnChange = PathEditChange
  end
  object BrowseBtn: TButton
    Left = 353
    Top = 289
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 2
    OnClick = BrowseBtnClick
  end
  object DelInvalidPathsBtn: TButton
    Left = 272
    Top = 318
    Width = 107
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Delete Invalid Paths'
    TabOrder = 6
    OnClick = DelInvalidPathsBtnClick
  end
end
