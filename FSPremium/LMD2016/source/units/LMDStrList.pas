unit LMDStrList;
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

LMDStrList unit (RM)
--------------------

Very simple component, moved back to Core on customer request

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDCustomComponent;

type
  {------------------------- TLMDStrList --------------------------------------}
  TLMDStrList = class(TLMDCustomComponent)
  private
    FStrList:TStringList;
    function GetDuplicates:TDuplicates;
    function GetList:TStrings;
    function GetSorted:Boolean;
    function GetOnChange:TNotifyEvent;
    function GetOnChanging:TNotifyEvent;
    procedure SetList(aValue:TStrings);
    procedure SetSorted(aValue:Boolean);
    procedure SetDuplicates(aValue:TDuplicates);
    procedure SetOnChange(aValue:TNotifyEvent);
    procedure SetOnChanging(aValue:TNotifyEvent);
  protected
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    Property About;
    property Items: TStrings read GetList write SetList;
    property Sorted: Boolean read GetSorted write SetSorted;
    property Duplicates: TDuplicates read GetDuplicates write SetDuplicates;
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;
    property OnChanging: TNotifyEvent read GetOnChanging write SetOnChanging;
  end;

implementation
{*************************** Class TLMDStrList*********************************}
{----------------------------  Private ----------------------------------------}
function TLMDStrList.GetSorted:Boolean;
begin
  result:=FStrList.Sorted;
end;

{------------------------------------------------------------------------------}
function TLMDStrList.GetDuplicates:TDuplicates;
begin
  result:=FStrList.Duplicates;
end;

{------------------------------------------------------------------------------}
function TLMDStrList.GetList:TStrings;
begin
  result:=FStrList;
end;

{------------------------------------------------------------------------------}
function TLMDStrList.GetOnChange:TNotifyEvent;
begin
  result:=FStrList.OnChange;
end;

{------------------------------------------------------------------------------}
function TLMDStrList.GetOnChanging:TNotifyEvent;
begin
  result:=FStrList.OnChanging;
end;

{------------------------------------------------------------------------------}
procedure TLMDStrList.SetList(aValue:TStrings);
begin
  FStrList.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStrList.SetSorted(aValue:Boolean);
begin
  if aValue<>FStrList.Sorted then FStrList.Sorted:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDStrList.SetDuplicates(aValue:TDuplicates);
begin
  if aValue<>FStrList.Duplicates then FStrList.Duplicates:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDStrList.SetOnChange(aValue:TNotifyEvent);
begin
  FStrList.OnChange:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDStrList.SetOnChanging(aValue:TNotifyEvent);
begin
  FStrList.OnChanging:=aValue;
end;

{---------------------Public---------------------------------------------------}
constructor TLMDStrList.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FStrList:=TStringList.Create;
  FStrList.Duplicates:=dupAccept;
end;

{------------------------------------------------------------------------------}
Destructor TLMDStrList.Destroy;
begin
  FStrList.Free;
  inherited Destroy;
end;

end.
