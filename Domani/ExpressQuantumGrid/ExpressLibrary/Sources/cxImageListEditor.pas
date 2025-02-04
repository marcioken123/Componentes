
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

unit cxImageListEditor;

{$I cxVer.inc}

interface

uses
{$IFNDEF CLR}
  dxGDIPlusAPI, dxGDIPlusClasses,
{$ENDIF}
  Windows, SysUtils, Classes, ExtDlgs, ImgList, ComCtrls, Controls, Graphics, Forms, Dialogs,
  ActnList, cxGeometry, cxGraphics;

type
  TcxImageInfo = class(TPersistent)
  private
    FGraphic: TGraphic;
    FNew: Boolean;
    FTransparentColor: TColor;

    procedure SetGraphic(AValue: TGraphic);
  protected
    function AddMaskedImage(AImageList: TcxImageList; ANew: Boolean; AColor: TColor): Integer; virtual;
    function CreateImage(ASize: TSize): TGraphic; virtual; abstract;
    procedure UpdateMask(AIndex: Integer; AColor: TColor); virtual;
  public
    constructor Create(ASize: TSize); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ColorFromPoint(X, Y: Integer): TColor; virtual;
    procedure Draw(AOriginalImageList: TcxImageList; ACanvas: TCanvas; ARect: TRect);
    procedure Synchronize(AImageList: TcxImageList);

    property Graphic: TGraphic read FGraphic write SetGraphic;
    property New: Boolean read FNew write FNew;
    property TransparentColor: TColor read FTransparentColor write FTransparentColor;
  end;

  TcxImageInfoClass = class of TcxImageInfo;

  TcxBitmapInfo = class(TcxImageInfo)
  private
    FMask: TBitmap;

    function GetImage: TBitmap;
    procedure SetImage(AValue: TBitmap);
    procedure SetMask(AValue: TBitmap);
  protected
    function AddMaskedImage(AImageList: TcxImageList; ANew: Boolean; AColor: TColor): Integer; override;
    function CreateImage(ASize: TSize): TGraphic; override;
    procedure UpdateMask(AIndex: Integer; AColor: TColor); override;
  public
    constructor Create(ASize: TSize); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ColorFromPoint(X, Y: Integer): TColor; override;

    property Image: TBitmap read GetImage write SetImage;
    property Mask: TBitmap read FMask write SetMask;
  end;

  TcxIconInfo = class(TcxImageInfo)
  private
    function GetIcon: TIcon;
    procedure SetIcon(AValue: TIcon);
  protected
    function AddMaskedImage(AImageList: TcxImageList; ANew: Boolean; AColor: TColor): Integer; override;
    function CreateImage(ASize: TSize): TGraphic; override;
  public
    procedure Assign(Source: TPersistent); override;

    property Icon: TIcon read GetIcon write SetIcon;
  end;

  TcxImageListEditorAddMode = (amAdd, amInsert, amReplace);

  TcxImageListEditor = class(TDataModule)
    actlCommands: TActionList;
    actAdd: TAction;
    actInsert: TAction;
    actReplace: TAction;
    actDelete: TAction;
    actClear: TAction;
    actExport: TAction;
    imglSmall: TcxImageList;
    actApply: TAction;
    actOk: TAction;
    opdOpen: TOpenPictureDialog;
    spdSave: TSavePictureDialog;

    procedure actAddExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actReplaceExecute(Sender: TObject);
  private
    FChanged: Boolean;
    FImageListModified: Boolean;
    FDataControl: TListView;
    FEditorForm: TForm;
    FImageList: TcxImageList;
    FImportList: TStrings;
    FOnChange: TNotifyEvent;
    FOriginalImageList: TcxImageList;
    FSplitBitmaps: TModalResult;
    FUpdateCount: Integer;

    procedure AddImage(AImage: TGraphic; var AInsertedImageIndex: Integer; ANew: Boolean = False; AColor: TColor = clNone);
    procedure Change;
    procedure ClearSelection;
    procedure DeleteDataItem(Sender: TObject; Item: TListItem);
    procedure DeleteImage(AIndex: Integer);
    function GetImagesCount: Integer;
    function GetDataItems: TListItems;
    function GetDefaultTransparentColor(AImage: TBitmap): TColor;
    function GetFocusedImageIndex: Integer;
    function GetImageHeight: Integer;
    function GetImageInfoClass(AImage: TGraphic): TcxImageInfoClass;
    function GetImagesInfo(Index: Integer): TcxImageInfo;
    function GetImageWidth: Integer;
    procedure ImageListChanged;
    procedure SelectDataItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure SetFocusedImageIndex(AValue: Integer);
    procedure SetImageList(AValue: TcxImageList);
    procedure SetImagesInfo(Index: Integer; AValue: TcxImageInfo);
    procedure SetImportList(AValue: TStrings);
    procedure UpdateDataItems(AUpdatedImageList: TcxImageList);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Edit(AImageList: TcxImagelist): Boolean;

    procedure AddImages(AAddMode: TcxImageListEditorAddMode); overload;
    procedure AddImages(AFiles: TStrings; AAddMode: TcxImageListEditorAddMode); overload;
    procedure ClearImages;
    procedure DeleteSelectedImages;
    procedure ExportImages(const AFileName: string);
    function InternalAddImage(AGraphic: TGraphic; AFileName: string;
      var AInsertedItemIndex: Integer; AMultiSelect: Boolean): Integer;
    procedure ImportImages(AImageList: TCustomImageList);
    procedure MoveImage(ASourceImageIndex, ADestImageIndex: Integer);

    function IsAnyImageSelected: Boolean;

    procedure BeginUpdate;
    procedure EndUpdate;
    function IsUpdateLocked: Boolean;

    procedure ApplyChanges;
    function IsChanged: Boolean;
    procedure UpdateActions;
    procedure UpdateTransparentColor(AColor: TColor);
    procedure SynchronizeData(AImageList: TCustomImageList);

    property DataControl: TListView read FDataControl;
    property DataItems: TListItems read GetDataItems;
    property FocusedImageIndex: Integer read GetFocusedImageIndex write SetFocusedImageIndex;
    property ImageHeight: Integer read GetImageHeight;
    property ImageList: TcxImageList read FImageList write SetImageList;
    property ImageListModified: Boolean read FImageListModified;
    property ImagesCount: Integer read GetImagesCount;
    property ImagesInfo[Index: Integer]: TcxImageInfo read GetImagesInfo write SetImagesInfo;
    property ImageWidth: Integer read GetImageWidth;
    property ImportList: TStrings read FImportList write SetImportList;
    property OriginalImageList: TcxImageList read FOriginalImageList;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

