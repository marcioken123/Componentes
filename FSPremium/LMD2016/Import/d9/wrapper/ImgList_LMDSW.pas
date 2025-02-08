unit ImgList_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ImgList' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, Classes, Graphics, CommCtrl, ImgList,
  Windows_LMDSW, Classes_LMDSW, Graphics_LMDSW, CommCtrl_LMDSW;


{ Type wrappers }

type
  TChangeLink_sw = class;
  TCustomImageList_sw = class;

  TChangeLink_sc = class of TChangeLink;
  TChangeLink_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TChangeLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TChangeLink;
    class function ClassToVar(AClass: TChangeLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TChangeLink_sc;
  end;

  TDrawingStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDrawingStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TDrawingStyle;
  end;

  TImageType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TImageType): OleVariant;
    class function FromVar(const AValue: OleVariant): TImageType;
  end;

  TResType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TResType): OleVariant;
    class function FromVar(const AValue: OleVariant): TResType;
  end;

  TOverlay_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TOverlay): OleVariant;
    class function FromVar(const AValue: OleVariant): TOverlay;
  end;

  TLoadResource_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TLoadResource): OleVariant;
    class function FromVar(const AValue: OleVariant): TLoadResource;
  end;

  TLoadResources_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TLoadResources): OleVariant;
    class function FromVar(const AValue: OleVariant): TLoadResources;
  end;

  TImageIndex_sw = class(Integer_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TImageIndex): OleVariant;
    class function FromVar(const AValue: OleVariant): TImageIndex;
  end;

  TCustomImageList_sc = class of TCustomImageList;
  TCustomImageList_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomImageList): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomImageList;
    class function ClassToVar(AClass: TCustomImageList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomImageList_sc;
  end;


{ Unit wrapper }

type
  ImgList_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TChangeLink_sw }

function TChangeLink_Change_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Change;

  TChangeLink(AObj).Change();
end;

