unit pLMDPeX;
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

LMD-Tools Shared Property Editors (RM)
--------------------------------------
Centralized unit for all LMD 2007 shared property editors.

Changes
-------
Release 8.0 (August 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Windows, Classes, Sysutils, Dialogs, Graphics, TypInfo, Forms
  {$IFDEF LMDComp12}
  , LMDPNGImage, PNGImage
  {$endif}
  ;

type

  {small property editors or public ones}
  {****************************************************************************}
  {---------------- Property-Editor for HelpFile ------------------------------}
  TLMDHelpFileNameProperty = class (TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {LMD-Tools related objects}
  {****************************************************************************}
  {----------------------------------------------------------------------------}
  TLMDCustomImageListProperty = class(TComponentProperty)
  public
    function GetValue: string;override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value :string); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDImageListProperty = class(TComponentProperty)
  public
    function GetValue: string;override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value :string); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDWaveProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  {----------------------------------------------------------------------------}
  {$IFDEF LMDCOMP12}
  TLMDPNGImageProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value :string); override;
  end;
  {$ENDIF}

implementation
uses
  DesignConst, IStreams, StFilSys, ToolsApi,
  Consts, StdCtrls, ExtCtrls,
  LMDCont, LMDCustomImageList, pLMDPeCst, LMDWave,
  pLMDDsgnCPGetX;

{********************HelpFileNameProperty**************************************}
{------------------- THelpFileNameProperty ------------------------------------}
function TLMDHelpFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog];
end;

{------------------------------------------------------------------------------}
Procedure TLMDHelpFileNameProperty.Edit;
var
  OpenDialog:TOpenDialog;

  begin
    OpenDialog := TOpenDialog.Create(nil);
    with opendialog do
      try
         filter:=IDS_HELPFILTER;
         title:=IDS_HELPTITLE;
         options:=[ofHideReadOnly,ofExtensionDifferent,ofPathMustExist,ofFileMustExist];
         defaultext:='hlp';filename:=GetStrValue;
         if execute then SetStrValue(filename);
      finally
        Free;
      end;
  end;

{LMD-Tools related objects}
{******************************************************************************}
{******************************************************************************}

{********************* TLMDCustomImageListProperty ****************************}
{------------------------------------------------------------------------------}
function TLMDCustomImageListProperty.GetValue: string;
begin
  if LMDContainer.BitmapList=TLMDCustomImageList(GetOrdValue) then
    result:=LMD_ICGLOBALBML
  else if LMDContainer.ImageList=TLMDCustomImageList(GetOrdValue) then
    result:=LMD_ICGLOBALIML
  else
    result:=inherited GetValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListProperty.GetValues(Proc: TGetStrProc);
begin
  Proc(LMD_ICGLOBALBML);
  Proc(LMD_ICGLOBALIML);

  inherited GetValues(Proc);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListProperty.SetValue(const Value: string);
begin
  if Value=LMD_ICGLOBALBML then
    SetOrdValue(LongInt(LMDContainer.BitmapList))
  else if Value=LMD_ICGLOBALIML then
    SetOrdValue(LongInt(LMDContainer.ImageList))
  else
    inherited SetValue(Value);
end;

{********************* TLMDImageListProperty **********************************}
{------------------------------------------------------------------------------}
function TLMDImageListProperty.GetValue: string;
begin
  if LMDContainer.ImageList=TLMDCustomImageList(GetOrdValue) then
    result:=LMD_ICGLOBALIML
  else
    result:=inherited GetValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListProperty.GetValues(Proc: TGetStrProc);
begin
  Proc(LMD_ICGLOBALIML);
  inherited GetValues(Proc);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListProperty.SetValue(const Value: string);
begin
  if Value=LMD_ICGLOBALIML then
    SetOrdValue(LongInt(LMDContainer.ImageList))
  else
    inherited SetValue(Value);
end;

{********************* Class TLMDWaveProperty *********************************}
{------------------------------------------------------------------------------}
procedure TLMDWaveProperty.Edit;
var
  tmp:TLMDWave;
begin
  tmp:=TLMDWave.Create;
  try
    tmp.Assign(TLMDWave(Pointer(GetOrdValue)));
    if LMDCPGetWave(tmp) then
      SetOrdValue(Longint(Pointer(tmp)));
  finally
    tmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDWaveProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end;

{------------------------------------------------------------------------------}
function TLMDWaveProperty.GetValue: string;
var
  uWave: TLMDWave;
begin
  uWave:=TLMDWAVE(GetOrdValue);
  if uWave.Empty then
    Result := srNone
  else
    Result := '('+uwave.classname+')';
end;

{********************* Class TLMDPNGImageProperty *********************************}
{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}

procedure TLMDPNGImageProperty.Edit;
var
  aGlyph: TLMDPNGObject;
begin
  aGlyph := TLMDPNGObject.Create;
  try
    aGlyph.Assign(TLMDPNGObject(Pointer(GetOrdValue)));
    if LMDCPGetPNG(aGlyph) then
      SetOrdValue(Longint(Pointer(aGlyph)))
    else
      SetOrdValue(0);
  finally
    aGlyph.Free;
  end;
end;


{------------------------------------------------------------------------------}
function TLMDPNGImageProperty.GetValue: string;
var
  aPng: TLMDPNGObject;
begin
  aPng := TLMDPNGObject(GetOrdValue);
  if not Assigned(aPng) or aPng.Empty then
    Result := srNone
  else
    Result := '('+aPng.classname+')';
end;

{------------------------------------------------------------------------------}
procedure TLMDPNGImageProperty.SetValue(const Value: string);
begin
  if Value='' then
    SetOrdValue(0)
  else
    inherited SetValue(Value);
end;

{------------------------------------------------------------------------------}
function TLMDPNGImageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;
{$ENDIF}

end.

