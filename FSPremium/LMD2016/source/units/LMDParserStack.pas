unit LMDParserStack;
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

LMDParserStack unit (VO)
------------------------

Some stacks for TLMDHTMLStyle 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, Graphics;

type

  { ******************************* TLMDStringStack *************************** }
  TLMDStringStack = class
  private
    FList : TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Push(const aValue : string);
    procedure Pop;
    function Top : string;
  end;

  { ******************************* TLMDIntegerStack ************************** }
  TLMDIntegerStack = class
  private
    FList : TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Push(aValue : integer);
    procedure Pop;
    function Top : integer;
  end;

  { ******************************* TLMDFontStyleStack ************************ }
  TLMDFontStyleStack = class
  private
    FList : TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Push(aValue : TFontStyles);
    procedure Pop;
    function Top : TFontStyles;
  end;

  { ******************************* TLMDPointerStack ************************ }
  TLMDPointerStack = class
  private
    FList : TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Top : Pointer;
    procedure Push(aValue : Pointer);
    procedure Pop;
  end;

implementation

{ ********************************* TLMDStringStack *************************** }
{-----------------------------------------------------------------------------}

constructor TLMDStringStack.Create;
begin
  inherited;
  FList := TStringList.Create;
end;

{-----------------------------------------------------------------------------}

destructor TLMDStringStack.Destroy;
begin
  FList.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDStringStack.Clear;
begin FList.Clear end;

{-----------------------------------------------------------------------------}

procedure TLMDStringStack.Push(const aValue : string);
begin FList.Insert(0, aValue) end;

{-----------------------------------------------------------------------------}

procedure TLMDStringStack.Pop;
begin
  if FList.count > 0 then
    FList.Delete(0);
end;

{-----------------------------------------------------------------------------}

function TLMDStringStack.Top : string;
begin
  if FList.count > 0 then result := FList[0]
  else result := '';
end;

{ ********************************* TLMDIntegerStack ************************** }
{-----------------------------------------------------------------------------}

constructor TLMDIntegerStack.Create;
begin
  inherited;
  FList := TList.Create;
end;

{-----------------------------------------------------------------------------}

destructor TLMDIntegerStack.Destroy;
begin
  FList.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDIntegerStack.Clear;
begin FList.Clear end;

{-----------------------------------------------------------------------------}

procedure TLMDIntegerStack.Push(aValue : integer);
begin
  FList.Insert(0, Pointer(aValue))
  end;

{-----------------------------------------------------------------------------}

procedure TLMDIntegerStack.Pop;
begin
  if FList.count > 0 then
    FList.Delete(0);
end;

{-----------------------------------------------------------------------------}

function TLMDIntegerStack.Top : integer;
begin
  if FList.count > 0 then result := integer(FList[0])
  else result := -10000;
end;

{ ********************************* TLMDFontStyleStack ************************ }
type
  TLMDFontStyles = class
  private
    FFontStyle : TFontStyles;
  public
    property FontStyle : TFontStyles read FFontStyle write FFontStyle;
  end;
{-----------------------------------------------------------------------------}

constructor TLMDFontStyleStack.Create;
begin
  inherited;
  FList := TList.Create;
end;

{-----------------------------------------------------------------------------}

destructor TLMDFontStyleStack.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDFontStyleStack.Clear;
var
  I : LongInt;
begin
  for I := 0 to FList.count-1 do
    if assigned(FList[I]) then
      TLMDFontStyles(FList[I]).Free;
  FList.Clear;
end;

procedure TLMDFontStyleStack.Push(aValue : TFontStyles);
var
  Item : TLMDFontStyles;
begin
  Item := TLMDFontStyles.Create;
  Item.FontStyle := aValue;
  FList.Insert(0, Item);
end;

{-----------------------------------------------------------------------------}

procedure TLMDFontStyleStack.Pop;
begin
  if FList.count > 0 then
    if assigned(FList[0])  then
    begin
      TLMDFontStyles(FList[0]).Free;
      FList.Delete(0);
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDFontStyleStack.Top : TFontStyles;
begin
  if FList.count > 0 then result := TLMDFontStyles(FList[0]).FontStyle
  else result := [];
end;

{ ********************************* TLMDPointerStack ************************ }
{-----------------------------------------------------------------------------}

constructor TLMDPointerStack.Create;
begin
  inherited;
  FList := TList.Create;
end;

{-----------------------------------------------------------------------------}

destructor TLMDPointerStack.Destroy;
begin
  FList.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDPointerStack.Clear;
begin FList.Clear end;

{-----------------------------------------------------------------------------}

procedure TLMDPointerStack.Push(aValue : pointer);

begin
  FList.Insert(0, aValue);
end;

{-----------------------------------------------------------------------------}

procedure TLMDPointerStack.Pop;
begin
  if FList.count > 0 then
    if assigned(FList[0])  then
      FList.Delete(0);
end;

{-----------------------------------------------------------------------------}

function TLMDPointerStack.Top : Pointer;
begin
  if FList.count > 0 then result := FList[0]
  else result := nil;
end;

end.