function TChangeLink_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TChangeLink(AObj).OnChange)
  else
    TChangeLink(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TChangeLink_Sender_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sender: TCustomImageList read <getter> write <se...

  if IsGet then
    Result := TCustomImageList_sw.ToVar(TChangeLink(AObj).Sender)
  else
    TChangeLink(AObj).Sender := TCustomImageList_sw.FromVar(AArgs[0]);
end;

class function TChangeLink_sw.GetTypeName: WideString;
begin
  Result := 'TChangeLink';
end;

class function TChangeLink_sw.GetWrappedClass: TClass;
begin
  Result := TChangeLink;
end;

class procedure TChangeLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Change', TChangeLink_Change_si, 0, False);
  AData.AddProperty('OnChange', TChangeLink_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('Sender', TChangeLink_Sender_si, TCustomImageList_sw, True, True, 0, False, False);
end;

class function TChangeLink_sw.ToVar(const AValue: TChangeLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TChangeLink_sw.FromVar(const AValue: OleVariant): TChangeLink;
begin
  Result := TChangeLink(ConvFromVar(AValue, TChangeLink));
end;

class function TChangeLink_sw.ClassToVar(AClass: TChangeLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TChangeLink_sw.ClassFromVar(
  const AClass: OleVariant): TChangeLink_sc;
begin
  Result := TChangeLink_sc(ConvClsFromVar(AClass, TChangeLink));
end;

{ TDrawingStyle_sw }

class function TDrawingStyle_sw.GetTypeName: WideString;
begin
  Result := 'TDrawingStyle';
end;

class procedure TDrawingStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'dsFocus'; Value: Integer({$IFDEF LMDSCT_12}TDrawingStyle.{$ENDIF}dsFocus)),
    (Name: 'dsSelected'; Value: Integer({$IFDEF LMDSCT_12}TDrawingStyle.{$ENDIF}dsSelected)),
    (Name: 'dsNormal'; Value: Integer({$IFDEF LMDSCT_12}TDrawingStyle.{$ENDIF}dsNormal)),
    (Name: 'dsTransparent'; Value: Integer({$IFDEF LMDSCT_12}TDrawingStyle.{$ENDIF}dsTransparent))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TDrawingStyle_sw.ToVar(const AValue: TDrawingStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDrawingStyle_sw.FromVar(
  const AValue: OleVariant): TDrawingStyle;
begin
  Result := TDrawingStyle(Integer(AValue));
end;

{ TImageType_sw }

class function TImageType_sw.GetTypeName: WideString;
begin
  Result := 'TImageType';
end;

class procedure TImageType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'itImage'; Value: Integer({$IFDEF LMDSCT_12}TImageType.{$ENDIF}itImage)),
    (Name: 'itMask'; Value: Integer({$IFDEF LMDSCT_12}TImageType.{$ENDIF}itMask))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TImageType_sw.ToVar(const AValue: TImageType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TImageType_sw.FromVar(const AValue: OleVariant): TImageType;
begin
  Result := TImageType(Integer(AValue));
end;

{ TResType_sw }

class function TResType_sw.GetTypeName: WideString;
begin
  Result := 'TResType';
end;

class procedure TResType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'rtBitmap'; Value: Integer({$IFDEF LMDSCT_12}TResType.{$ENDIF}rtBitmap)),
    (Name: 'rtCursor'; Value: Integer({$IFDEF LMDSCT_12}TResType.{$ENDIF}rtCursor)),
    (Name: 'rtIcon'; Value: Integer({$IFDEF LMDSCT_12}TResType.{$ENDIF}rtIcon))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TResType_sw.ToVar(const AValue: TResType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TResType_sw.FromVar(const AValue: OleVariant): TResType;
begin
  Result := TResType(Integer(AValue));
end;

{ TOverlay_sw }

class function TOverlay_sw.GetTypeName: WideString;
begin
  Result := 'TOverlay';
end;

class function TOverlay_sw.ToVar(const AValue: TOverlay): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TOverlay_sw.FromVar(const AValue: OleVariant): TOverlay;
begin
  Result := TOverlay(Integer(AValue));
end;

{ TLoadResource_sw }

class function TLoadResource_sw.GetTypeName: WideString;
begin
  Result := 'TLoadResource';
end;

class procedure TLoadResource_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'lrDefaultColor'; Value: Integer({$IFDEF LMDSCT_12}TLoadResource.{$ENDIF}lrDefaultColor)),
    (Name: 'lrDefaultSize'; Value: Integer({$IFDEF LMDSCT_12}TLoadResource.{$ENDIF}lrDefaultSize)),
    (Name: 'lrFromFile'; Value: Integer({$IFDEF LMDSCT_12}TLoadResource.{$ENDIF}lrFromFile)),
    (Name: 'lrMap3DColors'; Value: Integer({$IFDEF LMDSCT_12}TLoadResource.{$ENDIF}lrMap3DColors)),
    (Name: 'lrTransparent'; Value: Integer({$IFDEF LMDSCT_12}TLoadResource.{$ENDIF}lrTransparent)),
    (Name: 'lrMonoChrome'; Value: Integer({$IFDEF LMDSCT_12}TLoadResource.{$ENDIF}lrMonoChrome))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TLoadResource_sw.ToVar(const AValue: TLoadResource): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TLoadResource_sw.FromVar(
  const AValue: OleVariant): TLoadResource;
begin
  Result := TLoadResource(Integer(AValue));
end;

{ TLoadResources_sw }

class function TLoadResources_sw.GetTypeName: WideString;
begin
  Result := 'TLoadResources';
end;

class function TLoadResources_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TLoadResources);
end;

class function TLoadResources_sw.ToVar(
  const AValue: TLoadResources): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TLoadResources_sw.FromVar(
  const AValue: OleVariant): TLoadResources;
begin
  ConvFromVar(AValue, @Result);
end;

{ TImageIndex_sw }

class function TImageIndex_sw.GetTypeName: WideString;
begin
  Result := 'TImageIndex';
end;

class function TImageIndex_sw.ToVar(const AValue: TImageIndex): OleVariant;
begin
  Result := Integer_sw.ToVar(Integer(AValue));
end;

class function TImageIndex_sw.FromVar(const AValue: OleVariant): TImageIndex;
begin
  Result := TImageIndex(Integer_sw.FromVar(AValue));
end;

{ TCustomImageList_sw }

function TCustomImageList_CreateSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor CreateSize(AWidth: Integer; AHeight: Integer);

  Result := TCustomImageList_sw.ToVar(TCustomImageList_sc(AObj).CreateSize(
    Integer(AArgs[0]), Integer(AArgs[1])));
end;

function TCustomImageList_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(Image: TBitmap; Mask: TBitmap): Integer;

  Result := TCustomImageList(AObj).Add(TBitmap_sw.FromVar(AArgs[0]), TBitmap_sw.
    FromVar(AArgs[1]));
end;

function TCustomImageList_AddIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddIcon(Image: TIcon): Integer;

  Result := TCustomImageList(AObj).AddIcon(TIcon_sw.FromVar(AArgs[0]));
end;

function TCustomImageList_AddImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddImage(Value: TCustomImageList; Index: Integer...

  Result := TCustomImageList(AObj).AddImage(TCustomImageList_sw.FromVar(
    AArgs[0]), Integer(AArgs[1]));
end;

function TCustomImageList_AddImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddImages(Value: TCustomImageList);

  TCustomImageList(AObj).AddImages(TCustomImageList_sw.FromVar(AArgs[0]));
end;

function TCustomImageList_AddMasked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddMasked(Image: TBitmap; MaskColor: TColor): In...

  Result := TCustomImageList(AObj).AddMasked(TBitmap_sw.FromVar(AArgs[0]), 
    TColor_sw.FromVar(AArgs[1]));
end;

function TCustomImageList_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TCustomImageList(AObj).Clear();
end;

function TCustomImageList_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TCustomImageList(AObj).Delete(Integer(AArgs[0]));
end;

function TCustomImageList_Draw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Draw(Canvas: TCanvas; X: Integer; Y: Integer; I...

  case AArgsSize of
    4:
    begin
      TCustomImageList(AObj).Draw(TCanvas_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3]));
    end;
    5:
    begin
      TCustomImageList(AObj).Draw(TCanvas_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3]), Boolean(AArgs[4]));
    end;
  else
    WrongArgCountError('Draw');
  end;
