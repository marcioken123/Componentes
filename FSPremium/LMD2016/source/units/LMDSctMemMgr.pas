unit LMDSctMemMgr;
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

LMDSctMemMgr unit (YB)
----------------------
LMD-ScriptPack memory manager for detecting destroyed objects.

Changes
-------
Release 4.0 (March 2009)
 - Initial Release

###############################################################################}


interface

type
  TLMDItemProc = procedure(AItem: TObject) of object;
  TLMDEnumProc = procedure(AItemProc: TLMDItemProc) of object;

// Warning: Never call these functions. They should be called
//          only internally.

procedure InternalSetObjDestroyedProc(AObjDestroyed: TLMDItemProc);
procedure InternalObjectWrapped(AObject: TObject; AEnumerator: TLMDEnumProc);

implementation

type
  TUIntPtr = {$IFDEF LMDCOMP16}NativeUInt{$ELSE}Cardinal{$ENDIF};

  TGC = class
    class procedure ItemProc(AItem: TObject);
    class procedure Collect(AEnumerator: TLMDEnumProc);
  end;

var
  ObjDestroyedProc: TLMDItemProc;
  OldMemMgr:        TMemoryManager;
  GCPend:           Integer;

const
  BITS_CNT = 32768 * 8 * SizeOf(Integer);   // Bits in data.
  IDX_MSK  = BITS_CNT - 1;
  DATA_LNT = BITS_CNT div (SizeOf(Integer) * 8);

type
  TData = array[0..DATA_LNT - 1] of Integer;

var
  Data:   TData;
  GCData: TData;

procedure InternalSetObjDestroyedProc(AObjDestroyed: TLMDItemProc);
begin
  ObjDestroyedProc := AObjDestroyed;
end;

procedure InternalObjectWrapped(AObject: TObject; AEnumerator: TLMDEnumProc);
var
  idx: TUIntPtr;
  pdt: PInteger;
begin
  idx := TUIntPtr(AObject);
  idx := idx + not (idx shl 9);
  idx := idx xor   (idx shr 14);
  idx := idx +     (idx shl 4);
  idx := idx xor   (idx shr 10);
  idx := idx and   IDX_MSK;

  pdt  := @Data[idx shr 5];
  pdt^ := pdt^ or (1 shl (idx and 31));

  Inc(GCPend);
  if GCPend >= 100 then
  begin
    TGC.Collect(AEnumerator);
    GCPend := 0;
  end;
end;

function FreeMemProc(P: Pointer): Integer;
var
  idx: TUIntPtr;
  pdt: PInteger;
begin
  if Assigned(ObjDestroyedProc) then
  begin
    idx := TUIntPtr(P);
    idx := idx + not (idx shl 9);
    idx := idx xor   (idx shr 14);
    idx := idx +     (idx shl 4);
    idx := idx xor   (idx shr 10);
    idx := idx and   IDX_MSK;

    pdt := @Data[idx shr 5];

    if (pdt^ and (1 shl (idx and 31))) <> 0 then
      ObjDestroyedProc(P);
  end;
  
  Result := OldMemMgr.FreeMem(P);
end;

procedure InitMemMgr;
var
  mm: TMemoryManager;
begin
  GetMemoryManager(OldMemMgr);

  mm.GetMem     := OldMemMgr.GetMem;
  mm.ReallocMem := OldMemMgr.ReallocMem;
  mm.FreeMem    := FreeMemProc;

  SetMemoryManager(mm);
end;

class procedure TGC.Collect(AEnumerator: TLMDEnumProc);
var
  i:  Integer;
begin
  i := 0;
  while i <= High(GCData) do
  begin
    GCData[i]     := 0;
    GCData[i + 1] := 0;
    GCData[i + 2] := 0;
    GCData[i + 3] := 0;
    Inc(i, 4);
  end;

  AEnumerator(ItemProc);
  Data := GCData;
end;

class procedure TGC.ItemProc(AItem: TObject);
var
  idx: TUIntPtr;
  pdt: PInteger;
begin
  idx := TUIntPtr(AItem);
  idx := idx + not (idx shl 9);
  idx := idx xor   (idx shr 14);
  idx := idx +     (idx shl 4);
  idx := idx xor   (idx shr 10);
  idx := idx and   IDX_MSK;

  pdt  := @GCData[idx shr 5];
  pdt^ := pdt^ or (1 shl (idx and 31));
end;

initialization
  InitMemMgr;

finalization
  SetMemoryManager(OldMemMgr);

end.