function cxEditImageList(AImageList: TcxImageList; AImportList: TStrings): Boolean;

implementation

{$R *.dfm}

uses
{$IFDEF CLR}
  Types, System.IO,
{$ENDIF}
  Math, cxImageListEditorView;

function cxEditImageList(AImageList: TcxImageList; AImportList: TStrings): Boolean;
var
  AImageListEditor: TcxImageListEditor;
begin
  Result := False;
  if AImageList = nil then
    Exit;
  AImageListEditor := TcxImageListEditor.Create(nil);
  try
    AImageListEditor.ImportList := AImportList;
    Result := AImageListEditor.Edit(AImageList);
  finally
    AImageListEditor.Free;
  end;
end;

function IsIndexValid(AIndex, ACount: Integer): Boolean;
begin
  Result := (AIndex >= 0) and (AIndex < ACount);
end;

function IsBitmapAlphaUsed(AImage: TBitmap): Boolean;
var
  ATempBitmap: TcxBitmap;
begin
  ATempBitmap := TcxBitmap.Create;
  ATempBitmap.Assign(AImage);
  try
    Result := ATempBitmap.IsAlphaUsed;
  finally
    ATempBitmap.Free;
  end;
end;

{ TcxImageInfo }

constructor TcxImageInfo.Create(ASize: TSize);
begin
  inherited Create;
  FGraphic := CreateImage(ASize);
end;

destructor TcxImageInfo.Destroy;
begin
  Graphic.Free;
  inherited Destroy;
end;

