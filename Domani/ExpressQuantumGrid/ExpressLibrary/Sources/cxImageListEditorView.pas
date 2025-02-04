
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library classes                   }
{                                                                    }
{           Copyright (c) 2000-2007 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxImageListEditorView;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, ComCtrls, CommCtrl, Menus, ImgList, ToolWin, cxGraphics,
  cxImageListEditor;

type
  TcxImageListEditorForm = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    gbSelectedImage: TGroupBox;
    pbPreview: TPaintBox;
    lbTransparentColor: TLabel;
    cbTransparentColor: TComboBox;
    gbImages: TGroupBox;
    lvImages: TListView;
    pnlToolBarSubstrate: TPanel;
    tbCommands: TToolBar;
    tbbAdd: TToolButton;
    tbbDelete: TToolButton;
    tbbClear: TToolButton;
    tbbExport: TToolButton;
    tbbReplace: TToolButton;
    tbbImport: TToolButton;
    pmImageLists: TPopupMenu;
    pmCommands: TPopupMenu;
    miAdd: TMenuItem;
    miReplace: TMenuItem;
    miDelete: TMenuItem;
    miClear: TMenuItem;
    miExport: TMenuItem;
    miImport: TMenuItem;
    procedure tbbImportClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure cbTransparentColorChange(Sender: TObject);
    procedure cbTransparentColorExit(Sender: TObject);

    procedure lvImagesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvImagesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lvImagesEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure lvImagesStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure lvImagesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure pbPreviewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbPreviewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pbPreviewPaint(Sender: TObject);
  private
    FImageListEditor: TcxImageListEditor;
    FImportList: TStrings;
    FDragImageIndex: Integer;

    procedure AddColor(const AColor: string);
    procedure DrawFocusedItem(ACanvas: TCanvas; ARect: TRect);
    function GetColorFromCursorPos(X, Y: Integer): TColor;
    function GetFocusedImageIndex: Integer;
    procedure SetFocusedImageIndex(AValue: Integer);

    procedure ImportImageList(Sender: TObject);
    procedure PopulateImportItems;

    procedure DataChanged(Sender: TObject);

    procedure UpdateControls;
    procedure UpdateTransparentColor(AColor: TColor); overload;
    procedure UpdateTransparentColor(X, Y: Integer); overload;
    procedure UpdateTransparentColorIndicator(AColor: TColor);

    property FocusedImageIndex: Integer read GetFocusedImageIndex write SetFocusedImageIndex;
  public
    constructor Create(AImageListEditor: TcxImageListEditor); reintroduce;

    function GetVisualDataControl: TListView;
    procedure SetImportList(AValue: TStrings);
  end;

implementation

{$R *.dfm}

uses
{$IFDEF CLR}
  Types,
{$ENDIF}
  Math, cxGeometry, cxControls, dxOffice11;

{ TcxImageListEditorForm }

constructor TcxImageListEditorForm.Create(AImageListEditor: TcxImageListEditor);
begin
  inherited Create(nil);
  FImageListEditor := AImageListEditor;
  FImageListEditor.OnChange := DataChanged;

{$IFDEF DELPHI9}
  PopupMode := pmAuto;
{$ENDIF}
end;

function TcxImageListEditorForm.GetVisualDataControl: TListView;
begin
  Result := lvImages;
end;

procedure TcxImageListEditorForm.SetImportList(AValue: TStrings);
begin
  FImportList := AValue;
  PopulateImportItems;
end;

procedure TcxImageListEditorForm.tbbImportClick(Sender: TObject);
begin
  tbbImport.CheckMenuDropdown;
end;

procedure TcxImageListEditorForm.FormCreate(Sender: TObject);
begin
  lvImages.OnChange := lvImagesChange;

  pbPreview.Cursor := crcxColorPicker;
  GetColorValues(AddColor);
  FDragImageIndex := -1;

  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
end;

procedure TcxImageListEditorForm.FormDestroy(Sender: TObject);
begin
  lvImages.OnChange := nil;
end;

procedure TcxImageListEditorForm.cbTransparentColorChange(Sender: TObject);
begin
  if cbTransparentColor.Items.IndexOf(cbTransparentColor.Text) <> -1 then
    UpdateTransparentColor(StringToColor(cbTransparentColor.Text));
end;

procedure TcxImageListEditorForm.cbTransparentColorExit(Sender: TObject);
begin
  UpdateTransparentColor(StringToColor(cbTransparentColor.Text));
end;

procedure TcxImageListEditorForm.lvImagesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  UpdateControls;
end;

procedure TcxImageListEditorForm.lvImagesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := lvImages.GetItemAt(X, Y) <> nil;
end;

procedure TcxImageListEditorForm.lvImagesEndDrag(Sender, Target: TObject; X,
  Y: Integer);
var
  ATargetItem: TListItem;
begin
  FImageListEditor.EndUpdate;
  ATargetItem := lvImages.GetItemAt(X, Y);
  if ATargetItem <> nil then
    FImageListEditor.MoveImage(FDragImageIndex, ATargetItem.ImageIndex)
  else
    FocusedImageIndex := FDragImageIndex;
  FDragImageIndex := -1;
end;

procedure TcxImageListEditorForm.lvImagesStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FImageListEditor.BeginUpdate;
  FDragImageIndex := FImageListEditor.FocusedImageIndex;
end;

procedure TcxImageListEditorForm.lvImagesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    FImageListEditor.DeleteSelectedImages;
end;

procedure TcxImageListEditorForm.pbPreviewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  UpdateTransparentColor(X, Y);
end;

procedure TcxImageListEditorForm.pbPreviewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    UpdateTransparentColor(X, Y);
end;

procedure TcxImageListEditorForm.pbPreviewPaint(Sender: TObject);
var
  ARect: TRect;
begin
  ARect := pbPreview.ClientRect;
  FrameRectByColor(pbPreview.Canvas.Handle, ARect, clNavy);
  InflateRect(ARect, -1, -1);
  cxDrawHatch(pbPreview.Canvas.Handle, ARect, $BFBFBF, clWhite, 8);
  DrawFocusedItem(pbPreview.Canvas, ARect);
end;

procedure TcxImageListEditorForm.AddColor(const AColor: string);
begin
  cbTransparentColor.Items.Add(AColor);
end;

procedure TcxImageListEditorForm.DrawFocusedItem(ACanvas: TCanvas; ARect: TRect);
begin
  if FImageListEditor.IsAnyImageSelected then
    FImageListEditor.ImagesInfo[FocusedImageIndex].Draw(FImageListEditor.OriginalImageList, ACanvas, ARect);
end;

function TcxImageListEditorForm.GetColorFromCursorPos(X, Y: Integer): TColor;
begin
  if cxRectPtIn(Rect(0, 0, pbPreview.Width, pbPreview.Height), X, Y) then
  begin
    X := X * FImageListEditor.ImageWidth div pbPreview.Width;
    Y := Y * FImageListEditor.ImageHeight div pbPreview.Height;
    Result := FImageListEditor.ImagesInfo[FocusedImageIndex].ColorFromPoint(X, Y);
  end
  else
    Result := FImageListEditor.ImagesInfo[FocusedImageIndex].TransparentColor;
end;

function TcxImageListEditorForm.GetFocusedImageIndex: Integer;
begin
  Result := FImageListEditor.FocusedImageIndex;
end;

procedure TcxImageListEditorForm.SetFocusedImageIndex(AValue: Integer);
begin
  FImageListEditor.FocusedImageIndex := AValue;
end;

procedure TcxImageListEditorForm.ImportImageList(Sender: TObject);
begin
  FImageListEditor.ImportImages(FImportList.Objects[TMenuItem(Sender).Tag] as TCustomImageList);
end;

procedure TcxImageListEditorForm.PopulateImportItems;

  procedure PopulateItem(AParentItem: TMenuItem);
  var
    AMenuItem: TMenuItem;
    I: Integer;
  begin
    for I := 0 to FImportList.Count - 1 do
    begin
      AMenuItem := TMenuItem.Create(Self);
      AMenuItem.OnClick := ImportImageList;
      AMenuItem.Caption := FImportList[I];
      AMenuItem.Tag := I;
      AParentItem.Add(AMenuItem);
    end;
  end;

begin
  if FImportList.Count = 0 then
  begin
    tbbImport.Enabled := False;
    miImport.Enabled := False;
  end
  else
  begin
    PopulateItem(pmImageLists.Items);
    PopulateItem(miImport);
  end;
end;

procedure TcxImageListEditorForm.DataChanged(Sender: TObject);
begin
  UpdateControls;
end;

procedure TcxImageListEditorForm.UpdateControls;
var
  ANewImageSelected: Boolean;
begin
  if FImageListEditor.IsUpdateLocked then
    Exit;

  ANewImageSelected := FImageListEditor.IsAnyImageSelected and FImageListEditor.ImagesInfo[FocusedImageIndex].New;

  pbPreview.Enabled := ANewImageSelected;
  pbPreview.Invalidate;

  cbTransparentColor.Enabled := ANewImageSelected;
  lbTransparentColor.Enabled := cbTransparentColor.Enabled;

  if ANewImageSelected then
    UpdateTransparentColorIndicator(FImageListEditor.ImagesInfo[FocusedImageIndex].TransparentColor)
  else
    UpdateTransparentColorIndicator(clNone);

  FImageListEditor.UpdateActions;
end;

procedure TcxImageListEditorForm.UpdateTransparentColor(AColor: TColor);
begin
  FImageListEditor.UpdateTransparentColor(AColor);
end;

procedure TcxImageListEditorForm.UpdateTransparentColor(X, Y: Integer);
begin
  UpdateTransparentColor(GetColorFromCursorPos(X, Y));
end;

procedure TcxImageListEditorForm.UpdateTransparentColorIndicator(AColor: TColor);
begin
  cbTransparentColor.Text := ColorToString(AColor);
end;

end.
