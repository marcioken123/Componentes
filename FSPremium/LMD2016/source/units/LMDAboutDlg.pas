unit LMDAboutDlg;
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

LMDAboutDlg unit ()
-------------------

Standard about dialog component.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics,  Classes, Forms, Dialogs,
  LMDBaseDialog;

type
  TLMDAboutStyle=(bsStandard, bsLMD);
  TLMDAboutIconStyle=(isNone, isStandard, isExtended);
  TLMDAboutVersionStyle=(vsProg, vsFileShort, vsFileFull, vsFileBuild);

  TLMDAboutDlg = class(TLMDBaseDialog)
  private
    FAppname,
    FCopyright,
    FJump,
    FEmail,
    FDescription: String;
    FDefault:Boolean;
    FIcon:TIcon;
    FIconStyle:TLMDAboutIconStyle;
    FSize:Integer;
    FStyle:TLMDAboutStyle;
    FVersion:String;
    FUseResInfo:Boolean;
    FUseResVersionInfo:TLMDAboutVersionStyle;
    procedure SetIcon(aIcon:TIcon);
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function Execute:Boolean;override;
    function ExecuteEnh(aForm:TForm):Boolean;
    property CtlXP; // compatiblity
    {used internally}
    property Icon:TIcon read FIcon write SetIcon;
  published
    property About;
    property Appname:String read FAppname write FAppname;
    property AppNameSize:Integer read FSize write FSize default 22;
    property CaptionFill;
    property CaptionTitle;
    property Copyright: String read FCopyright write FCopyright;
    property Colors;
    property CustomButton;
    property Description: String read FDescription write FDescription;
    property Effect;
    property EMail : String read FEmail write FEmail;
    property Hints;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property IconStyle:TLMDAboutIconStyle read FIconStyle write FIconStyle default isExtended;
    property Jump:String read FJump write FJump;
    property Position;
    property RelatePos;
    property ShowHints;
    property Style: TLMDAboutstyle read FStyle write FStyle default bsLMD;
    property ThemeMode; // 9.0
    property ThemeGlobalMode;    
    property UseDefault:Boolean read FDefault write FDefault default false;
    property UseResInfo:Boolean read FUseResInfo write FUseResInfo default false;
    property UseResVersionInfoStyle:TLMDAboutVersionStyle read FUseResVersionInfo write FUseResVersionInfo default vsProg;
    property Version:String read FVersion write FVersion;

    {Events}
    property OnCustomize;
    property OnCustomClick;
  end;

implementation

uses
  Types, ShellAPI, SysUtils, Controls, ExtCtrls, StdCtrls, LMDSysIn, LMDClass, LMDBase,
  LMDProcs, LMDUtils, LMDConst, LMDGraph, LMDButton, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDFormStyler, LMDBack, LMDStrings, LMDGraphUtils;

{------------------------- Private --------------------------------------------}
procedure TLMDAboutDlg.SetIcon(aIcon:TIcon);
begin
  FIcon.Assign(aIcon);
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDAboutDlg.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FDefault:=False;
  FIcon:=TIcon.Create;
  FSize:=22;
  FStyle:=bsLMD;
  FIconStyle:=isExtended;
end;

{------------------------------------------------------------------------------}
destructor TLMDAboutDlg.Destroy;
begin
  FIcon.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
Function TLMDAboutDlg.Execute:Boolean;
begin
  {Wrapper for Execute}
  result:=ExecuteEnh(nil);
end;

