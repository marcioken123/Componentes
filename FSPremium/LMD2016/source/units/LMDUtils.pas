unit LMDUtils;
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

LMDUtils unit (RM, JH, AH)
--------------------------
Main, nonvisual utility routines.

Changes
-------
Release 8.05 (February 2008)
+ LMDSetForeGroundWindow method

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Windows, Forms, Graphics, Controls, Messages,
  Types, Math, TypInfo, LMDTypes, LMDClass, LMDProcs, LMDStrings;

{general drawing}
function  LMDAlphaBlend(DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;
function  LMDTransparentBlt(DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: UINT): BOOL; stdcall;
// does not really fit here, but is used by designtime only controls in LMDRTL
procedure LMDDrawTriangle(aCanvas: TCanvas; x,y,size: integer; Col: TColor; Down, Enabled:Boolean);
{General font routines}
{----------------------------------------------------------------------------}
function LMDIsTrueTypeFont(aFont:TFont):Boolean;
function LMDIsTrueTypeFontCheck(aCanvas:TCanvas):Boolean;
function LMDGetFontHeight(aFont:TFont):Integer;

{Form/Application related functions}
{------------------------------------------------------------------------------}
procedure LMDActivatePrevInstance;
function LMDSetForegroundWindow(HWnd: THandle): boolean;
procedure LMDWait(ms: LongWord);

{Misc routines for controls}
{----------------------------------------------------------------------------}
function LMDIsChild(Parent, Child: TControl):Boolean;
// use LMDSetEnableState to set Enabled property all childs of the given container control
procedure LMDSetEnabledState(Container:TWinControl; aValue: Boolean);
function  LMDInvalidateRect(hWnd: HWND; const lpRect: TRect; bErase: BOOL): BOOL;
function  LMDCenterChild(frmParent, frmchild: TCustomForm; flag:Boolean=True):TModalResult;
procedure LMDCenterForm(frm:TCustomForm);
procedure LMDCenterWindow(Wnd: HWnd; AtTop: Boolean=false);
//4.0
procedure LMDCenterChildWindow(Parent,Child:Hwnd; AtTop: Boolean);
procedure LMDPositionWindow(Wnd:Hwnd; aRect:TRect; APos:TLMDDlgPosition; AtTop:Boolean);
function LMDDlgGetTargetRect(aRel:TLMDDlgPosRel):TRect;

function LMDShowModal(aClass:TFormClass; owner:TComponent):TModalResult;

{System Menu}
{------------------------------------------------------------------------------}
procedure LMDExplodeForm(aForm:TCustomForm);
procedure LMDExplodeFormExt(aForm:TCustomForm; X,Y, Steps, Delay:Integer);
procedure LMDExplodeForm2(aForm:TCustomForm);
procedure LMDExplodeFormExt2(aForm:TCustomForm; X,Y, Steps, smWidth, smHeight,
                             Delay:Integer; flag:Boolean);

function LMDGetOwnerForm(Component: TComponent): TForm;
function LMDGetOwnerFrameForm(Component: TComponent): TWinControl;

{Unicode hint support}
{------------------------------------------------------------------------------}
function LMDConvertVCLHint(const Hint: TLMDString): String;
function LMDConvertUnicodeHint(const AHint: String): TLMDString;
{$ifdef LMD_UNICODE}
procedure LMDConvertVCLHintShow(const InHint: String; const FHint:TLMDString; var Message: TCMHintShow);
function LMDWideGetShortHint(Hint: WideString): WideString;
{$endif LMD_UNICODE}

{Loading and saving of CustomColor-Lists}
{------------------------------------------------------------------------------}
procedure LMDLoadCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
procedure LMDSaveCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
procedure LMDLoadCustomColorFromIniFile(const filename:String; const Section:String; aList:TStrings);
procedure LMDSaveCustomColorToIniFile(const Filename:String; const Section:String; aList:TStrings);

function LMDAllocateHWND(Obj: TObject; WndMethod: TLMDWndMethod): HWND; overload;
function LMDAllocateHWND(Obj: TObject; WndMethod: TLMDWndMethod; AWindowClass, AWindowName: String): HWND; overload;

procedure LMDDeallocateHWND(Wnd: HWND);

// Clipboard formats utilities
function LMDGetClipboardFormatName(AFormat: integer): string;
function LMDGetClipboardFormatIndex(const FormatName: string): integer;
function LMDHasClipboardFormat(Handle: THandle; Index: integer): boolean;

function LMDConvertBreaksFormat(Text : TLMDString) : TLMDString;
function LMDGetTextFromClipBoard: TLMDString;
procedure LMDCopyTextToClipboard(aText: TLMDString; aConvertBreaksFmt: boolean = false);


implementation

uses
  Consts, ClipBrd, LMDSysIn,
  {$IFDEF LMD_UNICODE}
  LMDUnicode,
  {$ENDIF}
  Inifiles, Registry;

  type
  TAlphaBlend = function (DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;
  TTransparentBlt = function (DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: UINT): BOOL; stdcall;
  // <--- from LMD BarPack
var
  AlphaBlendFunc : TAlphaBlend;
  TransparentBltFunc: TTransparentBlt;
  var
  hMSILib : THandle;

function LMDReplaceTransparentBlt(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
                                  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
                                  TransparentColor: cardinal): Longbool;
var
  MonoDC: HDC;
  MonoBmp: HBitmap;
  SavedDestDC, SavedSrcDC, SavedMonoDC: integer;
begin
  try
    MonoDC := CreateCompatibleDC(DestDC);
    SavedDestDC := SaveDC(DestDC);
    SavedSrcDC := SaveDC(SrcDC);
    SavedMonoDC := SaveDC(MonoDC);
    SetBkColor(DestDC, RGB(255, 255, 255));
    SetTextColor(DestDC, RGB(0, 0, 0));
    SetBkColor(SrcDC, TransparentColor);
    MonoBmp := CreateBitmap(SrcW, SrcH, 1, 1, nil);
    MonoBmp := SelectObject(MonoDC, MonoBmp);
    BitBlt(MonoDC, 0, 0, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCCOPY);
    BitBlt(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCINVERT);
    BitBlt(DestDC, X, Y, SrcW, SrcH, MonoDC, 0, 0, SRCAND);
    BitBlt(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCINVERT);
    MonoBmp := SelectObject(MonoDC, MonoBmp);
    RestoreDC(MonoDC, SavedMonoDC);
    DeleteDC(MonoDC);
    DeleteObject(MonoBmp);
    RestoreDC(SrcDC, SavedSrcDC);
    RestoreDC(DestDC, SavedDestDC);
    Result := True;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function  LMDAlphaBlend(DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;
begin
  if Assigned(AlphaBlendFunc) then
  Result := AlphaBlendFunc(DC,p2, p3, p4, p5,DC6,p7, p8, p9, p10,p11)
  else
    begin
      Result := BitBlt(DC,p2, p3, p4, p5,DC6,p7, p8,SRCCOPY);
    end;
end;

{------------------------------------------------------------------------------}
function  LMDTransparentBlt(DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: UINT): BOOL; stdcall;
begin
  // 7.01 --> check for NT required: TransparentBlt function contains Resource leak on Win9X systems:
  // http://support.microsoft.com/?kbid=300555
  if Assigned(TransparentBltFunc) and (SysUtils.Win32PlatForm = VER_PLATFORM_WIN32_NT) then
  // ---
  Result := TransparentBltFunc(DC,p2, p3, p4, p5,DC6,p7, p8, p9, p10,p11)
  else
    begin
      // -> AH: Works, but flickers
      // DONE: 04.27.2004 (see LMDExplorerBar.pas, TLMDExplorerBarPanel.WMPaint method)
      Result := LMDReplaceTransparentBlt(DC,p2, p3, p4, p5,DC6,p7, p8, p9, p10,p11) //BitBlt(DC,p2, p3, p4, p5,DC6,p7, p8,SRCCOPY);
    end;
end;

{General Drawing Routines}
{------------------------------------------------------------------------------}
procedure LMDDrawTriangle(aCanvas: TCanvas; x,y,size: integer; Col: TColor; Down,Enabled:Boolean);
var
  i: integer;
begin

  if (size<2) or (size>15) then exit;
  with aCanvas do
    begin
      if not Enabled then
        LMDDrawTriangle(aCanvas,x+1,y+1,size,clHighlightText,Down,True);

      Pen.Width:=1;
      Pen.Style:=psSolid;
      if Enabled then Pen.Color:=Col else Pen.Color:=clGrayText;
      if Down then
        begin
          for i:=0 to size-2 do
            begin
              MoveTo(x+i,y+i);
              LineTo(x+i+((size-i)*2)-1,y+i);
            end;
          MoveTo(x+(size-1),y+size-1);
          LineTo(x+(size-1),y+size-2);
        end
      else
        begin
          x:=x+(size div 2);
          for i:=0 to Pred(size) do
            begin
              MoveTo(x-i,y+i);
              LineTo(x+i+1,y+i);
            end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function LMDIsTrueTypeFont(aFont:TFont):Boolean;
var
  met: TTextMetric;
  old: HFont;
  DC:HDC;

begin
  DC:=GetDC(0);
  try
    old:=SelectObject(DC, aFont.Handle);
    GetTextMetrics(DC, met);
    result:=(met.tmPitchAndFamily and TMPF_TRUETYPE) <> 0;
    SelectObject(DC, old);
  finally
    ReleaseDC(0, DC);
  end;
end;

{------------------------------------------------------------------------------}
function LMDIsTrueTypeFontCheck(aCanvas:TCanvas):Boolean;
var
  {$IFDEF LMD_UNICODE}
  met: TTextMetricW;
  {$ELSE}
  met: TTextMetric;
  {$ENDIF}
begin
  {$IFDEF LMD_UNICODE}
  GetTextMetricsW(aCanvas.Handle, met);
  {$ELSE}
  GetTextMetrics(aCanvas.Handle, met);
  {$ENDIF}
  result:=(met.tmPitchAndFamily and TMPF_TRUETYPE)<>0;
end;

{------------------------------------------------------------------------------}
function LMDGetFontHeight(aFont:TFont):Integer;
var
  Extent:TSize;
  old:HFont;
  DC:HDC;
begin
  result:=0;
  DC:=GetDC(0);
  try
    old:=SelectObject(DC, aFont.Handle);
    if
    {$IFDEF LMD_UNICODE}
    GetTextExtentPointW(DC, 'Wq', 2, Extent)
    {$ELSE}
    GetTextExtentPoint(DC, 'Wq', 2, Extent)
    {$ENDIF}
    then
      result:=Extent.cY;
    SelectObject(DC, old);
  finally
    ReleaseDC(0, DC);
  end;
end;

{controls}
{------------------------------------------------------------------------------}
function LMDIsChild(Parent, Child:TControl):Boolean;
begin
  result:=False;
  while Parent<>nil do
    begin
      if Parent=Child then
        begin
          result:=True;exit;
        end;
      Parent:=Parent.Parent;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDSetEnabledState(Container:TWinControl; aValue: Boolean);
var
  i : Integer;
  aControl : TControl;
begin
  for i :=0 to Container.ControlCount-1 do
    begin
      aControl := Container.Controls[i];
      aControl.Enabled := aValue;
      if (aControl is TWinControl) and
         (csAcceptsControls in Container.Controls[i].ControlStyle) then
        LMDSetEnabledState(TWinControl(aControl), aValue)
    end;
end;

{------------------------------------------------------------------------------}
function LMDInvalidateRect(hWnd: HWND; const lpRect: TRect; bErase: BOOL): BOOL;
begin

  Result := InvalidateRect(hWnd, @lpRect, bErase);

end;

{******************** CustomColor lists ini Ini/Registry **********************}
{ ---------------------------------------------------------------------------- }
procedure LMDLoadCustomColorFromIniFile(const filename:String; const Section:String; aList:TStrings);
var
  inifile:TIniFile;

begin
   inifile:=TIniFile.Create(FileName);
   try
      LMDLoadCustomColorList(inifile, Section, aList);
   finally
     inifile.free;
   end;
end;

{------------------------------------------------------------------------------}
procedure LMDLoadCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
begin
  if (inifile=nil) or not ((inifile is TIniFile) or
                          (inifile is TRegIniFile)) then exit;
  aList.Clear;
  if iniFile is TRegIniFile then
    TRegIniFile(IniFile).ReadSectionValues(Section, aList)
  else
    TIniFile(IniFile).ReadSectionValues(Section, aList);
end;

{------------------------------------------------------------------------------}
procedure LMDSaveCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
var
   i,j:integer;
   colorstr:string;

begin
  if (inifile=nil) or not ((inifile is TIniFile) or
                          (inifile is TRegIniFile)) then exit;
  for i:=0 to aList.Count-1 do
    begin
      colorstr:=aList.Strings[I];
      j:=Pos('=', colorstr);
      if j<>0 then
        begin
          colorstr:=copy(colorstr,1,j-1);
          if inifile is TREGIniFile then
            TRegIniFile(IniFile).WriteString(Section, colorstr, aList.Values[colorstr])
          else
            TIniFile(IniFile).WriteString(Section, colorstr, aList.Values[colorstr]);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDSaveCustomColorToIniFile(const Filename:String; const Section:String;
                                      aList:TStrings);
var
  IniFile:TIniFile;

begin
   IniFile:=TIniFile.Create(FileName);
   try
      LMDSaveCustomColorList(IniFile, Section, aList);
   finally
     IniFile.Free;
   end;
end;

type
  TWndObjInstance = record
    Obj: TObject;
    WndMethod: TLMDWndMethod;
  end;
  PWndObjInstance = ^TWndObjInstance;

function XDefWindowProc(aWnd: HWND; aMsg: Integer; wParam: WPARAM; lParam: LPARAM): Integer; stdcall;
var
  Msg: TMessage;
  ObjInst: PWndObjInstance;
begin
  ObjInst := PWndObjInstance(GetWindowLong(aWnd, GWL_USERDATA));
  if Assigned(ObjInst) and Assigned(ObjInst.WndMethod) then
  begin
    Msg.Msg := aMsg;
    Msg.wParam := wParam;
    Msg.lParam := lParam;
    ObjInst.WndMethod(Msg);
    Result := Msg.Result;
  end
  else
    Result := DefWindowProc(aWnd, aMsg, wParam, lParam)
end;

var
  TLMDWindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @XDefWindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'LMDXUtilWindow');

function LMDAllocateHWND(Obj: TObject; WndMethod: TLMDWndMethod): HWND; overload;
begin
  Result := LMDAllocateHWND(Obj, WndMethod, 'LMDXUtilWindow', '');
end;

function LMDAllocateHWND(Obj: TObject; WndMethod: TLMDWndMethod; AWindowClass, AWindowName: String): HWND; overload;
var
  TempClass: TWndClass;
  ClassRegistered: Boolean;
  ObjInst: PWndObjInstance;
begin
  TLMDWindowClass.hInstance := HInstance;
  TLMDWindowClass.lpszClassName := PChar(AWindowClass);
  ClassRegistered := GetClassInfo(HInstance, TLMDWindowClass.lpszClassName, TempClass);
  if not ClassRegistered or (TempClass.lpfnWndProc <> @DefWindowProc) then
  begin
    if ClassRegistered then
      Windows.UnregisterClass(TLMDWindowClass.lpszClassName, HInstance);
    Windows.RegisterClass(TLMDWindowClass);
  end;
  Result := CreateWindowEx(WS_EX_TOOLWINDOW, TLMDWindowClass.lpszClassName, PChar(AWindowName), WS_POPUP, 0, 0, 0, 0, 0, 0, HInstance, nil);
  GetMem(ObjInst, sizeof(TWndObjInstance));
  ObjInst.Obj := Obj;
  ObjInst.WndMethod := WndMethod;
  SetWindowLong(Result, GWL_USERDATA, TLMDPtrInt(ObjInst));
end;

procedure LMDDeallocateHWND(Wnd: HWND);
var
  ObjInst: PWndObjInstance;
begin
  ObjInst := PWndObjInstance(GetWindowLong(Wnd, GWL_USERDATA));
  DestroyWindow(Wnd);
  FreeMem(ObjInst);
end;

{******************** Form/Application related functions **********************}
{------------------------------------------------------------------------------}
procedure LMDActivatePrevInstance;
//var
//  wnd:HWND;
//  tmp:String;
begin
   if not LMDApplication.IsPrevRunning then
     exit;
// 8.07
//   tmp:=Application.Title;
//   SetWindowText(Application.Handle, '');
//   wnd:=FindWindow('TApplication', int_Ref(tmp));
   {$IFDEF LMDCOMP11}
   SendMessage(LMDApplication.PreviouseAppWin, WM_SYSCOMMAND, SC_RESTORE, 0);
   {$ENDIF}
   // 8.05, 8.07
   LMDSetForegroundWindow(LMDApplication.PreviouseAppWin)
end;

{------------------------------------------------------------------------------}
function LMDSetForegroundWindow(HWnd: THandle): Boolean;
var
  ForegroundThreadID: DWORD;
  ThisThreadID: DWORD;
  timeout: LongInt;
begin
  if IsIconic(HWnd) then
    ShowWindow(HWnd, SW_RESTORE);

  result := THandle(GetForegroundWindow) = HWnd;
  if result then exit;

  if (LMDSIWindowsNT and (Win32MajorVersion > 4)) or (LMDSIWindows98 or LMDSIWindowsME) then
    begin
      result := false;
      ForegroundThreadID := GetWindowThreadProcessID(GetForegroundWindow, nil);
      ThisThreadID := GetWindowThreadPRocessId(HWnd, nil);
      if AttachThreadInput(ThisThreadID, ForegroundThreadID, true) then
        begin
          BringWindowToTop(HWnd);
          SetForegroundWindow(HWnd);
          AttachThreadInput(ThisThreadID, ForegroundThreadID, False);
          result := THandle(GetForegroundWindow) = HWnd;
        end;
      if not result then
        begin
          SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
          SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0)
                , SPIF_SENDCHANGE);
          BringWindowToTop(HWnd);
          SetForegroundWindow(HWnd);
          SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(timeout), SPIF_SENDCHANGE);
        end;
    end
  else
    begin
      BringWindowToTop(HWnd);
      SetForegroundWindow(HWnd);
    end;
  result := THandle(GetForegroundWindow) = HWnd;
