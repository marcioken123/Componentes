{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       class       : TRAFormDesigner
       description : form designer for external files

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit RAFDDesigner;

interface

uses
  Windows, Messages, SysUtils, LibIntf, Classes, Controls, Forms, Graphics, Menus,
  TypInfo, DsgnIntf, RARTTI, fRAFDEditor, RAFDCompat;


const
  DM_PAINTSELECTION = WM_USER + 1;

type

  TRAFDForm = class;
  TSelection = class;
  TContainers = class;
  TGrabHandle = class;
  TCorner = (ccLeft, ccTop, ccRight, ccBottom, ccLeftTop, ccRightTop,
    ccRightBottom, ccLeftBottom);
  TAlignSelection = (asLeft, asRight, asTop, asBottom, asHorCenter, asHorInWin,
    asHorSpace, asVerCenter, asVerInWin, asVerSpace);

  TRAFormDesigner = class(TFormDesigner)
  private
    FGridX, FGridY: integer;
    FFileName: TFileName;
    FMethodList: TStrings;
    FSelection: TSelection;
    FContainers: TContainers;
    FOnActivate: TNotifyEvent;
    FOnFormActivate: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FOnSelectionChange: TNotifyEvent;
    FChanged: Boolean;
    StartPoint, EndPoint: TPoint;
    Corners: array[TCorner] of TRect;
    GrabHandles: array[TCorner] of TGrabHandle;
    Corner: TCorner;
    FResize: Boolean;
    FCornerCanvas: TCanvas;
    FFileEditor: TFileEditor;
    FMenu: TPopupMenu;
   {$IFDEF RA_D4H}
    ControlsRemoved: Boolean;
   {$ENDIF}
    function ReadComponentResFile(const FileName: string; Instance: TComponent)
      : TComponent;
    function ReadComponentRes(Stream: TStream; Instance: TComponent)
    	: TComponent;
    function ProcessDesignMsg(Sender: TControl; var Message: TMessage): Boolean;
    procedure RemoveControls;
    procedure Load;
    procedure NewForm;
    procedure CreatePaletteComponent(const X, Y: Integer);
  public { TDesigner }
    function IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;  override;
    procedure Modified;  override;
   {$IFDEF RA_D3}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
   {$ELSE}
    procedure Notification(AComponent: TPersistent; Operation: TOperation); override;
   {$ENDIF}
    procedure PaintGrid;  override;
    procedure ValidateRename(AComponent: TComponent;
      const CurName, NewName: string);  override;
    procedure Activate;
    procedure WriteDfm(const DfmFile: TFileName);
  public { TFormDesigner }
    function CreateMethod(const Name: string; TypeData: PTypeData): TMethod;  override;
    function GetMethodName(const Method: TMethod): string;  override;
    procedure GetMethods(TypeData: PTypeData; Proc: TGetStrProc);  override;
    function GetPrivateDirectory: string;  override;
   {$IFDEF RA_D3}
    procedure GetSelections(List: TComponentList); override;
    procedure SetSelections(List: TComponentList); override;
   {$ELSE}
    procedure GetSelections(const List: IDesignerSelections); override;
    procedure SetSelections(const List: IDesignerSelections); override;
   {$ENDIF}
    function MethodExists(const Name: string): Boolean;  override;
    procedure RenameMethod(const CurName, NewName: string);  override;
    procedure SelectComponent(Instance: TPersistent);  override;
    procedure ShowMethod(const Name: string);  override;
    function UniqueName(const BaseName: string): string;  override;
    procedure GetComponentNames(TypeData: PTypeData; Proc: TGetStrProc);  override;
    function GetComponent(const Name: string): TComponent;  override;
    function GetComponentName(Component: TComponent): string;  override;
    function GetObject(const Name: string): TPersistent;  override;
    function GetObjectName(Instance: TPersistent): string;  override;
    procedure GetObjectNames(TypeData: PTypeData; Proc: TGetStrProc);  override;
    function MethodFromAncestor(const Method: TMethod): Boolean;  override;
    function CreateComponent(ComponentClass: TComponentClass;
      Parent: TComponent; Left, Top, Width, Height: Integer): TComponent;  override;
    function IsComponentLinkable(Component: TComponent): Boolean;  override;
    procedure MakeComponentLinkable(Component: TComponent);  override;
    function GetRoot: TComponent;  override;
    procedure Revert(Instance: TPersistent; PropInfo: PPropInfo);  override;
    function GetIsDormant: Boolean;  override;
    function HasInterface: Boolean;  override;
    function HasInterfaceMember(const Name: string): Boolean;  override;
   // procedure AddInterfaceMember(const MemberText: string);  override;
  private
   { Selection }
    SenderControl: TControl;
    Component: TComponent;
    ComponentEditor: TComponentEditor;
    SelectionFrame: Boolean;
    MouseControl: TControl;
    SelFrame: TRect;
    procedure MakeContainers;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure DrawSelectionFrame(const OnlyRemove: Boolean);
    procedure ChangeSelection(Instance: TPersistent; const Group: Boolean);
    procedure UpdateCorners(Control: TControl);
    procedure UpdateGrabHandles(Control: TControl);
    procedure SelectionChanging;
    procedure SelectionChanged;
    procedure PaintSelection(const Paint: Boolean);
    procedure MoveResizeSelection;
    procedure MoveSelection(const DeltaX, DeltaY: Integer);
    procedure ResizeSelection(const DeltaX, DeltaY: Integer);
    procedure NextSelection(const DeltaX, DeltaY: Integer);
    procedure AdjustGroup(Instance: TPersistent);
    procedure SelectSenderControl;
   { function PtInCorner(Control: TControl; const Point: TPoint;
      var Corner: TCorner): Boolean; }
    procedure GrabMouseDown(Grab: TGrabHandle; const X, Y: Integer);
    function AlignToGrid(const P: TPoint): TPoint;
    procedure BringContainers;
    procedure SelectFrame(Rect: TRect);
    procedure MakeMenu;
    procedure MakeComponentMenu;
    procedure MenuClick(Sender: TObject);
    function NewItem(Caption: string; const Tag: Integer): TMenuItem;
    procedure ComponentRead(Component: TComponent);
    procedure ReaderSetName(Reader: TReader; Component: TComponent;
      var Name: string);
  public
   { Selection }
    function GetControl(Instance: TPersistent): TControl;
    function GetInstance(Control: TControl): TPersistent;
    procedure SelectParent;
    procedure AlignSelection(const AAlign: TAlignSelection);
    procedure ClearSelection; {$IFDEF RA_D5H} override; {$ENDIF}
    procedure DeleteSelection; {$IFDEF RA_D5H} override; {$ENDIF}
    procedure CopySelection; {$IFDEF RA_D5H} override; {$ENDIF}
    procedure PasteSelection; {$IFDEF RA_D5H} override; {$ENDIF}
  public
    constructor Create(const AFileName: TFileName; AFileEditor: TFileEditor);
    destructor Destroy; override;
    procedure SaveToFile(const AFileName: TFileName);
    procedure Save;
    procedure FileEditorClosed;
    property FileName: TFileName read FFileName;
    property FileEditor: TFileEditor read FFileEditor;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnFormActivate: TNotifyEvent read FOnFormActivate write FOnFormActivate;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property Changed: Boolean read FChanged write FChanged;
    property MethodList: TStrings read FMethodList;
  end;

  TRAFDForm = class(TForm)
  private
   // procedure FixupMethods;
    FFormState: TFormState;
    function GetRAFormDesigner: TRAFormDesigner;
    procedure SetRAFormDesigner(Value: TRAFormDesigner);
    procedure SetVisible(Value: Boolean);
    procedure DMPaintSelection(var Message: TMessage); message DM_PAINTSELECTION;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    procedure ReadState(Reader: TReader); override;
    procedure Activate; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Visible write SetVisible default False;
 {$IFDEF RA_D4H}
  private
    FRAFormDesigner: TRAFormDesigner;
 {$ENDIF RA_D4H}
  public
    property RAFormDesigner: TRAFormDesigner read GetRAFormDesigner write SetRAFormDesigner;
  end;

  TSelection = class(TList)
  private
    function Get(Index: Integer): TPersistent;
  public
    property Items[Index: Integer]: TPersistent read Get; default;
  end;

  TNameContainer = class(TCustomControl)
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;
  public
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  end;

  TContainer = class(TCustomControl)
  private
    FComponent: TComponent;
    FRAFormDesigner: TRAFormDesigner;
    FBitmap: TBitmap;
    FNameContainer: TNameContainer;
  protected
    procedure Paint; override;
  public
    constructor CreateParam(AOwner: TComponent; AComponent: TComponent;
      ARAFormDesigner: TRAFormDesigner);
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  end;

  TContainers = class(TList)
  private
    function Get(Index: Integer): TContainer;
  public
    destructor Destroy; override;
    property Items[Index: Integer]: TContainer read Get; default;
  end;

  TGrabHandle = class(TWinControl)
  private
    FCorner: TCorner;
    RAFormDesigner: TRAFormDesigner;
    procedure SetCorner(Value: TCorner);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Corner: TCorner read FCorner write SetCorner;
  end;

  TLoadComponentBitmapProc = procedure (Component: TComponent; Bitmap: TBitmap);

var
  ActiveDesigner: TRAFormDesigner;
  DefaultIcon: TIcon = nil;
  LoadComponentBitmapProc: TLoadComponentBitmapProc;

implementation

uses RAUtils, iMTracer, fRAFDPalette, RAFD;

type

  THackControl = class(TControl);
  THackCollection = class(TCollection);

  TRAFDReader = class(TReader)
  protected
    function FindMethod(Root: TComponent; const MethodName: string): Pointer;
      override;
  end;

const
  verbTag = 100;


procedure LoadComponentBitmap(Component: TComponent; Bitmap: TBitmap);
begin
  try
    Bitmap.LoadFromResourceName(hInstance, Component.ClassName);
  except
    Bitmap.LoadFromResourceName(hInstance, DefaultComponentBitmap);
  end;
end;    { LoadComponentBitmap }


function TRAFDReader.FindMethod(Root: TComponent; const MethodName: string)
  : Pointer;
var
  F: Integer;
begin
  F := TRAFDForm(Root).RAFormDesigner.FMethodList.IndexOf(MethodName);
  if F = -1 then
    F := TRAFDForm(Root).RAFormDesigner.FMethodList.Add(MethodName);
  Result := Pointer(F + 1); { 0 = nil, but we won't nil }
end;    { FindMethod }

function TSelection.Get(Index: Integer): TPersistent;
begin
  Result := inherited Items[Index];
end;    { Get }

function TContainers.Get(Index: Integer): TContainer;
begin
  Result := inherited Items[Index];
end;    { Get }

destructor TContainers.Destroy;
begin
  ClearList(Self);
  inherited Destroy;
end;    { Destroy }

constructor TContainer.CreateParam(AOwner: TComponent; AComponent: TComponent;
  ARAFormDesigner: TRAFormDesigner);
begin
  inherited Create(AOwner);
  FBitmap := TBitmap.Create;
  FBitmap.Transparent := True;
  FRAFormDesigner := ARAFormDesigner;
  Parent := FRAFormDesigner.Form;
	FComponent := AComponent;
  FNameContainer := TNameContainer.Create(Self);
  FNameContainer.Parent := Parent;
	SetBounds(LongRec(FComponent.DesignInfo).Lo,
    LongRec(FComponent.DesignInfo).Hi, 0, 0);
	SetDesigning(True);
  if Assigned(LoadComponentBitmapProc) then
    LoadComponentBitmapProc(FComponent, FBitmap);
end;    { Create }

destructor TContainer.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;    { Destroy }

procedure TContainer.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
  Canvas.CopyMode := cmPatPaint;
  Canvas.Draw(2, 2, FBitmap);
end;    { Paint }

procedure TContainer.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, 28, 28);
  FComponent.DesignInfo := ATop shl 16 + ALeft;
  FNameContainer.SetBounds(Left, Top, Width, Height);
end;    { SetBounds }

procedure TNameContainer.WndProc(var Message: TMessage);
begin
  with Message do
    case Msg of    { }
      WM_LBUTTONDOWN:
        begin
          TWMMouse(Message).Pos := PointToSmallPoint(
            (Owner as TContainer).ScreenToClient(ClientToScreen(
             SmallPointToPoint(TWMMouse(Message).Pos))));
          PostMessage((Owner as TContainer).Handle, Msg, WParam, LParam);
        end;
      else
        Dispatch(Message);
    end;    { case }
end;    { WndProc }

procedure TNameContainer.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Canvas.Brush.Style := bsClear;
  DrawText(Canvas.Handle, PChar((Owner as TContainer).FComponent.Name), -1,
    R, 0);
end;    { Paint }

procedure TNameContainer.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  ALeft := ALeft + AWidth div 2;
  AWidth := Canvas.TextWidth((Owner as TContainer).FComponent.Name);
  ALeft := ALeft - AWidth div 2;
  AHeight := Canvas.TextHeight((Owner as TContainer).FComponent.Name);
  inherited SetBounds(ALeft, ATop + 32, AWidth, AHeight);
end;    { SetBounds }

constructor TGrabHandle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clBlack;
end;    { Create }

procedure TGrabHandle.SetCorner(Value: TCorner);
const
  CornerCursors: array[TCorner] of TCursor = (
    crSizeWE, crSizeNS, crSizeWE, crSizeNS,
    crSizeNWSE, crSizeNESW, crSizeNWSE, crSizeNESW);
begin
  FCorner := Value;
  Cursor := CornerCursors[FCorner];
end;    { SetCorner }

procedure TGrabHandle.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button = mbLeft then
    RAFormDesigner.GrabMouseDown(Self, X, Y);
end;    { MouseDown }


{ TRAFDForm }
constructor TRAFDForm.Create(AOwner: TComponent);
begin
  ODS('TRAFDForm.Create');
 {$IFDEF RA_D}
  CreateNew(AOwner);
 {$ELSE}
  CreateNew(AOwner, 1);
 {$ENDIF}
  OnClose := FormClose;
//  Form.SetBounds(200, 100, 544, 375);
  SetBounds(200, DelphiIDE.GetMainWindowSize.Bottom + 2, 540, 355);
end;    { Create }

destructor TRAFDForm.Destroy;
begin
  ODS('TRAFDForm.Destroy');
  if Assigned(Designer) then
  begin
    RAFormDesigner.RemoveControls;
    Designer.Form := nil;
  end;
  inherited Destroy;
  TRAFormDesigner(Designer).Free;
end;    { Destroy }

procedure TRAFDForm.ReadState(Reader: TReader);
begin
  RAFormDesigner.FMethodList.Clear;
  inherited ReadState(Reader);
 // FixupMethods;
end;    { ReadState }

procedure TRAFDForm.Activate;
begin
  inherited Activate;
  RAFormDesigner.Activate;
end;    { Activate }

procedure TRAFDForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
  ShowWindow(Handle, SW_HIDE);
end;    { FormClose }

function TRAFDForm.GetRAFormDesigner: TRAFormDesigner;
begin
{$IFDEF RA_D3}
  Result := Designer as TRAFormDesigner;
{$ELSE}
  Result := FRAFormDesigner;
{$ENDIF RA_D3}
end;    { GetRAFormDesigner }

procedure TRAFDForm.SetRAFormDesigner(Value: TRAFormDesigner);
begin
{$IFDEF RA_D3}
  Designer := Value;
{$ELSE}
  FRAFormDesigner := Value;
  Designer := Value;
{$ENDIF RA_D3}
end;

procedure TRAFDForm.SetVisible(Value: Boolean);
begin
  if fsCreating in FFormState then
    if Value then
      Include(FFormState, fsVisible) else
      Exclude(FFormState, fsVisible)
  else
    inherited Visible := Value;
end;    { SetVisible }

procedure TRAFDForm.DMPaintSelection(var Message: TMessage);
begin
  RAFormDesigner.PaintSelection(Message.WParam = 1);
end;    { DMPaintSelection }

procedure TRAFDForm.WMSize(var Message: TWMSize);
begin
  inherited;
  if (fsShowing in FFormState) and (Designer <> nil) then
    Designer.Modified;
end;    { WMSize }

procedure TRAFDForm.WMMove(var Message: TWMMove);
begin
  inherited;
  if (fsShowing in FFormState) and (Designer <> nil) then
    Designer.Modified;
end;    { WMMove }


{ TRAFormDesigner }

constructor TRAFormDesigner.Create(const AFileName: TFileName;
  AFileEditor: TFileEditor);
var
  i: TCorner;
begin
  ODS('TRAFormDesigner.Create');
  inherited Create;
  FSelection := TSelection.Create;
  FContainers := TContainers.Create;
  FMethodList := TStringList.Create;
  FGridX := 8;
  FGridY := 8;
	for i := Low(Corners) to High(Corners) do
  begin
    GrabHandles[i] := TGrabHandle.Create(nil);
    GrabHandles[i].Corner := i;
    GrabHandles[i].RAFormDesigner := Self;
  end;
  FCornerCanvas := TCanvas.Create;
  FFileName := AFileName;
  FFileEditor:= AFileEditor;
  if FFileName <> '' then
    Load else
    NewForm;
  FFileEditor.Designer := Self;
  FMenu := TPopupMenu.Create(nil);
  MakeMenu;
end;    { Create }

destructor TRAFormDesigner.Destroy;
var
  i: TCorner;
begin { System }
  ODS('TRAFormDesigner.Destroy');
  if ActiveDesigner = Self then ActiveDesigner := nil;
  if Assigned(FOnDestroy) then FOnDestroy(Self);
  FSelection.Clear;
  SelectionChanged;

 { Next 4 line must be in this order, don't change: }
  if Assigned(Form) then Form.Designer := nil;
  RemoveControls;
  Form.Free;
  FContainers.Free;

  FSelection.Free;
  FMethodList.Free;
	for i := Low(Corners) to High(Corners) do
    GrabHandles[i].Free;
  FCornerCanvas.Free;
  FMenu.Free;
  ComponentEditor.Free;
  inherited Destroy;
end;    { Destroy }

procedure TRAFormDesigner.FileEditorClosed;
begin
  ODS('TRAFormDesigner.FileEditorClosed');
 {$IFDEF RA_D3}
  Free;
 {$ELSE}
  _AddRef;
  if Assigned(Form) then Form.Designer := nil;
  RemoveControls;
  Form.Free;
  Form := nil;
  _Release;
  //_Release;
 {$ENDIF}
end;

procedure TRAFormDesigner.RemoveControls;
var
  Corner: TCorner;
  i: Integer;
begin
 {$IFDEF RA_D4H}
  if ControlsRemoved then Exit;
 {$ENDIF}
  for i := 0 to FContainers.Count - 1 do
    FContainers[i].Parent := nil;
	for Corner := Low(Corners) to High(Corners) do
    GrabHandles[Corner].Parent := nil;
 {$IFDEF RA_D4H}
  ControlsRemoved := True;
 {$ENDIF}
end;    { RemoveControls }

function TRAFormDesigner.ReadComponentRes(Stream: TStream; Instance: TComponent)
	: TComponent;
var
	RAFDReader: TRAFDReader;
  oldPos: integer;
  I: Integer;
  Flags: TFilerFlags;
begin
  ODS('TRAFormDesigner.ReadComponentResFile');
	Stream.ReadResHeader;
	RAFDReader := TRAFDReader.Create(Stream, 4096);
	try
    oldPos := Stream.Position;
    ODS('DANGER !');
		Result := RAFDReader.ReadRootComponent(Instance);
    ODS('DANGER OK');
    if csDesigning in Instance.ComponentState then
    begin
      Stream.Position := oldPos;
      RAFDReader.ReadSignature;
      RAFDReader.ReadPrefix(Flags, I);
      RAFDReader.ReadStr; { skip classname }
      Instance.Name := RAFDReader.ReadStr;
    end;
	finally
		RAFDReader.Free;
	end;
end;    { ReadComponentRes }

function TRAFormDesigner.ReadComponentResFile(const FileName: string;
  Instance: TComponent) : TComponent;
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    Result := ReadComponentRes(Stream, Instance);
  finally
    Stream.Free;
  end;
end;    { ReadComponentResFile }

procedure TRAFormDesigner.NewForm;
begin
  Form := TRAFDForm.Create(nil);
  TRAFDForm(Form).RAFormDesigner := Self;
  TRAFDForm(Form).SetDesigning(True);
  Form.Name := 'Form1';
	ShowWindow(Form.Handle, SW_SHOWNOACTIVATE);
end;    { NewForm }

procedure TRAFormDesigner.Load;
begin
  if not FileExists(FFileName) then
    RAFDErrorN(deFileNotFound, FFileName);
 // Form.Free;
  Form := TRAFDForm.Create(nil);
  TRAFDForm(Form).RAFormDesigner := Self;
  TRAFDForm(Form).SetDesigning(True);
	Include(TRAFDForm(Form).FFormState, fsCreating);
  try
    ReadComponentResFile(FFileName, Form);
    Exclude(TRAFDForm(Form).FFormState, fsCreating);
  except
    ODS('Error creating form');
    try
      Form.Free;
    except
     { I don't know why exceptions occurs in Form.Free }
    end;
    Form := nil;
    raise;
  end;
  try
    if TRAFDForm(Form).Icon.Empty then
    begin
      SendMessage(Form.Handle, WM_SETICON, 1, DefaultIcon.Handle);
      if IsIconic(Form.Handle) then Form.Invalidate;
    end;
    MakeContainers;
    ShowWindow(Form.Handle, SW_SHOW);
  finally
		Include(TRAFDForm(Form).FFormState, fsShowing);
  end;
//  TRAFDForm(Form).Visible := False;
 // if Assigned(FOnChange) then FOnChange(Self);
end;    { LoadFromFile }

procedure TRAFormDesigner.SaveToFile(const AFileName: TFileName);
begin
  WriteDfm(AFileName);
  FChanged := False;
  FFileName := AFileName;
end;    { SaveToFile }

procedure TRAFormDesigner.Save;
var
  TmpFileName: TFileName;
  BakFileName: TFileName;
begin
  TmpFileName := GenTempFileName(FileName);
  BakFileName := ChangeFileExt(FileName, '.~df');
  try
    WriteDfm(TmpFileName);
  except
    DeleteFile(TmpFileName);
    raise;
  end;    { try/except }
	RenameFile(FileName, BakFileName);
	RenameFile(TmpFileName, FileName);
	DeleteFile(BakFileName);
  FChanged := False;
end;    { SaveToFile }

procedure TRAFormDesigner.WriteDfm(const DfmFile: TFileName);
var
  MethodTable: PMethodTable;
  MethodTableSize: Integer;

  procedure MakeMethodTable;
  var
    i: Integer;
    P: PMethodTable;
  begin
    if FMethodList.Count = 0 then
      MethodTable := nil
    else
    begin
      MethodTableSize := sizeof(MethodTable^.EntryCount) +
        sizeof(TMethodEntry) * FMethodList.Count;
      GetMem(MethodTable, MethodTableSize);
      MethodTable^.EntryCount := FMethodList.Count;
      P := IncPtr(MethodTable, sizeof(MethodTable^.EntryCount));
      for i := 0 to MethodTable^.EntryCount - 1 do    { Iterate }
      begin
        PMethodEntry(P).Size := 6 + Length(FMethodList[i]) + 1;
        PMethodEntry(P).Code := Pointer(i + 1);
        PMethodEntry(P).Name := FMethodList[i];
        P := IncPtr(P, PMethodEntry(P).Size);
      end;    { for }
    end;
  end;    { MakeMethodTable }

var
  Obj: TComponent;
  oldVMT: Pointer;
begin
  with TRARTTIMaker.Create(nil) do
    try
      Obj := Form;
      oldVMT := PPointer(Obj)^;
      MakeMethodTable;
      try
        MakeClass(Form);
        RClass.ClassName := 'T' + Obj.Name;
        RClass.VMT.MethodTable := MethodTable;
        RClass.VMT.Parent := IncPtr(TForm, vmtOffset);
        PPointer(Obj)^ := CClass;
        WriteComponentResFile(DfmFile, Obj);
      finally { wrap up }
        PPointer(Obj)^ := oldVMT;
        if MethodTable <> nil then
          FreeMem(MethodTable, MethodTableSize);
      end;    { try/finally }
    finally { wrap up }
      Free;
    end;    { try/finally }
end;    { WriteDfm }

procedure TRAFormDesigner.PaintGrid;
var
  iX, iY: Integer;
begin
  for iX := 0 to Form.ClientWidth div FGridX do
    for iY := 0 to Form.ClientHeight div FGridY do
      Form.Canvas.Pixels[iX * FGridX, iY * FGridY] := clWindowText;
end;    { PaintGrid }

procedure TRAFormDesigner.Activate;
begin
  ODS('TRAFormDesigner.Activate');
  if ActiveDesigner <> Self then
  begin
    ActiveDesigner := Self;
    if Assigned(FOnActivate) then FOnActivate(Self);
  end;
  if Assigned(FOnFormActivate) then FOnFormActivate(Form);
  SelectionChanged;
end;    { Activate }

procedure TRAFormDesigner.Modified;
begin
  FChanged := True;
  if Assigned(FOnChange) then FOnChange(Self);
  if Assigned(DelphiIDE) then
    DelphiIDE.ActiveFormModified;
  PaintSelection(True);
end;    { Modified }

procedure TRAFormDesigner.ValidateRename(AComponent: TComponent;
  const CurName, NewName: string);
begin
  if (NewName <> '') and not (csReading in Form.ComponentState) then
    if CurName = '' then
      if AComponent <> nil then
        FFileEditor.CreateComponent(AComponent, NewName) else
    else
      if AComponent = nil then
        FFileEditor.RenameForm(CurName, NewName) else
        FFileEditor.RenameComponent(AComponent, NewName)
end;    { ValidateRename }


{$IFDEF RA_D3}
procedure TRAFormDesigner.Notification(AComponent: TComponent;
  Operation: TOperation);
{$ELSE}
procedure TRAFormDesigner.Notification(AComponent: TPersistent;
  Operation: TOperation);
{$ENDIF}
var
  i: integer;
  Selection: TPersistent;
  Control: TControl;
begin
  if fsCreating in TRAFDForm(Form).FFormState then Exit;
  case Operation of
   { opInsert: // next line moved to ValidateRename
      FFileEditor.CreateComponent(AComponent); }
    opRemove :
     {$IFDEF RA_D4H}
      if AComponent is TComponent then
     {$ENDIF RA_D4H}
      begin
        FFileEditor.DeleteComponent(AComponent as TComponent);
        for i := 0 to FSelection.Count - 1 do    { Iterate }
        begin
          Selection := FSelection[i];
          if Selection = AComponent then
    			begin
            FSelection.Delete(i);
            if not (Selection is TControl) then
            begin
              Control := GetControl(Selection);
              if Control is TContainer then
              begin
                FContainers.Remove(Control);
                Control.Free;
              end;
            end;  
            PaintSelection(True);
            Break;
    			end;
        end;
      end;
  end;
end;    { Notification }

{ TFormDesigner }

function TRAFormDesigner.GetPrivateDirectory: string;
begin
  Result := ExePath;
end;    { GetPrivateDirectory }

function TRAFormDesigner.UniqueName(const BaseName: string): string;
var
  i: integer;
  BN: string;
begin
  if BaseName = '' then
  begin
    Result := BaseName;
    Exit;
  end;
  BN := BaseName;
  if (Length(BN) > 1) and (BN[1] = 'T') then
    Delete(BN, 1, 1);
  while (Length(BN) > 0) and (BN[Length(BN)] in ['0'..'9']) do
    Delete(BN, Length(BN), 1);
  i := 1;
  Result := BN + IntToStr(i);
  while GetComponent(Result) <> nil do
  begin
    inc(i);
    Result := BN + IntToStr(i);
  end;
end;    { UniqueName }

procedure TRAFormDesigner.GetComponentNames(TypeData: PTypeData;
  Proc: TGetStrProc);
var
  i: integer;
begin
  for i := 0 to Form.ComponentCount - 1 do    { Iterate }
    if Form.Components[i] is TypeData^.ClassType then
    begin
      ODS(Form.Components[i].Name);
      Proc(GetComponentName(Form.Components[i]));
    end;
end;

function TRAFormDesigner.GetComponent(const Name: string): TComponent;
begin
  if Cmp(Name, GetRoot.Name) then
    Result := GetRoot else
  begin
    if Pos('.', Name) > 0 then
      Result := GetRoot.FindComponent(SubStr(Name, 1, '.')) else
      Result := GetRoot.FindComponent(Name)
  end;
end;    { GetComponent }

function TRAFormDesigner.GetComponentName(Component: TComponent): string;
begin
  Result := '';
  if Component = nil then Exit;
  if (Component = GetRoot) or (Component.Owner = GetRoot) then
    Result := Component.Name else
    Result := GetRoot.Name + '.' + Component.Name;
end;    { GetComponentName }

function TRAFormDesigner.GetObject(const Name: string): TPersistent;
begin
  Result := GetRoot.FindComponent(Name);
  //..
end;

function TRAFormDesigner.GetObjectName(Instance: TPersistent): string;
begin
  if Instance is TComponent then
    Result := (Instance as TComponent).Name
  else if Instance is TCollection then
    Result := THackCollection(Instance).PropName
  else if Instance is TCollectionItem then
    Result := GetObjectName((Instance as TCollectionItem).Collection) + '[' +
      IntToStr((Instance as TCollectionItem).Index) + ']'
  else
    RAFDErrorN(deNotYetImplemented, 'GetObjectName');
end;    { GetObjectName }

procedure TRAFormDesigner.GetObjectNames(TypeData: PTypeData;
  Proc: TGetStrProc);
begin
  //..
end;

function TRAFormDesigner.CreateComponent(ComponentClass: TComponentClass;
  Parent: TComponent; Left, Top, Width, Height: Integer): TComponent;
begin
  FSelection.Clear;
  Result := ComponentClass.Create(Form);
  Result.Name := UniqueName(Result.ClassName);
  Result.DesignInfo := Top shl 16 + Left;
  if Result is TControl then
  begin
    if Width = 0 then Width := (Result as TControl).Width;
    if Height = 0 then Height := (Result as TControl).Height;
    (Result as TControl).SetBounds(Left, Top, Width, Height);
  end
  else if not NoIcon(Result) then
    FContainers.Add(TContainer.CreateParam(nil, Result, Self));
  THackControl(Result).SetParentComponent(THackControl(Parent).GetChildParent);
  BringContainers;
  Modified;
end;

function TRAFormDesigner.IsComponentLinkable(Component: TComponent): Boolean;
begin
  Result := False;
  //..
end;

procedure TRAFormDesigner.MakeComponentLinkable(Component: TComponent);
begin
  //..
end;

function TRAFormDesigner.GetRoot: TComponent;
begin
  Result := Form;
end;

procedure TRAFormDesigner.Revert(Instance: TPersistent; PropInfo: PPropInfo);
begin
  //..
end;

function TRAFormDesigner.GetIsDormant: Boolean;
begin
  Result := False;
end;

function TRAFormDesigner.HasInterface: Boolean;
begin
  Result := False;
end;

function TRAFormDesigner.HasInterfaceMember(const Name: string): Boolean;
begin
  Result := False;
end;

{
procedure TRAFormDesigner.AddInterfaceMember(const MemberText: string);
begin
end;
}

{ Methods }
function TRAFormDesigner.MethodFromAncestor(const Method: TMethod): Boolean;
begin
  Result := False;
end;

function TRAFormDesigner.MethodExists(const Name: string): Boolean;
begin
  Result := FFileEditor.MethodExists(Name);
end;

procedure TRAFormDesigner.RenameMethod(const CurName, NewName: string);
var
  F: Integer;
begin
//  Error('Method renaming not implemented, sorry.');
  F := FMethodList.IndexOf(CurName);
  if F = -1 then
		RAFDErrorN(deCantRenameMethod, CurName);
  FFileEditor.RenameMethod(CurName, NewName);
  FMethodList[F] := NewName;
end;

procedure TRAFormDesigner.ShowMethod(const Name: string);
begin
  FFileEditor.ShowMethod(Name);
end;

function TRAFormDesigner.CreateMethod(const Name: string; TypeData: PTypeData)
  : TMethod;
var
  F: Integer;
begin
  //.. !!!! methods !!!!
  if Name = '' then Exit;
  F := FMethodList.IndexOf(Name);
  if F = -1 then
  begin
    FFileEditor.CreateMethod(Name, TypeData);
    F := FMethodList.Add(Name);
  end;
  if F > -1 then
  begin
    Result.Code := Pointer(F + 1);
    Result.Data := Form;
  end;
end;

function TRAFormDesigner.GetMethodName(const Method: TMethod): string;
begin
  //.. !!!! methods !!!!
 { !!!! DEBUG !!!! }
  if (Integer(Method.Code) > 0) and
     (Integer(Method.Code) <= FMethodList.Count) then
    Result := FMethodList[Integer(Method.Code) - 1] else
    Result := '';
end;

procedure TRAFormDesigner.GetMethods(TypeData: PTypeData; Proc: TGetStrProc);
begin
  FFileEditor.GetMethods(TypeData, Proc);
end;


{ Selections }

{$IFDEF RA_D3}
procedure TRAFormDesigner.GetSelections(List: TComponentList);
{$ELSE}
procedure TRAFormDesigner.GetSelections(const List: IDesignerSelections);
{$ENDIF}
var
  i: integer;
begin
  ODS('TRAFormDesigner.GetSelections');
  for i := 0 to FSelection.Count - 1 do    { Iterate }
 {$IFDEF RA_D3}
    List.Add(FSelection[i])
 {$ELSE}
    List.Add(MakeIPersistent(FSelection[i]))
 {$ENDIF}
end;    { GetSelections }

function TRAFormDesigner.GetControl(Instance: TPersistent): TControl;
var
  i: integer;
begin
  if Instance is TControl then
    Result := Instance as TControl
  else
  begin
    for i := 0 to FContainers.Count - 1 do    { Iterate }
    begin
      Result := FContainers[i];
      if TContainer(Result).FComponent = Instance then Exit;
    end;    { for }
    Result := nil;
  end;
end;    { AddSelection }

function TRAFormDesigner.GetInstance(Control: TControl): TPersistent;
begin
  if Control is TContainer then
    Result := TContainer(Control).FComponent else
    Result := Control;
end;

procedure TRAFormDesigner.SelectComponent(Instance: TPersistent);
begin
  SelectionChanging;
  FSelection.Clear;
  if Instance <> GetRoot then
    FSelection.Add(Instance);
  SelectionChanged;
end;    { SelectComponent }

procedure TRAFormDesigner.MakeContainers;
var
  i: integer;
  Comp: TComponent;
begin
  ClearList(FContainers);
  for i := 0 to Form.ComponentCount - 1 do    { Iterate }
  begin
    Comp := Form.Components[i];
    if not (Comp is TControl) and not NoIcon(Comp) then
      FContainers.Add(TContainer.CreateParam(nil, Comp, Self));
  end;
end;    { MakeContainers }

procedure TRAFormDesigner.ChangeSelection(Instance: TPersistent;
  const Group: Boolean);
begin
  SelectionChanging;
  if not Group then FSelection.Clear;
  if Instance <> GetRoot then
    if FSelection.IndexOf(Instance) > -1 then
      FSelection.Remove(Instance) else
      FSelection.Add(Instance);
  SelectionChanged;
end;    { ChangeSelection }

{$IFDEF RA_D3}
procedure TRAFormDesigner.SetSelections(List: TComponentList);
{$ELSE}
procedure TRAFormDesigner.SetSelections(const List: IDesignerSelections);
{$ENDIF}
var
  i: integer;
begin
  ODS('TRAFormDesigner.SetSelections');
  SelectionChanging;
  FSelection.Clear;
  for i := 0 to List.Count - 1 do
   {$IFDEF RA_D3}
    FSelection.Add(List[i]);
   {$ELSE}
    FSelection.Add(ExtractPersistent(List[i]));
   {$ENDIF}
  SelectionChanged;
end;    { SetSelections }

procedure TRAFormDesigner.ClearSelection;
begin
  if FSelection.Count > 0 then
  begin
    SelectionChanging;
    FSelection.Clear;
    SelectionChanged;
  end;
end;    { ClearSelection }

procedure TRAFormDesigner.SelectionChanging;
begin
  PaintSelection(False);
end;    { SelectionChanging }

procedure TRAFormDesigner.SelectionChanged;
begin
 { paint selection only for components showing in form window }
  if FSelection.Count > 0 then
    PaintSelection(True);
  if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end;    { SelectionChanged }

procedure TRAFormDesigner.UpdateCorners(Control: TControl);
begin
  with Control.ClientRect do
  begin
  	Corners[ccLeftTop] := Bounds(0, 0, 5, 5);
  	Corners[ccRightTop] := Bounds(Right - 5, 0, 5, 5);
  	Corners[ccLeftBottom] := Bounds(0, Bottom - 5, 5, 5);
  	Corners[ccRightBottom] := Bounds(Right - 5, Bottom - 5,	5, 5);
  end;
end;    { UpdateCorners }

procedure TRAFormDesigner.UpdateGrabHandles(Control: TControl);

  procedure SetCorner(Corner: TCorner; const ALeft, ATop: Integer);
  var
    P: TPoint;
  begin
    P := Form.ScreenToClient(Control.Parent.ClientToScreen(Point(ALeft, ATop)));
		GrabHandles[Corner].BoundsRect := Bounds(P.X, P.Y, 5, 5);
   // GrabHandles[Corner].Parent := Form;
    GrabHandles[Corner].ParentWindow := Form.Handle;
		GrabHandles[Corner].Visible := True;
    GrabHandles[Corner].BringToFront;
  end;    { SetCorner }

begin
  with Control.BoundsRect do
  begin
  	SetCorner(ccLeftTop, Left - 2, Top - 2);
  	SetCorner(ccRightTop, Right - 3, Top - 2);
  	SetCorner(ccLeftBottom, Left - 2, Bottom - 3);
  	SetCorner(ccRightBottom, Right - 3, Bottom - 3);
  	SetCorner(ccLeft, Left - 2, Top + (Bottom - Top) div 2 - 2);
  	SetCorner(ccTop, Left + (Right - Left) div 2 - 2, Top - 2);
  	SetCorner(ccRight, Right - 3, Top + (Bottom - Top) div 2 - 3);
  	SetCorner(ccBottom, Left + (Right - Left) div 2 - 2, Bottom - 3);
  end;    { with }
end;    { UpdateGrabHandles }

procedure TRAFormDesigner.PaintSelection(const Paint: Boolean);
var
  i: integer;
  Control: TControl;
  H: HWND;
  j: Integer;
  Control2: TControl;
  ParentControl: TWinControl;
  R: TRect;
  Corner: TCorner;
begin
  if not Paint or (FSelection.Count <> 1) then
  	for Corner := Low(TCorner) to High(TCorner) do    { Iterate }
  		GrabHandles[Corner].Visible := False;
	if FSelection.Count = 1 then
  begin
    Control := GetControl(FSelection[0]);
    if Paint and (Control <> nil) then
  		UpdateGrabHandles(Control);
  end
	else
  try
   { multiselect }
    for i := 0 to FSelection.Count - 1 do    { Iterate }
    begin
			Control := GetControl(FSelection[i]);
      if Control = nil then Exit;
			FCornerCanvas.Handle := THackControl(Control).GetDeviceContext(H);
			UpdateCorners(Control);
			if Paint then
			begin
				FCornerCanvas.Brush.Color := clGray;
				FCornerCanvas.FillRect(Corners[ccLeftTop]);
				FCornerCanvas.FillRect(Corners[ccRightTop]);
				FCornerCanvas.FillRect(Corners[ccRightBottom]);
				FCornerCanvas.FillRect(Corners[ccLeftBottom]);
			end
			else
			begin
				Control.Invalidate;
				if not (Control is TWinControl) then
				begin
					ParentControl := Control.Parent;
					for j := 0 to ParentControl.ControlCount - 1 do    { Iterate }
					begin
						Control2 := ParentControl.Controls[j];
						if IntersectRect(R, Control.BoundsRect, Control2.BoundsRect) then
							Control2.Invalidate;
					end;
				end;
			end;
		end;
  finally { wrap up }
    FCornerCanvas.Handle := 0;
  end;    { try/finally }
end;    { PaintSelection }

procedure TRAFormDesigner.MoveResizeSelection;
var
  DX, DY: Integer;
begin
  DX := (EndPoint.X - StartPoint.X) div FGridX * FGridX;
  DY := (EndPoint.Y - StartPoint.Y) div FGridY * FGridY;
	if FResize then
  begin
    if FSelection[0] is TControl then
      with FSelection[0] as TControl do
        case Corner of    { }
          ccLeft       : SetBounds(Left + DX, Top, Width - DX, Height);
          ccRight      : SetBounds(Left, Top, Width + DX, Height);
          ccTop        : SetBounds(Left, Top + DY, Width, Height - DY);
          ccBottom     : SetBounds(Left, Top, Width, Height + DY);
          ccLeftTop    : SetBounds(Left + DX, Top + DY, Width - DX, Height - DY);
          ccRightTop   : SetBounds(Left, Top + DY, Width + DX, Height - DY);
          ccLeftBottom : SetBounds(Left + DX, Top, Width - DX, Height + DY);
          ccRightBottom: SetBounds(Left, Top, Width + DX, Height + DY);
        end;    { case }
    Modified;
  end
  else
    MoveSelection(DX, DY);
end;    { MoveResizeSelection }

procedure TRAFormDesigner.MoveSelection(const DeltaX, DeltaY: Integer);
var
  i: integer;
begin
  for i := 0 to FSelection.Count - 1 do    { Iterate }
		with GetControl(FSelection[i]) do
			SetBounds(Left + DeltaX, Top + DeltaY, Width, Height);
  Modified;
end;    { MoveSelection }

procedure TRAFormDesigner.ResizeSelection(const DeltaX, DeltaY: Integer);
var
  i: integer;
begin
  for i := 0 to FSelection.Count - 1 do    { Iterate }
		with GetControl(FSelection[i]) do
			SetBounds(Left, Top, Width + DeltaX, Height + DeltaY);
  Modified;
end;    { ResizeSelection }

procedure TRAFormDesigner.NextSelection(const DeltaX, DeltaY: Integer);
begin
end;    { NextSelection }

procedure TRAFormDesigner.SelectParent;
var
  Control: TControl;
begin
  if FSelection.Count = 0 then Exit;
  Control := GetControl(FSelection[0]);
 //.. 
  SelectComponent(Control.Parent);
end;    { SelectParent }

procedure TRAFormDesigner.AlignSelection(const AAlign: TAlignSelection);
var
  i: Integer;
  Source: TControl;
begin
  Source := GetControl(FSelection[0]);
  if (FSelection.Count < 2) or (Source = nil) then Exit;
  for i := 0 to FSelection.Count - 1 do
    if GetControl(FSelection[i]).Parent <> Source.Parent then
    begin
      AdjustGroup(Source);
      Exit;
    end;
  for i := 1 to FSelection.Count - 1 do
    with GetControl(FSelection[i]) do
      case AAlign of
        asLeft  : Left := Source.Left;
        asRight : Left := Source.Left + Source.Width - Width;
        asTop   : Top := Source.Top;
        asBottom: Top := Source.Top + Source.Height - Height;
       { asHorCenter:
        asHorInWin :
        asHorSpace :
        asVerCenter:
        asVerInWin :
        asVerSpace : }
      end;    { case }
end;    { AlignSelection }

procedure TRAFormDesigner.DeleteSelection;
begin
  SelectionChanging;
  while FSelection.Count > 0 do
    FSelection[0].Free;
  Modified;
  SelectionChanged;
end;    { DeleteSelection }

procedure TRAFormDesigner.AdjustGroup(Instance: TPersistent);
var
  i: integer;
  Ch: Boolean;
  Control: TControl;
begin
  Control := GetControl(Instance);
  if Control = nil then Exit;
  Ch := False;
  i := 0;
  while i <= FSelection.Count - 1 do
    if GetControl(FSelection[i]).Parent <> Control.Parent then
    begin
      if not Ch then SelectionChanging;
      Ch := True;
      FSelection.Delete(i);
    end else
      inc(i);
  if Ch then SelectionChanged;
end;    { AdjustGroup }

procedure TRAFormDesigner.SelectSenderControl;
begin
  if not ((FSelection.Count = 1) and (FSelection[0] = SenderControl)) then
  begin
    SelectionChanging;
    FSelection.Clear;
    if SenderControl <> GetRoot then
      FSelection.Add(GetInstance(SenderControl));
    SelectionChanged;
  end;
end;    { SelectSenderControl }

procedure TRAFormDesigner.GrabMouseDown(Grab: TGrabHandle; const X, Y: Integer);
begin
	TRAFDForm(Form).MouseCapture := True;
	StartPoint := Grab.ClientToScreen(Point(X, Y));
	Corner := Grab.Corner;
	FResize := True;
end;    { GrabMouseDown }

function TRAFormDesigner.AlignToGrid(const P: TPoint): TPoint;
begin
  Result.X := (P.X + FGridX div 2) div FGridX * FGridX;
  Result.Y := (P.Y + FGridY div 2) div FGridY * FGridY;
end;    { AlignToGrid }

function TRAFormDesigner.IsDesignMsg(Sender: TControl; var Message: TMessage)
  : Boolean;
begin
  case Message.Msg of    { }
    WM_MOUSEFIRST .. WM_MOUSELAST, WM_KEYDOWN, WM_PAINT:
      Result := ProcessDesignMsg(Sender, Message)
    else
      Result := False;
  end;    { case }
end;    { IsDesignMsg }

function TRAFormDesigner.ProcessDesignMsg(Sender: TControl;
  var Message: TMessage): Boolean;
var
  Root: TComponent;
begin
  Result := True;
  case Message.Msg of    { }
    WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE, WM_KEYDOWN,
    WM_RBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
        SenderControl := Sender;
        Root := GetRoot;
        if (SenderControl <> Root) and not (SenderControl is TContainer) and
           (SenderControl.Owner <> Root) then
          while SenderControl.Owner <> Root do
            SenderControl := SenderControl.Parent;
        if SenderControl is TContainer then
          Component := TContainer(SenderControl).FComponent else
          Component := SenderControl;
        if SenderControl <> Sender then
          case Message.Msg of    { }
            WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE,
            WM_RBUTTONDOWN, WM_LBUTTONDBLCLK:
              begin
                with SenderControl.ScreenToClient(Sender.ClientToScreen(
                  Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos))) do
                begin
                  TWMMouse(Message).XPos := X;
                  TWMMouse(Message).YPos := Y;
                end;
              end;
          end;
				case Message.Msg of    { }
					WM_LBUTTONDOWN, WM_RBUTTONDOWN:
						Result := SenderControl.Perform(CM_DESIGNHITTEST, Message.WParam,
							 Message.LParam) = 0;
        end;
        Dispatch(Message);
      end;
    WM_PAINT:
      begin
        Result := False;
        if FSelection.Count > 1 then
          PostMessage(Form.Handle, DM_PaintSelection, 1, 0);
      end;
  end;    { case }
end;    { ProcessDesignMsg }

procedure TRAFormDesigner.DrawSelectionFrame(const OnlyRemove: Boolean);
var
  Control: TControl;
  H: HWND;
  R: TRect;
begin
  if csAcceptsControls in MouseControl.ControlStyle then
    Control := MouseControl else
    Control := MouseControl.Parent;
  R.TopLeft := Control.ScreenToClient(StartPoint);
  R.BottomRight := Control.ScreenToClient(EndPoint);
  with TCanvas.Create do
    try
      Handle := THackControl(Control).GetDeviceContext(H);
      Pen.Style := psDot;
      Pen.Mode := pmNot;
      Brush.Style := bsClear;
      with SelFrame do Rectangle(Left, Top, Right, Bottom);
      if OnlyRemove then
        SelFrame := Bounds(-10000, -10000, 0, 0)
      else
      begin
        with R do Rectangle(Left, Top, Right, Bottom);
        SelFrame := R;
      end;
    finally { wrap up }
      Handle := 0;
      Free;
    end;    { try/finally }
end;    { DrawSelectionFrame }

procedure TRAFormDesigner.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if fRAFDPalette.ButtonDown then
  begin
    CreatePaletteComponent(Message.XPos, Message.YPos);
    Exit;
  end;

  SelectionFrame := (SenderControl = Form) or
    (Message.Keys and MK_CONTROL = MK_CONTROL);
  if SelectionFrame then
  begin
    MouseControl := SenderControl;
    ClearSelection;
  end else
  begin
    if Message.Keys and MK_SHIFT = MK_SHIFT then
    	ChangeSelection(Component, True)
    else if FSelection.IndexOf(Component) = -1 then
    	ChangeSelection(Component, False);
    if (SenderControl <> Form) and
    	 (Message.Keys and MK_SHIFT = 0) and
    	 (FSelection.Count > 1) then
    	AdjustGroup(Component);
  end;
	TRAFDForm(Form).MouseCapture := True;
	StartPoint := SenderControl.ClientToScreen(
    SmallPointToPoint(TWMMouse(Message).Pos));
end;    { WMLButtonDown }

procedure TRAFormDesigner.WMMouseMove(var Message: TWMMouseMove);
begin
	if TRAFDForm(Form).MouseCapture then
	begin
		EndPoint := SenderControl.ClientToScreen(
			SmallPointToPoint(TWMMouse(Message).Pos));
    if SelectionFrame then
      DrawSelectionFrame(False)
		else
		if (Abs(EndPoint.X - StartPoint.X) >= FGridX) or
			 (Abs(EndPoint.Y - StartPoint.Y) >= FGridY) then
		begin
			if FSelection.Count > 1 then PaintSelection(False);
			MoveResizeSelection;
			PaintSelection(True);
  	  // StartPoint := EndPoint;
    	StartPoint := Point(EndPoint.X - (EndPoint.X - StartPoint.X) mod FGridX,
        EndPoint.Y - (EndPoint.Y - StartPoint.Y) mod FGridY);
		end;
	end;
end;    { WMMouseMove }

procedure TRAFormDesigner.WMLButtonUp(var Message: TWMLButtonUp);
var
  R: TRect;
begin
	TRAFDForm(Form).MouseCapture := False;
  if SelectionFrame then
  begin
    R := SelFrame;
    DrawSelectionFrame(True);
    SelectFrame(R);
  end;
	PaintSelection(True);
	FResize := False;
end;    { WMLButtonUp }

procedure TRAFormDesigner.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  SelectSenderControl;
  ComponentEditor.Free;
  ComponentEditor := GetComponentEditor(Component, Self);
  if ComponentEditor <> nil then ComponentEditor.Edit;
end;

procedure TRAFormDesigner.WMRButtonDown(var Message: TWMRButtonDown);
begin
  SelectSenderControl;
	StartPoint := SenderControl.ClientToScreen(
    SmallPointToPoint(TWMMouse(Message).Pos));
  MakeComponentMenu;
  FMenu.Popup(StartPoint.X, StartPoint.Y);
end;    { WMLButtonDown }

procedure TRAFormDesigner.WMKeyDown(var Message: TWMKeyDown);
begin
	if (FSelection.Count = 0) or
     not (Message.CharCode in
      [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_ESCAPE, VK_DELETE]) then
    Exit;
	if FSelection.Count > 1 then PaintSelection(False);
	if KeyPressed(VK_CONTROL) then
		case Message.CharCode of
			VK_UP: MoveSelection(0, -1);
			VK_DOWN: MoveSelection(0, 1);
			VK_LEFT: MoveSelection(-1, 0);
			VK_RIGHT: MoveSelection(1, 0);
		end
	else if KeyPressed(VK_SHIFT) then
		case Message.CharCode of
			VK_UP: ResizeSelection(0, -1);
			VK_DOWN: ResizeSelection(0, 1);
			VK_LEFT: ResizeSelection(-1, 0);
			VK_RIGHT: ResizeSelection(1, 0);
		end
	else
		case Message.CharCode of
			VK_UP: NextSelection(0, -1);
			VK_DOWN: NextSelection(0, 1);
			VK_LEFT: NextSelection(-1, 0);
			VK_RIGHT: NextSelection(1, 0);
			VK_ESCAPE: SelectParent;
      VK_DELETE: DeleteSelection;
		end;
	if FSelection.Count = 1 then PaintSelection(True);
end;    { WMKeyDown }

procedure TRAFormDesigner.SelectFrame(Rect: TRect);
var
  i: integer;
  R1, R2: TRect;
  Control: TControl;
begin
	{ Select controls }
  { BUGBUG:  }
  ClearSelection;
  if (Abs(Rect.Left - Rect.Right) < 5) and
     (Abs(Rect.Top - Rect.Bottom) < 5) then Exit;
  if Rect.Left > Rect.Right then SwapInt(Rect.Right, Rect.Left);
  if Rect.Top > Rect.Bottom then SwapInt(Rect.Top, Rect.Bottom);

	for i := 0 to Form.ComponentCount - 1 do    { Iterate }
	begin
		Control := GetControl(Form.Components[i]);
    R1 := Control.ClientRect;
		R1.TopLeft := Form.ScreenToClient(Control.ClientOrigin);
    R1.BottomRight := Form.ScreenToClient(Control.ClientToScreen(
      R1.BottomRight));
		if IntersectRect(R2, R1, Rect) then
		begin
			FSelection.Add(Form.Components[i]);
		end;    { for }
	end;
  PaintSelection(True);
end;    { SelectFrame }

procedure TRAFormDesigner.CreatePaletteComponent(const X, Y: Integer);
var
  P: TPoint;
  WinControl: TWinControl;
begin
	fRAFDPalette.ResetButton;
	P := Point(X, Y);
	if fRAFDPalette.ComponentClass.InheritsFrom(TControl) then
	begin
		if not (SenderControl is TWinControl) or
			(SenderControl is TContainer) or
			(SenderControl is TNameContainer) then
		begin
			WinControl := SenderControl.Parent;
			P := WinControl.ScreenToClient(SenderControl.ClientToScreen(P));
		end
		else
			WinControl := SenderControl as TWinControl;
	end
	else
	begin
		WinControl := Form;
    P := WinControl.ScreenToClient(SenderControl.ClientToScreen(P));
	end;
  P := AlignToGrid(P);
  SelectComponent(CreateComponent(fRAFDPalette.ComponentClass, WinControl,
    P.X, P.Y, 0, 0));
end;    { CreatePaletteComponent }

procedure TRAFormDesigner.BringContainers;
var
  i: integer;
begin
  for i := 0 to FContainers.Count - 1 do
    TControl(FContainers[i]).BringToFront;
end;    { BringContainers }


{ popup menu }

function TRAFormDesigner.NewItem(Caption: string; const Tag: Integer)
  : TMenuItem;
begin
  Result := Menus.NewItem(Caption, 0, False, True, MenuClick, 0, '');
  Result.Tag := Tag;
end;    { NewItem }

procedure TRAFormDesigner.MakeMenu;
begin
  FMenu.Items.Add(NewItem(ResStr(deBringToFront, 'Bring To &Front'), 1));
  FMenu.Items.Add(NewItem(ResStr(deSendToBack, 'Send To &Back'), 2));
end;    { MakeMenu }

procedure TRAFormDesigner.MakeComponentMenu;
var
  Verb: integer;
  i: integer;
begin
  ComponentEditor.Free;
  while FMenu.Items[0].Tag > 1 do
    FMenu.Items.Delete(0);
  ComponentEditor := GetComponentEditor(Component, Self);
  if not Assigned(ComponentEditor) then Exit;
  Verb := ComponentEditor.GetVerbCount;
  if Verb > 0 then
  begin
    FMenu.Items.Insert(0, NewLine);
    FMenu.Items[0].Tag := verbTag - 1;
    for i := 0 to Verb - 1 do    { Iterate }
    begin
      FMenu.Items.Insert(i, NewItem(ComponentEditor.GetVerb(i), i + verbTag));
    end;    { for }
  end;
end;    { PopulateMenu }

procedure TRAFormDesigner.MenuClick(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of    { }
    1:
      if not (SenderControl is TContainer) then
      begin
        PaintSelection(False);
        SenderControl.BringToFront;
        BringContainers;
        PaintSelection(True);
      end;
    2:
      if not (SenderControl is TContainer) then
        SenderControl.SendToBack;
    verbTag .. verbTag + 1000:
      ComponentEditor.ExecuteVerb((Sender as TMenuItem).Tag - verbTag);
  end;    { case }
end;    { MenuClick }


{ Clipboard }

procedure TRAFormDesigner.ComponentRead(Component: TComponent);
begin
  ODS('ComponentRead');
  FSelection.Add(Component);
end;

procedure TRAFormDesigner.ReaderSetName(Reader: TReader; Component: TComponent;
  var Name: string);
begin
  ODS('TRAFormDesigner.ReaderSetName');
  if (Reader.Root = Form) and (Form.FindComponent(Name) <> nil) then
    Name := UniqueName(Name);
end;

procedure TRAFormDesigner.CopySelection;
var
  S: TMemoryStream;
  W: TWriter;
  I: Integer;
begin
  if FSelection.Count = 0 then Exit;
  AdjustGroup(FSelection[0]);
  S := TMemoryStream.Create;
  try
    W := TWriter.Create(S, 1024);
    try
      W.Root := Form;
      for I := 0 to FSelection.Count - 1 do
      begin
        W.WriteSignature;
        W.WriteComponent(TComponent(FSelection[I]));
      end;
      W.WriteListEnd;
    finally
      W.Free;
    end;
    CopyStreamToClipboard(S);
  finally
    S.Free;
  end;
end;

procedure TRAFormDesigner.PasteSelection;
var
  S: TStream;
  R: TReader;
  AParent: TComponent;
begin
  if FSelection.Count = 1 then
    AParent := FSelection[0] as TComponent
  else if FSelection.Count = 0 then
    AParent := Form
  else Exit;
  ClearSelection;
  S := GetClipboardStream;
  try
    R := TReader.Create(S, 1024);
    try
      R.OnSetName := ReaderSetName;
      R.ReadComponents(Form, AParent, ComponentRead);
    finally
      R.Free;
    end;
  finally
    S.Free;
  end;
  SelectionChanged;
end;


initialization
  LoadComponentBitmapProc := LoadComponentBitmap;
  RegisterComponentEditor(TComponent, TDefaultEditor);
end.
