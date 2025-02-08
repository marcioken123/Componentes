unit LMDRTFStatisticsDialog;
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

LMDRTFStatisticsDialog unit (RM)
--------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Controls, StdCtrls, Classes, ExtCtrls,

  LMDRTFRichEdit;

type
  { ************************************************************************** }
  TLMDRTFStatisticsDlg = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnClose: TButton;
    lbPages: TLabel;
    lbWords: TLabel;
    lbChars1: TLabel;
    lbChars2: TLabel;
    lbPara: TLabel;
    lbLines: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    procedure ProcessEditor(aValue : TLMDCustomRichEdit);
  end;

implementation

uses
  Graphics, SysUtils,
  LMDRTFConst;

{$R *.DFM}

{------------------------------------------------------------------------------}
procedure TLMDRTFStatisticsDlg.ProcessEditor(aValue : TLMDCustomRichEdit);
var
  aText : string;
  i             : longint;
  bWord         : boolean;
  lSpaceCount   : LongInt;
  lWordChar     : LongInt;
  lWordCount    : LongInt;
  lParaCount    : LongInt;

  OldSel        : LongInt;

  B             : TBitmap;
  lPageCount    : integer;
begin
  if not assigned(aValue) then Exit;

  aText := aValue.Text;
  bWord := False;
  lSpaceCount := 0;
  lWordChar := 0;
  lWordCount := 0;
  lParaCount := 1;

  for i := 1 to Length(aText) do
  begin
    if (aText[i] = #$20) or (aText[i] = #$9) or (aText[i] = #$A) or (aText[i] = #$C) then
    begin
      if bWord then bWord := False;
      if (aText[i] = #$A) or (aText[i] = #$C) then
      begin
        if (i = 0) or (not ((aText[i-1] = #$A) or (aText[i-1] = #$C))) then
          Inc(lParaCount);
      end
      else Inc(lSpaceCount);
    end
    else
    begin
      Inc(lWordChar);
      if not bWord then
      begin
        Inc(lWordCount);
        bWord := True;
      end;
    end;
  end;

  lbChars2.Caption := IntToStr(lSpaceCount + lWordChar);
  lbChars1.Caption := IntToStr(lWordChar);
  lbWords.Caption := IntToStr(lWordCount);
  lbPara.Caption := IntToStr(lParaCount);

  OldSel := aValue.SelStart;
  aValue.SelStart := Length(aValue.Text);
  lbLines.Caption := IntToStr(aValue.CaretPos.Y+1);
  aValue.SelStart := OldSel;

  B := TBitmap.Create;
  i := 0;
  lPageCount := 0;
  try
    repeat
      Inc(lPageCount);
      aValue.Preview(B.Canvas, false, i);
    until (I = -1) or (I = 0);
  finally
    B.Free;
  end;

  lbPages.Caption := IntToStr(lPageCount);
end;

procedure TLMDRTFStatisticsDlg.btnCloseClick(Sender: TObject);
begin Close; end;

procedure TLMDRTFStatisticsDlg.FormCreate(Sender: TObject);
begin
  Caption := IDRTF_SD_CAPTION;
  Label1.Caption := IDRTF_SD_STATISTICS;
  Label2.Caption := IDRTF_SD_PAGES;
  Label3.Caption := IDRTF_SD_WORDS;
  Label4.Caption := IDRTF_SD_CHARACTERSWOS;
  Label5.Caption := IDRTF_SD_CHARACTERSWS;
  Label6.Caption := IDRTF_SD_PARAGRAPHS;
  Label7.Caption := IDRTF_SD_LINES;
end;

end.
