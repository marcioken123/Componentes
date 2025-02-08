unit LMDStrSupp;
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

LMDStrSupp unit (DD)
--------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Forms,
  LMDStrings;

function LMDSPFindInStream(Stream: TStream; const szText: String; MatchCase: Boolean; bAllowSpace: Boolean = True): Integer;

implementation

{------------------------------------------------------------------------------}

function LMDSPFindInStream(Stream: TStream; const szText: String; MatchCase: Boolean;
                           bAllowSpace: Boolean = True): Integer;

var
  iPos : Integer;
  iSPos: Int64;
  C    : Char;
  Size : int64;
  bSpace : Boolean;
begin
  Result := -1;
  if Length(sztext)=0 then
    exit;
  iPos  := 1;
  iSPos := Stream.Position;
  Size  := Stream.Size;
  bSpace := (Length(sztext)=1) and (sztext[1]=#1);
  while (Stream.Position<Size)  do
    begin
      Stream.Read(C, sizeof(C));
      if not bSpace then
        if not MatchCase then
          C := LMDAnsiUpperChar(C);
      if (szText[iPos] = C) or (bSpace and LMDAnsiIsSpace(C)) then
        begin
          Inc(iPos);
        end
      else
        if iPos>1 then
          begin
            Inc(iSPos, SizeOf(Char));
            Stream.Position := iSPos;
            iPos := 1;
          end
        else
          Inc(iSPos, SizeOf(Char));

      if (not bAllowSpace) and (LMDAnsiIsSpace(C)) and (not bSpace) then
      begin
        break;
      end;

      if (iPos>Length(szText)) then
      begin
        Result := iSPos;
        break;
      end;
    end;
  if(Result>=0) then
    Stream.Position := Result;
end;

end.
