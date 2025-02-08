unit  pLMDRTFActDescr;
{$I LMDCmps.inc}
interface

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

pLMDRTFActDescr unit (RM)
--------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}
uses
  Classes, Controls, LMDRTFActions;

type
{ ****************************  TLMDRTFActionDescriptor  ********************* }
  TLMDRTFActionDescriptor = class(TCollectionItem)
  private
    fCls: TLMDRichEditActionClass;
    fCaption: string;
    fImageIndex: integer;
    fCategory: string;
    fHint: string;
  protected
  public
    function  CreateAction(aOwner: TComponent): TLMDRichEditAction;
    property  Cls: TLMDRichEditActionClass read fCls write fCls;
    property  Caption: string read fCaption write fCaption;
    property  Hint: string read fHint write fHint;
    property  ImageIndex: integer read fImageIndex write fImageIndex;
    property  Category: string read fCategory write fCategory; 
  end;

{ ****************************  TLMDRTFActionDescriptors  ******************** }
  TLMDRTFActionDescriptors = class(TCollection)
  private
    function  GetItems(Ind: integer): TLMDRTFActionDescriptor;
  protected
  public
    constructor Create;
    procedure RegisterAction(Cls: TLMDRichEditActionClass;
        const Caption: string; const Category: string = ''; ImageIndex: integer = -1);
    function  CreateAction(Cls: TLMDRichEditActionClass; aOwner: TComponent): TLMDRichEditAction;
    property Items[Ind: integer]: TLMDRTFActionDescriptor read GetItems; default;
  end;

function  CreateLMDRTFActionImageList(aOwner: TComponent): TImageList;
function  CreateStdLMDRTFActionDescriptors: TLMDRTFActionDescriptors;
function  StdLMDRTFActionDescriptors: TLMDRTFActionDescriptors;

implementation

uses
  ImgList, Graphics, 
  pLMDGlobalEditors, LMDRTFConst;

{ ***********************  TLMDRTFActionDescriptor *********************** }

function  TLMDRTFActionDescriptor.CreateAction(aOwner: TComponent): TLMDRichEditAction;
begin
  if  Assigned(fCls)  then
    begin
      Result := fCls.Create(aOwner);
      Result.Caption := Caption;
      Result.ImageIndex := ImageIndex;
      Result.Category := Category;

      if  Hint = '' then
        Result.Hint := Caption
      else
        Result.Hint := Hint;
    end
  else
    Result := nil;
end;

{ ***********************  TLMDRTFActionDescriptors ********************** }

constructor TLMDRTFActionDescriptors.Create;
begin
  inherited Create(TLMDRTFActionDescriptor);
end;

{ ------------------------------------------------------------------------- }

function  TLMDRTFActionDescriptors.GetItems(Ind: integer): TLMDRTFActionDescriptor;
begin
  Result := TLMDRTFActionDescriptor(inherited Items[Ind]);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFActionDescriptors.RegisterAction(Cls: TLMDRichEditActionClass;
    const Caption: string; const Category: string; ImageIndex: integer);
var
  Itm: TLMDRTFActionDescriptor;
begin
  Itm := TLMDRTFActionDescriptor(Add);
  Itm.Cls := Cls;
  Itm.Caption := Caption;
  Itm.ImageIndex := ImageIndex;
  Itm.Category := Category;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRTFActionDescriptors.CreateAction(Cls: TLMDRichEditActionClass;
    aOwner: TComponent): TLMDRichEditAction;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to Count - 1 do
    if  Items[i].Cls = Cls  then
      begin
        Result := Items[i].CreateAction(aOwner);
        Break;
      end;

  if  not Assigned(Result)  then
    Result := Cls.Create(aOwner);
end;

{ ------------------------------------------------------------------------- }

function  CreateStdLMDRTFActionDescriptors: TLMDRTFActionDescriptors;
var
  Cat: string;
