unit Printers_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Printers' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, SysUtils, Classes, Graphics, Forms, Printers,
  Windows_LMDSW, SysUtils_LMDSW, Classes_LMDSW, Graphics_LMDSW, Forms_LMDSW;


{ Type wrappers }

type
  EPrinter_sw = class;
  TPrinter_sw = class;

  EPrinter_sc = class of EPrinter;
  EPrinter_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPrinter): OleVariant;
    class function FromVar(const AValue: OleVariant): EPrinter;
    class function ClassToVar(AClass: EPrinter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPrinter_sc;
  end;

  TPrinterState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrinterState): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterState;
  end;

  TPrinterOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrinterOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterOrientation;
  end;

  TPrinterCapability_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrinterCapability): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterCapability;
  end;

  TPrinterCapabilities_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TPrinterCapabilities): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterCapabilities;
  end;

  TPrinter_sc = class of TPrinter;
  TPrinter_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPrinter): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinter;
    class function ClassToVar(AClass: TPrinter_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPrinter_sc;
  end;


{ Unit wrapper }

type
  Printers_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ EPrinter_sw }

class function EPrinter_sw.GetTypeName: WideString;
begin
  Result := 'EPrinter';
end;

class function EPrinter_sw.GetWrappedClass: TClass;
begin
  Result := EPrinter;
end;

class procedure EPrinter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPrinter_sw.ToVar(const AValue: EPrinter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPrinter_sw.FromVar(const AValue: OleVariant): EPrinter;
begin
  Result := EPrinter(ConvFromVar(AValue, EPrinter));
end;

class function EPrinter_sw.ClassToVar(AClass: EPrinter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPrinter_sw.ClassFromVar(const AClass: OleVariant): EPrinter_sc;
begin
  Result := EPrinter_sc(ConvClsFromVar(AClass, EPrinter));
end;

{ TPrinterState_sw }

class function TPrinterState_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterState';
end;

class procedure TPrinterState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'psNoHandle'; Value: Integer({$IFDEF LMDSCT_12}TPrinterState.{$ENDIF}psNoHandle)),
    (Name: 'psHandleIC'; Value: Integer({$IFDEF LMDSCT_12}TPrinterState.{$ENDIF}psHandleIC)),
    (Name: 'psHandleDC'; Value: Integer({$IFDEF LMDSCT_12}TPrinterState.{$ENDIF}psHandleDC))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPrinterState_sw.ToVar(const AValue: TPrinterState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrinterState_sw.FromVar(
  const AValue: OleVariant): TPrinterState;
begin
  Result := TPrinterState(Integer(AValue));
end;

{ TPrinterOrientation_sw }

class function TPrinterOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterOrientation';
end;

class procedure TPrinterOrientation_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'poPortrait'; Value: Integer({$IFDEF LMDSCT_12}TPrinterOrientation.{$ENDIF}poPortrait)),
    (Name: 'poLandscape'; Value: Integer({$IFDEF LMDSCT_12}TPrinterOrientation.{$ENDIF}poLandscape))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TPrinterOrientation_sw.ToVar(
  const AValue: TPrinterOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrinterOrientation_sw.FromVar(
  const AValue: OleVariant): TPrinterOrientation;
begin
  Result := TPrinterOrientation(Integer(AValue));
end;

{ TPrinterCapability_sw }

class function TPrinterCapability_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterCapability';
end;

class procedure TPrinterCapability_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'pcCopies'; Value: Integer({$IFDEF LMDSCT_12}TPrinterCapability.{$ENDIF}pcCopies)),
    (Name: 'pcOrientation'; Value: Integer({$IFDEF LMDSCT_12}TPrinterCapability.{$ENDIF}pcOrientation)),
    (Name: 'pcCollation'; Value: Integer({$IFDEF LMDSCT_12}TPrinterCapability.{$ENDIF}pcCollation))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPrinterCapability_sw.ToVar(
  const AValue: TPrinterCapability): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrinterCapability_sw.FromVar(
  const AValue: OleVariant): TPrinterCapability;
begin
  Result := TPrinterCapability(Integer(AValue));
end;

{ TPrinterCapabilities_sw }

class function TPrinterCapabilities_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterCapabilities';
end;

class function TPrinterCapabilities_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TPrinterCapabilities);
end;

