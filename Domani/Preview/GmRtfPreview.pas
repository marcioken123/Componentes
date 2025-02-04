{******************************************************************************}
{                                                                              }
{                          GmRtfPreview.pas v2.61 Pro                          }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmRtfPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  GmPreview, ComCtrls, StdCtrls, RichEdit, GmTypes;

type
  TGmRtfNewPageEvent      = procedure (Sender: TObject; var ATopMargin, ABottomMargin: TGmValue) of object;

  TGmRtfPreview = class(TGmComponent)
  private
    FPreview: TGmPreview;
    FTextFileFont: TFont;
    FTopMargin: TGmValue;
    FBottomMargin: TGmValue;
    // events...
    FOnNewPage: TGmRtfNewPageEvent;
    FBeforeNewPage: TGmRtfNewPageEvent;
    procedure FormatRichText(ARichEdit: TCustomMemo);
    procedure NextPage;
    procedure SetTextFileFont(AFont: TFont);
    procedure SetPreview(const Value: TGmPreview);
    { Private declarations }
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // text file method...
    procedure LoadTextFromFile(const AFileName: string);
    procedure LoadTextFromMemo(AMemo: TCustomMemo);

    // rich text methods...
    procedure LoadRtfFromRichEdit(ARichEdit: TCustomMemo);
    procedure LoadRtfFromFile(const AFileName: string);
    procedure LoadRtfFromStream(AStream: TStream);

    property MarginBottom: TGmValue read FBottomMargin write FBottomMargin;
    property MarginTop: TGmValue read FTopMargin write FTopMargin;
    { Public declarations }
  published
    property Preview: TGmPreview read FPreview write SetPreview;
    property TextFileFont: TFont read FTextFileFont write SetTextFileFont;
    // events...
    property BeforeNewPage: TGmRtfNewPageEvent read FBeforeNewPage write FBeforeNewPage;
    property OnNewPage: TGmRtfNewPageEvent read FOnNewPage write FOnNewPage;
    { Published declarations }
  end;

implementation

uses GmConst, GmErrors, GmObjects, GmRtfFuncs, Printers;

//------------------------------------------------------------------------------

function IsTRichEdit(ARichEdit: TObject): Boolean;
var
  AClass: string;
begin
  AClass := LowerCase(ARichEdit.ClassName);
  Result := AClass = 'trichedit';
end;

function IsTRxRichEdit(ARichEdit: TObject): Boolean;
var
  AClass: string;
begin
  AClass := LowerCase(ARichEdit.ClassName);
  Result := (AClass = 'trxrichedit') or
            (AClass = 'tjvxrichedit');
end;

function IsTRichEdit98(ARichEdit: TObject): Boolean;
var
  AClass: string;
begin
  AClass := LowerCase(ARichEdit.ClassName);
  Result := AClass = 'trichedit98';
end;

function IsTMemo(AMemo: TObject): Boolean;
var
  AClass: string;
begin
  AClass := LowerCase(AMemo.ClassName);
  Result := AClass = 'tmemo';
end;

//------------------------------------------------------------------------------

{ TGmRtfPreview }

constructor TGmRtfPreview.Create(AOwner: TComponent);
begin
  inherited;
  FTopMargin := TGmValue.Create;
  FTopMargin.AsInches := 1;
  FBottomMargin := TGmValue.Create;
  FBottomMargin.AsInches := 1;
  FTextFileFont := TFont.Create;
  with FTextFileFont do
  begin
    Name := DEFAULT_FONT;
    Size := 12;
  end;
end;

destructor TGmRtfPreview.Destroy;
begin
  if Assigned(FPreview) then FPreview.RemoveAssociatedComponent(Self);
  FTopMargin.Free;
  FBottomMargin.Free;
  if Assigned(FTextFileFont) then FTextFileFont.Free;
  inherited;
end;

procedure TGmRtfPreview.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPreview) then
    FPreview := nil;
end;

procedure TGmRtfPreview.SetTextFileFont(AFont: TFont);
begin
  FTextFileFont.Assign(AFont);
end;

//------------------------------------------------------------------------------

procedure TGmRtfPreview.FormatRichText(ARichEdit: TCustomMemo);
var
  printarea: TRect;
  richedit_outputarea: TRect;
  fmtRange: TFormatRange;
  pw, ph: integer;
  TextLenEx: TGetTextLengthEx;
  LastOffset: integer;
  LastChar: integer;
  SaveRect: TRect;
  Ppi: integer;
  MarginRect: TRect;
  DC: THandle;
  FirstPage: Boolean;
  ATwip: Extended;
  StartPage: integer;
  RtfString: string;
  ARtfStringStream: TStringStream;
  RtfPage: integer;
  NewRichEdit: TCustomMemo;
  ICount: integer;
