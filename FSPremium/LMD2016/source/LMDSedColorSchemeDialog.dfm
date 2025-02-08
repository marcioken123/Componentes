object LMDSedColorSchemeDlg: TLMDSedColorSchemeDlg
  Left = 132
  Top = 113
  Caption = 'Color scheme editor'
  ClientHeight = 526
  ClientWidth = 677
  Color = clBtnFace
  Constraints.MinHeight = 348
  Constraints.MinWidth = 625
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 146
    Height = 526
    Align = alLeft
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object Panel10: TPanel
      Left = 0
      Top = 520
      Width = 146
      Height = 6
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
    end
    object Panel11: TPanel
      Left = 0
      Top = 0
      Width = 146
      Height = 7
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object Panel13: TPanel
      Left = 0
      Top = 7
      Width = 7
      Height = 513
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
    end
    object Panel14: TPanel
      Left = 7
      Top = 7
      Width = 139
      Height = 513
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object gbTokens: TGroupBox
        Left = 0
        Top = 0
        Width = 139
        Height = 513
        Align = alClient
        Caption = 'Tokens'
        TabOrder = 0
        object Panel15: TPanel
          Left = 132
          Top = 15
          Width = 5
          Height = 489
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
        end
        object Panel16: TPanel
          Left = 2
          Top = 15
          Width = 4
          Height = 489
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
        end
        object Panel18: TPanel
          Left = 2
          Top = 504
          Width = 135
          Height = 7
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
        end
        object Panel19: TPanel
          Left = 6
          Top = 15
          Width = 126
          Height = 489
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 3
          object btnMinus: TSpeedButton
            Left = 75
            Top = 0
            Width = 24
            Height = 22
            Hint = 'Remove current token'
            Flat = True
            Glyph.Data = {
              E6000000424DE60000000000000076000000280000000E0000000E0000000100
              0400000000007000000000000000000000001000000000000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3300333333333333330033333333333333003333333333333300333333333333
              330033333333333333003300000000003300330FFFFFFFF03300330000000000
              3300333333333333330033333333333333003333333333333300333333333333
              33003333333333333300}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnMinusClick
          end
          object btnPlus: TSpeedButton
            Left = 103
            Top = 0
            Width = 23
            Height = 22
            Hint = 'Add new token'
            Flat = True
            Glyph.Data = {
              E6000000424DE60000000000000076000000280000000E0000000E0000000100
              0400000000007000000000000000000000001000000000000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3300333333333333330033333333333333003333300033333300333330F03333
              3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
              3300333330F033333300333330F0333333003333300033333300333333333333
              33003333333333333300}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnPlusClick
          end
          object Label1: TLabel
            Left = 2
            Top = 20
            Width = 93
            Height = 13
            Caption = 'Press F2 to rename'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnShadow
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lsTokens: TListBox
            Left = 0
            Top = 35
            Width = 126
            Height = 454
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 13
            Sorted = True
            TabOrder = 0
            OnClick = lsTokensClick
            OnKeyDown = lsTokensKeyDown
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 146
    Top = 0
    Width = 531
    Height = 526
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 487
      Width = 531
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        531
        39)
      object btnOk: TButton
        Left = 357
        Top = 7
        Width = 80
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Ok'
        Default = True
        ModalResult = 1
        TabOrder = 1
      end
      object btnCancel: TButton
        Left = 444
        Top = 7
        Width = 80
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 0
      end
      object Button3: TButton
        Left = 8
        Top = 7
        Width = 75
        Height = 25
        Caption = 'Load...'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 89
        Top = 7
        Width = 75
        Height = 25
        Caption = 'Save...'
        TabOrder = 3
        OnClick = Button4Click
      end
    end
    object Panel4: TPanel
      Left = 524
      Top = 7
      Width = 7
      Height = 480
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
    end
    object Panel5: TPanel
      Left = 0
      Top = 7
      Width = 5
      Height = 480
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
    end
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 531
      Height = 7
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
    end
    object Panel7: TPanel
      Left = 5
      Top = 7
      Width = 519
      Height = 480
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 4
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 519
        Height = 480
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object gbExample: TGroupBox
          Left = 0
          Top = 123
          Width = 519
          Height = 357
          Align = alClient
          Caption = 'Example'
          TabOrder = 1
          object Panel9: TPanel
            Left = 510
            Top = 15
            Width = 7
            Height = 333
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
          end
          object Panel17: TPanel
            Left = 2
            Top = 15
            Width = 5
            Height = 333
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
          end
          object Panel20: TPanel
            Left = 2
            Top = 348
            Width = 515
            Height = 7
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
          end
          object Panel22: TPanel
            Left = 7
            Top = 15
            Width = 503
            Height = 333
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 3
            object cbExample: TComboBox
              Left = 3
              Top = 2
              Width = 103
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              OnChange = cbExampleChange
              Items.Strings = (
                'Delphi'
                'HTML')
            end
            object ViewExample: TLMDEditView
              Left = 0
              Top = 29
              Width = 503
              Height = 304
              Align = alBottom
              Anchors = [akLeft, akTop, akRight, akBottom]
              TabOrder = 1
              Document = DocHtml
              WantTabs = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Courier New'
              Font.Style = []
              Gutter.Bars = <
                item
                  Kind = gbLineNumberBar
                  Width = 16
                end
                item
                  Kind = gbFoldBar
                end>
              CustomKeyBindings = <>
              GutterBarsEmpty = False
            end
          end
        end
        object PageControl1: TPageControl
          Left = 0
          Top = 0
          Width = 519
          Height = 123
          ActivePage = tsCustomAttrs
          Align = alTop
          TabOrder = 0
          object tsMainAttrs: TTabSheet
            Caption = 'Main attributes'
            object gbAttributes: TGroupBox
              Left = 0
              Top = 46
              Width = 511
              Height = 49
              Align = alBottom
              Caption = 'Attributes'
              TabOrder = 1
              object cbItalic: TCheckBox
                Left = 9
                Top = 21
                Width = 64
                Height = 17
                Caption = 'Italic'
                TabOrder = 0
                OnClick = onAttrsClick
              end
              object cbBold: TCheckBox
                Left = 61
                Top = 21
                Width = 68
                Height = 17
                Caption = 'Bold'
                TabOrder = 1
                OnClick = onAttrsClick
              end
              object cbUnderline: TCheckBox
                Left = 107
                Top = 21
                Width = 102
                Height = 17
                Caption = 'Underline'
                TabOrder = 2
                OnClick = onAttrsClick
              end
              object cbStrikeout: TCheckBox
                Left = 178
                Top = 21
                Width = 121
                Height = 17
                Caption = 'Strikeout'
                TabOrder = 3
                OnClick = onAttrsClick
              end
              object cbFontAttrsDefined: TCheckBox
                Left = 295
                Top = 21
                Width = 138
                Height = 17
                Caption = 'Attributes defined'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsUnderline]
                ParentFont = False
                TabOrder = 4
                OnClick = cbFontAttrsDefinedClick
              end
            end
            object gbColors: TGroupBox
              Left = 0
              Top = 0
              Width = 511
              Height = 46
              Align = alBottom
              Caption = 'Colors'
              TabOrder = 0
              object lbBgColor: TLabel
                Left = 199
                Top = 20
                Width = 86
                Height = 13
                Caption = 'Background color:'
                FocusControl = cbBgColor
              end
              object lbColor: TLabel
                Left = 9
                Top = 20
                Width = 29
                Height = 13
                Caption = 'Color:'
                FocusControl = cbColor
              end
              object cbBgColor: TComboBox
                Left = 295
                Top = 17
                Width = 145
                Height = 19
                Style = csOwnerDrawFixed
                ItemHeight = 13
                TabOrder = 1
                OnChange = cbBgColorClick
                OnDrawItem = cbBgColorDrawItem
              end
              object cbColor: TComboBox
                Left = 44
                Top = 17
                Width = 145
                Height = 19
                Style = csOwnerDrawFixed
                ItemHeight = 13
                TabOrder = 0
                OnChange = cbBgColorClick
                OnDrawItem = cbBgColorDrawItem
              end
            end
          end
          object tsCustomAttrs: TTabSheet
            Caption = 'Custom attributes'
            ImageIndex = 1
            object lbCustomName: TLabel
              Left = 7
              Top = 4
              Width = 27
              Height = 13
              Caption = 'Name'
            end
            object btnCustomPlus: TSpeedButton
              Left = 154
              Top = 1
              Width = 18
              Height = 16
              Hint = 'Add new token'
              Flat = True
              Glyph.Data = {
                E6000000424DE60000000000000076000000280000000E0000000E0000000100
                0400000000007000000000000000000000001000000000000000000000000000
                BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3300333333333333330033333333333333003333300033333300333330F03333
                3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
                3300333330F033333300333330F0333333003333300033333300333333333333
                33003333333333333300}
              ParentShowHint = False
              ShowHint = True
              OnClick = btnCustomPlusClick
            end
            object btnCustomMinus: TSpeedButton
              Left = 133
              Top = 1
              Width = 18
              Height = 16
              Hint = 'Remove current token'
              Flat = True
              Glyph.Data = {
                E6000000424DE60000000000000076000000280000000E0000000E0000000100
                0400000000007000000000000000000000001000000000000000000000000000
                BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3300333333333333330033333333333333003333333333333300333333333333
                330033333333333333003300000000003300330FFFFFFFF03300330000000000
                3300333333333333330033333333333333003333333333333300333333333333
                33003333333333333300}
              ParentShowHint = False
              ShowHint = True
              OnClick = btnCustomMinusClick
            end
            object lbCustomValue: TLabel
              Left = 184
              Top = 4
              Width = 26
              Height = 13
              Caption = 'Value'
            end
            object lsCustomAttrs: TListBox
              Left = 3
              Top = 19
              Width = 169
              Height = 73
              ItemHeight = 13
              TabOrder = 0
              OnClick = lsCustomAttrsClick
              OnKeyDown = lsCustomAttrsKeyDown
            end
            object edCustomAttrValue: TEdit
              Left = 184
              Top = 19
              Width = 121
              Height = 21
              TabOrder = 1
              OnChange = edCustomAttrValueChange
            end
          end
        end
      end
    end
  end
  object DocHtml: TLMDEditDocument
    Lines.Strings = (
      '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"'
      '            "http://www.w3.org/TR/html4/strict.dtd">'
      ''
      '<html>'
      '<!-- <head>'
      '-->'
      '<title>'#1071#1085#1076#1077#1082#1089'</title>'
      
        '<link rel="SHORTCUT ICON" href="http://img.yandex.net/i/favicon.' +
        'ico">'
      '<style type="text/css">'
      'body, td,'
      
        'table.home-head td.enter { font-size: 80%; font-family: Arial, '#39 +
        'Geneva CY'#39', sans-serif; }'
      '</style>'
      '</head>'
      '<script language="JavaScript">'
      'var passFocus = false;'
      'var loginFocus = false;'
      ''
      'function c2D33CFB1() {'
      ' var img = new Image();'
      ' img.onload = r2D33CFB1;'
      ' img.src = "http://bs.yandex.ru/count/676/1611198";'
      ' return false;'
      '}'
      '</script>'
      ''
      ''
      ''
      '<script type='#39'text/php'#39'>'
      '  if(!isset($PHP_AUTH_USER)) {'
      '    Header("WWW-Authenticate: Basic realm=\"My Realm\"");'
      '    Header("HTTP/1.0 401 Unauthorized");'
      '    echo "Text to send if user hits Cancel button\n";'
      '    exit;'
      '  }'
      '  else {'
      '    echo "Hello $PHP_AUTH_USER.<P>";'
      '    echo "You entered $PHP_AUTH_PW as your password.<P>";'
      '  }'
      ''
      '</script>'
      '     '
      ''
      '<script LANGUAGE="VBScript">'
      'dim curtrans'
      'dim numtrans'
      'dim speed'
      'curtrans = 0'
      'numtrans = 23'
      'Speed=2.0'
      ''
      'Sub Window_onLoad()'
      '    mytext.style.visibility = "hidden"'
      '    call TImage1()'
      'End Sub'
      ''
      '</script>'
      ''
      '<br /><!-- sfront29.yandex.ru -->'
      '</body>'
      '</html>')
    SyntaxSchemes = <
      item
        Name = 'ASP_JS'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ''
          '<SchemeList root='#39'Main'#39'>'
          ''
          
            '    <Scheme name='#39'Main'#39' defaultToken='#39'default'#39' inherit='#39'HTML.Mai' +
            'n'#39' allIgnoreCase='#39'true'#39'>'
          '    '
          '        <RegexBlock innerScheme='#39'JavaScript.Main'#39' '
          '                    start_token0='#39'tagOpen'#39' '
          '                    end_token0='#39'tagClose'#39' '
          '                    defaultToken='#39'defaultEmbed'#39
          '                    >'
          '            <Start> '
          '              &lt; %'
          '            </Start>        '
          '            <End> % &gt; </End>        '
          '        </RegexBlock>'
          ''
          '    </Scheme>'
          '</SchemeList>')
      end
      item
        Name = 'ASP_VB'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ''
          '<SchemeList root='#39'Main'#39'>'
          ''
          
            '    <Scheme name='#39'VBEmbed'#39' inherit='#39'VB.Main'#39' defaultToken='#39'defau' +
            'ltEmbed'#39'>'
          '    </Scheme>'
          ''
          '    <Scheme name='#39'Main'#39' defaultToken='#39'default'#39' '
          '            inherit='#39'HTML.Main'#39' '
          '            allIgnoreCase='#39'true'#39'>'
          '    '
          '        <RegexBlock innerScheme='#39'VBEmbed'#39' '
          '                    start_token0='#39'tagOpen'#39' '
          '                    end_token0='#39'tagClose'#39' '
          '                    >'
          '            <Start> '
          '              &lt; %'
          '            </Start>        '
          '            <End> % &gt; </End>        '
          '        </RegexBlock>'
          ''
          '    </Scheme>'
          '</SchemeList>')
      end
      item
        Name = 'CSS'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ' '
          '<SchemeList root='#39'Main'#39'>'
          ''
          ''
          '  <Scheme name='#39'Comment'#39' defaultToken='#39'comment'#39'>'
          '  </Scheme>'
          '  '
          '  <Scheme name='#39'CssProps'#39' >'
          '      <Regex token0='#39'tagOpen'#39'> [ {} ] </Regex>'
          '      '
          '      <Regex token1='#39'attributeName'#39' token2='#39'attributeValue'#39'>'
          '         (\b[ \w - ]+:) \s*           '
          '         ( [^ ; {}  ]+ [;}]  )        '
          '      </Regex>'
          '      '
          '  </Scheme>'
          '  '
          '  <Scheme name='#39'Main'#39' >'
          '        <Regex token0='#39'cssRule'#39'>\w+</Regex>        '
          '        '
          
            '        <Regex token0='#39'cssRelSymbol'#39'>[* &gt; . &lt; #]+</Regex> ' +
            '       '
          '        '
          
            '        <RegexBlock innerScheme='#39'CssProps'#39' end_token0='#39'tagClose'#39 +
            ' >'
          '            <Start> \{ </Start>        '
          '            <End> \} </End>        '
          '        </RegexBlock>'
          ''
          
            '        <RegexBlock innerScheme='#39'Comment'#39' end_token0='#39'comment'#39' p' +
            'riority='#39'1000'#39' >'
          '          <Start> &lt; !--  </Start>           '
          '          <End> --&gt; </End>        '
          '        </RegexBlock>'
          '                '
          '  </Scheme>'
          '    '
          '</SchemeList>')
      end
      item
        Name = 'HTML'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ' '
          '<SchemeList root='#39'Main'#39'>'
          ''
          '  <Scheme name='#39'WithTags'#39' >'
          '  '
          
            '    <RegexBlock innerScheme='#39'Tag'#39' start_token0='#39'tagOpen'#39' end_tok' +
            'en0='#39'tagClose'#39' >'
          '        <Start> &lt; [\w:]+ </Start>        '
          '        <End> /? &gt; </End>        '
          '    </RegexBlock>'
          ''
          '    <Regex token0='#39'tagClose'#39' >'
          '        &lt; /  [\w:]+ &gt; '
          '    </Regex>'
          ''
          '  </Scheme>'
          ''
          '  <Scheme name='#39'Comment'#39' defaultToken='#39'comment'#39'>'
          '  </Scheme>'
          ''
          '    '
          '  <Scheme name='#39'Css'#39' inherit='#39'WithTags'#39' inherit0='#39'CSS.Main'#39' '
          '          defaultToken='#39'defaultEmbed'#39'  >'
          '  </Scheme>'
          '  '
          '  <Scheme name='#39'JavaScript'#39' inherit0='#39'JavaScript.Main'#39' '
          '          inherit='#39'WithTags'#39
          '          defaultToken='#39'defaultEmbed'#39'>'
          '          '
          '  </Scheme>'
          ''
          '  <Scheme name='#39'VBScript'#39' inherit0='#39'VB.Main'#39' '
          '          allIgnoreCase='#39'true'#39
          '          inherit='#39'WithTags'#39
          '          defaultToken='#39'defaultEmbed'#39'>'
          '          '
          '  </Scheme>'
          ''
          '  <Scheme name='#39'PHPInScript'#39' inherit0='#39'PHP.Language'#39' '
          '          inherit='#39'WithTags'#39
          '          defaultToken='#39'defaultEmbed'#39'>'
          '          '
          '  </Scheme>'
          ''
          '  <Scheme name='#39'PHP'#39' inherit0='#39'PHP.Language'#39' '
          '          defaultToken='#39'defaultEmbed'#39'>          '
          '  </Scheme>'
          ''
          '  <Scheme name='#39'VBScript'#39' inherit='#39'VB.Main'#39'>'
          ''
          '    <RegexBlock innerScheme='#39'Tag'#39' end_token0='#39'tagClose'#39' >'
          '        <Start> &lt; [\w:]+ </Start>        '
          '        <End> &gt; </End>        '
          '    </RegexBlock>'
          '          '
          '  </Scheme>'
          '    '
          
            '  <Scheme name='#39'DTD'#39' allIgnoreCase='#39'true'#39' defaultToken='#39'comment'#39 +
            '>  '
          '  '
          '    <KeywordRegex>\b\w+\b</KeywordRegex>'
          '    '
          '    <Keywords>HTML PUBLIC</Keywords>'
          '    '
          '    <Regex token0="fpi">'
          '        (&quot;|&apos;)'
          '        \s* '
          '        -//W3C//DTD '
          '        \s+ HTML '
          '        \s+ \d\.\d+(\s+\w+)?//EN '
          '        \s* '
          '        \1'
          '    </Regex>'
          '                                        '
          '    <Regex token0="url">'
          '        (&quot;|&apos;)'
          '        \s* '
          '           \w+://\w+(\.\w+)+((/\w+/)+\S*)?'
          '        \s* '
          '        \1        '
          '    </Regex>'
          '      '
          '  </Scheme>'
          ''
          '  <Scheme name='#39'AttrStringQuot'#39'>'
          '    <Regex token0='#39'attributeValue'#39'> [^ &quot; ]+</Regex>'
          '  </Scheme>'
          ''
          '  <Scheme name='#39'AttrStringApos'#39'>'
          '    <Regex token0='#39'attributeValue'#39'> [^ &apos; ]+</Regex>'
          '  </Scheme>'
          ''
          '    '
          '  <Scheme name='#39'AttributeValue'#39' defaultToken='#39'attributeValue'#39' />'
          '  '
          '  <Scheme name='#39'Tag'#39'>  '
          '  '
          '    <Regex token0='#39'attributeName'#39' priority='#39'10'#39'>'
          '        \b\w+ \s* = \s*        '
          '    </Regex>'
          ''
          '    <Regex token0='#39'attributeValue'#39'>'
          '        [^ &lt; &gt; &quot; &apos; = \s ]+         '
          '    </Regex>'
          ''
          
            '    <RegexBlock innerScheme='#39'AttrStringQuot'#39' start_token0='#39'attri' +
            'buteValue'#39' '
          '        end_token0='#39'attributeValue'#39' >'
          ''
          '        <Start> &quot;  </Start>        '
          '        <End> &quot; </End>        '
          '    </RegexBlock>'
          ''
          
            '    <RegexBlock innerScheme='#39'AttrStringApos'#39' start_token0='#39'attri' +
            'buteValue'#39' '
          '        end_token0='#39'attributeValue'#39' >'
          ''
          '        <Start> &apos;  </Start>        '
          '        <End> &apos; </End>        '
          '    </RegexBlock>'
          ''
          '  </Scheme>'
          '  '
          '  <Scheme name='#39'Main'#39' defaultToken='#39'default'#39
          '          inherit='#39'WithTags'#39'      '
          '          keywordsIgnoreCase='#39'true'#39' '
          #9'  allIgnoreCase='#39'true'#39#9
          '  >'
          ''
          '    <Regex token0='#39'entity'#39'>'
          '        &amp;[a-zA-Z]+;'
          '    </Regex>'
          '                    '
          '    <RegexBlock innerScheme='#39'Comment'#39' end_token0='#39'comment'#39' >'
          '        <Start> &lt; !--  </Start>        '
          '        <End> --&gt; </End>        '
          '    </RegexBlock>'
          ''
          
            '    <RegexBlock innerScheme='#39'DTD'#39' start_token0='#39'dtdTagStartEnd'#39' ' +
            'end_token0='#39'dtdTagStartEnd'#39' >'
          '        <Start> &lt; !DOCTYPE  </Start>        '
          '        <End> &gt; </End>        '
          '    </RegexBlock>'
          ''
          '    <RegexBlock innerScheme='#39'JavaScript'#39' '
          #9#9'end_token0='#39'tagClose'#39' >'
          '        <Start>         '
          '          &lt; script '
          '          '
          '            '
          '           ('
          '            \s+'
          
            '            (language \s* = \s* (&quot;|&apos;) \s* (javascript|' +
            'JScript|ECMAScript) \s* \3 ) |'
          
            '            (type \s* = \s* (&quot;|&apos;) \s* text/(javascript' +
            '|JScript|ECMAScript) \s* \6 )'
          '           )?'
          '          '
          '          .*?'
          '          &gt;'
          '        </Start>        '
          '        <End> &lt; / \s* script \s* &gt; </End>        '
          '    </RegexBlock>'
          ''
          '    <RegexBlock innerScheme='#39'VBScript'#39' '
          #9#9'end_token0='#39'tagClose'#39' priority='#39'10'#39' >'
          '        <Start>         '
          '          &lt; script '
          '          '
          '            \s+                             '
          '           ( '
          
            '            (language \s* = \s* (&quot;|&apos;) \s* VBScript \s*' +
            ' \3 ) |'
          
            '            (type \s* = \s* (&quot;|&apos;) \s* text/VBScript \s' +
            '* \6 )'
          '           ) '
          '          '
          '          .*?'
          '          &gt;'
          '        </Start>        '
          '        <End> &lt; / \s* script \s* &gt; </End>        '
          '    </RegexBlock>'
          ''
          '    <RegexBlock innerScheme='#39'PHPInScript'#39' '
          '                end_token0='#39'tagClose'#39' '
          '                priority='#39'200'#39' >'
          '        <Start> '
          '          &lt; script '
          '          '
          '            \s+                             '
          '           ( '
          
            '            (language \s* = \s* (&quot;|&apos;) \s* php \s* \3 )' +
            ' |'
          
            '            (type \s* = \s* (&quot;|&apos;) \s* text/php \s* \5 ' +
            ')'
          '           ) '
          '          '
          '          .*?'
          '          &gt;'
          '        </Start>        '
          '        <End> &lt; / \s* script \s* &gt; </End>        '
          '    </RegexBlock>'
          ''
          '    <RegexBlock innerScheme='#39'PHP'#39' '
          '                start_token0='#39'tagOpen'#39' '
          '                end_token0='#39'tagClose'#39' '
          '                priority='#39'100'#39' >'
          '        <Start> '
          '          &lt; \?php '
          '        </Start>        '
          '        <End> \? &gt; </End>        '
          '    </RegexBlock>'
          ''
          
            '    <RegexBlock innerScheme='#39'Css'#39' end_token0='#39'tagClose'#39' priority' +
            '='#39'100'#39' >'
          '        <Start> '
          '          &lt; style (\s+ [^ &lt; &gt; ]*)?'
          '          &gt;'
          '        </Start>        '
          '        <End> &lt; / \s* style \s* &gt; </End>        '
          '    </RegexBlock>'
          '                        '
          '  </Scheme>'
          '</SchemeList>       ')
      end
      item
        Name = 'JavaScript'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ''
          '<SchemeList root='#39'Main'#39'>'
          ''
          '      <Scheme name='#39'Text'#39' inherit='#39'Numbers'#39'>'
          '            <Regex token0='#39'email'#39'>'
          '                [_a-zA-Z\d\-\.]+ '
          '                @ '
          '                ([_ a-z A-Z \d \-]+ '
          '                (\. [_ a-z A-Z \d \-]+ )+ )'
          '            </Regex>                '
          '      </Scheme>'
          ''
          '      <Scheme name='#39'Numbers'#39'>'
          
            '        <Regex token0='#39'number'#39'>\b (0x \d+ [lL]? | \d+ (e \d*)? [' +
            'lLdDfF]? ) \b</Regex>'
          
            '        <Regex token0='#39'number'#39'>\b [+\-]? \d+ (\. \d+)? ([eE] [+\' +
            '-]? \d+) \b</Regex>'
          '      </Scheme>'
          ''
          
            '      <Scheme name='#39'Comment'#39' inherit='#39'Text'#39' defaultToken='#39'commen' +
            't'#39'>'
          
            '        <Regex token0='#39'st'#39' regex='#39' \/\* | \*\/   '#39' />           ' +
            '     '
          '                '
          '         <SyntaxBlock capture="true">'
          '            <Start> st:/*  </Start>'
          '            <End> st:*/  </End>'
          '         </SyntaxBlock>                '
          '      </Scheme>'
          ''
          
            '      <Scheme name='#39'String'#39' inherit='#39'Text'#39' defaultToken='#39'string'#39 +
            '>'
          '        <Regex token0='#39'escaped'#39' regex='#39'\\[a-z &quot; ]'#39' />    '
          '        <Regex token0='#39'escaped'#39' regex='#39'\\0x[a-fA-F0-9]+'#39' />'
          '      </Scheme>'
          ''
          
            '      <Scheme name='#39'BadString'#39' inherit='#39'String'#39' defaultToken='#39'ba' +
            'dString'#39'>'
          '      </Scheme>'
          ''
          '      <Scheme name='#39'StringFind'#39'>'
          '        <Regex innerScheme='#39'BadString'#39' > '
          '            (&quot;|&apos;) (.*?\\ \1 )*? .* $ '
          '        </Regex>'
          ''
          '        <Regex innerScheme='#39'String'#39' priority='#39'10'#39'> '
          '            (&quot;|&apos;) (.*?\\ \1 )*? \1'
          '        </Regex>'
          ''
          '        <Regex innerScheme='#39'String'#39' priority='#39'20'#39'> '
          '            (&quot;|&apos;) (.*?\\ \1 )*? .*? [^\\] \1'
          '        </Regex>  '
          '      </Scheme>'
          ''
          '    <Scheme name='#39'RegexFind'#39' defaultToken='#39'defaultEmbed'#39'>'
          '        <Regex token0='#39'escaped'#39' regex='#39'\\/'#39' />            '
          '    </Scheme>'
          '    '
          
            '    <Scheme name='#39'RegexSubst'#39' inherit='#39'RegexFind'#39' defaultToken='#39 +
            'defaultEmbed'#39'>'
          '        <Regex token0='#39'escaped'#39' regex='#39'\$\d'#39' />                '
          '    </Scheme>'
          '    '
          '    '
          '    <Scheme name='#39'Main'#39' inherit='#39'StringFind'#39' '
          '            defaultToken='#39'default'#39'           '
          ''
          '            keywordsIgnoreCase='#39'false'#39
          '    >'
          '    <KeywordRegex>\b[a-zA-Z_][\w_]*\b</KeywordRegex>'
          ''
          '    <Keywords>'
          '            Boolean'
          '            Array'
          '            join length reverse sort'
          '            NaN '
          '            null '
          '            true false '
          '            Infinity '
          '            undefined '
          '            Break '#9#9'continue '#9#9#9'for  in  if else return  while '
          '            '
          '            function new this var with  arguments '
          '            '
          '            Global escape unescape eval Number '
          '            Object new instanceof  delete typeof void '#9#9#9
          '            throw  try catch finally with'
          '    </Keywords>'
          ''
          ''
          '    <Regex innerScheme='#39'Comment'#39' regex='#39'//.*$'#39' />'
          ''
          ''
          '    <RegexBlock start='#39'\/\*'#39' end='#39'\*\/'#39' end_token0='#39'comment'#39' '
          '                innerScheme='#39'Comment'#39'/>'
          ''
          
            '    <Regex token0='#39'symbol'#39' regex='#39'[   \}   \{    \]    \[  \( \)' +
            ' &gt; &lt; ]'#39' />'
          '    <Regex token0='#39'symbol'#39' regex='#39'[-:?\~=+!^;,]'#39' />'
          ''
          '    <RegexBlock innerScheme='#39'RegexFind'#39' '
          '                start_token0='#39'regexStart'#39' '
          '                end_token0='#39'regexEnd'#39' >'
          ''
          '        <Start> /  </Start>        '
          '        <End> /[igmx]* </End>        '
          '    </RegexBlock>'
          '    '
          '    <ChainBlock name='#39'RegexSubstEnd'#39' '
          '                end_token0='#39'regexEnd'#39' '
          '                innerScheme='#39'RegexSubst'#39'  >'
          '        <End> /[igmx]* </End>        '
          '    </ChainBlock>'
          '    '
          '    <RegexBlock innerScheme='#39'RegexFind'#39' '
          '                start_token0='#39'regexStart'#39' '
          '                end_token0='#39'regexEnd'#39' '
          '                chainBlock='#39'RegexSubstEnd'#39'>'
          ''
          '        <Start> s/  </Start>        '
          '        <End> /[igmx]* </End>        '
          '    </RegexBlock>'
          ''
          ''
          '    <SkipSyntaxToken token='#39'comment'#39' />'
          ''
          '    <SyntaxBlock capture="true">'
          '        <Start> kw:function  id  '
          '                sym:(  '
          '                        [^ sym:;    sym:}   sym:{   ]*  '
          '                sym:) '
          '                sym:{'
          '        </Start>'
          ''
          '        <End> sym:\}  </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="true" priority='#39'10'#39'>'
          '        <Start>                 '
          
            '            [ kw:while  kw:do kw:if  kw:else  kw:try kw:catch  k' +
            'w:finally  kw:switch ]'
          '                                '
          '            [^ sym:;  sym:}  ]*?    sym:\{'
          '        </Start>'
          ''
          '        <End> sym:}  </End>'
          '    </SyntaxBlock>'
          '        '
          ''
          
            '    <SyntaxBlock capture="true" priority='#39'100'#39'  startGroupUsed='#39 +
            '1'#39'>'
          '        <Start>'
          
            '                    (  [ kw:while  kw:if  kw:with ]  sym:(   [^ ' +
            ' sym:;   sym:}    sym:{   ]+ sym:)   )    '
          ''
          '                    [^ sym:{  sym:}  sym:; ]+ sym:;'
          ''
          '            '
          '        </Start>'
          ''
          '        <End> sym:;  </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="false" priority='#39'0'#39'  >'
          '        <Start> sym:{  </Start>'
          '        <End> sym:}  </End>'
          '    </SyntaxBlock>'
          ''
          '    </Scheme>'
          '</SchemeList>')
      end
      item
        Name = 'Perl'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ''
          '<SchemeList root='#39'Main'#39'>'
          ''
          '    <Scheme name='#39'Text'#39' inherit='#39'Numbers'#39'>                '
          '    '
          '        <Regex token0='#39'email'#39'>'
          '            [_a-zA-Z\d\-\.]+ '
          '            @ '
          '            ([_ a-z A-Z \d \-]+ '
          '            (\. [_ a-z A-Z \d \-]+ )+ )'
          '        </Regex>'
          '    '
          
            '        <Regex token0='#39'st'#39' regex='#39' \/\* | \*\/   '#39' />           ' +
            '     '
          '                '
          '        <SyntaxBlock capture="true">'
          '            <Start> st:/*  </Start>'
          '            <End> st:*/  </End>'
          '        </SyntaxBlock>              '
          '    </Scheme>'
          ''
          '    <Scheme name='#39'Numbers'#39'>'
          '        <Regex token0='#39'number'#39'>'
          '            \b (0x \d+ [lL]? | \d+ (e \d*)? [lLdDfF]? ) \b'
          '        </Regex>'
          '        '
          '        <Regex token0='#39'number'#39'>'
          '            \b [+\-]? \d+ (\. \d+)? ([eE] [+\-]? \d+) \b'
          '        </Regex>'
          '    </Scheme>'
          ''
          
            '    <Scheme name='#39'Comment'#39' inherit='#39'Text'#39' defaultToken='#39'comment'#39 +
            '  />'
          ''
          '    <Scheme name='#39'StringInterpolation'#39'>'
          '        <Regex token0='#39'escaped'#39' regex='#39'\\[a-z &quot; ]'#39' />'
          '        <Regex token0='#39'escaped'#39' regex='#39'\\0\d+'#39' />        '
          
            '        <Regex token0='#39'escaped'#39' regex='#39'\\x[0-9A-Fa-f]+'#39' />      ' +
            '          '
          '        <Regex token0='#39'escaped'#39' regex='#39'[$%]\w+'#39' />    '
          '    </Scheme>'
          '    '
          
            '    <Scheme name='#39'String'#39' inherit='#39'StringInterpolation'#39' inherit0' +
            '='#39'Text'#39' '
          '            defaultToken='#39'string'#39'>'
          '                        '
          '    </Scheme>'
          ''
          
            '    <Scheme name='#39'HereDoc'#39' inherit0='#39'Text'#39' defaultToken='#39'string'#39 +
            '>'
          '        <SyntaxBlock capture="true">'
          '            <Start> blockStart  </Start>'
          '            <End> blockEnd  </End>'
          '        </SyntaxBlock>    '
          '    </Scheme>'
          ''
          
            '    <Scheme name='#39'RegexFind'#39' inherit='#39'StringInterpolation'#39' defau' +
            'ltToken='#39'defaultEmbed'#39'>'
          '        <Regex token0='#39'escaped'#39' regex='#39'\\/'#39' />            '
          '    </Scheme>'
          ''
          
            '    <Scheme name='#39'RegexSubst'#39' inherit='#39'RegexFind'#39' defaultToken='#39 +
            'defaultEmbed'#39'>'
          '        <Regex token0='#39'escaped'#39' regex='#39'\$\d'#39' />                '
          '    </Scheme>'
          ''
          '    <Scheme name='#39'PerlDoc'#39' defaultToken='#39'docDefault'#39'>'
          ''
          
            '        <Regex lineBound='#39'true'#39' token0='#39'docBlockStart'#39' > =begin ' +
            ' </Regex>'
          
            '        <Regex lineBound='#39'true'#39' token0='#39'docBlockEnd'#39' > =end  </R' +
            'egex>'
          
            '        <Regex lineBound='#39'true'#39' token0='#39'docInstruction'#39' > =[a-zA' +
            '-Z_]\w+  </Regex>'
          ''
          '        <SyntaxBlock capture="true">'
          '            <Start> docStart  </Start>'
          '            <End> docEnd  </End>'
          '        </SyntaxBlock>    '
          '        '
          '        <SyntaxBlock capture="true">'
          '            <Start> docBlockStart  </Start>'
          '            <End> docBlockEnd  </End>'
          '        </SyntaxBlock>    '
          '        '
          '    </Scheme>'
          '    '
          ''
          '    <Scheme name='#39'ShellCommand'#39' defaultToken='#39'defaultEmbed'#39'>'
          '        <SyntaxBlock capture="true">'
          '            <Start> blockStart  </Start>'
          '            <End> blockEnd  </End>'
          '        </SyntaxBlock>    '
          '    </Scheme>'
          '    '
          '    <Scheme name='#39'BaseSyntax'#39' inherit='#39'Numbers'#39'>'
          '        <Regex innersScheme='#39'Comment'#39' regex='#39'//.*$'#39' />'
          ''
          '        <Regex innerScheme='#39'Comment'#39' regex='#39'\#.*$'#39' />'
          ''
          
            '        <RegexBlock start='#39'\/\*'#39' end='#39'\*\/'#39' end_token0='#39'comment'#39 +
            ' '
          '                innerScheme='#39'Comment'#39'/>'
          ''
          
            '        <Regex token0='#39'symbol'#39' regex='#39'[   \}   \{    \]    \[  \' +
            '( \) &gt; &lt; ]'#39' />'
          '        <Regex token0='#39'symbol'#39' regex='#39'[-:?\~=+!^;,]'#39' />'
          ''
          '        <Regex regex='#39'\$[a-z_A-Z0-9#]+'#39' />'
          ''
          '        <Regex regex='#39'&lt; [^ &gt; ]+ &gt;'#39' token0='#39'keyword'#39'/>'
          '        '
          '        <RegexBlock innerScheme='#39'RegexFind'#39' '
          '                    start_token0='#39'regexStart'#39' '
          '                    end_token0='#39'regexEnd'#39' >'
          ''
          '            <Start> m?/  </Start>        '
          '            <End> /[cgimosx]* </End>        '
          '        </RegexBlock>'
          ''
          '        <RegexBlock innerScheme='#39'RegexFind'#39' '
          '                    start_token0='#39'regexStart'#39' '
          '                    end_token0='#39'regexEnd'#39' >'
          ''
          '            <Start> q(q?|[xw])/  </Start>        '
          '            <End> / </End>        '
          '        </RegexBlock>'
          ''
          '        <RegexBlock innerScheme='#39'RegexFind'#39' '
          '                    start_token0='#39'regexStart'#39' '
          '                    end_token0='#39'regexEnd'#39' >'
          ''
          '            <Start> qr/  </Start>        '
          '            <End> /[imosx]* </End>        '
          '        </RegexBlock>'
          ''
          '        <RegexBlock innerScheme='#39'RegexFind'#39' '
          '                    start_token0='#39'regexStart'#39' '
          '                    end_token0='#39'regexEnd'#39' >'
          ''
          '            <Start> \?  </Start>        '
          '            <End> \? </End>        '
          '        </RegexBlock>'
          ''
          '        <ChainBlock name='#39'RegexSubstEnd'#39' '
          '                    end_token0='#39'regexEnd'#39' '
          '                    innerScheme='#39'RegexSubst'#39'  >'
          '            <End> /[egimosx]* </End>        '
          '        </ChainBlock>'
          ''
          '        <ChainBlock name='#39'RegexSubstEnd2'#39' '
          '                    end_token0='#39'regexEnd'#39' '
          '                    innerScheme='#39'RegexSubst'#39'  >'
          '            <End> /[cds]* </End>        '
          '        </ChainBlock>'
          ''
          '        <RegexBlock innerScheme='#39'RegexFind'#39' '
          '                    start_token0='#39'regexStart'#39' '
          '                    end_token0='#39'regexEnd'#39' '
          '                    chainBlock='#39'RegexSubstEnd'#39'>'
          ''
          '            <Start> s/  </Start>        '
          '            <End> / </End>        '
          '        </RegexBlock>'
          ''
          '        <RegexBlock innerScheme='#39'RegexFind'#39' '
          '                    start_token0='#39'regexStart'#39' '
          '                    end_token0='#39'regexEnd'#39' '
          '                    chainBlock='#39'RegexSubstEnd2'#39'>'
          ''
          '            <Start> (tr|y)/  </Start>        '
          '            <End> / </End>        '
          '        </RegexBlock>'
          ''
          ''
          '        <RegexBlock innerScheme='#39'PerlDoc'#39' '
          '                    priority='#39'100'#39
          '                    lineBound='#39'true'#39
          '                    start_token0='#39'docStart'#39' '
          '                    end_token0='#39'docEnd'#39'>'
          ''
          '            <Start> =[a-zA-Z_]\w+  </Start>        '
          '            <End> =cut </End>        '
          '        </RegexBlock>'
          ''
          '    </Scheme>'
          '    '
          '    <Scheme name='#39'Main'#39' inherit='#39'BaseSyntax'#39' '
          '            defaultToken='#39'default'#39'           '
          ''
          '            keywordsIgnoreCase='#39'false'#39
          '    >'
          '        <KeywordRegex>\b[a-z()A-Z_][\w_]*\b</KeywordRegex>'
          ''
          '        <Keywords>    '
          '            __FILE__    __LINE__    __PACKAGE__'
          '            __END__     __DATA__'
          '            continue else elsif for foreach if last '
          '            next redo sub unless until while        '
          '            accept alarm atan2 bind binmode bless caller chdir'
          '            chmod abs chomp chop chown chr chroot closedir close'
          
            '            connect cos crypt dbmclose dbmopen defined delete di' +
            'e do'
          
            '            dump each endgrent endhostent endnetent endprotoent ' +
            'endpwent'
          
            '            endservent eof eval exec exists exit exp fcntl filen' +
            'o flock'
          '            fork format formline getc getgrent getgrgid getgrnam'
          
            '            gethostbyaddr gethostbyname gethostent getlogin getn' +
            'etbyaddr'
          
            '            getnetbyname getnetent getpeername getpgrp getpriori' +
            'ty'
          '            getprotobyname getprotobynumber getprotoent getpwent'
          
            '            getpwnam getpwuid getservbyname getservbyport getser' +
            'vent'
          
            '            getsockname getsockopt glob gmtime goto grep hex ind' +
            'ex'
          
            '            int ioctl join keys kill last lcfirst lc length link' +
            ' listen'
          
            '            local localtime log lstat map mkdir msgctl msgget ms' +
            'grcv'
          
            '            msgsnd my next no oct open opendir ord pack package ' +
            'pipe'
          '            pop pos printf print prototype push qq quotemeta qw'
          
            '            qx q rand readdir readline readlink readpipe read re' +
            'cv'
          
            '            redo ref rename require reset return reverse rewindd' +
            'ir'
          
            '            rindex rmdir scalar seek seekdir select semctl semge' +
            't'
          
            '            semop send setgrent sethostent setnetent setpgrp set' +
            'priority'
          
            '            setprotoent setpwent setservent setsockopt shift shm' +
            'ctl shmget'
          
            '            shmread shmwrite shutdown sin sleep socket socketpai' +
            'r sort splice'
          
            '            split sprintf sqrt srand stat study substr sub symli' +
            'nk syscall'
          
            '            sysopen sysread sysseek system syswrite s tell telld' +
            'ir tie tied'
          
            '            time times truncate tr ucfirst uc umask undef unlink' +
            ' unpack'
          
            '            unshift untie use utime values vec waitpid wait want' +
            'array'
          '            warn write            '
          '        </Keywords>'
          ''
          
            '        <RegexBlock innerScheme='#39'HereDoc'#39' start_token0='#39'blockSta' +
            'rt'#39' '
          '                    priority='#39'100'#39
          '                    end_token0='#39'blockEnd'#39' >'
          ''
          
            '            <Start>  [^ &lt; ]? &lt; &lt; (\w+) ; </Start>      ' +
            '  '
          '            <End> $1 </End>        '
          '        </RegexBlock>'
          ''
          
            '        <RegexBlock innerScheme='#39'ShellCommand'#39' start_token0='#39'blo' +
            'ckStart'#39' '
          '                    priority='#39'100'#39
          '                    end_token0='#39'blockEnd'#39' >'
          ''
          
            '            <Start>  [^ &lt; ]? &lt; &lt; \s? \`  (\w+) \` </Sta' +
            'rt>        '
          '            <End> $1 </End>        '
          '        </RegexBlock>'
          ''
          '        <RegexBlock innerScheme='#39'String'#39' start_token0='#39'string'#39' '
          '                    end_token0='#39'string'#39' >'
          ''
          '            <Start> &quot;  </Start>        '
          '            <End> &quot; </End>        '
          '        </RegexBlock>'
          ''
          '        <RegexBlock innerScheme='#39'ShellCommand'#39
          '                    start_token0='#39'defaultEmbed'#39
          '                    end_token0='#39'defaultEmbed'#39' >'
          ''
          '            <Start> &apos;  </Start>        '
          '            <End> &apos; </End>        '
          '        </RegexBlock>'
          ''
          '        <SkipSyntaxToken token='#39'comment'#39' />'
          ''
          '        <SyntaxBlock capture="true">'
          '            <Start> kw:sub  id  '
          '                    '
          '                    sym:{'
          '            </Start>'
          ''
          '            <End> sym:\}  </End>'
          '        </SyntaxBlock>'
          ''
          '        <SyntaxBlock capture="true">'
          '            <Start> [ kw:do ] sym:{'
          '            </Start>'
          ''
          '            <End> sym:\}   </End>'
          '        </SyntaxBlock>'
          ''
          '        <SyntaxBlock capture="true">'
          '            <Start> [ kw:else kw:continue ] sym:{'
          '            </Start>'
          ''
          '            <End> sym:\}  </End>'
          '        </SyntaxBlock>'
          ''
          '        <SyntaxBlock capture="true" priority='#39'10'#39'>'
          '            <Start>                 '
          
            '                ( id sym:: )? [ kw:while  kw:if  kw:switch kw:fo' +
            'r ]'
          '                                    '
          '                sym:( .+  sym:)   sym:\{'
          '            </Start>'
          ''
          '            <End> sym:}  </End>'
          '        </SyntaxBlock>'
          ''
          '        <SyntaxBlock capture="true" priority='#39'10'#39'>'
          '            <Start>                 '
          '                id sym::   sym:\{'
          '            </Start>'
          ''
          '            <End> sym:}  </End>'
          '        </SyntaxBlock>'
          ''
          '        <SyntaxBlock capture="true">'
          '            <Start> '
          '                kw:foreach  id  sym:( .+  sym:)  sym:{'
          '            </Start>'
          ''
          '            <End> sym:\}  </End>'
          '        </SyntaxBlock>'
          ''
          ''
          '        <SyntaxBlock capture="false" priority='#39'0'#39'  >'
          '            <Start> sym:{  </Start>'
          '            <End> sym:}  </End>'
          '        </SyntaxBlock>'
          ''
          '    </Scheme>'
          '</SchemeList>')
      end
      item
        Name = 'PHP'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ''
          '<SchemeList root='#39'Main'#39'>'
          ''
          '    <Scheme name='#39'Text'#39' inherit='#39'Numbers'#39'>                '
          '    '
          '        <Regex token0='#39'email'#39'>'
          '            [_a-zA-Z\d\-\.]+ '
          '            @ '
          '            ([_ a-z A-Z \d \-]+ '
          '            (\. [_ a-z A-Z \d \-]+ )+ )'
          '        </Regex>'
          '    '
          
            '        <Regex token0='#39'st'#39' regex='#39' \/\* | \*\/   '#39' />           ' +
            '     '
          '                '
          '        <SyntaxBlock capture="true">'
          '            <Start> st:/*  </Start>'
          '            <End> st:*/  </End>'
          '        </SyntaxBlock>              '
          '    </Scheme>'
          ''
          '    <Scheme name='#39'Numbers'#39'>'
          '        <Regex token0='#39'number'#39'>'
          '            \b (0x \d+ [lL]? | \d+ (e \d*)? [lLdDfF]? ) \b'
          '        </Regex>'
          '        '
          '        <Regex token0='#39'number'#39'>'
          '            \b [+\-]? \d+ (\. \d+)? ([eE] [+\-]? \d+) \b'
          '        </Regex>'
          '    </Scheme>'
          ''
          
            '    <Scheme name='#39'Comment'#39' inherit='#39'Text'#39' defaultToken='#39'comment'#39 +
            '  />'
          ''
          '    <Scheme name='#39'String'#39' inherit='#39'Text'#39' defaultToken='#39'string'#39'>'
          '        <Regex token0='#39'escaped'#39' regex='#39'\\[a-z &quot; ]'#39' />'
          
            '        <Regex token0='#39'escaped'#39' regex='#39'\\x[a-fA-F0-9 ]{1,2}'#39' pri' +
            'ority='#39'10'#39'/>        '
          '    </Scheme>'
          ''
          
            '    <Scheme name='#39'StringInterpolation'#39' inherit='#39'String'#39' defaultT' +
            'oken='#39'string'#39'>'
          '        <Regex token0='#39'escaped'#39' regex='#39'\$ \w[ \w - &gt; ]*'#39' />'
          '    </Scheme>'
          ''
          ''
          
            '      <Scheme name='#39'BadString'#39' inherit='#39'String'#39' defaultToken='#39'ba' +
            'dString'#39'>'
          '      </Scheme>'
          ''
          '      <Scheme name='#39'StringFind'#39'>'
          '        <Regex innerScheme='#39'BadString'#39' > '
          '            (&quot;|&apos;) (.*?\\ \1 )*? .* $ '
          '        </Regex>'
          ''
          '        <Regex innerScheme='#39'StringInterpolation'#39' priority='#39'10'#39'> '
          '            &quot; (.*?\\ &quot; )*? &quot;'
          '        </Regex>'
          ''
          '        <Regex innerScheme='#39'StringInterpolation'#39' priority='#39'20'#39'> '
          '            &quot; (.*?\\ &quot; )*? .*? [^\\] &quot;'
          '        </Regex>  '
          '        '
          '        <Regex innerScheme='#39'String'#39' priority='#39'10'#39'> '
          '            &apos; (.*?\\ &apos; )*? &apos;'
          '        </Regex>'
          ''
          '        <Regex innerScheme='#39'String'#39' priority='#39'20'#39'> '
          '            &apos; (.*?\\ &apos; )*? .*? [^\\] &apos;'
          '        </Regex>  '
          '        '
          '      </Scheme>'
          ''
          ''
          
            '    <Scheme name='#39'HereDoc'#39' inherit0='#39'StringInterpolation'#39' defaul' +
            'tToken='#39'string'#39'>'
          '        <SyntaxBlock capture="true">'
          '            <Start> blockStart  </Start>'
          '            <End> blockEnd  </End>'
          '        </SyntaxBlock>    '
          '    </Scheme>'
          ''
          
            '    <Scheme name='#39'Language'#39' inherit='#39'Numbers'#39' inherit0='#39'StringFi' +
            'nd'#39' '
          '            defaultToken='#39'default'#39'           '
          ''
          '            keywordsIgnoreCase='#39'false'#39
          '    >'
          '        <KeywordRegex>\b[a-z()A-Z_][\w_]*\b</KeywordRegex>'
          ''
          '        <Keywords>    '
          '            __LINE__            __FILE__ '
          '            __FUNCTION__        __CLASS__'
          '            __METHOD__'
          '            and     or  xor     exception '
          '            array   as  break   case'
          '            class   const       continue '
          '            declare default     die()       do  '
          '            echo    else        elseif      empty() '
          '            enddeclare          endfor      endforeach '
          '            endif   endswitch   endwhile    eval() '
          '            exit()  extends     for         foreach '
          
            '            function            global      if          include(' +
            ')           '
          '            include_once()      isset()     list()      '
          '            new     print()     require()   require_once()      '
          '            return()            static      switch '
          '            unset() use         var         while '
          '            final   php_user_filter         interface '
          '            implements          extends     public      '
          '            private protected   abstract    clone '
          '            try     catch       throw       cfunction '
          '            old_function '
          '            E_WARNING           E_ERROR                 E_PARSE'
          '            E_NOTICE            E_CORE_ERROR                '
          
            '            E_CORE_WARNING      E_COMPILE_ERROR         E_COMPIL' +
            'E_WARNING '
          
            '            E_USER_ERROR        E_USER_WARNING          E_USER_N' +
            'OTICE '
          '            E_STRICT            E_RECOVERABLE_ERROR     E_ALL '
          '        </Keywords>'
          ''
          '        <Regex innerScheme='#39'Comment'#39' regex='#39'//.*$'#39' />'
          '        '
          
            '        <RegexBlock start='#39'\/\*'#39' end='#39'\*\/'#39' end_token0='#39'comment'#39 +
            ' '
          '                innerScheme='#39'Comment'#39'/>'
          ''
          
            '        <Regex token0='#39'symbol'#39' regex='#39'[   \}   \{    \]    \[  \' +
            '( \) &gt; &lt; ]'#39' />'
          '        <Regex token0='#39'symbol'#39' regex='#39'[-:?\~=+!^;,]'#39' />'
          ''
          ''
          
            '        <RegexBlock innerScheme='#39'HereDoc'#39' start_token0='#39'blockSta' +
            'rt'#39' '
          '                    priority='#39'100'#39
          '                    end_token0='#39'blockEnd'#39' >'
          ''
          
            '            <Start>  [^ &lt; ]? &lt; &lt; &lt; (\w+)  </Start>  ' +
            '      '
          '            <End> ^ $1 ; </End>        '
          '        </RegexBlock>'
          ''
          '        <SkipSyntaxToken token='#39'comment'#39' />'
          ''
          '        <SyntaxBlock capture="true">'
          '            <Start> kw:function  id  sym:(  '
          '                    [^ sym:;    sym:}   sym:{   ]*  '
          '                    sym:) ( sym::   '
          '                    [^ sym:;    sym:}   sym:{   ]+   '
          '                    )? sym:{'
          '            </Start>'
          ''
          '            <End> sym:\}  </End>'
          '        </SyntaxBlock>'
          ''
          '        <SyntaxBlock capture="true" priority='#39'10'#39'>'
          '            <Start>                 '
          
            '                [ kw:while  kw:do kw:if  kw:else  kw:try kw:catc' +
            'h  kw:finally  kw:switch ]'
          '                                    '
          '                [^ sym:;  sym:}  ]*?    sym:\{'
          '            </Start>'
          ''
          '            <End> sym:}  </End>'
          '        </SyntaxBlock>'
          '            '
          ''
          
            '        <SyntaxBlock capture="true" priority='#39'100'#39'  startGroupUs' +
            'ed='#39'1'#39'>'
          '            <Start>'
          
            '                        (  [ kw:while  kw:if  kw:with ]  sym:(  ' +
            ' [^  sym:;   sym:}    sym:{   ]+ sym:)   )    '
          ''
          '                        [^ sym:{  sym:}  sym:; ]+ sym:;'
          ''
          '                '
          '            </Start>'
          ''
          '            <End> sym:;  </End>'
          '        </SyntaxBlock>'
          ''
          '        <SyntaxBlock capture="true">'
          '            <Start> kw:else sym:{  </Start>'
          '            <End> sym:}  </End>'
          '        </SyntaxBlock>'
          ''
          '        <SyntaxBlock capture="false" priority='#39'0'#39'  >'
          '            <Start> sym:{  </Start>'
          '            <End> sym:}  </End>'
          '        </SyntaxBlock>'
          ''
          '    </Scheme>'
          ''
          
            '    <Scheme name='#39'LanguageEmbed'#39' inherit='#39'Language'#39' defaultToken' +
            '='#39'defaultEmbed'#39'>'
          '    </Scheme>'
          '    '
          
            '    <Scheme name='#39'Main'#39' defaultToken='#39'default'#39' inherit='#39'HTML.Mai' +
            'n'#39'>'
          '    '
          '        <RegexBlock innerScheme='#39'LanguageEmbed'#39' '
          '                    start_token0='#39'tagOpen'#39' '
          '                    end_token0='#39'tagClose'#39'>'
          '            <Start> '
          '              &lt; \?(php)?'
          '            </Start>        '
          '            <End> \? &gt; </End>        '
          '        </RegexBlock>'
          ''
          '        <RegexBlock innerScheme='#39'LanguageEmbed'#39' '
          '                    start_token0='#39'tagOpen'#39' '
          '                    end_token0='#39'tagClose'#39' '
          '                    >'
          '            <Start> '
          '              &lt; %'
          '            </Start>        '
          '            <End> % &gt; </End>        '
          '        </RegexBlock>'
          ''
          '    </Scheme>'
          '</SchemeList>')
      end
      item
        Name = 'VB'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ''
          '<SchemeList root='#39'Main'#39'>'
          ''
          '  <Scheme name='#39'Text'#39' inherit='#39'Numbers'#39'>'
          '        <Regex token0='#39'email'#39'>'
          '            [_a-zA-Z\d\-\.]+ '
          '            @ '
          '            ([_ a-z A-Z \d \-]+ '
          '            (\. [_ a-z A-Z \d \-]+ )+ )'
          '        </Regex>'
          '  </Scheme>'
          ''
          '  <Scheme name='#39'Numbers'#39'>'
          
            '    <Regex token0='#39'number'#39'>\b (0x \d+ [lL]? | \d+ (e \d*)? [lLdD' +
            'fF]? ) \b</Regex>'
          
            '    <Regex token0='#39'number'#39'>\b [+\-]? \d+ (\. \d+)? ([eE] [+\-]? ' +
            '\d+) \b</Regex>'
          '  </Scheme>'
          ''
          
            '  <Scheme name='#39'Comment'#39' inherit='#39'Text'#39' defaultToken='#39'comment'#39'  ' +
            '/>'
          ''
          '  <Scheme name='#39'String'#39' inherit='#39'Text'#39' defaultToken='#39'string'#39'>'
          '  </Scheme>'
          ''
          
            '  <Scheme name='#39'BadString'#39' inherit='#39'String'#39' defaultToken='#39'badStr' +
            'ing'#39'>'
          '  </Scheme>'
          ''
          '  <Scheme name='#39'StringFind'#39'>'
          '    <Regex innerScheme='#39'BadString'#39' > '
          '        &quot; (.*?\\ &quot; )*? .* $ '
          '    </Regex>'
          ''
          '    <Regex innerScheme='#39'String'#39' priority='#39'10'#39'> '
          '        &quot; (.*?\\ &quot; )*? &quot; c?'
          '    </Regex>'
          ''
          '    <Regex innerScheme='#39'String'#39' priority='#39'20'#39'> '
          '        &quot; (.*?\\ &quot; )*? .*? [^\\] &quot; c?'
          '    </Regex>  '
          '  </Scheme>'
          ''
          ''
          ''
          '  <Scheme name='#39'Main'#39' inherit='#39'Numbers'#39' inherit0='#39'StringFind'#39
          '          defaultToken='#39'default'#39'           '
          ''
          '          allIgnoreCase='#39'true'#39
          '  >'
          '    <KeywordRegex>\b[a-zA-Z_][\w_]*\b</KeywordRegex>'
          ''
          '    <Keywords>'
          '            Empty False Nothing Null True'
          '            Initialize Terminate'
          '            Call Class End'
          '            Public  Private'
          '            Const'
          '            Dim'
          '            '
          '            Exit'
          '            Do While Until   '
          '            Loop '
          '            Erase '
          '            Execute '
          '            ExecuteGlobal '
          '            For Each  In   To'
          '            Next '
          '            Default'
          '            '
          '            If  Then  ElseIf Else   End '
          '            '
          '            On Error Resume Next GoTo '
          '            Option Explicit '
          '            Property Get  Set Let'
          '            Randomize ReDim  Preserve'
          '            Select Case  Else'
          '            Sub'
          '            While Wend  With '
          '            CreateObject'
          '            '
          '            Not Or And Xor Eqv Imp Is Mod '
          '            '
          '    </Keywords>'
          ''
          ''
          '    <Regex innerScheme='#39'Comment'#39' regex='#39'Rem.*$'#39' />'
          '    <Regex innerScheme='#39'Comment'#39' regex=" '#39'.*$ " />'
          ''
          
            '    <Regex token0='#39'symbol'#39' regex='#39'[    \]    \[  \( \) &gt; &lt;' +
            '  &amp; ]'#39' />'
          '    <Regex token0='#39'symbol'#39' regex='#39'[-=+^;,]'#39' />'
          ''
          '    <SkipSyntaxToken token='#39'comment'#39' />'
          ''
          '    <SyntaxBlock capture="true">'
          '        <Start> '
          
            '            [ kw:sub kw:class kw:if kw:function kw:property  kw:' +
            'select kw:with ]  '
          '        </Start>      '
          '        <End> kw:end  $0 </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="true">'
          '        <Start>   [ kw:do ]    </Start>'
          ''
          '        <End> kw:loop  </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="true">'
          '        <Start>   [ kw:for ]    </Start>'
          ''
          '        <End> kw:next  </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="true">'
          '        <Start>   [ kw:while ]    </Start>'
          ''
          '        <End> kw:wend  </End>'
          '    </SyntaxBlock>'
          '  </Scheme>'
          '</SchemeList>')
      end>
    ColorSchemes = <
      item
        Name = 'default'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          '<Attributes>'
          #9'<Token name="default" textColor="Black"/>'
          #9'<Token name="defaultEmbed" backgroundColor="#ECE9D8"/>'
          #9'<Token name="docStart" fontStyle="bold"/>'
          #9'<Token name="docEnd" fontStyle="bold"/>'
          #9'<Token name="docBlockStart" fontStyle="bold"/>'
          #9'<Token name="docBlockEnd" fontStyle="bold"/>'
          #9'<Token name="docInstruction" fontStyle="bold"/>'
          #9'<Token name="docDefault" backgroundColor="#ECE9D8"/>'
          #9'<Token name="comment" textColor="#008000"/>'
          #9'<Token name="commentStart" textColor="#008000"/>'
          #9'<Token name="commentEnd" textColor="#008000"/>'
          #9'<Token name="keyword" fontStyle="bold"/>'
          #9'<Token name="privateSymbol" textColor="Navy"/>'
          #9'<Token name="email" fontStyle="bold"/>'
          
            #9'<Token name="hairy" textColor="#000080" fontStyle="bold, italic' +
            ', underline, strikeOut"/>'
          #9'<Token name="number" textColor="Blue"/>'
          #9'<Token name="symbol" textColor="Blue"/>'
          #9'<Token name="string" textColor="Blue"/>'
          #9'<Token name="blockStart" fontStyle="bold"/>'
          #9'<Token name="blockEnd" fontStyle="bold"/>'
          #9'<Token name="badString" textColor="Red"/>'
          #9'<Token name="preprocessor" textColor="#008080"/>'
          #9'<Token name="badPreprocessor" textColor="red"/>'
          #9'<Token name="escaped" textColor="Navy"/>'
          
            #9'<Token name="quotedVariable" textColor="Navy" fontStyle="bold"/' +
            '>'
          #9'<Token name="regexStart" textColor="Navy" fontStyle="bold"/>'
          
            #9'<Token name="regexEnd" textColor="Navy" fontStyle="bold"/><!--h' +
            'tml/xml tokens-->'
          #9'<Token name="tagOpen" textColor="Purple"/>'
          #9'<Token name="tagClose" textColor="Purple"/>'
          
            #9'<Token name="dtdTagStartEnd" textColor="Purple" fontStyle="bold' +
            '"/>'
          #9'<Token name="url" textColor="Red"/>'
          #9'<Token name="fpi" textColor="Red" fontStyle="bold"/>'
          #9'<Token name="entity" textColor="#FF4500"/>'
          #9'<Token name="attributeName" textColor="#583485"/>'
          #9'<Token name="attributeValue" textColor="Blue"/>'
          #9'<Token name="cssRule" textColor="#583485" fontStyle="bold"/>'
          #9'<Token name="cssRelSymbol" fontStyle="bold"/>'
          
            #9'<Token name="cdataTagStart" textColor="Purple" fontStyle="bold"' +
            '/>'
          #9'<Token name="cdataTagEnd" textColor="Purple" fontStyle="bold"/>'
          
            #9'<Token name="xmlDeclStart" textColor="Purple" fontStyle="bold"/' +
            '>'
          #9'<Token name="xmlDeclEnd" textColor="Purple" fontStyle="bold"/>'
          '</Attributes>')
      end>
    ActiveSyntaxScheme = 'HTML'
    ActiveColorScheme = 'default'
    Left = 480
    Top = 224
  end
  object dlgColor: TColorDialog
    Options = [cdAnyColor]
    Left = 312
    Top = 240
  end
  object DocPascal: TLMDEditDocument
    Lines.Strings = (
      'unit Main;'
      ''
      'interface'
      ''
      'uses'
      
        '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Form' +
        's, Dialogs,'
      
        '  StdCtrls, ExtCtrls, Menus, ComCtrls, OleCtrls, Buttons, ToolWi' +
        'n, Isp3,'
      '  ActnList, ImgList, shdocvw;'
      ''
      'const'
      '  CM_HOMEPAGEREQUEST = WM_USER + $1000;'
      ''
      '  {Comment}'
      '  //Comment'
      'const  S  =  '#39'String here'#39';'
      ''
      'type'
      '  TMainForm = class(TForm)'
      '    StopAction: TAction;'
      '    procedure Exit1Click(Sender: TObject);'
      '    procedure About1Click(Sender: TObject);'
      '  private'
      '    HistoryIndex: Integer;'
      '  end;'
      ''
      'var'
      '  MainForm: TMainForm;'
      ''
      'implementation'
      ''
      'uses About;'
      ''
      '{$R *.DFM}'
      ''
      'procedure TMainForm.Exit1Click(Sender: TObject);'
      'begin'
      '  Close;'
      'end;'
      ''
      'procedure TMainForm.FindAddress;'
      'var'
      '  Flags: OLEVariant;'
      ''
      'begin'
      '  Flags := 0;'
      '  UpdateCombo := True;'
      
        '  WebBrowser1.Navigate(WideString(Urls.Text), Flags, Flags, Flag' +
        's, Flags);'
      'end;'
      ''
      ''
      'procedure TMainForm.HomePageRequest(var Message: TMessage);'
      'begin'
      '  URLs.Text := '#39#39';'
      '  FindAddress;'
      '  HistoryIndex := -1;'
      'end;'
      ''
      'end.')
    SyntaxSchemes = <
      item
        Name = 'Pascal'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ''
          '<SchemeList root='#39'Main'#39'>'
          ''
          '      <Scheme name='#39'Text'#39' inherit='#39'Numbers'#39'>'
          '            <Regex token0='#39'email'#39'>'
          '                [_a-zA-Z\d\-\.]+ '
          '                @ '
          '                ([_ a-z A-Z \d \-]+ '
          '                (\. [_ a-z A-Z \d \-]+ )+ )'
          '            </Regex>                '
          '      </Scheme>'
          ''
          '      <Scheme name='#39'Numbers'#39'>'
          
            '        <Regex token0='#39'number'#39'>\b (0x \d+ [lL]? | \d+ (e \d*)? [' +
            'lLdDfF]? ) \b</Regex>'
          
            '        <Regex token0='#39'number'#39'>\b [+\-]? \d+ (\. \d+)? ([eE] [+\' +
            '-]? \d+) \b</Regex>'
          '      </Scheme>'
          ''
          
            '      <Scheme name='#39'Comment'#39' inherit='#39'Text'#39' defaultToken='#39'commen' +
            't'#39'>'
          '        <Regex token0='#39'st'#39' regex='#39' [ {} ]   '#39' />'
          '        <Regex token0='#39'st'#39' regex='#39' ( \(\* )|( \*\) )   '#39' />'
          '                '
          '         <SyntaxBlock capture="true">'
          '            <Start> st:{  </Start>'
          '            <End> st:}  </End>'
          '         </SyntaxBlock>                '
          '         '
          '         <SyntaxBlock capture="true">'
          '            <Start> st:(*  </Start>'
          '            <End> st:*)  </End>'
          '         </SyntaxBlock>                         '
          '      </Scheme>'
          ''
          
            '      <Scheme name='#39'String'#39' inherit='#39'Text'#39' defaultToken='#39'string'#39 +
            '>'
          '      </Scheme>'
          ''
          
            '      <Scheme name='#39'BadString'#39' inherit='#39'String'#39' defaultToken='#39'ba' +
            'dString'#39'>'
          '      </Scheme>'
          ''
          '      <Scheme name='#39'StringFind'#39'>'
          '        <Regex innerScheme='#39'BadString'#39' > '
          '            &apos; (.*?\\ &apos; )*? .* $ '
          '        </Regex>'
          ''
          '        <Regex innerScheme='#39'String'#39' priority='#39'10'#39'> '
          '            &apos; (.*?\\ &apos; )*? &apos; '
          '        </Regex>'
          ''
          '        <Regex innerScheme='#39'String'#39' priority='#39'20'#39'> '
          '            &apos; (.*?\\ &apos; )*? .*? [^\\] &apos;'
          '        </Regex>  '
          '      </Scheme>'
          '    '
          
            '      <Scheme name='#39'Preprocessor'#39' defaultToken='#39'preprocessor'#39' in' +
            'herit='#39'Numbers'#39' >'
          ''
          '        <IdentRe>\b[a-zA-Z]+\b</IdentRe>'
          ''
          '        <Keywords>'
          '          if ifdef endif else ifend defined'
          '        </Keywords>'
          ''
          
            '        <Regex token0='#39'symbol'#39' regex='#39'[   \}   \{    \]    \[  \' +
            '( \) &gt; &lt; ]'#39' />'
          '        <Regex token0='#39'symbol'#39' regex='#39'[-=+]'#39' />'
          ''
          '      </Scheme>'
          '    '
          '    <Scheme name='#39'Main'#39' inherit='#39'StringFind'#39' '
          '            defaultToken='#39'default'#39'           '
          ''
          '            keywordsIgnoreCase='#39'false'#39
          '    >'
          '    <KeywordRegex>\b[a-zA-Z_][\w_]*\b</KeywordRegex>'
          ''
          '    <Keywords>'
          
            '        and     else    inherited   packed  then    array   end ' +
            '    initialization      procedure '
          
            '        threadvar       as          except  inline  program to  ' +
            '    asm                 exports '
          
            '        interface       property    try     begin   file    is  ' +
            '    raise               type '
          
            '        case            final       label   record  unit    clas' +
            's   finalization        library '
          
            '        repeat          unsafe      const   finally mod     reso' +
            'urcestring              until '
          
            '        constructor     for         nil     sealed  uses    dest' +
            'ructor                  function '
          
            '        not             set         var     dispinterface   goto' +
            '    object              shl '
          
            '        while           div         if      of      shr     with' +
            '    do                  implementation '
          
            '        or              static      xor     downto  in      out ' +
            '    string '
          ''
          
            '        absolute        dynamic     local   platform        requ' +
            'ires                    abstract '
          
            '        export          message     private                 resi' +
            'dent                    assembler '
          
            '        external        name        protected               safe' +
            'call                    automated '
          
            '        far             near        public  stdcall         cdec' +
            'l                       forward '
          
            '        nodefault       published   stored  contains        impl' +
            'ements                  overload '
          
            '        read            varargs     default index   override    ' +
            '                        readonly '
          
            '        virtual         deprecated  inline  package register    ' +
            '    write   dispid      library '
          '        pascal          reintroduce writeonly '
          '    </Keywords>'
          ''
          ''
          '    <Regex innerScheme='#39'Comment'#39' regex='#39'//.*$'#39' />'
          ''
          ''
          
            '    <RegexBlock start='#39'\(\*'#39' end='#39'\*\)'#39' end_token0='#39'comment'#39' pri' +
            'ority='#39'10'#39
          '                innerScheme='#39'Comment'#39'/>'
          ''
          
            '    <RegexBlock start='#39'\{\$'#39' end='#39'\}'#39' start_token0='#39'preprocessor' +
            #39' end_token0='#39'preprocessor'#39' priority='#39'100'#39
          '                innerScheme='#39'Preprocessor'#39'/>'
          ''
          
            '    <RegexBlock start='#39'\{'#39' end='#39'\}'#39' end_token0='#39'comment'#39' priorit' +
            'y='#39'100'#39
          '                innerScheme='#39'Comment'#39'/>'
          ''
          
            '    <Regex token0='#39'symbol'#39' regex='#39'[   \}   \{    \]    \[  \( \)' +
            ' &gt; &lt; ]'#39' />'
          '    <Regex token0='#39'symbol'#39' regex='#39'[-:?\~=+!^;,]'#39' />'
          ''
          ''
          '    <SkipSyntaxToken token='#39'comment'#39' />'
          ''
          '    <SyntaxBlock capture="true">'
          
            '        <Start> [ kw:procedure kw:function kw:destructor  kw:con' +
            'structor ] '
          '                [^ kw:procedure kw:initialization '
          '                   kw:finalization'
          '                   kw:implementation'
          '                   kw:destructor  '
          '                   kw:constructor'
          '                   kw:class'
          '                   kw:end ]+? kw:begin  </Start>'
          '        <End> kw:end  </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="true" priority='#39'100'#39' >'
          
            '        <Start> kw:if [^ kw:end sym:; ]+? kw:then  kw:begin </St' +
            'art>'
          '        <End> kw:end  </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="true">'
          
            '        <Start> [ kw:if kw:for kw:while kw:with kw:else  ]  [^ k' +
            'w:begin kw:end  sym:; ]+ </Start>'
          '        <End> sym:;  </End>'
          '    </SyntaxBlock>'
          ''
          ''
          '    <SyntaxBlock capture="true">'
          
            '        <Start> [ kw:with kw:for kw:while ] [^ kw:end  sym:; ]+?' +
            ' kw:do  kw:begin </Start>'
          '        <End> kw:end  </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="true">'
          
            '        <Start> id sym:= [ kw:class kw:record ]  [^ sym:; kw:of ' +
            ' ]</Start>'
          '        <End> kw:end  </End>'
          '    </SyntaxBlock>'
          ''
          '    <SyntaxBlock capture="false" priority='#39'0'#39'  >'
          '        <Start> kw:begin  </Start>'
          '        <End> kw:end  </End>'
          '    </SyntaxBlock>'
          ''
          '    </Scheme>'
          '</SchemeList>')
      end>
    ColorSchemes = <
      item
        Name = 'default'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ''
          '<Attributes>'
          '    <Token name="default" textColor="#0" />'
          ''
          '    <Token name="defaultEmbed" backgroundColor="#ECE9D8"  />'
          '    '
          '    <Token name="docStart" fontStyle="bold" />'
          '    <Token name="docEnd" fontStyle="bold" />'
          '    '
          '    <Token name="docBlockStart" fontStyle="bold" />'
          '    <Token name="docBlockEnd" fontStyle="bold" />'
          '    <Token name="docInstruction" fontStyle="bold" />    '
          '    '
          '    <Token name="docDefault" backgroundColor="#ECE9D8" />    '
          ''
          '    <Token name="comment" textColor="#008000" />'
          '    <Token name="commentStart" textColor="#008000" />'
          '    <Token name="commentEnd" textColor="#008000" />'
          ''
          '    <Token name="keyword" fontStyle="bold" />'
          '    '
          '    <Token name="privateSymbol" textColor="Navy" />    '
          ''
          '    <Token name="email" fontStyle="bold" />'
          ''
          
            '    <Token name="hairy" textColor="#000080" fontStyle="bold, ita' +
            'lic, underline, strikeOut" />'
          ''
          '    <Token name="number" textColor="Blue"  />'
          ''
          '    <Token name="symbol" textColor="Blue" />'
          ''
          '    <Token name="string" textColor="Blue" />'
          '    '
          '    <Token name="blockStart" fontStyle="bold" />'
          '    <Token name="blockEnd" fontStyle="bold" />'
          ''
          '    <Token name="badString" textColor="Red" />    '
          ''
          '    <Token name="preprocessor" textColor="#008080" />'
          '    <Token name="badPreprocessor" textColor="red" />'
          ''
          '    <Token name="escaped" textColor="Navy" />'
          
            '    <Token name="quotedVariable" textColor="Navy" fontStyle="bol' +
            'd" />'
          '    '
          
            '    <Token name="regexStart" textColor="Navy" fontStyle="bold" /' +
            '>    '
          
            '    <Token name="regexEnd" textColor="Navy" fontStyle="bold" /> ' +
            '   '
          '    '
          '    '
          '    <!--html/xml tokens-->'
          '    '
          '    <Token name="tagOpen" textColor="Purple" />'
          ''
          '    <Token name="tagClose" textColor="Purple" />'
          '    '
          '    <Token name="dtdTagStartEnd" '
          '           textColor="Purple" fontStyle="bold" />    '
          '                      '
          '    <Token name="url"  textColor="Red" />'
          '    <Token name="fpi"  textColor="Red" fontStyle="bold" />    '
          ''
          '    <Token name="entity" textColor="#FF4500" />'
          ''
          '    <Token name="attributeName" textColor="#583485" />'
          '    '
          '    <Token name="attributeValue" textColor="Blue" />'
          ''
          '    '
          '    <Token name="cssRule"  '
          '           textColor="#583485" '
          '           fontStyle="bold"'
          '    />           '
          '    '
          '    <Token name="cssRelSymbol"  '
          '           fontStyle="bold"'
          '    />           '
          ''
          '    <Token name="cdataTagStart" '
          '           textColor="Purple" fontStyle="bold" />    '
          ''
          '    <Token name="cdataTagEnd" '
          '           textColor="Purple" fontStyle="bold" />    '
          ''
          '    <Token name="xmlDeclStart" '
          '           textColor="Purple" fontStyle="bold" />    '
          ''
          '    <Token name="xmlDeclEnd" '
          '           textColor="Purple" fontStyle="bold" />    '
          '    '
          '</Attributes>')
      end>
    ActiveSyntaxScheme = 'Pascal'
    Left = 480
    Top = 296
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'xml'
    Filter = 'Schemes|*.xml|Any files|*.*'
    Left = 48
    Top = 72
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xml'
    Filter = 'Schemes|*.xml|Any files|*.*'
    Left = 48
    Top = 104
  end
end
