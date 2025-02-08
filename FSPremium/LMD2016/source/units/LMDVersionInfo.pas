unit LMDVersionInfo;
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

LMDVersionInfo unit (DS)
------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, LMDShBase;

type
  TLMDFileOs = (foUNKNOWN, foDOS, foOS216, foOS232, foNT);
  TLMDFileTyp = (ftUNKNOWN, ftAPP, ftDLL, ftDRV, ftFONT, ftVXD, ftSTATIC_LIB);

  {**************************** class TLMDVersionInfo *************************}
  TLMDVersionInfo = class(TLMDShellComponent)
  private
    FFileTyp : TLMDFileTyp;
    FFileOs  : TLMDFileOs;
    FRetrieveFilename,
    FFileSubTyp,
    FCreated,
    FLastModified,
    FLanguage,
    FLastAccess,
    FCompanyName,
    FProductVersion,
    FFileDes,
    FFileVersion,
    FInternalFileName,
    FOriginalFilename,
    FLegalCopyright,
    FLegalTrademarks,
    FProductName,
    FComments           : String;
    FCompressed,
    FArchive,
    FReadOnly,
    FSystem,
    FHidden,
    FVolumeId,
    FAnyFile,
    FDirectory,
    FDebug,
    FPreRelease,
    FPatched,
    FPrivateBuild,
    FInfoInferred,
    FSpecialBuild       : Boolean;
    FSmallIconList,
    FLargeIconList      : TImageList;
    procedure SetRetrieveFile (aValue : String);
    procedure SetDummyString (aValue : String);
    procedure SetDummyBool (aValue : Boolean);
    procedure SetDummyFileOs (aValue : TLMDFileOS);
    procedure SetDummyFileTyp (aValue : TLMDFileTyp);
  protected
    procedure GetInfos;

    procedure Loaded; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    property LargeIcons : TImageList read FLargeIconList;
    property SmallIcons : TImageList read FSmallIconList;
  published
    property About;
    property RetrieveFilename : String read FRetrieveFilename write SetRetrieveFile;
    property FileSubTyp : String read FFileSubTyp write SetDummyString stored false;
    property CompanyName : String read FCompanyName write SetDummyString stored false;
    property ProductVersion : String read FProductVersion write SetDummyString stored false;
    property FileVersion : String read FFileVersion write SetDummyString stored false;
    property InternalFilename : String read FInternalFilename write SetDummyString stored false;
    property OriginalFilename : String read FOriginalFilename write SetDummyString stored false;
    property ProductName : String read FProductName write SetDummyString stored false;
    property Comments : String read FComments write SetDummyString stored false;
    property Language : String read FLanguage write SetDummyString stored false;
    property LegalCopyright : String read FLegalCopyright write SetDummyString stored false;
    property LegalTrademarks : String read FLegalTrademarks write SetDummyString stored false;
    property FileDescription : String read FFileDes write SetDummyString stored false;
    property Debug : Boolean read FDebug write SetDummyBool stored false;
    property PreRelease : Boolean read FPreRelease write SetDummyBool stored false;
    property Patched : Boolean read FPatched write SetDummyBool stored false;
    property PrivateBuild : Boolean read FPrivateBuild write SetDummyBool stored false;
    property InfoInferred : Boolean read FInfoInferred write SetDummyBool stored false;
    property SpecialBuild : Boolean read FSpecialBuild write SetDummyBool stored false;
    property LastModified : String read FLastModified write SetDummyString stored false;
    property LastAccess   : String read FLastAccess write SetDummyString stored false;
    property Created      : String read FCreated write SetDummyString stored false;
    property Archive      : Boolean read FArchive write SetDummyBool stored false;
    property ReadOnly     : Boolean read FReadOnly write SetDummyBool stored false;
    property System       : Boolean read FSystem write SetDummyBool stored false;
    property Hidden       : Boolean read FHidden write SetDummyBool stored false;
    property VolumeId     : Boolean read FVolumeId write SetDummyBool stored false;
    property AnyFile      : Boolean read FAnyFile write SetDummyBool stored false;
    property Directory    : Boolean read FDirectory write SetDummyBool stored false;
    property Compressed   : Boolean read FCompressed write SetDummyBool stored false;
    property FileOs       : TLMDFileOs read FFileOs write SetDummyFileOs stored false;
    property FileTyp      : TLMDFileTyp read FFileTyp write SetDummyFileTyp stored false;
  end;

implementation

uses

  Windows, Forms, Graphics, SysUtils, ShellAPI, LMDProcs, LMDShUtils;