{------------------------------------------------------------------------------}
function TLMDAboutDlg.ExecuteEnh(aForm:TForm):Boolean;
var
  AboutBox:TForm{LMDAboutBox};
  {3.02}
  sIcon:TImage;
  ok, custom:TLMDButton;
  line3D:TBevel;
  AppName, version, description, copyright,
  infolabel, info, link, email:TLMDSimpleLabel;
  fs:TLMDFormStyler;
  b:TLMDBack;
  {--}
  h1:HWND;
  tmp, tmpc:String;
  inIcon:TIcon;
  bmp, bmp2:TBitmap;

  pc1, pc2:array[0..255] of char;
  dScaleFactor: Double;
  tmp_i,
  leftpos, topPos, tmo1:Integer;

  procedure SetLabel(c:TLMDSimpleLabel; const s:String; y:Integer);
  var
    tmp:Integer;
  begin
    if s<>'' then
      begin
        c.AutoSize := false;
        if LeftPos+tmo1>AboutBox.ClientWidth then
          tmp:=AboutBox.ClientWidth-6
        else
          tmp:=tmo1;
        with c do SetBounds(LeftPos, TopPos, tmp {Width}, 24);
        c.Caption:=s;
        c.AutoSize := True;
        if y<>0 then inc(TopPos, c.Height +Y );
      end;
  end;