end;

{------------------------------------------------------------------------------}
procedure LMDWait(ms: LongWord);
var
  waituntil: LongWord ;
begin
  if ms<=0 then exit;
  waituntil:=GetTickCount+ms;
  repeat
    Application.ProcessMessages;
  until (Application.Terminated) or (GetTickCount>waitUntil);
end;

{------------------------------------------------------------------------------}
function LMDCenterChild(frmParent, frmchild: TCustomForm; flag:Boolean=true):TModalResult;
var
  l,t:integer;
  Monitor: TMonitor;

begin

  result:=0;
  if (frmParent=nil) or (frmchild=nil) then exit;
  if frmChild is TForm then
    TForm(frmchild).Position:=poDesigned;

  if Application.MainForm <> nil then
    begin
      if Assigned(Screen.ActiveForm) then
        Monitor := Screen.ActiveForm.Monitor
      else
        Monitor := Application.MainForm.Monitor;
    end
  else
    Monitor := Screen.Monitors[0];

  l:= frmParent.Left + ((frmParent.Width - frmchild.Width) div 2);
  if (l + frmchild.Width) > Monitor.Width then l:= Monitor.Width - frmchild.Width;
  if l<0 then l:=0;

  t := frmParent.Top + ((frmParent.Height - frmchild.Height) div 2);
  if (t + frmchild.Height) > Monitor.Height then t:= Monitor.Height - frmchild.Height;
  if t<0 then t:=0;

  with frmChild do
    begin
      SetBounds(l,t, Width, Height);
      if flag then result:=ShowModal;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDCenterForm(frm:TCustomForm);
