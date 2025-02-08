unit LMDRegionMask;
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

LMDRegionMask unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Graphics,
  Classes,
  LMDClass,
  LMDObject,
  LMDGraph;

type

  TLMDRegionMask = class(TLMDObject)
  private
    FRegionData  : PRGNDATA;
    FDataSize    : Integer;
    FBmpUp,
    FBmpDn,
    FBmp         : TBitmap; //normal (contains "flat" image for button, up/down image for others)
    FPixelFormat : TLMDSavePixelFormat;
    FCompressed  : Boolean;

    procedure SetRegionData (aValue : PRGNDATA);
    procedure SetDataSize (aValue : Integer);
    procedure SetBorderBmp (index : integer;aValue : TBitmap);

    procedure ReadRegionData (Reader : TStream);
    procedure ReadBitmap (Stream:TStream);
    procedure ReadUpBitmap (Stream:TStream);
    procedure ReadDnBitmap (Stream:TStream);
    procedure WriteRegionData (Writer : TStream);
    procedure WriteBitmap (Stream:TStream);
    procedure WriteUpBitmap (Stream:TStream);
    procedure WriteDnBitmap (Stream:TStream);
  protected
    procedure DefineProperties (Filer : TFiler); override;
  public
    constructor Create(Owner:TPersistent=nil); override;
    destructor Destroy; override;
    procedure Assign(Source:TPersistent); override;
    procedure CreateBorderUpBmp;
    procedure CreateBorderDnBmp;

    procedure GetMem;
    procedure FreeMem;
    procedure GetRegionData (frh : HRGN);
    property RegionData : PRGNDATA read FRegionData write SetRegionData;
    property BorderBmp : TBitmap index 0 read FBmp write SetBorderBmp;
    property BorderUpBmp : TBitmap index 1 read FBmpUp write SetBorderBmp;
    property BorderDnBmp : TBitmap index 2 read FBmpDn write SetBorderBmp;
  published
    property RegionDataSize : Integer read FDataSize write SetDataSize default 0;
    property Compressed : Boolean read FCompressed write FCompressed default false;
    property PixelFormat:TLMDSavePixelFormat read FPixelFormat write FPixelFormat default spfDefault;
  end;

function  AllocRegionData(Size: integer): PRGNDATA;
procedure FreeRegionData(Data: PRGNDATA);

implementation

uses

  LMDProcs, LMDStreamUtils;

function  AllocRegionData(Size: integer): PRGNDATA;
begin
  if  Size = 0 then
    Result := nil
  else

    System.GetMem(Result, Size);

end;

procedure FreeRegionData(Data: PRGNDATA);
begin
  if Data <> nil then

    System.FreeMem (Data);

end;

{------------------------------ TLMDRegionMask --------------------------------}
procedure TLMDRegionMask.SetDataSize (aValue : Integer);
begin
  FDataSize := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.SetRegionData (aValue : PRGNDATA);
begin
  FRegionData := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.SetBorderBmp (index : Integer;aValue : TBitmap);
begin
  case index of
    0 : FBmp.Assign (aValue);
    1 : FBmpUp.Assign (aValue);
    2 : FBmpDn.Assign (aValue);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegionMask.ReadRegionData (Reader : TStream);

begin
//  if FDataSize <> 0 then
    begin
      GetMem;

      Reader.ReadBuffer (FRegionData^, FDataSize);

    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.ReadBitmap(Stream:TStream);
begin
  if not Assigned(FBmp) then
    begin
      FBmp:=TBitmap.Create;
    end;
  FCompressed:=Boolean(stReadByte(Stream));
  stReadBitmap(Stream, FBmp, FCompressed);
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.ReadUpBitmap(Stream:TStream);
begin
  if not Assigned(FBmpUp) then
    begin
      FBmpUp:=TBitmap.Create;
    end;
  FCompressed:=Boolean(stReadByte(Stream));
  stReadBitmap(Stream, FBmpUp, FCompressed);
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.ReadDnBitmap(Stream:TStream);
begin
  if not Assigned(FBmpDn) then
    begin
      FBmpDn:=TBitmap.Create;
    end;
  FCompressed:=Boolean(stReadByte(Stream));
  stReadBitmap(Stream, FBmpDn, FCompressed);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegionMask.WriteRegionData (Writer : TStream);

