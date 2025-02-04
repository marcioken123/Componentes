unit GrFingerXLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 07/10/2023 18:10:18 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Projetos\Componentes\Domani\Griaule\GrFinger 4.2\bin\GrFingerX.dll (1)
// LIBID: {A9995C7C-77BF-4E27-B581-A4B5BBD90E50}
// LCID: 0
// Helpfile: 
// HelpString: GrFingerX Control Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  GrFingerXLibMajorVersion = 1;
  GrFingerXLibMinorVersion = 0;

  LIBID_GrFingerXLib: TGUID = '{A9995C7C-77BF-4E27-B581-A4B5BBD90E50}';

  DIID__IGrFingerXCtrlEvents: TGUID = '{8D7EE181-74C0-498C-8715-DBCD75BCE01A}';
  IID_IGrFingerXCtrl: TGUID = '{A92FF0A8-F969-4AB9-99FB-9D7C03DF38C7}';
  CLASS_GrFingerXCtrl: TGUID = '{71944DD6-B5D2-4558-AD02-0435CB2B39DF}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum GRConstants
type
  GRConstants = TOleEnum;
const
  GR_OK = $00000000;
  GR_BAD_QUALITY = $00000000;
  GR_MEDIUM_QUALITY = $00000001;
  GR_HIGH_QUALITY = $00000002;
  GR_NOT_MATCH = $00000000;
  GR_MATCH = $00000001;
  GR_DEFAULT_USED = $00000003;
  GR_ERROR_INITIALIZE_FAIL = $FFFFFFFF;
  GR_ERROR_NOT_INITIALIZED = $FFFFFFFE;
  GR_ERROR_FAIL_LICENSE_READ = $FFFFFFFD;
  GR_ERROR_NO_VALID_LICENSE = $FFFFFFFC;
  GR_ERROR_NULL_ARGUMENT = $FFFFFFFB;
  GR_ERROR_FAIL = $FFFFFFFA;
  GR_ERROR_ALLOC = $FFFFFFF9;
  GR_ERROR_PARAMETERS = $FFFFFFF8;
  GR_ERROR_WRONG_USE = $FFFFFF95;
  GR_ERROR_EXTRACT = $FFFFFF94;
  GR_ERROR_SIZE_OFF_RANGE = $FFFFFF93;
  GR_ERROR_RES_OFF_RANGE = $FFFFFF92;
  GR_ERROR_CONTEXT_NOT_CREATED = $FFFFFF91;
  GR_ERROR_INVALID_CONTEXT = $FFFFFF90;
  GR_ERROR_ERROR = $FFFFFF8F;
  GR_ERROR_NOT_ENOUGH_SPACE = $FFFFFF8E;
  GR_ERROR_CONNECT_SENSOR = $FFFFFF37;
  GR_ERROR_CAPTURING = $FFFFFF36;
  GR_ERROR_CANCEL_CAPTURING = $FFFFFF35;
  GR_ERROR_INVALID_ID_SENSOR = $FFFFFF34;
  GR_ERROR_SENSOR_NOT_CAPTURING = $FFFFFF33;
  GR_ERROR_INVALID_EXT = $FFFFFF32;
  GR_ERROR_INVALID_FILENAME = $FFFFFF31;
  GR_ERROR_INVALID_FILETYPE = $FFFFFF30;
  GR_ERROR_SENSOR = $FFFFFF2F;
  GR_DEFAULT_RES = $000001F4;
  GR_DEFAULT_DIM = $00000280;
  GR_MAX_SIZE_TEMPLATE = $00002710;
  GR_MAX_IMAGE_WIDTH = $00000500;
  GR_MAX_IMAGE_HEIGHT = $00000500;
  GR_MAX_RESOLUTION = $000003E8;
  GR_MIN_IMAGE_WIDTH = $00000032;
  GR_MIN_IMAGE_HEIGHT = $00000032;
  GR_MIN_RESOLUTION = $0000007D;
  GR_IMAGE_NO_COLOR = $1FFFFFFF;
  GR_MAX_THRESHOLD = $000000C8;
  GR_MIN_THRESHOLD = $0000000A;
  GR_VERYLOW_FRR = $00000019;
  GR_LOW_FRR = $0000002D;
  GR_LOW_FAR = $0000003C;
  GR_VERYLOW_FAR = $00000050;
  GR_ROT_MIN = $00000000;
  GR_ROT_MAX = $000000B4;
  GRCAP_IMAGE_FORMAT_BMP = $000001F5;
  GRCAP_IMAGE_FORMAT_TIFF = $000001F6;
  GRCAP_IMAGE_FORMAT_RAW = $000001F7;
  GR_DEFAULT_CONTEXT = $00000000;
  GR_NO_CONTEXT = $FFFFFFFF;
  GRFINGER_FULL = $00000001;
  GRFINGER_LIGHT = $00000002;
  GRFINGER_FREE = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _IGrFingerXCtrlEvents = dispinterface;
  IGrFingerXCtrl = interface;
  IGrFingerXCtrlDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  GrFingerXCtrl = IGrFingerXCtrl;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PPSafeArray1 = ^PSafeArray; {*}


