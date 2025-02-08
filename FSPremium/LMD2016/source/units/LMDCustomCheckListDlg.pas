unit LMDCustomCheckListDlg;
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

LMDCheckListDlg unit (RM)
-------------------------

Dialog providing a Radio- or CheckListBox

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Classes,
  LMDClass, LMDBaseDialog, LMDCheckListBox, LMDButtonListData;

type
  TLMDCheckListBoxDlgOptions=set of (cloRadioButtons, cloHideBox, cloCheckButtons,
                                     cloSelectByClick, cloSpeedBtnFlat, cloUseResetButton);

  TLMDCustomCheckListDlg = class (TLMDBaseDialog)
  private
    FItems:TStrings;
    FMargin:Byte;
    FDefaultValue,
    FResult,
    FItemIndex,
    FItemHeight,
    FWidth,
    FListWidth,
    FListHeight:Integer;
    FOptions:TLMDCheckListBoxDlgOptions;
    FPrompt         : String;
    procedure SetItems(aValue:TStrings);
    procedure GetCheckClick(Sender:TObject);
    function GetChecked(index:Integer):Boolean;
    function GetCheckListBox:TLMDCheckListBox;
  protected
    function ShowDialog (const Caption, Prompt : String; aList:TStrings; aValue:Integer; Main:TCustomForm) : Boolean;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    function Execute:Boolean;override;
    function ExecuteEnh(aForm:TForm):Boolean; virtual;

    function DisplayOptionsDlg(const ACaption, APrompt : String; theOptions:TStrings; var aValue:Integer):Boolean;overload;
    function DisplayOptionsDlg(theOptions:TStrings; var aValue:Integer):Boolean;overload;

    // public properties
    property CtlXP; // compatibility
    property Value:Integer read FResult;
    property Checked[Index: Integer]: Boolean read GetChecked;
    property CheckListBox:TLMDCheckListBox read GetCheckListBox;
    property Items:TStrings read FItems write SetItems;
  published
    property About;
    property CaptionFill;
    property CaptionTitle;
    property Colors;
    property CustomButton;
    property DefaultValue:Integer read FDefaultValue write FDefaultValue default 0;
    property Effect;
    property Hints;
    property ImageIndex;
    property ImageList;
    property ListIndex;

    property ListBoxShowItems:Integer read FListHeight write FListHeight default -1;
    property ListBoxItemHeight:Integer read FItemHeight write FItemHeight default 16;
    property ListBoxItemIndex:Integer read FItemIndex write FItemIndex default -1;
    property ListBoxWidth:Integer read FListWidth write FListWidth default -1;
    property Options:TLMDCheckListBoxDlgOptions read FOptions write FOptions default [cloCheckButtons, cloSelectByClick, cloSpeedBtnFlat];

    property Margin:Byte read FMargin write FMargin default 3;
    property Width: Integer read FWidth write FWidth default -1;
    property Position;
    property Prompt : String read FPrompt write FPrompt;
    property RelatePos;
    property ShowHints;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
    property OnCustomClick;
    property OnCustomize;
  end;

  // Allows setting of a set property in class "Instance"
  // Returns true when successful
  function LMDCPSelectValueDialog(Instance:TObject; const PropName: string; vCtlXP:TLMDThemeMode=ttmNone):Boolean;

implementation

uses
  Types, TypInfo, Windows, Graphics, StdCtrls, SysUtils, Controls,
  LMDButtonBase, LMDGraph, LMDGraphUtils, LMDProcs, LMDConst, LMDSimpleLabel,
  LMDUtils, LMDCustomFormFill, LMDFormStyler, LMDButton, LMDSpeedButton;

function LMDCPSelectValueDialog(Instance:TObject; const PropName: string; vCtlXP:TLMDThemeMode=ttmNone):Boolean;

var
  Data: PTypeData;
  FPropInfo:PPropInfo;
  FEnumInfo:PTypeInfo;
  tmp: TIntegerSet;
  tmpd:TLMDCustomCheckListDlg;
  i:Integer;

