unit LMDSvcPvdr;
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

LMDSvcPvdr unit (YB)
--------------------
General local service providing mechanism for using in customizable
applications.

Changes
-------
Release 8.0 (January 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, SysUtils, Types, intfLMDBase, LMDTypes, LMDRTLConst;

type
  ELMDServiceProvider = class(Exception);
  TLMDServiceProvider = class;

  ILMDServicesNotifier = class
  public
    procedure AfterMemberAddition(AMember: TObject); virtual; abstract;
    procedure BeforeMemberRemoving(AMember: TObject); virtual; abstract;
  end;

  {****************************** TLMDServices ********************************}

  TLMDServices = class
  private
    FItems:    TList;
    FProvider: TLMDServiceProvider;
  public
    constructor Create(AProvider: TLMDServiceProvider);
    destructor Destroy; override;

    procedure Clear;
    procedure RegisterService(AService: TObject);
    procedure UnregisterService(AService: TObject);
    function  IsRegistered(AClass: TClass): Boolean;

    function  Find(AClass: TClass): TObject;
    function  Get(AClass: TClass): TObject;
  end;

  {****************************** TLMDNotifiers *******************************}

  TLMDNotifiers = class
  private
    FItems:    TList;
    FProvider: TLMDServiceProvider;
  public
    constructor Create(AProvider: TLMDServiceProvider);
    destructor Destroy; override;

    procedure Clear;
    procedure RegisterNotifier(ANotifier: TObject);
    procedure UnregisterNotifier(ANotifier: TObject);
    function  GetList(AClass: TClass): TList;
  end;

  {******************************* TLMDMembers ********************************}

  TLMDMembers = class
  private
    FItems:    TList;
    FProvider: TLMDServiceProvider;

    function GetCount: Integer;
    function GetItems(AIndex: Integer): TObject;
  public
    constructor Create(AProvider: TLMDServiceProvider);
    destructor Destroy; override;

    procedure Clear;
    procedure RegisterMember(AMember: TObject);
    procedure UnregisterMember(AMember: TObject);
    function  IsMember(AObject: TObject): Boolean;
    function  GetList(AClass: TClass): TList;
    function  FindFirst(AClass: TClass): TObject;
    property  Count: Integer read GetCount;
    property  Items[AIndex: Integer]: TObject read GetItems; default;
  end;

  {*************************** TLMDServiceProvider ****************************}

  TLMDServiceProvider = class(TComponent, ILMDComponent)
  private
    FAbout:     TLMDAboutVar;
    FServices:  TLMDServices;
    FNotifiers: TLMDNotifiers;
    FMembers:   TLMDMembers;
  protected
    function getLMDPackage:TLMDPackageID; 
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Services: TLMDServices read FServices;
    property Notifiers: TLMDNotifiers read FNotifiers;
    property Members: TLMDMembers read FMembers;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

function   LMDTryGetService(AProvider: TLMDServiceProvider; AClass: TClass;
                            out AService): Boolean;
procedure  _RegisterOnce; // IDE-Tools packages will register shared
                          // TLMDServiceProvider component using this utility.
                          // Do not call it directly.
                   
implementation
          
{------------------------------------------------------------------------------}

var
  IsRegistered: Boolean;
                 
{------------------------------------------------------------------------------}

function LMDTryGetService(AProvider: TLMDServiceProvider; AClass: TClass;
  out AService): Boolean;
begin
  TObject(AService) := nil;
  if AProvider <> nil then
    TObject(AService) := AProvider.Services.Find(AClass);

  Result := (TObject(AService) <> nil);
end;
                  
{------------------------------------------------------------------------------}

procedure _RegisterOnce;
begin
  if not IsRegistered then
    RegisterComponents('LMD IDE-Tools', [TLMDServiceProvider]);
  IsRegistered := True;
end;

{******************************** TLMDServices ********************************}
{------------------------------------------------------------------------------}

procedure TLMDServices.Clear;
begin
  FItems.Clear;
end;

{------------------------------------------------------------------------------}

constructor TLMDServices.Create(AProvider: TLMDServiceProvider);
begin
  inherited Create;
  FProvider := AProvider;
  FItems    := TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDServices.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDServices.Find(AClass: TClass): TObject;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
  begin
    Result := TObject(FItems[i]);

    if (Result.ClassType = AClass) or
       (Result.ClassType.InheritsFrom(AClass)) then
      Exit;
  end;

  Result := nil;
end;

{------------------------------------------------------------------------------}

function TLMDServices.Get(AClass: TClass): TObject;
begin
  Result := Find(AClass);
  if Result = nil then
    raise ELMDServiceProvider.CreateFmt(SLMDServiceNotRegistered,
                                        [AClass.ClassName]);
end;

{------------------------------------------------------------------------------}

function TLMDServices.IsRegistered(AClass: TClass): Boolean;
begin
  Result := (Find(AClass) <> nil);
end;

{------------------------------------------------------------------------------}

procedure TLMDServices.RegisterService(AService: TObject);
begin
  if IsRegistered(AService.ClassType) then
    raise ELMDServiceProvider.CreateFmt(SLMDDuplicateService,
                                        [AService.ClassType.ClassName]);
  FItems.Add(AService);
end;

{------------------------------------------------------------------------------}

procedure TLMDServices.UnregisterService(AService: TObject);
begin
  FItems.Remove(AService);
end;

{******************************* TLMDNotifiers ********************************}
{------------------------------------------------------------------------------}

constructor TLMDNotifiers.Create(AProvider: TLMDServiceProvider);
begin
  inherited Create;
  FProvider := AProvider;
  FItems    := TList.Create;
end;
       
{------------------------------------------------------------------------------}

destructor TLMDNotifiers.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;
   
{------------------------------------------------------------------------------}

procedure TLMDNotifiers.Clear;
begin
  FItems.Clear;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDNotifiers.RegisterNotifier(ANotifier: TObject);
begin
  if FItems.IndexOf(ANotifier) = -1 then
    FItems.Add(ANotifier);
end;
        
{------------------------------------------------------------------------------}

procedure TLMDNotifiers.UnregisterNotifier(ANotifier: TObject);
begin
  FItems.Remove(ANotifier);
end;
     
{------------------------------------------------------------------------------}

function TLMDNotifiers.GetList(AClass: TClass): TList;
var
  i:   Integer;
  obj: TObject;
begin
  Result := TList.Create;
  try
    for i := 0 to FItems.Count - 1 do
    begin
      obj := TObject(FItems[i]);
      if (obj.ClassType = AClass) or
         (obj.ClassType.InheritsFrom(AClass)) then
        Result.Add(obj);
    end;
  except
    Result.Free;
    raise;
  end;
end;

{******************************** TLMDMembers *********************************}
{------------------------------------------------------------------------------}

function TLMDMembers.GetCount: Integer;
begin
  Result := FItems.Count;
end;
    
{------------------------------------------------------------------------------}

function TLMDMembers.GetItems(AIndex: Integer): TObject;
begin
  Result := TObject(FItems[AIndex]);
end;
    
{------------------------------------------------------------------------------}

constructor TLMDMembers.Create(AProvider: TLMDServiceProvider);
begin
  inherited Create;
  FProvider := AProvider;
  FItems    := TList.Create;
end;
    
{------------------------------------------------------------------------------}

destructor TLMDMembers.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDMembers.Clear;
begin
  FItems.Clear;
end;
         
{------------------------------------------------------------------------------}

procedure TLMDMembers.RegisterMember(AMember: TObject);
var
  i:    Integer;
  list: TList;
begin
  if FItems.IndexOf(AMember) = -1 then
  begin
    FItems.Add(AMember);

    list := FProvider.Notifiers.GetList(ILMDServicesNotifier);
    try
      for i := 0 to list.Count - 1 do
        ILMDServicesNotifier(list[i]).AfterMemberAddition(AMember);
    finally
      list.Free;
    end;
  end;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDMembers.UnregisterMember(AMember: TObject);
var
  idx:  Integer;
  i:    Integer;
  list: TList;
begin
  idx := FItems.IndexOf(AMember);

  if idx <> -1 then
  begin
    list := FProvider.Notifiers.GetList(ILMDServicesNotifier);
    try
      for i := 0 to list.Count - 1 do
        ILMDServicesNotifier(list[i]).BeforeMemberRemoving(AMember);
      FItems.Delete(idx);
    finally
      list.Free;
    end;
  end;
end;
           
{------------------------------------------------------------------------------}

function TLMDMembers.IsMember(AObject: TObject): Boolean;
begin
  Result := (FItems.IndexOf(AObject) <> -1);
end;
       
{------------------------------------------------------------------------------}

function TLMDMembers.GetList(AClass: TClass): TList;
var
  i:   Integer;
  obj: TObject;
begin
  Result := TList.Create;
  try
    for i := 0 to FItems.Count - 1 do
    begin
      obj := TObject(FItems[i]);
      if (obj.ClassType = AClass) or
         (obj.ClassType.InheritsFrom(AClass)) then
        Result.Add(obj);
    end;
  except
    Result.Free;
    raise;
  end;
end;
        
{------------------------------------------------------------------------------}

function TLMDMembers.FindFirst(AClass: TClass): TObject;
var
  i:   Integer;
  obj: TObject;
begin
  for i := 0 to FItems.Count - 1 do
  begin
    obj := TObject(FItems[i]);
    if (obj.ClassType = AClass) or
       (obj.ClassType.InheritsFrom(AClass)) then
    begin
      Result := obj;
      Exit;
    end;
  end;

  Result := nil;
end;

{**************************** TLMDServiceProvider *****************************}
{----------------------- protected --------------------------------------------}
function TLMDServiceProvider.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_DESIGN;
end;

{------------------------------------------------------------------------------}
constructor TLMDServiceProvider.Create(AOwner: TComponent);
begin
  inherited;
  FServices  := TLMDServices.Create(Self);
  FNotifiers := TLMDNotifiers.Create(Self);
  FMembers   := TLMDMembers.Create(Self);
end;

{------------------------------------------------------------------------------}
destructor TLMDServiceProvider.Destroy;
begin
  inherited; // Send remove notifications first.

  FServices.Clear;
  FNotifiers.Clear;
  FMembers.Clear;
  FServices.Free;
  FNotifiers.Free;
  FMembers.Free;
end;

end.