class function TPrinterCapabilities_sw.ToVar(
  const AValue: TPrinterCapabilities): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TPrinterCapabilities_sw.FromVar(
  const AValue: OleVariant): TPrinterCapabilities;
begin
  ConvFromVar(AValue, @Result);
end;

{ TPrinter_sw }

function TPrinter_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TPrinter_sw.ToVar(TPrinter_sc(AObj).Create());
end;

function TPrinter_Abort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Abort;

  TPrinter(AObj).Abort();
end;

function TPrinter_BeginDoc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginDoc;

  TPrinter(AObj).BeginDoc();
end;

function TPrinter_EndDoc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndDoc;

  TPrinter(AObj).EndDoc();
end;

function TPrinter_NewPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NewPage;

  TPrinter(AObj).NewPage();
end;

function TPrinter_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Refresh;

  TPrinter(AObj).Refresh();
end;

function TPrinter_Aborted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Aborted: Boolean read <getter>;

  Result := TPrinter(AObj).Aborted;
end;

function TPrinter_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TPrinter(AObj).Canvas);
end;

function TPrinter_Capabilities_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Capabilities: TPrinterCapabilities read <getter>;

  Result := TPrinterCapabilities_sw.ToVar(TPrinter(AObj).Capabilities);
end;

function TPrinter_Copies_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Copies: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrinter(AObj).Copies
  else
    TPrinter(AObj).Copies := Integer(AArgs[0]);
end;

function TPrinter_Fonts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fonts: TStrings read <getter>;

  Result := TStrings_sw.ToVar(TPrinter(AObj).Fonts);
end;

function TPrinter_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HDC read <getter>;

  Result := HDC_sw.ToVar(TPrinter(AObj).Handle);
end;

function TPrinter_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Orientation: TPrinterOrientation read <getter> w...

  if IsGet then
    Result := TPrinterOrientation_sw.ToVar(TPrinter(AObj).Orientation)
  else
    TPrinter(AObj).Orientation := TPrinterOrientation_sw.FromVar(AArgs[0]);
end;

function TPrinter_PageHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageHeight: Integer read <getter>;

  Result := TPrinter(AObj).PageHeight;
end;

function TPrinter_PageWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageWidth: Integer read <getter>;

  Result := TPrinter(AObj).PageWidth;
end;

function TPrinter_PageNumber_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageNumber: Integer read <getter>;

  Result := TPrinter(AObj).PageNumber;
end;

function TPrinter_PrinterIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PrinterIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrinter(AObj).PrinterIndex
  else
    TPrinter(AObj).PrinterIndex := Integer(AArgs[0]);
end;

function TPrinter_Printing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Printing: Boolean read <getter>;

  Result := TPrinter(AObj).Printing;
end;

function TPrinter_Printers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Printers: TStrings read <getter>;

  Result := TStrings_sw.ToVar(TPrinter(AObj).Printers);
end;

function TPrinter_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: string read <getter> write <setter>;

  if IsGet then
    Result := TPrinter(AObj).Title
  else
    TPrinter(AObj).Title := string(AArgs[0]);
end;

class function TPrinter_sw.GetTypeName: WideString;
begin
  Result := 'TPrinter';
end;

class function TPrinter_sw.GetWrappedClass: TClass;
begin
  Result := TPrinter;
end;

