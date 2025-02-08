unit LMDAlphaObject;
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

LMDAlphaObject unit (JH)
------------------------
Special object for supporting alpha blending

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Imglist,
  LMDBaseController, LMDBmp, LMDCont, LMDCustomImageList, LMDObject, LMDGraph, 
  LMDFillObject;

type

  //ensure that component containg this object has got an extra Notification procedure which
  //clears this objects ImageList if it is removed!!

  TLMDAlphaObject = class(TLMDObject)
  private
    FImageList   : TCustomImageList;
    FStrength    : Single;
    FImageIndex,
    FListIndex   : Integer;
    FTransparent : Boolean;
    FFillObject  : TLMDFillObject;
    FChangeLink  : TChangeLink;

    procedure SetInteger (index, aValue : Integer);
    procedure SetBoolean (index:Integer;aValue : Boolean);
    procedure SetSingle (aValue : Single);
    procedure SetFillObject (aValue : TLMDFillObject);
    procedure SetImageList (aValue : TCustomImageList);

    procedure GetIMLChange (Sender : TObject);
    function IMLEmpty : Boolean;
  protected
    procedure GetChange (Sender : TObject); override;
    procedure DefineProperties(Filer:TFiler); override;
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function CheckCont:Boolean;
    function HasControl:Boolean;
    function HasNonDefaultStrength: Boolean; //new July 02, JH    
    property Transparent : Boolean index 0 read FTransparent write SetBoolean default false;
  public
    constructor Create(AOwner:TPersistent=nil); override;
    destructor Destroy; override;
    procedure Assign (Source : TPersistent); override;
    function GetSetStr : String; override;

    function Enabled : Boolean;
    function GetPalette : HPalette;

//    procedure RectAlphaBlend (Target : TBitmap);
    procedure AlphaBlend (Target : TBitmap);
    procedure ControlBlend (OriginalBack : TBitmap; ControlsRect : TRect;
                            DestinationRect : TRect; Target : TCanvas; Src : TRect);
  published
    property ImageList : TCustomImageList read FImageList write SetImageList stored HasControl;
    property ImageIndex : Integer index 0 read FImageIndex write SetInteger default 0;
    property ListIndex : Integer index 1 read FListIndex write SetInteger default 0;
    property Strength : Single read FStrength write SetSingle stored HasNonDefaultStrength;
    property FillObject : TLMDFillObject read FFillObject write SetFillObject;
  end;

//procedure rudimentAlphaBlend (target, source1, source2 : TBitmap; FStrength : Byte; trans : boolean);

implementation
uses
  Types,
  LMDClass;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.SetInteger (index, aValue : Integer);
begin
  case index of
    0 : FImageIndex := aValue;
    1 : FListIndex := aValue;
  end;
  GetIMLChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.SetBoolean (index:Integer;aValue : Boolean);
begin
  case index of
    0: if aValue <> FTransparent then
         begin
           FTransparent := aValue;
           GetChange (nil);
         end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.SetSingle (aValue : Single);
begin
  if (aValue <> FStrength) {and ((aValue >= 0) and (aValue <= 1))} then
    begin
      FStrength := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.SetFillObject (aValue : TLMDFillObject);
begin
  FFillObject.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.SetImageList (aValue : TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
//      FImageList.FreeNotification(Self);
    end;
  GetIMLChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.GetIMLChange (Sender : TObject);
begin
  if not IMLEmpty then
    LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FFillObject.ListBitmap)
  else
    FFillObject.ListBitmap:=nil;
  GetChange(FFillObject);
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlphaObject.IMLEmpty : Boolean;
begin
  result:=not ((FImageList<>nil) and LMDIMLIsValidItem(FImageList, FListIndex, FImageIndex));
end;

