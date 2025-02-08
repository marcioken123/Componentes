unit LMDArrayUtils;
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

LMDArrayUtils unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDTypes,
  LMDProcs,
  Math;

type
  //Operation which  TLMDArrayFunc should perform
  TLMDArrayOperation = (//callback should one element of array to another: Arr[AIdx1] := Arr[AIdx2]
                        aoAssign,
                        //callback should compare two elements of array and return
                        //the difference as Integer: result := Arr[AIdx1] - Arr[AIdx2]
                        aoCompare,
                        //callback should swap two elements of array: Swap(Arr, AIdx1, AIdx2)
                        aoSwap,
                        //callback should set size (AIdx1=Size) of array: SetSize(Arr, AIdx1)
                        aoSetSize,
                        //callback should return size of array
                        aoGetSize);

  //Callback which does some work on one or two elements at AIdx1, AIdx2
  //of some 'virtual' array (or some array-like structure)
  //See LMDArray* functions for usage
  TLMDArrayFunc = function(AIdx1, AIdx2: Integer; AOp: TLMDArrayOperation): Integer of object;

//Char array

//Same as .Net System.Array.Copy. ASrc and ADst may be same array,
//AStart..AStart+ALength and ADstStart may overlap
procedure LMDCharArrayCopy(var ASrc: TLMDCharArray; AStart: Integer;
                           var ADst: TLMDCharArray; ADstStart: Integer;
                           ACount: Integer);  overload;

procedure LMDCharArrayCopy(const ASrc: TLMDString; AStart: Integer;
                           var ADst: TLMDCharArray; ADstStart: Integer;
                           ACount: Integer);  overload;

//Int array

//Search AVal in array using binary search algorithm. If fails, then return -1
function  LMDIntArrayBinarySearch(AVal: Integer; const Arr: TLMDIntArray): Integer; overload;
//This function determines the lowest position before which AVal can be inserted in the Arr and still preserve its ordering
function  LMDIntArrayLowerBound(AVal: Integer; const Arr: TLMDIntArray): Integer; overload;
//This function determines the highest position before which AVal can be inserted in the Arr and still preserve its ordering
function  LMDIntArrayUpperBound(AVal: Integer; const Arr: TLMDIntArray): Integer; overload;

//Same as upper overloaded function, but searches in bounds: [AStart..AEnd]
function  LMDIntArrayBinarySearch(AStart, AEnd, AVal: Integer; const Arr: TLMDIntArray): Integer;overload;
//Same as upper overloaded function, but searches in bounds: [AStart..AEnd]
function  LMDIntArrayLowerBound(AStart, AEnd, AVal: Integer; const Arr: TLMDIntArray): Integer; overload;
//Same as upper overloaded function, but searches in bounds: [AStart..AEnd]
function  LMDIntArrayUpperBound(AStart, AEnd, AVal: Integer; const Arr: TLMDIntArray): Integer; overload;

//Inserts AIns value at AIdx position into Arr
procedure LMDIntArrayInsertOne(AIdx: Integer; AIns: Integer; var Arr: TLMDIntArray);

//Makes free space in Arr from AIdx, resizing Arr and moving its contents from AIdx forward
procedure LMDIntArrayInsert(AIdx: Integer; ACount: Integer; var Arr: TLMDIntArray);
//Removes ACount values from AIdx pos from Arr, moving its contents and resizing Arr
procedure LMDIntArrayDelete(AIdx, ACount: Integer; var Arr: TLMDIntArray);

//Same as .Net System.Array.Copy. ASrc and ADst may be same array,
//AStart..AStart+ALength and ADstStart may overlap
procedure LMDIntArrayCopy(var ASrc: TLMDIntArray;
                          AStart: Integer;
                          var ADst: TLMDIntArray;
                          ADstStart: Integer; ACount: Integer);

//Sorts Arr in bounds [AStart..AEnd] using short-sort algorithm (optimized for short arrays)
procedure LMDIntArrayShortSort(AStart, AEnd: Integer; Arr: TLMDIntArray);

//Common arrays

//Same as LMDIntArrayCopy, but uses AOps callback to do real work
procedure LMDArrayCopy(AStart: Integer; ADstStart: Integer; ALength: Integer;
                       AOps: TLMDArrayFunc);
