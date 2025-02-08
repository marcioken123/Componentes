unit LMDRTFAnalyser;
{$I LMDCmps.inc}

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

LMDRTFAnalyser unit (VO)
------------------------

RTF stream analyser 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  classes, LMDRTFTape, LMDRTFDocument, syncobjs;

type
  pboolean = ^boolean;
  {****************************************************************************}
  TLMDRTFAnalyser = class(TThread)              // an analyser skeleton
  private
    FTape               : TLMDRTFTape;
    FDocument           : TLMDRTFDocument;
    FHeadPosition       : LongInt;
    FHeadValue          : TLMDRTFTapeCell;
    FFinished           : pboolean;
    protected
    procedure MoveNext;
    procedure Look; virtual; abstract;
    procedure Strip; virtual; abstract;
    property Head : TLMDRTFTapeCell read FHeadValue;
    property Document : TLMDRTFDocument read FDocument;
    public
    destructor Destroy; override;
    constructor Create(aTape : TLMDRTFTape; aDocument : TLMDRTFDocument; aFinished : pboolean);
    procedure Execute; override;
    end;

  {****************************************************************************}
  TLMDRTFGDSAnalyser = class(TLMDRTFAnalyser)   // a global document settings analyser
  protected
    procedure Look; override;
    procedure Strip; override;
  end;

  {****************************************************************************}
  TLMDRTFFontTblAnalyser = class(TLMDRTFAnalyser)   // a font table analyser
  protected
    procedure Look; override;
    procedure Strip; override;
  end;

  {****************************************************************************}
  TLMDRTFFileTblAnalyser = class(TLMDRTFAnalyser)   // a file table analyser
  protected
    procedure Look; override;
    procedure Strip; override;
  end;

  {****************************************************************************}
  TLMDRTFColorTblAnalyser = class(TLMDRTFAnalyser)   // a color table analyser
  protected
    procedure Look; override;
    procedure Strip; override;
  end;

  {****************************************************************************}
  TLMDRTFStyleTblAnalyser = class(TLMDRTFAnalyser)   // a style table analyser
  protected
    procedure Look; override;
    procedure Strip; override;
  end;

  {****************************************************************************}
  TLMDRTFSectionAnalyser = class(TLMDRTFAnalyser)   // a document section analyser
  protected
    procedure Look; override;
    procedure Strip; override;
  end;

implementation
uses
  LMDRTFLookupTable;

{** TLMDRTFAnalyser ***********************************************************}
{-- protected -----------------------------------------------------------------}
procedure TLMDRTFAnalyser.MoveNext;
begin
  Inc(FHeadPosition);
  FHeadValue := FTape[FHeadPosition];
  if not assigned(Head) then
    begin
      Terminate;
      Exit;
    end;

  while (Head.CellCode = tocWAIT) and (not Terminated) do ;

  if Terminated then Exit;

  if Head.CellCode = tocEOF then
    begin
      Terminate;
      Exit;
    end;
end;

{-- public --------------------------------------------------------------------}

constructor TLMDRTFAnalyser.Create(aTape : TLMDRTFTape; aDocument : TLMDRTFDocument; aFinished : pboolean);

begin
  inherited Create(True);
  FTape := aTape;
  FDocument := aDocument;
  FHeadPosition := -1;
  FHeadValue := nil;
  FFinished := aFinished;
  FFinished^ := False;
  FreeOnTerminate := True;
  Resume;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFAnalyser.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFAnalyser.Execute;
begin
  while True do
    begin
      Look;
      if Terminated then Break;
      Strip;
      if Terminated then Break;
    end;
  FFinished^ := True;
  end;

{** TLMDRTFGDSAnalyser ********************************************************}
procedure TLMDRTFGDSAnalyser.Look;
begin
  repeat
    MoveNext;
    if Terminated then break;
  until (Head.CellCode in [
    tocRTF, tocANSI, tocMAC, tocPC, tocPCA, tocANSICPG, tocDEFF
    ]);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFGDSAnalyser.Strip;
