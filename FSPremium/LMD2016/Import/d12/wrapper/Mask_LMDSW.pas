unit Mask_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Mask' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Types, Windows, Messages, SysUtils, Classes, MaskUtils,
  Controls, StdCtrls, Forms, Graphics, Menus, Mask, Windows_LMDSW,
  Messages_LMDSW, SysUtils_LMDSW, Classes_LMDSW, MaskUtils_LMDSW,
  Controls_LMDSW, StdCtrls_LMDSW, Forms_LMDSW, Graphics_LMDSW, Menus_LMDSW;


{ Type wrappers }

type
  EDBEditError_sw = class;
  TCustomMaskEdit_sw = class;
  TMaskEdit_sw = class;

  EDBEditError_sc = class of EDBEditError;
  EDBEditError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EDBEditError): OleVariant;
    class function FromVar(const AValue: OleVariant): EDBEditError;
    class function ClassToVar(AClass: EDBEditError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EDBEditError_sc;
  end;

  TCustomMaskEdit_sc = class of TCustomMaskEdit;
  TCustomMaskEdit_sw = class(TCustomEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomMaskEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMaskEdit;
    class function ClassToVar(AClass: TCustomMaskEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomMaskEdit_sc;
  end;

  TMaskEdit_sc = class of TMaskEdit;
  TMaskEdit_sw = class(TCustomMaskEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMaskEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TMaskEdit;
    class function ClassToVar(AClass: TMaskEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMaskEdit_sc;
  end;


{ Unit wrapper }

type
  Mask_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomMaskEdit_sacc = class(TCustomMaskEdit);

{ EDBEditError_sw }

class function EDBEditError_sw.GetTypeName: WideString;
begin
  Result := 'EDBEditError';
end;

class function EDBEditError_sw.GetWrappedClass: TClass;
begin
  Result := EDBEditError;
end;

class procedure EDBEditError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EDBEditError_sw.ToVar(const AValue: EDBEditError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EDBEditError_sw.FromVar(const AValue: OleVariant): EDBEditError;
begin
  Result := EDBEditError(ConvFromVar(AValue, EDBEditError));
end;

class function EDBEditError_sw.ClassToVar(AClass: EDBEditError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EDBEditError_sw.ClassFromVar(
  const AClass: OleVariant): EDBEditError_sc;
begin
  Result := EDBEditError_sc(ConvClsFromVar(AClass, EDBEditError));
end;

{ TCustomMaskEdit_sw }

function TCustomMaskEdit_EditMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property EditMask: TEditMask read <getter> writ...

  if IsGet then
    Result := TEditMask_sw.ToVar(TCustomMaskEdit_sacc(TCustomMaskEdit(AObj)).
      EditMask)
  else
    TCustomMaskEdit_sacc(TCustomMaskEdit(AObj)).EditMask := TEditMask_sw.
      FromVar(AArgs[0]);
end;

function TCustomMaskEdit_MaxLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MaxLength: Integer read <getter> write...

  if IsGet then
    Result := TCustomMaskEdit_sacc(TCustomMaskEdit(AObj)).MaxLength
  else
    TCustomMaskEdit_sacc(TCustomMaskEdit(AObj)).MaxLength := Integer(AArgs[0]);
end;

function TCustomMaskEdit_ValidateEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ValidateEdit;

  TCustomMaskEdit(AObj).ValidateEdit();
end;

function TCustomMaskEdit_GetTextLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetTextLen: Integer;

  Result := TCustomMaskEdit(AObj).GetTextLen();
end;

function TCustomMaskEdit_IsMasked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsMasked: Boolean read <getter>;

  Result := TCustomMaskEdit(AObj).IsMasked;
end;

function TCustomMaskEdit_EditText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditText: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomMaskEdit(AObj).EditText
  else
    TCustomMaskEdit(AObj).EditText := string(AArgs[0]);
end;

function TCustomMaskEdit_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: TMaskedText read <getter> write <setter>;

  if IsGet then
    Result := TMaskedText_sw.ToVar(TCustomMaskEdit(AObj).Text)
  else
    TCustomMaskEdit(AObj).Text := TMaskedText_sw.FromVar(AArgs[0]);
end;

class function TCustomMaskEdit_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMaskEdit';
end;

class function TCustomMaskEdit_sw.GetWrappedClass: TClass;
begin
  Result := TCustomMaskEdit;
end;

class procedure TCustomMaskEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('EditMask', TCustomMaskEdit_EditMask_si, TEditMask_sw, True, True, 0, True, False);
  AData.AddProperty('MaxLength', TCustomMaskEdit_MaxLength_si, Integer_sw, True, True, 0, True, False);
  AData.AddProcedure('ValidateEdit', TCustomMaskEdit_ValidateEdit_si, 0, False);
  AData.AddFunction('GetTextLen', TCustomMaskEdit_GetTextLen_si, Integer_sw, 0, False);
  AData.AddProperty('IsMasked', TCustomMaskEdit_IsMasked_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('EditText', TCustomMaskEdit_EditText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Text', TCustomMaskEdit_Text_si, TMaskedText_sw, True, True, 0, False, False);
end;

class function TCustomMaskEdit_sw.ToVar(
  const AValue: TCustomMaskEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMaskEdit_sw.FromVar(
  const AValue: OleVariant): TCustomMaskEdit;
begin
  Result := TCustomMaskEdit(ConvFromVar(AValue, TCustomMaskEdit));
end;

class function TCustomMaskEdit_sw.ClassToVar(
  AClass: TCustomMaskEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomMaskEdit_sw.ClassFromVar(
  const AClass: OleVariant): TCustomMaskEdit_sc;
begin
  Result := TCustomMaskEdit_sc(ConvClsFromVar(AClass, TCustomMaskEdit));
end;

{ TMaskEdit_sw }

class function TMaskEdit_sw.GetTypeName: WideString;
begin
  Result := 'TMaskEdit';
end;

class function TMaskEdit_sw.GetWrappedClass: TClass;
begin
  Result := TMaskEdit;
end;

class procedure TMaskEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSelect', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('CharCase', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('EditMask', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PasswordChar', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Text', False);
  AData.AddPropertyRedecl('TextHint', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TMaskEdit_sw.ToVar(const AValue: TMaskEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMaskEdit_sw.FromVar(const AValue: OleVariant): TMaskEdit;
begin
  Result := TMaskEdit(ConvFromVar(AValue, TMaskEdit));
end;

class function TMaskEdit_sw.ClassToVar(AClass: TMaskEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMaskEdit_sw.ClassFromVar(
  const AClass: OleVariant): TMaskEdit_sc;
begin
  Result := TMaskEdit_sc(ConvClsFromVar(AClass, TMaskEdit));
end;

{ Mask_sw }

function Mask_EDBEditError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EDBEditError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EDBEditError_sw);
end;

function Mask_TCustomMaskEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMaskEdit = class(TCustomEdit);

  Result := TLMDUnitWrapper.TypeToVar(TCustomMaskEdit_sw);
end;

function Mask_TMaskEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMaskEdit = class(TCustomMaskEdit);

  Result := TLMDUnitWrapper.TypeToVar(TMaskEdit_sw);
end;

class function Mask_sw.GetUnitName: WideString;
begin
  Result := 'Mask';
end;

class procedure Mask_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EDBEditError_sw, Mask_EDBEditError_si);
  AData.AddType(TCustomMaskEdit_sw, Mask_TCustomMaskEdit_si);
  AData.AddType(TMaskEdit_sw, Mask_TMaskEdit_si);
end;

class function Mask_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Mask_sw);
end;

initialization
  RegisterUnitWrapper(Mask_sw);
  RegisterClassWrapper(EDBEditError_sw);
  RegisterClassWrapper(TCustomMaskEdit_sw);
  RegisterClassWrapper(TMaskEdit_sw);

end.