{**************************** class TLMDVersionInfo ***************************}
{------------------------------ private ---------------------------------------}
procedure TLMDVersionInfo.SetRetrieveFile (aValue : String);
begin
  if aValue <> FRetrieveFilename then
    begin
      FRetrieveFilename := aValue;
      GetInfos;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDVersionInfo.SetDummyString (aValue : String);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDVersionInfo.SetDummyBool (aValue : Boolean);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDVersionInfo.SetDummyFileOs (aValue : TLMDFileOS);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDVersionInfo.SetDummyFileTyp (aValue : TLMDFileTyp);
begin
end;

{-------------------------------- protected -----------------------------------}
procedure TLMDVersionInfo.Loaded;
begin
  inherited Loaded;
  GetInfos;
end;

{--------------------------------- public -------------------------------------}
constructor TLMDVersionInfo.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  //FRetrieveFilename := '';
  FLargeIconList := TImageList.Create(self);
  FSmallIconList := TImageList.Create(self);
  GetInfos;
end;

{------------------------------------------------------------------------------}
destructor TLMDVersionInfo.Destroy;
begin
  FSmallIconList.Free;
  FLargeIconList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDVersionInfo.GetInfos;

var
  InfoResSize: DWORD;     // holds the size of the version info resource
  InfoPath: string;       // holds the version info request string

  VersionInfo,             // points to the version info resource
  Info       : Pointer;    // a pointer to version information

  function FileTimeToDateTime(const ft: TFileTime): TDateTime;
  var
    st : TSystemTime;
  begin
    FileTimeToSystemTime (ft, st);
    //only works for st.wYear < 9999
    if (st.wYear >= 9999) or (st.wYear < 1) or
       (st.wMonth > 12) or (st.wMonth < 1) or
       (st.wDay < 1) or (st.wDay > 31) then
      begin
        result := EncodeDate (1900, 1, 1);
        exit;
      end;
    with st do
      Result := EncodeDate(wYear, wMonth, wDay) +
        EncodeTime(wHour, wMinute, wSecond, wMilliSeconds);
  end;

  function  QueryValue(const Name: string; var Info: Pointer; var Size: dword): Boolean;

  begin
    Result := (InfoResSize > 0)
              and VerQueryValue(VersionInfo, Int_Ref(InfoPath+Name), Info,
                                Size)
              and (Size > 0);
  end;

  function  GetStrInfo(const Name: string): string;
  var
    Size: dword;
  begin
    if QueryValue(Name, Info, Size) and (Size > 1)  then

      SetString(Result, PChar(Info), Size - 1)

    else
      Result := '';
  end;

  function  CheckFlag(dw: dword; Flag: dword): Boolean;
  begin
    Result := ((dw and Flag) = Flag);
  end;

type
  TLANGANDCODEPAGE = record
    wLanguage,
    wCodePage : Word;
  end;

  PLANGANDCODEPAGE = ^TLANGANDCODEPAGE;

var
  Zero       : DWORD;      // a junk variable, its value is ignored

  VSFixedFileInfo: PVSFixedFileInfo;

  Translation: PLANGANDCODEPAGE; // holds version info translation table

  ni,
  i           : Integer;
  VersionInfoSize: UINT;      // holds the size of version information
  Filename    : string;
  Attr        : DWORD;
  hf          : THandle;
  LIcon,
  SIcon       : HICON;
  LargeIcon,
  SmallIcon   : TIcon;
  lpCreated,                  // these three vars recieve the file dates
  lpCreated2,
  lpLastAccess,
  lpLastAccess2,
  lpLastWrite,
  lpLastWrite2: TFileTime;
  SecAttr     : TSECURITYATTRIBUTES;   // needed for open file