begin
  case Head.CellCode of
    tocRTF :
      if Head.CellType = ctIDATA then
        Document.Version := TLMDRTFTapeCellIDATA(Head.Data).Data;
    tocANSI : Document.CharSet := csANSI;
    tocMAC : Document.CharSet := csMAC;
    tocPC : Document.CharSet := csPC;
    tocPCA : Document.CharSet := csPCA;
    tocANSICPG :
      if Head.CellType = ctIDATA then
        Document.AnsiCodePage := TLMDRTFTapeCellIDATA(Head.Data).Data;
    tocDEFF :
      if Head.CellType = ctIDATA then
        Document.DefaultFontNumber := TLMDRTFTapeCellIDATA(Head.Data).Data;
    tocUC :
      if Head.CellType = ctIDATA then
        Document.BytePerUChar := TLMDRTFTapeCellIDATA(Head.Data).Data;
  end;
end;

{** TLMDRTFFontTblAnalyser ****************************************************}
procedure TLMDRTFFontTblAnalyser.Look;
var
  PrevCode : LongInt;
begin
  repeat
    if assigned(Head) then
      PrevCode := Head.CellCode
    else
      PrevCode := 0;

    MoveNext;
    if Terminated then break;
  until (PrevCode = tocOPENGROUP) and (Head.CellCode = tocFONTTBL);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFFontTblAnalyser.Strip;
type
  TSubgroup = (sgNONE, sgPANOSE, sgALT, sgTEMB, sgFILE);
var
  GroupRef : LongInt;
  item : TLMDRTFFontTableRecord;
  subgroup : TSubgroup;
begin
  GroupRef := 1;
  item := nil;
  subgroup := sgNONE;

  while (GroupRef > 0) and (not Terminated) do
    begin
      case Head.CellCode of
        tocOPENGROUP : Inc(GroupRef);
        tocCLOSEGROUP :
          begin
            subgroup := sgNONE;
            Dec(GroupRef);
          end;
        tocF :
          begin
            item := Document.FontTable.Add;
            if (Head.CellType = ctIDATA) and Assigned(Item) then
              Item.ID := TLMDRTFTapeCellIDATA(Head.Data).Data;
          end;
        tocFNIL :
          if Assigned(Item) then
            Item.FontFamily := ffNIL;
        tocFROMAN :
          if Assigned(Item) then
            Item.FontFamily := ffROMAN;
        tocFSWISS :
          if Assigned(Item) then
            Item.FontFamily := ffSWISS;
        tocFMODERN :
          if Assigned(Item) then
            Item.FontFamily := ffMODERN;
        tocFSCRIPT :
          if Assigned(Item) then
            Item.FontFamily := ffSCRIPT;
        tocFDECOR :
          if Assigned(Item) then
            Item.FontFamily := ffDECOR;
        tocFTECH :
          if Assigned(Item) then
            Item.FontFamily := ffTECH;
        tocFBIDI :
          if Assigned(Item) then
            Item.FontFamily := ffBIDI;
        tocFCHARSET :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.Charset := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocFPRQ :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.FontPitch := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocFNAME :
          if Assigned(Item) then
            Item.NontaggedName := True;
        tocCPG :
          begin
            case subgroup of
              sgNONE  :
                if (Head.CellType = ctIDATA) and Assigned(Item) then
                  Item.CodePage := TLMDRTFTapeCellIDATA(Head.Data).Data;
              sgFILE :
                if (Head.CellType = ctIDATA) and Assigned(Item) then
                  Item.EmbFontCodePage := TLMDRTFTapeCellIDATA(Head.Data).Data;
            end;
          end;
        tocPANOSE : subgroup := sgPANOSE;
        tocFALT : subgroup := sgALT;
        tocFONTEMB : subgroup := sgTEMB;
        tocFTNIL :
          if Assigned(Item) then
            Item.EmbFontType := ftNIL;
        tocFTTRUETYPE :
          if Assigned(Item) then
            Item.EmbFontType := ftTRUETYPE;
        tocFONTFILE : subgroup := sgFILE;

        tocPLAINTEXT :
          begin
            case subgroup of
              sgNONE  :
                if (Head.CellType = ctPDATA) and Assigned(Item) then
                  Item.FontName := TLMDRTFTapeCellPDATA(Head.Data).Data;
              sgPANOSE :
                if (Head.CellType = ctPDATA) and Assigned(Item) then
                  Item.Panose := TLMDRTFTapeCellPDATA(Head.Data).Data;
              sgALT :
                if (Head.CellType = ctPDATA) and Assigned(Item) then
                  Item.AltFontName := TLMDRTFTapeCellPDATA(Head.Data).Data;
              sgFILE :
                if (Head.CellType = ctPDATA) and Assigned(Item) then
                  Item.EmbFontFileName := TLMDRTFTapeCellPDATA(Head.Data).Data;
              sgTEMB : ;//??? <data> - unspecified
            end;
          end;
      end;
      MoveNext;
    end;
