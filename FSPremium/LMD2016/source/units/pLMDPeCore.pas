unit pLMDPeCore;
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

LMD-Tools Core Controls Property Editors (RM)
---------------------------------------------
Centralized unit for all LMD-Tools Core Controls property editors.

Changes
-------
Release 8.0 (August 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors, 
  Windows, Classes, Sysutils, Dialogs, Graphics, TypInfo, Forms,
  LMDBase, LMDClass, LMDGraph, LMDWave, LMDCont, LMDSplt, LMDStrings, LMDShadow,
  pLMDCommon;

type

  {LMD-Tools related objects}
  {****************************************************************************}
  {----------------------------------------------------------------------------}
  TLMD3DProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {----------------------------------------------------------------------------}
  TLMDTextAndGlyphProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDDateTimeFormatProperty = class (TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBevelProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;

    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {----------------------------------------------------------------------------}
  TLMDBitmapStyleProperty = class(TEnumProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDButtonLayoutProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

 {----------------------------------------------------------------------------}
  TLMDFillObjectProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {----------------------------------------------------------------------------}
  TLMDFxProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;

    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {----------------------------------------------------------------------------}
  TLMDGradientProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {----------------------------------------------------------------------------}
  TLMDSmallBarProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDSplitterBarItemProperty = class(TClassProperty)
  private
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDTransparentProperty= class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDMemoLinesProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDMaskProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  // 8.0
  {----------------------------------------------------------------------------}
  TLMDTabSheetProperty = class(TComponentProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBitmapFXObjectProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit;override;
    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {----------------------------------------------------------------------------}
  TLMDAlphaObjectProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    function GetAttributes: TPropertyAttributes; override;
    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {*********************** TLMDStringListProperty *****************************}
  TLMDStringListProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDHTMLStringProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  procedure LMDCPShowBarItemDlg(aComponent: TLMDSplitterPanel; aDesigner: IDesigner);

  {helper-routines for component-/property editors}
  // 28-12-2001
  function LMDCPGetStrings(aList:TStrings; Ident: String):Boolean; overload;
  // ---

implementation
uses
  DesignConst, IStreams, StFilSys, ToolsApi,
  Consts, StdCtrls, ExtCtrls, Buttons, Controls, Registry, Extdlgs, Types,

  LMDFillObject,
  LMDGradient,
  LMDShapeFill,
  LMDBevel,
  LMDGlyphTextLayout,

  LMDButtonLayout,
  LMDTransparent,
  LMD3DCaption,
  LMDFXCaption,
  LMDCaption,
  LMDSmallBar,
  LMDBitmapEffectObject,
  LMDAlphaObject,
  LMDPageControl,
  LMDProcs, LMDUtils, LMDGraphUtils, LMDCustomMemo,

  pLMDMaskEditorDlg,  pLMDStringsEditorDlg,

  pLMDCPGetCore, pLMDCst, pLMDPECst;

// Helper Class for Code-Editor Support in LMD-Editors, Win32 only
// -----------------------------------------------------------------------------
type
  TLMDStringsModuleCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    FFileName: string;
    FStream: TStringStream;
    FAge: TDateTime;
  public
    constructor Create(const FileName: string; Stream: TStringStream; Age: TDateTime);
    destructor Destroy; override;
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  end;

  {************************** TOTAFile ****************************************}
  TOTAFile = class(TInterfacedObject, IOTAFile)
  private
    FSource: string;
    FAge: TDateTime;
  public
    constructor Create(const ASource: string; AAge: TDateTime);
    function GetSource: string;
    function GetAge: TDateTime;
  end;

{*********************** TLMDStringsModuleCreator***************************** }
{----------------------------- Public -----------------------------------------}
constructor TLMDStringsModuleCreator.Create(const FileName: string; Stream: TStringStream; Age: TDateTime);
begin
  inherited Create;
  FFileName:=FileName;
  FStream:=Stream;
  FAge:=Age;
end;

{------------------------------------------------------------------------------}
destructor TLMDStringsModuleCreator.Destroy;
begin
  FStream.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsModuleCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetAncestorName: string;
begin
  Result := ''
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetCreatorType: string;
begin
  Result := sText;
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetExisting: Boolean;
begin
  Result:= False
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetFileSystem: string;
begin
  Result:=sTStringsFileSystem;
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetFormName: string;
begin
  Result:= ''
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetImplFileName: string;
begin
  Result:= FFileName
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetIntfFileName: string;
begin
  Result:= ''
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetMainForm: Boolean;
begin
  Result:= False
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetOwner: IOTAModule;
begin
  Result:= nil
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetShowForm: Boolean;
begin
  Result:= False
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetShowSource: Boolean;
begin
  Result:= True
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.GetUnnamed: Boolean;
begin
  Result:= False
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result:= nil
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result:=TOTAFile.Create(FStream.DataString, FAge)
end;

{------------------------------------------------------------------------------}
function TLMDStringsModuleCreator.NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result:= nil
end;

{------------------------ Public ----------------------------------------------}
constructor TOTAFile.Create(const ASource: string; AAge: TDateTime);
begin
  inherited Create;
  FSource := ASource;
  FAge := AAge;
end;

{------------------------------------------------------------------------------}
function TOTAFile.GetAge: TDateTime;
begin
  Result := FAge;
end;

{------------------------------------------------------------------------------}
function TOTAFile.GetSource: string;
begin
  Result := FSource;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetStrings(aList:TStrings; Ident: String):Boolean;
var
  FEditor: TLMDfrmStringEditor;
  Stream: TStringStream;
  Age: TDateTime;
  Module: IOTAModule;
  ModuleServices: IOTAModuleServices;
  Editor: IOTAEditor;
  begin
  result:=False;
  FEditor:=TLMDfrmStringEditor.Create(nil);
  with FEditor do
    try
       StrList.Lines.Assign(TStrings(aList));
       case ShowModal of
         mrOK:
           begin
             aList.Assign(TStrings(StrList.Lines));
             result:=True
           end;
         mrYes:
           begin
             Result:= false;
             StFilSys.Register;
             ModuleServices:= BorlandIDEServices as IOTAModuleServices;
             Stream := TStringStream.Create(TStrings(StrList.Lines).Text);
             Stream.Position := 0;
             Age:= Now;
             Module:= ModuleServices.CreateModule(TLMDStringsModuleCreator.Create(Ident, Stream, Age));
             if Module <> nil then
               begin
                 Editor := Module.GetModuleFileEditor(0);
                 if Editor <> nil then
                   begin
                     Editor.MarkModified;
                     Editor.Show;
                  end;
               end;
           end;
           end;
    finally
      Free;
    end;
end;

{LMD-Tools related objects}
{******************************************************************************}
{******************************************************************************}

{********************** DateTimeFormatProperty ********************************}
{-------------------------- public --------------------------------------------}
function TLMDDateTimeFormatProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------------------}
Procedure TLMDDateTimeFormatProperty.Edit;
var
  s : string;
begin
  s := GetStrValue;
  if LMDCPGetDateTimeFormat(s) then
    SetStrValue(s);
end;

{********************* Class TLMD3DProperty ***********************************}
{------------------------------------------------------------------------------}
procedure TLMD3DProperty.Edit;
var
  a3D:TLMD3DCaption;
begin
  a3D:=TLMD3DCaption.Create;
  try
    a3D.Assign(TLMD3DCaption(Pointer(GetOrdValue)));
    if LMDCPGetFont3D(a3D) then
      SetOrdValue(Longint(Pointer(a3D)));
    finally
    a3D.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  aCanvas.FillRect (aRect);
  if not Assigned (Pointer(GetOrdValue)) then exit;
  with TLMD3DCaption(Pointer(GetOrdValue))do
  ACanvas.TextOut (aRect.Left+1, aRect.Top+1, GetSetStr);
end;

{------------------------------------------------------------------------------}
procedure TLMD3DProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMD3DProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDTextAndGlyphProperty *************************}
{------------------------------------------------------------------------------}
procedure TLMDTextAndGlyphProperty.Edit;
var
  aGTL:TLMDGlyphTextLayout;
begin
  aGTL:=TLMDGlyphTextLayout.Create;
  try
    aGTL.Assign(TLMDGlyphTextLayout(Pointer(GetOrdValue)));
    if LMDCPGetGlyphTextLayout(aGTL) then
      SetOrdValue(Longint(Pointer(aGTL)));
    finally
    aGTL.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTextAndGlyphProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDBevelProperty ********************************}
{------------------------------------------------------------------------------}
procedure TLMDBevelProperty.Edit;
var
  Bevel:TLMDBevel;
begin
  Bevel:=TLMDBevel.Create;
  try
    Bevel.Assign(TLMDBevel(Pointer(GetOrdValue)));
    if LMDCPGetBevel(Bevel) then SetOrdValue(Longint(Pointer(Bevel)));
  finally
    Bevel.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevelProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin
  aCanvas.FillRect (aRect);
  if not Assigned (Pointer(GetOrdValue)) then exit;
  with TLMDBevel(Pointer(GetOrdValue)) do
  ACanvas.TextOut (aRect.Left+1, aRect.Top+1, GetSetStr);
end;

{------------------------------------------------------------------------------}
procedure TLMDBevelProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDBevelProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDBitmapStyleProperty **************************}
{------------------------------------------------------------------------------}
procedure TLMDBitmapStyleProperty.Edit;
begin
  SetOrdValue(LongInt(LMDCPGetBitmapStyle(TLMDBitmapStyle(GetOrdValue))));