begin
  if not Assigned(FPreview) then
  begin
    ShowGmError(Self, NO_PREVIEW_ASSIGNED);
    Exit;
  end;
  // get the rich text...

  if FPreview.GmPrinter.Printers.Count = 0 then
  begin
    ShowGmError(Self, PRINT_DRIVER_NEEDED);
    Exit;
  end;

  FPreview.BeginUpdate;
  FPreview.RtfInformation.Clear;

  ARtfStringStream := TStringStream.Create('');
  try
    GetRtfText(ARichEdit, ARtfStringStream);
    RtfString := ARtfStringStream.DataString;
  finally
    ARtfStringStream.Free;
  end;

  Ppi := GetDeviceCaps(Printer.Handle, LOGPIXELSX);

  pw := Round(Ppi * FPreview.PageWidth.AsInches);
  ph := Round(Ppi * FPreview.PageHeight.AsInches);

  StartPage := FPreview.CurrentPage;
  RtfPage := FPreview.CurrentPage;
  DC := GetDC(0);
  try
    MarginRect := Rect(Trunc(FPreview.Margins.Left.AsInches * Ppi),
                       Round(Ppi * FTopMargin.AsInches) ,
                       Trunc(FPreview.Margins.Right.AsInches * Ppi),
                       Round((Ppi * FBottomMargin.AsInches)));
    printarea := Rect(0 + MarginRect.Left,
                      0 + MarginRect.Top,
                      pw - MarginRect.Right,
                      ph - MarginRect.Bottom);

    {Define a rectangle for the rich edit text. The height is set to the maximum. But
    we need to convert from device units to twips, 1 twip = 1/1440 inch or 1/20 point.}


    ATwip := 1440 / Ppi;
    richedit_outputarea := Rect(Round(printarea.left * ATwip),
                                Round(printarea.top * ATwip) ,
                                Round(printarea.right * ATwip),
                                Round(printarea.bottom * ATwip));
    SaveRect := richedit_outputarea;

    {Tell rich edit to format its text to the printer. First set up data record for message:}
    fmtRange.hDC := dc;  {printer handle}
    fmtRange.hdcTarget := Printer.Handle;  {ditto}

    fmtRange.rc := richedit_outputarea;
    fmtRange.rcPage := Rect( 0, 0, pw, ph);

    LastChar := 0;

    with TextLenEx do
    begin
      flags := GTL_DEFAULT;
      codepage := CP_ACP;
    end;

    FirstPage := True;
    try
      with FPreview.RtfInformation do
      begin
        if Assigned(RichEdit) then RichEdit.Free;
        NewRichEdit := nil;

        if (Assigned(FPreview.OnNeedRichEdit)) then
          FPreview.OnNeedRichEdit(FPreview, NewRichEdit);

        if NewRichEdit = nil then  NewRichEdit := TRichEdit.Create(nil);

        RichEdit := NewRichEdit;
        if (IsTRxRichEdit(RichEdit)) then
        begin
          NewRichEdit.Parent := Form;
        	NewRichEdit.SetSelTextBuf(PChar(RtfString));
        end
        else
        begin
      		RichEdit.Width := 0;
      		RichEdit.Height := 0;
        	RichEdit.Parent := Application.MainForm;
          Insertrtf(RichEdit, RtfString);
          RichEdit.Visible := False;
          if not IsTRichEdit98(RichEdit) then RichEdit.Parent := Form;
        end;
      end;
      fmtRange.chrg.cpMin := 0;
      fmtRange.chrg.cpMax := NewRichEdit.GetTextLen;

      if IsTRxRichEdit(NewRichEdit) then
        LastOffset := NewRichEdit.perform(EM_GETTEXTLENGTHEX, WParam(@TextLenEx), 0)
      else
        LastOffset := NewRichEdit.GetTextLen;

      SendMessage(NewRichEdit.Handle, EM_FORMATRANGE, 0, 0);

      repeat
        fmtRange.rc := SaveRect;
        fmtRange.chrg.cpMin := LastChar;
        LastChar := SendMessage(NewRichEdit.Handle, EM_FORMATRANGE, 0, Longint(@fmtRange));

        if (LastChar < LastOffset) and (LastChar <> -1) then
        begin
          FPreview.RtfInformation.AddOffset(SaveRect, RtfPage, fmtRange.chrg.cpMin, LastChar,
            FTopMargin.AsInches, FBottomMargin.AsInches);
          Inc(RtfPage);
          if not FirstPage then NextPage;
          FirstPage := False;
        end;
      until (LastChar >= LastOffset) or (LastChar = -1);
    finally
    	if FirstPage = False then NextPage;

      FPreview.RtfInformation.AddOffset(SaveRect, RtfPage, fmtRange.chrg.cpMin, LastChar,
        FTopMargin.AsInches, FBottomMargin.AsInches);
      {Free cached information}
      SendMessage(NewRichEdit.Handle, EM_FORMATRANGE, 0, 0);  // flush buffer

    end;
  finally
    ReleaseDc(0, DC);
    FPreview.CurrentPage := StartPage;
    for ICount := StartPage to RtfPage do
    begin
      FPreview.Pages[ICount].HasChanged := True;
    end;
    FPreview.EndUpdate;
  end;
