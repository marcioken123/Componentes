unit LMDIdeSprigs;
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

LMDIdeCompTree unit (YB)
------------------------
Standard sprigs unit.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, Graphics, ComCtrls,
  ImgList, intfLMDBase, LMDTypes, LMDSvcPvdr, LMDIdeCst, LMDIdeClass,
  LMDIdeCompTree;

type
  {**************************** TLMDComponentSprig ****************************}

  TLMDComponentSprig = class(TLMDSprig)
  protected
    function  GetDisplayName: TLMDString; override;
    function  GetImageKind: TLMDSprigImageKind; override;
  end;

  {**************************** TLMDCollectionSprig ***************************}

  TLMDCollectionSprig = class(TLMDSprig)
  protected
    function  GetDisplayName: TLMDString; override;
    procedure CreateChildren(AGetEditorClassProc: TLMDGetSprigClassProc); override;
    function  GetImageKind: TLMDSprigImageKind; override;
  end;

  {************************* TLMDCollectionItemSprig **************************}

  TLMDCollectionItemSprig = class(TLMDSprig)
  protected
    function GetDisplayName: TLMDString; override;
  end;

  {*************************** TLMDControlSprig *******************************}

  TLMDControlSprig = class(TLMDComponentSprig)
  protected
    function GetImageKind: TLMDSprigImageKind; override;
  end;

  {************************** TLMDWinControlSprig *****************************}

  TLMDWinControlSprig = class(TLMDControlSprig)
  protected
    function GetImageKind: TLMDSprigImageKind; override;
  end;

  {************************* TLMDRootControlSprig *****************************}

  TLMDRootControlSprig = class(TLMDWinControlSprig)
  protected
    procedure CreateChildren(AGetEditorClassProc: TLMDGetSprigClassProc); override;
  end;

  {***************************** TLMDFormSprig ********************************}

  TLMDFormSprig = class(TLMDRootControlSprig)
  protected
    function GetImageKind: TLMDSprigImageKind; override;
  end;

  {**************************** TLMDFrameSprig ********************************}

  TLMDFrameSprig = class(TLMDRootControlSprig)
  end;

implementation

{***************************** TLMDComponentSprig *****************************}
{------------------------------------------------------------------------------}

function TLMDComponentSprig.GetDisplayName: TLMDString;
begin
  if Instance <> nil then
  begin
    Result := TComponent(Instance).Name;
    if Result = '' then
      Result := Format(SLMDUnnamedComponent,
                       [TComponent(Instance).ComponentIndex]);
  end
  else
    Result := inherited GetDisplayName;
end;

{------------------------------------------------------------------------------}

function TLMDComponentSprig.GetImageKind: TLMDSprigImageKind;
begin
  Result := sikComponent;
end;

{***************************** TLMDCollectionSprig ****************************}
{------------------------------------------------------------------------------}

function TLMDCollectionSprig.GetDisplayName: TLMDString;
begin
  Result := PropName;
end;

{------------------------------------------------------------------------------}

procedure TLMDCollectionSprig.CreateChildren(
  AGetEditorClassProc: TLMDGetSprigClassProc);
var
  i:    Integer;
  item: TCollectionItem;
  scls: TLMDSprigClass;
begin
  inherited;

  if Instance is TCollection then
    for i := 0 to TCollection(Instance).Count - 1 do
    begin
      item := TCollection(Instance).Items[i];

      if Tree.FindSprig(item) = nil then
      begin
        AGetEditorClassProc(item, scls);
        scls.Create(Tree, Self, item);
      end;
    end;
end;

{------------------------------------------------------------------------------}

function TLMDCollectionSprig.GetImageKind: TLMDSprigImageKind;
begin
  Result := sikCollection;
end;

{************************** TLMDCollectionItemSprig ***************************}
{------------------------------------------------------------------------------}

function TLMDCollectionItemSprig.GetDisplayName: TLMDString;
var
  idx: Integer;
begin
  idx    := TCollectionItem(Instance).Index;
  Result := IntToStr(idx) + ' - ' + TCollectionItem(Instance).DisplayName;
end;

{**************************** TLMDControlSprig ********************************}
{------------------------------------------------------------------------------}

function TLMDControlSprig.GetImageKind: TLMDSprigImageKind;
begin
  Result := sikControl;
end;

{*************************** TLMDWinControlSprig ******************************}
{------------------------------------------------------------------------------}

function TLMDWinControlSprig.GetImageKind: TLMDSprigImageKind;
begin
  Result := sikWinControl;
  if (Instance is TWinControl) and
     (csAcceptsControls in TWinControl(Instance).ControlStyle) then
    Result := sikContainer;
end;

{*************************** TLMDRootControlSprig *****************************}
{------------------------------------------------------------------------------}

procedure TLMDRootControlSprig.CreateChildren(
  AGetEditorClassProc: TLMDGetSprigClassProc);
var
  i:    Integer;
  comp: TComponent;
  scls: TLMDSprigClass;
begin
  inherited;

  if Instance is TWinControl then
    for i := 0 to TWinControl(Instance).ComponentCount - 1 do
    begin
      comp := TWinControl(Instance).Components[i];

      if not (csDestroying in comp.ComponentState) and
         (Tree.FindSprig(comp) = nil) then
      begin
        AGetEditorClassProc(comp, scls);
        scls.Create(Tree, Self, comp);
      end;
    end;
end;

{****************************** TLMDFormSprig *********************************}
{------------------------------------------------------------------------------}

function TLMDFormSprig.GetImageKind: TLMDSprigImageKind;
begin
  Result := sikForm;
end;

{------------------------------------------------------------------------------}

end.