// *********************************************************************//
// DispIntf:  _IGrFingerXCtrlEvents
// Flags:     (4096) Dispatchable
// GUID:      {8D7EE181-74C0-498C-8715-DBCD75BCE01A}
// *********************************************************************//
  _IGrFingerXCtrlEvents = dispinterface
    ['{8D7EE181-74C0-498C-8715-DBCD75BCE01A}']
    procedure SensorPlug(const idSensor: WideString); dispid 1;
    procedure SensorUnplug(const idSensor: WideString); dispid 2;
    procedure FingerUp(const idSensor: WideString); dispid 3;
    procedure FingerDown(const idSensor: WideString); dispid 4;
    procedure ImageAcquired(const idSensor: WideString; width: Integer; height: Integer; 
                            var rawImage: OleVariant; res: Integer); dispid 5;
  end;

// *********************************************************************//
// Interface: IGrFingerXCtrl
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A92FF0A8-F969-4AB9-99FB-9D7C03DF38C7}
// *********************************************************************//
  IGrFingerXCtrl = interface(IDispatch)
    ['{A92FF0A8-F969-4AB9-99FB-9D7C03DF38C7}']
    function Initialize: Integer; safecall;
    function Finalize: Integer; safecall;
    function CreateContext(var contextId: Integer): Integer; safecall;
    function DestroyContext(contextId: Integer): Integer; safecall;
    function Verify(var queryTemplate: PSafeArray; var referenceTemplate: PSafeArray; 
                    var verifyScore: Integer; context: Integer): Integer; safecall;
    function IdentifyPrepare(var templateQuery: PSafeArray; context: Integer): Integer; safecall;
    function Identify(var templateReference: PSafeArray; var identifyScore: Integer; 
                      context: Integer): Integer; safecall;
    function SetIdentifyParameters(identifyThreshold: Integer; identifyRotationTolerance: Integer; 
                                   context: Integer): Integer; safecall;
    function SetVerifyParameters(verifyThreshold: Integer; verifyRotationTolerance: Integer; 
                                 context: Integer): Integer; safecall;
    function GetIdentifyParameters(var identifyThreshold: Integer; 
                                   var identifyRotationTolerance: Integer; context: Integer): Integer; safecall;
    function GetVerifyParameters(var verifyThreshold: Integer; 
                                 var verifyRotationTolerance: Integer; context: Integer): Integer; safecall;
    function CapInitialize: Integer; safecall;
    function CapFinalize: Integer; safecall;
    function CapStartCapture(const idSensor: WideString): Integer; safecall;
    function CapStopCapture(const idSensor: WideString): Integer; safecall;
    function CapSaveRawImageToFile(var rawImage: OleVariant; width: Integer; height: Integer; 
                                   const fileName: WideString; imageFormat: Integer): Integer; safecall;
    function CapLoadImageFromFile(const fileName: WideString; res: Integer): Integer; safecall;
    function CapRawImageToHandle(var rawImage: OleVariant; width: Integer; height: Integer; 
                                 hdc: Integer; var handler: IPictureDisp): Integer; safecall;
    function Extract(var rawImage: OleVariant; width: Integer; height: Integer; res: Integer; 
                     var tpt: PSafeArray; var tptSize: Integer; context: Integer): Integer; safecall;
    function BiometricDisplay(var tptQuery: PSafeArray; var rawImage: OleVariant; width: Integer; 
                              height: Integer; res: Integer; hdc: Integer; 
                              var handler: IPictureDisp; matchContext: Integer): Integer; safecall;
    function SetBiometricDisplayColors(minutiaeColor: Integer; minutiaeMatchedColor: Integer; 
                                       segmentColor: Integer; segmentMatchedColor: Integer; 
                                       inclinationColor: Integer; inclinationMatchedColor: Integer): Integer; safecall;
    function GetGrFingerVersion(var majorRelease: Byte; var minorRelease: Byte): Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IGrFingerXCtrlDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A92FF0A8-F969-4AB9-99FB-9D7C03DF38C7}
