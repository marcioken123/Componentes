unit ElSysMenu;
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

ElSysMenu unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  SysUtils;

//procedure ElCallSysEditMenu(const Handle, X, Y: integer);
//procedure ElCallSysWhatIsMenu(const Handle, X, Y: integer);
procedure ElCallSysMenu(const IDOfMenu, Handle, X, Y: integer);

var
  ElWhatIsMenu,
  ElEditMenu,
  ElSysWindowMenu,
  ElMDIWindowMenu: integer;

implementation

{$warnings off}
function LoadLibrary16(LibraryName: PChar): THandle; stdcall; external kernel32 index 35;
procedure FreeLibrary16(HInstance: THandle); stdcall; external kernel32 index 36;
{$warnings on}

procedure ElCallSysMenu(const IDOfMenu, Handle, X, Y: integer);
var
  SysMenu: HMENU;
  h: THandle;
begin
  if IsWinNTUp then
  begin
    h := GetModuleHandle(PChar('user32.dll'));
    SysMenu := LoadMenu(h, MAKEINTRESOURCE(IDOfMenu));
  end
  else
  begin
    h := LoadLibrary16(PChar('user.exe'));
    SysMenu := LoadMenu(h, MAKEINTRESOURCE(IDOfMenu));
    FreeLibrary16(h);
  end;
  try
    TrackPopupMenu(GetSubMenu(SysMenu, 0), TPM_LEFTALIGN or TPM_RIGHTBUTTON, X, Y, 0, Handle, nil);
  finally
    DestroyMenu(SysMenu);
  end;
end;

begin
  ElWhatIsMenu := 4;
  if IsWinNTUp then
  begin
    ElEditMenu := 1;
    ElSysWindowMenu := 16;
    ElMDIWindowMenu := 32;
  end
  else
  begin
    ElEditMenu := 3;
    ElSysWindowMenu := 1;
    ElMDIWindowMenu := 2;
  end;
end.