begin
//  if (FRegionData = nil) and (FDataSize > 0) then FDataSize := 0; //just to prevent error

  Writer.WriteBuffer (FRegionData^, FDataSize);

end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.WriteBitmap(Stream:TStream);
begin
  stWriteByte(Stream, Ord(FCompressed));
  stWriteBitmap(Stream, FBmp, FCompressed, -1{LMDPixelFormatColors[FPixelFormat]});
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.WriteUpBitmap(Stream:TStream);
begin
  stWriteByte(Stream, Ord(FCompressed));
  stWriteBitmap(Stream, FBmpUp, FCompressed, -1{LMDPixelFormatColors[FPixelFormat]});
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.WriteDnBitmap(Stream:TStream);
begin
  stWriteByte(Stream, Ord(FCompressed));
  stWriteBitmap(Stream, FBmpDn, FCompressed, -1{LMDPixelFormatColors[FPixelFormat]});
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRegionMask.DefineProperties (Filer : TFiler);
begin
  inherited DefineProperties (Filer);

  Filer.DefineBinaryProperty ('RegionData', ReadRegionData, WriteRegionData, FDataSize <> 0);
  Filer.DefineBinaryProperty('BorderBmp', ReadBitmap, WriteBitmap, not FBmp.Empty);
  Filer.DefineBinaryProperty('BorderUpBmp', ReadUpBitmap, WriteUpBitmap, not FBmpUp.Empty);
  Filer.DefineBinaryProperty('BorderDnBmp', ReadDnBitmap, WriteDnBitmap, not FBmpDn.Empty);
end;

{------------------------------------------------------------------------------}
constructor TLMDRegionMask.Create;
begin
  inherited Create;
  FBmp := TBitmap.Create;
  FBmpUp := TBitmap.Create;
  FBmpDn := TBitmap.Create;
  FDataSize := 0;
  FRegionData := nil;
  FCompressed := false;
end;

{------------------------------------------------------------------------------}
destructor TLMDRegionMask.Destroy;
begin
  if FBmpUp <> nil then FBmpUp.Free;
  if FBmpDn <> nil then FBmpDn.Free;
  FreeMem;
//  FDataSize := 0;
//  System.FreeMem (FRegionData);
  FBmp.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.Assign (Source : TPersistent);
var
  Src: TLMDRegionMask;

begin
  if Source=self then exit;
  if Source is TLMDRegionMask then
    begin
      FreeMem;
      Src := TLMDRegionMask(Source);

      if Src.RegionDataSize > 0 then
        begin
          FDataSize := Src.RegionDataSize;
          GetMem;

          if  FDataSize > 0 then

            CopyMemory (FRegionData, Src.RegionData, FDataSize);

//          FRegionData^ := TLMDRegionMask (Source).RegionData^;
          //get the border bmp
          FBmp.Assign(Src.BorderBmp);
          FBmpUp.Assign(Src.BorderUpBmp);
          FBmpDn.Assign(Src.BorderDnBmp);
          FCompressed := Src.Compressed;
        end;
    end
  else
    inherited Assign (Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDregionMask.CreateBorderUpBmp;
begin
  if FBmpUp = nil then
    FBmpUp := TBitmap.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.CreateBorderDnBmp;
begin
  if FBmpDn = nil then
    FBmpDn := TBitmap.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.GetMem;
begin
  //FDataSize should contain a valid value
  FRegionData := AllocRegionData(FDataSize);
end;

{------------------------------------------------------------------------------}
procedure TLMDRegionMask.FreeMem;
begin
  //FDataSize should contain a valid value
  FreeRegionData(FRegionData);
  FRegionData := nil;
  FDataSize := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDRegionMask.GetRegionData (frh : HRGN);
begin
  Windows .GetRegionData (frh, FDataSize, FRegionData);
end;

end.