// *********************************************************************//
  IGrFingerXCtrlDisp = dispinterface
    ['{A92FF0A8-F969-4AB9-99FB-9D7C03DF38C7}']
    function Initialize: Integer; dispid 1;
    function Finalize: Integer; dispid 2;
    function CreateContext(var contextId: Integer): Integer; dispid 3;
    function DestroyContext(contextId: Integer): Integer; dispid 4;
    function Verify(var queryTemplate: {??PSafeArray}OleVariant; 
                    var referenceTemplate: {??PSafeArray}OleVariant; var verifyScore: Integer; 
                    context: Integer): Integer; dispid 5;
    function IdentifyPrepare(var templateQuery: {??PSafeArray}OleVariant; context: Integer): Integer; dispid 6;
    function Identify(var templateReference: {??PSafeArray}OleVariant; var identifyScore: Integer; 
                      context: Integer): Integer; dispid 7;
    function SetIdentifyParameters(identifyThreshold: Integer; identifyRotationTolerance: Integer; 
                                   context: Integer): Integer; dispid 8;
    function SetVerifyParameters(verifyThreshold: Integer; verifyRotationTolerance: Integer; 
                                 context: Integer): Integer; dispid 9;
    function GetIdentifyParameters(var identifyThreshold: Integer; 
                                   var identifyRotationTolerance: Integer; context: Integer): Integer; dispid 11;
    function GetVerifyParameters(var verifyThreshold: Integer; 
                                 var verifyRotationTolerance: Integer; context: Integer): Integer; dispid 12;
    function CapInitialize: Integer; dispid 13;
    function CapFinalize: Integer; dispid 14;
    function CapStartCapture(const idSensor: WideString): Integer; dispid 15;
    function CapStopCapture(const idSensor: WideString): Integer; dispid 16;
    function CapSaveRawImageToFile(var rawImage: OleVariant; width: Integer; height: Integer; 
                                   const fileName: WideString; imageFormat: Integer): Integer; dispid 18;
    function CapLoadImageFromFile(const fileName: WideString; res: Integer): Integer; dispid 19;
    function CapRawImageToHandle(var rawImage: OleVariant; width: Integer; height: Integer; 
                                 hdc: Integer; var handler: IPictureDisp): Integer; dispid 20;
    function Extract(var rawImage: OleVariant; width: Integer; height: Integer; res: Integer; 
                     var tpt: {??PSafeArray}OleVariant; var tptSize: Integer; context: Integer): Integer; dispid 21;
    function BiometricDisplay(var tptQuery: {??PSafeArray}OleVariant; var rawImage: OleVariant; 
                              width: Integer; height: Integer; res: Integer; hdc: Integer; 
                              var handler: IPictureDisp; matchContext: Integer): Integer; dispid 22;
    function SetBiometricDisplayColors(minutiaeColor: Integer; minutiaeMatchedColor: Integer; 
                                       segmentColor: Integer; segmentMatchedColor: Integer; 
                                       inclinationColor: Integer; inclinationMatchedColor: Integer): Integer; dispid 23;
    function GetGrFingerVersion(var majorRelease: Byte; var minorRelease: Byte): Integer; dispid 24;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TGrFingerXCtrl
