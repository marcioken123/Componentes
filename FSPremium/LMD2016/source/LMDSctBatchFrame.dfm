object LMDBatchFrame: TLMDBatchFrame
  Left = 0
  Top = 0
  Width = 751
  Height = 482
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object ErrorsSplitter: TSplitter
    Left = 0
    Top = 340
    Width = 751
    Height = 7
    Cursor = crVSplit
    Align = alBottom
  end
  object ErrorsPanel: TPanel
    Left = 0
    Top = 347
    Width = 751
    Height = 116
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object ErrorsPageControls: TPageControl
      Left = 0
      Top = 0
      Width = 751
      Height = 116
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Messages'
        object ErrorList: TMemo
          Left = 0
          Top = 0
          Width = 743
          Height = 87
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Additional Info'
        ImageIndex = 1
        object InfoMemo: TMemo
          Left = 0
          Top = 0
          Width = 743
          Height = 87
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          OnKeyDown = InfoMemoKeyDown
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 751
    Height = 340
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      751
      340)
    object Label2: TLabel
      Left = 10
      Top = 7
      Width = 37
      Height = 14
      Caption = 'Unit list:'
    end
    object UnitsMemo: TMemo
      Left = 10
      Top = 25
      Width = 733
      Height = 261
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object Button1: TButton
      Left = 16
      Top = 292
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Open list...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 97
      Top = 292
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Import'
      TabOrder = 2
      OnClick = Button2Click
    end
    object PsreOnly: TCheckBox
      Left = 186
      Top = 316
      Width = 217
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Parsing only (No analyze, no importing)'
      TabOrder = 3
    end
    object UncheckErrors: TCheckBox
      Left = 186
      Top = 293
      Width = 217
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Uncheck all nodes with errors'
      TabOrder = 4
    end
    object SaveHint: TCheckBox
      Left = 440
      Top = 293
      Width = 129
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Generate hints file'
      TabOrder = 5
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 463
    Width = 751
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object OpenDialog1: TOpenDialog
    Left = 40
    Top = 40
  end
end