end;

{** TLMDRTFFileTblAnalyser ****************************************************}
procedure TLMDRTFFileTblAnalyser.Look;
var
  PrevCode : LongInt;
begin
  repeat
    if assigned(Head) then
      PrevCode := Head.CellCode
    else
      PrevCode := 0;
    MoveNext;
    if Terminated then break;
  until (PrevCode = tocOPENGROUP) and (Head.CellCode = tocFILETBL);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFFileTblAnalyser.Strip;
var
  GroupRef : LongInt;
  item : TLMDRTFFileTableRecord;
begin
  GroupRef := 1;
  item := nil;

  while (GroupRef > 0) and (not Terminated) do
    begin
      case Head.CellCode of
        tocOPENGROUP : Inc(GroupRef);
        tocCLOSEGROUP : Dec(GroupRef);
        tocFILE : item := Document.FileTable.Add;
        tocFID :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ID := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocFRELATIVE :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.RelativePos := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocFOSNUM :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.OsNum := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocFVALIDMAC :
          if Assigned(Item) then
            Item.FileSources := Item.FileSources + [fsVALIDMAC];
        tocFVALIDDOS :
          if Assigned(Item) then
            Item.FileSources := Item.FileSources + [fsVALIDDOS];
        tocFVALIDNTFS :
          if Assigned(Item) then
            Item.FileSources := Item.FileSources + [fsVALIDNTFS];
        tocFVALIDHPFS :
          if Assigned(Item) then
            Item.FileSources := Item.FileSources + [fsVALIDHPFS];
        tocFNETWORK :
          if Assigned(Item) then
            Item.FileSources := Item.FileSources + [fsNETWORK];
        tocPLAINTEXT :
          if (Head.CellType = ctPDATA) and Assigned(Item) then
            Item.FileName := TLMDRTFTapeCellPDATA(Head.Data).Data;
      end;
      MoveNext;
    end;
end;

{** TLMDRTFColorTblAnalyser ***************************************************}
procedure TLMDRTFColorTblAnalyser.Look;
var
  PrevCode : LongInt;
begin
  repeat
    if assigned(Head) then
      PrevCode := Head.CellCode
    else
      PrevCode := 0;
    MoveNext;
    if Terminated then break;
  until (PrevCode = tocOPENGROUP) and (Head.CellCode = tocCOLORTBL);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFColorTblAnalyser.Strip;
var
  GroupRef : LongInt;
  item : TLMDRTFColorTableRecord;
begin
  GroupRef := 1;
//  item := nil;
  item := Document.ColorTable.Add;
  while (GroupRef > 0) and (not Terminated) do
    begin
      case Head.CellCode of
        tocOPENGROUP : Inc(GroupRef);
        tocCLOSEGROUP : Dec(GroupRef);
        tocRED :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.Red := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocGREEN :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.Green := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocBLUE :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.Blue := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocPLAINTEXT :
          if (Head.CellType = ctPDATA) and (TLMDRTFTapeCellPDATA(Head.Data).Data = ';') then
            item := Document.ColorTable.Add;
      end;
      MoveNext;
    end;
end;

{** TLMDRTFStyleTblAnalyser ***************************************************}
procedure TLMDRTFStyleTblAnalyser.Look;
var
  PrevCode : LongInt;
begin
  repeat
    if assigned(Head) then
      PrevCode := Head.CellCode
    else
      PrevCode := 0;
    MoveNext;
    if Terminated then break;
  until (PrevCode = tocOPENGROUP) and (Head.CellCode = tocSTYLESHEET);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFStyleTblAnalyser.Strip;