//Same as LMDIntArrayDelete, but uses AOps callback to do real work
procedure LMDArrayDelete(AIdx, ACount: Integer; AOps: TLMDArrayFunc);
//Same as LMDIntArrayShortSort, but uses AOps callback to do real work
procedure LMDArrayShortSort(AStart, AEnd: Integer; AOps: TLMDArrayFunc);
//Same as LMDIntArrayInsert, but uses AOps callback to do real work
procedure LMDArrayInsert(AIdx, ACount: Integer; AOps: TLMDArrayFunc);

function LMDArrayLowerBound(AOps: TLMDArrayFunc): Integer; overload;
function LMDArrayLowerBound(AStart, AEnd: Integer; AOps: TLMDArrayFunc): Integer; overload;
function LMDArrayUpperBound(AOps: TLMDArrayFunc): Integer; overload;
function LMDArrayUpperBound(AStart, AEnd: Integer; AOps: TLMDArrayFunc): Integer; overload;

implementation

uses LMDRtlConst, SysUtils;
//Char array

procedure CheckArrCopy(ASrcLn: Integer; AStart: Integer;
                       ADstLn: Integer; ADstStart: Integer;
                       ACount: Integer);
begin
  if not LMDInRange(AStart, 0, ASrcLn-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AStart]);

  if (not LMDInRange(AStart+ACount, 0, ASrcLn)) or (ACount<0) then
    raise EInvalidArgument.CreateFmt(SLMDInvalidCount, [ACount]);

  if not LMDInRange(ADstStart, 0, ADstLn-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [ADstStart]);

  if (not LMDInRange(ADstStart+ACount, 0, ADstLn)) or (ACount<0) then
    raise EInvalidArgument.CreateFmt(SLMDInvalidCount, [ACount]);
end;

procedure CheckArrDelete(AIdx, ACount, ArrCount: Integer);
begin
  if not LMDInRange(AIdx, 0, ArrCount-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AIdx]);

  if (not LMDInRange(AIdx+ACount, 0, ArrCount)) or (ACount<0) then
    raise EInvalidArgument.CreateFmt(SLMDInvalidCount, [ACount]);
end;

procedure LMDCharArrayCopy(var ASrc: TLMDCharArray; AStart: Integer;
                        var ADst: TLMDCharArray; ADstStart: Integer;
                        ACount: Integer);
begin
  if ACount=0 then
    Exit;

  CheckArrCopy(Length(ASrc), AStart, Length(ADst), ADstStart, ACount);

  System.Move(ASrc[AStart], ADst[ADstStart], ACount*Sizeof(ASrc[0]));

end;

procedure LMDCharArrayCopy(const ASrc: TLMDString; AStart: Integer;
                           var ADst: TLMDCharArray; ADstStart: Integer;
                           ACount: Integer);  overload;
begin
  if ACount=0 then
    Exit;

  CheckArrCopy(Length(ASrc), AStart-1, Length(ADst), ADstStart, ACount);
  System.Move(ASrc[AStart], ADst[ADstStart], ACount*Sizeof(ASrc[1]));

end;

//Common array

procedure LMDArrayCopy(AStart: Integer; ADstStart: Integer; ALength: Integer;
                    AOps: TLMDArrayFunc);
var i: integer;
begin
  if ALength=0 then
    Exit;

  if LMDInRange(ADstStart, AStart, AStart+ALength) then
    for i := ALength-1 downto 0 do
      AOps(ADstStart+i, AStart+i, aoAssign)
  else
    for i := 0 to ALength-1 do
      AOps(ADstStart+i, AStart+i, aoAssign);
end;

procedure LMDArrayDelete(AIdx, ACount: Integer; AOps: TLMDArrayFunc);
var
  LIn: Integer;
begin
  LIn := AOps(-1, -1, aoGetSize);

  CheckArrDelete(AIdx, ACount, LIn);

  if ACount=0 then
    Exit;

  LMDArrayCopy(AIdx+ACount, AIdx, LIn-(AIdx+ACount), AOps);
  AOps(LIn-ACount, -1, aoSetSize);
end;

procedure LMDArrayShortSort(AStart, AEnd: Integer; AOps: TLMDArrayFunc);
var
  p, max, lin: Integer;
