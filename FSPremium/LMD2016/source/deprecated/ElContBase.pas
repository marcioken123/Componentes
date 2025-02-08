unit ElContBase;

{$I lmdcmps.inc}
{###############################################################################

ElContBase unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

{$ifdef CLR}

type

 TxListItem = TObject;
 TObjectList = array of TxListItem;

// TPointerList = PPointerList;
// PPointerList = TObjectList;

 procedure SysArrayMove( Const SysArray:System.Array; FromPos, ToPos, Count :Integer );

 // boxing simple types value to object
function BoxingInteger(const Value: Integer):TObject;
function BoxingWString(const Value: WideString):TObject;
function BoxingPointer(const Value: IntPtr):TObject;

 // unboxing to simple types value
function UnboxingInteger(const O:TObject):Integer;
function UnBoxingWString(const O:TObject):WideString;
function UnBoxingPointer(const O:TObject):IntPtr;

{$else}

const
  MaxListSize = Maxint div 16;
type
  PPointerList = ^TPointerList;
  TPointerList = array[0..MaxListSize - 1] of Pointer;
  TxListItem = Pointer;
{$endif}

implementation

{$ifdef CLR}

procedure SysArrayMove( Const SysArray:System.Array; FromPos, ToPos, Count :Integer );
begin
   if (FromPos = ToPos) or (Count < 1) then
     exit;
   System.Array.Copy(SysArray, FromPos, SysArray, ToPos, Count);
   if ToPos < FromPos then
   begin
     if (FromPos - ToPos + 1) > Count then
       System.Array.Clear(SysArray, ToPos + Count, (FromPos - ToPos + Count) - 1);
   end
   else
   if ToPos > FromPos then
   begin
     if (ToPos-FromPos+1)>Count then
       System.Array.Clear( SysArray, FromPos, ToPos-Count-FromPos );
   end;
end;

 // boxing simple types value to object

function BoxingInteger(const Value: Integer):TObject;
begin
  Result := TObject(Value);
end;

function BoxingWString(const Value: WideString):TObject;
begin
  Result := TObject(Value);
end;

function BoxingPointer(const Value: IntPtr):TObject;
begin
  Result := TObject( Value );
end;

 // unboxing to simple types value

function UnboxingInteger(const O:TObject):Integer;
begin
  if Assigned(O) then
    Result := Integer(O)
  else
    Result := 0;
end;

function UnBoxingWString(const O:TObject):WideString;
begin
  if Assigned(O) then
    Result := WideString(O)
  else
    Result := '';
end;

function UnBoxingPointer(const O:TObject):IntPtr;
begin
  if Assigned(O) then
    Result :=  IntPtr(O)
  else
    Result := IntPtr(nil); // = IntPtr(0)
end;

{$endif}

end.