// Help String      : GrFingerX
// Default Interface: IGrFingerXCtrl
// Def. Intf. DISP? : No
// Event   Interface: _IGrFingerXCtrlEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TGrFingerXCtrlSensorPlug = procedure(ASender: TObject; const idSensor: WideString) of object;
  TGrFingerXCtrlSensorUnplug = procedure(ASender: TObject; const idSensor: WideString) of object;
  TGrFingerXCtrlFingerUp = procedure(ASender: TObject; const idSensor: WideString) of object;
  TGrFingerXCtrlFingerDown = procedure(ASender: TObject; const idSensor: WideString) of object;
  TGrFingerXCtrlImageAcquired = procedure(ASender: TObject; const idSensor: WideString; 
                                                            width: Integer; height: Integer; 
                                                            var rawImage: OleVariant; res: Integer) of object;

  TGrFingerXCtrl = class(TOleControl)
  private
    FOnSensorPlug: TGrFingerXCtrlSensorPlug;
    FOnSensorUnplug: TGrFingerXCtrlSensorUnplug;
    FOnFingerUp: TGrFingerXCtrlFingerUp;
    FOnFingerDown: TGrFingerXCtrlFingerDown;
    FOnImageAcquired: TGrFingerXCtrlImageAcquired;
    FIntf: IGrFingerXCtrl;
    function  GetControlInterface: IGrFingerXCtrl;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function Initialize: Integer;
    function Finalize: Integer;
    function CreateContext(var contextId: Integer): Integer;
    function DestroyContext(contextId: Integer): Integer;
    function Verify(var queryTemplate: PSafeArray; var referenceTemplate: PSafeArray; 
                    var verifyScore: Integer; context: Integer): Integer;
    function IdentifyPrepare(var templateQuery: PSafeArray; context: Integer): Integer;
    function Identify(var templateReference: PSafeArray; var identifyScore: Integer; 
                      context: Integer): Integer;
    function SetIdentifyParameters(identifyThreshold: Integer; identifyRotationTolerance: Integer; 
                                   context: Integer): Integer;
    function SetVerifyParameters(verifyThreshold: Integer; verifyRotationTolerance: Integer; 
                                 context: Integer): Integer;
    function GetIdentifyParameters(var identifyThreshold: Integer; 
                                   var identifyRotationTolerance: Integer; context: Integer): Integer;
    function GetVerifyParameters(var verifyThreshold: Integer; 
                                 var verifyRotationTolerance: Integer; context: Integer): Integer;
    function CapInitialize: Integer;
    function CapFinalize: Integer;
    function CapStartCapture(const idSensor: WideString): Integer;
    function CapStopCapture(const idSensor: WideString): Integer;
    function CapSaveRawImageToFile(var rawImage: OleVariant; width: Integer; height: Integer; 
                                   const fileName: WideString; imageFormat: Integer): Integer;
    function CapLoadImageFromFile(const fileName: WideString; res: Integer): Integer;
    function CapRawImageToHandle(var rawImage: OleVariant; width: Integer; height: Integer; 
                                 hdc: Integer; var handler: IPictureDisp): Integer;
    function Extract(var rawImage: OleVariant; width: Integer; height: Integer; res: Integer; 
                     var tpt: PSafeArray; var tptSize: Integer; context: Integer): Integer;
    function BiometricDisplay(var tptQuery: PSafeArray; var rawImage: OleVariant; width: Integer; 
                              height: Integer; res: Integer; hdc: Integer; 
                              var handler: IPictureDisp; matchContext: Integer): Integer;
    function SetBiometricDisplayColors(minutiaeColor: Integer; minutiaeMatchedColor: Integer; 
                                       segmentColor: Integer; segmentMatchedColor: Integer; 
                                       inclinationColor: Integer; inclinationMatchedColor: Integer): Integer;
    function GetGrFingerVersion(var majorRelease: Byte; var minorRelease: Byte): Integer;
    property  ControlInterface: IGrFingerXCtrl read GetControlInterface;
    property  DefaultInterface: IGrFingerXCtrl read GetControlInterface;
  published
    property Anchors;
    property OnSensorPlug: TGrFingerXCtrlSensorPlug read FOnSensorPlug write FOnSensorPlug;
    property OnSensorUnplug: TGrFingerXCtrlSensorUnplug read FOnSensorUnplug write FOnSensorUnplug;
    property OnFingerUp: TGrFingerXCtrlFingerUp read FOnFingerUp write FOnFingerUp;
    property OnFingerDown: TGrFingerXCtrlFingerDown read FOnFingerDown write FOnFingerDown;
    property OnImageAcquired: TGrFingerXCtrlImageAcquired read FOnImageAcquired write FOnImageAcquired;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Griaule Fingerprint';

  dtlOcxPage = 'Griaule Fingerprint';