procedure TcxImageInfo.Assign(Source: TPersistent);
begin
  if Source is TcxImageInfo then
  begin
    New := TcxImageInfo(Source).New;
    TransparentColor := TcxImageInfo(Source).TransparentColor;
  end
  else
    inherited Assign(Source);
end;

function TcxImageInfo.ColorFromPoint(X, Y: Integer): TColor;
begin
  Result := clNone;
end;

procedure TcxImageInfo.Draw(AOriginalImageList: TcxImageList; ACanvas: TCanvas; ARect: TRect);
var
  AImageList: TcxImageList;
begin
  AImageList := TcxImageList.Create(nil);
  try
    AImageList.Assign(AOriginalImageList);
    AImageList.Clear;
    AddMaskedImage(AImageList, New, TransparentColor);
    AImageList.Draw(ACanvas, ARect, 0);
  finally
    AImageList.Free;
  end;
end;

procedure TcxImageInfo.Synchronize(AImageList: TcxImageList);
begin
  AddMaskedImage(AImageList, New, TransparentColor);
end;

function TcxImageInfo.AddMaskedImage(AImageList: TcxImageList; ANew: Boolean; AColor: TColor): Integer;
begin
  New := ANew;
  TransparentColor := AColor;
  Result := -1;
end;

procedure TcxImageInfo.UpdateMask(AIndex: Integer; AColor: TColor);
begin
  // do nothing
end;

procedure TcxImageInfo.SetGraphic(AValue: TGraphic);
begin
  Graphic.Assign(AValue);
end;

 { TcxBitmapInfo }

constructor TcxBitmapInfo.Create(ASize: TSize);
begin
  inherited Create(ASize);
  FMask := cxCreateBitmap(ASize, pf1bit);
  FMask.Canvas.Brush.Color := clBlack;
  FMask.Canvas.FillRect(cxRect(0, 0, FMask.Width, FMask.Height));
  TransparentColor := clNone;
end;

destructor TcxBitmapInfo.Destroy;
begin
  Mask.Free;
  inherited Destroy;
end;

procedure TcxBitmapInfo.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxBitmapInfo then
  begin
    Image := TcxBitmapInfo(Source).Image;
    Mask := TcxBitmapInfo(Source).Mask;
  end;
end;

function TcxBitmapInfo.ColorFromPoint(X, Y: Integer): TColor;
begin
  Result := Image.Canvas.Pixels[X, Y];
end;

function TcxBitmapInfo.AddMaskedImage(AImageList: TcxImageList; ANew: Boolean; AColor: TColor): Integer;
var
  ATempImage: TBitmap;
begin
  inherited AddMaskedImage(AImageList, ANew, AColor);
  ATempImage := cxCreateBitmap(AImageList.Width, AImageList.Height, pf32bit);
  try
    ATempImage.Assign(Image);
    if New then
      Result := AImageList.AddMasked(ATempImage, TransparentColor)
    else
      Result := AImageList.Add(ATempImage, Mask);
    AImageList.GetMask(Result, Mask);
  finally
    ATempImage.Free;
  end;
end;

function TcxBitmapInfo.CreateImage(ASize: TSize): TGraphic;
begin
  Result := cxCreateBitmap(ASize, pf32bit);
end;

procedure TcxBitmapInfo.UpdateMask(AIndex: Integer; AColor: TColor);
begin
  TransparentColor := AColor;
end;

function TcxBitmapInfo.GetImage: TBitmap;
begin
  Result := TBitmap(Graphic);
end;

procedure TcxBitmapInfo.SetImage(AValue: TBitmap);
begin
  Image.Assign(AValue);
end;

procedure TcxBitmapInfo.SetMask(AValue: TBitmap);
begin
  Mask.Assign(AValue);
end;

 { TcxIconInfo }

procedure TcxIconInfo.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxIconInfo then
    Icon := TcxIconInfo(Source).Icon;
end;

function TcxIconInfo.AddMaskedImage(AImageList: TcxImageList; ANew: Boolean; AColor: TColor): Integer;
var
  ATempIcon: TIcon;
begin
  inherited AddMaskedImage(AImageList, ANew, AColor);
  ATempIcon := TIcon.Create;
  try
    ATempIcon.Assign(Icon);
    Result := AImageList.AddIcon(ATempIcon);
  finally
    ATempIcon.Free;
  end;
