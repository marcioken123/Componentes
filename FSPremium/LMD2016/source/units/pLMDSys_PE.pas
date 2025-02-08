unit pLMDSys_PE;
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

pLMDSys_PE unit (RM)
-------------------
Property editors for LMD SysPack

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Windows, Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls,
  pLMDOIEnh;

type

  {----------------------------------------------------------------------------}
  TLMDSysSetProperty=class(TLMDSetProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

implementation

uses
  TypInfo,pLMDSysCheckListDlg;

{------------------------------------------------------------------------------}
function TLMDSysSetProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= inherited GEtAttributes+[paDialog];
end;

{------------------------------------------------------------------------------}
procedure TLMDSysSetProperty.Edit;
var
  i: TLMDSet;
  Data: PTypeData;
  tmp:TIntegerSet;
  tmpv:Integer;
  tmpf:TfrmLMDSysOptionsEditor;

  function LMDExp(base, exp:Integer):LongInt;
  var
    i:LongInt;
  begin
    result:=1;
    for i:=1 to exp do
      result:=result*base;
  end;

begin
  tmpf:=TfrmLMDSysOptionsEditor.Create(nil);
  try
    Data:=GetTypeData(FEnumInfo);
    tmpv:=GetOrdValue;
    for i:=Data.MinValue to Data.MaxValue do
      begin
        tmpf.lb.Items.Add(GetEnumName(FEnumInfo, i));
        if LMDExp(2,i) AND tmpv>0 then
          tmpf.lb.Checked[ord(i)]:=true;
      end;

    if tmpf.ShowModal=mrOK then
      begin
        tmp:=[];
        for i:=Data.MinValue to Data.MaxValue do
          if tmpf.lb.Checked[Ord(i)] then Include(tmp, i);
        SetOrdValue(Integer(tmp));
        end;
    finally
      tmpf.free;
    end;
end;

end.
