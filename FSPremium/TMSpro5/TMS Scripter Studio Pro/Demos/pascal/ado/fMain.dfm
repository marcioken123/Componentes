�
 TFORM1 0�  TPF0TForm1Form1LeftLTop� Width�HeightdCaptionFTatPascalScripter with ADO to initialize form combobox from a databaseColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderPixelsPerInch`
TextHeight TLabelLabel1LeftToppWidth2HeightCaptionCountries :  TLabelLabel2LeftXTopWidthDHeightCaptionScript source :  TLabelLabel3LeftXTop�Width2HeightCaptionScript log :  TLabelLabel4Left`ToppWidth HeightCaption7(values initialized through TatPascalScripter with ADO)  TButtonButton1LeftTopWidthKHeightCaptionExec scriptTabOrder OnClickButton1Click  TListBoxlogLeftXTop�Width1Height� 
ItemHeightTabOrder  	TComboBoxcountrycomboLeftXToppWidthHeightStylecsDropDownList
ItemHeightTabOrder  TAdvMemoAdvMemo1LeftXTopWidth1HeightACursorcrIBeam!ActiveLineSettings.ShowActiveLine*ActiveLineSettings.ShowActiveLineIndicatorAutoCompletion.Font.CharsetDEFAULT_CHARSETAutoCompletion.Font.ColorclWindowTextAutoCompletion.Font.Height�AutoCompletion.Font.NameMS Sans SerifAutoCompletion.Font.Style AutoCorrect.Active	AutoHintParameterPositionhpBelowCodeBlockLineColorclGrayBorderStylebsSingleCtl3DDelErase	EnhancedHomeKeyGutter.DigitCountGutter.Font.CharsetDEFAULT_CHARSETGutter.Font.ColorclWindowTextGutter.Font.Height�Gutter.Font.NameCourier NewGutter.Font.Style Gutter.LineNumberStartGutter.LineNumberTextColorclBlackGutter.ShowLineNumbers	Gutter.Visible	Gutter.ShowLeadingZerosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameCOURIER NEW
Font.Style HiddenCaretLines.Strings6log.Items.Add('Start ADO demo for TatPascalScripter');0ObjConnC := CreateOleObject('ADODB.Connection');(log.Items.Add('ADO connection created');FmyDSN := 'Driver={Microsoft Access Driver (*.mdb)};DBQ=countries.mdb'; ObjConnC.Open(myDSN);'log.Items.Add('ADO connection opened');-ObjRSC := CreateOleObject('ADODB.RecordSet');#mySQL := 'SELECT * FROM COUNTRIES';$ObjRSC.ActiveConnection := ObjConnC;ObjRSC.Open(mySQL);i := 0;countrycombo.Items.Clear;while (ObjRSC.Eof = False) dobegin  { get the field }%  fld := ObjRSC.Fields('COUNTRY');   !  { add field value to combobox }%  countrycombo.Items.Add( fld.value);  { count nr. of items added }  i := i + 1;  ObjRSC.MoveNext;end;/log.items.Add('Added '+inttostr(i)+' records');ObjRSC.Close;ObjConnC.Close;'log.items.Add('ADO connection closed');4{ Pre initialize the selected country in the combo }countrycombo.ItemIndex := 12;ShowMessage('Script executed');  %MarkerList.UseDefaultMarkerImageIndex"MarkerList.DefaultMarkerImageIndex� MarkerList.ImageTransparentColor�PrintOptions.MarginLeft PrintOptions.MarginRight PrintOptions.MarginTop PrintOptions.MarginBottom PrintOptions.PageNrPrintOptions.PrintLineNumbersRightMarginColor��� 
ScrollHintSelColorclWhite
SelBkColorclNavyShowRightMargin		SmartTabsSyntaxStylesAdvPascalMemoStyler1TabOrderTabSizeTabStop	TrimTrailingSpaces	UndoLimitdUrlStyle.TextColorclBlueUrlStyle.BkColorclWhiteUrlStyle.StylefsUnderline 	UseStyler	Version1.6.0.8WordWrapwwNone  TatPascalFormScripteratPascalFormScripter1SaveCompiledCodeShortBooleanEvalLeft(Topp  TAdvPascalMemoStylerAdvPascalMemoStyler1
BlockStartbeginBlockEndendLineComment//MultiCommentLeft{MultiCommentRight}CommentStyle.TextColorclNavyCommentStyle.BkColorclWhiteCommentStyle.StylefsItalic NumberStyle.TextColor	clFuchsiaNumberStyle.BkColorclWhiteNumberStyle.StylefsBold 	AllStylesKeyWords.Stringsbeginbreakclassclassconstconstructorcontinuedefault
destructordoelseendfinaliseforfunctionifimplementation	inherited
initialise	interfacenotoverrideprivate	procedureproperty	protectedpublic	publishedrepeatstoredthentotypeunituntilusesvarvirtualwhilewith Font.CharsetDEFAULT_CHARSET
Font.ColorclGreenFont.Height�	Font.NameCourier New
Font.Style BGColorclWhite	StyleType	stKeywordBracketStart 
BracketEnd InfoPascal Standard Default Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameCourier New
Font.Style BGColorclWhite	StyleType	stBracketBracketStart 
BracketEnd InfoSimple Quote Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameCourier New
Font.Style BGColorclWhite	StyleType	stBracketBracketStart 
BracketEnd InfoDouble Quote Font.CharsetDEFAULT_CHARSET
Font.ColorclTealFont.Height�	Font.NameCourier New
Font.Style BGColorclWhite	StyleTypestSymbolBracketStart 
BracketEnd Symbols ,;:.(){}[]=-*/^%<>#
InfoSymbols Delimiters  AutoCompletion.StringsShowMessage
MessageDlg HintParameter.TextColorclBlackHintParameter.BkColorclInfoBkHintParameter.HintCharStart(HintParameter.HintCharEnd)HintParameter.HintCharDelimiter;$HintParameter.HintCharWriteDelimiter, HintParameter.Parameters.StringsShowMessage(const Msg: string);iMessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer); HexIdentifier$DescriptionPascalFilter>Pascal Files (*.pas,*.dpr,*.dpk,*.inc)|*.pas;*.dpr;*.dpk;*.incDefaultExtension.pas
StylerNamePascal
Extensionspas;dpr;dpk;incLeft(Top�    