end;

function TcxIconInfo.CreateImage(ASize: TSize): TGraphic;
begin
  Result := TIcon.Create;
end;

function TcxIconInfo.GetIcon: TIcon;
begin
  Result := TIcon(Graphic);
end;

procedure TcxIconInfo.SetIcon(AValue: TIcon);
begin
  Icon.Assign(AValue);
end;

{ TcxImageFileFormats }

type
  TcxImageFileFormat = record
    Name: string;
    Ext: string;
    GraphicClass: TGraphicClass;
  end;

  TcxImageFileFormatList = array of TcxImageFileFormat;

  TcxImageFileFormats = class
  private
    FList: TcxImageFileFormatList;

    function Count: Integer;
    function GetItem(Index: Integer): TcxImageFileFormat;

    property Items[Index: Integer]: TcxImageFileFormat read GetItem;
  public
    procedure Register(const AName, AExt: string; AGraphicClass: TGraphicClass);
//TODO:    procedure UnRegister(AGraphicClass: TGraphicClass);
    function GetGraphicClass(const AFileName: string): TGraphicClass;
    function GetFilter: string;
  end;

procedure TcxImageFileFormats.Register(const AName, AExt: string; AGraphicClass: TGraphicClass);
begin
  SetLength(FList, Count + 1);
  FList[Count - 1].Name := AName;
  FList[Count - 1].Ext := AExt;
  FList[Count - 1].GraphicClass := AGraphicClass;
end;

function TcxImageFileFormats.GetGraphicClass(const AFileName: string): TGraphicClass;
var
  I: Integer;
  AExt: string;
begin
  Result := nil;
  AExt := ExtractFileExt(AFileName);
  for I := 0 to Count - 1 do
    if AExt = Items[I].Ext then
      Result := Items[I].GraphicClass;
end;

function TcxImageFileFormats.GetFilter: string;
var
  I: Integer;
  AAllExtentions, AAllImages: string;
begin
  AAllExtentions := '';
  AAllImages := '';
  for I := 0 to Count - 1 do
  begin
    if AAllExtentions = '' then
      AAllExtentions := '*' + Items[I].Ext
    else
      AAllExtentions := AAllExtentions + ';*' + Items[I].Ext;
    if AAllImages = '' then
      AAllImages := Items[I].Name + '|*' + Items[I].Ext
    else
      AAllImages := AAllImages + '|' + Items[I].Name + '|*' + Items[I].Ext;
  end;
  Result := 'All supported image types|' + AAllExtentions + '|' + AAllImages;
end;

function TcxImageFileFormats.Count: Integer;
begin
  Result := Length(FList);
end;

function TcxImageFileFormats.GetItem(Index: Integer): TcxImageFileFormat;
begin
  Result := FList[Index];
end;

var
  FImageFileFormats: TcxImageFileFormats;

function cxImageFileFormats: TcxImageFileFormats;
begin
  if FImageFileFormats = nil then
    FImageFileFormats := TcxImageFileFormats.Create;
  Result := FImageFileFormats;
end;

{ TcxImageListEditor }

constructor TcxImageListEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImageList := TcxImageList.Create(nil);
  FEditorForm := TcxImageListEditorForm.Create(Self);
  FImportList := TStringList.Create;

  FDataControl := TcxImageListEditorForm(FEditorForm).GetVisualDataControl;
  FDataControl.SmallImages := ImageList;
  FDataControl.LargeImages := ImageList;
  FDataControl.OnDeletion := DeleteDataItem;
  FDataControl.OnSelectItem := SelectDataItem;
end;

destructor TcxImageListEditor.Destroy;
begin
  ClearImages;
  FDataControl.OnSelectItem := nil;
  FDataControl.OnDeletion := nil;
  FDataControl := nil;
  FreeAndNil(FImportList);
  FreeAndNil(FEditorForm);
  FreeAndNil(FImageList);
  inherited;
end;

function TcxImageListEditor.Edit(AImageList: TcxImagelist): Boolean;
var
  ACaption: string;