end;

{------------------------------------------------------------------------------}
function TLMDBitmapStyleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paValueList, paRevertable];
end;

{********************* Class TLMDButtonLayoutProperty *************************}
{------------------------------------------------------------------------------}
procedure TLMDButtonLayoutProperty.Edit;
var
  aG:TLMDButtonLayout;
begin
  aG:=TLMDButtonLayout.Create;
  try
    ag.Assign(TLMDButtonLayout(Pointer(GetOrdValue)));
    if LMDCPGetButtonLayout(aG) then SetOrdValue(Longint(Pointer(aG)));
    finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDButtonLayoutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDFillObjectProperty ***************************}
{------------------------------------------------------------------------------}
procedure TLMDFillObjectProperty.Edit;
var
  aG:TLMDFillObject;
begin
  aG:=TLMDFillObject.Create;
  try
    aG.Assign(TLMDFillObject(Pointer(GetOrdValue)));
    if LMDCPGetFillObject(aG) then SetOrdValue(Longint(Pointer(aG)));
    finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillObjectProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
var
  aG:TLMDFillObject;
  bRect : TRect;
  tmp:TBitmap;
begin
  if not Assigned (Pointer(GetOrdValue)) then exit;
  aG:=TLMDFillObject.Create;
  try
    aCanvas.FillRect (aRect);
    aG.Assign(TLMDFillObject(Pointer(GetOrdValue)));
    // more checks!!!
    if not (ag.Style in [sfNone, sfBitmapList]) and not (ag.Bitmap.Empty and (ag.style in [sfBitmap, sfBrushBitmap])) then
      begin
        bRect := aRect;
        InflateRect (bRect, -1, -1);
        bRect.Right:=bRect.Left+LMDPE_DEFVISUALWIDTH;
        aCanvas.TextOut (bRect.Right+2, ARect.Top+1, aG.GetSetStr);
        tmp:=TBitmap.Create;
        try
          LMDBmpCreateFromRect(tmp, bRect, clBtnFace);
          aG.FillCanvas(tmp.Canvas, Types.Rect(0,0,tmp.Width, tmp.Height), clBtnFace);
          aCanvas.Draw(bRect.Left, bRect.Top, tmp);
        finally
          tmp.Free;
        end;
      end
    else
      ACanvas.TextOut (ARect.Left+1, ARect.Top+1, aG.GetSetStr);
  finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillObjectProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDFillObjectProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDFxProperty ***********************************}
{------------------------------------------------------------------------------}
procedure TLMDFxProperty.Edit;
var
  aFontFX:TLMDFxCaption;
