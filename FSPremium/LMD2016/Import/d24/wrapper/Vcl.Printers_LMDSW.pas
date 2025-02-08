unit Vcl.Printers_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Vcl.Printers' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, Winapi.Windows, System.UITypes,
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Printers,
  Winapi.Windows_LMDSW, System.UITypes_LMDSW, System.SysUtils_LMDSW,
  System.Classes_LMDSW, Vcl.Graphics_LMDSW, Vcl.Forms_LMDSW;


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

  TPrinterState_sw = System.UITypes_LMDSW.TPrinterState_sw;

  TPrinterOrientation_sw = System.UITypes_LMDSW.TPrinterOrientation_sw;

  TPrinterCapability_sw = System.UITypes_LMDSW.TPrinterCapability_sw;

  TPrinterCapabilities_sw = System.UITypes_LMDSW.TPrinterCapabilities_sw;

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

function Printers_poPortrait_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const poPortrait = <value>;

  Result := TPrinterOrientation_sw.ToVar(poPortrait);
end;

function Printers_poLandscape_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const poLandscape = <value>;

  Result := TPrinterOrientation_sw.ToVar(poLandscape);
end;

function Printers_pcCopies_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pcCopies = <value>;

  Result := TPrinterCapability_sw.ToVar(pcCopies);
end;

function Printers_pcOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pcOrientation = <value>;

  Result := TPrinterCapability_sw.ToVar(pcOrientation);
end;

function Printers_pcCollation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const pcCollation = <value>;

  Result := TPrinterCapability_sw.ToVar(pcCollation);
end;

function Printers_EPrinter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPrinter = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPrinter_sw);
end;

function Printers_TPrinterState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterState = System.UITypes.TPrinterState;

  Result := TLMDUnitWrapper.TypeToVar(TPrinterState_sw);
end;

function Printers_TPrinterOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterOrientation = System.UITypes.TPrinterOrienta...

  Result := TLMDUnitWrapper.TypeToVar(TPrinterOrientation_sw);
end;

function Printers_TPrinterCapability_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterCapability = System.UITypes.TPrinterCapability;

  Result := TLMDUnitWrapper.TypeToVar(TPrinterCapability_sw);
end;

function Printers_TPrinterCapabilities_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterCapabilities = System.UITypes.TPrinterCapabi...

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

  Result := TPrinter_sw.ToVar(Vcl.Printers.Printer());
end;

function Printers_SetPrinter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SetPrinter(NewPrinter: TPrinter): TPrinter;

  Result := TPrinter_sw.ToVar(Vcl.Printers.SetPrinter(TPrinter_sw.FromVar(
    AArgs[0])));
end;

class function Printers_sw.GetUnitName: WideString;
begin
  Result := 'Printers';
end;

class procedure Printers_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('poPortrait', Printers_poPortrait_si, TPrinterOrientation_sw);
  AData.AddConstant('poLandscape', Printers_poLandscape_si, TPrinterOrientation_sw);
  AData.AddConstant('pcCopies', Printers_pcCopies_si, TPrinterCapability_sw);
  AData.AddConstant('pcOrientation', Printers_pcOrientation_si, TPrinterCapability_sw);
  AData.AddConstant('pcCollation', Printers_pcCollation_si, TPrinterCapability_sw);
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