begin
  ImageList := AImageList;
  ACaption := AImageList.Name;
  if AImageList.Owner <> nil then
    ACaption := AImageList.Owner.Name + '.' + ACaption;
  FEditorForm.Caption := ACaption;
  FEditorForm.ShowModal;
  Result := FImageListModified;
end;

procedure TcxImageListEditor.AddImages(AAddMode: TcxImageListEditorAddMode);
begin
  opdOpen.Filter := cxImageFileFormats.GetFilter;
  if opdOpen.Execute then
    AddImages(opdOpen.Files, AAddMode);
end;

procedure TcxImageListEditor.AddImages(AFiles: TStrings; AAddMode: TcxImageListEditorAddMode);

  function CreateGraphicFromFile(const AFileName: string): TGraphic;
  var
    AGraphic: TGraphic;
  begin
    AGraphic := cxImageFileFormats.GetGraphicClass(AFileName).Create;
  {$IFNDEF CLR}
    if AGraphic is TdxPNGImage then // TODO:
    begin
      AGraphic.LoadFromFile(AFileName);
      Result := TdxPNGImage(AGraphic).GetAsBitmap;
      AGraphic.Free;
    end
    else
  {$ENDIF}
    begin
      AGraphic.LoadFromFile(AFileName);
      Result := AGraphic;
    end;
  end;

var
  AGraphic: TGraphic;
  I, AInsertedItemIndex: Integer;
begin
  case AAddMode of
    amAdd:
      AInsertedItemIndex := ImagesCount;
    amInsert:
      AInsertedItemIndex := Max(0, FocusedImageIndex);
  else {amReplace}
    AInsertedItemIndex := FocusedImageIndex;
    DeleteImage(AInsertedItemIndex);
  end;
  
  FSplitBitmaps := mrNone;
  ClearSelection;
  Application.ProcessMessages;
  for I := 0 to AFiles.Count - 1 do
  begin
    AGraphic := CreateGraphicFromFile(AFiles[I]);
    try
      InternalAddImage(AGraphic, AFiles[I], AInsertedItemIndex, AFiles.Count > 1);
    finally
      AGraphic.Free;
    end;
  end;
  FocusedImageIndex := AInsertedItemIndex - 1;
end;

procedure TcxImageListEditor.ClearImages;
begin
  DataItems.Clear;
  UpdateDataItems(ImageList);
end;

procedure TcxImageListEditor.DeleteSelectedImages;
var
  ASelectedIndex: Integer;
  I: Integer;
begin
  if not IsAnyImageSelected then
    Exit;
  ASelectedIndex := FocusedImageIndex;
  for I := ImagesCount - 1 downto 0 do
    if DataItems[I].Selected then
      DeleteImage(I);
  FocusedImageIndex := Min(ASelectedIndex, ImagesCount - 1);
end;

procedure TcxImageListEditor.ExportImages(const AFileName: string);

  procedure SelectAllImages;
  var
    I: Integer;
  begin
    for I := 0 to ImagesCount - 1 do
      DataItems[I].Selected := True;
  end;

var
  AImageIndex: Integer;
  ASelectedItem: TListItem;
  ATempImageList: TcxImageList;
  AImage: TBitmap;
begin
  AImage := TBitmap.Create;
  try
    ASelectedItem := FDataControl.Selected;
    if not IsAnyImageSelected then
      SelectAllImages;
    ATempImageList := TcxImageList.CreateSize(ImageList.Width, ImageList.Height);
    try
      for AImageIndex := 0 to ImageList.Count - 1 do
        if DataItems[AImageIndex].Selected then
          ATempImageList.CopyImages(ImageList, AImageIndex, AImageIndex);
      ATempImageList.GetImage(-1, AImage);
      AImage.SaveToFile(AFileName);
    finally
      ATempImageList.Free;
    end;
    FDataControl.Selected := ASelectedItem;
  finally
    AImage.Free;
  end;
end;

procedure TcxImageListEditor.ImportImages(AImageList: TCustomImageList);
begin
  if AImageList.Count <> 0 then
  begin
    ImageList.CopyImages(AImageList);
    SynchronizeData(AImageList);
    FChanged := True;
    FocusedImageIndex := ImagesCount - 1;
  end;
  Change;
end;