end;

function TCustomImageList_DrawOverlay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DrawOverlay(Canvas: TCanvas; X: Integer; Y: Int...

  case AArgsSize of
    5:
    begin
      TCustomImageList(AObj).DrawOverlay(TCanvas_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3]), TOverlay_sw.FromVar(
        AArgs[4]));
    end;
    6:
    begin
      TCustomImageList(AObj).DrawOverlay(TCanvas_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3]), TOverlay_sw.FromVar(
        AArgs[4]), Boolean(AArgs[5]));
    end;
  else
    WrongArgCountError('DrawOverlay');
  end;
end;

function TCustomImageList_FileLoad_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FileLoad(ResType: TResType; const Name: string; ...

  Result := TCustomImageList(AObj).FileLoad(TResType_sw.FromVar(AArgs[0]), 
    string(AArgs[1]), TColor_sw.FromVar(AArgs[2]));
end;

function TCustomImageList_GetBitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetBitmap(Index: Integer; Image: TBitmap): Boolean;

  Result := TCustomImageList(AObj).GetBitmap(Integer(AArgs[0]), TBitmap_sw.
    FromVar(AArgs[1]));
end;

function TCustomImageList_GetHotSpot_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHotSpot: TPoint;

  Result := TPoint_sw.ToVar(TCustomImageList(AObj).GetHotSpot());
end;

function TCustomImageList_GetIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetIcon(Index: Integer; Image: TIcon);

  TCustomImageList(AObj).GetIcon(Integer(AArgs[0]), TIcon_sw.FromVar(AArgs[1]));
end;

function TCustomImageList_GetImageBitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetImageBitmap: HBITMAP;

  Result := HBITMAP_sw.ToVar(TCustomImageList(AObj).GetImageBitmap());
end;

function TCustomImageList_GetMaskBitmap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetMaskBitmap: HBITMAP;

  Result := HBITMAP_sw.ToVar(TCustomImageList(AObj).GetMaskBitmap());
end;

function TCustomImageList_GetResource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetResource(ResType: TResType; const Name: strin...

  Result := TCustomImageList(AObj).GetResource(TResType_sw.FromVar(AArgs[0]), 
    string(AArgs[1]), Integer(AArgs[2]), TLoadResources_sw.FromVar(AArgs[3]),
    TColor_sw.FromVar(AArgs[4]));
end;

function TCustomImageList_GetInstRes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetInstRes(Instance: THandle; ResType: TResType;...

  Result := TCustomImageList(AObj).GetInstRes(THandle_sw.FromVar(AArgs[0]), 
    TResType_sw.FromVar(AArgs[1]), string(AArgs[2]), Integer(AArgs[3]),
    TLoadResources_sw.FromVar(AArgs[4]), TColor_sw.FromVar(AArgs[5]));
end;

function TCustomImageList_HandleAllocated_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandleAllocated: Boolean;

  Result := TCustomImageList(AObj).HandleAllocated();
end;

function TCustomImageList_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Insert(Index: Integer; Image: TBitmap; Mask: TB...

  TCustomImageList(AObj).Insert(Integer(AArgs[0]), TBitmap_sw.FromVar(AArgs[1]),
    TBitmap_sw.FromVar(AArgs[2]));
end;

function TCustomImageList_InsertIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InsertIcon(Index: Integer; Image: TIcon);

  TCustomImageList(AObj).InsertIcon(Integer(AArgs[0]), TIcon_sw.FromVar(
    AArgs[1]));
end;

function TCustomImageList_InsertMasked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InsertMasked(Index: Integer; Image: TBitmap; Ma...

  TCustomImageList(AObj).InsertMasked(Integer(AArgs[0]), TBitmap_sw.FromVar(
    AArgs[1]), TColor_sw.FromVar(AArgs[2]));
end;

function TCustomImageList_Move_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Move(CurIndex: Integer; NewIndex: Integer);

  TCustomImageList(AObj).Move(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TCustomImageList_Overlay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Overlay(ImageIndex: Integer; Overlay: TOverlay):...

  Result := TCustomImageList(AObj).Overlay(Integer(AArgs[0]), TOverlay_sw.
    FromVar(AArgs[1]));
end;

function TCustomImageList_RegisterChanges_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RegisterChanges(Value: TChangeLink);

  TCustomImageList(AObj).RegisterChanges(TChangeLink_sw.FromVar(AArgs[0]));
end;

function TCustomImageList_ResourceLoad_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ResourceLoad(ResType: TResType; const Name: stri...

  Result := TCustomImageList(AObj).ResourceLoad(TResType_sw.FromVar(AArgs[0]), 
    string(AArgs[1]), TColor_sw.FromVar(AArgs[2]));
end;

function TCustomImageList_ResInstLoad_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ResInstLoad(Instance: THandle; ResType: TResType...

  Result := TCustomImageList(AObj).ResInstLoad(THandle_sw.FromVar(AArgs[0]), 
    TResType_sw.FromVar(AArgs[1]), string(AArgs[2]), TColor_sw.FromVar(AArgs[3]));
end;

function TCustomImageList_Replace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Replace(Index: Integer; Image: TBitmap; Mask: T...

  TCustomImageList(AObj).Replace(Integer(AArgs[0]), TBitmap_sw.FromVar(
    AArgs[1]), TBitmap_sw.FromVar(AArgs[2]));
end;

function TCustomImageList_ReplaceIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReplaceIcon(Index: Integer; Image: TIcon);

  TCustomImageList(AObj).ReplaceIcon(Integer(AArgs[0]), TIcon_sw.FromVar(
    AArgs[1]));
end;

function TCustomImageList_ReplaceMasked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReplaceMasked(Index: Integer; NewImage: TBitmap...

  TCustomImageList(AObj).ReplaceMasked(Integer(AArgs[0]), TBitmap_sw.FromVar(
    AArgs[1]), TColor_sw.FromVar(AArgs[2]));
end;

function TCustomImageList_UnRegisterChanges_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnRegisterChanges(Value: TChangeLink);

  TCustomImageList(AObj).UnRegisterChanges(TChangeLink_sw.FromVar(AArgs[0]));
end;

function TCustomImageList_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TCustomImageList(AObj).Count;
end;

function TCustomImageList_AllocBy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllocBy: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomImageList(AObj).AllocBy
  else
    TCustomImageList(AObj).AllocBy := Integer(AArgs[0]);
end;

function TCustomImageList_BlendColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BlendColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TCustomImageList(AObj).BlendColor)
  else
    TCustomImageList(AObj).BlendColor := TColor_sw.FromVar(AArgs[0]);
end;

function TCustomImageList_BkColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BkColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TCustomImageList(AObj).BkColor)
  else
    TCustomImageList(AObj).BkColor := TColor_sw.FromVar(AArgs[0]);
end;

function TCustomImageList_DrawingStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DrawingStyle: TDrawingStyle read <getter> write ...

  if IsGet then
    Result := TDrawingStyle_sw.ToVar(TCustomImageList(AObj).DrawingStyle)
  else
    TCustomImageList(AObj).DrawingStyle := TDrawingStyle_sw.FromVar(AArgs[0]);
end;

function TCustomImageList_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomImageList(AObj).Height
  else
    TCustomImageList(AObj).Height := Integer(AArgs[0]);
end;

function TCustomImageList_ImageType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageType: TImageType read <getter> write <setter>;

  if IsGet then
    Result := TImageType_sw.ToVar(TCustomImageList(AObj).ImageType)
  else
    TCustomImageList(AObj).ImageType := TImageType_sw.FromVar(AArgs[0]);
end;

function TCustomImageList_Masked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Masked: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomImageList(AObj).Masked
  else
    TCustomImageList(AObj).Masked := Boolean(AArgs[0]);
end;

function TCustomImageList_ShareImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShareImages: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomImageList(AObj).ShareImages
  else
    TCustomImageList(AObj).ShareImages := Boolean(AArgs[0]);
end;

function TCustomImageList_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomImageList(AObj).Width
  else
    TCustomImageList(AObj).Width := Integer(AArgs[0]);
end;

function TCustomImageList_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomImageList(AObj).OnChange)
  else
    TCustomImageList(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomImageList_sw.GetTypeName: WideString;
begin
  Result := 'TCustomImageList';
end;

class function TCustomImageList_sw.GetWrappedClass: TClass;
begin
  Result := TCustomImageList;
end;

class procedure TCustomImageList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TCustomImageList_Add_si, Integer_sw, 2, False);
  AData.AddFunction('AddIcon', TCustomImageList_AddIcon_si, Integer_sw, 1, False);
  AData.AddFunction('AddImage', TCustomImageList_AddImage_si, Integer_sw, 2, False);
  AData.AddProcedure('AddImages', TCustomImageList_AddImages_si, 1, False);
  AData.AddFunction('AddMasked', TCustomImageList_AddMasked_si, Integer_sw, 2, False);
  AData.AddProcedure('Clear', TCustomImageList_Clear_si, 0, False);
  AData.AddProcedure('Delete', TCustomImageList_Delete_si, 1, False);
  AData.AddProcedure('Draw', TCustomImageList_Draw_si, 4, True);
  AData.AddProcedure('DrawOverlay', TCustomImageList_DrawOverlay_si, 5, True);
  AData.AddFunction('FileLoad', TCustomImageList_FileLoad_si, Boolean_sw, 3, False);
  AData.AddFunction('GetBitmap', TCustomImageList_GetBitmap_si, Boolean_sw, 2, False);
  AData.AddFunction('GetHotSpot', TCustomImageList_GetHotSpot_si, TPoint_sw, 0, False);
  AData.AddProcedure('GetIcon', TCustomImageList_GetIcon_si, 2, False);
  AData.AddFunction('GetImageBitmap', TCustomImageList_GetImageBitmap_si, HBITMAP_sw, 0, False);
  AData.AddFunction('GetMaskBitmap', TCustomImageList_GetMaskBitmap_si, HBITMAP_sw, 0, False);
  AData.AddFunction('GetResource', TCustomImageList_GetResource_si, Boolean_sw, 5, False);
  AData.AddFunction('GetInstRes', TCustomImageList_GetInstRes_si, Boolean_sw, 6, False);
  AData.AddFunction('HandleAllocated', TCustomImageList_HandleAllocated_si, Boolean_sw, 0, False);
  AData.AddProcedure('Insert', TCustomImageList_Insert_si, 3, False);
  AData.AddProcedure('InsertIcon', TCustomImageList_InsertIcon_si, 2, False);
  AData.AddProcedure('InsertMasked', TCustomImageList_InsertMasked_si, 3, False);
  AData.AddProcedure('Move', TCustomImageList_Move_si, 2, False);
  AData.AddFunction('Overlay', TCustomImageList_Overlay_si, Boolean_sw, 2, False);
  AData.AddProcedure('RegisterChanges', TCustomImageList_RegisterChanges_si, 1, False);
  AData.AddFunction('ResourceLoad', TCustomImageList_ResourceLoad_si, Boolean_sw, 3, False);
  AData.AddFunction('ResInstLoad', TCustomImageList_ResInstLoad_si, Boolean_sw, 4, False);
  AData.AddProcedure('Replace', TCustomImageList_Replace_si, 3, False);
  AData.AddProcedure('ReplaceIcon', TCustomImageList_ReplaceIcon_si, 2, False);
  AData.AddProcedure('ReplaceMasked', TCustomImageList_ReplaceMasked_si, 3, False);
  AData.AddProcedure('UnRegisterChanges', TCustomImageList_UnRegisterChanges_si, 1, False);
  AData.AddProperty('Count', TCustomImageList_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('AllocBy', TCustomImageList_AllocBy_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('BlendColor', TCustomImageList_BlendColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('BkColor', TCustomImageList_BkColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('DrawingStyle', TCustomImageList_DrawingStyle_si, TDrawingStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TCustomImageList_Height_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ImageType', TCustomImageList_ImageType_si, TImageType_sw, True, True, 0, False, False);
  AData.AddProperty('Masked', TCustomImageList_Masked_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ShareImages', TCustomImageList_ShareImages_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TCustomImageList_Width_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TCustomImageList_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('CreateSize', TCustomImageList_CreateSize_si, 2, False);
end;

class function TCustomImageList_sw.ToVar(
  const AValue: TCustomImageList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomImageList_sw.FromVar(
  const AValue: OleVariant): TCustomImageList;
begin
  Result := TCustomImageList(ConvFromVar(AValue, TCustomImageList));
end;

class function TCustomImageList_sw.ClassToVar(
  AClass: TCustomImageList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomImageList_sw.ClassFromVar(
  const AClass: OleVariant): TCustomImageList_sc;
begin
  Result := TCustomImageList_sc(ConvClsFromVar(AClass, TCustomImageList));
end;

{ ImgList_sw }

function ImgList_TChangeLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TChangeLink = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TChangeLink_sw);
end;

function ImgList_TDrawingStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDrawingStyle = (dsFocus, dsSelected, dsNormal, dsTr...

  Result := TLMDUnitWrapper.TypeToVar(TDrawingStyle_sw);
end;

function ImgList_TImageType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TImageType = (itImage, itMask);

  Result := TLMDUnitWrapper.TypeToVar(TImageType_sw);
end;

function ImgList_TResType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TResType = (rtBitmap, rtCursor, rtIcon);

  Result := TLMDUnitWrapper.TypeToVar(TResType_sw);
end;

function ImgList_TOverlay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOverlay = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TOverlay_sw);
end;

function ImgList_TLoadResource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLoadResource = (lrDefaultColor, lrDefaultSize, lrFr...

  Result := TLMDUnitWrapper.TypeToVar(TLoadResource_sw);
end;

function ImgList_TLoadResources_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLoadResources = set of TLoadResource;

  Result := TLMDUnitWrapper.TypeToVar(TLoadResources_sw);
end;

function ImgList_TImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TImageIndex = Integer;

  Result := TLMDUnitWrapper.TypeToVar(TImageIndex_sw);
end;

function ImgList_TCustomImageList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomImageList = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomImageList_sw);
end;

class function ImgList_sw.GetUnitName: WideString;
begin
  Result := 'ImgList';
end;

class procedure ImgList_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TChangeLink_sw, ImgList_TChangeLink_si);
  AData.AddType(TDrawingStyle_sw, ImgList_TDrawingStyle_si);
  AData.AddType(TImageType_sw, ImgList_TImageType_si);
  AData.AddType(TResType_sw, ImgList_TResType_si);
  AData.AddType(TOverlay_sw, ImgList_TOverlay_si);
  AData.AddType(TLoadResource_sw, ImgList_TLoadResource_si);
  AData.AddType(TLoadResources_sw, ImgList_TLoadResources_si);
  AData.AddType(TImageIndex_sw, ImgList_TImageIndex_si);
  AData.AddType(TCustomImageList_sw, ImgList_TCustomImageList_si);
end;

class function ImgList_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ImgList_sw);
end;

initialization
  RegisterUnitWrapper(ImgList_sw);
  RegisterClassWrapper(TChangeLink_sw);
  RegisterClassWrapper(TCustomImageList_sw);

end.
