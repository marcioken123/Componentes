unit pLMDPrintPE;
{$I LMDCmps.inc}

interface

uses
  Classes, TypInfo, Dialogs, DesignIntf, DesignEditors, VCLEditors, pLMDCommon,
  LMDTypes;

type
  { ********************* class TLMDPrinterEditor ******************* }
  TLMDPrinterEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  { ********************* class TLMDPrintTemplateProperty ******************* }
  TLMDPrintTemplateProperty = class(TClassProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

implementation

uses
  Forms, LMDPrinter, LMDPrintPageDialog,
  LMDPrintTemplateEditDlg, LMDPrintConst;

{ TLMDPrinterEditor }

procedure TLMDPrinterEditor.ExecuteVerb(Index: Integer);
var
    Printer: TLMDPrinter;
begin
  Printer := Component as TLMDPrinter;

  case Index of
    0:
    begin
      if Printer.ExecPageSetupDlg then
        Designer.Modified;
    end;
  else
    Assert(false);
  end;
end;

function TLMDPrinterEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SLMDPrintEditPrinterPageSettings;
  else
    Assert(false);
  end;
end;

function TLMDPrinterEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TLMDPrintTemplateProperty }

procedure TLMDPrintTemplateProperty.Edit;

function FindPrinter(AParent: TComponent; ALines: TObject): TLMDPrinter;
var
    i: Integer;
    Prn: TLMDPrinter;
begin
  Result := nil;

  for i:=0 to AParent.ComponentCount-1 do
    if AParent.Components[i] is TLMDPrinter then
    begin
      Prn := AParent.Components[i] as TLMDPrinter;

      if ((Prn.Header<>nil) and (ALines=Prn.Header.Template)) or
         ((Prn.Footer<>nil) and (ALines=Prn.Footer.Template))
      then
      begin
        Result := Prn;
        Break;
      end;
    end
    else if AParent.Components[i].ComponentCount>0 then
    begin
      Result := FindPrinter(AParent.Components[i], ALines);

      if Result<>nil then
        Break;
    end;
end;

var
    Lines: TStrings;
    Printer: TLMDPrinter;
    Cap: TLMDString;
    Dsg: IDesigner;
    Root: TComponent;
begin
  Dsg := Designer;
  Root := Dsg.GetRoot as TComponent;

  Lines := TObject(Pointer(GetOrdValue)) as TStrings;
  Printer := FindPrinter(Root, Lines);

  if (Printer<>nil) and (Printer.Header<>nil) and
     (Lines=Printer.Header.Template)
  then
    Cap := SLMDPrintHeaderEdit
  else if (Printer<>nil) and (Printer.Footer<>nil) and
          (Lines=Printer.Footer.Template)
  then
    Cap := SLMDPrintFooterEdit
  else
    Cap := SLMDPrintTemplateEdit;

  if LMDPrintExecTemplateDlg(Cap, Lines) then
    Modified;
end;

function TLMDPrintTemplateProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

end.