begin
  Result := TLMDRTFActionDescriptors.Create;
  Cat := IDRTF_AC_FILE;
  Result.RegisterAction(TLMDRichEditNew, IDRTF_ANEW, Cat, 0);
  Result.RegisterAction(TLMDRichEditLoad, IDRTF_AOPEN, Cat, 1);
  Result.RegisterAction(TLMDRichEditSave, IDRTF_ASAVE, Cat, 2);
  Result.RegisterAction(TLMDRichEditPrint, IDRTF_APRINT, Cat, 3);
  Result.RegisterAction(TLMDRichEditPreview, IDRTF_APREVIEW, Cat, 4);

  Cat := IDRTF_AC_EDIT;
  Result.RegisterAction(TLMDRichEditUndo, IDRTF_AUNDO, Cat, 8);
  Result.RegisterAction(TLMDRichEditRedo, IDRTF_AREDO, Cat, 9);
  Result.RegisterAction(TLMDRichEditCut, IDRTF_ACUT, Cat, 5);
  Result.RegisterAction(TLMDRichEditCopy, IDRTF_ACOPY, Cat, 6);
  Result.RegisterAction(TLMDRichEditPaste, IDRTF_APASTE, Cat, 7);
  Result.RegisterAction(TLMDRichEditDelete, IDRTF_ADELETE, Cat, -1);
  Result.RegisterAction(TLMDRichEditSelectAll, IDRTF_ASELECTALL, Cat, -1);
  Result.RegisterAction(TLMDRichEditFind, IDRTF_AFIND, Cat, 24);
  Result.RegisterAction(TLMDRichEditReplace, IDRTF_AREPLACE, Cat, -1);

  Cat := IDRTF_AC_FORMAT;
  Result.RegisterAction(TLMDRichEditTextAttributes, IDRTF_AFONT, Cat, 23);
  Result.RegisterAction(TLMDRichEditTextBold, IDRTF_ABOLD, Cat, 10);
  Result.RegisterAction(TLMDRichEditTextItalic, IDRTF_AITALIC, Cat, 11);
  Result.RegisterAction(TLMDRichEditTextUnderline, IDRTF_AUNDERLINE, Cat, 12);
  Result.RegisterAction(TLMDRichEditTextSubscript, IDRTF_ASUBSCRIPT, Cat, 13);
  Result.RegisterAction(TLMDRichEditTextSuperscript, IDRTF_ASUPERSCRIPT, Cat, 14);
  Result.RegisterAction(TLMDRichEditIndent, IDRTF_AINCREASEINDENT, Cat, 22);
  Result.RegisterAction(TLMDRichEditUnindent, IDRTF_ADECREASEINDENT, Cat, 21);
  Result.RegisterAction(TLMDRichEditParaAlignLeft, IDRTF_JUSTIFYLEFT, Cat, 15);
  Result.RegisterAction(TLMDRichEditParaAlignCenter, IDRTF_JUSTIFYCENTER, Cat, 17);
  Result.RegisterAction(TLMDRichEditParaAlignRight, IDRTF_JUSTIFYRIGHT, Cat, 16);

  Result.RegisterAction(TLMDRichEditNumberingBullet, IDRTF_ANUMBERINGBULLET, Cat, 19);
  Result.RegisterAction(TLMDRichEditNumberingArabicNumbers, IDRTF_ANUMBERINGARABICNUMBERS, Cat, 20);
end;

var
  FStdLMDRTFActionDescriptors: TLMDRTFActionDescriptors = nil;

function  StdLMDRTFActionDescriptors: TLMDRTFActionDescriptors;
begin
  if  not Assigned(FStdLMDRTFActionDescriptors) then
    FStdLMDRTFActionDescriptors := CreateStdLMDRTFActionDescriptors;

  Result := FStdLMDRTFActionDescriptors;
end;

{ ------------------------------------------------------------------------- }

function CreateLMDRTFActionImageList(aOwner: TComponent): TImageList;
begin
  Result := TImageList.Create(aOwner);
  Result.Width:=16;
  Result.Height:=16;
  Result.AddMasked(LMDGetToolBitmap, clFuchsia);
end;

{ ------------------------------------------------------------------------- }

initialization

finalization
  StdLMDRTFActionDescriptors.Free;

end.
