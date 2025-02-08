unit System.ImageList_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'System.ImageList' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.SysUtils, System.Variants, System.TypInfo, LMDTypes,
  LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers, System.Classes,
  System.UITypes, System.ImageList, System.Classes_LMDSW, System.UITypes_LMDSW;


{ Type wrappers }

type
  TBaseImageList_sw = class;
  TImageLink_sw = class;

  TBaseImageList_sc = class of TBaseImageList;
  TBaseImageList_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBaseImageList): OleVariant;
    class function FromVar(const AValue: OleVariant): TBaseImageList;
    class function ClassToVar(AClass: TBaseImageList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBaseImageList_sc;
  end;

  TImageLink_sc = class of TImageLink;
  TImageLink_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TImageLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TImageLink;
    class function ClassToVar(AClass: TImageLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TImageLink_sc;
  end;


{ Unit wrapper }

type
  ImageList_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TBaseImageList_sacc = class(TBaseImageList);

{ TBaseImageList_sw }

function TBaseImageList_LinkCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property LinkCount: Integer read <getter>;

  Result := TBaseImageList_sacc(TBaseImageList(AObj)).LinkCount;
end;

function TBaseImageList_Links_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Links[const Index: Integer]: TImageLin...

  Result := TImageLink_sw.ToVar(TBaseImageList_sacc(TBaseImageList(AObj)).
    Links[Integer(AArgs[0])]);
end;

function TBaseImageList_Change_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Change;

  TBaseImageList(AObj).Change();
end;

function TBaseImageList_BeginUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginUpdate;

  TBaseImageList(AObj).BeginUpdate();
end;

function TBaseImageList_EndUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndUpdate;

  TBaseImageList(AObj).EndUpdate();
end;

function TBaseImageList_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TBaseImageList(AObj).Count;
end;

class function TBaseImageList_sw.GetTypeName: WideString;
begin
  Result := 'TBaseImageList';
end;

class function TBaseImageList_sw.GetWrappedClass: TClass;
begin
  Result := TBaseImageList;
end;

class procedure TBaseImageList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('LinkCount', TBaseImageList_LinkCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('Links', TBaseImageList_Links_si, TImageLink_sw, True, False, 1, True, False);
  AData.AddProcedure('Change', TBaseImageList_Change_si, 0, False);
  AData.AddProcedure('BeginUpdate', TBaseImageList_BeginUpdate_si, 0, False);
  AData.AddProcedure('EndUpdate', TBaseImageList_EndUpdate_si, 0, False);
  AData.AddProperty('Count', TBaseImageList_Count_si, Integer_sw, True, False, 0, False, False);
end;

class function TBaseImageList_sw.ToVar(
  const AValue: TBaseImageList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBaseImageList_sw.FromVar(
  const AValue: OleVariant): TBaseImageList;
begin
  Result := TBaseImageList(ConvFromVar(AValue, TBaseImageList));
end;

class function TBaseImageList_sw.ClassToVar(
  AClass: TBaseImageList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBaseImageList_sw.ClassFromVar(
  const AClass: OleVariant): TBaseImageList_sc;
begin
  Result := TBaseImageList_sc(ConvClsFromVar(AClass, TBaseImageList));
end;

{ TImageLink_sw }

function TImageLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TImageLink_sw.ToVar(TImageLink_sc(AObj).Create());
end;

function TImageLink_Change_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Change;

  TImageLink(AObj).Change();
end;

function TImageLink_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TBaseImageList read <getter> write <sett...

  if IsGet then
    Result := TBaseImageList_sw.ToVar(TImageLink(AObj).Images)
  else
    TImageLink(AObj).Images := TBaseImageList_sw.FromVar(AArgs[0]);
end;

function TImageLink_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TImageLink(AObj).ImageIndex)
  else
    TImageLink(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TImageLink_IgnoreIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IgnoreIndex: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TImageLink(AObj).IgnoreIndex
  else
    TImageLink(AObj).IgnoreIndex := Boolean(AArgs[0]);
end;

function TImageLink_IgnoreImages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IgnoreImages: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TImageLink(AObj).IgnoreImages
  else
    TImageLink(AObj).IgnoreImages := Boolean(AArgs[0]);
end;

function TImageLink_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TImageLink(AObj).OnChange)
  else
    TImageLink(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TImageLink_sw.GetTypeName: WideString;
begin
  Result := 'TImageLink';
end;

class function TImageLink_sw.GetWrappedClass: TClass;
begin
  Result := TImageLink;
end;

class procedure TImageLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Change', TImageLink_Change_si, 0, False);
  AData.AddProperty('Images', TImageLink_Images_si, TBaseImageList_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TImageLink_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('IgnoreIndex', TImageLink_IgnoreIndex_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('IgnoreImages', TImageLink_IgnoreImages_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TImageLink_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TImageLink_Create_si, 0, False);
end;

class function TImageLink_sw.ToVar(const AValue: TImageLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TImageLink_sw.FromVar(const AValue: OleVariant): TImageLink;
begin
  Result := TImageLink(ConvFromVar(AValue, TImageLink));
end;

class function TImageLink_sw.ClassToVar(AClass: TImageLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TImageLink_sw.ClassFromVar(
  const AClass: OleVariant): TImageLink_sc;
begin
  Result := TImageLink_sc(ConvClsFromVar(AClass, TImageLink));
end;

{ ImageList_sw }

function ImageList_TBaseImageList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBaseImageList = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TBaseImageList_sw);
end;

function ImageList_TImageLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TImageLink = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TImageLink_sw);
end;

class function ImageList_sw.GetUnitName: WideString;
begin
  Result := 'ImageList';
end;

class procedure ImageList_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TBaseImageList_sw, ImageList_TBaseImageList_si);
  AData.AddType(TImageLink_sw, ImageList_TImageLink_si);
end;

class function ImageList_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ImageList_sw);
end;

initialization
  RegisterUnitWrapper(ImageList_sw);
  RegisterClassWrapper(TBaseImageList_sw);
  RegisterClassWrapper(TImageLink_sw);

end.
