{ Summary
  This unit includes the default control used for displayed formatted text in the footer of the dialog.
  This control is capable of highlighting links with the text and triggering an event when a link is clicked. }
unit JSRichEdit;

interface

{$I lmddlgcmps.inc}

uses
  RichEdit, ComCtrls, Classes, Messages, Windows, Controls, JSTypes;

type
  { Type of event that is triggered when a link has be clicked on. }
  TLinkClickedEvent = procedure (Sender: TObject; const Link: TJSString; var Handled: Boolean) of object;

  { Default control used when the More text is to be displayed in
    the Footer.
    
    To display the More text in the footer of the dialog make
    sure the ShowInFooter property is set to True in the
    MoreOptions property.                                         }
  TJSRichEdit = class(TRichEdit)
  private
    FShowLinks: Boolean;
    FOnLinkClicked: TLinkClickedEvent;
    procedure SetShowLinks(const Value: Boolean);
    procedure UpdateShowLinks(const Value: Boolean);
  protected
    { Protected virtual method that first the OnLinkClicked event. }
    procedure DoLinkClicked(const ALink: TJSString); virtual;
    procedure Loaded; override;
    procedure CreateWnd; override;
    procedure CNNotify(var Message: TMessage); message CN_NOTIFY;
  public
    constructor Create(AOwner: TComponent); override;
    { Scrolls to the line specified in the aLineNumber parameter. }
    procedure ScrollToLine(const aLineNumber: Integer);
    { Scrolls to the top of the text in the control. }
    procedure ScrollToTop;
    { Scrolls to the end of the text in the control. }
    procedure ScrollToEnd;
  published
    { Set this property to True to have the control highlight links
      within the text. If this property is False then no links are
      highlighted within the text.                                  }
    property ShowLinks: Boolean read FShowLinks write SetShowLinks default True;
    { Event triggered when the user clicks on the link within the
      control.                                                    }
    property OnLinkClicked: TLinkClickedEvent read FOnLinkClicked write FOnLinkClicked;
  end;

implementation

uses
  ShellAPI, JSUnicode;

{ TJSRichEdit }

procedure TJSRichEdit.CNNotify(var Message: TMessage);
var
  p: TENLink;
begin
  if (PNMHDR(Message.LParam).code = EN_LINK) and FShowLinks then
  begin
    p := TENLink(Pointer(TWMNotify(Message).NMHdr)^);
    if (p.msg = WM_LBUTTONDOWN) then
    begin
      SendMessage(Handle, EM_EXSETSEL, 0, LPARAM(@(p.chrg)));
      DoLinkClicked(SelText);
    end
  end
end;

constructor TJSRichEdit.Create(AOwner: TComponent);
begin
  inherited;
  ShowLinks := True;
end;

procedure TJSRichEdit.CreateWnd;
begin
  inherited;
  UpdateShowLinks(FShowLinks);
end;

procedure TJSRichEdit.DoLinkClicked(const ALink: TJSString);
var
  lHandled: Boolean;
  {$IFDEF FORCEUNICODE}
  LAnsiStr: AnsiString;
  {$ENDIF FORCEUNICODE}
  {$IFNDEF UNICODE}
  LS: WideString;
  {$ENDIF}
begin
  lHandled := False;
  if Assigned(FOnLinkClicked) then
    FOnLinkClicked(Self, aLink, lHandled);
  if not lHandled then
  begin
    {$IFDEF UNICODE}
    ShellExecuteW(Handle, 'open', PWideChar(aLink), nil, nil, SW_SHOWNORMAL);
    {$ELSE}
    if JSSupportsUnicode then
    begin
      LS := aLink;
      ShellExecuteW(Handle, 'open', PWideChar(LS), nil, nil, SW_SHOWNORMAL);
    end
    else
    begin
      {$IFDEF FORCEUNICODE}
  	  LAnsiStr := JSCompilerStringFromUnicodeWideString(ALink);
      ShellExecuteA(Handle, 'open', PChar(LAnsiStr), nil, nil, SW_SHOWNORMAL);
      {$ELSE}
      ShellExecute(Handle, 'open', PChar(aLink), nil, nil, SW_SHOWNORMAL);
      {$ENDIF FORCEUNICODE}
    end;
    {$ENDIF UNICODE}
  end;
end;

procedure TJSRichEdit.Loaded;
begin
  inherited;
  UpdateShowLinks(FShowLinks);
end;

procedure TJSRichEdit.ScrollToEnd;
begin
  SelStart := Perform(EM_LINEINDEX, Lines.Count, 0);
  Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TJSRichEdit.ScrollToLine(const aLineNumber: Integer);
var
  lCurrentLine: Integer;
begin
  lCurrentLine := Perform(EM_GETFIRSTVISIBLELINE, 0, 0);
  Perform(EM_LINESCROLL, 0, (aLineNumber - lCurrentLine));
  SelStart := Perform(EM_LINEINDEX, aLineNumber, 0);
  Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TJSRichEdit.ScrollToTop;
begin
  ScrollToLine(0);
end;

procedure TJSRichEdit.SetShowLinks(const Value: Boolean);
begin
  if FShowLinks <> Value then
  begin
    FShowLinks := Value;
    UpdateShowLinks(Value);
  end;
end;

procedure TJSRichEdit.UpdateShowLinks(const Value: Boolean);
var
  lEventMask: Integer;
begin
  if HandleAllocated then
  begin
    lEventMask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0);
    SendMessage(Handle, EM_SETEVENTMASK, 0, lEventMask or ENM_LINK);
    SendMessage(Handle, EM_AUTOURLDETECT, WPARAM(Value), 0);
  end;
end;

end.
