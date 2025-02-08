object LMDSedSchemeEditDlg: TLMDSedSchemeEditDlg
  Left = 170
  Top = 184
  Caption = 'Edit scheme'
  ClientHeight = 396
  ClientWidth = 546
  Color = clBtnFace
  Constraints.MinHeight = 204
  Constraints.MinWidth = 269
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    546
    396)
  PixelsPerInch = 96
  TextHeight = 14
  object Button1: TButton
    Left = 367
    Top = 364
    Width = 80
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 456
    Top = 364
    Width = 80
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object LMDEditView1: TLMDEditView
    Left = 9
    Top = 9
    Width = 527
    Height = 348
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    Document = Doc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    CustomKeyBindings = <>
    GutterBarsEmpty = False
  end
  object Button3: TButton
    Left = 8
    Top = 364
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Load...'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 89
    Top = 364
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Save...'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Doc: TLMDEditDocument
    Lines.Strings = (
      '')
    SyntaxSchemes = <
      item
        Name = 'XML'
        Scheme.Strings = (
          '<?xml version="1.0" encoding="UTF-8"?>'
          ' '
          '<SchemeList root='#39'Main'#39'>'
          ''
          '  <Scheme name='#39'BaseSyntax'#39'>'
          '    <Regex token0='#39'entity'#39'>'
          '        &amp;[a-zA-Z]+;'
          '    </Regex>'
          ''
          '    <RegexBlock innerScheme='#39'Comment'#39' end_token0='#39'comment'#39' >'
          '        <Start> &lt; !--  </Start>        '
          '        <End> --&gt; </End>        '
          '    </RegexBlock>'
          ''
          '  </Scheme>'
          ''
          '  <Scheme name='#39'InsideTag'#39' inherit='#39'BaseSyntax'#39'>'
          
            '    <RegexBlock innerScheme='#39'CDATA'#39' start_token0='#39'cdataTagStart'#39 +
            ' end_token0='#39'cdataTagEnd'#39' >'
          '        <Start> &lt; !\[\[CDATA  </Start>'
          '        <End> \]\] &gt; </End>        '
          '    </RegexBlock>'
          '  </Scheme>'
          '  '
          '  <Scheme name='#39'WithTags'#39' inherit='#39'Tag'#39' inherit0='#39'BaseSyntax'#39'>'
          '  '
          
            '    <RegexBlock innerScheme='#39'WithTags'#39' start_token0='#39'tagOpen'#39' en' +
            'd_token0='#39'tagClose'#39' >'
          '        <Start> &lt; ([\w:]+) </Start>        '
          '        <End> ( / &gt; ) | ( &lt; / $1 &gt; ) </End>        '
          '    </RegexBlock>  '
          ''
          
            '    <RegexBlock innerScheme='#39'InsideTag'#39' start_token0='#39'tagOpen'#39' e' +
            'nd_token0='#39'tagClose'#39' >'
          '        <Start> &gt;  </Start>        '
          '        <End> (?= &lt; [^ ! ] ) </End>        '
          '    </RegexBlock>  '
          ''
          ''
          '    <SyntaxBlock capture='#39'true'#39'>'
          '        <Start> tagOpen </Start>'
          '        <End> tagClose </End>'
          '    </SyntaxBlock>'
          '    '
          '  </Scheme>'
          ''
          '  <Scheme name='#39'Comment'#39' defaultToken='#39'comment'#39'>'
          '  </Scheme>'
          ''
          '  <Scheme name='#39'XmlDecl'#39' inherit='#39'Tag'#39'>'
          '  </Scheme>'
          ''
          '  <Scheme name='#39'CDATA'#39' defaultToken='#39'xmlCdata'#39'>'
          '    <SyntaxBlock capture='#39'true'#39'>'
          '        <Start> cdataTagStart </Start>'
          '        <End> cdataTagEnd </End>'
          '    </SyntaxBlock>  '
          '  </Scheme>    '
          '    '
          '  <Scheme name='#39'DTD'#39' defaultToken='#39'comment'#39'>               '
          '  </Scheme>'
          '    '
          '  <Scheme name='#39'AttrStringQuot'#39'>'
          '    <Regex token0='#39'attributeValue'#39'> [^ &quot; ]+</Regex>'
          '  </Scheme>'
          ''
          '  <Scheme name='#39'AttrStringApos'#39'>'
          '    <Regex token0='#39'attributeValue'#39'> [^ &apos; ]+</Regex>'
          '  </Scheme>'
          '    '
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
          '          inherit='#39'BaseSyntax'#39'        '
          '          inherit0='#39'WithTags'#39'      '
          '          keywordsIgnoreCase='#39'true'#39' >'
          '                    '
          ''
          
            '    <RegexBlock innerScheme='#39'DTD'#39' start_token0='#39'dtdTagStartEnd'#39' ' +
            'end_token0='#39'dtdTagStartEnd'#39' >'
          '        <Start> &lt; !\w+  </Start>        '
          '        <End> &gt; </End>        '
          '    </RegexBlock>'
          '                    '
          '    <Regex token0='#39'tagClose'#39'>'
          '        &lt; / [\w:]+ \s* &gt;'
          '    </Regex>'
          ''
          
            '    <RegexBlock innerScheme='#39'XmlDecl'#39' start_token0='#39'xmlDeclStart' +
            #39' end_token0='#39'xmlDeclEnd'#39' >'
          '        <Start> &lt; \? xml  </Start>'
          '        <End> \? &gt; </End>        '
          '    </RegexBlock>'
          ''
          ''
          '  </Scheme>'
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
    ActiveSyntaxScheme = 'XML'
    ActiveColorScheme = 'default'
    Left = 48
    Top = 40
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