type
  TSubgroup = (sgNONE, sgKEYCODE);
  TBorder = (brdrt, brdrb, brdrl, brdrr, brdrbtw, brdrbar, box);
var
  GroupRef : LongInt;
  item : TLMDRTFStyleTableRecord;
  subgroup : TSubgroup;
  Border : TBorder;

  procedure SetBorderDrawKind(bdrdk : TLMDRTFBRDRK);
  begin
    if not Assigned(Item) then Exit;
    case Border of
      brdrt : Item.BorderDefs.Right.DrawKind := Item.BorderDefs.Right.DrawKind + [bdrdk];
      brdrb : Item.BorderDefs.Bottom.DrawKind := Item.BorderDefs.Bottom.DrawKind + [bdrdk];
      brdrl : Item.BorderDefs.Left.DrawKind := Item.BorderDefs.Left.DrawKind + [bdrdk];
      brdrr : Item.BorderDefs.Right.DrawKind := Item.BorderDefs.Right.DrawKind + [bdrdk];
      brdrbtw : Item.BorderDefs.IPB.DrawKind := Item.BorderDefs.IPB.DrawKind + [bdrdk];
      brdrbar : Item.BorderDefs.Bar.DrawKind := Item.BorderDefs.Bar.DrawKind + [bdrdk];
      box : Item.BorderDefs.Box.DrawKind := Item.BorderDefs.Box.DrawKind + [bdrdk];
    end;
  end;

  procedure SetBorderSpacing(value : LongInt);
  begin
    if not Assigned(Item) then Exit;
    case Border of
      brdrt : Item.BorderDefs.Right.Spacing := value;
      brdrb : Item.BorderDefs.Bottom.Spacing := value;
      brdrl : Item.BorderDefs.Left.Spacing := value;
      brdrr : Item.BorderDefs.Right.Spacing := value;
      brdrbtw : Item.BorderDefs.IPB.Spacing := value;
      brdrbar : Item.BorderDefs.Bar.Spacing := value;
      box : Item.BorderDefs.Box.Spacing := value;
    end;
  end;

  procedure SetBorderWidth(value : LongInt);
  begin
    if not Assigned(Item) then Exit;
    case Border of
      brdrt : Item.BorderDefs.Right.width := value;
      brdrb : Item.BorderDefs.Bottom.width := value;
      brdrl : Item.BorderDefs.Left.width := value;
      brdrr : Item.BorderDefs.Right.width := value;
      brdrbtw : Item.BorderDefs.IPB.width := value;
      brdrbar : Item.BorderDefs.Bar.width := value;
      box : Item.BorderDefs.Box.width := value;
    end;
  end;

  procedure SetBorderColor(value : LongInt);
  begin
    if not Assigned(Item) then Exit;
    case Border of
      brdrt : Item.BorderDefs.Right.Color := value;
      brdrb : Item.BorderDefs.Bottom.Color := value;
      brdrl : Item.BorderDefs.Left.Color := value;
      brdrr : Item.BorderDefs.Right.Color := value;
      brdrbtw : Item.BorderDefs.IPB.Color := value;
      brdrbar : Item.BorderDefs.Bar.Color := value;
      box : Item.BorderDefs.Box.Color := value;
    end;
  end;