begin
  LIn := AOps(-1, -1, aoGetSize);

  if not LMDInRange(AStart, 0, LIn-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AStart]);

  if not LMDInRange(AEnd, 0, LIn-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AEnd]);

  while AEnd>AStart do
  begin
    max := AStart;
    for p := AStart to AEnd do
      if AOps(p, max, aoCompare)>0 then
        max := p;

    AOps(max, AEnd, aoSwap);
    Dec(AEnd)
  end
end;

procedure LMDArrayInsert(AIdx, ACount: Integer; AOps: TLMDArrayFunc);
var
  Lin: Integer;
begin
  Lin := AOps(-1, -1, aoGetSize);

  if not LMDInRange(AIdx, 0, Lin) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AIdx]);

  AOps(Lin+ACount, -1, aoSetSize);
  Inc(Lin, ACount);

  LMDArrayCopy(AIdx, AIdx+ACount, Lin-AIdx-ACount, AOps);
end;

function ArrayFindBound(AStart, AEnd: Integer; ALower: Boolean;
                        AOps: TLMDArrayFunc): Integer; overload;
var
  Cmp, Mid, Lin: Integer;
begin
  Lin := AOps(-1, -1, aoGetSize);

  if not LMDInRange(AStart, -1, Lin) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AStart]);

  if not LMDInRange(AEnd, -1, Lin) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AEnd]);

  if Lin > 0 then
    while AStart<>AEnd do
    begin
      if not ALower then
        Mid := AStart + ((AEnd - AStart) div 2)
      else
        Mid := AEnd - ((AEnd - AStart) div 2);

      Cmp := AOps(Mid, -1, aoCompare);

      if not ALower then
      begin
        if Cmp>0 then
          AEnd := Mid
        else
          AStart := Mid + 1
      end
      else
      begin
        if Cmp<0 then
          AStart := Mid
        else
          AEnd := Mid-1
      end
    end;

  result := AStart
end;

function ArrayFindBound(ALower: Boolean; AOps: TLMDArrayFunc): Integer; overload;
var
  First, Last, Lin: Integer;
begin
  Lin := AOps(-1, -1, aoGetSize);

  First := 0; Last := Max(0, Lin-1);
  result := ArrayFindBound(First, Last, ALower, AOps)
end;

function LMDArrayLowerBound(AOps: TLMDArrayFunc): Integer;
begin
  result := ArrayFindBound(true, AOps)
end;

function LMDArrayLowerBound(AStart, AEnd: Integer; AOps: TLMDArrayFunc): Integer;
begin
  result := ArrayFindBound(AStart, AEnd, true, AOps)
end;

function LMDArrayUpperBound(AOps: TLMDArrayFunc): Integer;
begin
  result := ArrayFindBound(false, AOps)
end;

function LMDArrayUpperBound(AStart, AEnd: Integer; AOps: TLMDArrayFunc): Integer;
begin
  result := ArrayFindBound(AStart, AEnd, false, AOps)
end;

//Int arrays

procedure IntArraySwap(I1, I2: Integer; Arr: TLMDIntArray);
var t: Integer;
begin
  t := Arr[I1];
  Arr[I1] := Arr[I2];
  Arr[I2] := t;
end;

function IntArray(Arr: TLMDIntArray): TLMDIntArray;
var
  i: Integer;
begin
  SetLength(result, Length(Arr));

  for i := 0 to Length(Arr) - 1 do
    result[i] := Arr[i];
end;

procedure LMDIntArrayCopy(var ASrc: TLMDIntArray; AStart: Integer;
                          var ADst: TLMDIntArray; ADstStart: Integer;
                          ACount: Integer);
begin
  if ACount=0 then
    Exit;

  CheckArrCopy(Length(ASrc), AStart, Length(ADst), ADstStart, ACount);

  System.Move(ASrc[AStart], ADst[ADstStart], ACount*Sizeof(Integer));

end;

procedure LMDIntArrayDelete(AIdx, ACount: Integer; var Arr: TLMDIntArray);
var
  Lin: Integer;
begin
  if ACount=0 then
    Exit;

  Lin := Length(Arr);
  CheckArrDelete(AIdx, ACount, Lin);

  LMDIntArrayCopy(Arr, AIdx+ACount, Arr, AIdx, Lin-(AIdx+ACount));
  SetLength(Arr, Lin-ACount);
