unit Vcl.ExtDlgs_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Vcl.ExtDlgs' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.Variants, System.TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Winapi.Messages, Winapi.Windows,
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Graphics,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Dialogs, Vcl.ExtDlgs, Winapi.Messages_LMDSW,
  Winapi.Windows_LMDSW, System.SysUtils_LMDSW, System.Classes_LMDSW,
  Vcl.Controls_LMDSW, Vcl.StdCtrls_LMDSW, Vcl.Graphics_LMDSW,
  Vcl.ExtCtrls_LMDSW, Vcl.Buttons_LMDSW, Vcl.Dialogs_LMDSW;


{ Type wrappers }

type
  TOpenPictureDialog_sw = class;
  TSavePictureDialog_sw = class;
  TOpenTextFileDialog_sw = class;
  TSaveTextFileDialog_sw = class;

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

  TOpenTextFileDialog_sc = class of TOpenTextFileDialog;
  TOpenTextFileDialog_sw = class(TOpenDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TOpenTextFileDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TOpenTextFileDialog;
    class function ClassToVar(AClass: TOpenTextFileDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TOpenTextFileDialog_sc;
  end;

  TSaveTextFileDialog_sc = class of TSaveTextFileDialog;
  TSaveTextFileDialog_sw = class(TOpenTextFileDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSaveTextFileDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TSaveTextFileDialog;
    class function ClassToVar(AClass: TSaveTextFileDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSaveTextFileDialog_sc;
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

{ TOpenTextFileDialog_sw }

function TOpenTextFileDialog_Encodings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Encodings: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TOpenTextFileDialog(AObj).Encodings)
  else
    TOpenTextFileDialog(AObj).Encodings := TStrings_sw.FromVar(AArgs[0]);
end;

function TOpenTextFileDialog_EncodingIndex_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EncodingIndex: Integer read <getter> write <sett...

  if IsGet then
    Result := TOpenTextFileDialog(AObj).EncodingIndex
  else
    TOpenTextFileDialog(AObj).EncodingIndex := Integer(AArgs[0]);
end;

class function TOpenTextFileDialog_sw.GetTypeName: WideString;
begin
  Result := 'TOpenTextFileDialog';
end;

class function TOpenTextFileDialog_sw.GetWrappedClass: TClass;
begin
  Result := TOpenTextFileDialog;
end;

class procedure TOpenTextFileDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Encodings', TOpenTextFileDialog_Encodings_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('EncodingIndex', TOpenTextFileDialog_EncodingIndex_si, Integer_sw, True, True, 0, False, False);
end;

class function TOpenTextFileDialog_sw.ToVar(
  const AValue: TOpenTextFileDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TOpenTextFileDialog_sw.FromVar(
  const AValue: OleVariant): TOpenTextFileDialog;
begin
  Result := TOpenTextFileDialog(ConvFromVar(AValue, TOpenTextFileDialog));
end;

class function TOpenTextFileDialog_sw.ClassToVar(
  AClass: TOpenTextFileDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TOpenTextFileDialog_sw.ClassFromVar(
  const AClass: OleVariant): TOpenTextFileDialog_sc;
begin
  Result := TOpenTextFileDialog_sc(ConvClsFromVar(AClass, TOpenTextFileDialog));
end;

{ TSaveTextFileDialog_sw }

class function TSaveTextFileDialog_sw.GetTypeName: WideString;
begin
  Result := 'TSaveTextFileDialog';
end;

class function TSaveTextFileDialog_sw.GetWrappedClass: TClass;
begin
  Result := TSaveTextFileDialog;
end;

class procedure TSaveTextFileDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSaveTextFileDialog_sw.ToVar(
  const AValue: TSaveTextFileDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSaveTextFileDialog_sw.FromVar(
  const AValue: OleVariant): TSaveTextFileDialog;
begin
  Result := TSaveTextFileDialog(ConvFromVar(AValue, TSaveTextFileDialog));
end;

class function TSaveTextFileDialog_sw.ClassToVar(
  AClass: TSaveTextFileDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSaveTextFileDialog_sw.ClassFromVar(
  const AClass: OleVariant): TSaveTextFileDialog_sc;
begin
  Result := TSaveTextFileDialog_sc(ConvClsFromVar(AClass, TSaveTextFileDialog));
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

function ExtDlgs_TOpenTextFileDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenTextFileDialog = class(TOpenDialog);

  Result := TLMDUnitWrapper.TypeToVar(TOpenTextFileDialog_sw);
end;

function ExtDlgs_TSaveTextFileDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSaveTextFileDialog = class(TOpenTextFileDialog);

  Result := TLMDUnitWrapper.TypeToVar(TSaveTextFileDialog_sw);
end;

function ExtDlgs_StandardEncodingFromName_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StandardEncodingFromName(const Name: string): TE...

  Result := TEncoding_sw.ToVar(Vcl.ExtDlgs.StandardEncodingFromName(string(
    AArgs[0])));
end;

class function ExtDlgs_sw.GetUnitName: WideString;
begin
  Result := 'ExtDlgs';
end;

class procedure ExtDlgs_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TOpenPictureDialog_sw, ExtDlgs_TOpenPictureDialog_si);
  AData.AddType(TSavePictureDialog_sw, ExtDlgs_TSavePictureDialog_si);
  AData.AddType(TOpenTextFileDialog_sw, ExtDlgs_TOpenTextFileDialog_si);
  AData.AddType(TSaveTextFileDialog_sw, ExtDlgs_TSaveTextFileDialog_si);
  AData.AddFunction('StandardEncodingFromName', ExtDlgs_StandardEncodingFromName_si, TEncoding_sw, 1, False);
end;

class function ExtDlgs_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ExtDlgs_sw);
end;

initialization
  RegisterUnitWrapper(ExtDlgs_sw);
  RegisterClassWrapper(TOpenPictureDialog_sw);
  RegisterClassWrapper(TSavePictureDialog_sw);
  RegisterClassWrapper(TOpenTextFileDialog_sw);
  RegisterClassWrapper(TSaveTextFileDialog_sw);

end.
