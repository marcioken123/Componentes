unit pLMDComAboutDlg;
{$I LMDCmps.inc}
interface

uses
  Windows, ComCtrls, Classes, Graphics, Forms, Controls, Dialogs, buttons,
  StdCtrls, ExtCtrls, CheckLst,
  DesignIntf, DesignEditors,
  pLMDURLLabel, pLMDCst, pLMDCommon, LMDTypes;

type
  TLMDAboutDlg = class(TForm)
    ok: TButton;
    Panel1: TPanel;
    Image1: TImage;
    Button1: TButton;
    lblversion: TLabel;
    lblversionExt: TLabel;
    lbldesc: TLabel;
    lblcopyright: TLabel;
    bv: TBevel;
    lblwebsite: TLMDURLLabel;
    lblsysinfo: TLabel;
    btnReg: TButton;
    lblquestion: TLabel;
    lblsupport: TLMDURLLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FApp,
    FClipText,
    FPack: string;
    FPackageID:TLMDPackageID;
  end;

  {-------------------  Class TLMDAboutProperty -------------------------}
  TLMDAboutProperty = class(TStringProperty)
    //procedure GetVersionValues(aForm:TLMDAboutDlg);virtual;abstract;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
  end;

implementation
uses
  SysUtils, Registry,
  ShellAPI, TypInfo, Clipbrd,
  intfLMDBase, LMDProcs, LMDSysIn, pLMDConfigDlg, LMDStrings;

{$R *.DFM}

  {$R LMDSplash.res}

{************************** TLMDAboutProperty *********************************}
{------------------------------------------------------------------------------}
function TLMDAboutProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paDialog, paReadOnly];
end;

{------------------------------------------------------------------------------}
procedure TLMDAboutProperty.Edit;
var
  dlg:TLMDAboutDlg;
  itmp:ILMDComponent;

  function GetSplashResName(APackId: TLMDPackageID):string;
  begin
    case APackId of
      //pi_LMD_RTL,
      //pi_LMD_RTLX,
      //pi_LMD_CORE,
      //pi_LMD_TOOLS:   result := 'LMDTOOLS';
      pi_LMD_ELCORE,
      pi_LMD_ELPRO:   result := 'LMDELPACK';
      pi_LMD_SEARCH:  result := 'LMDSEARCHPACK';
      pi_LMD_SHELL:   result := 'LMDSHELLPACK';
      pi_LMD_DESIGN:  result := 'LMDDESIGNPACK';
      //pi_LMD_PARSE,
      pi_LMD_FX:      result := 'LMDFXPACK';
      pi_LMD_WEB:     result := 'LMDWEBPACK';
      pi_LMD_SYS:     result := 'LMDSYSPACK';
      //pi_LMD_TXT,
      pi_LMD_SYNTAX:  result := 'LMDSYNTAXEDIT';
      pi_LMD_RTF:     result := 'LMDRICHPACK';
      //pi_LMD_PRINT: ;
      pi_LMD_IDE:     result := 'LMDIDETOOLS';
      pi_LMD_CHART:   result := 'LMDCHARTPACK';
      pi_LMD_SCRIPT:  result := 'LMDSCRIPTPACK';
      //pi_LMD_LEGACY,
      pi_LMD_BAR:     result := 'LMDBARPACK';
      pi_LMD_STORAGE: result := 'LMDSTORAGEPACK';
    else
      result := 'LMDTOOLS';
    end;
  end;

begin
  dlg:=TLMDAboutDlg.Create(nil);
  try
    with dlg do
      begin
        if LMDSupports (GetComponent(0), ILMDComponent, itmp) then
          FPackageID:=itmp.getLMDPackage;
        FPack:=LMDPackageInfo[FPackageID].Name;
        lblversionExt.Caption:='Component Suite '+LMDTOOLS_COMPILERNAME +
                               ', Component: '+GetComponent(0).Classname;
        lblVersion.Caption:=FPack+' '+
                            LMDPackageInfo[FPackageID].Version+' ('+
                            LMDPackageInfo[FPackageID].ReleaseDate+')';
        lblsysinfo.Caption:='Platform: '+ LMDSIPlatformStr+' (Build: '+ inttostr(LMDSIBuildNr);
        if Win32CSDVersion<>'' then
          lblsysinfo.Caption := lblsysinfo.Caption + ', '+ Win32CSDVersion;
        lblsysinfo.Caption := lblsysinfo.Caption + ')';
        bv.Width := lblversion.Width + 3;
        FClipText := 'Component: ' + GetComponent(0).Classname + LMDCRLF +
                     'Package:   ' + lblVersion.Caption + LMDCRLF +
                     'IDE:       ' + LMDTOOLS_COMPILERNAME+ LMDCRLF +
                     'Platform:  ' + lblsysinfo.Caption;
                     // themes enabled?
        try    //.net debug purposes only
          lblsupport.Jump:='mailto:mail@lmdsupport.com?subject='+FPack+'%20Support';
        except //.net debug purposes only
        end;   //.net debug purposes only
        LMDDsgnGetJPEGResource(HInstance, GetSplashResName(FPackageID), Image1.Picture);
        ShowModal;
      end;
  finally
    dlg.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDAboutProperty.GetValue: string;
begin
  Result:='(About...)';
end;

{------------------------------------------------------------------------------}
procedure TLMDAboutDlg.FormShow(Sender: TObject);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDAboutDlg.FormCreate(Sender: TObject);
begin
  // Find and check registration utility
  FApp:=LMDSystemDirectory+'\'+LMDTOOLS_APPNAME+'.exe';
  btnReg.Visible:=FileExists(FApp);
  Caption:='Info '+FPack+'...';
end;

{------------------------------------------------------------------------------}
procedure TLMDAboutDlg.btnRegClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(FApp), nil, nil, SW_SHOWNORMAL)
  end;

{------------------------------------------------------------------------------}
procedure TLMDAboutDlg.Button1Click(Sender: TObject);
begin
  ClipBoard.AsText := FClipText;
end;

procedure TLMDAboutDlg.Button2Click(Sender: TObject);
begin
  with TLMDConfigDlg.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end
end;

initialization
  RegisterClass(TLMDUrlLabel);
end.