function TcxImageListEditor.InternalAddImage(AGraphic: TGraphic; AFileName: string;
  var AInsertedItemIndex: Integer; AMultiSelect: Boolean): Integer;

  function GetUserPermissionForSplit(AFileName: string; AMultiSelect: Boolean): Boolean;
  const
    scxBitmapSeparateQuery = 'The bitmap in the file %s is too large. Do you want to separate it into smaller bitmaps?';
  var
    APossibleAnswers: TMsgDlgButtons;
  begin
    APossibleAnswers := [mbYes, mbNo];
    if AMultiSelect then
        APossibleAnswers := APossibleAnswers + [mbNoToAll, mbYesToAll];
    FSplitBitmaps := MessageDlg(Format(scxBitmapSeparateQuery, [AFileName]), mtConfirmation, APossibleAnswers, 0);
    Result := FSplitBitmaps in [mrYes, mrYesToAll, mrCancel];
  end;

var
  AColCount, ARowCount, AColIndex, ARowIndex: Integer;
  ASourceImageSize: TSize;
  ASplitX, ASplitY: Boolean;
  AImage, ADestBitmap: TBitmap;
begin
  Result := -1;
  if AGraphic is TBitmap then
  begin
    AImage := TBitmap(AGraphic);
    ASplitX := (AImage.Width >= ImageWidth) and ((AImage.Width mod ImageWidth) = 0);
    ASplitY := (AImage.Height >= ImageHeight) and ((AImage.Height mod ImageHeight) = 0);

    if ((AImage.Width = ImageWidth) and (AImage.Height = ImageHeight)) or
      (ASplitX and ASplitY) and
      (FSplitBitmaps <> mrNoToAll) and
      ((FSplitBitmaps = mrYesToAll) or GetUserPermissionForSplit(AFileName, AMultiSelect)) then
      ASourceImageSize := cxSize(ImageWidth, ImageHeight)
    else
      ASourceImageSize := cxSize(AImage.Width, AImage.Height);

    AColCount := AImage.Width div ASourceImageSize.cx;
    ARowCount := AImage.Height div ASourceImageSize.cy;

    for ARowIndex := 0 to ARowCount - 1 do
      for AColIndex := 0 to AColCount - 1 do
      begin
        ADestBitmap := cxCreateBitmap(ImageWidth, ImageHeight, pf32bit);
        try
          ADestBitmap.Canvas.CopyRect(Rect(0, 0, ImageWidth, ImageHeight), AImage.Canvas,
            Rect(AColIndex * ASourceImageSize.cx, ARowIndex * ASourceImageSize.cy, (AColIndex + 1) * ASourceImageSize.cx, (ARowIndex + 1) * ASourceImageSize.cy));
          AddImage(ADestBitmap, AInsertedItemIndex, not IsBitmapAlphaUsed(ADestBitmap), GetDefaultTransparentColor(ADestBitmap));
        finally
          ADestBitmap.Free;
        end;
      end;
  end
  else {Icon}
  begin
    AGraphic.Width := ImageWidth;
    AGraphic.Height := ImageHeight;
    TIcon(AGraphic).Handle;
    AddImage(AGraphic, AInsertedItemIndex);
  end;
end;

procedure TcxImageListEditor.MoveImage(ASourceImageIndex, ADestImageIndex: Integer);
var
  AList: TList;
  I: Integer;
begin
  if ADestImageIndex <> ASourceImageIndex then
  begin
    AList := TList.Create;
    try
      for I := 0 to ImagesCount - 1 do
        AList.Add(DataItems[I].Data);
      AList.Move(ASourceImageIndex, ADestImageIndex);
      for I := 0 to ImagesCount - 1 do
        DataItems[I].Data := AList[I];
    finally
      AList.Free;
    end;
    FocusedImageIndex := ADestImageIndex;
  end;
  UpdateDataItems(ImageList);
end;

procedure TcxImageListEditor.SynchronizeData(AImageList: TCustomImageList);
var
  I: Integer;
  ABitmapInfo: TcxBitmapInfo;