end;

procedure LMDIntArrayInsertOne(AIdx: Integer; AIns: Integer; var Arr: TLMDIntArray);
var
  Ln: Integer;
begin
  Ln := Length(Arr);

  if not LMDInRange(AIdx, 0, Ln) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AIdx]);

  SetLength(Arr, Ln+1);
  LMDIntArrayCopy(Arr, AIdx, Arr, AIdx + 1, Ln - AIdx);
  Arr[AIdx] := AIns;
end;

procedure LMDIntArrayInsert(AIdx: Integer; ACount: Integer; var Arr: TLMDIntArray);
var
  Lin: Integer;
begin
  Lin := Length(Arr);

  if not LMDInRange(AIdx, 0, Lin) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AIdx]);

  SetLength(Arr, Lin+ACount);
  Lin := Lin+ACount;

  LMDIntArrayCopy(Arr, AIdx, Arr, AIdx+ACount, Lin-AIdx-ACount)
end;

function IntArrayFindBound(AStart, AEnd, AVal: Integer;
                           const Arr: TLMDIntArray; ALower: Boolean): Integer;
                                                                      overload;
var Cmp, Mid, Lin: Integer;
begin
  Lin := Length(Arr);

  if not LMDInRange(AStart, 0, Lin-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AStart]);

  if not LMDInRange(AEnd, 0, Lin-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AEnd]);

  while AStart<AEnd do
  begin
    Mid := (AStart + AEnd) div 2;

    Cmp := Arr[Mid]-AVal;

    if not ALower then
    begin
      if Cmp>0 then
        AEnd := Max(AStart, Mid)
      else
        AStart := Min(AEnd, Mid + 1)
    end
    else
    begin
      if Cmp<0 then
        AStart := Min(AEnd, Mid + 1)
      else
        AEnd := Max(AStart, Mid)
    end
  end;

  result := AStart
end;

function IntArrayFindBound(AVal: Integer; const Arr: TLMDIntArray;
                           ALower: Boolean): Integer; overload;
begin
  result := IntArrayFindBound(0, Length(Arr)-1, AVal, Arr, ALower)
end;

function  LMDIntArrayLowerBound(AStart, AEnd, AVal: Integer; const Arr: TLMDIntArray): Integer;
begin
  result := IntArrayFindBound(AStart, AEnd, AVal, Arr, true)
end;

function  LMDIntArrayUpperBound(AStart, AEnd, AVal: Integer; const Arr: TLMDIntArray): Integer;
begin
  result := IntArrayFindBound(AStart, AEnd, AVal, Arr, false)
end;

function  LMDIntArrayLowerBound(AVal: Integer; const Arr: TLMDIntArray): Integer;
begin
  result := IntArrayFindBound(AVal, Arr, true)
end;

function  LMDIntArrayUpperBound(AVal: Integer; const Arr: TLMDIntArray): Integer;
begin
  result := IntArrayFindBound(AVal, Arr, false)
end;

function  LMDIntArrayBinarySearch(AStart, AEnd, AVal: Integer; const Arr: TLMDIntArray): Integer;
begin
  result := LMDIntArrayLowerBound(AStart, AEnd, AVal, Arr);
  if Arr[result]<>AVal then
    result := -1
end;

function LMDIntArrayBinarySearch(AVal: Integer; const Arr: TLMDIntArray): Integer;
begin
  if Length(Arr)>0 then
    result := LMDIntArrayBinarySearch(0, Length(Arr)-1, AVal, Arr)
  else
    result := -1
end;

procedure LMDIntArrayShortSort(AStart, AEnd: Integer; Arr: TLMDIntArray);
var p, max, Lin: Integer;
begin
  Lin := Length(Arr);

  if not LMDInRange(AStart, 0, Lin-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AStart]);

  if not LMDInRange(AEnd, 0, Lin-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AEnd]);

  while AEnd > AStart do
  begin
    max := AStart;
    for p := AStart to AEnd do
      if Arr[p] > Arr[max] then
        max := p;

    if max <> AEnd then
      IntArraySwap(max, AEnd, Arr);

    Dec(AEnd);
  end
end;

end.
