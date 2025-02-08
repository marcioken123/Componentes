unit LMDCustomIniComponent;
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

LMDCustomIniComponent unit ()
-----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, LMDCustomComponent, LMDIniCtrl;

type
  {------------------- class TLMDCustomIniComponent ---------------------------}
  TLMDCustomIniComponent = class(TLMDCustomComponent)
  private
    FIniLink:TLMDIniCtrl;
    FIniUse:TLMDIniUse;
    FSection:String;
    FOwnerFormCreate,
    FOwnerFormDestroy: TNotifyEvent;
    procedure OwnerFormCreate(Sender:TObject);
    procedure OwnerFormDestroy(Sender:TObject);
    procedure SetIniLink(aValue:TLMDIniCtrl);
    procedure SetSection(const aValue:String);
    function GetSection:String;
  protected
    procedure CreateSectionDefault(var aValue:String);virtual;
    //procedure Loaded;override;
    procedure SetSectionDefault;
    procedure Notification(aComponent:TComponent;Operation:TOperation);override;
    procedure NotificationStandard(aComponent:TComponent);
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy; override;
    procedure RestoreState;dynamic;
    procedure SaveState;dynamic;
    property IniLink:TLMDIniCtrl read FIniLink write SetIniLink;
    property IniUse: TLMDIniUse read FIniUse write FIniUse default ioUseGlobal;
    property Section:String read GetSection write SetSection;
  end;

implementation

uses
  SysUtils,
  Forms;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.SetIniLink(aValue:TLMDIniCtrl);
begin
  FIniLink:=aValue;
  if FIniLink<>nil then FIniLink.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.SetSection(const aValue:String);
begin
  if aValue<>FSection then
    begin
      FSection:=aValue;
      SetSectionDefault;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomIniComponent.GetSection:String;
begin
  result:=FSection;
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDCustomIniComponent.Notification(aComponent:TComponent;Operation:TOperation);
begin
  inherited Notification(aComponent,Operation);
  if (Operation=opRemove) and (aComponent=FIniLink) then FIniLink:=nil;
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomIniComponent.Loaded;
begin
  inherited Loaded;
  if not(csDesigning in ComponentState) then RestoreState;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.NotificationStandard(aComponent:TComponent);
var
  i,l,comp : Integer;

begin
  if (FIniUse=ioUseLink) and (aComponent is TLMDIniCtrl) and (FIniLink=nil) then
    IniLink:=TLMDIniCtrl(aComponent);

  if (Owner is TForm) and (aComponent=Self) then
    begin
      comp:=0;
      if FIniUse=ioUseLink then
        begin
          l:=0;
          for i:=0 to Pred(TForm(Owner).ComponentCount) do
            if TForm(Owner).Components[i] is TLMDIniCtrl then
              begin
                Comp:=i;
                inc(l);
              end;
          if l=1 then
            FIniLink:=TLMDIniCtrl(TForm(Owner).Components[Comp]);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if not (csDesigning in ComponentState) then
    begin
      FOwnerFormCreate:=TForm(Owner).OnCreate;
      TForm(Owner).OnCreate:=OwnerFormCreate;
      FOwnerFormDestroy:=TForm(Owner).OnDestroy;
      TForm(Owner).OnDestroy:=OwnerFormDestroy;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.CreateSectionDefault(var aValue:String);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.SetSectionDefault;
begin
  CreateSectionDefault(FSection);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.OwnerFormCreate(Sender:TObject);
begin
  if not(csDesigning in ComponentState) then RestoreState;
  if Assigned(FOwnerFormCreate) then FOwnerFormCreate(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.OwnerFormDestroy(Sender:TObject);
begin
  if not(csDesigning in ComponentState) then SaveState;
  if Assigned(FOwnerFormDestroy) then FOwnerFormDestroy(Sender);
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDCustomIniComponent.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  //TDataModule added Nov 02, JH
  if not (Owner is TForm) and not (Owner is TDataModule) then
    raise Exception.Create(self.ClassName+#13'Invalid Owner (<>TForm and <>TDataModule)');
  FIniUse:=ioUseGlobal;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomIniComponent.Destroy;
begin
  //if not(csDesigning in ComponentState) then SaveState;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.RestoreState;
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomIniComponent.SaveState;
begin
end;

end.