begin
  result:=false;
  tmpd:=TLMDCustomCheckListDlg.Create(nil);
  with tmpd do
    try
      FPropInfo:=GetPropInfo(Instance, PropName);

      case FPropInfo.PropType^.Kind of
        tkSet:
                        FEnumInfo:=GetTypeData(FPropInfo.PropType^).CompType^;
        tkEnumeration: begin
                         FEnumInfo:=FPropInfo.PropType^;
                         Options:=Options+[cloRadioButtons];
                       end
      else
        raise Exception.Create('LMDCPSelectValueDlg: Invalid property parameter');
      end;

      data:=GetTypeData(FEnumInfo);
      for i:= data.MinValue to data.MaxValue do
        Items.Add(GetEnumName(FEnumInfo, i));

      DefaultValue:=GetOrdProp(Instance, PropName);
      Prompt:=IDS_SELECTOPTIONS;
      ListBoxShowItems:=16;  // do not show more than 16 items, otherwise show scrollbars
      ThemeMode := vCtlXP;

      if Execute then
        begin
          tmp:=[];
          if cloRadioButtons in Options then
            SetPropValue(Instance, PropName, Integer(Value))
          else
            begin
              for i:=Data.MinValue to Data.MaxValue do
                if Checked[Ord(i)] then Include(tmp, i);
              SetPropValue(Instance, PropName, Integer(tmp));
            end;
          result:=true;
        end;
    finally
      Free;
    end;
end;

{ ************************** TLMDCustomCheckListDlg *********************************}
{ ------------------------------- private ------------------------------------ }
procedure TLMDCustomCheckListDlg.SetItems(aValue:TStrings);
begin
  FItems.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCheckListDlg.GetCheckClick(Sender:TObject);
var
  CB: TLMDCheckListBox;
begin
  with TComponent(Sender) do
    begin

      CB := TLMDCheckListBox(Tag);

      if Name='C' then
        CB.CheckAll;
      if Name='U' then
        CB.CheckAll(true);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckListDlg.GetChecked(index:Integer):Boolean;
var
  tmp:LongInt;
begin
  tmp:=LMDExp(2, index);
  result:=(tmp and FResult = tmp);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckListDlg.GetCheckListBox:TLMDCheckListBox;
begin
  result:=nil;
  if Assigned(Dlg) then

    result:=TLMDCheckListBox(Dlg.Tag);

end;

{ ------------------------------- protected ---------------------------------- }
function TLMDCustomCheckListDlg.ShowDialog (const Caption, Prompt:String;aList:TStrings; aValue:Integer;  Main : TCustomForm) : Boolean;
var
  id     : TForm;
  input  : TLMDCheckListBox;
  custom,
  ok,
  cancel : TLMDButton;
  checkAll,
  uncheckAll:TLMDSpeedButton;
  promptL: TLMDSimpleLabel;
  fs     : TLMDFormStyler;
  b      : TLMDCustomFormFill;
  bw,
  w,
  lw,
  i      : Integer;
  tmp    : TBitmap;
  tmpr   :TRect;

  function theGreater (i1, i2 : Integer) : Integer;
  begin
    result := i1;
    if i2 > i1 then
      result := i2;
  end;

