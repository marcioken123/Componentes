unit ExtDlgs_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ExtDlgs' unit.
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
  LMDSctSysWrappers, Messages, Windows, SysUtils, Classes, Controls, StdCtrls,
  Graphics, ExtCtrls, Buttons, Dialogs, ExtDlgs, Messages_LMDSW, Windows_LMDSW,
  SysUtils_LMDSW, Classes_LMDSW, Controls_LMDSW, StdCtrls_LMDSW,
  Graphics_LMDSW, ExtCtrls_LMDSW, Buttons_LMDSW, Dialogs_LMDSW;


{ Type wrappers }

type
  TOpenPictureDialog_sw = class;
  TSavePictureDialog_sw = class;

  TOpenPictureDialog_sc = class of TOpenPictureDialog;
  TOpenPictureDialog_sw = class(TOpenDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TOpenPictureDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TOpenPictureDialog;
    class function ClassToVar(AClass: TOpenPictureDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TOpenPictureDialog_sc;
  end;

  TSavePictureDialog_sc = class of TSavePictureDialog;
  TSavePictureDialog_sw = class(TOpenPictureDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSavePictureDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TSavePictureDialog;
    class function ClassToVar(AClass: TSavePictureDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSavePictureDialog_sc;
  end;


{ Unit wrapper }

type
  ExtDlgs_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TOpenPictureDialog_sacc = class(TOpenPictureDialog);

{ TOpenPictureDialog_sw }

function TOpenPictureDialog_ImageCtrl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ImageCtrl: TImage read <getter>;

  Result := TImage_sw.ToVar(TOpenPictureDialog_sacc(TOpenPictureDialog(AObj)).
    ImageCtrl);
end;

function TOpenPictureDialog_PictureLabel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PictureLabel: TLabel read <getter>;

  Result := TLabel_sw.ToVar(TOpenPictureDialog_sacc(TOpenPictureDialog(AObj)).
    PictureLabel);
end;

class function TOpenPictureDialog_sw.GetTypeName: WideString;
begin
  Result := 'TOpenPictureDialog';
end;

class function TOpenPictureDialog_sw.GetWrappedClass: TClass;
begin
  Result := TOpenPictureDialog;
end;

class procedure TOpenPictureDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ImageCtrl', TOpenPictureDialog_ImageCtrl_si, TImage_sw, True, False, 0, True, False);
  AData.AddProperty('PictureLabel', TOpenPictureDialog_PictureLabel_si, TLabel_sw, True, False, 0, True, False);
  AData.AddPropertyRedecl('Filter', False);
end;

class function TOpenPictureDialog_sw.ToVar(
  const AValue: TOpenPictureDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TOpenPictureDialog_sw.FromVar(
  const AValue: OleVariant): TOpenPictureDialog;
begin
  Result := TOpenPictureDialog(ConvFromVar(AValue, TOpenPictureDialog));
end;

class function TOpenPictureDialog_sw.ClassToVar(
  AClass: TOpenPictureDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TOpenPictureDialog_sw.ClassFromVar(
  const AClass: OleVariant): TOpenPictureDialog_sc;
begin
  Result := TOpenPictureDialog_sc(ConvClsFromVar(AClass, TOpenPictureDialog));
end;

{ TSavePictureDialog_sw }

class function TSavePictureDialog_sw.GetTypeName: WideString;
begin
  Result := 'TSavePictureDialog';
end;

class function TSavePictureDialog_sw.GetWrappedClass: TClass;
begin
  Result := TSavePictureDialog;
end;

class procedure TSavePictureDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSavePictureDialog_sw.ToVar(
  const AValue: TSavePictureDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSavePictureDialog_sw.FromVar(
  const AValue: OleVariant): TSavePictureDialog;
begin
  Result := TSavePictureDialog(ConvFromVar(AValue, TSavePictureDialog));
end;

class function TSavePictureDialog_sw.ClassToVar(
  AClass: TSavePictureDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSavePictureDialog_sw.ClassFromVar(
  const AClass: OleVariant): TSavePictureDialog_sc;
begin
  Result := TSavePictureDialog_sc(ConvClsFromVar(AClass, TSavePictureDialog));
end;

{ ExtDlgs_sw }

function ExtDlgs_TOpenPictureDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenPictureDialog = class(TOpenDialog);

  Result := TLMDUnitWrapper.TypeToVar(TOpenPictureDialog_sw);
end;

function ExtDlgs_TSavePictureDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSavePictureDialog = class(TOpenPictureDialog);

  Result := TLMDUnitWrapper.TypeToVar(TSavePictureDialog_sw);
end;

class function ExtDlgs_sw.GetUnitName: WideString;
begin
  Result := 'ExtDlgs';
end;

class procedure ExtDlgs_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TOpenPictureDialog_sw, ExtDlgs_TOpenPictureDialog_si);
  AData.AddType(TSavePictureDialog_sw, ExtDlgs_TSavePictureDialog_si);
end;

class function ExtDlgs_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ExtDlgs_sw);
end;

initialization
  RegisterUnitWrapper(ExtDlgs_sw);
  RegisterClassWrapper(TOpenPictureDialog_sw);
  RegisterClassWrapper(TSavePictureDialog_sw);

end.
