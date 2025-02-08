object LMDChartEditor: TLMDChartEditor
  Left = 362
  Top = 234
  Width = 631
  Height = 427
  BorderIcons = [biSystemMenu]
  Caption = 'LMD Chart Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object plChartPreview: TPanel
    Left = 0
    Top = 0
    Width = 1
    Height = 393
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 1
    Top = 0
    Width = 622
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 358
      Width = 622
      Height = 35
      Align = alBottom
      TabOrder = 0
      DesignSize = (
        622
        35)
      object btOK: TButton
        Left = 535
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
      end
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 622
      Height = 358
      ActivePage = tsOptions
      Align = alClient
      TabOrder = 1
      object tsChartData: TTabSheet
        Caption = 'Chart data'
        ImageIndex = 1
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 614
          Height = 25
          Align = alTop
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            614
            25)
          object btAddSeries: TButton
            Left = 440
            Top = 0
            Width = 80
            Height = 25
            Anchors = [akTop, akRight]
            Caption = 'Add series...'
            TabOrder = 0
            OnClick = btAddSeriesClick
          end
          object btRemoveSeries: TButton
            Left = 524
            Top = 0
            Width = 80
            Height = 25
            Anchors = [akTop, akRight]
            Caption = 'Remove series'
            TabOrder = 1
            OnClick = btRemoveSeriesClick
          end
        end
        object pcChartSeriesValues: TTabControl
          Left = 0
          Top = 25
          Width = 614
          Height = 305
          Align = alClient
          TabOrder = 1
          OnChange = pcChartSeriesValuesChange
          DesignSize = (
            614
            305)
          object Label3: TLabel
            Left = 486
            Top = 32
            Width = 60
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Rows count:'
          end
          object bColOptions: TButton
            Left = 5
            Top = 25
            Width = 80
            Height = 25
            Caption = 'Column options'
            TabOrder = 0
            OnClick = bColOptionsClick
          end
          object sgData: TStringGrid
            Left = 5
            Top = 56
            Width = 596
            Height = 237
            Anchors = [akLeft, akTop, akRight, akBottom]
            ColCount = 2
            DefaultRowHeight = 18
            FixedCols = 0
            RowCount = 4
            FixedRows = 3
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
            TabOrder = 1
            OnSetEditText = sgDataSetEditText
            ColWidths = (
              65
              64)
          end
          object seRowCount: TLMDShSpinEdit
            Left = 550
            Top = 28
            Width = 50
            Height = 21
            MaxValue = 100000000
            MinValue = 1
            TabOrder = 2
            Value = 1
            OnChange = seRowCountChange
            Anchors = [akTop, akRight]
          end
        end
      end
      object tsOptions: TTabSheet
        Caption = 'General chart options'
        ImageIndex = 2
        object PageControl2: TPageControl
          Left = 0
          Top = 0
          Width = 614
          Height = 330
          ActivePage = tsAxis
          Align = alClient
          MultiLine = True
          TabOrder = 0
          object isGeneral: TTabSheet
            Caption = 'General'
            object btChartBackground: TButton
              Left = 8
              Top = 1
              Width = 75
              Height = 25
              Caption = 'Background...'
              TabOrder = 0
              OnClick = btChartBackgroundClick
            end
            object GroupBox1: TGroupBox
              Left = 8
              Top = 28
              Width = 337
              Height = 248
              Caption = 'Chart area'
              TabOrder = 1
              object btChartAreaBackground: TButton
                Left = 16
                Top = 16
                Width = 75
                Height = 25
                Caption = 'Background...'
                TabOrder = 0
                OnClick = btChartAreaBackgroundClick
              end
              object btEdge: TButton
                Left = 16
                Top = 46
                Width = 75
                Height = 25
                Caption = 'Edge...'
                TabOrder = 1
                OnClick = btEdgeClick
              end
              object GroupBox2: TGroupBox
                Left = 129
                Top = 11
                Width = 199
                Height = 76
                Caption = 'Inner indents'
                TabOrder = 2
                object meChartAreaInnerIndents: TLMDMarginsEditor
                  Left = 8
                  Top = 11
                  Width = 186
                  Height = 63
                  TopMarginChange = meChartAreaInnerIndentsTopMarginChange
                  BottomMarginChange = meChartAreaInnerIndentsBottomMarginChange
                  LeftMarginChange = meChartAreaInnerIndentsLeftMarginChange
                  RightMarginChange = meChartAreaInnerIndentsRightMarginChange
                  DesignSize = (
                    186
                    63)
                end
              end
              object GroupBox3: TGroupBox
                Left = 129
                Top = 87
                Width = 199
                Height = 76
                Caption = 'Margins'
                TabOrder = 3
                object meChartAreaMargins: TLMDMarginsEditor
                  Left = 8
                  Top = 12
                  Width = 186
                  Height = 62
                  TopMarginChange = meChartAreaMarginsTopMarginChange
                  BottomMarginChange = meChartAreaMarginsBottomMarginChange
                  LeftMarginChange = meChartAreaMarginsLeftMarginChange
                  RightMarginChange = meChartAreaMarginsRightMarginChange
                  DesignSize = (
                    186
                    62)
                end
              end
              object GroupBox4: TGroupBox
                Left = 8
                Top = 72
                Width = 113
                Height = 73
                Caption = 'Major vertical grid'
                TabOrder = 4
                object chbVerticalGridLines: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 89
                  Height = 17
                  Caption = 'Visible'
                  TabOrder = 0
                  OnClick = chbVerticalGridLinesClick
                end
                object btMajorVerticalGridLine: TButton
                  Left = 8
                  Top = 40
                  Width = 75
                  Height = 25
                  Caption = 'Line style...'
                  TabOrder = 1
                  OnClick = btMajorVerticalGridLineClick
                end
              end
              object GroupBox5: TGroupBox
                Left = 8
                Top = 145
                Width = 112
                Height = 73
                Caption = 'Major horizontal grid'
                TabOrder = 5
                object chbHorizontalGridLines: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 89
                  Height = 17
                  Caption = 'Visible'
                  TabOrder = 0
                  OnClick = chbHorizontalGridLinesClick
                end
                object btMajorHorizontalGridLine: TButton
                  Left = 8
                  Top = 40
                  Width = 75
                  Height = 25
                  Caption = 'Line style...'
                  TabOrder = 1
                  OnClick = btMajorHorizontalGridLineClick
                end
              end
              object chbChartAreaMarkers: TCheckBox
                Left = 9
                Top = 221
                Width = 97
                Height = 17
                Caption = 'Show markers'
                TabOrder = 6
                OnClick = chbChartAreaMarkersClick
              end
              object GroupBox6: TGroupBox
                Left = 129
                Top = 164
                Width = 199
                Height = 76
                Caption = 'Shadow'
                TabOrder = 7
                object Label7: TLabel
                  Left = 73
                  Top = 8
                  Width = 65
                  Height = 13
                  Caption = 'Transparency'
                end
                object Label8: TLabel
                  Left = 73
                  Top = 39
                  Width = 29
                  Height = 13
                  Caption = 'Depth'
                end
                object chbChartAreaShadow: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 57
                  Height = 17
                  Caption = 'Visible'
                  TabOrder = 0
                  OnClick = chbChartAreaShadowClick
                end
                object btChartAreaShadowColor: TButton
                  Left = 7
                  Top = 40
                  Width = 58
                  Height = 25
                  Caption = 'Color...'
                  TabOrder = 1
                  OnClick = btChartAreaShadowColorClick
                end
                object tbChartAreaShadowTransparency: TTrackBar
                  Left = 68
                  Top = 21
                  Width = 129
                  Height = 18
                  Max = 255
                  PageSize = 50
                  Frequency = 25
                  Position = 150
                  TabOrder = 2
                  ThumbLength = 10
                  OnChange = tbChartAreaShadowTransparencyChange
                end
                object tbChartAreaShadowDepth: TTrackBar
                  Left = 68
                  Top = 53
                  Width = 129
                  Height = 17
                  Max = 100
                  PageSize = 20
                  Frequency = 10
                  Position = 100
                  TabOrder = 3
                  ThumbLength = 10
                  OnChange = tbChartAreaShadowDepthChange
                end
              end
            end
          end
          object tsLegend: TTabSheet
            Caption = 'Legend'
            ImageIndex = 2
            object Label6: TLabel
              Left = 8
              Top = 8
              Width = 88
              Height = 13
              Caption = 'Legend options'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label9: TLabel
              Left = 16
              Top = 120
              Width = 42
              Height = 13
              Caption = 'Icon size'
            end
            object Label10: TLabel
              Left = 15
              Top = 165
              Width = 93
              Height = 13
              Caption = 'Space after an icon'
            end
            object Label11: TLabel
              Left = 16
              Top = 208
              Width = 121
              Height = 13
              Caption = 'Interval between the lines'
            end
            object chbShowLegend: TCheckBox
              Left = 8
              Top = 32
              Width = 73
              Height = 17
              Caption = 'Visible'
              TabOrder = 0
              OnClick = chbShowLegendClick
            end
            object btLegendEdge: TButton
              Left = 8
              Top = 53
              Width = 75
              Height = 25
              Caption = 'Edge...'
              TabOrder = 1
              OnClick = btLegendEdgeClick
            end
            object btLegendIndentsDefine: TButton
              Left = 95
              Top = 83
              Width = 75
              Height = 25
              Caption = 'Text indents...'
              TabOrder = 2
              OnClick = btLegendIndentsDefineClick
            end
            object btLegendBackground: TButton
              Left = 8
              Top = 83
              Width = 75
              Height = 25
              Caption = 'Background...'
              TabOrder = 3
              OnClick = btLegendBackgroundClick
            end
            object aeLegendAlignment: TLMDAlignmentEditor
              Left = 182
              Top = 28
              Width = 86
              Height = 82
              ButtonSpaceWidth = 3
              Mode = amAll
              SelX = 0
              SelY = 0
              Caption = 'Alignment'
              OnChange = aeLegendAlignmentChange
            end
            object btLegendFont: TButton
              Left = 95
              Top = 54
              Width = 75
              Height = 25
              Caption = 'Font...'
              TabOrder = 5
              OnClick = btLegendFontClick
            end
            object chbLegendMayOverlap: TCheckBox
              Left = 96
              Top = 32
              Width = 81
              Height = 17
              Caption = 'May overlap'
              TabOrder = 6
              OnClick = chbLegendMayOverlapClick
            end
            object tbLegendIconSize: TTrackBar
              Left = 8
              Top = 138
              Width = 145
              Height = 25
              Max = 50
              Frequency = 2
              Position = 6
              TabOrder = 7
              ThumbLength = 10
              OnChange = tbLegendIconSizeChange
            end
            object tbLegendSpaceAfterIcon: TTrackBar
              Left = 7
              Top = 181
              Width = 146
              Height = 25
              Max = 50
              Frequency = 2
              Position = 4
              TabOrder = 8
              ThumbLength = 10
              OnChange = tbLegendSpaceAfterIconChange
            end
            object tbLegendIntervalBetweenLines: TTrackBar
              Left = 8
              Top = 224
              Width = 145
              Height = 25
              Max = 50
              Frequency = 2
              Position = 14
              TabOrder = 9
              ThumbLength = 10
              OnChange = tbLegendIntervalBetweenLinesChange
            end
            object rgLegendLayout: TRadioGroup
              Left = 168
              Top = 121
              Width = 100
              Height = 57
              Caption = 'Layout'
              Items.Strings = (
                'Vertical'
                'Horizontal')
              TabOrder = 10
              OnClick = rgLegendLayoutClick
            end
          end
          object tsAxis: TTabSheet
            Caption = 'Axis'
            ImageIndex = 1
            object GroupBox8: TGroupBox
              Left = 5
              Top = 0
              Width = 340
              Height = 129
              Caption = 'X Axis'
              TabOrder = 0
              object Label15: TLabel
                Left = 67
                Top = 107
                Width = 42
                Height = 13
                Caption = 'Tick size'
              end
              object Label16: TLabel
                Left = 162
                Top = 106
                Width = 42
                Height = 13
                Caption = 'Tick size'
              end
              object Label17: TLabel
                Left = 9
                Top = 83
                Width = 50
                Height = 13
                Caption = 'Value type'
              end
              object btXAxisLine: TButton
                Left = 8
                Top = 53
                Width = 49
                Height = 25
                Caption = 'Line...'
                TabOrder = 0
                OnClick = btXAxisLineClick
              end
              object btXAxisFont: TButton
                Left = 7
                Top = 22
                Width = 50
                Height = 25
                Caption = 'Font...'
                TabOrder = 1
                OnClick = btXAxisFontClick
              end
              object rgXAxisMajorTicks: TRadioGroup
                Left = 66
                Top = 16
                Width = 89
                Height = 82
                Caption = 'Major ticks'
                ItemIndex = 1
                Items.Strings = (
                  'Inside'
                  'Outside'
                  'Cross'
                  'None')
                TabOrder = 2
                OnClick = rgXAxisMajorTicksClick
              end
              object rgXAxisMinorTicks: TRadioGroup
                Left = 162
                Top = 16
                Width = 89
                Height = 82
                Caption = 'Minor ticks'
                ItemIndex = 1
                Items.Strings = (
                  'Inside'
                  'Outside'
                  'Cross'
                  'None')
                TabOrder = 3
                OnClick = rgXAxisMinorTicksClick
              end
              object edXAxisMajorTickSize: TEdit
                Left = 120
                Top = 102
                Width = 33
                Height = 21
                TabOrder = 4
                Text = '2'
                OnChange = edXAxisMajorTickSizeChange
              end
              object edXAxisMinorTickSize: TEdit
                Left = 215
                Top = 102
                Width = 33
                Height = 21
                TabOrder = 5
                Text = '2'
                OnChange = edXAxisMinorTickSizeChange
              end
              object cbXAxisValueType: TComboBox
                Left = 9
                Top = 100
                Width = 48
                Height = 21
                Style = csDropDownList
                ItemHeight = 13
                TabOrder = 6
                OnChange = cbXAxisValueTypeChange
                Items.Strings = (
                  'DateTime'
                  'Float')
              end
            end
            object GroupBox9: TGroupBox
              Left = 5
              Top = 130
              Width = 340
              Height = 150
              Caption = 'Y Axis'
              TabOrder = 1
              object Label18: TLabel
                Left = 66
                Top = 107
                Width = 42
                Height = 13
                Caption = 'Tick size'
              end
              object Label19: TLabel
                Left = 161
                Top = 106
                Width = 42
                Height = 13
                Caption = 'Tick size'
              end
              object Label20: TLabel
                Left = 9
                Top = 83
                Width = 50
                Height = 13
                Caption = 'Value type'
              end
              object Label21: TLabel
                Left = 181
                Top = 127
                Width = 22
                Height = 13
                Caption = 'Step'
              end
              object Label22: TLabel
                Left = 87
                Top = 127
                Width = 22
                Height = 13
                Caption = 'Step'
              end
              object Label2: TLabel
                Left = 255
                Top = 104
                Width = 17
                Height = 13
                Caption = 'Min'
              end
              object Label4: TLabel
                Left = 255
                Top = 128
                Width = 20
                Height = 13
                Caption = 'Max'
              end
              object btYAxisLine: TButton
                Left = 8
                Top = 53
                Width = 49
                Height = 25
                Caption = 'Line...'
                TabOrder = 0
                OnClick = btYAxisLineClick
              end
              object btYAxisFont: TButton
                Left = 7
                Top = 22
                Width = 50
                Height = 25
                Caption = 'Font...'
                TabOrder = 1
                OnClick = btYAxisFontClick
              end
              object rgYAxisMajorTicks: TRadioGroup
                Left = 65
                Top = 16
                Width = 88
                Height = 82
                Caption = 'Major ticks'
                ItemIndex = 1
                Items.Strings = (
                  'Inside'
                  'Outside'
                  'Cross'
                  'None')
                TabOrder = 2
                OnClick = rgYAxisMajorTicksClick
              end
              object rgYAxisMinorTicks: TRadioGroup
                Left = 163
                Top = 16
                Width = 85
                Height = 82
                Caption = 'Minor ticks'
                ItemIndex = 1
                Items.Strings = (
                  'Inside'
                  'Outside'
                  'Cross'
                  'None')
                TabOrder = 3
                OnClick = rgYAxisMinorTicksClick
              end
              object edYAxisMajorTickSize: TEdit
                Left = 119
                Top = 102
                Width = 33
                Height = 21
                TabOrder = 4
                Text = '2'
                OnChange = edYAxisMajorTickSizeChange
              end
              object edYAxisMinorTickSize: TEdit
                Left = 214
                Top = 102
                Width = 33
                Height = 21
                TabOrder = 5
                Text = '2'
                OnChange = edYAxisMinorTickSizeChange
              end
              object cbYAxisValueType: TComboBox
                Left = 9
                Top = 100
                Width = 48
                Height = 21
                Style = csDropDownList
                ItemHeight = 13
                TabOrder = 6
                OnChange = cbYAxisValueTypeChange
                Items.Strings = (
                  'DateTime'
                  'Float')
              end
              object chbYAxisAutoScale: TCheckBox
                Left = 255
                Top = 20
                Width = 73
                Height = 17
                Caption = 'Auto scale'
                Checked = True
                State = cbChecked
                TabOrder = 7
                OnClick = chbYAxisAutoScaleClick
              end
              object edYAxisMajorStep: TEdit
                Left = 119
                Top = 124
                Width = 33
                Height = 21
                TabOrder = 8
                Text = '10'
                OnChange = edYAxisMajorStepChange
              end
              object edYAxisMinorStep: TEdit
                Left = 214
                Top = 124
                Width = 33
                Height = 21
                TabOrder = 9
                Text = '5'
                OnChange = edYAxisMinorStepChange
              end
              object chbYAxisStacked: TCheckBox
                Left = 255
                Top = 44
                Width = 73
                Height = 17
                Caption = 'Stacked'
                TabOrder = 10
                OnClick = chbYAxisStackedClick
              end
              object chbYAxisInverted: TCheckBox
                Left = 255
                Top = 67
                Width = 73
                Height = 17
                Caption = 'Inverted'
                TabOrder = 11
                Visible = False
                OnClick = chbYAxisInvertedClick
              end
              object edYMinValue: TEdit
                Left = 280
                Top = 101
                Width = 49
                Height = 21
                TabOrder = 12
                Text = '0'
                OnChange = edYMinValueChange
              end
              object edYMaxValue: TEdit
                Left = 280
                Top = 123
                Width = 49
                Height = 21
                TabOrder = 13
                Text = '100'
                OnChange = edYMaxValueChange
              end
            end
          end
          object tsTitleBox: TTabSheet
            Caption = 'Header'
            ImageIndex = 3
            object Label12: TLabel
              Left = 11
              Top = 11
              Width = 21
              Height = 13
              Caption = 'Text'
            end
            object Label13: TLabel
              Left = 205
              Top = 135
              Width = 59
              Height = 13
              Caption = 'Chart margin'
            end
            object Label14: TLabel
              Left = 204
              Top = 180
              Width = 59
              Height = 13
              Caption = 'Edge margin'
            end
            object Button1: TButton
              Left = 8
              Top = 70
              Width = 75
              Height = 25
              Caption = 'Background...'
              TabOrder = 0
              OnClick = Button1Click
            end
            object Button2: TButton
              Left = 8
              Top = 40
              Width = 75
              Height = 25
              Caption = 'Edge...'
              TabOrder = 1
              OnClick = Button2Click
            end
            object Button3: TButton
              Left = 7
              Top = 100
              Width = 75
              Height = 25
              Caption = 'Font...'
              TabOrder = 2
              OnClick = Button3Click
            end
            object aeTitleBoxAlignment: TLMDAlignmentEditor
              Left = 96
              Top = 39
              Width = 88
              Height = 87
              ButtonSpaceWidth = 3
              Mode = am4Sides
              SelX = 0
              SelY = 0
              Caption = 'Alignment'
              OnChange = aeTitleBoxAlignmentChange
            end
            object aeHeaderIconAlignment: TLMDAlignmentEditor
              Left = 195
              Top = 39
              Width = 86
              Height = 88
              ButtonSpaceWidth = 3
              Mode = am4Sides
              SelX = 0
              SelY = 0
              Caption = 'Icon alignment'
              OnChange = aeHeaderIconAlignmentChange
            end
            object edHeaderText: TEdit
              Left = 40
              Top = 8
              Width = 241
              Height = 21
              TabOrder = 5
              OnChange = edHeaderTextChange
            end
            object GroupBox7: TGroupBox
              Left = 9
              Top = 135
              Width = 183
              Height = 76
              Caption = 'Text indents'
              TabOrder = 6
              object meTitleBoxMargins: TLMDMarginsEditor
                Left = 3
                Top = 12
                Width = 178
                Height = 62
                TopMarginChange = meTitleBoxMarginsTopMarginChange
                BottomMarginChange = meTitleBoxMarginsBottomMarginChange
                LeftMarginChange = meTitleBoxMarginsLeftMarginChange
                RightMarginChange = meTitleBoxMarginsRightMarginChange
                DesignSize = (
                  178
                  62)
              end
            end
            object tbTitleBoxChartMargin: TTrackBar
              Left = 197
              Top = 153
              Width = 89
              Height = 25
              Max = 50
              PageSize = 10
              Frequency = 5
              TabOrder = 7
              ThumbLength = 10
              OnChange = tbTitleBoxChartMarginChange
            end
            object tbTitleBoxEdgeMargin: TTrackBar
              Left = 196
              Top = 196
              Width = 89
              Height = 25
              Max = 50
              PageSize = 10
              Frequency = 5
              TabOrder = 8
              ThumbLength = 10
              OnChange = tbTitleBoxEdgeMarginChange
            end
            object btHeaderIcon: TButton
              Left = 7
              Top = 220
              Width = 75
              Height = 25
              Caption = 'Icon...'
              TabOrder = 9
              OnClick = btHeaderIconClick
            end
          end
        end
      end
      object tsChartType: TTabSheet
        Caption = 'Chart type options'
        object PageControl4: TPageControl
          Left = 0
          Top = 0
          Width = 614
          Height = 330
          ActivePage = tsChartTypeOptions
          Align = alClient
          TabOrder = 0
          object tsChartTypeOptions: TTabSheet
            Caption = 'Chart type options'
            ImageIndex = 1
            object GroupBox10: TGroupBox
              Left = 3
              Top = 2
              Width = 345
              Height = 135
              Caption = 'Common options'
              TabOrder = 0
              object Label23: TLabel
                Left = 119
                Top = 18
                Width = 87
                Height = 13
                Caption = 'Labels X deviation'
              end
              object Label24: TLabel
                Left = 119
                Top = 39
                Width = 87
                Height = 13
                Caption = 'Labels Y deviation'
              end
              object Label25: TLabel
                Left = 141
                Top = 59
                Width = 65
                Height = 13
                Caption = 'Labels margin'
              end
              object Label26: TLabel
                Left = 118
                Top = 104
                Width = 89
                Height = 13
                Caption = 'Chart transparency'
              end
              object Label27: TLabel
                Left = 142
                Top = 81
                Width = 63
                Height = 13
                Caption = 'Labels indent'
              end
              object tbCTLabelsXDeviation: TTrackBar
                Left = 208
                Top = 18
                Width = 133
                Height = 25
                Max = 26
                Min = -26
                PageSize = 4
                Frequency = 2
                TabOrder = 0
                ThumbLength = 10
                OnChange = tbCTLabelsXDeviationChange
              end
              object tbCTLabelsYDeviation: TTrackBar
                Left = 208
                Top = 39
                Width = 133
                Height = 25
                Max = 26
                Min = -26
                PageSize = 4
                Frequency = 2
                TabOrder = 1
                ThumbLength = 10
                OnChange = tbCTLabelsYDeviationChange
              end
              object tbCTLabelsMargin: TTrackBar
                Left = 209
                Top = 59
                Width = 132
                Height = 25
                Max = 50
                PageSize = 4
                Frequency = 2
                Position = 4
                TabOrder = 2
                ThumbLength = 10
                OnChange = tbCTLabelsMarginChange
              end
              object chbCTShowLabels: TCheckBox
                Left = 9
                Top = 18
                Width = 81
                Height = 17
                Caption = 'Show labels'
                TabOrder = 3
                OnClick = chbCTShowLabelsClick
              end
              object tbCTTransparency: TTrackBar
                Left = 209
                Top = 105
                Width = 131
                Height = 18
                Max = 250
                PageSize = 50
                Frequency = 10
                Position = 150
                TabOrder = 4
                ThumbLength = 10
                OnChange = tbCTTransparencyChange
              end
              object btCTLabelsBackground: TButton
                Left = 9
                Top = 53
                Width = 103
                Height = 26
                Caption = 'Labels background...'
                TabOrder = 5
                OnClick = btCTLabelsBackgroundClick
              end
              object btCTLabelEdges: TButton
                Left = 8
                Top = 80
                Width = 104
                Height = 25
                Caption = 'Labels edges...'
                TabOrder = 6
                OnClick = btCTLabelEdgesClick
              end
              object btCTLabelFont: TButton
                Left = 9
                Top = 106
                Width = 103
                Height = 25
                Caption = 'Labels font...'
                TabOrder = 7
                OnClick = btCTLabelFontClick
              end
              object chbCTShowLabelsBackground: TCheckBox
                Left = 9
                Top = 33
                Width = 81
                Height = 17
                Caption = 'Filled labels'
                TabOrder = 8
                OnClick = chbCTShowLabelsBackgroundClick
              end
              object tbCTLabelsIndent: TTrackBar
                Left = 209
                Top = 81
                Width = 132
                Height = 25
                Max = 50
                PageSize = 4
                Frequency = 2
                Position = 2
                TabOrder = 9
                ThumbLength = 10
                OnChange = tbCTLabelsIndentChange
              end
            end
            object pcSpecificCTOptions: TPageControl
              Left = 3
              Top = 136
              Width = 344
              Height = 144
              ActivePage = tsCTSpecifcOptions
              MultiLine = True
              TabOrder = 1
              object tsCT3DOptions: TTabSheet
                Caption = '3D Options'
                object Label28: TLabel
                  Left = 8
                  Top = 96
                  Width = 55
                  Height = 13
                  Caption = 'Chart depth'
                end
                object gbCTLeftPlane: TGroupBox
                  Left = 5
                  Top = 4
                  Width = 88
                  Height = 88
                  Caption = 'Left plane'
                  TabOrder = 0
                  object btCTLeftPlaneFill: TButton
                    Left = 6
                    Top = 20
                    Width = 75
                    Height = 25
                    Caption = 'Background...'
                    TabOrder = 0
                    OnClick = btCTLeftPlaneFillClick
                  end
                  object btCTLeftPlaneLine: TButton
                    Left = 6
                    Top = 52
                    Width = 75
                    Height = 25
                    Caption = 'Lines...'
                    TabOrder = 1
                    OnClick = btCTLeftPlaneLineClick
                  end
                end
                object gbCTBackPlane: TGroupBox
                  Left = 95
                  Top = 4
                  Width = 145
                  Height = 45
                  Caption = 'Back plane'
                  TabOrder = 1
                  object btCTBackPlaneFill: TButton
                    Left = 8
                    Top = 15
                    Width = 75
                    Height = 25
                    Caption = 'Background...'
                    TabOrder = 0
                    OnClick = btCTBackPlaneFillClick
                  end
                  object btCTBackPlaneLine: TButton
                    Left = 88
                    Top = 14
                    Width = 51
                    Height = 25
                    Caption = 'Lines...'
                    TabOrder = 1
                    OnClick = btCTBackPlaneLineClick
                  end
                end
                object tbChartDepth: TTrackBar
                  Left = 73
                  Top = 97
                  Width = 171
                  Height = 19
                  Max = 74
                  PageSize = 4
                  Frequency = 2
                  Position = 4
                  TabOrder = 2
                  ThumbLength = 10
                  OnChange = tbChartDepthChange
                end
                object chbCTNoEdge: TCheckBox
                  Left = 246
                  Top = 25
                  Width = 73
                  Height = 17
                  Caption = 'No edge'
                  TabOrder = 3
                  OnClick = chbCTNoEdgeClick
                end
                object chbCTShaded: TCheckBox
                  Left = 246
                  Top = 8
                  Width = 73
                  Height = 17
                  Caption = 'Shaded'
                  TabOrder = 4
                  OnClick = chbCTShadedClick
                end
                object gbCTBottomPlane: TGroupBox
                  Left = 95
                  Top = 48
                  Width = 145
                  Height = 45
                  Caption = 'Bottom plane'
                  TabOrder = 5
                  object btCTBottomPlaneFill: TButton
                    Left = 8
                    Top = 15
                    Width = 75
                    Height = 25
                    Caption = 'Background...'
                    TabOrder = 0
                    OnClick = btCTBottomPlaneFillClick
                  end
                  object btCTBottomPlaneLine: TButton
                    Left = 89
                    Top = 14
                    Width = 51
                    Height = 25
                    Caption = 'Lines...'
                    TabOrder = 1
                    OnClick = btCTBottomPlaneLineClick
                  end
                end
              end
              object tsCTSpecifcOptions: TTabSheet
                Caption = 'Chart-specific options'
                ImageIndex = 1
                object lbCTAutoSizeValue: TLabel
                  Left = 89
                  Top = 7
                  Width = 72
                  Height = 13
                  Caption = 'Auto size value'
                end
                object lbCTCustomSize: TLabel
                  Left = 105
                  Top = 25
                  Width = 56
                  Height = 13
                  Caption = 'Custom size'
                end
                object lbCTIndent3D: TLabel
                  Left = 115
                  Top = 59
                  Width = 47
                  Height = 13
                  Caption = 'Indent 3D'
                end
                object chbCTStacked: TCheckBox
                  Left = 5
                  Top = 24
                  Width = 65
                  Height = 17
                  Caption = 'Stacked'
                  TabOrder = 0
                  OnClick = chbCTStackedClick
                end
                object chbCTFullStacked: TCheckBox
                  Left = 5
                  Top = 41
                  Width = 84
                  Height = 17
                  Caption = 'Full stacked'
                  TabOrder = 1
                  OnClick = chbCTFullStackedClick
                end
                object chbCTAutoSize: TCheckBox
                  Left = 5
                  Top = 6
                  Width = 84
                  Height = 17
                  Caption = 'Auto size'
                  TabOrder = 2
                  OnClick = chbCTAutoSizeClick
                end
                object tbCTAutoSizeValue: TTrackBar
                  Left = 167
                  Top = 4
                  Width = 162
                  Height = 21
                  Max = 150
                  Min = 10
                  PageSize = 10
                  Frequency = 5
                  Position = 10
                  TabOrder = 3
                  ThumbLength = 10
                  OnChange = tbCTAutoSizeValueChange
                end
                object tbCTCustomSize: TTrackBar
                  Left = 167
                  Top = 28
                  Width = 161
                  Height = 21
                  Max = 150
                  Min = 10
                  PageSize = 10
                  Frequency = 5
                  Position = 10
                  TabOrder = 4
                  ThumbLength = 10
                  OnChange = tbCTCustomSizeChange
                end
                object btCTLeftZGrid: TButton
                  Left = 2
                  Top = 95
                  Width = 75
                  Height = 19
                  Caption = 'Left Z grid...'
                  TabOrder = 5
                  OnClick = btCTLeftZGridClick
                end
                object btCTBottomZMajorGrid: TButton
                  Left = 82
                  Top = 96
                  Width = 105
                  Height = 19
                  Caption = 'Bottom Z major grid...'
                  TabOrder = 6
                  OnClick = btCTBottomZMajorGridClick
                end
                object btCTBottomZMinorGrid: TButton
                  Left = 193
                  Top = 96
                  Width = 105
                  Height = 19
                  Caption = 'Bottom Z minor grid...'
                  TabOrder = 7
                  OnClick = btCTBottomZMinorGridClick
                end
                object chbCTMultiRow: TCheckBox
                  Left = 5
                  Top = 57
                  Width = 84
                  Height = 17
                  Caption = 'Multi row'
                  TabOrder = 8
                  OnClick = chbCTMultiRowClick
                end
                object tbCTIndent3D: TTrackBar
                  Left = 169
                  Top = 59
                  Width = 159
                  Height = 21
                  Max = 50
                  PageSize = 4
                  Frequency = 2
                  Position = 10
                  TabOrder = 9
                  ThumbLength = 10
                  OnChange = tbCTIndent3DChange
                end
                object chbCTExplodeAutoScale: TCheckBox
                  Left = 5
                  Top = 75
                  Width = 84
                  Height = 17
                  Caption = 'Explode'
                  TabOrder = 10
                  OnClick = chbCTExplodeAutoScaleClick
                end
                object chbCTProportional: TCheckBox
                  Left = 91
                  Top = 75
                  Width = 84
                  Height = 17
                  Caption = 'Proportional'
                  TabOrder = 11
                  OnClick = chbCTProportionalClick
                end
              end
            end
          end
        end
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 200
    Top = 216
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 208
    Top = 264
  end
  object ColorDialog1: TColorDialog
    Left = 144
    Top = 256
  end
end
