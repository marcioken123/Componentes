unit LMDTypes;
{$I lmdcmps.inc}

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

LMDTypes unit - General types for LMDRTL (AH)
---------------------------------------------

ToDo
----
* VCL.NET support

Changes
-------
Release 9.0 (July 2008)
+ TLMDTypeData

Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Messages, Windows, TypInfo,
  LMDUnicode, LMDUnicodeStrings;

const
  LMDVCL_PRODUCTNAME = 'LMD-Tools 2016';                                     // do not localize
  LMDTOOLS_REGISTRYPATH = 'SOFTWARE\LMD Innovative\' + LMDVCL_PRODUCTNAME;   // do not localize

type
  TLMDPtrUInt = {$IFDEF LMDX64}NativeUInt;{$ELSE}Cardinal;{$ENDIF}
  TLMDPtrInt = {$IFDEF LMDX64}NativeInt;{$ELSE}Integer;{$ENDIF}
  TLMDIntRec = {$IFDEF LMDX64}Int64Rec;{$else}LongRec;{$endif}

  {$ifdef LMDCOMP16}
  TLMDSize_t = SIZE_T;
  {$else}
  TLMDSize_t = DWORD;
  {$endif}

  {$IFDEF LMD_UNICODE}
  PLMDChar          = {$IFDEF LMD_NATIVEUNICODE}PChar{$ELSE}PWideChar{$ENDIF};
  TLMDChar          = {$IFDEF LMD_NATIVEUNICODE}Char{$ELSE}WideChar{$ENDIF};
  TLMDBaseString    = {$IFDEF LMD_NATIVEUNICODE}String{$ELSE}WideString{$ENDIF};
  TLMDStrings       = {$IFDEF LMD_NATIVEUNICODE}TStrings{$ELSE}TLMDWideStrings{$ENDIF};
  TLMDMemoryStrings = {$IFDEF LMD_NATIVEUNICODE}TStringList{$ELSE}TLMDWideStringList{$ENDIF};
  {$ELSE}
  PLMDChar          = PAnsiChar;
  TLMDChar          = AnsiChar;
  TLMDBaseString    = AnsiString;
  TLMDStrings       = TStrings;
  TLMDMemoryStrings = TStringList;
  {$ENDIF}
  TLMDString        = type TLMDBaseString;
  TElFString        = TLMDString;

  // ZLib
  TLMDDataTag  =  Pointer ;
  TLMDPropInfo =  PPropInfo ;
  TLMDTypeInfo =  PTypeInfo ;
  TLMDTypeData =  PTypeData;
  TLMDPropList =  PPropList ;

  // LMDFiles, BOM - Byte Order Mark, BE - Big Endian, LE - Little Endian
  // For UTF8 - byte order same for BE and LE
  TLMDBOM = (bomNone, bomUTF32BE, bomUTF32LE, bomUTF16BE, bomUTF16LE, bomUTF8, bomUTF7);

  TLMDCharArray = array of TLMDChar;
  TLMDWideCharArray = array of WideChar;
  TLMDAnsiCharArray = array of AnsiChar;
  TLMDIntArray = array of Integer;
  TLMDByteArray = array of Byte;

  TLMDRegExString = type String;

  TLMDUnits = (unPoints, unInches, unMillimeters, unAuto);
  TLMDMeasureUnits = unInches..unAuto;
  // from LMDGraph
  TLMDPercent= 0..100;

 {$EXTERNALSYM TLMDTextMetric}
 {$ifdef LMD_UNICODE}
  TLMDTextMetric = tagTextMetricW;
 {$else}
  TLMDTextMetric = tagTextMetricA;
 {$endif}

{$HINTS OFF}
const
  MaxListSize = Maxint div 16;

type
  PPointerList = ^TPointerList;
  TPointerList = array[0..MaxListSize - 1] of Pointer;
  TxListItem = Pointer;
{$HINTS ON}

type
  PByteArr = ^TByteArr;
  TByteArr = array[0..$7FFFFFFE] of byte;

  // Process priority class
  // TODO: Never used, incompatible with d5.
  //TLMDProcessPriority = (ppNormalClass = $00000020, ppIdleClass = $00000040,
  //                       ppHighClass = $00000080, ppRealtimeClass = $00000100);

type
  PtrToPixel = Pointer;
  UniPtr = PtrToPixel;

  // WAIT_ABONDONED, WAIT_OBJECT_0, WAIT_TIMEOUT, WAIT_FAILED
  TLMDWaitStatus = (wsAbandoned, wsSignaled, wsTimeout, wsFailed);

  TLMDWndMethod = procedure(var Message: TMessage) of object;
  TLMDIndexEvent = procedure (Sender : TObject; Index : Integer) of object;

  TLMDAboutVar = type String;


type
  TLMDMargins = class(TPersistent)
  private
    FTop: Integer;
    FLeft: Integer;
    FRight: Integer;
    FBottom: Integer;
    FOnChange: TNotifyEvent;
    procedure SetMargins(const Index, Value: Integer);
  protected
    procedure Change; virtual;
  public
    constructor Create; overload;
    constructor Create(const ALeft, ATop, ARight, ABottom: Integer); overload;
    constructor Create(const ARect: TRect); overload;
    procedure Assign(ASource: TPersistent); override;
    function AsRect: TRect;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Left: Integer index 0 read FLeft write SetMargins default 0;
    property Top: Integer index 1 read FTop write SetMargins default 0;
    property Right: Integer index 2 read FRight write SetMargins default 0;
    property Bottom: Integer index 3 read FBottom write SetMargins default 0;
  end;

{$IFDEF LMDDISABLE_OLEINIT}
   CONST LMDDisableOleinit:Boolean=TRUE;
{$ELSE}
   CONST LMDDisableOleinit:Boolean=FALSE;
{$ENDIF}

  {$I LMDPackages.inc}

implementation

{ TLMDMargins }

procedure TLMDMargins.Assign(ASource: TPersistent);
var
  LSource: TLMDMargins;
begin
  if ASource is TLMDMargins then
  begin
    LSource := ASource as TLMDMargins;
    Self.FTop := LSource.Top;
    Self.FLeft := LSource.Left;
    Self.FBottom := LSource.Bottom;
    Self.FRight := LSource.Right;
  end
  else
    inherited;
end;

function TLMDMargins.AsRect: TRect;
begin
  Result := Rect(FLeft, FTop, FRight, FBottom);
end;

procedure TLMDMargins.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TLMDMargins.Create(const ALeft, ATop, ARight, ABottom: Integer);
begin
  FLeft := ALeft;
  FTop := ATop;
  FRight := ARight;
  FBottom := ABottom;
end;

constructor TLMDMargins.Create(const ARect: TRect);
begin
  FLeft := ARect.Left;
  FTop := ARect.Top;
  FRight := ARect.Right;
  FBottom := ARect.Bottom;
end;

constructor TLMDMargins.Create;
begin
  inherited;
  Self.FTop := 0;
  Self.FLeft := 0;
  Self.FBottom := 0;
  Self.FRight := 0;
end;

procedure TLMDMargins.SetMargins(const Index, Value: Integer);
begin
  case Index of
  0: if (FLeft <> Value) then
     begin
       FLeft := Value;
       Change;
     end;
  1: if (FTop <> Value) then
     begin
       FTop := Value;
       Change;
     end;
  2: if (FRight <> Value) then
     begin
       FRight := Value;
       Change;
     end;
  3: if (FBottom <> Value) then
     begin
       FBottom := Value;
       Change;
     end;
  end;
end;

end.
