unit LMDDsgObjects;
{$I LmdCmps.inc}

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

LMDDsgObjects unit (YB)
------------------------
TLMDDesignObjects unit.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, LMDDsgCst, LMDDsgClass,
  LMDTypes, intfLMDBase;

type
  {***************************** TLMDDesignObjects ****************************}

  TLMDDesignObjects = class;

  ILMDDsgObjsNotifier = class
  public
    procedure Changed(ASender: TLMDDesignObjects); virtual; abstract;
  end;

  TLMDDesignObjects = class(TComponent, ILMDComponent)
  private
    FAbout:       TLMDAboutVar;
    FItems:       TList;
    FNotifiers:   TList;
    FUpdateCount: Integer;
    FChanged:     Boolean;
    FOnChange:    TNotifyEvent;

    procedure Changed;
    function  GetCount: Integer;
    function  GetItem(AIndex: Integer): TPersistent;
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure DoChange; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddNotifier(ANotifier: ILMDDsgObjsNotifier);
    procedure RemoveNotifier(ANotifier: ILMDDsgObjsNotifier);

    procedure Clear;
    procedure Add(AItem: TPersistent);
    procedure Delete(AIndex: Integer);
    procedure Remove(AItem: TPersistent);
    function  IndexOf(AItem: TPersistent): Integer;
    procedure SetItems(AItems: TList);
    procedure GetItems(AResult: TList);
    procedure GetComps(AResult: TList);
    procedure SetOne(AItem: TPersistent);
    procedure CopyFrom(AObjects: TLMDDesignObjects);
    procedure BeginUpdate;
    procedure EndUpdate;

    property  Count: Integer read GetCount;
    property  Item[AIndex: Integer]: TPersistent read GetItem; default;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

{****************************** TLMDDesignObjects *****************************}
{----------------------------------- private ----------------------------------}

procedure TLMDDesignObjects.Changed;
begin
  FChanged := False;
  if FUpdateCount = 0 then
    DoChange
  else
    FChanged := True;
end;

{------------------------------------------------------------------------------}

function TLMDDesignObjects.GetCount: Integer;
begin
  Result := FItems.Count;
end;
      
{------------------------------------------------------------------------------}

function TLMDDesignObjects.GetItem(AIndex: Integer): TPersistent;
begin
  Result := TPersistent(FItems[AIndex]);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDDesignObjects.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DESIGN;
end;

{----------------------------------- protected --------------------------------}

procedure TLMDDesignObjects.DoChange;
var
  i: Integer;
begin
  if not (csDestroying in ComponentState) then
  begin
    for i := 0 to FNotifiers.Count - 1 do
      ILMDDsgObjsNotifier(FNotifiers[i]).Changed(Self);

    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

{------------------------------------- public ---------------------------------}

constructor TLMDDesignObjects.Create(AOwner: TComponent);
begin
  inherited;
  FItems     := TList.Create;
  FNotifiers := TList.Create;
end;
       
{------------------------------------------------------------------------------}

destructor TLMDDesignObjects.Destroy;
begin
  Destroying;
  FItems.Free;
  FNotifiers.Free;
  FNotifiers := nil;
  inherited;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.AddNotifier(
  ANotifier: ILMDDsgObjsNotifier);
begin
  if FNotifiers.IndexOf(ANotifier) = -1 then
    FNotifiers.Add(ANotifier);
end;
   
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.RemoveNotifier(
  ANotifier: ILMDDsgObjsNotifier);
begin
  if FNotifiers <> nil then
    FNotifiers.Remove(ANotifier);
end;
   
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.Clear;
begin
  FItems.Clear;
  Changed;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.Add(AItem: TPersistent);
begin
  FItems.Add(AItem);
  Changed;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.Delete(AIndex: Integer);
begin
  FItems.Delete(AIndex);
  Changed;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.Remove(AItem: TPersistent);
begin
  FItems.Remove(AItem);
  Changed;
end;
    
{------------------------------------------------------------------------------}

function TLMDDesignObjects.IndexOf(AItem: TPersistent): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;
     
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.SetItems(AItems: TList);
var
  i: Integer;
begin
  FItems.Clear;
  for i := 0 to AItems.Count - 1 do
    FItems.Add(AItems[i]);
  Changed;
end;
       
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.GetItems(AResult: TList);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    AResult.Add(FItems[i]);
end;
      
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.GetComps(AResult: TList);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
  begin
    if TPersistent(FItems[i]) is TComponent then
      AResult.Add(FItems[i]);
  end;
end;
    
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.SetOne(AItem: TPersistent);
begin
  FItems.Clear;
  FItems.Add(AItem);
  Changed;
end;
     
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.CopyFrom(AObjects: TLMDDesignObjects);
var
  i: Integer;
begin
  for i := 0 to AObjects.FItems.Count - 1 do
    FItems.Add(AObjects.FItems[i]);
  Changed;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.BeginUpdate;
begin
  Inc(FUpdateCount);
end;
    
{------------------------------------------------------------------------------}

procedure TLMDDesignObjects.EndUpdate;
begin
  Dec(FUpdateCount);
  if (FUpdateCount = 0) and FChanged then
    Changed;
end;
    
{------------------------------------------------------------------------------}

end.