var
  Monitor: TMonitor;

begin
   if frm<>nil then
     begin
       if Application.MainForm <> nil then
         begin
           if Assigned(Screen.ActiveForm) then
             Monitor := Screen.ActiveForm.Monitor
           else
             Monitor := Application.MainForm.Monitor;
         end
       else
         Monitor := Screen.Monitors[0];

      frm.SetBounds((Monitor.Width-frm.Width) div 2, (Monitor.Height-frm.Height) div 2, frm.Width, frm.Height);
    end;
end;

//4.0
{------------------------------------------------------------------------------}
procedure LMDCenterChildWindow(Parent,Child:Hwnd; AtTop: Boolean);
var
  rp, rc:TRect;
  x, y, tmp:Integer;
begin
  if child=0 then exit;
  GetWindowRect(Parent, rp);
  GetWindowRect(child, rc);
  tmp:=rc.Right-rc.Left;
  x:=rp.Left+(((rp.Right-rp.Left) - tmp) div 2);
  if (x+tmp)>Screen.Width then x:=Screen.Width-tmp;
  tmp:=rc.Bottom-rc.Top;
  y:=rp.Top+(((rp.Bottom-rp.Top) - tmp) div 2);
  if (y+tmp)>Screen.Height then y:=Screen.Height-tmp;
  if y<0 then y:=0;
  if AtTop then tmp:=HWND_TOP else tmp:=0;
  SetWindowPos(child, tmp, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

{------------------------------------------------------------------------------}
procedure LMDCenterWindow(Wnd: HWnd; AtTop: Boolean=false);
var
  r:TRect;
  x, y:Integer;
  tmp:HWnd;
  Monitor:TMonitor;
begin
  GetWindowRect(Wnd, r);
  if Application.MainForm <> nil then
    Monitor:= Application.MainForm.Monitor
  else
    Monitor:= Screen.Monitors[0];
  x:=Monitor.Left + ((Monitor.Width - r.Right + r.Left) div 2);
  y:=Monitor.Top + ((Monitor.Height - r.Bottom + r.Top) div (2+Ord(AtTop)));
  x:=LMDMax([0, LMDMin([x, Monitor.Width-(r.Right-r.Left)])]);
  y:=LMDMax([0, LMDMin([y, Monitor.Height-(r.Bottom-r.Top)])]);
  if AtTop then tmp:=HWND_TOP else tmp:=0;
  SetWindowPos(Wnd, tmp, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

{------------------------------------------------------------------------------}
procedure LMDPositionWindow(Wnd:Hwnd; aRect:TRect; APos:TLMDDlgPosition; AtTop:Boolean);
var
  r:TRect;
  x,y, w, h:Integer;
  tmp:HWnd;
begin
  GetWindowRect(Wnd, r);
  w:=r.Right-r.Left;
  h:=r.Bottom-r.Top;
  x:=0;y:=0;
  case APos of
    bpCustom,bpTopLeft:begin
                x:=aRect.Left;
                y:=aRect.Top;
              end;
    bpBottomLeft:begin
                   x:=aRect.Left;
                   y:=aRect.Bottom-h;
                 end;
    bpCenterLeft:begin
                   x:=aRect.Left;
                   y:=aRect.Top+(((aRect.Bottom-aRect.Top) - h) div 2);
                  end;
    bpTopRight:  begin
                   x:=aRect.Right-w;
                   y:=aRect.Top;
                  end;
    bpBottomRight : begin
                      x:=aRect.Right-w;
                      y:=aRect.Bottom-h;
                    end;
    bpCenterRight:begin
                     x:=aRect.Right-w;
                     y:=aRect.Top+(((aRect.Bottom-aRect.Top) - h) div 2);
                   end;
    bpTopCenter   : begin
                     x:=aRect.Left+(((aRect.Right-aRect.Left)-w) div 2);
                     y:=aRect.Top;
                    end;
    bpBottomCenter: begin
                      x:=aRect.Left+(((aRect.Right-aRect.Left)-w) div 2);
                      y:=aRect.Bottom-h;
                    end;
    bpCenter      : begin
                      x:=aRect.Left+(((aRect.Right-aRect.Left)-w) div 2);
                      y:=aRect.Top+(((aRect.Bottom-aRect.Top) - h) div 2);
                    end;
   end;

   // justify if needed
   if y+h>Screen.DesktopHeight then y:=Screen.DesktopHeight-h;  // 7.00.60 + .61
   if x+w>Screen.DesktopWidth then x:=Screen.DesktopWidth-w;    // 7.00.60 + .61
   if x<Screen.DesktopLeft then x:=Screen.DesktopLeft;
   if y<Screen.DesktopTop then y:=Screen.DesktopTop;

   if AtTop then tmp:=HWND_TOP else tmp:=0;
   SetWindowPos(Wnd, tmp, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

{------------------------------------------------------------------------------}
//JH, April 2001 Added assigned check -> otherwise, if called during application
//creation it resulted into an access violation
function LMDDlgGetTargetRect(aRel:TLMDDlgPosRel):TRect;

        function screenRect : TRect;
        begin
          result := Rect(0,0,Screen.Width, Screen.Height);
        end;

begin
   Case aRel Of
     brMainForm:        if assigned (Application.MainForm) then
                          result := Application.MainForm.BoundsRect
                        else
                          result := screenRect;
     brActiveWindow:    if assigned (Screen.ActiveForm) then
                          result:=Screen.ActiveForm.BoundsRect
                        else
                          result := screenRect;
     brScreenWorkArea:
        with Screen do result:=Rect(WorkAreaLeft, WorkAreaTop, WorkAreaWidth, WorkAreaHeight);
   else
     result := screenRect;
   end;
end;

{------------------------------------------------------------------------------}
function LMDShowModal(aClass:TFormClass; owner:TComponent):TModalResult;
begin
  with aClass.Create(Owner) do
    try
      result:=ShowModal;
    finally
      Destroy;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDExplodeForm(aForm:TCustomForm);
begin
  LMDExplodeFormExt(aForm, -1,0, 40, LMDApplication.DlgEffectDelay);
end;

{------------------------------------------------------------------------------}
procedure LMDExplodeFormExt(aForm:TCustomForm; X,Y, Steps, Delay:Integer);
var
  tp:TPoint;
  aRect:TRect;
  DC:HDC;
  vx, vy, vw, vh:Real;

    procedure DrawFrame;
    var
      i,k:Integer;
      iRect:TRect;
    begin
      For i:=1 To Steps do
        begin
          for k:=0 to Delay*10000 do ;
          iRect.Left:=Trunc(i*vx+X);
          iRect.Top:=Trunc(i*vy+Y);
          iRect.Right:=Trunc(i*vw+iRect.Left);
          iRect.Bottom:=Trunc(i*vh+iRect.Top);
          DrawFocusRect(DC, iRect);
        end;
    end;

begin

  if (aForm=nil) {or (aForm.Visible)} then exit;

  If X<0 then
    begin
      GetCursorPos(tp);
      X:=tp.X;Y:=tp.Y;
    end;

  if Steps<=3 then Steps:=40;
  If Delay<=0 then Delay:=1;

  DC:=GetDC(0);
  try
    GetWindowRect(AForm.Handle, aRect);
    with aRect do
      begin
        vx:= (Left-X)/ Steps;
        vy:= (Top-Y)/ Steps;
        vw:= (Right - Left)/Steps;
        vh:= (Bottom - Top)/Steps;
        DrawFrame;
        DrawFrame;
      end;
  finally
    ReleaseDC(0,DC);
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDGetOwnerForm(Component: TComponent): TForm;
begin
  result := nil;
  while (not (Component is TForm)) and (Component.Owner <> nil) do
    Component := Component.Owner;
  if Component is TForm then result := (Component as TForm);
end;

{------------------------------------------------------------------------------}
function LMDGetOwnerFrameForm(Component: TComponent): TWinControl;
begin
  Result := nil;
  while (not ((Component is TForm) or (Component is
    TFrame))) and (Component.Owner <> nil) do
  begin
    Component := Component.Owner;
    Result := (Component as TWinControl);
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDExplodeForm2(aForm:TCustomForm);
begin
  LMDExplodeFormExt2(aForm, -1,0, 40, 20, 10, LMDApplication.DlgEffectDelay, True);
end;

{------------------------------------------------------------------------------}
procedure LMDExplodeFormExt2(aForm:TCustomForm; X,Y, Steps, smWidth, smHeight,
                             Delay:Integer; Flag:Boolean);
var
  tp:TPoint;
  aRect:TRect;
  DC:HDC;
  j, xh, yh:Integer;
  vx, vy, vw, vh:Real;

    procedure DrawFrame(x1,y1:Integer);
    var
      i,k:Integer;
      iRect:TRect;
    begin
      For i:=1 To Steps do
        begin
          for k:=0 to Delay*10000 do ;
          iRect.Left:=Trunc(i*vx+x1);
          iRect.Top:=Trunc(i*vy+y1);
          iRect.Right:=Trunc(i*vw+iRect.Left+smWidth);
          iRect.Bottom:=Trunc(i*vh+iRect.Top+smHeight);
          DrawFocusRect(DC, iRect);
        end;
    end;

begin

  if (aForm=nil) {or (aForm.Visible)} then exit;
  If X<0 then
    begin
      GetCursorPos(tp);
      X:=tp.X;Y:=tp.Y;
    end;

  if Steps<=3 then Steps:=40;
  If Delay<=0 then Delay:=1;
  DC:=GetDC(0);
  try
    GetWindowRect(AForm.Handle, aRect);
    for j:=0 to 1 do
      with aRect do
        begin
          xh:=(Left-X) div 2 + X;yh:=Bottom;
          vx:=(xh-X) / Steps; vy:=(yh-Y) / Steps; vw:=0; vh:=0;
          if flag then DrawFrame(X,Y);
          vx:=(Left - XH) / Steps; vy:=(Top-YH) / Steps;
          vw:=(Right-Left-smWidth) / Steps; vh:=(Bottom-Top-smHeight) / Steps;
          DrawFrame(XH,YH);
        end;
  finally
    ReleaseDC(0,DC);
  end;
end;

{------------------------------------------------------------------------------}
function LMDHasClipboardFormat(Handle: THandle; Index: integer): boolean;
 var Fmt : integer;
begin
  result := false;
  if not OpenClipboard(Handle) then Exit;
  try
    Fmt := EnumClipboardFormats(0);
    while Fmt <> 0 do
    begin
      if Fmt = Index then
      begin
        result := true;
        break;
      end;
      Fmt := EnumClipboardFormats(Fmt);
    end;
  finally
    CloseClipboard;
  end;
end;

{------------------------------------------------------------------------------}
function LMDGetClipboardFormatName(AFormat: integer): string;
 const
   FormatNames : array[1..16] of string =
     ('TEXT', 'BITMAP', 'METAFILEPICT', 'SYLK', 'DIF', 'TIFF',
     'OEMTEXT', 'DIB', 'PALETTE', 'PENDATA', 'RIFF', 'WAVE',
     'UNICODETEXT', 'ENHMETAFILE', 'HDROP', 'LOCALE');
begin
  if (AFormat >= CF_TEXT) and (AFormat <= CF_LOCALE) then
    Result := FormatNames[AFormat]
  else
  begin
    SetLength(Result, 128);
    SetLength(Result, GetClipboardFormatName(AFormat, PChar(Result), Length(Result) ));
    end;
end;

{------------------------------------------------------------------------------}
function LMDGetClipboardFormatIndex(const FormatName: string): integer;
 const
   FormatNames = ':TEXT:BITMAP:METAFILEPICT:SYLK:DIF:TIFF:OEMTEXT:DIB:PALETTE:' +
     'PENDATA:RIFF:WAVE:UNICODETEXT:ENHMETAFILE:HDROP:LOCALE:';
 var
   S : string;
begin
  S := UpperCase(FormatName);
  case Pos(':' + S + ':', FormatNames) of
    1    : Result := CF_TEXT;
    6    : Result := CF_BITMAP;
    13   : Result := CF_METAFILEPICT;
    26   : Result := CF_SYLK;
    31   : Result := CF_DIF;
    35   : Result := CF_TIFF;
    40   : Result := CF_OEMTEXT;
    48   : Result := CF_DIB;
    52   : Result := CF_PALETTE;
    60   : Result := CF_PENDATA;
    68   : Result := CF_RIFF;
    73   : Result := CF_WAVE;
    78   : Result := CF_UNICODETEXT;
    90   : Result := CF_ENHMETAFILE;
    102  : Result := CF_HDROP;
    108  : Result := CF_LOCALE;
  else
         Result := RegisterClipboardFormat(PChar(S));
         end;
end;

{ ---------------------------------------------------------------------------- }
function LMDConvertVCLHint(const  Hint: TLMDString): String;
{$IFNDEF LMD_NATIVEUNICODE}
var
  i,l : integer;
  T : WideChar;
{$ENDIF}
begin
  Result := Hint;
  // ToDo Alex
  {$IFDEF LMD_NATIVEUNICODE}
  //Result := result + #0 + Hint+ #0; //Jan 19 2009 [VB]
  {$ELSE}
  i:=Length(result);
  l:=Length(result)+1+Length(Hint)*2;
  SetLength(result, l+4);
  result[i+1]:= #0;
  Move(Hint[1], result[i+2], Length(Hint)*2);
  T:=#0;
  Move(T, result[l+1],sizeof(T));
  T:=#$FFFE;
  Move(T,result[l+3],sizeof(T));
  {$ENDIF}
end;

function LMDConvertUnicodeHint(const AHint: String): TLMDString;
{$IFNDEF LMD_NATIVEUNICODE}
{$IFDEF LMD_UNICODE}
var
  i: Integer;
  LHint: String;
{$ENDIF}
{$ENDIF}
begin
  {$IFDEF LMDCOMP12}
  Result := AHint;
  {$ELSE LMDCOMP12}
  {$ifdef LMD_UNICODE}
  Result := AHint;
  if (Length(AHint) > 4) then
  begin
    if Copy(AHint, Length(AHint) - 3, 4) = #00#00#$FE#$FF then
    begin
      i := StrLen(PChar(AHint)) + 1;
      SetLength(Result, (Length(AHint) - i - 4) div 2);
      Move(AHint[i + 1], Result[1], Length(Result) * 2);
      Result := LMDWideGetShortHint(Result);
    end
    else
      if Copy(AHint, Length(AHint) - 3, 4) = #00#00#$FF#$FF then
      begin
        LHint := AHint;
        if Length(LHint) mod 2 = 1 then
          Delete(LHint, 1, 1);
        SetLength(Result, (Length(LHint) - 4) div 2);
        Move(LHint[1], Result[1], Length(Result) * 2);
      end;
  end;
  {$ENDIF LMD_UNICODE}
  {$ENDIF LMDCOMP12}
end;

{$ifdef LMD_UNICODE}
{ ---------------------------------------------------------------------------- }
function LMDWideGetShortHint(Hint: WideString): WideString;
var
  I: Integer;
begin
  // WidePos
  I := Pos('|', Hint);
  if I = 0 then
    Result := Hint
  else
    Result := Copy(Hint, 1, I - 1); // WideCopy
end;

{ ---------------------------------------------------------------------------- }
procedure LMDConvertVCLHintShow(const InHint: String; const FHint: TLMDString; var Message: TCMHintShow);
var
  l : integer;
  S : String;
  WS: WideString;

  T: WideChar;
  HintInfo: PHintInfo;

begin
  HintInfo := Message.HintInfo;
  if Length(FHint) = 0 then
    begin
      HintInfo.HintStr := '';
      exit;
    end;

  S := GetShortHint(inHint);  //inherited Hint.
  if HintInfo.HintStr = S then
    WS := LMDWideGetShortHint(FHint)
  else
    begin
      S := FHint;
      WS := FHint;
    end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);
  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
  end;
{$endif LMD_UNICODE}



{------------------------------------------------------------------------------}
function LMDConvertBreaksFormat(Text : TLMDString) : TLMDString;
var
  i : integer;
  {$IFDEF LMD_UNICODE}
  S : WideString;
  {$ENDIF}
begin
  result := Text;
  i := 1;
  while i < Length(result) do
  begin
    if Result[i + 1] = #10 then
    begin
      {$IFDEF LMD_UNICODE}
      S := Result;
      LMDWideInsert(#13, S, i + 1);
      result := S;
      {$ELSE}
      insert(#13, Result, i + 1);
      {$ENDIF}
      inc(i, 2);
    end
    else if Result[i + 1] = #13 then
    begin
      {$IFDEF LMD_UNICODE}
      S := Result;
      LMDWideInsert(#10, S, i + 2);
      result := S;
      {$ELSE}
      insert(#10, Result, i + 2);
      {$ENDIF}
      inc(i, 2);
    end
    else
      inc(i);
  end;
end; {ConvertBreaksFormat}

{------------------------------------------------------------------------------}
function LMDGetTextFromClipBoard: TLMDString;
var
  Clip : TClipboard;
  {$IFDEF _LMD_UNICODEIMPL}
  mem: Cardinal;
  ptr: Pointer;
  StrEnd : PWideChar;
  {$ENDIF}
begin
  Clip := Clipboard;
  Clip.Open;
  {$IFDEF _LMD_UNICODEIMPL}
  if not Clipboard.HasFormat(CF_UNICODETEXT) then
  begin
    result := Clip.AsText;
  end
  else
  begin
    mem := Clipboard.GetAsHandle(CF_UNICODETEXT);
    SetLength(result, GlobalSize(mem));
    ptr := GlobalLock(mem);
    Move(ptr^, PWideChar(result)^, Length(result));
    StrEnd := LMDWideStrScan(PWideChar(result), #0);
    if StrEnd <> nil then
      SetLength(result, StrEnd - PWideChar(result));
    GlobalUnlock(mem);
    end;
  {$ELSE}
  result := Clip.AsText;
  {$ENDIF _LMD_UNICODEIMPL}
  Clip.Close;
end;

{------------------------------------------------------------------------------}
procedure LMDCopyTextToClipboard(AText: TLMDString; aConvertBreaksFmt: boolean = false);
var
  Clip: TClipboard;

{$IFDEF LMD_UNICODE}
  mem: Cardinal;
  ptr: Pointer;
  SelText: WideString;
  SelLen: integer;
  S: string;
{$ENDIF}

begin
  Clip := Clipboard;
  Clip.Open;

{$IFDEF LMD_UNICODE}
  SelText := AText;
  SelLen := (Length(SelText) + 1) * 2;
  mem := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, SelLen);
  ptr := Windows.GlobalLock(mem);
  Move(PWideChar(SelText)^, ptr^, SelLen);
  Windows.GlobalUnlock(mem);
  Clip.SetAsHandle(CF_UNICODETEXT, mem);
  // if Win32Platform <> VER_PLATFORM_WIN32_NT then
  //begin
  S := SelText;
  SelLen := Length(S) + 1;
  mem := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, SelLen);
  ptr := Windows.GlobalLock(mem);
  Move(PChar(S)^, ptr^, SelLen);
  Windows.GlobalUnlock(mem);
  Clip.SetAsHandle(CF_TEXT, mem);
  //end;
{$ELSE}
  if (aConvertBreaksFmt) then
    Clip.AsText := LMDConvertBreaksFormat(aText)
  else
    Clip.AsText := aText;
{$ENDIF}
  Clip.Close;
end;

initialization
  AlphaBlendFunc := nil;
  HMSILib := LoadLibrary(msimg32);
  if HMSILib <> 0 then
    begin
      AlphaBlendFunc := GetProcAddress(hMSILib,'AlphaBlend');
      TransparentBltFunc := GetProcAddress(hMSILib,'TransparentBlt');
      end;

finalization
  if hMSILib<>0 then
    FreeLibrary(hMSILib);

end.