begin
  aFontFx:=TLMDFxCaption.Create;
  try
    aFontFx.Assign(TLMDFxCaption(Pointer(GetOrdValue)));
    if LMDCPGetFontFx(aFontFx) then
      SetOrdValue(Longint(Pointer(aFontFx)));
    finally
    aFontFx.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin
  aCanvas.FillRect (aRect);
  if not Assigned (Pointer(GetOrdValue)) then exit;
  with TLMDFXCaption(Pointer(GetOrdValue))do
  ACanvas.TextOut (aRect.Left+1, aRect.Top+1, GetSetStr);
end;

{------------------------------------------------------------------------------}
procedure TLMDFxProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{-----------------------------------------------------------------------}
function TLMDFxProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDGradientProperty *****************************}
{------------------------------------------------------------------------------}
procedure TLMDGradientProperty.Edit;
var
  aG:TLMDGradient;
begin
  aG:=TLMDGradient.Create;
  try
    aG.Assign(TLMDGradient(Pointer(GetOrdValue)));
    if LMDCPGetGradient(aG) then SetOrdValue(Longint(Pointer(aG)));
    finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
var
  aG:TLMDGradient;
  bRect : TRect;
  cr: HRGN;
begin
  if not Assigned (Pointer(GetOrdValue)) then exit;
  aG:=TLMDGradient.Create;
  try
    aCanvas.FillRect (ARect);
    aG.Assign(TLMDGradient(Pointer(GetOrdValue)));
    bRect := ARect;
    InflateRect (bRect, -1, -1);
    bRect.Right:=bRect.Left+LMDPE_DEFVISUALWIDTH;
    aCanvas.TextOut(bRect.Right+2, bRect.Top, '(TLMDGradient)');
    cr := CreateRectRgn (0,0,1, 1);
    try
      GetClipRgn (ACanvas.Handle, cr);
      with bRect do
        IntersectClipRect (ACanvas.Handle, Left, Top, Right, Bottom);
      aG.PaintGradient (ACanvas, bRect);
      SelectClipRgn (ACanvas.Handle, cr);
    finally
      DeleteObject (cr);
    end;
  finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradientProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDGradientProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDSmBarOptionsProperty *************************}
{------------------------------------------------------------------------------}
procedure TLMDSmallBarProperty.Edit;
var
  aSmBarOptions:TLMDSmallBar;