class procedure TPrinter_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Abort', TPrinter_Abort_si, 0, False);
  AData.AddProcedure('BeginDoc', TPrinter_BeginDoc_si, 0, False);
  AData.AddProcedure('EndDoc', TPrinter_EndDoc_si, 0, False);
  AData.AddProcedure('NewPage', TPrinter_NewPage_si, 0, False);
  AData.AddProcedure('Refresh', TPrinter_Refresh_si, 0, False);
  AData.AddProperty('Aborted', TPrinter_Aborted_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Canvas', TPrinter_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('Capabilities', TPrinter_Capabilities_si, TPrinterCapabilities_sw, True, False, 0, False, False);
  AData.AddProperty('Copies', TPrinter_Copies_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Fonts', TPrinter_Fonts_si, TStrings_sw, True, False, 0, False, False);
  AData.AddProperty('Handle', TPrinter_Handle_si, HDC_sw, True, False, 0, False, False);
  AData.AddProperty('Orientation', TPrinter_Orientation_si, TPrinterOrientation_sw, True, True, 0, False, False);
  AData.AddProperty('PageHeight', TPrinter_PageHeight_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('PageWidth', TPrinter_PageWidth_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('PageNumber', TPrinter_PageNumber_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('PrinterIndex', TPrinter_PrinterIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Printing', TPrinter_Printing_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Printers', TPrinter_Printers_si, TStrings_sw, True, False, 0, False, False);
  AData.AddProperty('Title', TPrinter_Title_si, string_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TPrinter_Create_si, 0, False);
end;

class function TPrinter_sw.ToVar(const AValue: TPrinter): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPrinter_sw.FromVar(const AValue: OleVariant): TPrinter;
begin
  Result := TPrinter(ConvFromVar(AValue, TPrinter));
end;

class function TPrinter_sw.ClassToVar(AClass: TPrinter_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPrinter_sw.ClassFromVar(const AClass: OleVariant): TPrinter_sc;
begin
  Result := TPrinter_sc(ConvClsFromVar(AClass, TPrinter));
end;

{ Printers_sw }

function Printers_EPrinter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPrinter = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPrinter_sw);
end;

function Printers_TPrinterState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterState = (psNoHandle, psHandleIC, psHandleDC);

  Result := TLMDUnitWrapper.TypeToVar(TPrinterState_sw);
end;

function Printers_TPrinterOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterOrientation = (poPortrait, poLandscape);

  Result := TLMDUnitWrapper.TypeToVar(TPrinterOrientation_sw);
end;

function Printers_TPrinterCapability_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterCapability = (pcCopies, pcOrientation, pcCol...

  Result := TLMDUnitWrapper.TypeToVar(TPrinterCapability_sw);
end;

function Printers_TPrinterCapabilities_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterCapabilities = set of TPrinterCapability;

  Result := TLMDUnitWrapper.TypeToVar(TPrinterCapabilities_sw);
end;

function Printers_TPrinter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinter = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TPrinter_sw);
end;

function Printers_Printer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Printer: TPrinter;

  Result := TPrinter_sw.ToVar(Printers.Printer());
end;

function Printers_SetPrinter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SetPrinter(NewPrinter: TPrinter): TPrinter;

  Result := TPrinter_sw.ToVar(Printers.SetPrinter(TPrinter_sw.FromVar(
    AArgs[0])));
end;

class function Printers_sw.GetUnitName: WideString;
begin
  Result := 'Printers';
end;

class procedure Printers_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EPrinter_sw, Printers_EPrinter_si);
  AData.AddType(TPrinterState_sw, Printers_TPrinterState_si);
  AData.AddType(TPrinterOrientation_sw, Printers_TPrinterOrientation_si);
  AData.AddType(TPrinterCapability_sw, Printers_TPrinterCapability_si);
  AData.AddType(TPrinterCapabilities_sw, Printers_TPrinterCapabilities_si);
  AData.AddType(TPrinter_sw, Printers_TPrinter_si);
  AData.AddFunction('Printer', Printers_Printer_si, TPrinter_sw, 0, False);
  AData.AddFunction('SetPrinter', Printers_SetPrinter_si, TPrinter_sw, 1, False);
end;

class function Printers_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Printers_sw);
end;

initialization
  RegisterUnitWrapper(Printers_sw);
  RegisterClassWrapper(EPrinter_sw);
  RegisterClassWrapper(TPrinter_sw);

end.
