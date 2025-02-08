unit pLMDCPGetBase;
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

LMD-Tools Common Object access methods (RM)
-------------------------------------------
Impements LMDCPGet[..] methods for shared objects/types in LMD-Tools.

Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  RtlConsts, StdCtrls, ExtCtrls, Forms, Windows, Classes, Graphics,
  LMDDateTime;

  function LMDCPGetCaption(const aValue:String; aMaxLength:Integer):String;
  function LMDCPGetBrush(aBrush:TBrush):Boolean;
  function LMDCPGetDateTime(aDateTime:TLMDDateTime):Boolean;
  function LMDCPGetShortCut(var Value:TShortCut):Boolean;

  // from LMDUtils
  procedure LMDComLoadCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
  procedure LMDComSaveCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);

  {$R plmdpestr.dfm}

type
  TLMDStrEditorDlg = class(TForm)
    sh: TLabel;
    str: TMemo;
    Label2: TLabel;
    Bevel1: TBevel;
    lh: TEdit;
    lbh: TLabel;
    ok: TButton;
    cancel: TButton;
    beditor: TButton;
  end;

const
  BoolStr:array[Boolean] of String=(' [False]', ' [True]');
  implementation
uses
  Consts, Messages, Controls, ExtDlgs, Dialogs, SysUtils, Inifiles, Registry,
  pLMDComBrushDlg, pLMDDateTimeEditorDlg, pLMDHotKeyEditorDlg;

{ ---------------------------------------------------------------------------- }
function LMDCPGetCaption(const aValue:String; aMaxLength:Integer):String;
var
  dlg:TLMDStrEditorDlg;

begin
  result:=aValue;
  dlg:=TLMDStrEditorDlg.Create(nil);
  with dlg, dlg.Str do
    try
       Caption:='String-Editor';
       ScrollBars:=ssBoth;
       Text:=aValue;
       if MaxLength<>-1 then
         MaxLength:=aMaxLength
       else
         MaxLength:=MaxInt;
       SelStart:=0;
       SelLength:=Length(aValue);
       if ShowModal=mrOK then result:=Text;
    finally
      dlg.Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetBrush(aBrush:TBrush):Boolean;
var
  BEditor: TLMDComBrushEditorDlg;
begin
  result:=False;
  BEditor := TLMDComBrushEditorDlg.Create(Application);
  with BEditor do
    try
      test.Brush.Assign(aBrush);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aBrush.Assign(test.Brush);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
function LMDCPGetDateTime(aDateTime:TLMDDateTime):Boolean;
var
  DateTimeEditor: TLMDFrmDateTimeEditor;
begin
  result:=False;
  DateTimeEditor := TLMDFrmDateTimeEditor.Create(Application);
  with DateTimeEditor do
    try
      with aDateTime do
        begin
          DayEdit.Value := Day;
          MonthEdit.Value := Month;
          YearEdit.Value := Year;
          HourEdit.Value := Hour;
          MinuteEdit.Value := Minute;
          SecondEdit.Value := Second;
        end;
      if Showmodal=mrOK then
        with aDateTime do
          begin
            Day := DayEdit.Value;
            Month := MonthEdit.Value;
            Year := YearEdit.Value;
            Hour := HourEdit.Value;
            Minute := MinuteEdit.Value;
            Second := SecondEdit.Value;
            result := true;
          end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDComLoadCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
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
procedure LMDComSaveCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
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

{ ---------------------------------------------------------------------------- }
function LMDCPGetShortCut(var Value:TShortCut):Boolean;
begin
  result:=false;
  with TLMDfrmHotkeyEditor.Create(nil) do
    try
      edHotkey.Hotkey:=Value;
      if ShowModal=mrOk then
        begin
          Value:=edHotkey.Hotkey;
          result:=true;
        end;
    finally
      Release;
    end;
end;

end.