implementation

uses ComObj;

procedure TGrFingerXCtrl.InitControlData;
const
  CEventDispIDs: array [0..4] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005);
  CControlData: TControlData2 = (
    ClassID: '{71944DD6-B5D2-4558-AD02-0435CB2B39DF}';
    EventIID: '{8D7EE181-74C0-498C-8715-DBCD75BCE01A}';
    EventCount: 5;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80004002*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnSensorPlug) - Cardinal(Self);
end;

procedure TGrFingerXCtrl.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IGrFingerXCtrl;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TGrFingerXCtrl.GetControlInterface: IGrFingerXCtrl;
begin
  CreateControl;
  Result := FIntf;
end;

function TGrFingerXCtrl.Initialize: Integer;
begin
  Result := DefaultInterface.Initialize;
end;

function TGrFingerXCtrl.Finalize: Integer;
begin
  Result := DefaultInterface.Finalize;
end;

function TGrFingerXCtrl.CreateContext(var contextId: Integer): Integer;
begin
  Result := DefaultInterface.CreateContext(contextId);
end;

function TGrFingerXCtrl.DestroyContext(contextId: Integer): Integer;
begin
  Result := DefaultInterface.DestroyContext(contextId);
end;

function TGrFingerXCtrl.Verify(var queryTemplate: PSafeArray; var referenceTemplate: PSafeArray; 
                               var verifyScore: Integer; context: Integer): Integer;
begin
  Result := DefaultInterface.Verify(queryTemplate, referenceTemplate, verifyScore, context);
end;

function TGrFingerXCtrl.IdentifyPrepare(var templateQuery: PSafeArray; context: Integer): Integer;
begin
  Result := DefaultInterface.IdentifyPrepare(templateQuery, context);
end;

function TGrFingerXCtrl.Identify(var templateReference: PSafeArray; var identifyScore: Integer; 
                                 context: Integer): Integer;
begin
  Result := DefaultInterface.Identify(templateReference, identifyScore, context);
end;

function TGrFingerXCtrl.SetIdentifyParameters(identifyThreshold: Integer; 
                                              identifyRotationTolerance: Integer; context: Integer): Integer;
begin
  Result := DefaultInterface.SetIdentifyParameters(identifyThreshold, identifyRotationTolerance, 
                                                   context);
end;

function TGrFingerXCtrl.SetVerifyParameters(verifyThreshold: Integer; 
                                            verifyRotationTolerance: Integer; context: Integer): Integer;
