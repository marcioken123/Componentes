unit LMDDebugUnit;

{###############################################################################

LMD VCL Series 2016
й by LMD Innovative
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

LMDDebugUnit unit (RM)
----------------------

Specifies routines for debug output

Within IDE, use Event Log for viewing messages (CTRL+ALT+V) Outside IDE use tool
like Dbgview.exe from sysinternals.com * LMD_DEBUG compilers switch must be enabled

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
{$I lmdcmps.inc}
interface

procedure LMDDebug(const Msg:string); overload;
procedure LMDDebug(const Fmt: string; Args: array of const); overload;

function LMDMessageToStr(const WM_Number: Integer): String;
function LMDWMCommandButtonNotify  (const CN_Number: Integer): String;
function LMDWMCommandListBoxNotify (const CN_Number: Integer): String;
function LMDWMCommandComboBoxNotify(const CN_Number: Integer): String;
function LMDWMCommandEditNotify    (const CN_Number: Integer): String;

function LMDWindowsStyleToString(AStyle: Cardinal): string;
function LMDWindowExStyleToString(AExStyle: Cardinal): String;

implementation
uses
  Windows, Messages, Controls, SysUtils;

{------------------------------------------------------------------------------}
procedure LMDDebug(const Fmt: string; Args: array of const);
{$IFDEF LMD_DEBUG}
var
  Msg: string;
{$ENDIF}
begin
  {$IFDEF LMD_DEBUG}
   Msg:=Format(Fmt, Args);
   Windows.OutputDebugString(PChar(Msg));
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure LMDDebug(const Msg: string);
begin
  {$IFDEF LMD_DEBUG}
  OutputDebugString(PChar(Msg));
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDMessageToStr(const WM_Number:Integer): String;
begin
  Result:='';
  case WM_Number of
    { Basic Windows Messages }
    WM_NULL                   : Result := 'WM_NULL';
    WM_CREATE                 : Result := 'WM_CREATE';
    WM_DESTROY                : Result := 'WM_DESTROY';
    WM_MOVE                   : Result := 'WM_MOVE';
    WM_SIZE                   : Result := 'WM_SIZE';
    WM_ACTIVATE               : Result := 'WM_ACTIVATE';
    WM_SETFOCUS               : Result := 'WM_SETFOCUS';
    WM_KILLFOCUS              : Result := 'WM_KILLFOCUS';
    WM_ENABLE                 : Result := 'WM_ENABLE';
    WM_SETREDRAW              : Result := 'WM_SETREDRAW';
    WM_SETTEXT                : Result := 'WM_SETTEXT';
    WM_GETTEXT                : Result := 'WM_GETTEXT';
    WM_GETTEXTLENGTH          : Result := 'WM_GETTEXTLENGTH';
    WM_PAINT                  : Result := 'WM_PAINT';
    WM_CLOSE                  : Result := 'WM_CLOSE';
    WM_QUERYENDSESSION        : Result := 'WM_QUERYENDSESSION';
    WM_QUIT                   : Result := 'WM_QUIT';
    WM_QUERYOPEN              : Result := 'WM_QUERYOPEN';
    WM_ERASEBKGND             : Result := 'WM_ERASEBKGND';
    WM_SYSCOLORCHANGE         : Result := 'WM_SYSCOLORCHANGE';
    WM_ENDSESSION             : Result := 'WM_ENDSESSION';
    WM_SYSTEMERROR            : Result := 'WM_SYSTEMERROR';
    WM_SHOWWINDOW             : Result := 'WM_SHOWWINDOW';
    WM_CTLCOLOR               : Result := 'WM_CTLCOLOR';
    // WM_WININICHANGE           : Result := 'WM_WININICHANGE'; // Устаревший WM_SETTINGCHANGE
    WM_SETTINGCHANGE          : Result := 'WM_SETTINGCHANGE';
    WM_DEVMODECHANGE          : Result := 'WM_DEVMODECHANGE';
    WM_ACTIVATEAPP            : Result := 'WM_ACTIVATEAPP';
    WM_FONTCHANGE             : Result := 'WM_FONTCHANGE';
    WM_TIMECHANGE             : Result := 'WM_TIMECHANGE';
    WM_CANCELMODE             : Result := 'WM_CANCELMODE';
    WM_SETCURSOR              : Result := 'WM_SETCURSOR';
    WM_MOUSEACTIVATE          : Result := 'WM_MOUSEACTIVATE';
    WM_CHILDACTIVATE          : Result := 'WM_CHILDACTIVATE';
    WM_QUEUESYNC              : Result := 'WM_QUEUESYNC';
    WM_GETMINMAXINFO          : Result := 'WM_GETMINMAXINFO';
    WM_PAINTICON              : Result := 'WM_PAINTICON';
    WM_ICONERASEBKGND         : Result := 'WM_ICONERASEBKGND';
    WM_NEXTDLGCTL             : Result := 'WM_NEXTDLGCTL';
    WM_SPOOLERSTATUS          : Result := 'WM_SPOOLERSTATUS';
    WM_DRAWITEM               : Result := 'WM_DRAWITEM';
    WM_MEASUREITEM            : Result := 'WM_MEASUREITEM';
    WM_DELETEITEM             : Result := 'WM_DELETEITEM';
    WM_VKEYTOITEM             : Result := 'WM_VKEYTOITEM';
    WM_CHARTOITEM             : Result := 'WM_CHARTOITEM';
    WM_SETFONT                : Result := 'WM_SETFONT';
    WM_GETFONT                : Result := 'WM_GETFONT';
    WM_SETHOTKEY              : Result := 'WM_SETHOTKEY';
    WM_GETHOTKEY              : Result := 'WM_GETHOTKEY';
    WM_QUERYDRAGICON          : Result := 'WM_QUERYDRAGICON';
    WM_COMPAREITEM            : Result := 'WM_COMPAREITEM';
    WM_GETOBJECT              : Result := 'WM_GETOBJECT';
    WM_COMPACTING             : Result := 'WM_COMPACTING';
    WM_COMMNOTIFY             : Result := 'WM_COMMNOTIFY';
    WM_WINDOWPOSCHANGING      : Result := 'WM_WINDOWPOSCHANGING';
    WM_WINDOWPOSCHANGED       : Result := 'WM_WINDOWPOSCHANGED';
    WM_POWER                  : Result := 'WM_POWER';
    WM_COPYDATA               : Result := 'WM_COPYDATA';
    WM_CANCELJOURNAL          : Result := 'WM_CANCELJOURNAL';
    WM_NOTIFY                 : Result := 'WM_NOTIFY';
    WM_INPUTLANGCHANGEREQUEST : Result := 'WM_INPUTLANGCHANGEREQUEST';
    WM_INPUTLANGCHANGE        : Result := 'WM_INPUTLANGCHANGE';
    WM_TCARD                  : Result := 'WM_TCARD';
    WM_HELP                   : Result := 'WM_HELP';
    WM_USERCHANGED            : Result := 'WM_USERCHANGED';
    WM_NOTIFYFORMAT           : Result := 'WM_NOTIFYFORMAT';
    WM_CONTEXTMENU            : Result := 'WM_CONTEXTMENU';
    WM_STYLECHANGING          : Result := 'WM_STYLECHANGING';
    WM_STYLECHANGED           : Result := 'WM_STYLECHANGED';
    WM_DISPLAYCHANGE          : Result := 'WM_DISPLAYCHANGE';
    WM_GETICON                : Result := 'WM_GETICON';
    WM_SETICON                : Result := 'WM_SETICON';
    WM_NCCREATE               : Result := 'WM_NCCREATE';
    WM_NCDESTROY              : Result := 'WM_NCDESTROY';
    WM_NCCALCSIZE             : Result := 'WM_NCCALCSIZE';
    WM_NCHITTEST              : Result := 'WM_NCHITTEST';
    WM_NCPAINT                : Result := 'WM_NCPAINT';
    WM_NCACTIVATE             : Result := 'WM_NCACTIVATE';
    WM_GETDLGCODE             : Result := 'WM_GETDLGCODE';
    WM_NCMOUSEMOVE            : Result := 'WM_NCMOUSEMOVE';
    WM_NCLBUTTONDOWN          : Result := 'WM_NCLBUTTONDOWN';
    WM_NCLBUTTONUP            : Result := 'WM_NCLBUTTONUP';
    WM_NCLBUTTONDBLCLK        : Result := 'WM_NCLBUTTONDBLCLK';
    WM_NCRBUTTONDOWN          : Result := 'WM_NCRBUTTONDOWN';
    WM_NCRBUTTONUP            : Result := 'WM_NCRBUTTONUP';
    WM_NCRBUTTONDBLCLK        : Result := 'WM_NCRBUTTONDBLCLK';
    WM_NCMBUTTONDOWN          : Result := 'WM_NCMBUTTONDOWN';
    WM_NCMBUTTONUP            : Result := 'WM_NCMBUTTONUP';
    WM_NCMBUTTONDBLCLK        : Result := 'WM_NCMBUTTONDBLCLK';
    // WM_KEYFIRST               : Result := 'WM_KEYFIRST'; // Синоним WM_KEYDOWN
    WM_KEYDOWN                : Result := 'WM_KEYDOWN';
    WM_KEYUP                  : Result := 'WM_KEYUP';
    WM_CHAR                   : Result := 'WM_CHAR';
    WM_DEADCHAR               : Result := 'WM_DEADCHAR';
    WM_SYSKEYDOWN             : Result := 'WM_SYSKEYDOWN';
    WM_SYSKEYUP               : Result := 'WM_SYSKEYUP';
    WM_SYSCHAR                : Result := 'WM_SYSCHAR';
    WM_SYSDEADCHAR            : Result := 'WM_SYSDEADCHAR';
    WM_KEYLAST                : Result := 'WM_KEYLAST';
    WM_INITDIALOG             : Result := 'WM_INITDIALOG';
    WM_COMMAND                : Result := 'WM_COMMAND';
    WM_SYSCOMMAND             : Result := 'WM_SYSCOMMAND';
    WM_TIMER                  : Result := 'WM_TIMER';
    WM_HSCROLL                : Result := 'WM_HSCROLL';
    WM_VSCROLL                : Result := 'WM_VSCROLL';
    WM_INITMENU               : Result := 'WM_INITMENU';
    WM_INITMENUPOPUP          : Result := 'WM_INITMENUPOPUP';
    WM_MENUSELECT             : Result := 'WM_MENUSELECT';
    WM_MENUCHAR               : Result := 'WM_MENUCHAR';
    WM_ENTERIDLE              : Result := 'WM_ENTERIDLE';
    WM_MENURBUTTONUP          : Result := 'WM_MENURBUTTONUP';
    WM_MENUDRAG               : Result := 'WM_MENUDRAG';
    WM_MENUGETOBJECT          : Result := 'WM_MENUGETOBJECT';
    WM_UNINITMENUPOPUP        : Result := 'WM_UNINITMENUPOPUP';
    WM_MENUCOMMAND            : Result := 'WM_MENUCOMMAND';
    WM_CHANGEUISTATE          : Result := 'WM_CHANGEUISTATE';
    WM_UPDATEUISTATE          : Result := 'WM_UPDATEUISTATE';
    WM_QUERYUISTATE           : Result := 'WM_QUERYUISTATE';
    WM_CTLCOLORMSGBOX         : Result := 'WM_CTLCOLORMSGBOX';
    WM_CTLCOLOREDIT           : Result := 'WM_CTLCOLOREDIT';
    WM_CTLCOLORLISTBOX        : Result := 'WM_CTLCOLORLISTBOX';
    WM_CTLCOLORBTN            : Result := 'WM_CTLCOLORBTN';
    WM_CTLCOLORDLG            : Result := 'WM_CTLCOLORDLG';
    WM_CTLCOLORSCROLLBAR      : Result := 'WM_CTLCOLORSCROLLBAR';
    WM_CTLCOLORSTATIC         : Result := 'WM_CTLCOLORSTATIC';
    // WM_MOUSEFIRST             : Result := 'WM_MOUSEFIRST'; // Синоним WM_ MOUSEMOVE
    WM_MOUSEMOVE              : Result := 'WM_MOUSEMOVE';
    WM_LBUTTONDOWN            : Result := 'WM_LBUTTONDOWN';
    WM_LBUTTONUP              : Result := 'WM_LBUTTONUP';
    WM_LBUTTONDBLCLK          : Result := 'WM_LBUTTONDBLCLK';
    WM_RBUTTONDOWN            : Result := 'WM_RBUTTONDOWN';
    WM_RBUTTONUP              : Result := 'WM_RBUTTONUP';
    WM_RBUTTONDBLCLK          : Result := 'WM_RBUTTONDBLCLK';
    WM_MBUTTONDOWN            : Result := 'WM_MBUTTONDOWN';
    WM_MBUTTONUP              : Result := 'WM_MBUTTONUP';
    WM_MBUTTONDBLCLK          : Result := 'WM_MBUTTONDBLCLK';
    WM_MOUSEWHEEL             : Result := 'WM_MOUSEWHEEL';
    // WM_MOUSELAST              : Result := 'WM_MOUSELAST'; // Синоним WM_MOUSEWHEEL
    WM_PARENTNOTIFY           : Result := 'WM_PARENTNOTIFY';
    WM_ENTERMENULOOP          : Result := 'WM_ENTERMENULOOP';
    WM_EXITMENULOOP           : Result := 'WM_EXITMENULOOP';
    WM_NEXTMENU               : Result := 'WM_NEXTMENU';
    WM_SIZING                 : Result := 'WM_SIZING';
    WM_CAPTURECHANGED         : Result := 'WM_CAPTURECHANGED';
    WM_MOVING                 : Result := 'WM_MOVING';
    WM_POWERBROADCAST         : Result := 'WM_POWERBROADCAST';
    WM_DEVICECHANGE           : Result := 'WM_DEVICECHANGE';
    WM_IME_STARTCOMPOSITION   : Result := 'WM_IME_STARTCOMPOSITION';
    WM_IME_ENDCOMPOSITION     : Result := 'WM_IME_ENDCOMPOSITION';
    WM_IME_COMPOSITION        : Result := 'WM_IME_COMPOSITION';
    // WM_IME_KEYLAST            : Result := 'WM_IME_KEYLAST'; // Синоним WM_IME_COMPOSITION
    WM_IME_SETCONTEXT         : Result := 'WM_IME_SETCONTEXT';
    WM_IME_NOTIFY             : Result := 'WM_IME_NOTIFY';
    WM_IME_CONTROL            : Result := 'WM_IME_CONTROL';
    WM_IME_COMPOSITIONFULL    : Result := 'WM_IME_COMPOSITIONFULL';
    WM_IME_SELECT             : Result := 'WM_IME_SELECT';
    WM_IME_CHAR               : Result := 'WM_IME_CHAR';
    WM_IME_REQUEST            : Result := 'WM_IME_REQUEST';
    WM_IME_KEYDOWN            : Result := 'WM_IME_KEYDOWN';
    WM_IME_KEYUP              : Result := 'WM_IME_KEYUP';
    WM_MDICREATE              : Result := 'WM_MDICREATE';
    WM_MDIDESTROY             : Result := 'WM_MDIDESTROY';
    WM_MDIACTIVATE            : Result := 'WM_MDIACTIVATE';
    WM_MDIRESTORE             : Result := 'WM_MDIRESTORE';
    WM_MDINEXT                : Result := 'WM_MDINEXT';
    WM_MDIMAXIMIZE            : Result := 'WM_MDIMAXIMIZE';
    WM_MDITILE                : Result := 'WM_MDITILE';
    WM_MDICASCADE             : Result := 'WM_MDICASCADE';
    WM_MDIICONARRANGE         : Result := 'WM_MDIICONARRANGE';
    WM_MDIGETACTIVE           : Result := 'WM_MDIGETACTIVE';
    WM_MDISETMENU             : Result := 'WM_MDISETMENU';
    WM_ENTERSIZEMOVE          : Result := 'WM_ENTERSIZEMOVE';
    WM_EXITSIZEMOVE           : Result := 'WM_EXITSIZEMOVE';
    WM_DROPFILES              : Result := 'WM_DROPFILES';
    WM_MDIREFRESHMENU         : Result := 'WM_MDIREFRESHMENU';
    WM_MOUSEHOVER             : Result := 'WM_MOUSEHOVER';
    WM_MOUSELEAVE             : Result := 'WM_MOUSELEAVE';
    WM_CUT                    : Result := 'WM_CUT';
    WM_COPY                   : Result := 'WM_COPY';
    WM_PASTE                  : Result := 'WM_PASTE';
    WM_CLEAR                  : Result := 'WM_CLEAR';
    WM_UNDO                   : Result := 'WM_UNDO';
    WM_RENDERFORMAT           : Result := 'WM_RENDERFORMAT';
    WM_RENDERALLFORMATS       : Result := 'WM_RENDERALLFORMATS';
    WM_DESTROYCLIPBOARD       : Result := 'WM_DESTROYCLIPBOARD';
    WM_DRAWCLIPBOARD          : Result := 'WM_DRAWCLIPBOARD';
    WM_PAINTCLIPBOARD         : Result := 'WM_PAINTCLIPBOARD';
    WM_VSCROLLCLIPBOARD       : Result := 'WM_VSCROLLCLIPBOARD';
    WM_SIZECLIPBOARD          : Result := 'WM_SIZECLIPBOARD';
    WM_ASKCBFORMATNAME        : Result := 'WM_ASKCBFORMATNAME';
    WM_CHANGECBCHAIN          : Result := 'WM_CHANGECBCHAIN';
    WM_HSCROLLCLIPBOARD       : Result := 'WM_HSCROLLCLIPBOARD';
    WM_QUERYNEWPALETTE        : Result := 'WM_QUERYNEWPALETTE';
    WM_PALETTEISCHANGING      : Result := 'WM_PALETTEISCHANGING';
    WM_PALETTECHANGED         : Result := 'WM_PALETTECHANGED';
    WM_HOTKEY                 : Result := 'WM_HOTKEY';
    WM_PRINT                  : Result := 'WM_PRINT';
    WM_PRINTCLIENT            : Result := 'WM_PRINTCLIENT';
    WM_HANDHELDFIRST          : Result := 'WM_HANDHELDFIRST';
    WM_HANDHELDLAST           : Result := 'WM_HANDHELDLAST';
    WM_PENWINFIRST            : Result := 'WM_PENWINFIRST';
    WM_PENWINLAST             : Result := 'WM_PENWINLAST';
    WM_COALESCE_FIRST         : Result := 'WM_COALESCE_FIRST';
    WM_COALESCE_LAST          : Result := 'WM_COALESCE_LAST';
    // WM_DDE_FIRST              : Result := 'WM_DDE_FIRST'; // Синоним WM_DDE_INITIATE
    WM_DDE_INITIATE           : Result := 'WM_DDE_INITIATE';
    WM_DDE_TERMINATE          : Result := 'WM_DDE_TERMINATE';
    WM_DDE_ADVISE             : Result := 'WM_DDE_ADVISE';
    WM_DDE_UNADVISE           : Result := 'WM_DDE_UNADVISE';
    WM_DDE_ACK                : Result := 'WM_DDE_ACK';
    WM_DDE_DATA               : Result := 'WM_DDE_DATA';
    WM_DDE_REQUEST            : Result := 'WM_DDE_REQUEST';
    WM_DDE_POKE               : Result := 'WM_DDE_POKE';
    WM_DDE_EXECUTE            : Result := 'WM_DDE_EXECUTE';
    // WM_DDE_LAST               : Result := 'WM_DDE_LAST'; // Синоним WM_DDE_EXECUTE
    WM_APP                    : Result := 'WM_APP';
    { Button Control Messages }
    BM_GETCHECK               : Result := 'BM_GETCHECK';
    BM_SETCHECK               : Result := 'BM_SETCHECK';
    BM_GETSTATE               : Result := 'BM_GETSTATE';
    BM_SETSTATE               : Result := 'BM_SETSTATE';
    BM_SETSTYLE               : Result := 'BM_SETSTYLE';
    BM_CLICK                  : Result := 'BM_CLICK';
    BM_GETIMAGE               : Result := 'BM_GETIMAGE';
    BM_SETIMAGE               : Result := 'BM_SETIMAGE';
    { Listbox messages }
    LB_ADDSTRING              : Result := 'LB_ADDSTRING';
    LB_INSERTSTRING           : Result := 'LB_INSERTSTRING';
    LB_DELETESTRING           : Result := 'LB_DELETESTRING';
    LB_SELITEMRANGEEX         : Result := 'LB_SELITEMRANGEEX';
    LB_RESETCONTENT           : Result := 'LB_RESETCONTENT';
    LB_SETSEL                 : Result := 'LB_SETSEL';
    LB_SETCURSEL              : Result := 'LB_SETCURSEL';
    LB_GETSEL                 : Result := 'LB_GETSEL';
    LB_GETCURSEL              : Result := 'LB_GETCURSEL';
    LB_GETTEXT                : Result := 'LB_GETTEXT';
    LB_GETTEXTLEN             : Result := 'LB_GETTEXTLEN';
    LB_GETCOUNT               : Result := 'LB_GETCOUNT';
    LB_SELECTSTRING           : Result := 'LB_SELECTSTRING';
    LB_DIR                    : Result := 'LB_DIR';
    LB_GETTOPINDEX            : Result := 'LB_GETTOPINDEX';
    LB_FINDSTRING             : Result := 'LB_FINDSTRING';
    LB_GETSELCOUNT            : Result := 'LB_GETSELCOUNT';
    LB_GETSELITEMS            : Result := 'LB_GETSELITEMS';
    LB_SETTABSTOPS            : Result := 'LB_SETTABSTOPS';
    LB_GETHORIZONTALEXTENT    : Result := 'LB_GETHORIZONTALEXTENT';
    LB_SETHORIZONTALEXTENT    : Result := 'LB_SETHORIZONTALEXTENT';
    LB_SETCOLUMNWIDTH         : Result := 'LB_SETCOLUMNWIDTH';
    LB_ADDFILE                : Result := 'LB_ADDFILE';
    LB_SETTOPINDEX            : Result := 'LB_SETTOPINDEX';
    LB_GETITEMRECT            : Result := 'LB_GETITEMRECT';
    LB_GETITEMDATA            : Result := 'LB_GETITEMDATA';
    LB_SETITEMDATA            : Result := 'LB_SETITEMDATA';
    LB_SELITEMRANGE           : Result := 'LB_SELITEMRANGE';
    LB_SETANCHORINDEX         : Result := 'LB_SETANCHORINDEX';
    LB_GETANCHORINDEX         : Result := 'LB_GETANCHORINDEX';
    LB_SETCARETINDEX          : Result := 'LB_SETCARETINDEX';
    LB_GETCARETINDEX          : Result := 'LB_GETCARETINDEX';
    LB_SETITEMHEIGHT          : Result := 'LB_SETITEMHEIGHT';
    LB_GETITEMHEIGHT          : Result := 'LB_GETITEMHEIGHT';
    LB_FINDSTRINGEXACT        : Result := 'LB_FINDSTRINGEXACT';
    LB_SETLOCALE              : Result := 'LB_SETLOCALE';
    LB_GETLOCALE              : Result := 'LB_GETLOCALE';
    LB_SETCOUNT               : Result := 'LB_SETCOUNT';
    LB_INITSTORAGE            : Result := 'LB_INITSTORAGE';
    LB_ITEMFROMPOINT          : Result := 'LB_ITEMFROMPOINT';
    LB_MSGMAX                 : Result := 'LB_MSGMAX';
    { Combo Box messages }
    CB_GETEDITSEL             : Result := 'CB_GETEDITSEL';
    CB_LIMITTEXT              : Result := 'CB_LIMITTEXT';
    CB_SETEDITSEL             : Result := 'CB_SETEDITSEL';
    CB_ADDSTRING              : Result := 'CB_ADDSTRING';
    CB_DELETESTRING           : Result := 'CB_DELETESTRING';
    CB_DIR                    : Result := 'CB_DIR';
    CB_GETCOUNT               : Result := 'CB_GETCOUNT';
    CB_GETCURSEL              : Result := 'CB_GETCURSEL';
    CB_GETLBTEXT              : Result := 'CB_GETLBTEXT';
    CB_GETLBTEXTLEN           : Result := 'CB_GETLBTEXTLEN';
    CB_INSERTSTRING           : Result := 'CB_INSERTSTRING';
    CB_RESETCONTENT           : Result := 'CB_RESETCONTENT';
    CB_FINDSTRING             : Result := 'CB_FINDSTRING';
    CB_SELECTSTRING           : Result := 'CB_SELECTSTRING';
    CB_SETCURSEL              : Result := 'CB_SETCURSEL';
    CB_SHOWDROPDOWN           : Result := 'CB_SHOWDROPDOWN';
    CB_GETITEMDATA            : Result := 'CB_GETITEMDATA';
    CB_SETITEMDATA            : Result := 'CB_SETITEMDATA';
    CB_GETDROPPEDCONTROLRECT  : Result := 'CB_GETDROPPEDCONTROLRECT';
    CB_SETITEMHEIGHT          : Result := 'CB_SETITEMHEIGHT';
    CB_GETITEMHEIGHT          : Result := 'CB_GETITEMHEIGHT';
    CB_SETEXTENDEDUI          : Result := 'CB_SETEXTENDEDUI';
    CB_GETEXTENDEDUI          : Result := 'CB_GETEXTENDEDUI';
    CB_GETDROPPEDSTATE        : Result := 'CB_GETDROPPEDSTATE';
    CB_FINDSTRINGEXACT        : Result := 'CB_FINDSTRINGEXACT';
    CB_SETLOCALE              : Result := 'CB_SETLOCALE';
    CB_GETLOCALE              : Result := 'CB_GETLOCALE';
    CB_GETTOPINDEX            : Result := 'CB_GETTOPINDEX';
    CB_SETTOPINDEX            : Result := 'CB_SETTOPINDEX';
    CB_GETHORIZONTALEXTENT    : Result := 'CB_GETHORIZONTALEXTENT';
    CB_SETHORIZONTALEXTENT    : Result := 'CB_SETHORIZONTALEXTENT';
    CB_GETDROPPEDWIDTH        : Result := 'CB_GETDROPPEDWIDTH';
    CB_SETDROPPEDWIDTH        : Result := 'CB_SETDROPPEDWIDTH';
    CB_INITSTORAGE            : Result := 'CB_INITSTORAGE';
    CB_MSGMAX                 : Result := 'CB_MSGMAX';
    { Edit Control Messages }
    EM_GETSEL                 : Result := 'EM_GETSEL';
    EM_SETSEL                 : Result := 'EM_SETSEL';
    EM_GETRECT                : Result := 'EM_GETRECT';
    EM_SETRECT                : Result := 'EM_SETRECT';
    EM_SETRECTNP              : Result := 'EM_SETRECTNP';
    EM_SCROLL                 : Result := 'EM_SCROLL';
    EM_LINESCROLL             : Result := 'EM_LINESCROLL';
    EM_SCROLLCARET            : Result := 'EM_SCROLLCARET';
    EM_GETMODIFY              : Result := 'EM_GETMODIFY';
    EM_SETMODIFY              : Result := 'EM_SETMODIFY';
    EM_GETLINECOUNT           : Result := 'EM_GETLINECOUNT';
    EM_LINEINDEX              : Result := 'EM_LINEINDEX';
    EM_SETHANDLE              : Result := 'EM_SETHANDLE';
    EM_GETHANDLE              : Result := 'EM_GETHANDLE';
    EM_GETTHUMB               : Result := 'EM_GETTHUMB';
    EM_LINELENGTH             : Result := 'EM_LINELENGTH';
    EM_REPLACESEL             : Result := 'EM_REPLACESEL';
    EM_GETLINE                : Result := 'EM_GETLINE';
    // EM_LIMITTEXT              : Result := 'EM_LIMITTEXT'; // Заменено EM_SETLIMITTEXT
    EM_CANUNDO                : Result := 'EM_CANUNDO';
    EM_UNDO                   : Result := 'EM_UNDO';
    EM_FMTLINES               : Result := 'EM_FMTLINES';
    EM_LINEFROMCHAR           : Result := 'EM_LINEFROMCHAR';
    EM_SETTABSTOPS            : Result := 'EM_SETTABSTOPS';
    EM_SETPASSWORDCHAR        : Result := 'EM_SETPASSWORDCHAR';
    EM_EMPTYUNDOBUFFER        : Result := 'EM_EMPTYUNDOBUFFER';
    EM_GETFIRSTVISIBLELINE    : Result := 'EM_GETFIRSTVISIBLELINE';
    EM_SETREADONLY            : Result := 'EM_SETREADONLY';
    EM_SETWORDBREAKPROC       : Result := 'EM_SETWORDBREAKPROC';
    EM_GETWORDBREAKPROC       : Result := 'EM_GETWORDBREAKPROC';
    EM_GETPASSWORDCHAR        : Result := 'EM_GETPASSWORDCHAR';
    EM_SETMARGINS             : Result := 'EM_SETMARGINS';
    EM_GETMARGINS             : Result := 'EM_GETMARGINS';
    EM_SETLIMITTEXT           : Result := 'EM_SETLIMITTEXT';
    EM_GETLIMITTEXT           : Result := 'EM_GETLIMITTEXT';
    EM_POSFROMCHAR            : Result := 'EM_POSFROMCHAR';
    EM_CHARFROMPOS            : Result := 'EM_CHARFROMPOS';
    EM_SETIMESTATUS           : Result := 'EM_SETIMESTATUS';
    EM_GETIMESTATUS           : Result := 'EM_GETIMESTATUS';
    { Scroll bar messages }
    SBM_SETPOS                : Result := 'SBM_SETPOS';
    SBM_GETPOS                : Result := 'SBM_GETPOS';
    SBM_SETRANGE              : Result := 'SBM_SETRANGE';
    SBM_SETRANGEREDRAW        : Result := 'SBM_SETRANGEREDRAW';
    SBM_GETRANGE              : Result := 'SBM_GETRANGE';
    SBM_ENABLE_ARROWS         : Result := 'SBM_ENABLE_ARROWS';
    SBM_SETSCROLLINFO         : Result := 'SBM_SETSCROLLINFO';
    SBM_GETSCROLLINFO         : Result := 'SBM_GETSCROLLINFO';
    { Dialog messages }
    DM_GETDEFID               : Result := 'DM_GETDEFID';
    DM_SETDEFID               : Result := 'DM_SETDEFID';
    DM_REPOSITION             : Result := 'DM_REPOSITION';
    PSM_PAGEINFO              : Result := 'PSM_PAGEINFO';
    PSM_SHEETINFO             : Result := 'PSM_SHEETINFO';
    { VCL control message IDs }
    CM_ACTIVATE               : Result := 'CM_ACTIVATE';
    CM_DEACTIVATE             : Result := 'CM_DEACTIVATE';
    CM_GOTFOCUS               : Result := 'CM_GOTFOCUS';
    CM_LOSTFOCUS              : Result := 'CM_LOSTFOCUS';
    CM_CANCELMODE             : Result := 'CM_CANCELMODE';
    CM_DIALOGKEY              : Result := 'CM_DIALOGKEY';
    CM_DIALOGCHAR             : Result := 'CM_DIALOGCHAR';
    CM_FOCUSCHANGED           : Result := 'CM_FOCUSCHANGED';
    CM_CONTROLLISTCHANGE      : Result := 'CM_CONTROLLISTCHANGE';
    CM_GETDATALINK            : Result := 'CM_GETDATALINK';
    CM_CONTROLCHANGE          : Result := 'CM_CONTROLCHANGE';
    CM_DOCKCLIENT             : Result := 'CM_DOCKCLIENT';
    CM_UNDOCKCLIENT           : Result := 'CM_UNDOCKCLIENT';
    CM_FLOAT                  : Result := 'CM_FLOAT';
    CM_ACTIONUPDATE           : Result := 'CM_ACTIONUPDATE';
    CM_ACTIONEXECUTE          : Result := 'CM_ACTIONEXECUTE';
    CM_PARENTFONTCHANGED      : Result := 'CM_PARENTFONTCHANGED';
    CM_PARENTCOLORCHANGED     : Result := 'CM_PARENTCOLORCHANGED';
    CM_HITTEST                : Result := 'CM_HITTEST';
    CM_VISIBLECHANGED         : Result := 'CM_VISIBLECHANGED';
    CM_ENABLEDCHANGED         : Result := 'CM_ENABLEDCHANGED';
    CM_COLORCHANGED           : Result := 'CM_COLORCHANGED';
    CM_FONTCHANGED            : Result := 'CM_FONTCHANGED';
    CM_CURSORCHANGED          : Result := 'CM_CURSORCHANGED';
    //{$ifdef D_6_UP}
    //CM_CTL                    : Result := 'CM_CTL';
    //CM_PARENTCTL              : Result := 'CM_PARENTCTL';
    CM_CTL3DCHANGED           : Result := 'CM_CTL3DCHANGED';
    CM_PARENTCTL3DCHANGED     : Result := 'CM_PARENTCTL3DCHANGED';
    //{$endif}
    CM_TEXTCHANGED            : Result := 'CM_TEXTCHANGED';
    CM_MOUSEENTER             : Result := 'CM_MOUSEENTER';
    CM_MOUSELEAVE             : Result := 'CM_MOUSELEAVE';
    CM_MENUCHANGED            : Result := 'CM_MENUCHANGED';
    CM_APPKEYDOWN             : Result := 'CM_APPKEYDOWN';
    CM_APPSYSCOMMAND          : Result := 'CM_APPSYSCOMMAND';
    CM_BUTTONPRESSED          : Result := 'CM_BUTTONPRESSED';
    CM_SHOWINGCHANGED         : Result := 'CM_SHOWINGCHANGED';
    CM_ENTER                  : Result := 'CM_ENTER';
    CM_EXIT                   : Result := 'CM_EXIT';
    CM_DESIGNHITTEST          : Result := 'CM_DESIGNHITTEST';
    CM_ICONCHANGED            : Result := 'CM_ICONCHANGED';
    CM_WANTSPECIALKEY         : Result := 'CM_WANTSPECIALKEY';
    CM_INVOKEHELP             : Result := 'CM_INVOKEHELP';
    CM_WINDOWHOOK             : Result := 'CM_WINDOWHOOK';
    CM_RELEASE                : Result := 'CM_RELEASE';
    CM_SHOWHINTCHANGED        : Result := 'CM_SHOWHINTCHANGED';
    CM_PARENTSHOWHINTCHANGED  : Result := 'CM_PARENTSHOWHINTCHANGED';
    CM_SYSCOLORCHANGE         : Result := 'CM_SYSCOLORCHANGE';
    CM_WININICHANGE           : Result := 'CM_WININICHANGE';
    CM_FONTCHANGE             : Result := 'CM_FONTCHANGE';
    CM_TIMECHANGE             : Result := 'CM_TIMECHANGE';
    CM_TABSTOPCHANGED         : Result := 'CM_TABSTOPCHANGED';
    CM_UIACTIVATE             : Result := 'CM_UIACTIVATE';
    CM_UIDEACTIVATE           : Result := 'CM_UIDEACTIVATE';
    CM_DOCWINDOWACTIVATE      : Result := 'CM_DOCWINDOWACTIVATE';
    CM_CHILDKEY               : Result := 'CM_CHILDKEY';
    CM_DRAG                   : Result := 'CM_DRAG';
    CM_HINTSHOW               : Result := 'CM_HINTSHOW';
    CM_DIALOGHANDLE           : Result := 'CM_DIALOGHANDLE';
    CM_ISTOOLCONTROL          : Result := 'CM_ISTOOLCONTROL';
    CM_RECREATEWND            : Result := 'CM_RECREATEWND';
    CM_INVALIDATE             : Result := 'CM_INVALIDATE';
    CM_SYSFONTCHANGED         : Result := 'CM_SYSFONTCHANGED';
    CM_CHANGED                : Result := 'CM_CHANGED';
    CM_BORDERCHANGED          : Result := 'CM_BORDERCHANGED';
    CM_BIDIMODECHANGED        : Result := 'CM_BIDIMODECHANGED';
    CM_PARENTBIDIMODECHANGED  : Result := 'CM_PARENTBIDIMODECHANGED';
    CM_ALLCHILDRENFLIPPED     : Result := 'CM_ALLCHILDRENFLIPPED';
    CM_HINTSHOWPAUSE          : Result := 'CM_HINTSHOWPAUSE';
    CM_DOCKNOTIFICATION       : Result := 'CM_DOCKNOTIFICATION';
    CM_MOUSEWHEEL             : Result := 'CM_MOUSEWHEEL';
    CM_ISSHORTCUT             : Result := 'CM_ISSHORTCUT';
    { VCL control notification IDs }
    CN_CHARTOITEM             : Result := 'CN_CHARTOITEM';
    CN_COMMAND                : Result := 'CN_COMMAND';
    CN_COMPAREITEM            : Result := 'CN_COMPAREITEM';
    CN_CTLCOLORBTN            : Result := 'CN_CTLCOLORBTN';
    CN_CTLCOLORDLG            : Result := 'CN_CTLCOLORDLG';
    CN_CTLCOLOREDIT           : Result := 'CN_CTLCOLOREDIT';
    CN_CTLCOLORLISTBOX        : Result := 'CN_CTLCOLORLISTBOX';
    CN_CTLCOLORMSGBOX         : Result := 'CN_CTLCOLORMSGBOX';
    CN_CTLCOLORSCROLLBAR      : Result := 'CN_CTLCOLORSCROLLBAR';
    CN_CTLCOLORSTATIC         : Result := 'CN_CTLCOLORSTATIC';
    CN_DELETEITEM             : Result := 'CN_DELETEITEM';
    CN_DRAWITEM               : Result := 'CN_DRAWITEM';
    CN_HSCROLL                : Result := 'CN_HSCROLL';
    CN_MEASUREITEM            : Result := 'CN_MEASUREITEM';
    CN_PARENTNOTIFY           : Result := 'CN_PARENTNOTIFY';
    CN_VKEYTOITEM             : Result := 'CN_VKEYTOITEM';
    CN_VSCROLL                : Result := 'CN_VSCROLL';
    CN_KEYDOWN                : Result := 'CN_KEYDOWN';
    CN_KEYUP                  : Result := 'CN_KEYUP';
    CN_CHAR                   : Result := 'CN_CHAR';
    CN_SYSKEYDOWN             : Result := 'CN_SYSKEYDOWN';
    CN_SYSCHAR                : Result := 'CN_SYSCHAR';
    CN_NOTIFY                 : Result := 'CN_NOTIFY';
  else
  { Unknown or Custom Message }
    Result := 'Unknown or Custom Message ('
              +IntToStr(WM_Number)+')';
  end;
end;

{ Button Notifications }
{------------------------------------------------------------------------------}
function LMDWMCommandButtonNotify(const CN_Number: Integer): String;
begin
  case CN_Number of
    BN_CLICKED                : Result := 'BN_CLICKED';
    BN_PAINT                  : Result := 'BN_PAINT';
    BN_HILITE                 : Result := 'BN_HILITE';
    BN_UNHILITE               : Result := 'BN_UNHILITE';
    BN_DISABLE                : Result := 'BN_DISABLE';
    BN_DOUBLECLICKED          : Result := 'BN_DOUBLECLICKED';
    // BN_PUSHED                 : Result := 'BN_PUSHED';   // Синоним BN_HILITE
    // BN_UNPUSHED               : Result := 'BN_UNPUSHED'; // Синоним BN_UNHILITE
    // BN_DBLCLK                 : Result := 'BN_DBLCLK';   // Синоним BN_DOUBLECLICKED
    BN_SETFOCUS               : Result := 'BN_SETFOCUS';
    BN_KILLFOCUS              : Result := 'BN_KILLFOCUS';
  else
    Result := 'Unknown or Custom Notification ('+
              IntToStr(CN_Number)+')';
  end;
end;

{ ListBox Notification }
{------------------------------------------------------------------------------}
function LMDWMCommandListBoxNotify(const CN_Number: Integer): String;
begin
  case CN_Number of
    LBN_ERRSPACE              : Result := 'LBN_ERRSPACE';
    LBN_SELCHANGE             : Result := 'LBN_SELCHANGE';
    LBN_DBLCLK                : Result := 'LBN_DBLCLK';
    LBN_SELCANCEL             : Result := 'LBN_SELCANCEL';
    LBN_SETFOCUS              : Result := 'LBN_SETFOCUS';
    LBN_KILLFOCUS             : Result := 'LBN_KILLFOCUS';
  else
    Result := 'Unknown or Custom Notification ('+
              IntToStr(CN_Number)+')';
  end;
end;

{ Combobox Notification }
{------------------------------------------------------------------------------}
function LMDWMCommandComboBoxNotify(const CN_Number: Integer): String;
begin
  case CN_Number of
    CBN_ERRSPACE              : Result := 'CBN_ERRSPACE';
    CBN_SELCHANGE             : Result := 'CBN_SELCHANGE';
    CBN_DBLCLK                : Result := 'CBN_DBLCLK';
    CBN_SETFOCUS              : Result := 'CBN_SETFOCUS';
    CBN_KILLFOCUS             : Result := 'CBN_KILLFOCUS';
    CBN_EDITCHANGE            : Result := 'CBN_EDITCHANGE';
    CBN_EDITUPDATE            : Result := 'CBN_EDITUPDATE';
    CBN_DROPDOWN              : Result := 'CBN_DROPDOWN';
    CBN_CLOSEUP               : Result := 'CBN_CLOSEUP';
    CBN_SELENDOK              : Result := 'CBN_SELENDOK';
    CBN_SELENDCANCEL          : Result := 'CBN_SELENDCANCEL';
  else
    Result := 'Unknown or Custom Notification ('+
              IntToStr(CN_Number)+')';
  end;
end;

{ Edit Notification }
{------------------------------------------------------------------------------}
function LMDWMCommandEditNotify(const CN_Number: Integer): String;
begin
  case CN_Number of
    EN_SETFOCUS               : Result := 'EN_SETFOCUS';
    EN_KILLFOCUS              : Result := 'EN_KILLFOCUS';
    EN_CHANGE                 : Result := 'EN_CHANGE';
    EN_UPDATE                 : Result := 'EN_UPDATE';
    EN_ERRSPACE               : Result := 'EN_ERRSPACE';
    EN_MAXTEXT                : Result := 'EN_MAXTEXT';
    EN_HSCROLL                : Result := 'EN_HSCROLL';
    EN_VSCROLL                : Result := 'EN_VSCROLL';
  else
    Result := 'Unknown or Custom Notification ('+
              IntToStr(CN_Number)+')';
  end;
end;

{ Window styles }
{------------------------------------------------------------------------------}
function LMDWindowsStyleToString(AStyle: Cardinal): string;
begin
  Result := '';
  if (AStyle and WS_OVERLAPPED ) <> 0 then Result := Result + ', WS_OVERLAPPED';
  if (AStyle and WS_POPUP ) <> 0 then Result := Result + ', WS_POPUP';
  if (AStyle and WS_CHILD ) <> 0 then Result := Result + ', WS_CHILD';
  if (AStyle and WS_MINIMIZE ) <> 0 then Result := Result + ', WS_MINIMIZE';
  if (AStyle and WS_VISIBLE ) <> 0 then Result := Result + ', WS_VISIBLE';
  if (AStyle and WS_DISABLED ) <> 0 then Result := Result + ', WS_DISABLED';
  if (AStyle and WS_CLIPSIBLINGS ) <> 0 then Result := Result + ', WS_CLIPSIBLINGS';
  if (AStyle and WS_CLIPCHILDREN ) <> 0 then Result := Result + ', WS_CLIPCHILDREN';
  if (AStyle and WS_MAXIMIZE ) <> 0 then Result := Result + ', WS_MAXIMIZE';
  if (AStyle and WS_CAPTION ) <> 0 then Result := Result + ', WS_CAPTION';
  if (AStyle and WS_BORDER ) <> 0 then Result := Result + ', WS_BORDER';
  if (AStyle and WS_DLGFRAME ) <> 0 then Result := Result + ', WS_DLGFRAME';
  if (AStyle and WS_VSCROLL ) <> 0 then Result := Result + ', WS_VSCROLL';
  if (AStyle and WS_HSCROLL ) <> 0 then Result := Result + ', WS_HSCROLL';
  if (AStyle and WS_SYSMENU ) <> 0 then Result := Result + ', WS_SYSMENU';
  if (AStyle and WS_THICKFRAME ) <> 0 then Result := Result + ', WS_THICKFRAME';
  if (AStyle and WS_GROUP ) <> 0 then Result := Result + ', WS_GROUP';
  if (AStyle and WS_TABSTOP ) <> 0 then Result := Result + ', WS_TABSTOP';
  if (AStyle and WS_MINIMIZEBOX ) <> 0 then Result := Result + ', WS_MINIMIZEBOX';
  if (AStyle and WS_MAXIMIZEBOX ) <> 0 then Result := Result + ', WS_MAXIMIZEBOX';
  if (AStyle and WS_TILED ) <> 0 then Result := Result + ', WS_TILED';
  if (AStyle and WS_ICONIC ) <> 0 then Result := Result + ', WS_ICONIC';
  if (AStyle and WS_SIZEBOX ) <> 0 then Result := Result + ', WS_SIZEBOX';

  if Result <> '' then
    Result := Copy(Result, 2, Length(Result) - 1);
end;

//Those constants does not exist in D5,D6
const LMD_WS_EX_LAYERED = $00080000;
      LMD_WS_EX_NOINHERITLAYOUT = $00100000;
      LMD_WS_EX_LAYOUTRTL = $00400000;
      LMD_WS_EX_COMPOSITED = $02000000;
      LMD_WS_EX_NOACTIVATE = $08000000;
{------------------------------------------------------------------------------}
function LMDWindowExStyleToString(AExStyle: Cardinal): String;
begin
  Result := '';
  if (AExStyle and WS_EX_DLGMODALFRAME ) <> 0 then Result := Result + ', WS_EX_DLGMODALFRAME';
  if (AExStyle and WS_EX_NOPARENTNOTIFY ) <> 0 then Result := Result + ', WS_EX_NOPARENTNOTIFY';
  if (AExStyle and WS_EX_TOPMOST ) <> 0 then Result := Result + ', WS_EX_TOPMOST';
  if (AExStyle and WS_EX_ACCEPTFILES ) <> 0 then Result := Result + ', WS_EX_ACCEPTFILES';
  if (AExStyle and WS_EX_TRANSPARENT ) <> 0 then Result := Result + ', WS_EX_TRANSPARENT';
  if (AExStyle and WS_EX_MDICHILD ) <> 0 then Result := Result + ', WS_EX_MDICHILD';
  if (AExStyle and WS_EX_TOOLWINDOW ) <> 0 then Result := Result + ', WS_EX_TOOLWINDOW';
  if (AExStyle and WS_EX_WINDOWEDGE ) <> 0 then Result := Result + ', WS_EX_WINDOWEDGE';
  if (AExStyle and WS_EX_CLIENTEDGE ) <> 0 then Result := Result + ', WS_EX_CLIENTEDGE';
  if (AExStyle and WS_EX_CONTEXTHELP ) <> 0 then Result := Result + ', WS_EX_CONTEXTHELP';
  if (AExStyle and WS_EX_RIGHT ) <> 0 then Result := Result + ', WS_EX_RIGHT';
  if (AExStyle and WS_EX_LEFT ) <> 0 then Result := Result + ', WS_EX_LEFT';
  if (AExStyle and WS_EX_RTLREADING ) <> 0 then Result := Result + ', WS_EX_RTLREADING';
  if (AExStyle and WS_EX_LTRREADING ) <> 0 then Result := Result + ', WS_EX_LTRREADING';
  if (AExStyle and WS_EX_LEFTSCROLLBAR ) <> 0 then Result := Result + ', WS_EX_LEFTSCROLLBAR';
  if (AExStyle and WS_EX_RIGHTSCROLLBAR ) <> 0 then Result := Result + ', WS_EX_RIGHTSCROLLBAR';
  if (AExStyle and WS_EX_CONTROLPARENT ) <> 0 then Result := Result + ', WS_EX_CONTROLPARENT';
  if (AExStyle and WS_EX_STATICEDGE ) <> 0 then Result := Result + ', WS_EX_STATICEDGE';
  if (AExStyle and WS_EX_APPWINDOW ) <> 0 then Result := Result + ', WS_EX_APPWINDOW';
  if (AExStyle and WS_EX_OVERLAPPEDWINDOW ) <> 0 then Result := Result + ', WS_EX_OVERLAPPEDWINDOW';
  if (AExStyle and WS_EX_PALETTEWINDOW ) <> 0 then Result := Result + ', WS_EX_PALETTEWINDOW';
  if (AExStyle and LMD_WS_EX_LAYERED ) <> 0 then Result := Result + ', WS_EX_LAYERED';
  if (AExStyle and LMD_WS_EX_NOINHERITLAYOUT ) <> 0 then Result := Result + ', WS_EX_NOINHERITLAYOUT';
  if (AExStyle and LMD_WS_EX_LAYOUTRTL) <> 0 then Result := Result + ', WS_EX_LAYOUTRTL';
  if (AExStyle and LMD_WS_EX_COMPOSITED) <> 0 then Result := Result + ', WS_EX_COMPOSITED';
  if (AExStyle and LMD_WS_EX_NOACTIVATE) <> 0 then Result := Result + ', WS_EX_NOACTIVATE';
  if Result <> '' then
    Result := Copy(Result, 2, Length(Result) - 1);
end;

end.