begin
  GroupRef := 1;
  item := nil;
  subgroup := sgNONE;
  Border := brdrt;

  while (GroupRef > 0) and (not Terminated) do
    begin
      case Head.CellCode of
        tocOPENGROUP :
          begin
            Inc(GroupRef);
            if GroupRef = 2 then item := Document.StyleTable.Add;
          end;
        tocCLOSEGROUP :
          begin
            Dec(GroupRef);
            subgroup := sgNONE;
          end;
        tocS :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.DesignatesParaStyle := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocCS :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.DesignatesCharStyle := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocDS :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.DesignatesSecStyle := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocKEYCODE : subgroup := sgKEYCODE;
        tocSHIFT :
          if Assigned(Item) then
            Item.KeyShiftState := Item.KeyShiftState + [ssShift];
        tocCTRL :
          if Assigned(Item) then
            Item.KeyShiftState := Item.KeyShiftState + [ssCtrl];
        tocALT :
          if Assigned(Item) then
            Item.KeyShiftState := Item.KeyShiftState + [ssAlt];
        tocFN :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.KeyNumber := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocADDITIVE :
          if Assigned(Item) then
            Item.Additive := True;
        tocSBASEDON :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.BaseStyle := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocSNEXT :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.NextStyle := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocBRDRT : Border := brdrt;
        tocBRDRB : Border := brdrb;
        tocBRDRL : Border := brdrl;
        tocBRDRR : Border := brdrr;
        tocBRDRBTW : Border := brdrbtw;
        tocBRDRBAR : Border := brdrbar;
        tocBOX : Border := box;
        tocBRDRS : SetBorderDrawKind(brdrs);
        tocBRDRTH : SetBorderDrawKind(brdrth);
        tocBRDRSH : SetBorderDrawKind(brdrsh);
        tocBRDRDB : SetBorderDrawKind(brdrdb);
        tocBRDRDOT : SetBorderDrawKind(brdrdot);
        tocBRDRDASH : SetBorderDrawKind(brdrdash);
        tocBRDRHAIR : SetBorderDrawKind(brdrhair);
        tocBRDRDASHSM : SetBorderDrawKind(brdrdashsm);
        tocBRDRDASHD : SetBorderDrawKind(brdrdashd);
        tocBRDRDASHDD : SetBorderDrawKind(brdrdashdd);
        tocBRDRTRIPLE : SetBorderDrawKind(brdrtriple);
        tocBRDRTNTHSG : SetBorderDrawKind(brdrtnthsg);
        tocBRDRTHTNSG : SetBorderDrawKind(brdrthtnsg);
        tocBRDRTNTHTNSG : SetBorderDrawKind(brdrtnthtnsg);
        tocBRDRTNTHMG : SetBorderDrawKind(brdrtnthmg);
        tocBRDRTNTHLG : SetBorderDrawKind(brdrtnthlg);
        tocBRDRTHTNLG : SetBorderDrawKind(brdrthtnlg);
        tocBRDRWAVY : SetBorderDrawKind(brdrwavy);
        tocBRDRWAVYDB : SetBorderDrawKind(brdrwavydb);
        tocBRDRDASHDOTSTR : SetBorderDrawKind(brdrdashdotstr);
        tocBRDREMBOSS : SetBorderDrawKind(brdremboss);
        tocBRDRENGRAVE : SetBorderDrawKind(brdrengrave);
        tocBRDRW :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            SetBorderWidth(TLMDRTFTapeCellIDATA(Head.Data).Data);
        tocBRSP :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            SetBorderSpacing(TLMDRTFTapeCellIDATA(Head.Data).Data);
        tocBRDRCF :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            SetBorderColor(TLMDRTFTapeCellIDATA(Head.Data).Data);
        tocPARD :
          if Assigned(Item) then
            Item.ParaFormat.ParDef := True;
        tocHYPHPAR :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.Hyphpar := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocINTBL :
          if Assigned(Item) then
            Item.ParaFormat.Intbl := True;
        tocKEEP :
          if Assigned(Item) then
            Item.ParaFormat.Keep := True;
        tocNOWIDCTLPAR :
          if Assigned(Item) then
            Item.ParaFormat.Nowidctl := True;
        tocWIDCTLPAR :
          if Assigned(Item) then
            Item.ParaFormat.Widctl := True;
        tocKEEPN :
          if Assigned(Item) then
            Item.ParaFormat.Keepn := True;
        tocNOLINE :
          if Assigned(Item) then
            Item.ParaFormat.Noline := True;
        tocPAGEBB :
          if Assigned(Item) then
            Item.ParaFormat.Pagebb := True;
        tocSBYS :
          if Assigned(Item) then
            Item.ParaFormat.Sbys := True;
        tocQL :
          if Assigned(Item) then
            Item.ParaFormat.Alignment := paLeft;
        tocQR :
          if Assigned(Item) then
            Item.ParaFormat.Alignment := paRight;
        tocQJ :
          if Assigned(Item) then
            Item.ParaFormat.Alignment := paJustify;
        tocQC :
          if Assigned(Item) then
            Item.ParaFormat.Alignment := paCenter;
        tocLEVEL :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.Level := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocOUTLINELEVEL :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.Outlinelevel := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocFI :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.FirstLineIndentation := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocLI :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.LeftLineIndentation := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocRI :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.RightLineIndentation := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocSB :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.BeforeSpacing := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocSA :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.AfterSpacing := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocSL :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.BetweenSpacing := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocSLMULT :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.LineSpacing := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocSUBDOCUMENT :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.Subdocument := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocRTLPAR :
          if Assigned(Item) then
            Item.ParaFormat.BiDi := bidiRTL;
        tocLTRPAR :
          if Assigned(Item) then
            Item.ParaFormat.BiDi := bidiLTR;
        tocABSW :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.AbsWidth := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocABSH :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.AbsHeight := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocPOSX :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.posx := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocPOSNEGX :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.posnegx := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocPOSNEGY :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.posnegy := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocPOSY :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.posy := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocDXFRTEXT :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.dxfrtext := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocDFRMTXTX :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.dfrmtxtx := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocDFRMTXTY :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.dfrmtxty := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocDROPCAPLI :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.dropcapli := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocDROPCAPT :
          if (Head.CellType = ctIDATA) and Assigned(Item) then
            Item.ParaFormat.dropcapt := TLMDRTFTapeCellIDATA(Head.Data).Data;
        tocPHMRG :
          if Assigned(Item) then
            Item.ParaFormat.phmrg := True;
        tocPHPG :
          if Assigned(Item) then
            Item.ParaFormat.phpg := True;
        tocPHCOL :
          if Assigned(Item) then
            Item.ParaFormat.phcol := True;
        tocPOSXC :
          if Assigned(Item) then
            Item.ParaFormat.posxc := True;
        tocPOSXI :
          if Assigned(Item) then
            Item.ParaFormat.posxi := True;
        tocPOSXO :
          if Assigned(Item) then
            Item.ParaFormat.posxo := True;
        tocPOSXR :
          if Assigned(Item) then
            Item.ParaFormat.posxr := True;
        tocPOSXL :
          if Assigned(Item) then
            Item.ParaFormat.posxl := True;
        tocPVMRG :
          if Assigned(Item) then
            Item.ParaFormat.pvmrg := True;
        tocPVPG :
          if Assigned(Item) then
            Item.ParaFormat.pvpg := True;
        tocPVPARA :
          if Assigned(Item) then
            Item.ParaFormat.pvpara := True;
        tocPOSYIL :
          if Assigned(Item) then
            Item.ParaFormat.posyil := True;
        tocPOSYT :
          if Assigned(Item) then
            Item.ParaFormat.posyt := True;
        tocPOSYC :
          if Assigned(Item) then
            Item.ParaFormat.posyc := True;
        tocPOSYB :
          if Assigned(Item) then
            Item.ParaFormat.posyb := True;
        tocABSLOCK :
          if Assigned(Item) then
            Item.ParaFormat.abslock := True;
        tocNOWRAP :
          if Assigned(Item) then
            Item.ParaFormat.nowrap := True;
        tocOVERLAY :
          if Assigned(Item) then
            Item.ParaFormat.overlay := True;
        tocPOSYIN :
          if Assigned(Item) then
            Item.ParaFormat.posyin := True;
        tocPOSYOUT :
          if Assigned(Item) then
            Item.ParaFormat.posyout := True;
        //<tabdef> | <shading> | <chrfmt>
        tocPLAINTEXT :
          begin
            case subgroup of
              sgNONE :
                if (Head.CellType = ctPDATA) and Assigned(Item) then
                  Item.StyleName := TLMDRTFTapeCellPDATA(Head.Data).Data;
              sgKEYCODE :
                if (Head.CellType = ctPDATA) and Assigned(Item) then
                  Item.KeyName := TLMDRTFTapeCellPDATA(Head.Data).Data;
            end;
          end;
      end;
      MoveNext;
    end;
end;

{** TLMDRTFSectionAnalyser ****************************************************}
procedure TLMDRTFSectionAnalyser.Look;
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFSectionAnalyser.Strip;
begin
end;

end.
