unit pLMDText_PE;
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

pLMDText_PE unit (JH)
---------------------

Property editor for parser written by VO 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, LMDParser,
  DesignIntf, DesignEditors;
  type
  TLMDParserClassProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const aValue: string); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDTextLinesProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TLMDTextContainerEditor = class(TDefaultEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation
uses
 pLMDHTMLEditorDlg, LMDText, LMDTextObject, sysutils;

{ ---------------------------------------------------------------------------- }
function TLMDParserClassProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paValueList]
end;

{ ---------------------------------------------------------------------------- }
function TLMDParserClassProperty.GetValue: string;
begin
  Result:= GetStrValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParserClassProperty.GetValues(Proc: TGetStrProc);
var
  I: LongInt;
begin
  for I:= 0 to Parsers.Count - 1 do
    Proc(PLMDParserRec(Parsers[I])^.ParserClass.ClassName);
    end;

{ ---------------------------------------------------------------------------- }
procedure TLMDParserClassProperty.SetValue(const aValue: string);
begin
  SetStrValue(aValue)
end;

{********************* Class TLMDTextLinesProperty ****************************}
{------------------------------------------------------------------------------}
procedure TLMDTextLinesProperty.Edit;
var
  aList:TLMDStrings;
  FEditor: TfrmTLMDHTMLEditor;
begin
  aList:=TLMDStrings.Create;
  try
    FEditor:=TfrmTLMDHTMLEditor.Create(nil);
    with FEditor do
      try
        HTMLEdit.Lines.Text:=TLMDStrings(Pointer(GetOrdValue)).Text;
        if Showmodal=mrOK then
          begin
            aList.Text:=HTMLEdit.Lines.Text;
            SetOrdValue(Longint(Pointer(aList)));
            end;
      finally
        Free;
      end;
  finally
    aList.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTextLinesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ TLMDTextContainerEditor }
{------------------------------------------------------------------------------}
procedure TLMDTextContainerEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  PropName: string;
begin
  PropName:= Prop.GetName;
  if CompareText(PropName, 'Items') = 0 then
    begin
      Prop.Edit;
      Continue:= False;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextContainerEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: Edit;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTextContainerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result:= 'Text Items Editor...';
  else
    Result:= '';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTextContainerEditor.GetVerbCount: Integer;
begin
  Result:= 1
end;

end.
