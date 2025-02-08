unit pLMDCEX;
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

LMD-Tools Shared(X) Component Editors (RM)
------------------------------------------
Centralized unit for LMD Shared component editors (suitable for both LMD-Tools
and LMD ElPack).

Changes
-------
Release 8.0 (December 2006)
 - Initial Release

###############################################################################}

interface
uses
  DesignIntf, DesignEditors, VCLEditors, DesignMenus,
  Classes, Sysutils, Dialogs, TypInfo, Graphics, Forms, Buttons, ExtCtrls, StdCtrls,
  Controls, Messages, Menus, ComCtrls,

  LMDClass, LMDCont;

type
  {----------------------------------------------------------------------------}
  TLMDBitmapListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDContainerComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {*********************** TLMDDlgEditor **************************************}
  TLMDDlgEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDFormComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer);override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDGenericListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDGraphicListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDImageListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDPNGImageListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;
  {----------------------------------------------------------------------------}
  TLMDStringListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDWaveListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation
uses
  Types, LMDPNGImageList,
  pLMDDsgnCPGetX, pLMDCPGetBase,
  LMDGenericList, LMDGraphicList, LMDBitmapList, LMDStringList,
  LMDWaveList, LMDImageList, LMDFormPersistent, LMDBrowseDlg, LMDVistaDialogs,
  pLMDExtImageListEditorDlg;

{********************* Class TLMDBitmapListEditor *****************************}
{------------------------------------------------------------------------------}
procedure TLMDBitmapListEditor.ExecuteVerb(Index: Integer);
begin
  if LMDCPGetBitmapList(TLMDBitmapList(Component)) then Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDBitmapListEditor.GetVerb(Index: Integer): string;
begin
  Result := 'BitmapList-Editor';
end;

{------------------------------------------------------------------------------}
function TLMDBitmapListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDContainerComponentEditor *********************}
{------------------------------------------------------------------------------}
procedure TLMDContainerComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDContainerCtrl(Component) do
    case Index of
      0:if not LMDCPGetBitmapList(Container.BitmapList) then exit;
      1:if not LMDCPGetImageList(Container.ImageList) then exit;
      2:if not LMDCPGetStringList(Container.StringList) then exit;
      3:if not LMDCPGetWaveList(Container.WaveList) then exit;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDContainerComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='BitmapList';
    1:result:='ImageList';
    2:result:='StringList';
    3:result:='WaveList';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDContainerComponentEditor.GetVerbCount: Integer;
begin
  Result:=4;
end;

{********************* Class TLMDDlgEditor *************************************}
{------------------------------------------------------------------------------}
procedure TLMDDlgEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0 : begin  // for VCL.NET no "hard" typecasting
          if Component is TOpenDialog then
            TOpenDialog(Component).Execute;
          if Component is TLMDBrowseDlg then
            TLMDBrowseDlg(Component).Execute;
          if Component is TLMDCustomFileDialog then
            TLMDCustomFileDialog(Component).Execute;
        end;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDDlgEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result:='Test Dialog...';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDDlgEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDFormComponentEditor **************************}
{------------------------------------------------------------------------------}
procedure TLMDFormComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDFormPersistent(Component), TForm(Component.Owner) do
    case Index of
      0:Enabled:=not Enabled;
      1: if WindowState=wsMinimized then exit else SetMaximizedRect(Types.Rect(Left, Top, Width, Height));
      2: if WindowState=wsMinimized then exit else SetTrackMaxValues(Types.Point(Width, Height));
      3: if WindowState=wsMinimized then exit else SetTrackMinValues(Types.Point(Width, Height));
      4:begin
          SetMaximizedRect(Types.Rect(0,0,0,0));
          SetTrackMaxValues(Types.Point(0,0));
          SetTrackMinValues(Types.Point(0,0));
        end;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDFormComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0:result:='Enabled' + BoolStr[TLMDFormPersistent(Component).Enabled];
    1:result:='Set maximized values';
    2:result:='Set TrackMaxWidth + Height';
    3:result:='Set TrackMinWidth + Height';
    4:result:='Reset';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFormComponentEditor.GetVerbCount: Integer;
begin
  Result:=5;
end;

{********************* Class TLMDGenericListEditor *****************************}
{------------------------------------------------------------------------------}
procedure TLMDGenericListEditor.ExecuteVerb(Index: Integer);
begin
  if LMDCPGetGenericList(TLMDGenericList(Component)) then Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDGenericListEditor.GetVerb(Index: Integer): string;
begin
  Result:='Editor';
end;

{------------------------------------------------------------------------------}
function TLMDGenericListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDGraphicListEditor *****************************}
{------------------------------------------------------------------------------}
procedure TLMDGraphicListEditor.ExecuteVerb(Index: Integer);
begin
  if LMDCPEditGraphicList(TLMDGraphicList(Component)) then Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDGraphicListEditor.GetVerb(Index: Integer): string;
begin
  Result := 'GraphicList-Editor';
end;

{------------------------------------------------------------------------------}
function TLMDGraphicListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDImageListEditor ******************************}
{------------------------------------------------------------------------------}
procedure TLMDImageListEditor.ExecuteVerb(Index: Integer);
begin
  if LMDCPGetImageList(TLMDImageList(Component)) then Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDImageListEditor.GetVerb(Index: Integer): string;
begin
  Result:='Editor';
end;

{------------------------------------------------------------------------------}
function TLMDImageListEditor.GetVerbCount: Integer;
begin
  Result:=1;
end;

{********************* Class TLMDPNGImageListEditor *****************************}
{------------------------------------------------------------------------------}
procedure TLMDPNGImageListEditor.ExecuteVerb(Index: Integer);
begin
  if LMDCPEditPngList(TLMDPNGImageList(Component)) then Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDPNGImageListEditor.GetVerb(Index: Integer): string;
begin
  Result := 'PNGImageList-Editor';
end;

{------------------------------------------------------------------------------}
function TLMDPNGImageListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDStringListEditor *****************************}
{------------------------------------------------------------------------------}
procedure TLMDStringListEditor.ExecuteVerb(Index: Integer);
begin
  if LMDCPGetStringList(TLMDStringList(Component)) then Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDStringListEditor.GetVerb(Index: Integer): string;
begin
  Result:='Editor';
end;

{------------------------------------------------------------------------------}
function TLMDStringListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDWaveListEditor *********************************}
{------------------------------------------------------------------------------}
procedure TLMDWaveListEditor.ExecuteVerb(Index: Integer);
begin
  if LMDCPGetWaveList(TLMDWaveList(Component)) then Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDWaveListEditor.GetVerb(Index: Integer): string;
begin
  Result := 'WaveList-Editor' ;
end;

{------------------------------------------------------------------------------}
function TLMDWaveListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.

