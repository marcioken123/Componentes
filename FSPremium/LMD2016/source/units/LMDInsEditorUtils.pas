unit LMDInsEditorUtils;
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

LMDInsEditorUtils unit (YB)
--------------------------
Unit contains base abstract class for utilites used by advanced built-in
property editors (and by non-modal editor dialogs).

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, LMDTypes, LMDStrings,
  LMDInsCst, LMDInsClass;

type
  TLMDEditorUtils = class
  private
    FRefCounter: Integer;
    FIsReset:    Boolean;
  public
    function  AddRef: TLMDEditorUtils;
    procedure Release(AReset: Boolean = False);
    property  IsReset: Boolean read FIsReset;

    procedure GetObjects(AResult: TList); virtual; abstract;
    procedure SetObjects(AObjects: TList); overload; virtual; abstract;
    procedure SetObjects(AObjects: array of TPersistent); overload;
    procedure MarkModified; overload; virtual; abstract;
    function  GetUniqueCompName(AComp: TComponent): TLMDString; virtual;
  end;

implementation

{ TLMDEditorUtils }

function TLMDEditorUtils.AddRef: TLMDEditorUtils;
begin
  Inc(FRefCounter);
  Result := Self;
end;

function TLMDEditorUtils.GetUniqueCompName(AComp: TComponent): TLMDString;
var
  ownr:   TComponent;
  i:      Integer;
  bsname: TLMDString;
begin
  bsname := AComp.ClassName;
  ownr   := AComp.Owner;

  if (Length(bsname) >= 2) and ((bsname[1] = 't') or (bsname[1] = 'T')) then
      bsname := Copy(bsname, 2, MaxInt);

  i := 0;
  repeat
    Inc(i);
    Result := Format('%s%d', [bsname, i]);
  until (ownr.FindComponent(Result) = nil);
end;

procedure TLMDEditorUtils.Release(AReset: Boolean);
begin
  if AReset then
    FIsReset := True;

  Dec(FRefCounter);
  if FRefCounter <= 0 then
    Free;
end;

procedure TLMDEditorUtils.SetObjects(AObjects: array of TPersistent);
var
  i:   Integer;
  list: TList;
begin
  list := TList.Create;
  try
    for i := 0 to High(AObjects) do
      list.Add(AObjects[i]);
    SetObjects(list);
  finally
    list.Free;
  end;
end;

end.