begin

  bmp:=nil;
  bmp2:=nil;
  inIcon:=nil;

  {used for both Styles}
  if LMDAnsiEmpty(FAppName) then
    begin
      if FUseResInfo then
        tmp:=LMDSIVersionInfo(viName)
      else
        tmp:=Application.Title;
    end
  else
    tmp:=FAppname;

  tmpc:=FCopyRight;
  if FUseResInfo and (tmpc='') then tmpC:=#13+LMDSIVersionInfo(viCopyRight);
  if FDefault and (tmpc='') then tmpC:=#13'Copyright © by '+LMDApplication.Company;

  if FStyle=bsLMD then
    begin
      AboutBox:=TForm.Create(Application);

      with AboutBox do
        try
          BorderStyle:=bsDialog;
          Font := self.Font;
          Position:=poDefault;
          PixelsPerInch := 96;
          dScaleFactor := Screen.PixelsPerInch / PixelsPerInch;
          if dScaleFactor < 1 then dScaleFactor := 1;


          {create additional resources}
          sIcon:=TImage.Create(AboutBox);
          with sIcon do
            begin
              Parent:=AboutBox;
              Left:=15;
              Top:=7;
              Stretch:=True;
            end;

          ok:=TLMDButton.Create(AboutBox);
          with ok do
            begin
              Parent:=AboutBox;
              ModalResult:=1;
              Caption:='OK';
              Default:=True;
              Cancel:=True;
              TabOrder:=0;
            end;
          ActiveControl:=ok;

          custom:=TLMDButton.Create(AboutBox);
          with custom do
            begin
              Parent:=AboutBox;
              TabOrder:=1;
              Visible:=False;
            end;

          line3D:=TBevel.Create(AboutBox);
          line3D.Parent:=AboutBox;
          with line3D do
            begin
              Left:=96;
              Top:=181;
              Width:=153;
              Height:=3;
              Shape:=bsTopLine;
            end;

          AppName:=TLMDSimpleLabel.Create(AboutBox);
          with Appname do
            begin
              Parent:=AboutBox;
              Left:=93;
              Top:=18;
              Font.Name:=LMD_DEFAULTFONT;
              Font.Style:=[fsBold];
              Font3D.Style:=tdSunken;
              MultiLine:=True;
              ShowAccelChar:=False;
            end;

          version:=TLMDSimpleLabel.Create(AboutBox);
          description:=TLMDSimpleLabel.Create(AboutBox);
          copyright:=TLMDSimpleLabel.Create(AboutBox);
          infolabel:=TLMDSimpleLabel.Create(AboutBox);
          info:=TLMDSimpleLabel.Create(AboutBox);
          with infolabel do
            begin
              Parent:=AboutBox;
              MultiLine:=True;
              ShowAccelChar:=False;
              //CONDEV 20050331
              name:='lblinfo1';
            end;

          with info do
            begin
              Parent:=AboutBox;
              MultiLine:=True;
              ShowAccelChar:=False;
              //CONDEV 20050331
              name:='lblinfo2';

            end;

          with version do
            begin
              Parent:=AboutBox;
              MultiLine:=True;
              ShowAccelChar:=False;
              Font.Style:=[fsBold];
            end;

          with description do
            begin
              Parent:=AboutBox;
              MultiLine:=True;
              ShowAccelChar:=False;
            end;

          with copyright do
            begin
              Parent:=AboutBox;
              MultiLine:=True;
              ShowAccelChar:=False;
            end;

          link:=TLMDSimpleLabel.Create(AboutBox);
          with link do
            begin
              Parent:=AboutBox;
              Font.Color:=clBlue;
              Font.Style:=[fsUnderline];
              MultiLine:=True;
              ShowAccelChar:=False;
              JumpMode:=jmInternet;
            end;

          email:=TLMDSimpleLabel.Create(AboutBox);
          with email do
            begin
              Parent:=AboutBox;
              Font.Color:=clBlue;
              Font.Style:=[fsUnderline];
              MultiLine:=True;
              ShowAccelChar:=False;
              JumpMode:=jmInternet;
            end;

          fs:=TLMDFormStyler.Create(AboutBox);
          fs.Enabled:=False;
          fs.Options:=[fsAdjustRect, fsUseDefaultFont, fsUseFormCaption];

          b:=TLMDBack.Create(AboutBox);
          b.Enabled:=False;

          {-----------------}
          tmo1:=0;
          AppName.Font.Size:=FSize;

          if FIconStyle<>isNone  then
            if not FIcon.Empty then inIcon:=FIcon else inIcon:=Application.Icon;

          {required because of minor quirk in Delphi 2.01}
          Width:= Trunc(520*dScaleFactor);
          case FIconStyle of
            isNone:
              begin
                width:=Trunc(400*dScaleFactor);
                topPos:=10;
                leftPos:=10;
                SIcon.Visible:=False;
                tmo1:=ClientWidth;
                AppName.SetBounds(LeftPos,12, tmo1,0);
                SetLabel(appname, tmp, 10);
                if topPos<60 then topPos:=60;
              end;
            isStandard:
                begin
                  SIcon.Left:=13;
                  SIcon.Picture.Icon:=inIcon;
                  Width:=Width-30;
                  topPos:=12;
                  leftpos:=60;
                  tmo1:=ClientWidth-70;
                  AppName.SetBounds(LeftPos, 12,tmo1,0);
                  SetLabel(appname, tmp, 10);
                  if topPos<66 then topPos:=66;
                end;
            isExtended:
              begin
                bmp:=TBitmap.Create;
                LMDIcon2Bitmap(inIcon, bmp, clBtnFace);
                bmp2:=TBitmap.Create;
                // 5.07
                sicon.transparent:=true;
                with bmp2, bmp2.Canvas do
                  begin
                    Width:=2*inIcon.Width+8;
                    Height:=2*inIcon.Height+8;
                    Brush.color:=clbtnface;
                    FillRect(Rect(0,0,width,height));
                    Brush.color:=clgray;
                    FillRect(Rect(6,height-6,width,height));
                    FillRect(Rect(width-6,6,width,height));
                    StretchDraw(Rect(1,1, width-6, height-6),bmp);
                    Brush.color:=clblack;
                    FrameRect(Rect(0,0,width-5, height-5));
                  end;

                SIcon.Picture.Bitmap:=bmp2;
                leftpos:=SIcon.Left+SIcon.Width+8;
                topPos:=24{SIcon.Top+SIcon.Height};
                tmo1:=ClientWidth-LeftPos-6;
                AppName.SetBounds(LeftPos, 24, tmo1,0);
                SetLabel(appname, tmp, 10);
                if topPos<SIcon.Top+SIcon.Height then topPos:=SIcon.Top+SIcon.Height;
              end;
          end;

          version.Width:=tmo1;
          description.Width:=tmo1;
          copyright.Width:=tmo1;

          {settings of Control on form}
          if FVersion<>'' then
            SetLabel(version, FVersion, 6)
          else
            if FUseResInfo then
              begin
                case FuseResVersionInfo of
                  vsProg: SetLabel(version, 'Version '+LMDSIVersionInfo(viVersion), 6);
                  vsFileShort: SetLabel(version, 'Version '+LMDSIVersionInfo(viFileVersion), 6);
                  vsFileFull: SetLabel(version, 'Version '+LMDSIVersionInfo(viFileVersionFull), 6);
                  vsFileBuild: SetLabel(version, 'Version '+LMDSIVersionInfo(viFileVersionBuild), 6);
                end;
              end
            else
              if FDefault then
                SetLabel(version, 'Version '+LMDApplication.Version, 6);

          if LMDAnsiEmpty(FDescription) then
            begin
              if FUseResInfo then
                 SetLabel(description, LMDSIVersionInfo(viDescription), 6)
              else
                inc(topPos, 6);
            end
          else
            SetLabel(description, FDescription, 6);

          SetLabel(copyright, tmpc, 4);

          tmp_i := 6;
          if not LMDAnsiEmpty(FEmail) then
            tmp_i := 3;
            if LMDAnsiEmpty(FJump) then
            begin
              Inc(TopPos, tmp_i);
              Link.Visible:=False;
            end
          else
            SetLabel(Link, FJump, tmp_i);

          if LMDAnsiEmpty(FEmail) then
            begin
              Inc(TopPos, 6);
              email.Visible:=False;
            end
          else
            SetLabel(email, FEmail, 6);

          Line3D.SetBounds(LeftPos, TopPos, tmo1, 2); inc(TopPos, 9);

          tmo1:=Trunc(300*dScaleFactor);
          if LMDSIWindowsNT then
            begin
              SetLabel(infoLabel, Format('%s'#13'%s',[IDS_AboutAvailMemory, IDS_AboutPlatform]), 0);
              inc(LeftPos, infoLabel.Width + 4);
              SetLabel(info, Format('%d KB'#13'%dx %s', [TRUNC(LMDSIMemTotal/1024),
                      LMDSIProcessorCount, LMDSIProcessorTypeStr+' '+IDS_ABOUTCOMPATIBLE]), 0);
            end
          else
            begin
              SetLabel(infoLabel, Format('%s'#13'%s',[IDS_AboutAvailMemory,
                       IDS_AboutSysRes]), 0);
              inc(LeftPos,infoLabel.Width +4);
              SetLabel(info, Format('%d KB'#13'%d%% %s', [TRUNC(LMDSIMemTotal/1024),
                       LMDSIFreeSysRes, IDS_FREE]),0);
            end;

          Inc(TopPos, LMDMax([info.Height, infoLabel.Height])+24);

          with ok do
            SetBounds(AboutBox.ClientWidth-Width-6, TopPos, Width, Height);

          with Custom do
            SetBounds(ok.Left-Width-6, TopPos, Width, Height);

          if ShowHint and (Hints.Count>0) then
            begin
              ShowHint:=True;
              ok.Hint:=Hints[0];
              if Hints.Count>1 then custom.Hint:=Hints[1];
              if Hints.Count>2 then sIcon.Hint:=Hints[2];
            end;

          ClientHeight:=ok.Top+ok.Height+6;

          BaseExecute(AboutBox, aForm, Custom, fs, b, IDS_AboutInfo+Application.Title+'...');
          result:=True;
        finally
          if Assigned(bmp) then bmp.Free;
          if Assigned(bmp2) then bmp2.Free;
          Aboutbox.Free;
        end;
    end
  else
    begin
      if Length(Captiontitle)>0 then tmp:=CaptionTitle+'#'+tmp;

      StrpCopy(pc1, tmp);
      StrPCopy(pc2, tmpc);

      if aForm<>nil then h1:=aForm.Handle else h1:=0;
      If FIcon.Empty then
        result:=ShellAbout(h1, pc1, pc2, Application.Icon.Handle)<>0
      else
        result:=ShellAbout(h1, pc1, pc2, FIcon.Handle)<>0;
    end;
end;

end.
