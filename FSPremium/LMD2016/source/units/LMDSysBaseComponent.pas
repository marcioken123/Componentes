unit LMDSysBaseComponent;
{$I LMDCmps.inc}

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

LMDSysBaseComponent unit (JH)
-----------------------------
The TLMDSysBaseComponent is the base component for all LMD Sys components which
shall provide logging.

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDSysBase,
  LMDSysObject,
  LMDSysLog
  ;

type

  TLMDSysComponentOnProgress = procedure(aSender : TObject; aCaption : string; aMax, aPosition : integer) of Object;

  TLMDSysBaseComponent = class(TLMDSysComponent, IUnknown, ILMDSysContainer, ILMDSysDescriptor)
  private
    FLog: TLMDSysLog;
    FRetrieved,
    FAutoRetrieve : Boolean;
    FOnRefresh,
    FOnAfterRefresh: TNotifyEvent;
    FOnProgress : TLMDSysComponentOnProgress;
    procedure SetLog(aLog: TLMDSysLog);
  protected
    FSysObject: TLMDSysObject;

    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; reintroduce; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    property SysObject: TLMDSysObject read FSysObject write FSysObject;

    //takes care about the pointer to the SysLog component
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RefreshIt; virtual;
    //event handler method for the TLMDSysObject descendants
    //will /if connected to one) automatically forward the event to the syslog
    //component FLog points to
    procedure DoLog(Sender: TObject; propertyDescription, oldValue, newValue: string; datetime: TDateTime);
    //Initializes SysObject event handling and gets current sys settings
    procedure InitSysObject;
    //returns true if the system info data has been retrieved
    function GetRetrieved: Boolean; virtual;
    //sets the retrieved variable to true (data has been retrieved)
    procedure SetRetrieved;
    public
    procedure Loaded; override;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;

    function GetElementCount : integer; virtual;
    function GetElement(index : integer) : TObject;  virtual;
    function GetElementTitle : string;  virtual;
    function GetElementDescription : string;  virtual;
    function GetElementType : TLMDSysInfoType; virtual;

    procedure DoProgress(aCaption : string; aMax, aPosition : integer);

    //determines whether system infor data has been retrieved
    property Retrieved: Boolean read GetRetrieved stored false;

    //loggging component, some of the properties of the sysobject may be changeable
    //all the changes made by this component can be logged
    property SysLog: TLMDSysLog read FLog write SetLog;

  published
    //if enabled the component will retrieve the system information directly after it has been loaded from the stream
    //otherwise this has to be done manually
    property AutoRetrieve: Boolean read FAutoRetrieve write FAutoRetrieve default false;

    property OnRefresh : TNotifyEvent read FOnRefresh write FOnRefresh;
    property OnAfterRefresh : TNotifyEvent read FOnAfterRefresh write FOnAfterRefresh;
    property OnProgress : TLMDSysComponentOnProgress read FOnProgress write FOnProgress;
  end;

implementation
uses
  LMDSysConst;
{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{ ************************** TLMDSysBaseComponent **************************** }
{ -------------------------------- private ----------------------------------- }
procedure TLMDSysBaseComponent.SetLog(aLog: TLMDSysLog);
begin
  FLog:= aLog;
end;

{ ------------------------------- protected ---------------------------------- }

function TLMDSysBaseComponent.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseComponent._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseComponent._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseComponent.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FLog then
      FLog:= nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseComponent.RefreshIt;
begin
  FSysObject.Refresh;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseComponent.DoLog(Sender: TObject; propertyDescription, oldValue, newValue: string; datetime: TDateTime);
begin
  if not Assigned(FLog) then exit;

  FLog.Log(propertyDescription, oldValue, newValue, datetime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseComponent.InitSysObject;
begin
  if Assigned(FSysObject) then
    begin
      FSysObject.OnChangeLog:= DoLog;
      FSysObject.Owner:= Self;
      //FSysObject.Refresh; -> do not auto retrieve, may cost too much time on
      //program startup, or on placing the component on the form
      FSysObject.Init;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseComponent.GetRetrieved: Boolean;
begin
  result := FRetrieved;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseComponent.SetRetrieved;
begin
   FRetrieved := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseComponent.DoProgress(aCaption : string; aMax, aPosition : integer);
begin
  if assigned(FOnProgress) then
    FOnProgress(Self, aCaption, aMax, aPosition);
end;

{ ------------------------------- public ------------------------------------- }
procedure TLMDSysBaseComponent.Loaded;
begin
  inherited Loaded;
  // static items are initialized here
  //if Assigned(FSysObject) then
  //  FSysObject.Init;
  if FAutoRetrieve then
    Refresh;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSysBaseComponent.Create(aOwner: TComponent);
begin
  inherited Create (aOwner);
  FAutoRetrieve := false;
  FOnProgress := nil;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysBaseComponent.Destroy;
begin
  if Assigned(FSysObject) then
    begin
      FSysObject.OnChangeLog:= nil;
      FSysObject.Free;
    end;
  FLog:= nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
{$O-} // Just a trick - in other case Self is nil after calling RefreshIt.
procedure TLMDSysBaseComponent.Refresh;
begin
  if Assigned (FOnRefresh) then FOnRefresh (self);
  RefreshIt;
  SetRetrieved;
  if Assigned (FOnAfterRefresh) then FOnAfterRefresh (self);
end;
{$O+}

{ ---------------------------------------------------------------------------- }

procedure TLMDSysBaseComponent.AfterConstruction;
begin
  inherited;
//  InterlockedDecrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysBaseComponent.BeforeDestruction;
begin
  inherited;
//  if RefCount <> 0 then RunError(204);
  if RefCount > 1 then RunError(204);
end;

{ ---------------------------------------------------------------------------- }

class function TLMDSysBaseComponent.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TLMDSysBaseComponent(Result).FRefCount := 1;
end;

{------------------------------------------------------------------------------}
function TLMDSysBaseComponent.GetElementCount : integer;
begin
  result := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseComponent.GetElement(index : integer) : TObject;
begin
  result := TObject(FSysObject);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseComponent.GetElementTitle : string;
begin
  result := cLMDSysInfoTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseComponent.GetElementDescription : string;
begin
  result := cLMDSysInfoDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysBaseComponent.GetElementType : TLMDSysInfoType;
begin
  result := itSystemInfoGroup;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}
end.
