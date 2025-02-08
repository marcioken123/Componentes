object LMDMenuEditorDialog: TLMDMenuEditorDialog
  Left = 403
  Top = 229
  Width = 393
  Height = 287
  BorderStyle = bsSizeToolWin
  Caption = 'Menu Designer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  DesignSize = (
    385
    255)
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox1: TGroupBox
    Left = 8
    Top = 3
    Width = 366
    Height = 241
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' Menu Items '
    TabOrder = 0
    DesignSize = (
      366
      241)
    object Panel2: TPanel
      Left = 263
      Top = 16
      Width = 101
      Height = 223
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Bevel2: TBevel
        Left = 10
        Top = 93
        Width = 81
        Height = 5
        Shape = bsTopLine
      end
      object NewSubItemBtn: TButton
        Left = 10
        Top = 32
        Width = 81
        Height = 25
        Caption = 'New &Subitem'
        TabOrder = 0
        OnClick = NewSubItemBtnClick
      end
      object NewItemBtn: TButton
        Left = 10
        Top = 4
        Width = 81
        Height = 25
        Caption = '&New Item'
        TabOrder = 1
        OnClick = NewItemBtnClick
      end
      object DeleteItemBtn: TButton
        Left = 10
        Top = 60
        Width = 81
        Height = 25
        Caption = '&Delete'
        TabOrder = 2
        OnClick = DeleteItemBtnClick
      end
      object MoveUp: TButton
        Left = 10
        Top = 103
        Width = 81
        Height = 25
        Caption = 'Move &Up'
        TabOrder = 3
        OnClick = MoveUpClick
      end
      object MoveDown: TButton
        Left = 10
        Top = 131
        Width = 81
        Height = 25
        Caption = 'Move &Down'
        TabOrder = 4
        OnClick = MoveDownClick
      end
      object LevelUp: TButton
        Left = 10
        Top = 160
        Width = 81
        Height = 25
        Caption = '&<<'
        TabOrder = 5
        OnClick = LevelUpClick
      end
      object LevelDown: TButton
        Left = 10
        Top = 188
        Width = 81
        Height = 25
        Caption = '&>>'
        TabOrder = 6
        OnClick = LevelDownClick
      end
    end
    object MenuEdit: TTreeView
      Left = 12
      Top = 22
      Width = 251
      Height = 207
      Anchors = [akLeft, akTop, akRight, akBottom]
      DragMode = dmAutomatic
      Indent = 19
      TabOrder = 1
      OnChange = MenuEditChange
      OnDragDrop = MenuEditDragDrop
      OnDragOver = MenuEditDragOver
      OnEdited = MenuEditEdited
      OnStartDrag = MenuEditStartDrag
    end
  end
  object OpenMenuDlg: TOpenDialog
    DefaultExt = 'elm'
    Filter = 'Menu items file (*.mit)|*.mit'
    Left = 32
    Top = 276
  end
  object SaveMenuDlg: TSaveDialog
    DefaultExt = 'elm'
    Filter = 'Menu items file (*.mit)|*.mit'
    Left = 4
    Top = 276
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 16
    Top = 32
  end
end
