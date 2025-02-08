unit LMDIdeProjNodes;
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

LMDIdeProjNodes unit (YB)
-------------------------
Built-in project manager nodes.

Changes
-------

###############################################################################}

interface

uses
  Windows, Classes, Controls, SysUtils, Graphics, Menus, intfLMDBase, LMDTypes,
  LMDStrings, LMDSvcPvdr, LMDXML, LMDIdeClass, LMDIdeProjMgr;

type
  {**************************** TLMDScriptUnit ********************************}

  TLMDScriptUnit = class(TLMDProjDocument)
  protected
    procedure DrawImage(ACanvas: TCanvas; const ARect: TRect); override;
    procedure DoRead(AElem: ILMDXmlElement; AIsParentXml: Boolean); override;
    procedure DoWrite(AElem: ILMDXmlElement; AIsParentXml: Boolean); override;
    procedure DoLoad(const AFilePath: TLMDString); override;
    procedure DoSave(const AFilePath: TLMDString); override;
    function  DoOpenFileStream(const AFileIdent: TLMDString): TStream; override;
    function  DoGetDefaultBaseName: TLMDString; override;
    function  DoGetFileExt: TLMDString; override;
  end;

  {**************************** TLMDScriptForm ********************************}

  TLMDScriptFormForm = class(TLMDProjNode)
  protected
    function  DoGetDisplayName: TLMDString; override;
    procedure DrawImage(ACanvas: TCanvas; const ARect: TRect); override;
  end;

  TLMDScriptForm = class(TLMDScriptUnit)
  private
    FFormName: TLMDString;
    procedure SetFormName(const Value: TLMDString);
  protected
    procedure DrawImage(ACanvas: TCanvas; const ARect: TRect); override;
    procedure DoRead(AElem: ILMDXmlElement; AIsParentXml: Boolean); override;
    procedure DoWrite(AElem: ILMDXmlElement; AIsParentXml: Boolean); override;
    procedure DoLoad(const AFilePath: TLMDString); override;
    procedure DoSave(const AFilePath: TLMDString); override;
    function  DoOpenFileStream(const AFileIdent: TLMDString): TStream; override;
  public
    constructor Create(AProjMgr: TLMDProjectManager; AParent: TLMDProjNode); override;

    property FormName: TLMDString read FFormName write SetFormName; // Should be maintained
                                                                    // by document editor.
  end;

  {*************************** TLMDScriptProject ******************************}

  TLMDScriptProject = class(TLMDProjDocument)
  private
    FLanguageName: TLMDString;
  protected
    procedure DrawImage(ACanvas: TCanvas; const ARect: TRect); override;
    procedure DoRead(AElem: ILMDXmlElement; AIsParentXml: Boolean); override;
    procedure DoWrite(AElem: ILMDXmlElement; AIsParentXml: Boolean); override;
    procedure DoLoad(const AFilePath: TLMDString); override;
    procedure DoSave(const AFilePath: TLMDString); override;
    function  DoGetDefaultBaseName: TLMDString; override;
    function  DoGetFileExt: TLMDString; override;
  public
    property LanguageName: TLMDString read FLanguageName write FLanguageName;
  end;

procedure LMDRegisterStandardNodes(AProjMgr: TLMDProjectManager);

implementation

var
  NodeImages:          TImageList;
  ProjImageIndex,
  UnitImageIndex,
  FormImageIndex,
  FormFormImageIndex:  Integer;

procedure InitNodeImages;

  function _AddBitmap(const AResName: string): Integer;
  var
    bmp:  TBitmap;
    mask: TBitmap;
  begin
    bmp  := TBitmap.Create;
    mask := TBitmap.Create;
    try
      bmp.Transparent := True;
      bmp.LoadFromResourceName(HInstance, AResName);

      mask.Assign(bmp);
      mask.Mask(mask.Canvas.Pixels[0, 0]);

      Result := NodeImages.Add(bmp, mask);
    finally
      bmp.Free;
      mask.Free;
    end;
  end;

begin
  NodeImages := TImageList.Create(nil);
  try
    ProjImageIndex     := _AddBitmap('LMD_PROJPROJECT');
    UnitImageIndex     := _AddBitmap('LMD_PROJUNIT');
    FormImageIndex     := _AddBitmap('LMD_PROJFORM');
    FormFormImageIndex := _AddBitmap('LMD_PROJFORMFORM');
  except
    NodeImages.Free;
    NodeImages := nil;
    raise;
  end;
end;

{------------------------------------------------------------------------------}

procedure LMDRegisterStandardNodes(AProjMgr: TLMDProjectManager);
begin
  AProjMgr.RegisterNodeClass(TLMDScriptUnit);
  AProjMgr.RegisterNodeClass(TLMDScriptForm);
  AProjMgr.RegisterNodeClass(TLMDScriptProject);
end;

{***************************** TLMDScriptUnit *********************************}
{------------------------------------------------------------------------------}

procedure TLMDScriptUnit.DoRead(AElem: ILMDXmlElement; AIsParentXml: Boolean);
var
  filepath: TLMDString;
begin
  Assert(AIsParentXml, 'Script unit have no self XML.');

  filepath := MakeFullFilePath(AElem.GetAttr('path'));
  Load(filepath);
end;
                  
{------------------------------------------------------------------------------}

procedure TLMDScriptUnit.DoWrite(AElem: ILMDXmlElement; AIsParentXml: Boolean);
begin
  Assert(AIsParentXml, 'Script unit have no self XML.');

  Save; // Save before, to get valid filepath.
  AElem.SetAttr('path', GetRelativeFilePath);
end;
                
{------------------------------------------------------------------------------}

procedure TLMDScriptUnit.DoLoad(const AFilePath: TLMDString);
begin
  // Do nothing.
  // Do not call inherited.