{ -------------------------- protected --------------------------------------- }
procedure TLMDAlphaObject.GetChange (Sender : TObject);
begin
  inherited GetChange (nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDAlphaObject.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
end;

{------------------------------------------------------------------------------}
procedure TLMDAlphaObject.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDAlphaObject.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDAlphaObject.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDAlphaObject.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
function TLMDAlphaObject.HasNonDefaultStrength: Boolean;
begin
  //checks whether a user has changed the strength
  //strength changes < 1/1000000 will be ignored!!
  result := Trunc(FStrength * 1000000) <> Trunc(0.6 * 1000000);
end;

{ -------------------------- public ------------------------------------------ }
constructor TLMDAlphaObject.Create;
begin
  inherited Create;

  FListIndex:=0;
  FImageIndex:=0;
  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetIMLChange;

  FFillObject := TLMDFillObject.Create;
  FFillObject.OnChange := GetChange;

  FImageIndex := 0;
  FListIndex := 0;

  FStrength := 0.6;
  FTransparent := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDAlphaObject.Destroy;
begin

  FChangeLink.OnChange:=nil;
  FChangeLink.Free;

  FFillObject.OnChange := nil;
  FFillObject.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlphaObject.Enabled : Boolean;
begin
  result := (FFillObject.Style <> sfNone) and (FStrength <> 1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.Assign (Source : TPersistent);
var
  S: TLMDAlphaObject;
begin
  if Source = self then exit;
  if Source is TLMDAlphaObject then
    begin
      S := TLMDAlphaObject(Source);
      FFillObject.Assign ( S.FillObject);
      FTransparent := S.Transparent;
      FStrength := S.Strength;
      FImageIndex := S.ImageIndex;
      FListIndex := S.ListIndex;
      FImageList := S.ImageList;
      exit;
    end;
  inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlphaObject.GetSetStr : String;
begin
  result := '';
  if FFillObject.Style <> sfNone then
    begin
      result := '{Enabled (';
      case FillObject.Style of
        sfGradient : result := result + 'grad';
        sfBitmapList,
        sfBitmap : result := result + 'bmp';
        sfBrush : result := result + 'brush';
      end;
      result := result+'), strength: '+FloatToStrF (FStrength, ffFixed, 5, 3)+'}'
    end
  else
    result := '{Disabled}';
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlphaObject.GetPalette : HPalette;
begin
  result := 0;
  if FFillObject.Style <> sfNone then
    result := FFillObject.Palette;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.AlphaBlend (Target : TBitmap);
var
  b : TBitmap;
  aRect : TRect;
begin
  if FFillObject.Style = sfNone then exit;

  aRect := Types.Rect (0, 0, Target.Width-1, Target.Height-1);

  b := TBitmap.Create;
  try
    b.Width := aRect.Right - aRect.Left + 1;
    b.Height := aRect.Bottom - aRect.Top + 1;

    FFillObject.FillCanvas (b.Canvas, b.Canvas.ClipRect, clWhite);

    b.TransparentColor := FFillObject.Bitmap.Transparentcolor;

    Target.PixelFormat := pf24Bit;
    b.PixelFormat := pf24Bit;

    LMDBMPAlphaBlend (Target, b, aRect, Point (0, 0), Target, FStrength, Point (aRect.Left, aRect.Top));

//    rudimentAlphaBlend (Target, Target, b, FStrength, FTransparent);
//    AlfaBlnd.AlphaBlend (Target, b, FStrength, Target);
  finally
    b.Free;
  end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaObject.ControlBlend (OriginalBack : TBitmap; ControlsRect : TRect;
                                        DestinationRect : TRect; Target : TCanvas; Src : TRect);
var
  b : TBitmap;
begin
  b := TBitmap.Create;
  try
    b.Width := ControlsRect.Right - ControlsRect.Left;
    b.Height := ControlsRect.Bottom - ControlsRect.Top;
    b.Canvas.CopyRect (b.Canvas.ClipRect, OriginalBack.Canvas, ControlsRect); //get back
    AlphaBlend (b); //make blend operation
    Target.CopyRect (DestinationRect, b.Canvas, Src);
  finally
    b.Free;
  end;
end;

end.
