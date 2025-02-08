unit LMDSctFloatingView;
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

LMDSctFloatingView unit (YB)
----------------------------
LMD Script Pack Importer floating view for old Delphi versions.

Changes
-------
Release 5.0 (September 2011)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, Dialogs, ToolsAPI, LMDSctImporterUnitDoc, LMDSctUnitFrame,
  LMDSctBatchFrame;

type
  { ************************** TLMDUnitFloatingView ************************** }

  TLMDUnitViewTraits = class(TComponent, ILMDUnitFrameTraits)
  private
    FForm:    TForm;
    FContent: TLMDUnitFrame;

    procedure SetContent(const Value: TLMDUnitFrame);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    {ILMDUnitFrameTraits}

    procedure UpdateCaption;
    procedure OpenUsedUnit(const AUnitName: string);
    function  UseExternalMessageView: Boolean;
    procedure BeginImporting;
    procedure ImportingProgress(AProgress: Integer);
    procedure EndImporting(ASucceded: Boolean);
  public
    constructor Create(AForm: TForm); reintroduce;
    destructor  Destroy; override;
    property    Content: TLMDUnitFrame read FContent write SetContent;
  end;

  TLMDUnitFloatingView = class
  public
    class function  GetView(AContent: TLMDUnitFrame): TForm;
    class procedure Finalize;
  end;

  {************************* TLMDBatchFloatingView ****************************}

  TLMDBatchTraits = class(TComponent, ILMDBatchFrameTraits)
  private
    FForm:    TForm;
    FContent: TLMDBatchFrame;

    procedure SetContent(const Value: TLMDBatchFrame);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    { ILMDBatchFrameTraits }

    function  UseExternalMessageView: Boolean;
    procedure BeginImporting;
    procedure UnitNotFound(const AUnitName: string);
    procedure HintsSaved(const AFilePath: string);
    procedure BeginUnitImport(ADocument: TLMDUnitDocument);
    procedure EndUnitImport(ADocument: TLMDUnitDocument; ASucceded: Boolean);
    procedure EndImporting(const ADocuments: array of TLMDUnitDocument;
                           ASucceded: Boolean);
  public
    constructor Create(AForm: TForm); reintroduce;
    destructor  Destroy; override;
    property    Content: TLMDBatchFrame read FContent write SetContent;
  end;

  TLMDBatchFloatingView = class
  public
    class procedure Execute;
    class procedure Finalize;
  end;

implementation

uses
  LMDSctExpertUnit;

var
  TraitsList: TList;

{ ---------------------------------------------------------------------------- }

class procedure TLMDUnitFloatingView.Finalize;
begin
  while TraitsList.Count > 0 do
    TLMDUnitViewTraits(TraitsList[0]).FForm.Free;
end;
   
{ ---------------------------------------------------------------------------- }

class function TLMDUnitFloatingView.GetView(
  AContent: TLMDUnitFrame): TForm;
var
  i:      Integer;
  form:   TForm;
  traits: TLMDUnitViewTraits;
begin
  for i := 0 to TraitsList.Count - 1 do
    if TLMDUnitViewTraits(TraitsList[i]).Content = AContent then
    begin
      Result := TLMDUnitViewTraits(TraitsList[i]).FForm;
      Exit;
    end;

  form              := TForm.Create(Application);
  form.ClientWidth  := AContent.Width;
  form.ClientHeight := AContent.Height;
  form.Position     := poScreenCenter;

  traits            := TLMDUnitViewTraits.Create(form);
  traits.Content    := AContent;
  Result            := traits.FForm;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.BeginImporting;
begin
  // Do nothing.
end;
                  
{ ---------------------------------------------------------------------------- }

constructor TLMDUnitViewTraits.Create(AForm: TForm);
begin
  inherited Create(AForm);

  FForm         := AForm;
  FForm.OnClose := FormClose;
  TraitsList.Add(Self);
end;
                 
{ ---------------------------------------------------------------------------- }

destructor TLMDUnitViewTraits.Destroy;
begin
  TraitsList.Remove(Self);
  Content := nil;
  inherited;
end;
               
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.EndImporting(ASucceded: Boolean);
begin
  // Do nothing.
end;
                    
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;
                     
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.ImportingProgress(AProgress: Integer);
begin
  // Do nothing.
end;
                     
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FContent) and (Operation = opRemove) then
  begin
    Content := nil;
    FForm.Release; // Close the form.
  end;