end;

procedure TGmRtfPreview.NextPage;
begin
  if Assigned(FBeforeNewPage) then FBeforeNewPage(Self, FTopMargin, FBottomMargin);
  FPreview.Canvas.Page.HasChanged := True;
  if FPreview.CurrentPage = FPreview.NumPages then
    FPreview.NewPage
  else
    FPreview.NextPage;
  if Assigned(FOnNewPage) then FOnNewPage(Self, FTopMargin, FBottomMargin);
end;

//------------------------------------------------------------------------------


procedure TGmRtfPreview.LoadTextFromFile(const AFileName: string);
var
  AMemo: TMemo;
begin
  AMemo := TMemo.Create(nil);
  try
    AMemo.Lines.LoadFromFile(AFileName);
    LoadTextFromMemo(AMemo);
  finally
    AMemo.Free;
  end;
end;

procedure TGmRtfPreview.LoadTextFromMemo(AMemo: TCustomMemo);
var
  AForm: TForm;
  ARichEdit: TRichEdit;
begin
  AForm := TForm.Create(nil);
  ARichEdit := TRichEdit.Create(AForm);
  try
    ARichEdit.Parent := AForm;
    ARichEdit.PlainText := True;
    ARichEdit.Font.Assign(FTextFileFont);
    ARichEdit.Lines.Assign(AMemo.Lines);
    FormatRichText(ARichEdit);
  finally
    ARichEdit.Free;
    AForm.Free;
  end;
end;

//------------------------------------------------------------------------------

// RichEdit functions with OLE support...

procedure TGmRtfPreview.LoadRtfFromRichEdit(ARichEdit: TCustomMemo);
begin
  FormatRichText(ARichEdit);
end;

procedure TGmRtfPreview.LoadRtfFromFile(const AFileName: string);
var
  AStream: TFileStream;
  FileExt: string;
begin
    FileExt := ExtractFileExt(AFileName);
  if LowerCase(FileExt) = '.txt' then
  begin
    LoadTextFromFile(AFileName);
    Exit;
  end;

  if LowerCase(FileExt) = '.rtf' then
  begin
    AStream := TFileStream.Create(AFileName, fmOpenRead);
    try
      LoadRtfFromStream(AStream);
    finally
      AStream.Free;
    end;
  end;
end;

procedure TGmRtfPreview.LoadRtfFromStream(AStream: TStream);
var
  AForm: TForm;
  ARichEdit: TCustomMemo;
begin
  if not Assigned(FPreview) then
  begin
    ShowGmError(Self, NO_PREVIEW_ASSIGNED);
    Exit;
  end;
  ARichEdit := nil;
  if Assigned(FPreview.OnNeedRichEdit) then FPreview.OnNeedRichEdit(FPreview, ARichEdit);
  if ARichEdit = nil then ARichEdit := TRichEdit.Create(nil);
  AForm := TForm.Create(nil);
  try
    Screen.Cursor := crHourGlass;
   	ARichEdit.Width := 0;
  	ARichEdit.Height := 0;
  	ARichEdit.Parent := Application.MainForm;
    PutRtfSelection(ARichedit, AStream);
  	ARichEdit.Visible := False;
    LoadRtfFromRichEdit(ARichEdit);
  finally
    ARichEdit.Free;
    AForm.Free;
    Screen.Cursor := crDefault;
  end;
end;

//------------------------------------------------------------------------------

procedure TGmRtfPreview.SetPreview(const Value: TGmPreview);
begin
  if Assigned(FPreview) then
    FPreview.RemoveAssociatedComponent(Self);
  FPreview := Value;
  if Assigned(FPreview) then
    FPreview.AddAssociatedComponent(Self);
end;

end.
