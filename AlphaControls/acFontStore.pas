unit acFontStore;
{$I sDefs.inc}
// {$DEFINE LOGGED}

interface

uses
  Windows, Messages, Graphics, Forms, Menus, Classes, Controls, ExtCtrls,
{$IFNDEF DELPHI5}types, {$ENDIF}
{$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sConst;


type
{$IFNDEF NOTFORHELP}
  TacEmbeddedFont = class(TCollectionItem)
  protected
    FFileName, FFontName: acString;
    Handle: THandle;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadData(Reader: TStream);
    procedure WriteData(Writer: TStream);
  public
    FontData: TMemoryStream;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    constructor Create(ACollection: TCollection); override;
    procedure UnLoadFont;
    procedure LoadFont;
  published
    property FileName: acString read FFileName write FFileName;
    property FontName: acString read FFontName write FFontName;
  end;


  TacEmbeddedFonts = class(TCollection)
  protected
    FOwner: TComponent;
    function GetItem(Index: Integer): TacEmbeddedFont;
    procedure SetItem(Index: Integer; const Value: TacEmbeddedFont);
  public
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent);
    property Items[index: Integer]: TacEmbeddedFont read GetItem write SetItem; default;
  end;


  TacFonts = class(TacEmbeddedFonts);
{$ENDIF} // NOTFORHELP


  {$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsFontStore = class(TComponent)
{$IFNDEF NOTFORHELP}
  private
    FFonts: TacFonts;
    FOnFontListChanged: TNotifyEvent;
  public
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetFontNames(aStrings: TStringList): Integer;
    procedure Loaded; override;
    procedure LoadFonts;
  published
{$ENDIF} // NOTFORHELP
    property Fonts: TacFonts read FFonts write FFonts;
    property OnFontListChanged: TNotifyEvent read FOnFontListChanged write FOnFontListChanged;
  end;


{$IFNDEF NOTFORHELP}
const
  {$IFNDEF ALITE}
  sOTFWarning = '<b>Warning!</b> Some Otf-fonts may be non-usable under some old Windows systems.<br>' +
               'Be careful with using of Otf-fonts under old Windows systems.';
  {$ELSE}
  sOTFWarning = 'Warning! Some Otf-fonts may be non-usable under some old Windows systems.'#13#10 +
               'Be careful with using of Otf-fonts under old Windows systems.';
  {$ENDIF}
  sWarnRead = 'I have read this warning, I will remember about it.'#13#10 +
                             'Do not show this window anymore.';
var
  acFontStoreList: TList = nil;
  
{$ENDIF} // NOTFORHELP


implementation

uses
  math, Dialogs, SysUtils,
{$IFNDEF ALITE}

{$ENDIF}
  sGraphUtils, sVCLUtils, sLabel;


procedure TacEmbeddedFonts.Assign(Source: TPersistent);
var
  i: Integer;
begin
  Clear;
  for i := 0 to TacEmbeddedFonts(Source).Count - 1 do
    TacEmbeddedFont(Add).Assign(TacEmbeddedFonts(Source)[i]);
end;


constructor TacEmbeddedFonts.Create(AOwner: TComponent);
begin
  inherited Create(TacEmbeddedFont);
  FOwner := AOwner;
end;


destructor TacEmbeddedFonts.Destroy;
begin
  inherited Destroy;
  FOwner := nil;
end;


function TacEmbeddedFonts.GetItem(Index: Integer): TacEmbeddedFont;
begin
  Result := TacEmbeddedFont(inherited GetItem(index));
end;


procedure TacEmbeddedFonts.SetItem(Index: Integer; const Value: TacEmbeddedFont);
begin
  inherited SetItem(index, Value);
end;


procedure TacEmbeddedFont.Assign(Source: TPersistent);
begin
  FFileName := TacEmbeddedFont(Source).FileName;
  FFontName := TacEmbeddedFont(Source).FontName;
  if TacEmbeddedFont(Source).FontData.Size > 0 then
    TacEmbeddedFont(Source).FontData.SaveToStream(FontData);
end;


procedure TacEmbeddedFont.AssignTo(Dest: TPersistent);
begin
  if Dest <> nil then
    Dest.Assign(Self)
  else
    inherited;
end;


constructor TacEmbeddedFont.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FontData := TMemoryStream.Create;
end;


procedure TacEmbeddedFont.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('FontData', ReadData, WriteData, True);
end;


destructor TacEmbeddedFont.Destroy;
begin
  UnLoadFont;
  FontData.Free;
  inherited Destroy;
end;


procedure TacEmbeddedFont.LoadFont;
var
  FontCount: DWord;
begin
  FontCount := 1;
  Handle := AddFontMemResourceEx(FontData.Memory, FontData.Size, nil, @FontCount);
end;


procedure TacEmbeddedFont.ReadData(Reader: TStream);
begin
  FontData.LoadFromStream(Reader);
end;


procedure TacEmbeddedFont.UnLoadFont;
begin
  RemoveFontMemResourceEx(Handle);
end;


procedure TacEmbeddedFont.WriteData(Writer: TStream);
begin
  FontData.SaveToStream(Writer);
end;


procedure TsFontStore.Assign(Source: TPersistent);
begin
  Fonts.BeginUpdate;
  try
    Fonts.Clear;
    if Source <> nil then begin
      if Source is TsFontStore then
        Fonts.Assign(TsFontStore(Source).Fonts)
      else
        inherited Assign(Source);

      if Assigned(FOnFontListChanged) then
        FOnFontListChanged(Self);
    end;
  finally
    Fonts.EndUpdate;
  end;
end;


procedure TsFontStore.AssignTo(Dest: TPersistent);
begin
  if Dest is TsFontStore then
    Dest.Assign(Self)
  else
    inherited AssignTo(Dest);
end;


constructor TsFontStore.Create(AOwner: TComponent);
begin
  inherited;
  FFonts := TacFonts.Create(Self);
  if acFontStoreList = nil then
    acFontStoreList := TList.Create;

  acFontStoreList.Add(Self);
end;


destructor TsFontStore.Destroy;
begin
  acFontStoreList.Remove(Self);
  FFonts.Free;
  inherited;
end;


function TsFontStore.GetFontNames(aStrings: TStringList): Integer;
var
  i: integer;
begin
  aStrings.BeginUpdate;
  for i := 0 to FFonts.Count - 1 do
    aStrings.Add(FFonts[i].FontName);

  aStrings.Sort;
  aStrings.EndUpdate;
  Result := aStrings.Count;
end;


procedure TsFontStore.Loaded;
begin
  inherited;
  LoadFonts;
  if Assigned(FOnFontListChanged) then
    FOnFontListChanged(Self);
end;


procedure TsFontStore.LoadFonts;
var
  i: Integer;
begin
  for i := 0 to FFonts.Count - 1 do
    FFonts[i].LoadFont;
end;


initialization


finalization
  FreeAndNil(acFontStoreList);

end.