begin
  for I := 0 to AImageList.Count - 1 do
  begin
    ABitmapInfo := TcxBitmapInfo.Create(cxSize(ImageWidth, ImageHeight));
    DataItems.Add.Data := ABitmapInfo;
    ImageList.GetImageInfo(ImageList.Handle, ImagesCount - 1, ABitmapInfo.Image, ABitmapInfo.Mask);
  end;
  UpdateDataItems(ImageList);
end;

function TcxImageListEditor.IsAnyImageSelected: Boolean;
begin
  Result := (FocusedImageIndex <> -1) and (FDataControl.SelCount > 0);
end;

procedure TcxImageListEditor.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxImageListEditor.EndUpdate;
begin
  if FUpdateCount > 0 then
    Dec(FUpdateCount);
end;

function TcxImageListEditor.IsUpdateLocked: Boolean;
begin
  Result := FUpdateCount > 0;
end;

procedure TcxImageListEditor.ApplyChanges;
begin
  if IsChanged then
  begin
    UpdateDataItems(FOriginalImageList);
    //FOriginalImageList.Assign(ImageList);
    FImageListModified := True;
    FChanged := False;
  end;
  Change;
end;

function TcxImageListEditor.IsChanged: Boolean;
begin
  Result := FChanged;
end;

procedure TcxImageListEditor.UpdateActions;
begin
  actDelete.Enabled := IsAnyImageSelected;
  actClear.Enabled := ImagesCount > 0;
  actExport.Enabled := ImagesCount > 0;
  actReplace.Enabled := IsAnyImageSelected;
  actInsert.Enabled := IsAnyImageSelected;
  actApply.Enabled := IsChanged;
end;

procedure TcxImageListEditor.UpdateTransparentColor(AColor: TColor);
var
  I: Integer;
begin
  for I := 0 to ImagesCount - 1 do
    if DataItems[I].Selected then
    begin
      ImagesInfo[I].UpdateMask(I, AColor);
      UpdateDataItems(ImageList);
    end;
end;

procedure TcxImageListEditor.actAddExecute(Sender: TObject);
begin
  AddImages(amAdd);
end;

procedure TcxImageListEditor.actApplyExecute(Sender: TObject);
begin
  ApplyChanges;
end;

procedure TcxImageListEditor.actClearExecute(Sender: TObject);
begin
  ClearImages;
end;

procedure TcxImageListEditor.actDeleteExecute(Sender: TObject);
begin
  DeleteSelectedImages;
end;

procedure TcxImageListEditor.actExportExecute(Sender: TObject);

  function CanReplace: Boolean;
  begin
    Result := MessageDlg(Format('File %s is already exists.'#$A#$D'Do you want to replace it?',
      [spdSave.FileName]), mtWarning, [mbYes, mbNo], 0) = mrYes;
  end;

begin
  if spdSave.Execute and (not FileExists(spdSave.FileName) or CanReplace) then
  begin
    Application.ProcessMessages;
    ExportImages(spdSave.FileName);
  end;
end;

procedure TcxImageListEditor.actInsertExecute(Sender: TObject);
begin
  AddImages(amInsert);
end;

procedure TcxImageListEditor.actOkExecute(Sender: TObject);
begin
  ApplyChanges;
end;

procedure TcxImageListEditor.actReplaceExecute(Sender: TObject);
begin
  AddImages(amReplace);
end;

procedure TcxImageListEditor.AddImage(AImage: TGraphic; var AInsertedImageIndex: Integer; ANew: Boolean = False; AColor: TColor = clNone);
var
  AImageInfo: TcxImageInfo;
begin
  AImageInfo := GetImageInfoClass(AImage).Create(cxSize(ImageWidth, ImageHeight));
  AImageInfo.Graphic := AImage;
  DataItems.Add.Data := AImageInfo;
  MoveImage(AImageInfo.AddMaskedImage(ImageList, ANew, AColor), AInsertedImageIndex);
  Inc(AInsertedImageIndex);
end;

procedure TcxImageListEditor.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TcxImageListEditor.ClearSelection;
var
  I: Integer;
begin
  for I := 0 to ImagesCount - 1 do
    DataItems[I].Selected := False;
end;

procedure TcxImageListEditor.DeleteDataItem(Sender: TObject; Item: TListItem);
begin
  TcxImageInfo(Item.Data).Free;
end;

