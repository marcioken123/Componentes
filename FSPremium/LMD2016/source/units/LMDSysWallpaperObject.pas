unit LMDSysWallpaperObject;
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

LMDSysWallpaperObject unit (JH, AH)
-----------------------------------
Information about wallpaper settings

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes, 
  LMDSysBase, LMDSysObject;

type
  { ************************************************************************** }
  TLMDSysWallpaperObject = class(TLMDSysObject)
  private
    FPatternMask: string;
    FPattern: string;
    FFilename: string;
    FStretch: Boolean;
    FTile: Boolean;
    FPatternMasks: TStrings;
    FPatterns: TStrings;

    procedure SetString(index: Integer; aValue: string);
    procedure SetBoolean(index: Integer; aValue: Boolean);
    procedure SetDummyPatterns(aValue: TStrings);
    function GetString(index: Integer): string;
    function GetBoolean(index: Integer): Boolean;
    function GetPatterns: TStrings;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    //    procedure GetValues(aText: TStrings); override;

    procedure Apply; override;
    procedure Refresh; override;

    procedure GetPatternBitmap(aPatName: string; aBitmap: TBitmap);

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

  published
    property Filename: string index 0 read GetString write SetString stored false;
    property Tile: Boolean index 0 read GetBoolean write SetBoolean stored false;
    property Stretch: Boolean index 1 read GetBoolean write SetBoolean stored false;
    property Patterns: TStrings read GetPatterns write SetDummyPatterns stored false;
    property Pattern: string index 1 read GetString write SetString stored false;
  end;

implementation

uses
  SysUtils,
  LMDSysIn, LMDSysLogStrings, LMDSysConst;

const
  cpidFilename  = 0;
  cpidTile      = 1;
  cpidStretch   = 2;
  cpidPatterns  = 3;
  cpidPattern   = 4;

procedure LMDPatternBitMaskToBitmap(aBitMask: string; aBitmap: TBitmap);
var
  y, row: Integer;
  s: string;

  function gc(r, i: Integer): TColor;
  begin
    if Boolean(r and i) then
      Result:= clBlack
    else
      Result:= clWhite;
  end;

begin
  aBitmap.Width:= 8;
  aBitmap.Height:= 8;
  y:= 0;
  while aBitMask <> '' do
    begin
      if Pos(' ', aBitMask) <> 0 then
        begin
          s:= Copy(aBitMask, 1, Pos(' ', aBitMask) - 1);
          Delete(aBitMask, 1, Pos(' ', aBitMask));
        end
      else
        s:= aBitMask;
      row:= StrToInt(s);
      aBitmap.Canvas.Pixels[0, y]:= gc(row, 1);
      aBitmap.Canvas.Pixels[0, y]:= gc(row, 2);
      aBitmap.Canvas.Pixels[0, y]:= gc(row, 4);
      aBitmap.Canvas.Pixels[0, y]:= gc(row, 8);
      aBitmap.Canvas.Pixels[0, y]:= gc(row, 16);
      aBitmap.Canvas.Pixels[0, y]:= gc(row, 32);
      aBitmap.Canvas.Pixels[0, y]:= gc(row, 64);
      aBitmap.Canvas.Pixels[0, y]:= gc(row, 128);
      inc(y);
    end;
end;

{ --------------------------------- private ---------------------------------- }
procedure TLMDSysWallpaperObject.SetString(index: Integer; aValue: string);
begin
  case index of
    0:
      if aValue <> FFilename then
        begin
          RememberChange(strWallpaperFileName, FFilename, aValue);
          FFilename:= aValue;
        end;
    1:
      if aValue <> FPattern then
        begin
          RememberChange(strWallpaperPattern, FPattern, aValue);
          FPattern:= aValue;
        end;
  end;
  if ApplyChangesAtOnce then
    Apply;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysWallpaperObject.SetBoolean(index: Integer; aValue: Boolean);
begin
  case index of
    0:
      if FTile <> aValue then
        begin
          RememberChange(strWallpaperTile, BoolToStr(FTile), BoolToStr(aValue));
          FTile:= aValue;
        end;
    1:
      if FStretch <> aValue then
        begin
          RememberChange(strWallpaperStretch, BoolToStr(FStretch), BoolToStr(aValue));
          FStretch:= aValue;
        end;
  end;
  if ApplyChangesAtOnce then
    Apply;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWallpaperObject.SetDummyPatterns(aValue: TStrings);
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWallpaperObject.GetString(index: Integer): string;
begin
  if FInstantUpdate then
    Refresh;
  case index of
    0: Result:= FFilename;
    1: Result:= FPattern;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWallpaperObject.GetBoolean(index: Integer): Boolean;
begin
  if FInstantUpdate then
    Refresh;
  case index of
    0: Result:= FTile;
    1: Result:= FStretch;
  else
    Result:= false;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWallpaperObject.GetPatterns: TStrings;
begin
  if FInstantUpdate then
    Refresh;

  Result:= FPatterns;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWallpaperObject.GetPatternBitmap(aPatName: string; aBitmap: TBitmap);
var
  i: Integer;
begin
  //i = 0 is no! -> has no mask!!!
  for i:= 1 to FPatterns.Count - 1 do
    if UpperCase(aPatName) = UpperCase(FPatterns[i]) then
      LMDPatternBitMaskToBitmap(FPatternMasks[i], aBitmap);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWallpaperObject.GetElementTitle : string;