begin
  if (csWriting in ComponentState) or (csDestroying in ComponentState) then exit;
  if FRetrieveFileName = '' then
    Filename := Application.ExeName
  else
    Filename := FRetrieveFilename;

  InfoPath := '';

  //set all parameters to nothing
  FProductName := '';
  FProductVersion := '';
  FComments := '';
  FCompanyName := '';
  FLegalTrademarks := '';
  FLegalCopyright := '';
  FOriginalFilename := '';
  FInternalFilename := '';
  FFileDes := '';
  FFileVersion := '';
  FCreated := '';
  FLastAccess := '';
  FLastModified := '';
  FLanguage := '';

  FFileOs := foUNKNOWN;
  FFileTyp := ftUNKNOWN;
  FFileSubTyp := '';
  FDebug := false;
  FPreRelease := false;
  FPatched := false;
  FPrivateBuild := false;
  FInfoInferred := false;
  FSpecialBuild := false;
  FLargeIconList.Clear;
  FLargeIconList.Width := GetSystemMetrics (SM_CXICON);
  FLargeIconList.Height := GetSystemMetrics (SM_CYICON);
  FSmallIconList.Clear;
  FSmallIconList.Width := GetSystemMetrics (SM_CXSMICON);
  FSmallIconList.Height := GetSystemMetrics (SM_CYSMICON);

  if not FileExists (Filename) then Exit;

  LargeIcon := TIcon.Create;
  SmallIcon := TIcon.Create;
  LIcon := 0;
  SIcon := 0;

  try
    ni := LMDGetIconCount(Filename);

    if ni <> 0 then
      for i := 0 to ni-1 do
        begin
          LMDExtractIconEx(Filename, i, LIcon, SIcon);
          SmallIcon.Handle := SIcon;
          LargeIcon.Handle := LIcon;
          FLargeIconList.AddIcon (LargeIcon);
          //size check added January 03, JH
          if ((SmallIcon.Width <> FSmallIconList.Width) or
             (SmallIcon.Height <> FSmallIconList.Height)) then
            begin
              if (FSmallIconList.Count = 0) then
                begin
                  FSmallIconList.Width  := SmallIcon.Width;
                  FSmallIconList.Height := SmallIcon.height;
                  FSmallIconList.AddIcon (SmallIcon);
                end;
            end
          else
            FSmallIconList.AddIcon (SmallIcon);
        end;
  finally
    SmallIcon.Free;
    LargeIcon.Free;
  end;

  Attr := GetFileAttributes (PChar(Filename));

  //error found
  if Attr = $FFFFFFFF then exit;

  FReadOnly := CheckFlag(Attr, FILE_ATTRIBUTE_READONLY);
  FArchive := CheckFlag(Attr, FILE_ATTRIBUTE_ARCHIVE);
  FHidden := CheckFlag(Attr, FILE_ATTRIBUTE_HIDDEN);
  FSystem := CheckFlag(Attr, FILE_ATTRIBUTE_SYSTEM);
  FDirectory := CheckFlag(Attr, FILE_ATTRIBUTE_DIRECTORY);
  FAnyFile := CheckFlag(Attr, FILE_ATTRIBUTE_NORMAL);
  FCompressed := CheckFlag(Attr, FILE_ATTRIBUTE_COMPRESSED);

  Attr := FileGetAttr (Filename);
  if (Attr and faVolumeID) = faVolumeID then
    FVolumeId := true
  else
    FVolumeId := false;

  //File Time
  SecAttr.nLength := SizeOf(TSecurityAttributes);
  SecAttr.bInheritHandle := false;
  hf := CreateFile (int_Ref(Filename), GENERIC_READ , FILE_SHARE_READ, nil, OPEN_EXISTING, 0{FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN}, 0);
  if hf <> INVALID_HANDLE_VALUE then
    begin
      try

        GetFileTime (hf, @lpCreated, @lpLastAccess, @lpLastWrite);

        FileTimeToLocalFileTime (lpCreated, lpCreated2);
        FCreated := DateTimeToStr (FileTimeToDateTime (lpCreated2));
        FileTimeToLocalFileTime (lpLastAccess, lpLastAccess2);
        FLastAccess := DateTimeToStr (FileTimeToDateTime (lpLastAccess2));
        FileTimeToLocalFileTime (lpLastWrite, lpLastWrite2);
        FLastModified := DateTimeToStr (FileTimeToDateTime (lpLastWrite2));
      finally
        CloseHandle (hf);
      end;
    end;

  //retrieve the size of the version information resource, if one exists
  //InfoResSize := 0;
  InfoResSize := GetFileVersionInfoSize(Int_Ref(Filename), Zero);

  if InfoResSize=0 then exit;
  //if there are infos we will go on

  //allocate the needed memory for the info structure

  GetMem(VersionInfo, InfoResSize);

  try
    //Get the information of the current file
    if not GetFileVersionInfo(Int_Ref(Filename), 0, InfoResSize, VersionInfo) then
      begin

        FreeMem (VersionInfo);

        Exit;
      end;

    //get out if there is no Translation available
{    if not VerQueryValue(VersionInfo, '\\VarFileInfo\\Translation', Translation, VersionInfoSize) then exit;

    //set the version value path string
    InfoPath :='\\StringFileInfo\\'+
                    IntToHex(LoWord(LongInt(Translation^)),4)+
                    IntToHex(HiWord(LongInt(Translation^)),4)+
                    '\\';}

