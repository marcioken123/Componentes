unit LMDRTFSyntaxEdit;
{$I LMDCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDRTFSyntaxEdit unit (DS, VO)
------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RichEdit, LMDRTFRichEdit, LMDTypes;

type
  TLMDRichSyntaxDefinition = class;

  // used internally
  TLMDRichChangeType = (ctUndo, ctUnknown, ctReplSel, ctDelete, ctBack, ctCut, ctPaste, ctMove, ctNone);

{*************************** TLMDCustomRichSyntaxEdit  *******************************}
  TLMDCustomRichSyntaxEdit = class(TLMDCustomRichEdit)
  private
    { Private declarations }
    FSyntaxDefinition: TLMDRichSyntaxDefinition;
    FChangeType: TLMDRichChangeType;
    FOldSel: TCharRange;
    FForcedChange: Boolean;
    procedure SetSyntaxDefinition(const Value: TLMDRichSyntaxDefinition);
  protected
    { Protected declarations }
    procedure Parse(aStart, aEnd: LongInt); virtual;
    procedure ParseLines(aStart, aEnd: LongInt);
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  procedure Change; override;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure Loaded; override;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure ParseAll;
    property SyntaxDefinition: TLMDRichSyntaxDefinition read FSyntaxDefinition write SetSyntaxDefinition;
  end;

{*************************** TLMDRichSyntaxEdit  *******************************}
  TLMDRichSyntaxEdit = class(TLMDCustomRichSyntaxEdit)
  published
    { Published declarations }
    property SyntaxDefinition;
    property AcceptDropFiles;
    property Align;
    property Alignment;
    property Anchors;
    property AutoURLDetect;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
    property Constraints;
    property Lines;
    property LanguageOptions;
    property MaxLength;
    property Mode;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ReadOnly;
    property RichStorage;
    property RichStorageItem;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Title;
    property UndoLimit;
    property Visible;
    property WantTabs;
    property WantReturns;
    property WordWrap;
    property Zoom;
    property OnChange;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
    property OnStartDock;
    property OnStartDrag;
    property OnURLClick;
    property OnRulerTabCreate;
    property OnRulerTabChange;
    property OnRulerTabDestroy;
    property OnRulerFirstIdentChange;
    property OnRulerLeftIdentChange;
    property OnRulerRightIdentChange;
  end;

  {*************************** TLMDRichSyntaxDefinition  **********************}
  TLMDRichSyntaxDefinition = class(TPersistent)
  private
    FKeywords: TStrings;
    FSyntaxEdit: TLMDCustomRichSyntaxEdit;
    FKeywordFont: TFont;
    FStringFont: TFont;
    FStringDelim: Char;
    FSingleLineComments: TStrings;
    FCommentsFont: TFont;
    FNumbersFont: TFont;
    FSpaces: TSysCharSet;
    FDelimiters: TSysCharSet;
    procedure SetKeywords(const Value: TStrings);
    procedure SetKeywordFont(const Value: TFont);
    procedure SetStringFont(const Value: TFont);
    procedure SetStringDelim(const Value: Char);
    procedure SetSingleLineComments(const Value: TStrings);
    procedure SetCommentsFont(const Value: TFont);
    procedure SetNumbersFont(const Value: TFont);
  public
    constructor Create(aSyntaxEdit: TLMDCustomRichSyntaxEdit);
    destructor Destroy; override;
    procedure LoadFromFile(const aFileName: string);
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToFile(const aFileName: string);
    procedure SaveToStream(aStream: TStream);
    property Spaces: TSysCharSet read FSpaces write FSpaces;
    property Delimiters: TSysCharSet read FDelimiters write FDelimiters;
  published
    property Keywords: TStrings read FKeywords write SetKeywords;
    property SingleLineComments: TStrings read FSingleLineComments write
    SetSingleLineComments;
    property KeywordFont: TFont read FKeywordFont write SetKeywordFont;
    property StringFont: TFont read FStringFont write SetStringFont;
    property CommentsFont: TFont read FCommentsFont write SetCommentsFont;
    property NumbersFont: TFont read FNumbersFont write SetNumbersFont;
    property StringDelim: Char read FStringDelim write SetStringDelim;
  end;

implementation

//uses
//  Windows, Forms;

type
  TTokenType =
    (ttNormalText, ttKeyWord, ttComment, ttString,
    ttNumber, ttDelim, ttEOF);

  TTextRange = record
    SelStart: LongInt;
    SelEnd: LongInt;
  end;

  TToken = record
    TokenRange: TTextRange;
    TokenType: TTokenType;
  end;

const
  c_Spaces: set of AnsiChar = [#0, #10, #13, #9, #32];
  c_Delimiters: set of AnsiChar =
    [',', '.', ':', ';', '-', '+', '*', '\', '/', '(', ')', '[', ']', '~'..'|',
     '?', '<', '>', '''', '"'];

{*************************** TLMDCustomRichSyntaxEdit  ***************************}
{-----------------------------------------------------------------------------}
procedure TLMDCustomRichSyntaxEdit.Change;
var
  FCurSel: TCharRange;
begin

  inherited;
//  DefAttributes.Protected:= true;
//  SelAttributes.Protected:= true;
  if FForcedChange or not Assigned(Parent) then Exit;
  FCurSel.cpMin:= SelStart;
  FCurSel.cpMax:= SelStart + SelLength;
  // cut was canceled, so this is paste operation
  if (FChangeType = ctMove) and (FCurSel.cpMin = FCurSel.cpMax) then
    FChangeType:= ctPaste;

  case FChangeType of
    ctReplSel, // old=(x,y) -> cur=(x+len,x+len)
      ctPaste: // old=(x,y) -> cur=(x+len,x+len)
      ParseLines(FOldSel.cpMin, FCurSel.cpMax);
    ctDelete, // old=(x,y) -> cur=(x,x)
      ctBack, // old=(x,y) -> cur=(x,x), newline del => old=(x,x+1) -> cur=(x-1,x-1)
      ctCut: // old=(x,y) -> cur=(x,x)
      ParseLines(FCurSel.cpMin, FCurSel.cpMax);
    ctUndo: // old=(?,?) -> cur=(x,y)
      ParseLines(FCurSel.cpMin, FCurSel.cpMax);
    ctMove:
      begin // old=(x,x+len) -> cur=(y-len,y) | cur=(y,y+len)
        ParseLines(FCurSel.cpMin, FCurSel.cpMax);
        if (FCurSel.cpMin > FOldSel.cpMin) then // move after
          ParseLines(FOldSel.cpMin, FOldSel.cpMin)
        else // move before
          ParseLines(FOldSel.cpMax, FOldSel.cpMax);
      end;
    ctNone: ;
  else
    ParseAll;
  end;
  //undo action does not call OnProtected, so make it default
//  FChangeType:= ctUndo;
  FChangeType:= ctNone;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomRichSyntaxEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then ParseAll;
end;

{-----------------------------------------------------------------------------}

{-----------------------------------------------------------------------------}
procedure TLMDCustomRichSyntaxEdit.CNNotify(var Message: TWMNotify);
begin
  inherited;
  if Message.NMHdr.code = EN_PROTECTED then
    begin
    case PENProtected(Message.NMHdr).msg of
    WM_KEYDOWN:
        case PENProtected(Message.NMHdr)^.wParam of
        VK_DELETE: FChangeType:= ctDelete;
            VK_BACK: FChangeType:= ctBack;
          else
            FChangeType:= ctUnknown;
          end;

        EM_REPLACESEL, WM_CHAR: FChangeType:= ctReplSel;

        WM_PASTE:
          if FChangeType = ctCut then
            FChangeType:= ctMove
          else
            FChangeType:= ctPaste;

        WM_CUT: FChangeType:= ctCut;

        EM_SETCHARFORMAT:
           {FChangeType:= ctCharFormat};
      else
        FChangeType:= ctUnknown;
      end;
    if (PENProtected(Message.NMHdr)^.msg <> EM_SETCHARFORMAT) and
    (FChangeType <> ctMove) then
      FOldSel:= PENProtected(Message.NMHdr)^.chrg;
      Message.Result:= 0;
    end;
end;

{-----------------------------------------------------------------------------}
constructor TLMDCustomRichSyntaxEdit.Create(aOwner: TComponent);
begin
  inherited;
  PlainText:= true;
  WordWrap:= false;
  FSyntaxDefinition:= TLMDRichSyntaxDefinition.Create(Self);
  DefAttributes.Protected:= true;
  SelAttributes.Protected:= true;
  FChangeType:= {ctUndo}ctNone;
  FForcedChange:= False;
  FOldSel.cpMin:= 0;
  FOldSel.cpMax:= 0;
end;

{-----------------------------------------------------------------------------}
destructor TLMDCustomRichSyntaxEdit.Destroy;
begin
  FreeAndNil(FSyntaxDefinition);
  inherited;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomRichSyntaxEdit.Loaded;
begin
  inherited;
  ParseAll;
  DefAttributes.Protected:= true;
  SelStart:= 0;
  SelLength:= Length(Text);
  SelAttributes.Protected:= true;
  SelLength:= 0;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomRichSyntaxEdit.Parse(aStart, aEnd: Integer);
var
  FToken: TToken;
  FParserPosition: LongInt;
  FText: String;
  FTxtLength: LongInt;

  procedure SkipSpaces;
  begin
    while (FParserPosition <= FTxtLength) and
      (AnsiChar(FText[FParserPosition]) in SyntaxDefinition.Spaces) do
      begin
        Inc(FParserPosition);
      end;
  end;

  function GetToken: TToken;
  var
    I: LongInt;
  begin
    SkipSpaces;
    if FParserPosition > FTxtLength then
      begin
        Result.TokenType:= ttEOF;
        Exit;
      end;
    Result.TokenRange.SelStart:= FParserPosition - 1 { - FSkipped13};

    Result.TokenType:= ttNormalText;

  // Check delimiters
    if AnsiChar(FText[FParserPosition]) in SyntaxDefinition.Delimiters then
      begin
    //Check String
        if FText[FParserPosition] = SyntaxDefinition.StringDelim then
          begin
            Inc(FParserPosition); // Skip delim
            while (FText[FParserPosition] <> SyntaxDefinition.StringDelim) and
              (FParserPosition < FTxtLength) and
              (FText[FParserPosition] <> #10) do
              begin
                Inc(FParserPosition);
              end;
            Result.TokenType:= ttString;
            Result.TokenRange.SelEnd:= FParserPosition { - FSkipped13};
            Inc(FParserPosition); // Skip delim
            Exit;
          end
        else
          begin // Check single line comment
            for I:= 0 to SyntaxDefinition.SingleLineComments.Count - 1 do
              begin
                if SyntaxDefinition.SingleLineComments[I] =
                  Copy(FText, FParserPosition,
                  Length(SyntaxDefinition.SingleLineComments[I])) then
                  begin
                    while (FParserPosition < FTxtLength) and
                      (FText[FParserPosition] <> #10) and
                      (FText[FParserPosition] <> #13) do
                      Inc(FParserPosition);
                    Result.TokenType:= ttComment;
                    Result.TokenRange.SelEnd:= FParserPosition;
                    Exit;
                  end;
              end;
          end;
    // it's delimiter...
        Result.TokenType:= ttDelim;
        Inc(FParserPosition); // Skip delim
        Exit;
      end;
  //Check numbers
    if AnsiChar(FText[FParserPosition]) in ['0'..'9'] then
      begin
        while (AnsiChar(FText[FParserPosition]) in ['0'..'9']) and
          (FParserPosition <= FTxtLength) do
          Inc(FParserPosition);
        Result.TokenRange.SelEnd:= FParserPosition;
        Result.TokenType:= ttNumber;
        Exit;
      end;

  // extract text
    while (FParserPosition <= FTxtLength) and
      not (AnsiChar(FText[FParserPosition]) in SyntaxDefinition.Spaces) and
      not (AnsiChar(FText[FParserPosition]) in SyntaxDefinition.Delimiters) do
      begin
        Inc(FParserPosition);
      end;
    Result.TokenRange.SelEnd:= FParserPosition;

// Check keywords
    if SyntaxDefinition.Keywords.IndexOf(
      Copy(FText, Result.TokenRange.SelStart + 1, Result.TokenRange.SelEnd -
      Result.TokenRange.SelStart - 1)) <> -1 then
      begin
        Result.TokenType:= ttKeyword;
      end;
//  ShowMessage( '"'+Copy( FText, Result.TokenRange.SelStart + 1 {+ FSkipped13}, Result.TokenRange.SelEnd -
//    Result.TokenRange.SelStart - 1) +'"');
  end;

var
  oldSelStart: LongInt;
  oldSelLength: LongInt;
//  WindowLocked: Boolean;
  CharRange: TCharRange;
  OldEventMask: dword;

begin
//  if  not HandleAllocated then
//    System .exit;
//  if aStart >= aEnd then Exit;
  FParserPosition:= 1;

  oldSelStart:= SelStart;
  oldSelLength:= SelLength;
  FText:= String(GetTextRange(aStart, aEnd));
  FTxtLength:= Length(FText);

//  FSkipped13:= 0;
  FForcedChange:= true;
  OldEventMask := Perform(EM_GETEVENTMASK, 0, 0);

  try
    Perform(EM_SETEVENTMASK, 0, ENM_NONE);
    Perform(WM_SETREDRAW, 0, 0);

    repeat
      FToken:= GetToken;
      if FToken.TokenType <> ttEOF then
        begin
          CharRange.cpMin := aStart + FToken.TokenRange.SelStart;
          CharRange.cpMax := CharRange.cpMin + FToken.TokenRange.SelEnd - FToken.TokenRange.SelStart;
          if CharRange.cpMax - CharRange.cpMin > 0 then
            begin
            Perform(EM_EXSETSEL, 0, TLMDPtrInt(@CharRange));
            case FToken.TokenType of
                ttNormalText, ttDelim: SelAttributes.Assign(Font);
                ttKeyWord: SelAttributes.Assign(SyntaxDefinition.KeywordFont);
                ttComment: SelAttributes.Assign(SyntaxDefinition.CommentsFont);
                ttString: SelAttributes.Assign(SyntaxDefinition.StringFont);
                ttNumber: SelAttributes.Assign(SyntaxDefinition.NumbersFont);
                ttEOF: ;
              end;
            end;
        end;
    until (FToken.TokenType = ttEOF);

    SelStart:= oldSelStart;
    SelLength:= oldSelLength;
  finally
  //  if WindowLocked then LockWindowUpdate(0);
    Perform(WM_SETREDRAW, 1, 0);
    Perform(EM_SETEVENTMASK, 0, OldEventMask);
    InvalidateRect(Handle, nil, true);
    FForcedChange:= false;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomRichSyntaxEdit.ParseAll;
var
  OldCurs: TCursor;
begin
  OldCurs := Screen.Cursor;

  try
    Screen.Cursor := crHourGlass;
    Parse(0, Self.GetTextLen)
  finally
    Screen.Cursor := OldCurs;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomRichSyntaxEdit.ParseLines(aStart, aEnd: LongInt);
var
  aLen: LongInt;
begin
  aStart:= SendMessage(Handle, EM_EXLINEFROMCHAR, 0, aStart);
  aStart:= SendMessage(Handle, EM_LINEINDEX, aStart, 0);
  aLen:= SendMessage(Handle, EM_LINELENGTH, aEnd, 0);
  aEnd:= SendMessage(Handle, EM_EXLINEFROMCHAR, 0, aEnd);
  aEnd:= SendMessage(Handle, EM_LINEINDEX, aEnd, 0) + aLen;
  Parse(aStart, aEnd);
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomRichSyntaxEdit.SetSyntaxDefinition(
  const Value: TLMDRichSyntaxDefinition);
begin
  FSyntaxDefinition.Assign(Value);
end;

{*********************** TLMDRichSyntaxDefinition  *******************************}
{-----------------------------------------------------------------------------}
constructor TLMDRichSyntaxDefinition.Create(aSyntaxEdit: TLMDCustomRichSyntaxEdit);
begin
  inherited Create;
  FSyntaxEdit:= aSyntaxEdit;
  FKeywords:= TStringList.Create;
  FKeywordFont:= TFont.Create;
  FKeywordFont.Style:= [fsBold];
  FStringFont:= TFont.Create;
  FStringFont.Color:= clBlue;
  FCommentsFont:= TFont.Create;
  FCommentsFont.Color:= clGreen;
  FNumbersFont:= TFont.Create;
  FNumbersFont.Color:= clMaroon;
  FStringDelim:= '''';
  FSingleLineComments:= TStringList.Create;
  FSpaces := c_Spaces;
  FDelimiters := c_Delimiters;
end;

{-----------------------------------------------------------------------------}
destructor TLMDRichSyntaxDefinition.Destroy;
begin
  FreeAndNil(FSingleLineComments);
  FreeAndNil(FNumbersFont);
  FreeAndNil(FCommentsFont);
  FreeAndNil(FKeywordFont);
  FreeAndNil(FStringFont);
  FreeAndNil(FKeywords);
  inherited;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SetKeywords(const Value: TStrings);
begin
  FKeywords.Assign(Value);
  if not (csLoading in FSyntaxEdit.ComponentState) then
    FSyntaxEdit.ParseAll;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SetKeywordFont(const Value: TFont);
begin
  FKeywordFont.Assign(Value);
  if not (csLoading in FSyntaxEdit.ComponentState) then FSyntaxEdit.ParseAll;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SetStringFont(const Value: TFont);
begin
  FStringFont.Assign(Value);
  if not (csLoading in FSyntaxEdit.ComponentState) then FSyntaxEdit.ParseAll;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SetStringDelim(const Value: Char);
begin
  FStringDelim:= Value;
  if not (csLoading in FSyntaxEdit.ComponentState) then
    FSyntaxEdit.ParseAll;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SetSingleLineComments(const Value: TStrings);
begin
  FSingleLineComments.Assign(Value);
  if not (csLoading in FSyntaxEdit.ComponentState) then FSyntaxEdit.ParseAll;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SetCommentsFont(const Value: TFont);
begin
  FCommentsFont.Assign(Value);
  if not (csLoading in FSyntaxEdit.ComponentState) then
    FSyntaxEdit.ParseAll;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SetNumbersFont(const Value: TFont);
begin
  FNumbersFont.Assign(Value);
  if not (csLoading in FSyntaxEdit.ComponentState) then FSyntaxEdit.ParseAll;
end;

// Helpers
{-----------------------------------------------------------------------------}
type
  TLMDWriter = class(TWriter)
  public
    procedure WriteProperties(Instance: TPersistent);
  end;

type
  TLMDReader = class(TReader)
  public
    procedure ReadProperty(Instance: TPersistent);
  end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.LoadFromFile(const aFileName: string);
var
  S: TFileStream;
begin
  S:= TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.LoadFromStream(aStream: TStream);
var
  Reader: TLMDReader;
  M: TMemoryStream;
begin
  M:= TMemoryStream.Create;
  try
    ObjectTextToBinary(aStream, M);
  M.Seek(soFromBeginning, 0);
  Reader:= TLMDReader.Create(M, 4096);
    try
      Reader.ReadSignature;
      Reader.ReadStr; {ClassName}
      Reader.ReadStr; {NAME}
      while not Reader.EndOfList do
        Reader.ReadProperty(Self);
      Reader.ReadListEnd;
      Reader.ReadListEnd;
    finally
      Reader.Free;
    end;
  finally
    M.Free;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SaveToFile(const aFileName: string);
var
  S: TFileStream;
begin
  S:= TFileStream.Create(aFileName, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDRichSyntaxDefinition.SaveToStream(aStream: TStream);
var
  Writer: TLMDWriter;
  M: TMemoryStream;
begin
  M:= TMemoryStream.Create;
  try
    Writer:= TLMDWriter.Create(M, 4096);
    try
      Writer.WriteSignature;
      Writer.WriteStr(AnsiString(ClassName));
      Writer.WriteStr(''); {NAME}
      Writer.WriteProperties(Self);
      Writer.WriteListEnd;
      Writer.WriteListEnd;
    finally
      Writer.Free;
    end;
  M.Seek(soFromBeginning, 0);
  ObjectBinaryToText(M, aStream);
  finally
    M.Free;
  end;
end;

{ TLMDWriter }
{-----------------------------------------------------------------------------}
procedure TLMDWriter.WriteProperties(Instance: TPersistent);
begin
  inherited WriteProperties(Instance);
end;

{ TLMDReader }
{-----------------------------------------------------------------------------}
procedure TLMDReader.ReadProperty(Instance: TPersistent);
begin
  inherited;
end;

end.
