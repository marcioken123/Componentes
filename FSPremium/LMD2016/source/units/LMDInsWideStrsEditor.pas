unit LMDInsWideStrsEditor;
{$I lmdcmps.inc}

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

LMDDsgWideStrsEditor unit (YB)
------------------------
TLMDWideStringsEditorDialog unit.

Changes
-------
Release 4.0 (January 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, LMDTypes, LMDUnicodeStrings, LMDInsCst;

type
  {********************** TLMDWideStringsEditorDialog *************************}

  TLMDWideStringsEditorDialog = class(TForm)
    lbLineCount: TLabel;
    bvlMain: TBevel;
    btnOk: TButton;
    btnCancel: TButton;
    pnlMain: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMemo:  TObject;
    FLines: TLMDWideStrings;

    procedure MemoChange(Sender: TObject);
    procedure SetLines(const Value: TLMDWideStrings);
    procedure CopyToMemo;
    procedure CopyFromMemo;
  public
    function Execute: Boolean;
    property Lines: TLMDWideStrings read FLines write SetLines;
  end;

implementation

uses
  LMDUnicode, LMDUnicodeControl;

type
  {$IFDEF _LMD_UNICODEIMPL}
  TStringsAccess = class(TStrings);

  TEditorMemo = class(TMemo)
  private
    FLines: TLMDStrings;

    function  GetText: TLMDString;
    procedure SetText(const Value: TLMDString);
    procedure SetLines(const Value: TLMDStrings);
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Text: TLMDString read GetText write SetText;
    property Lines: TLMDStrings read FLines write SetLines;
  end;

  TEditorMemoStrings = class(TLMDStrings)
  private
    FMemo:       TEditorMemo;
    FOldStrings: TStrings;

    function LineStart(Index: Integer): Integer;
    function LineLength(Index: Integer): Integer;
  protected
    function  Get(Index: Integer): WideString; override;
    function  GetCount: Integer; override;
    function  GetTextStr: WideString; override;
    procedure Put(Index: Integer; const S: WideString); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AMemo: TEditorMemo; AOldStrings: TStrings);

    procedure SetTextStr(const Value: WideString); override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: WideString); override;
  end;
  {$ELSE}
  TEditorMemo = TMemo;
  {$ENDIF} // _LMD_UNICODEIMPL

{$R *.dfm}

{************************ TLMDFrmWideStringsEditor ****************************}
{------------------------------------------------------------------------------}

function TLMDWideStringsEditorDialog.Execute: Boolean;
begin
  Caption             := SLMDStrErDlgCaption;
  btnOk.Caption       := SLMDStrErDlgOkBtnCaption;
  btnCancel.Caption   := SLMDStrErDlgCancelBtnCaption;
  lbLineCount.Caption := Format(SLMDStrErDlgLinesCountTemplate,
                                [TEditorMemo(FMemo).Lines.Count]);

  CopyToMemo;
  Result := (ShowModal = mrOk);
  CopyFromMemo;
end;

{------------------------------------------------------------------------------}

procedure TLMDWideStringsEditorDialog.MemoChange(Sender: TObject);
begin
  lbLineCount.Caption := Format(SLMDStrErDlgLinesCountTemplate,
                                [TEditorMemo(FMemo).Lines.Count]);
end;

{------------------------------------------------------------------------------}

procedure TLMDWideStringsEditorDialog.SetLines(const Value: TLMDWideStrings);
begin
  FLines.Assign(Value);
end;

{------------------------------------------------------------------------------}

procedure TLMDWideStringsEditorDialog.CopyToMemo;
{$IFNDEF LMD_UNICODE}
var
  i: Integer;
{$ENDIF}
begin
  {$IFDEF LMD_UNICODE}
  TEditorMemo(FMemo).Lines := FLines;
  {$ELSE}
  TEditorMemo(FMemo).Lines.BeginUpdate;
  try
    TEditorMemo(FMemo).Lines.Clear;
    for i := 0 to FLines.Count - 1 do
      TEditorMemo(FMemo).Lines.Add(FLines[i]);
  finally
    TEditorMemo(FMemo).Lines.EndUpdate;
  end;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

procedure TLMDWideStringsEditorDialog.CopyFromMemo;
{$IFNDEF LMD_UNICODE}
var
  i: Integer;
{$ENDIF}
begin
  {$IFDEF LMD_UNICODE}
  FLines.Assign(TEditorMemo(FMemo).Lines);
  {$ELSE}
  FLines.BeginUpdate;
  try
    FLines.Clear;
    for i := 0 to FLines.Count - 1 do
      FLines.Add(TEditorMemo(FMemo).Lines[i]);
  finally
    FLines.EndUpdate;
  end;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

procedure TLMDWideStringsEditorDialog.FormCreate(Sender: TObject);
begin
  FMemo := TEditorMemo.Create(Self);
  TEditorMemo(FMemo).OnChange := MemoChange;
  TEditorMemo(FMemo).Align    := alClient;
  TEditorMemo(FMemo).Parent   := pnlMain;

  FLines := TLMDWideStringList.Create;