end;
           
{------------------------------------------------------------------------------}

procedure TLMDScriptUnit.DoSave(const AFilePath: TLMDString);
begin
  SaveAssociatedFile('code', AFilePath, FilePath);
end;
         
{------------------------------------------------------------------------------}

function TLMDScriptUnit.DoOpenFileStream(
  const AFileIdent: TLMDString): TStream;
begin
  if LMDSameText(AFileIdent, 'code') then
    Result := ProjMgr.CreateStream(FilePath, skRead)
  else
    Result := inherited DoOpenFileStream(AFileIdent);
end;
    
{------------------------------------------------------------------------------}

function TLMDScriptUnit.DoGetDefaultBaseName: TLMDString;
begin
  Result := 'Unit';
end;
    
{------------------------------------------------------------------------------}

function TLMDScriptUnit.DoGetFileExt: TLMDString;
begin
  Result := '.sct';
end;

{***************************** TLMDScriptForm *********************************}
{------------------------------------------------------------------------------}

procedure TLMDScriptForm.DoRead(AElem: ILMDXmlElement;
  AIsParentXml: Boolean);
var
  filepath: TLMDString;
begin
  Assert(AIsParentXml, 'Script form have no self XML.');

  filepath  := MakeFullFilePath(AElem.GetAttr('path'));
  FFormName := AElem.GetAttr('formname');
  Load(filepath);
end;
                
{------------------------------------------------------------------------------}

procedure TLMDScriptForm.DoWrite(AElem: ILMDXmlElement;
  AIsParentXml: Boolean);
begin
  Assert(AIsParentXml, 'Script form have no self XML.');

  Save; // Save before, to get valid filepath.
  AElem.SetAttr('path', GetRelativeFilePath);
  AElem.SetAttr('formname', FFormName);
end;
           
{------------------------------------------------------------------------------}

procedure TLMDScriptForm.DoLoad(const AFilePath: TLMDString);
begin
  // Do nothing.
  // Do not call inherited.
end;
        
{------------------------------------------------------------------------------}

procedure TLMDScriptForm.DoSave(const AFilePath: TLMDString);
begin
  SaveAssociatedFile('code', AFilePath, FilePath);
  SaveAssociatedFile('form', ChangeFileExt(AFilePath, '.sfm'),
                     ChangeFileExt(FilePath, '.sfm'));
end;
        
{------------------------------------------------------------------------------}

function TLMDScriptForm.DoOpenFileStream(
  const AFileIdent: TLMDString): TStream;
begin
  if LMDSameText(AFileIdent, 'form') then
    Result := ProjMgr.CreateStream(ChangeFileExt(FilePath, '.sfm'), skRead)
  else
    Result := inherited DoOpenFileStream(AFileIdent);
end;

{**************************** TLMDScriptProject *******************************}
{------------------------------------------------------------------------------}

procedure TLMDScriptProject.DoRead(AElem: ILMDXmlElement;
  AIsParentXml: Boolean);
begin
  FLanguageName := AElem.GetAttr('language');
  ReadChildren(AElem);
end;
              
{------------------------------------------------------------------------------}

procedure TLMDScriptProject.DoWrite(AElem: ILMDXmlElement;
  AIsParentXml: Boolean);
begin
  AElem.SetAttr('language', FLanguageName);
  WriteChildren(AElem);
end;
          
{------------------------------------------------------------------------------}

function TLMDScriptProject.DoGetDefaultBaseName: TLMDString;
begin
  Result := 'Project';
end;
         
{------------------------------------------------------------------------------}

function TLMDScriptProject.DoGetFileExt: TLMDString;
begin
  Result := '.xml';
end;
        
{------------------------------------------------------------------------------}

procedure TLMDScriptProject.DoLoad(const AFilePath: TLMDString);
begin
  LoadFromXml(AFilePath);
end;

procedure TLMDScriptProject.DoSave(const AFilePath: TLMDString);
begin
  SaveToXml(AFilePath);
end;

constructor TLMDScriptForm.Create(AProjMgr: TLMDProjectManager;
  AParent: TLMDProjNode);
begin
  inherited;
  TLMDScriptFormForm.Create(AProjMgr, Self);
end;

{ TLMDScriptFormForm }

function TLMDScriptFormForm.DoGetDisplayName: TLMDString;
begin
  Result := TLMDScriptForm(Parent).FormName;
end;

procedure TLMDScriptForm.SetFormName(const Value: TLMDString);
begin
  FFormName := Value;
  UpdateViews;
end;

procedure TLMDScriptUnit.DrawImage(ACanvas: TCanvas; const ARect: TRect);
begin
  NodeImages.Draw(ACanvas, ARect.Left, ARect.Top, UnitImageIndex);
end;

procedure TLMDScriptFormForm.DrawImage(ACanvas: TCanvas;
  const ARect: TRect);
begin
  NodeImages.Draw(ACanvas, ARect.Left, ARect.Top, FormFormImageIndex);
end;

procedure TLMDScriptProject.DrawImage(ACanvas: TCanvas;
  const ARect: TRect);
begin
  NodeImages.Draw(ACanvas, ARect.Left, ARect.Top, ProjImageIndex);
end;

procedure TLMDScriptForm.DrawImage(ACanvas: TCanvas; const ARect: TRect);
begin
  NodeImages.Draw(ACanvas, ARect.Left, ARect.Top, FormImageIndex);
end;

initialization
  InitNodeImages;
  TLMDScriptUnit.SetNodeClassIdent('scriptunit');
  TLMDScriptForm.SetNodeClassIdent('scriptform');
  TLMDScriptProject.SetNodeClassIdent('scriptproject');

{------------------------------------------------------------------------------}

finalization;
  NodeImages.Free;

{------------------------------------------------------------------------------}

end.