end;
                   
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.OpenUsedUnit(const AUnitName: string);
var
  path:   string;
  md:     IOTAModule;
  edtr:   IOTASourceEditor;
  doc:    TLMDUnitDocument;
  untfrm: TLMDUnitFrame;
  form:   TForm;
begin
  doc := FContent.Document;

  if doc.FileHandler.FindUsedPasFile(AUnitName, path) then
  begin
    (BorlandIDEServices as IOTAActionServices).OpenFile(path);

    md   := (BorlandIDEServices as IOTAModuleServices).FindModule(path);
    edtr := TLMDImporterExpert.EditorFromModule(md);

    if edtr <> nil then
    begin
      untfrm := TLMDUnitFrame.GetWizard(edtr);
      form   := TLMDUnitFloatingView.GetView(untfrm);

      form.Show;
    end;
  end;
end;
                    
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.SetContent(const Value: TLMDUnitFrame);
begin
  if FContent <> Value then
  begin
    if FContent <> nil then
    begin
      FContent.RemoveFreeNotification(Self);
      FContent.Parent  := nil;
      FContent.Visible := False;
      FContent.Traits  := nil;
    end;
    FContent := Value;
    if FContent <> nil then
    begin
      FContent.FreeNotification(Self);
      FContent.Traits  := Self;
      FContent.Align   := alClient;
      FContent.Visible := True;
      FContent.Parent  := FForm;
    end;
    UpdateCaption;
  end;
end;
                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.UpdateCaption;
begin
  if FContent <> nil then
    FForm.Caption := FContent.Caption;
end;
                   
{ ---------------------------------------------------------------------------- }

function TLMDUnitViewTraits.UseExternalMessageView: Boolean;
begin
  Result := False;
end;
          
{ ---------------------------------------------------------------------------- }

class procedure TLMDBatchFloatingView.Execute;
var
 form:   TForm;
 bfrm:   TLMDBatchFrame;
 traits: TLMDBatchTraits;
begin
  form := TForm.Create(Application);
  try
    bfrm              := TLMDBatchFrame.Create(form);
    form.Caption      := 'LMD-ScriptPack Batch Import';
    form.Position     := poScreenCenter;
    form.ClientWidth  := bfrm.Width;
    form.ClientHeight := bfrm.Height;
    traits            := TLMDBatchTraits.Create(form);
    traits.Content    := bfrm;

    form.ShowModal;
  finally
    form.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDBatchFloatingView.Finalize;
begin
  //!!!
end;

{ ---------------------------------------------------------------------------- }

{ TLMDBatchTraits }

procedure TLMDBatchTraits.BeginImporting;
begin
  // Do nothing. 
end;

procedure TLMDBatchTraits.BeginUnitImport(ADocument: TLMDUnitDocument);
begin
  // Do nothing.
end;

constructor TLMDBatchTraits.Create(AForm: TForm);
begin
  inherited Create(AForm); // Owned by the form.
  FForm := AForm;
end;

destructor TLMDBatchTraits.Destroy;
begin
  Content := nil;
  inherited;
end;

procedure TLMDBatchTraits.EndImporting(
  const ADocuments: array of TLMDUnitDocument; ASucceded: Boolean);
begin
  // Do nothing.
end;

procedure TLMDBatchTraits.EndUnitImport(ADocument: TLMDUnitDocument;
  ASucceded: Boolean);
begin
  // Do nothing.
end;

procedure TLMDBatchTraits.HintsSaved(const AFilePath: string);
begin
  // Do nothing.
end;

procedure TLMDBatchTraits.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FContent) and (Operation = opRemove) then
    Content := nil;
end;

procedure TLMDBatchTraits.SetContent(const Value: TLMDBatchFrame);
begin
  if FContent <> Value then
  begin
    if FContent <> nil then
    begin
      FContent.RemoveFreeNotification(Self);
      FContent.Parent  := nil;
      FContent.Visible := False;
      FContent.Traits  := nil;
    end;
    FContent := Value;
    if FContent <> nil then
    begin
      FContent.FreeNotification(Self);
      FContent.Traits  := Self;
      FContent.Align   := alClient;
      FContent.Visible := True;
      FContent.Parent  := FForm;
    end;
  end;
end;

procedure TLMDBatchTraits.UnitNotFound(const AUnitName: string);
begin
  // Do nothing.
end;

function TLMDBatchTraits.UseExternalMessageView: Boolean;
begin
  Result := False;
end;

initialization
  TraitsList := TList.Create;

{ ---------------------------------------------------------------------------- }
finalization
  TLMDUnitFloatingView.Finalize;
  TLMDBatchFloatingView.Finalize;
  FreeAndNil(TraitsList);

end.