begin
  Result := DefaultInterface.SetVerifyParameters(verifyThreshold, verifyRotationTolerance, context);
end;

function TGrFingerXCtrl.GetIdentifyParameters(var identifyThreshold: Integer; 
                                              var identifyRotationTolerance: Integer; 
                                              context: Integer): Integer;
begin
  Result := DefaultInterface.GetIdentifyParameters(identifyThreshold, identifyRotationTolerance, 
                                                   context);
end;

function TGrFingerXCtrl.GetVerifyParameters(var verifyThreshold: Integer; 
                                            var verifyRotationTolerance: Integer; context: Integer): Integer;
begin
  Result := DefaultInterface.GetVerifyParameters(verifyThreshold, verifyRotationTolerance, context);
end;

function TGrFingerXCtrl.CapInitialize: Integer;
begin
  Result := DefaultInterface.CapInitialize;
end;

function TGrFingerXCtrl.CapFinalize: Integer;
begin
  Result := DefaultInterface.CapFinalize;
end;

function TGrFingerXCtrl.CapStartCapture(const idSensor: WideString): Integer;
begin
  Result := DefaultInterface.CapStartCapture(idSensor);
end;

function TGrFingerXCtrl.CapStopCapture(const idSensor: WideString): Integer;
begin
  Result := DefaultInterface.CapStopCapture(idSensor);
end;

function TGrFingerXCtrl.CapSaveRawImageToFile(var rawImage: OleVariant; width: Integer; 
                                              height: Integer; const fileName: WideString; 
                                              imageFormat: Integer): Integer;
begin
  Result := DefaultInterface.CapSaveRawImageToFile(rawImage, width, height, fileName, imageFormat);
end;

function TGrFingerXCtrl.CapLoadImageFromFile(const fileName: WideString; res: Integer): Integer;
begin
  Result := DefaultInterface.CapLoadImageFromFile(fileName, res);
end;

function TGrFingerXCtrl.CapRawImageToHandle(var rawImage: OleVariant; width: Integer; 
                                            height: Integer; hdc: Integer; var handler: IPictureDisp): Integer;
begin
  Result := DefaultInterface.CapRawImageToHandle(rawImage, width, height, hdc, handler);
end;

function TGrFingerXCtrl.Extract(var rawImage: OleVariant; width: Integer; height: Integer; 
                                res: Integer; var tpt: PSafeArray; var tptSize: Integer; 
                                context: Integer): Integer;
begin
  Result := DefaultInterface.Extract(rawImage, width, height, res, tpt, tptSize, context);
end;

function TGrFingerXCtrl.BiometricDisplay(var tptQuery: PSafeArray; var rawImage: OleVariant; 
                                         width: Integer; height: Integer; res: Integer; 
                                         hdc: Integer; var handler: IPictureDisp; 
                                         matchContext: Integer): Integer;
begin
  Result := DefaultInterface.BiometricDisplay(tptQuery, rawImage, width, height, res, hdc, handler, 
                                              matchContext);
end;

function TGrFingerXCtrl.SetBiometricDisplayColors(minutiaeColor: Integer; 
                                                  minutiaeMatchedColor: Integer; 
                                                  segmentColor: Integer; 
                                                  segmentMatchedColor: Integer; 
                                                  inclinationColor: Integer; 
                                                  inclinationMatchedColor: Integer): Integer;
begin
  Result := DefaultInterface.SetBiometricDisplayColors(minutiaeColor, minutiaeMatchedColor, 
                                                       segmentColor, segmentMatchedColor, 
                                                       inclinationColor, inclinationMatchedColor);
end;

function TGrFingerXCtrl.GetGrFingerVersion(var majorRelease: Byte; var minorRelease: Byte): Integer;
begin
  Result := DefaultInterface.GetGrFingerVersion(majorRelease, minorRelease);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TGrFingerXCtrl]);
end;

end.