//    if VerQueryValue(VersionInfo, '\VarFileInfo\Translation', Pointer(Translation), VersionInfoSize) then
    if QueryValue('\VarFileInfo\Translation', Info, VersionInfoSize) then
      begin
        Translation := PLANGANDCODEPAGE(

        Info);

        //set the version value path string
        InfoPath :='\StringFileInfo\'+
                        IntToHex(Translation.wLanguage, 4)+
                        IntToHex(Translation.wCodePage, 4)+
                        '\';

        GetMem (info, 2000);
        VerLanguageName (Translation.wLanguage, Info, 2000);
        FLanguage := PChar(Info);
        FreeMem (info);

        //Languages := VersionInfoSize div sizeof (TLANGANDCODEPAGE);
      end
    else //set default value
      begin
       //set the version value path string
        InfoPath :='\StringFileInfo\040904E4\';
      end;

    //productname
    FProductName := GetStrInfo('ProductName');

    //get the company name
    FCompanyName := GetStrInfo('CompanyName');

    //productversion
    FProductVersion := GetStrInfo('ProductVersion');

    //legal Copyright
    FLegalCopyright := GetStrInfo('LegalCopyright');

    //legal trademarks
    FLegalTrademarks := GetStrInfo('LegalTrademarks');

    //comments
    FComments := GetStrInfo('Comments');

    //original filename
    FOriginalFilename := GetStrInfo('OriginalFilename');

    //internal FileName
    FInternalFileName := GetStrInfo('InternalName');

    //get the file description
    FFileDes := GetStrInfo('FileDescription');

    //File Version
    FFileVersion := GetStrInfo('FileVersion');
    //file build flags
    if VerQueryValue(VersionInfo, '\', Info, VersionInfoSize) then
      begin

        VSFixedFileInfo := PVSFixedFileInfo(Info);

        FDebug := BOOL(VSFixedFileInfo.dwFileFlags and VS_FF_DEBUG);
        FPreRelease := BOOL(VSFixedFileInfo.dwFileFlags and VS_FF_PRERELEASE);
        FPatched := BOOL(VSFixedFileInfo.dwFileFlags and VS_FF_PATCHED);
        FPrivateBuild := BOOL(VSFixedFileInfo.dwFileFlags and VS_FF_PRIVATEBUILD);
        FInfoInferred := BOOL(VSFixedFileInfo.dwFileFlags and VS_FF_INFOINFERRED);
        FSpecialBuild := BOOL(VSFixedFileInfo.dwFileFlags and VS_FF_SPECIALBUILD);
        FFileOs := TLMDFileOs (VSFixedFileInfo.dwFileOs);
        FFileTyp := TLMDFileTyp (VSFixedFileInfo.dwFileType);
        FFileSubTyp := IntToStr (VSFixedFileInfo.dwFileSubType);
        case FFileTyp of
          ftDrv  : case (VSFixedFileInfo.dwFileSubType) of
                     VFT2_UNKNOWN         : FFileSubTyp := 'UNKNWON';
                     VFT2_DRV_PRINTER     : FFileSubTyp := 'Printer';
                     VFT2_DRV_KEYBOARD    : FFileSubTyp := 'Keyboard';
                     VFT2_DRV_LANGUAGE    : FFileSubTyp := 'Language';
                     VFT2_DRV_DISPLAY     : FFileSubTyp := 'Display';
                     VFT2_DRV_MOUSE       : FFileSubTyp := 'Mouse';
                     VFT2_DRV_NETWORK     : FFileSubTyp := 'Network';
                     VFT2_DRV_SYSTEM      : FFileSubTyp := 'System';
                     VFT2_DRV_INSTALLABLE : FFileSubTyp := 'Installable';
                     VFT2_DRV_SOUND       : FFileSubTyp := 'Sound';
                     VFT2_DRV_COMM        : FFileSubTyp := 'Comm';
                   end;
          ftFont : case (VSFixedFileInfo.dwFileSubType) of
                     VFT2_FONT_RASTER     : FFileSubTyp := 'Raster';
                     VFT2_FONT_VECTOR     : FFileSubTyp := 'Vector';
                     VFT2_FONT_TRUETYPE   : FFileSubTyp := 'TrueType';
                   end;
        end
      end;
  finally
    //free the memory

    FreeMem(VersionInfo, InfoResSize);

  end;
end;

end.
