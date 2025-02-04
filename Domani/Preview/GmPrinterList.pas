{******************************************************************************}
{                                                                              }
{                       GmPrinterList.pas v2.61 Pro                            }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmPrinterList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, GmPreview, GmConst, GmTypes;

  {$I GMPS.INC}

type
  TGmPrinterList = class(TGmCustomComboBox)
  private
    { Private declarations }
    FPrinterBitmap: TBitmap;
    FPreview: TGmPreview;
    procedure SetPreview(APreview: TGmPreview);
  protected
    procedure Change; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure Loaded; override;
    // update messages...
    procedure PrinterChanged(var Message: TMessage); message GM_PRINTER_CHANGED;
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; {$IFDEF  D6+} override; {$ENDIF}
    procedure RefreshList;
  published
    { Published declarations }
    {properties available from Delphi 4...}
    {$IFDEF  D4+}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Color;
    property DragCursor;
    {$IFDEF  D4+}
    property DragKind;
    property DragMode;
    {$ENDIF}
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Preview: TGmPreview read FPreview write SetPreview;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnChange;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

implementation

{$R PrintListRes.RES}

constructor TGmPrinterList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csOwnerDrawFixed;
  FPrinterBitmap := TBitmap.Create;
  FPrinterBitmap.Transparent := True;
  FPrinterBitmap.LoadFromResourceName(HInstance, 'Printer');
end;

destructor TGmPrinterList.Destroy;
begin
  if Assigned(FPreview) then FPreview.RemoveAssociatedComponent(Self);
  FPrinterBitmap.Free;
  inherited Destroy;
end;

procedure TGmPrinterList.Clear;
var
  ICount: integer;
begin
  for ICount := 0 to Items.Count-1 do
    Items.Objects[ICount].Free;
  inherited Clear;
end;

procedure TGmPrinterList.Loaded;
begin
  inherited Loaded;
  if Assigned(FPreview) then
  begin
    RefreshList;
    ItemIndex := FPreview.GmPrinter.PrinterIndex;
  end;
end;

procedure TGmPrinterList.PrinterChanged(var Message: TMessage);
begin
  if ItemIndex <> FPreview.GmPrinter.PrinterIndex then
    ItemIndex := FPreview.GmPrinter.PrinterIndex;
end;

procedure TGmPrinterList.Change;
begin
  if Assigned(FPreview) then
  begin
   FPreview.GmPrinter.PrinterIndex := ItemIndex;
  end;
  inherited Change;
end;

procedure TGmPrinterList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPreview) then
    FPreview := nil;
end;

procedure TGmPrinterList.RefreshList;
begin
  if Assigned(FPreview) then
    Items.Assign(FPreview.GmPrinter.Printers);
end;

procedure TGmPrinterList.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  ItemTop: integer;
begin
  ItemTop := (ItemHeight-16) div 2;
  with Canvas do
  begin
    FillRect(Rect);
    Draw(3,Rect.Top+ItemTop,FPrinterBitmap);
    TextOut(22, Rect.Top+ItemTop, Items[Index]);
  end;
end;

procedure TGmPrinterList.SetPreview(APreview: TGmPreview);
begin
  if Assigned(FPreview) then
    FPreview.RemoveAssociatedComponent(Self);
  FPreview := APreview;
  if Assigned(FPreview) then
    FPreview.AddAssociatedComponent(Self);
end;

end.

