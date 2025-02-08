unit LMDIdeObjEditors;
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

LMDIdeObjEditors unit (YB)
--------------------------
Standard object editors unit.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, Menus, ActnList, ComCtrls,
  intfLMDBase, LMDTypes, LMDStrings, LMDSvcPvdr, LMDIdeCst, LMDIdeClass,
  LMDIdeObjEdrMgr, LMDInsEditorWnds, LMDInsEditorUtils;

type
  { ************************* TLMDCollectionObjEditor ************************ }

  TLMDCollectionObjEditor = class(TLMDObjectEditor)
  public
    function  GetVerbCount: Integer; override;
    function  GetVerb(AIndex: Integer): TLMDString; override;
    procedure ExecuteVerb(AIndex: Integer); override;
  end;

  { **************************** TLMDMenuObjEditor *************************** }

  TLMDMenuObjEditor = class(TLMDObjectEditor)
  public
    function  GetVerbCount: Integer; override;
    function  GetVerb(AIndex: Integer): TLMDString; override;
    procedure ExecuteVerb(AIndex: Integer); override;
  end;

  { ************************* TLMDActionListObjEditor ************************ }

  TLMDActionListObjEditor = class(TLMDObjectEditor)
  public
    function  GetVerbCount: Integer; override;
    function  GetVerb(AIndex: Integer): TLMDString; override;
    procedure ExecuteVerb(AIndex: Integer); override;
  end;

  { ************************ TLMDPageControlObjEditor ************************ }

  TLMDPageControlObjEditor = class(TLMDObjectEditor)
  public
    function  GetVerbCount: Integer; override;
    function  GetVerb(AIndex: Integer): TLMDString; override;
    procedure ExecuteVerb(AIndex: Integer); override;
  end;

implementation

uses
  LMDInsCollectionEditor, LMDInsMenuEditor, LMDIdeActListEditor;

procedure TLMDMenuObjEditor.ExecuteVerb(AIndex: Integer);
var
  item: TMenuItem;
  cbs:  TLMDEditorWindowCallbacks;
begin
  if Instance is TMenu then
  begin
    item := TMenu(Instance).Items;
    if CreateEditorWndCbs(item, cbs) then
      TLMDMenuEditorDialog.OpenEditor(cbs, item);
  end;
end;

function TLMDMenuObjEditor.GetVerb(AIndex: Integer): TLMDString;
begin
  Result := 'Menu Designer...';
end;

function TLMDMenuObjEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TLMDActionListObjEditor }

procedure TLMDActionListObjEditor.ExecuteVerb(AIndex: Integer);
var
  actlst: TActionList;
  cbs:    TLMDEditorWindowCallbacks;
begin
  if Instance is TActionList then
  begin
    actlst := TActionList(Instance);
    if CreateEditorWndCbs(actlst, cbs) then
      TLMDActionListEditorDialog.OpenEditor(cbs, actlst);
  end;
end;

function TLMDActionListObjEditor.GetVerb(AIndex: Integer): TLMDString;
begin
  Result := 'Action List Editor...';
end;

function TLMDActionListObjEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TLMDCollectionObjEditor }

procedure TLMDCollectionObjEditor.ExecuteVerb(AIndex: Integer);
var
  coll: TCollection;
  cbs:  TLMDEditorWindowCallbacks;
begin
  if Instance is TCollection then
  begin
    coll := Instance as TCollection;
    if CreateEditorWndCbs(coll, cbs) then
      TLMDCollectionEditorDialog.OpenEditor(cbs, coll);
  end;
end;

function TLMDCollectionObjEditor.GetVerb(AIndex: Integer): TLMDString;
begin
  Result := 'Collection Editor...';
end;

function TLMDCollectionObjEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TLMDPageControlObjEditor }

procedure TLMDPageControlObjEditor.ExecuteVerb(AIndex: Integer);
var
  control: TPageControl;
  pg:      TTabSheet;
  idx:     Integer;
begin
  if Instance is TTabSheet then
    control := TTabSheet(Instance).PageControl
  else
    control := Instance as TPageControl;

  case AIndex of
    0:  begin
          pg := TTabSheet.Create(control.Owner);
          pg.PageControl      := control;
          control.ActivePage  := pg;
        end;
    1:  if control.PageCount >= 2 then
        begin
          if control.ActivePage <> nil then
            idx := control.ActivePage.TabIndex
          else
            idx := -1;

          Inc(idx);
          if idx >= control.PageCount then // Loop back.
            idx := 0;                      //

          control.ActivePage := control.Pages[idx];
        end;
    2:  if control.PageCount >= 2 then
        begin
          if control.ActivePage <> nil then
            idx := control.ActivePage.TabIndex
          else
            idx := control.PageCount;

          Dec(idx);
          if idx < 0 then                  // Loop back.
            idx := control.PageCount - 1;  //

          control.ActivePage := control.Pages[idx];
        end;
    3:  begin
          if control.ActivePage <> nil then
            control.ActivePage.Free;
        end;
  else
    Assert(False);
  end;

  if control.ActivePage <> nil then
    SetObjects([control.ActivePage]);
  Changed;
end;

function TLMDPageControlObjEditor.GetVerb(AIndex: Integer): TLMDString;
begin
  case AIndex of
    0: Result := 'New page';
    1: Result := 'Next page';
    2: Result := 'Previous page';
    3: Result := 'Delete page';
  else
    Assert(False);
  end;
end;

function TLMDPageControlObjEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

end.