begin
  result := false;

  // if Items property is empty, dialog makes not much sense.
  if aList.Count=0 then
    raise Exception.Create(IDS_TIPERROR);

  checkAll:=nil;
  uncheckAll:=nil;
  //input := nil;

  id := TForm.Create(nil);
  with id do
  begin
    input := TLMDCheckListBox.Create (id);
    try
      if FWidth <> -1 then
        w := FWidth
      else
        if FListWidth<>-1 then
          w:=FListWidth+30
        else
          w := 280;

      // CheckButtons make sense only in CheckBox Mode
      if (cloCheckButtons in FOptions) and
         not (cloRadioButtons in FOptions) then
        lw:=24
      else
        lw:=0;

      BorderStyle:=bsDialog;

      // Font-->
      Font.Color:=clWindowText;
      Font.Name:='MS Sans Serif';
      Font.Height:=-11;
      // -------
      Position:=poDefault;
      PixelsPerInch:=96;
      Scaled:=False;

      //get needed btn size
      bw := 75;

      bw := theGreater (bw, Canvas.TextWidth (IDS_CANCEL) + 6);
      bw := theGreater (bw, Canvas.TextWidth (CustomButton) + 6);

      //get space needed by buttons
      if CustomButton <> '' then
        i := 3 * (bw + 5)
      else
        i := 2 * (bw + 5);

      if i > w then w := i + 10;  // buttons

      //set form width
      Width := w;
      i := (w - i) div 2;

      promptL := TLMDSimpleLabel.Create (id);
      with promptL do
        begin
          Parent:=id;
          BeginUpdate;
          Font:=self.Font;
          MultiLine:=True;
          Transparent:=True;
          SetBounds(10,10, w-30, 10);
          Caption:=prompt;
          EndUpdate(true);
        end;

      with input do
        begin
          Parent := id;
          ThemeMode := self.ThemeMode;
          Top := promptL.Top + promptL.Height + FMargin;

          if (FListWidth=-1) or (FListWidth>id.Width-20) then
            begin
              Left := 10;
              Width := w - 30 -lw;
            end
          else
            begin
              input.Width:=FListWidth-lw;
              Left:=(id.ClientWidth-FlistWidth) div 2;
            end;
          TabOrder := 0;
          Items:=aList;

          // CheckListBox specific settings
          if cloHideBox in FOptions then
            begin
              BorderStyle:=bsNone;
              ParentColor:=True;
              SelectedColor:=id.Color;
              SelectedFontColor:=Font.Color;
              HideFocus:=True;
            end;

          if cloRadioButtons in FOptions then
            BtnMode:=blRadioButton;

          SelectByClick:=(cloSelectByClick in FOptions);

          ItemHeight:=FItemHeight;
          w:=aList.Count;
          if (FListHeight>0) and (w>FListHeight) then w:=FListHeight;

          if self.ThemeMode = ttmNone then
            Height:=w*ItemHeight+4
          else
            Height:=w*ItemHeight+2;

          ItemIndex:=FItemIndex;
          Value:=DefaultValue;
        end;

      // Save Tag for CheckListBox property
      Tag:=LongInt(input);
      if lw>0 then
        begin
          // CheckButton
          checkAll:=TLMDSpeedButton.Create(id);
          with checkAll do
            begin
              Parent:=id;
              if ThemeMode = ttmNone then
                if (cloSpeedBtnFlat in FOptions) then
                  Style:=ubsFlat
                else
                  Style:=ubsWin40;
              Width:=24;
              Height:=22;
              Left:=input.BoundsRect.Right+1;
              Top:=input.Top;
              OnClick:=GetCheckClick;
              // store Pointer to CheckListBox
              Name:='C';

              Tag:=LongInt(input);

            end;

          tmpr:=Rect(0,1, 12, 13);

          // UnCheckButton
          uncheckAll:=TLMDSpeedButton.Create(id);
          with uncheckAll do
            begin
              Parent:=id;
              Style:=checkAll.Style;
              Width:=24;
              Height:=22;
              Left:=checkAll.Left;
              Top:=checkAll.BoundSrect.Bottom+1;
              OnClick:=GetCheckClick;
              // store Pointer to CheckListBox
              Name:='U';

              Tag:=LongInt(input);

            end;

          tmp:=TBitmap.Create;
          try
            LMDBmpCreateFromRect(tmp, Rect(0,0, 12,14), clFuchsia);
            DrawFrameControl(tmp.Canvas.Handle, tmpr, DFC_BUTTON, DFCS_FLAT or DFCS_BUTTONCHECK or DFCS_CHECKED);
            CheckAll.Glyph:=tmp;
            DrawFrameControl(tmp.Canvas.Handle, tmpr, DFC_BUTTON, DFCS_FLAT or DFCS_BUTTONCHECK);
            UnCheckAll.Glyph:=tmp;
          finally
            tmp.Free;
          end;

        end;

      id.ClientHeight:=Input.Top+Input.Height+37;
      if Assigned(UnCheckAll) then
        if UnCheckAll.BoundsRect.Bottom+37>id.ClientHeight then
          id.ClientHeight:=UnCheckAll.BoundsRect.Bottom+37;

      ok:=TLMDButton.Create(id);
      with ok do
        begin
          Parent:=id;
          if ThemeMode = ttmNone then ExtStyle:=ubsWin40;
          Width:=bw;
          Height:=24;
          Left:=i;
          Top:=id.ClientHeight-30;
          ModalResult:=mrOK;
          Caption:='OK';
          Default:=True;
          TabOrder:=0;
        end;

      i := ok.Left + ok.Width;

      cancel:=TLMDButton.Create(id);
      with cancel do
        begin
          Parent:=id;
          if ThemeMode = ttmNone then ExtStyle:=ubsWin40;
          Width:=bw;
          Height:=24;
          Left:=i + 5;
          Top:=ok.Top;
          ModalResult:=mrCancel;
          Caption:=IDS_CANCEL;
          Cancel:=True;
          TabOrder:=1;
        end;

      i := cancel.Left + cancel.Width;

      custom:=TLMDButton.Create(id);
      with custom do
        begin
          Parent:=id;
          if ThemeMode = ttmNone then ExtStyle:=ubsWin40;
          Width:=bw;
          Height:=24;
          Left:=i + 5;
          Top:=ok.Top;
          TabOrder:=2;
          Tag:=LongInt(input.Tag);
        end;

      if ShowHints and (Hints.Count>0) then
        begin
          ShowHint:=True;
          ok.Hint:=Hints[0];
          if Hints.Count>1 then cancel.Hint:=Hints[1];
          if Hints.Count>2 then input.Hint:=Hints[2];
          if Hints.Count>3 then custom.Hint:=Hints[3];
          if Hints.Count>4 then input.Hint:=Hints[4];
          // UnCheck / Check Buttons
          if (Hints.Count>5) and Assigned(checkAll) then checkAll.Hint:=Hints[5];
          if (Hints.Count>6) and Assigned(UncheckAll) then uncheckAll.Hint:=Hints[6];
        end;

      fs:=TLMDFormStyler.Create(id);
      fs.Enabled:=False;

      b:=TLMDCustomFormFill.Create(id);
      b.Enabled:=False;

    if BaseExecute(id, Main, Custom,  fs, b, IDS_SELECT)=mrOK then
      begin
        FResult:=input.Value;
        result := true;
      end
    else
      FResult:=-1;
  finally
    //free all

    id.Free;
  end;
  end;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDCustomCheckListDlg.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FWidth := -1;
  FListHeight:=-1;
  FListWidth:=-1;
  FItemIndex:=-1;
  FMargin:=3;
  FItemHeight:=16;
  FOptions:=[cloCheckButtons, cloSelectByClick, cloSpeedBtnFlat];
  FItems:=TStringlist.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomCheckListDlg.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckListDlg.Execute:Boolean;
begin
  result := ExecuteEnh (nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckListDlg.ExecuteEnh(aForm:TForm):Boolean;
begin
  result := ShowDialog (CaptionTitle, FPrompt, FItems, DefaultValue, aForm);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckListDlg.DisplayOptionsDlg(const ACaption, APrompt : String; theOptions:TStrings; var aValue:Integer):Boolean;
begin
  result:=ShowDialog (aCaption, aPrompt, theOptions, aValue, nil);
  if result then aValue:=Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCheckListDlg.DisplayOptionsDlg(theOptions:TStrings; var aValue:Integer):Boolean;
begin
  result:=ShowDialog (CaptionTitle, Prompt, theOptions, aValue, nil);
  if result then aValue:=Value;
end;

initialization
finalization

end.