begin
  aSmBarOptions:=TLMDSmallBar.Create;
  try
    aSmBarOptions.Assign(TLMDSmallBar(Pointer(GetOrdValue)));
    if LMDCPGetSmallBar(aSmBarOptions) then
      SetOrdValue(Longint(Pointer(aSmBarOptions)));
    finally
    aSmBarOptions.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSmallBarProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{******************* Class TLMDSplitterBarItemProperty ************************}
{------------------------------------------------------------------------------}
type
  TLMDSplitterBarDialog=class(TObject)
  public
    Component:TLMDSplitterPanel;
    Designer: IDesigner;
    procedure GetItem(Sender:TObject);
    procedure GetItemClick(Sender:TObject);
    procedure ShowDialog;
  end;

  procedure TLMDSplitterBarDialog.GetItem(Sender:TObject);
  begin
    Designer.SelectComponent(Component.Bars[TListBox(Sender).ItemIndex]);
    Designer.Modified;
  end;

  procedure TLMDSplitterBarDialog.GetItemClick(Sender:TObject);
  begin
    GetItem(Sender);
    TForm(TComponent(Sender).Owner).Close;
  end;

  procedure TLMDSplitterBarDialog.ShowDialog;
  var
    i:Integer;
    tmp:String;
    lb:TListBox;
    ok:TButton;
    f:TForm;
    p:TPoint;

  const
    HORZ:array[Boolean] of String=(' - vertical', ' - horizontal');
  begin
    f:= TForm.Create(Application);
    with f do
      try
         // Form
         BorderStyle:=bsToolWindow;
         Font.Color:=clWindowText;
         Font.Name:='MS Sans Serif';
         Font.Height:=-11;
         Position:=poDefault;
         PixelsPerInch:=96;
         width:=246;
         Height:=92;

         {create additional resources}
         lb:=TListBox.Create(f);
         with lb do
           begin
             Parent:=f;
             SetBounds(6,6,166, 54);
             OnClick:=GetItem;
             OnDblClick:=GetItemClick;
           end;

         ok:=TButton.Create(f);
         with ok do
           begin
             ModalResult:=1;
             Caption:='OK';
             Default:=True;
             Cancel:=True;
             TabOrder:=0;
             Parent:=f;
             SetBounds(180,6,54, 23);
           end;

        Caption:=Component.Name+'.Bars';
         with TLMDSplitterPanel(Component) do
           for i:=0 to Pred(Bars.Count) do
             begin
               tmp:='Bar['+inttostr(i)+']';
               if (Bars.Count<3) or (Orientation=spCross) then
                  tmp:=tmp+HORZ[Bars[i].Horizontal]
               else
                 case Orientation of
                   spHorzDown, spHorzUp:
                     case i of
                       0:tmp:=tmp+HORZ[Bars[i].Horizontal];
                       1:tmp:=tmp+HORZ[Bars[i].Horizontal]+' (top)';
                       2:tmp:=tmp+HORZ[Bars[i].Horizontal]+' (bottom)';
                     end;
                   spVertRight, spVertLeft:
                     case i of
                       0:tmp:=tmp+HORZ[Bars[i].Horizontal];
                       1:tmp:=tmp+HORZ[Bars[i].Horizontal]+' (left)';
                       2:tmp:=tmp+HORZ[Bars[i].Horizontal]+' (right)';
                     end;
                 end;
               lb.Items.Add(tmp);
             end;
        GetCursorPos(p);
        Left:=p.X+4;
        Top:=p.Y+4;
        ShowModal;
      finally
        Free;
      end;
  end;