procedure TcxImageListEditor.DeleteImage(AIndex: Integer);
begin
  if IsIndexValid(AIndex, ImagesCount) then
  begin
    DataItems.Delete(AIndex);
    UpdateDataItems(ImageList);
  end;
end;

function TcxImageListEditor.GetImagesCount: Integer;
begin
  Result := DataItems.Count;
end;

function TcxImageListEditor.GetDefaultTransparentColor(AImage: TBitmap): TColor;
begin
  if not IsBitmapAlphaUsed(AImage) then
    Result := AImage.Canvas.Pixels[0, AImage.Height - 1]
  else
    Result := clNone;
end;

function TcxImageListEditor.GetFocusedImageIndex: Integer;
begin
  Result := -1;
  if FDataControl.ItemFocused <> nil then
    Result := FDataControl.ItemFocused.Index;
end;

function TcxImageListEditor.GetImageHeight: Integer;
begin
  Result := ImageList.Height;
end;

function TcxImageListEditor.GetImageInfoClass(AImage: TGraphic): TcxImageInfoClass;
begin
  if AImage is TBitmap then
    Result := TcxBitmapInfo
  else
    Result := TcxIconInfo;
end;

function TcxImageListEditor.GetImagesInfo(Index: Integer): TcxImageInfo;
begin
  Result := nil;
  if IsIndexValid(Index, ImagesCount) then
    Result := TcxImageInfo(DataItems[Index].Data);
end;

procedure TcxImageListEditor.SetImageList(AValue: TcxImageList);
begin
  FOriginalImageList := AValue;
  ImageList.Assign(AValue);
  SynchronizeData(AValue);
  FChanged := False;
  FocusedImageIndex := 0;
  Change;
end;

function TcxImageListEditor.GetImageWidth: Integer;
begin
  Result := ImageList.Width;
end;

procedure TcxImageListEditor.ImageListChanged;

  procedure InitializeListViewItem(AIndex: Integer);
  begin
    DataItems[AIndex].Caption := IntToStr(AIndex);
    DataItems[AIndex].ImageIndex := AIndex;
  end;

var
  I: Integer;
begin
  for I := 0 to ImagesCount - 1 do
    InitializeListViewItem(I);
  FChanged := True;
  Change;
end;

procedure TcxImageListEditor.SelectDataItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    FDataControl.ItemFocused := Item;
end;

function TcxImageListEditor.GetDataItems: TListItems;
begin
  Result := FDataControl.Items;
end;

procedure TcxImageListEditor.SetFocusedImageIndex(AValue: Integer);
begin
  if IsIndexValid(AValue, ImagesCount) then
  begin
    ClearSelection;
    DataItems[AValue].Selected := True;
    FDataControl.Selected.MakeVisible(True);
  end;
end;

procedure TcxImageListEditor.SetImagesInfo(Index: Integer;
  AValue: TcxImageInfo);
begin
  if DataItems[Index].Data <> AValue then
    DataItems[Index].Data := AValue;
end;

procedure TcxImageListEditor.SetImportList(AValue: TStrings);
begin
  if AValue <> nil then
    FImportList.Assign(AValue)
  else
    FImportList.Clear;
  TcxImageListEditorForm(FEditorForm).SetImportList(FImportList);
end;

procedure TcxImageListEditor.UpdateDataItems(AUpdatedImageList: TcxImageList);
var
  I: Integer;
begin
  AUpdatedImageList.BeginUpdate;
  try
    AUpdatedImageList.Clear;
    for I := 0 to DataItems.Count - 1 do
      ImagesInfo[I].Synchronize(AUpdatedImageList);
  finally
    AUpdatedImageList.EndUpdate;
  end;
  ImageListChanged;
end;

initialization
  cxImageFileFormats.Register('Bitmaps (*.bmp)', '.bmp', TBitmap);
  cxImageFileFormats.Register('Icons (*.ico)', '.ico', TIcon);
{$IFNDEF CLR}
  if CheckGdiPlus then
    cxImageFileFormats.Register('DevExpress PNG (*.png)', '.png', TdxPNGImage);
{$ENDIF}

finalization
  FreeAndNil(FImageFileFormats);

end.
