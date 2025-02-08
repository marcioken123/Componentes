unit LMDCallStack;
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

LMDCallStack unit (EN, AH)
---------------------------
Trace call stack

Changes
-------
Release 8.0 (Mart 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  SysUtils,
  Classes,
  LMDTypes;

type
  TLMDStackFrame = class(TObject)
  private
    FMapAddress: Cardinal;
    function GetFileName: String;
    function GetLineNumber: Integer;
    function GetMethodName: string;
  public
    constructor Create(AAddress: TLMDPtrUInt);
    function ToString: String; {$ifdef LMDCOMP12}override;{$endif}
    function IsEmpty: Boolean;
    property FileName: String read GetFileName;
    property LineNumber: Integer read GetLineNumber;
    property Method: string read GetMethodName;
  end;

  TLMDCallStack = class(TObject)
  private
    FCallStack: array of TLMDStackFrame;
    FMaxStackLevel: Integer;
    FSkipEmptyFrames: Boolean;
    function CheckCallAddress(AAddress: TLMDPtrUInt): Boolean;
    function GetStackFrame(Index: Integer): TLMDStackFrame;
    function GetFrameCount: Integer;
    procedure SetMaxStackLevel(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TLMDCallStack;
    function ToString: String; {$ifdef LMDCOMP12}override;{$endif}
    function FillCallStack(ACallStackLength: integer): Integer;
    property SkipEmptyFrames: Boolean read FSkipEmptyFrames write FSkipEmptyFrames;
    property MaxStackLevel: Integer read FMaxStackLevel write SetMaxStackLevel;
    property FrameCount: Integer read GetFrameCount;
    property StackFrames[Index: Integer]: TLMDStackFrame read GetStackFrame;
  end;

function GetCallStack(var ACallStack: array of TLMDStackFrame): Integer;

implementation

uses
  Math,
  LMDMapFile;

{------------------------------------------------------------------------------}
function GetCallStack(var ACallStack: array of TLMDStackFrame): Integer;
var
  i: Integer;
begin
  Result := TLMDCallStack.Instance.FillCallStack(Length(ACallStack));
  for i:=0 to result - 1 do
    ACallStack[i] := TLMDCallStack.Instance.FCallStack[i];
end;

var
  FInstance: TLMDCallStack;

{------------------------------------------------------------------------------}
{$STACKFRAMES OFF}
function StackTop: Cardinal;
asm
  MOV EAX, FS:[4]
end;

{------------------------------------------------------------------------------}
function StackBase: Cardinal;
asm
  MOV EAX, ESP
end;

{
******************************** TLMDCallStack *********************************
}
constructor TLMDCallStack.Create;
begin
  inherited Create;
  FSkipEmptyFrames := True;
  FMaxStackLevel := 100;
end;

{------------------------------------------------------------------------------}
destructor TLMDCallStack.Destroy;
begin
  if FInstance = Self then
    FInstance := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCallStack.CheckCallAddress(AAddress: TLMDPtrUInt): Boolean;
var
  LAddr4, LAddr8: ^TLMDPtrUInt;
begin
  LAddr4 := Pointer(AAddress - (SizeOf(Pointer) div 2));
  LAddr8 := Pointer(AAddress - SizeOf(Pointer));
  Result := (AAddress > SizeOf(Pointer)) and not IsBadReadPtr(Pointer(LAddr8), SizeOf(Pointer))
    and (
         ((LAddr4^ and $38FF0000) = $10FF0000) or
         ((LAddr4^ and $0038FF00) = $0010FF00) or
         ((LAddr4^ and $000038FF) = $000010FF) or
         ((LAddr8^ and $FF000000) = $E8000000) or
         ((LAddr8^ and $38FF0000) = $10FF0000) or
         ((LAddr8^ and $0038FF00) = $0010FF00)
        );
end;

{------------------------------------------------------------------------------}
function TLMDCallStack.GetFrameCount: Integer;
begin
  Result := Min(abs(StackBase - StackTop), FMaxStackLevel);
end;

function TLMDCallStack.GetStackFrame(Index: Integer): TLMDStackFrame;
begin
  if (Index >= Low(FCallStack)) and (Index <= High(FCallStack)) then
    Result := FCallStack[Index]
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDCallStack.FillCallStack(ACallStackLength: integer): Integer;
var
  LStackTop: TLMDPtrUInt;
  LStackBase: TLMDPtrUInt;
  StackPtr: ^TLMDPtrUInt;
  PrevCaller: TLMDPtrUInt;
  i: Integer;

begin
  Result := 0;
  try
    LStackBase := StackBase;
    LStackTop := StackTop;
    PrevCaller := 0;
    StackPtr := Pointer(LStackBase);
    i := 0;
    SetLength(FCallStack, ACallStackLength);
    while (TLMDPtrUInt(StackPtr) < LStackTop) and (i < ACallStackLength) do
    begin
      if CheckCallAddress(StackPtr^) and (StackPtr^ <> PrevCaller) then
      begin
        PrevCaller := StackPtr^;
        FCallStack[i] := TLMDStackFrame.Create(StackPtr^);
        result := i;
        Inc(i);
      end;
      Inc(StackPtr);
    end;

  except
    Result := 0;
  end;
end;

{------------------------------------------------------------------------------}
class function TLMDCallStack.Instance: TLMDCallStack;
begin
  if not Assigned(FInstance) then
    FInstance := TLMDCallStack.Create;
  Result := FInstance;
end;

{------------------------------------------------------------------------------}
procedure TLMDCallStack.SetMaxStackLevel(const Value: Integer);
begin
  if Value <> FMaxStackLevel then
    FMaxStackLevel := Value;
end;

{------------------------------------------------------------------------------}
function TLMDCallStack.ToString: String;
var
  i: Integer;
begin
  Result := '';
  for i := Low(FCallStack) to High(FCallStack) do
  begin
    if Assigned(FCallStack[i]) then
      if not (SkipEmptyFrames and FCallStack[i].IsEmpty) then
        Result := Result + FCallStack[i].ToString + #13#10;
  end;
end;

{ TLMDStackFrame }

{------------------------------------------------------------------------------}

constructor TLMDStackFrame.Create(AAddress: TLMDPtrUInt);
begin
  inherited Create;
  FMapAddress := TLMDMapFile.Instance.MapFileAddress(Pointer(AAddress));
end;

{------------------------------------------------------------------------------}
function TLMDStackFrame.ToString: String;
begin
  Result := Format('Unit: %s, Line: %d, Method: %s', [GetFileName, GetLineNumber, GetMethodName]);
end;

{------------------------------------------------------------------------------}
function TLMDStackFrame.GetFileName: String;
begin
  Result := TLMDMapFile.Instance.UnitName(FMapAddress);
end;

{------------------------------------------------------------------------------}
function TLMDStackFrame.GetLineNumber: Integer;
begin
  Result := TLMDMapFile.Instance.LineNumberAsInt(FMapAddress);
end;

{------------------------------------------------------------------------------}
function TLMDStackFrame.GetMethodName: string;
begin
  Result := TLMDMapFile.Instance.ProcedureName(FMapAddress);
end;

{------------------------------------------------------------------------------}
function TLMDStackFrame.IsEmpty: Boolean;
begin
  with TLMDMapFile.Instance do
    Result := not (UnitExists(FMapAddress) and LineExists(FMapAddress) and ProcedureExists(FMapAddress));
end;

begin
  FInstance := nil;

end.