{------------------------------------------------------------------------------}
procedure LMDCPShowBarItemDlg(aComponent: TLMDSplitterPanel; aDesigner: IDesigner);
begin
  with TLMDSplitterBarDialog.Create do
    try
      Component:=aComponent;
      Designer:=aDesigner;
      ShowDialog;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterBarItemProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paDialog, paReadOnly];
end;

{------------------------------------------------------------------------------}
procedure TLMDSplitterBarItemProperty.Edit;
begin
  LMDCPShowBarItemDlg(TLMDSplitterPanel(GetComponent(0)), Designer);
end;

{********************* Class TLMDTransparentProperty***************************}
{------------------------------------------------------------------------------}
procedure TLMDTransparentProperty.Edit;
var
  aG:TLMDTransparent;
begin
  aG:=TLMDTransparent.Create;
  try
    aG.Assign(TLMDTransparent(Pointer(GetOrdValue)));
    if LMDCPGetTransparent(aG) then SetOrdValue(Longint(Pointer(aG)));
    finally
    aG.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDTransparentProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDMemoLinesProperty ****************************}
{------------------------------------------------------------------------------}
procedure TLMDMemoLinesProperty.Edit;
var
  aList:TStringList;
begin
  aList:=TStringList.Create;
  try
    aList.Text := TLMDMemoStrings(Pointer(GetOrdValue)).Text;
    if LMDCPGetStrings(aList) then
      TLMDMemoStrings(Pointer(GetOrdValue)).Text := aList.Text;
    finally
    aList.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDMemoLinesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------- TLMDMaskProperty -----------------------------------}