end;

{------------------------------------------------------------------------------}

procedure TLMDWideStringsEditorDialog.FormDestroy(Sender: TObject);
begin
  FMemo.Free;
  FLines.Free;
end;

{******************************* TEditorMemo **********************************}
{------------------------------------------------------------------------------}

{$IFDEF _LMD_UNICODEIMPL}

constructor TEditorMemo.Create(AOwner: TComponent);
begin
  inherited;
  FLines := TEditorMemoStrings.Create(Self, inherited Lines);
end;

{------------------------------------------------------------------------------}

procedure TEditorMemo.CreateWindowHandle(const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'EDIT');
end;

{------------------------------------------------------------------------------}

destructor TEditorMemo.Destroy;
begin
  FLines.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TEditorMemo.GetText: TLMDString;
begin
  Result := LMDGetControlText(Self);
end;

{------------------------------------------------------------------------------}

procedure TEditorMemo.SetLines(const Value: TLMDStrings);
begin
  FLines.Assign(Value);
end;

{------------------------------------------------------------------------------}

procedure TEditorMemo.SetText(const Value: TLMDString);
begin
  LMDSetControlText(Self, Value);
end;

{$ENDIF}

{**************************** TEditorMemoStrings ******************************}
{------------------------------------------------------------------------------}

{$IFDEF _LMD_UNICODEIMPL}

procedure TEditorMemoStrings.Clear;
begin
  FOldStrings.Clear;
end;

{------------------------------------------------------------------------------}

constructor TEditorMemoStrings.Create(AMemo: TEditorMemo;
  AOldStrings: TStrings);
begin
  inherited Create;
  FMemo       := AMemo;
  FOldStrings := AOldStrings;
end;

{------------------------------------------------------------------------------}

procedure TEditorMemoStrings.Delete(Index: Integer);
begin
  FOldStrings.Delete(Index);
end;

{------------------------------------------------------------------------------}

function TEditorMemoStrings.Get(Index: Integer): WideString;
var
  len: Integer;
begin
  if not LMDIsUnicodePlatform then
    Result := FOldStrings[Index]
  else
  begin
    SetLength(Result, LineLength(Index));
    if Length(Result) > 0 then
    begin
      if Length(Result) < 4 then
        SetLength(Result, 4);
      Word((@Result[1])^) := Length(Result);
      len := LMDSendMessage(FMemo.Handle, EM_GETLINE, Index,
                            LPARAM(@Result[1]));
      SetLength(Result, len);
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TEditorMemoStrings.GetCount: Integer;
begin
  Result := FOldStrings.Count;
end;

{------------------------------------------------------------------------------}

function TEditorMemoStrings.GetTextStr: WideString;
begin
  Result := LMDGetControlText(FMemo);
end;

{------------------------------------------------------------------------------}

procedure TEditorMemoStrings.Insert(Index: Integer; const S: WideString);
var
  spos, len: Integer;
  line:      TLMDString;
begin
  if Index >= 0 then
  begin
    spos := LineStart(Index);

    if spos >= 0 then
      line := S + #13#10
    else
    begin
      spos := LineStart(Index - 1);
      if spos < 0 then
        Exit;
        len := LineLength(Index - 1);
      if len = 0 then
        Exit;
        Inc(spos, len);
      line := #13#10 + s;
    end;

    LMDSendMessage(FMemo.Handle, EM_SETSEL, spos, spos);
    LMDSendMessage(FMemo.Handle, EM_REPLACESEL, 0, LPARAM(PLMDChar(line)));
  end;
end;

{------------------------------------------------------------------------------}

function TEditorMemoStrings.LineLength(Index: Integer): Integer;
var
  spos: Integer;
begin
  spos := LineStart(Index);
  if spos < 0 then
    Result := 0
  else
    Result := LMDSendMessage(FMemo.Handle, EM_LINELENGTH, spos, 0);
end;

{------------------------------------------------------------------------------}

function TEditorMemoStrings.LineStart(Index: Integer): Integer;
begin
  Result := LMDSendMessage(FMemo.Handle, EM_LINEINDEX, Index, 0);
end;

{------------------------------------------------------------------------------}

procedure TEditorMemoStrings.Put(Index: Integer; const S: WideString);
var
  spos: Integer;
begin
  if not LMDIsUnicodePlatform then
    FOldStrings[Index] := S
  else
  begin
    spos := LineStart(Index);
    if spos >= 0 then
    begin
      LMDSendMessage(FMemo.Handle, EM_SETSEL, spos, spos + LineLength(Index));
      LMDSendMessage(FMemo.Handle, EM_REPLACESEL, 0, LPARAM(PLMDChar(S)));
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TEditorMemoStrings.SetTextStr(const Value: WideString);
begin
  LMDSetControlText(FMemo, Value);
end;

{------------------------------------------------------------------------------}

procedure TEditorMemoStrings.SetUpdateState(Updating: Boolean);
begin
  TStringsAccess(FOldStrings).SetUpdateState(Updating);
end;

{$ENDIF}
{------------------------------------------------------------------------------}

end.
