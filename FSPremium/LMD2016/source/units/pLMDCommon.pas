unit pLMDCommon;
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

LMD-Tools common designtime services unit (RM)
---------------------------------------------
Common routines for all Packs / used at Designtime

Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Classes, Controls, Graphics, Stdctrls;

const
  sLMDCategoryName = 'LMD-Tools'; // do not localize

type
  TLMDDsgnGlobalEditorOption=(geoBrushEditor,
                              geoCaptionEditor,
                              geoHintEditor,
                              geoHotKeyEditor,
                              geoStringEditor,
                              geoFontOI,
                              geoBooleanOI,
                              geoSetOI,
                              geoWideStringEditor);
  TLMDDsgnGlobalEditorOptions=set of TLMDDsgnGlobalEditorOption;

  TLMDToolsEditorOption = (leoInstallLabeledControls,
                           leoInstallDesignEditorControls,
                           leoInstallScriptPackImporter);
  TLMDToolsEditorOptions = set of TLMDToolsEditorOption;

var
  LMDGLOBALEDITOROPTIONS: TLMDDsgnGlobalEditorOptions;
  LMDTOOLSEDITOROPTIONS:  TLMDToolsEditorOptions;

// Helper Routine to load JPEG from Resource
procedure LMDDsgnGetJPEGResource(Instance:THandle; const aName: string; aPicture: TPicture);
procedure LMDDsgnRefreshOptions;

// Load/save custom color list in Delphi/CBuilder IDE
procedure LMDComLoadDelphiCustomColor(aList:TStrings);
procedure LMDComSaveDelphiCustomColor(aList:TStrings);

implementation
uses
  Consts, SysUtils, Registry, LMDRtlConst,
  pLMDCPGetBase, pLMDCst, LMDBitmap, LMDTypes;

{------------------------------------------------------------------------------}
function LMDDsgnIntToOptions(const aValue:Integer):TLMDDsgnGlobalEditorOptions;
var
  i:Integer;
begin
  result:=[];
  for i:=0 to Ord(High(TLMDDsgnGlobalEditorOption)) do
    if aValue and (1 shl i)=(1 shl i) then
      Include(result, TLMDDsgnGlobalEditorOption(i));
end;

{------------------------------------------------------------------------------}
function LMDDsgnGetOptions:TLMDDsgnGlobalEditorOptions;
begin
  result:=[];
  with TRegIniFile.Create(LMDTOOLS_REGISTRYPATH) do
    try
      result:=LMDDsgnIntToOptions(ReadInteger('Shared', 'EditorOptions', LMDPE_DEFSHAREDOPTIONS));
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
function LMDToolsIntToOptions(const aValue:Integer):TLMDToolsEditorOptions;
var
  i:Integer;
begin
  result:=[];
  for i:=0 to Ord(High(TLMDToolsEditorOption)) do
    if aValue and (1 shl i)=(1 shl i) then
      Include(result, TLMDToolsEditorOption(i));
end;

{------------------------------------------------------------------------------}
function LMDToolsGetOptions:TLMDToolsEditorOptions;
begin
  result:=[];
  with TRegIniFile.Create(LMDTOOLS_REGISTRYPATH) do
    try
      result := LMDToolsIntToOptions(ReadInteger('Shared', 'LMDOptions', LMDPE_DEFLMDTOOLSOPTIONS));
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDDsgnRefreshOptions;
begin
  LMDTOOLSEDITOROPTIONS := LMDToolsGetOptions;
  LMDGLOBALEDITOROPTIONS := LMDDsgnGetOptions;
end;

{------------------------------------------------------------------------------}
procedure LMDDsgnGetJPEGResource(Instance:THandle; const aName: string;
  aPicture: TPicture);
var
  jpg:TLMDBitmap;
  Res:TResourceStream;
  begin

  Res:=TResourceStream.Create(Instance, aName, 'JPEG');
  // Found an entry?
  if Res.Size>0 then
    try
      jpg:=TLMDBitmap.Create;
      try
        jpg.LoadFromStream(res);
        aPicture.Assign(jpg);
      finally
        jpg.Free;
      end;
    finally
      Res.Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDComLoadDelphiCustomColor(aList:TStrings);
var
  tmp:TRegIniFile;
begin
  tmp:=TRegIniFile.Create(LMDTOOLS_REGISTRYPATH+'\Shared');
  try
    LMDComLoadCustomColorList(tmp, SCustomColors, aList);
  finally
    tmp.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDComSaveDelphiCustomColor(aList:TStrings);
var
  tmp:TRegIniFile;
begin
  tmp:=TRegIniFile.Create(LMDTOOLS_REGISTRYPATH+'\Shared');
  try
    LMDComSaveCustomColorList(tmp, SCustomColors, aList);
  finally
    tmp.Free;
  end;
end;

initialization
  LMDDsgnRefreshOptions;
end.