procedure TLMDMaskProperty.Edit;
var
  mask:String;
  MaskEditor:TLMDfrmMaskEditDlg;
begin
  Mask := GetStrValue;
  MaskEditor := TLMDfrmMaskEditDlg.Create(Application);
  try
    MaskEditor.MaskEdit.Text := Mask;
    if MaskEditor.ShowModal=mrOk then SetStrValue(MaskEditor.MaskEdit.Text);
  finally
    MaskEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDMaskProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

// 6.0
{********************* TLMDTabSheetEditor *************************************}
{------------------------------------------------------------------------------}
function TLMDTabSheetProperty.GetAttributes: TPropertyAttributes;
begin
  result:=[paValueList];
end;

{------------------------------------------------------------------------------}
procedure TLMDTabSheetProperty.GetValues(Proc: TGetStrProc);
var
  i:Integer;
begin
  with TLMDPageControl(GetComponent(0)) do
    for i:=0 to Pred(Count) do Proc(Pages[i].Name);
end;

{********************* Class TLMDBitmapFXObjectProperty ***************************}
{------------------------------------------------------------------------------}
procedure TLMDBitmapFXObjectProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin
  aCanvas.FillRect (aRect);
  if not Assigned (Pointer(GetOrdValue)) then exit;
  with TLMDBitmapEffectObject(Pointer(GetOrdValue)) do
  ACanvas.TextOut (aRect.Left+1, aRect.Top+1, GetSetStr);
end;

{------------------------------------------------------------------------------}
procedure TLMDBitmapFXObjectProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDBitmapFXObjectProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paMultiSelect, paDialog];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapFXObjectProperty.Edit;
var
  bo:TLMDBitmapEffectObject;
begin
  bo:=TLMDBitmapEffectObject.Create;
  try
    bo.Assign(TLMDBitmapEffectObject(Pointer(GetOrdValue)));
    if LMDCPGetBitmapEffectObject(bo) then SetOrdValue(Longint(Pointer(bo)));
    finally
    bo.Free;
  end;
end;

{********************* Class TLMDAlphaObjectProperty ***************************}
{------------------------------------------------------------------------------}
procedure TLMDAlphaObjectProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin
  aCanvas.FillRect (aRect);
  if not Assigned (Pointer(GetOrdValue)) then exit;
  with TLMDAlphaObject(Pointer(GetOrdValue))do
    ACanvas.TextOut (aRect.Left+1, aRect.Top+1, GetSetStr);
  end;

{------------------------------------------------------------------------------}
procedure TLMDAlphaObjectProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDAlphaObjectProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paMultiSelect];
end;

{********************* Class TLMDStringListProperty ***************************}
{------------------------------------------------------------------------------}
procedure TLMDStringListProperty.Edit;
var
  aList:TStringList;
  Ident: String;
  Module: IOTAModule;
begin
  Ident:= Designer.GetRoot.Name + '.' + TComponent(GetComponent(0)).Name + '.' + GetName;
  Module:= (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
  if (Module <> nil) and (Module.GetModuleFileCount > 0) then
    Module.GetModuleFileEditor(0).Show
  else
    begin
      aList:=TStringList.Create;
      try
        aList.Assign(TStrings(Pointer(GetOrdValue)));
        if LMDCPGetStrings(aList, Ident) then
          SetOrdValue(Longint(Pointer(aList)));
        finally
        aList.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDStringListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{******************** TLMDHTMLStringProperty **********************************}
{------------------------------------------------------------------------------}
function TLMDHTMLStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable, paDialog];
end;

{------------------------------------------------------------------------------}
procedure TLMDHTMLStringProperty.Edit;
var
  tmp:TLMDHTMLString;
begin
  tmp:=GetStrValue;
  if LMDCPGetHTMLString(tmp) then
    SetStrValue(tmp);
end;

end.