begin
  result := sLMDSysDisplayWallpaperObjectTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWallpaperObject.GetElementDescription : string;
begin
  result := sLMDSysDisplayWallpaperObjectDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWallpaperObject.GetElementType : TLMDSysInfoType;
begin
  result := itDisplayWallpaper;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWallpaperObject.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidFilename, sLMDSysDisplayWallpaperPropTitleFilename, sLMDSysDisplayWallpaperPropDescFilename);
  FPropertiesDesc.Add(cpidTile, sLMDSysDisplayWallpaperPropTitleTile, sLMDSysDisplayWallpaperPropDescTile);
  FPropertiesDesc.Add(cpidStretch, sLMDSysDisplayWallpaperPropTitleStretch, sLMDSysDisplayWallpaperPropDescStretch);
  FPropertiesDesc.Add(cpidPatterns, sLMDSysDisplayWallpaperPropTitlePatterns, sLMDSysDisplayWallpaperPropDescPatterns);
  FPropertiesDesc.Add(cpidPattern, sLMDSysDisplayWallpaperPropTitlePattern, sLMDSysDisplayWallpaperPropDescPattern);
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDSysWallpaperObject.Create;
begin
  inherited Create;
  FPatterns:= TStringList.Create;
  FPatternMasks:= TStringList.Create;
  //  ApplyChangesAtOnce:= true;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDSysWallpaperObject.Destroy;
begin
  FPatternMasks.Free;
  FPatterns.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

//procedure TLMDSysWallpaperObject.GetValues(aText: TStrings);
//begin
//  aText.Add(FPattern);
//  aText.Add(FPatternMask);
//  aText.Add(FFilename);
//  if FTile then
//    aText.Add('TRUE')
//  else
//    aText.Add('FALSE');
//  aText.AddStrings(FPatterns);
//end;

{------------------------------------------------------------------------------}
procedure TLMDSysWallpaperObject.Refresh;
var
  i: Integer;
  tmpStr : string;
begin
  tmpStr := '';

  DoProgress(sLMDSysDisplayWallpaperObjectTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;
  OpenRegistry(true);
  SetRegistryRootKey(HKEY_CURRENT_USER);

  if OpenRegistrySubKey('\Control Panel\Desktop') then
    begin
      FFilename:= Registry.ReadString('Wallpaper');
        FPropertiesDesc.PropertyByID(cpidFilename).Text := FFilename;
      if Registry.KeyExists('Pattern') then
      begin
        if LMDSIWindowsVistaUp then
          FPatternMask:= inttostr(Registry.ReadInteger('Pattern'))
        else
          FPatternMask:= Registry.ReadString('Pattern');
      end;
      FTile:= Registry.ReadString('TileWallpaper') = '1';
        FPropertiesDesc.PropertyByID(cpidTile).Text := BoolToStr(FTile);
      FStretch:= Registry.ReadString('WallpaperStyle') = '2';
        FPropertiesDesc.PropertyByID(cpidStretch).Text := BoolToStr(FStretch);
      CloseRegistrySubKey;
    end;

  FPatterns.Clear;
  FPatternMasks.Clear;
  if OpenRegistrySubKey('\Control Panel\Patterns') then
    begin
      Registry.GetValueNames(FPatterns);

      //get all pattern bit masks
      for i:= 0 to FPatterns.Count - 1 do
        begin
          DoProgress(sLMDSysDisplayWallpaperObjectTitle, 100, Round(i*100/FPatterns.Count));
          FPatternMasks.Add(Registry.ReadString(FPatterns[i]));
          tmpStr := tmpStr + '; ' + FPatternMasks[i];
        end;
        FPropertiesDesc.PropertyByID(cpidPatterns).Text := tmpStr;
      CloseRegistrySubKey;
    end;

  //find out which pattern is currently used
  FPattern:= '';
  for i:= 0 to FPatterns.Count - 1 do
    if FPatternMasks[i] = FPatternMask then
      FPattern:= FPatterns[i];
  FPropertiesDesc.PropertyByID(cpidPattern).Text := FPattern;

  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWallpaperObject.Apply;
var
  i: LongInt;
  begin
  OpenRegistry(false);

  SetRegistryRootKey(HKEY_CURRENT_USER);

  if OpenRegistrySubKey('\Control Panel\Desktop') then
    begin

      if PropChanged(strWallpaperTile) then
        begin
          WriteToLog(strWallpaperTile);
          if FTile then
            Registry.WriteString('TileWallpaper', '1')
          else
            Registry.WriteString('TileWallpaper', '0');
        end;

      if PropChanged(strWallpaperStretch) then
        begin
          WriteToLog(strWallpaperStretch);
          if FStretch then
            Registry.WriteString('WallpaperStyle', '2')
          else
            Registry.WriteString('WallpaperStyle', '0');
        end;

      if PropChanged(strWallpaperPattern) then
        begin
          WriteToLog(strWallpaperPattern);
          for i:= 0 to FPatterns.Count - 1 do
            if FPatterns[i] = FPattern then
              Registry.WriteString('Pattern', FPatternMasks[i]);
        end;
      CloseRegistrySubKey;

      if PropChanged(strWallpaperFileName) then
        begin
          WriteToLog(strWallpaperFileName);
          SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, PChar(FFilename), 0);
          end;
    end;
end;

end.
