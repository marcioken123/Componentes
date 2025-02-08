unit  pLMDRTFGenerateToolbar;
{$I LMDCmps.inc}

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

pLMDRTFGenerateToolbar unit (RM)
-------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes;

procedure GenerateToolbar(Component: TComponent);

implementation

uses
  ActnMan, ActnMenus, ActnCtrls,
  {$IFDEF LMDCOMP7}
  XPStyleActnCtrls,
  StdStyleActnCtrls,
  {$ENDIF}
  {$IFDEF LMDCOMP17}System.Actions,{$ENDIF}
  Commctrl,
  Windows, Forms, SysUtils, ActnList, ComCtrls, Controls, ImgList, Graphics,
  LMDRTFRichEdit, pLMDRTFToolbarOptions, LMDRTFActions, LMDRTFConst,
  pLMDRTFActDescr;

type
  TActionClass = class of TAction;

function IsEqualImageList(IL1, IL2: TCustomImageList): Boolean;

  procedure WriteData(IL: TCustomImageList; Stream: TStream);
  var
    SA: TStreamAdapter;
  begin
    SA := TStreamAdapter.Create(Stream);
    try
      ImageList_Write(IL.Handle, SA);
    finally
      SA.Free;
    end;
  end;

var
  sI1, sI2: TMemoryStream;
begin
  if (IL1 = nil) or (IL2 = nil) or (IL1.Count <> IL2.Count) then
  begin
    Result := False;
    Exit;
  end;

  if (IL1.Count = 0) and (IL2.Count = 0) then
  begin
    Result := True;
    Exit;
  end;

  sI1 := TMemoryStream.Create;
  sI2 := TMemoryStream.Create;

  try
    WriteData(IL1, sI1);
    WriteData(IL2, sI2);
    Result := (sI1.Size = sI2.Size) and
    CompareMem(sI1.Memory, sI2.Memory, sI1.Size);
    finally
    sI1.Free;
    sI2.Free;
  end;
end;

procedure GenerateToolbar(Component: TComponent);
var
  Owner: TComponent;

  function  GenerateComponentName(const BaseName: string): string;
  var
    i: integer;
  begin
    if  Owner.FindComponent(BaseName) = nil then
      Result := BaseName
    else
      begin
        i := 1;
        while Owner.FindComponent(BaseName + IntToStr(i)) <> nil do
          inc(i);

        Result := BaseName + IntToStr(i);
      end;
  end;

  function  GenerateActionName(Action: TComponent): string;
  begin
    Result := GenerateComponentName('act' + Copy(Action.ClassName, 13, MAXINT));
  end;

var
//  TB: TToolBar;
//  AL: TActionList;
  IL: TCustomImageList;
  TOF: TToolbarOptionsForm;
  {------------------------------------------------------------------------------}

  procedure CreateToolBar;
    var
      TB: TToolBar;
      AL: TActionList;

    function CreateButton(D: TLMDRTFActionDescriptor; aCheck: Boolean = false): TToolButton;
    begin
      Result:= TToolButton.Create(Component.Owner);

      if TB.ButtonCount > 0 then
        begin
          Result.Top:= TB.Buttons[ TB.ButtonCount - 1].Top;
          Result.Left:= TB.Buttons[ TB.ButtonCount - 1].Left +
            TB.Buttons[ TB.ButtonCount - 1].Width;
        end;

      Result.Parent:= TB;
      Result.Name:= GenerateComponentName('btn' + Copy(D.Cls.ClassName, 13, MAXINT));

      if aCheck then
        Result.Style:= tbsCheck;
      Result.Action:= D.CreateAction(Component.Owner);
      TContainedAction(Result.Action).ActionList:= AL;
      Result.Action.Name := GenerateActionName(Result.Action);
    end;

    {------------------------------------------------------------------------------}

    procedure CreateSeparator;
    begin
      with TToolButton.Create( Component.Owner) do
      begin
  //      Name:= GenerateComponentName('Separator');
        if TB.ButtonCount > 0 then begin
          Top:= TB.Buttons[ TB.ButtonCount - 1].Top;
          Left:= TB.Buttons[ TB.ButtonCount - 1].Left +
            TB.Buttons[ TB.ButtonCount - 1].Width;
        end;
        Parent:= TB;
        Style:= tbsSeparator;
        Width:= 8;
      end;
    end;

    {------------------------------------------------------------------------------}

    procedure CreateSection(const Actions: array of TLMDRichEditActionClass;
        Groupped: Boolean = False);
      var
        i, j: integer;
        S: Boolean;
        aCls: TLMDRichEditActionClass;
        D: TLMDRTFActionDescriptor;
        LI: TListItem;
        Btn: TToolButton;
    begin
      S := False;

      for i := Low(Actions) to High(Actions) do
        begin
          aCls := Actions[i];
          D := nil;

          for j := 0 to TOF.CheckListBox.Items.Count - 1 do
            begin
              LI := TOF.CheckListBox.Items[j];
              if  Assigned(LI.Data)
                  and (TLMDRTFActionDescriptor(LI.Data).Cls = aCls) then
                begin
                  if  LI.Checked  then
                  D := LI.Data;
                  Break;
                end;
            end;

          if  Assigned(D) then
            begin
              if  not S and (TB.ButtonCount > 0) then
                CreateSeparator;

              S := True;
              Btn := CreateButton(D, Groupped);

              if  Groupped  then
                begin
                  Btn.Grouped := True;
                  Btn.AllowAllUp := True;
                end;
            end;
        end;
    end;

  begin
    AL:= TActionList.Create( Component.Owner);
    AL.Name:= GenerateComponentName('alToolbar');
    AL.Images:= IL;
    TB:= TToolbar.Create(Component.Owner);
    TB.Name:= GenerateComponentName('Toolbar');
    TB.Parent:= (Component as TControl).Parent;
    TB.ShowHint := True;
    TB.Images:= IL;
    TB.Flat:= True;
    TB.AutoSize:= True;

    CreateSection([TLMDRichEditNew, TLMDRichEditLoad, TLMDRichEditSave]);
    CreateSection([TLMDRichEditPrint, TLMDRichEditPreview]);
    CreateSection([TLMDRichEditCut, TLMDRichEditCopy, TLMDRichEditPaste]);
    CreateSection([TLMDRichEditUndo, TLMDRichEditRedo]);
    CreateSection([TLMDRichEditTextAttributes]);
    CreateSection([TLMDRichEditTextBold, TLMDRichEditTextItalic, TLMDRichEditTextUnderline]);
    CreateSection([TLMDRichEditTextSubscript, TLMDRichEditTextSuperscript], True);
    CreateSection([TLMDRichEditParaAlignLeft, TLMDRichEditParaAlignCenter,
                  TLMDRichEditParaAlignRight], True);
    CreateSection([TLMDRichEditNumberingBullet, TLMDRichEditNumberingArabicNumbers],
      True);
    CreateSection([TLMDRichEditIndent, TLMDRichEditUnindent]);
  end;
  {------------------------------------------------------------------------------}

  var
    ActionManager: TActionManager;

  procedure CreateActionBar;
  var
//    ActionManager: TActionManager;
    ActionToolBar: TActionToolBar;
    ActionBarItem: TActionBarItem;
//  CustomAction: TCustomAction;
    ActionClientItem: TActionClientItem;

    function CreateActionButton(D: TLMDRTFActionDescriptor;
        const Category: String): TActionClientItem;
      var
        CustomAction: TCustomAction;
    begin
//      Application.ProcessMessages;
      CustomAction := D.CreateAction(Component.Owner);
//      aAction.Create(Component.Owner);
      CustomAction.Name := GenerateActionName(CustomAction);
//      CustomAction.ImageIndex := ImageIndex;
      CustomAction.ActionList := ActionManager;
      CustomAction.Category := Category;

      Result := ActionBarItem.Items.Add;
      Result.Action := CustomAction;
      Result.ShowCaption := False;
    end;

    {------------------------------------------------------------------------------}
    procedure CreateActionSeparator;
    begin
      ActionClientItem := ActionBarItem.Items.Add;
      ActionClientItem.Caption := '-';
      ActionClientItem.Visible := True;
    end;

    procedure CreateSection(const Actions: array of TLMDRichEditActionClass;
        const Category: string;
        Groupped: Boolean = False);
      var
        i, j: integer;
        S: Boolean;
        aCls: TLMDRichEditActionClass;
        D: TLMDRTFActionDescriptor;
        LI: TListItem;
    begin
      S := False;

      for i := Low(Actions) to High(Actions) do
        begin
          aCls := Actions[i];
          D := nil;

          for j := 0 to TOF.CheckListBox.Items.Count - 1 do
            begin
              LI := TOF.CheckListBox.Items[j];
              if Assigned(LI.Data)
                  and (TLMDRTFActionDescriptor(LI.Data).Cls = aCls) then
                begin
                  if LI.Checked then
                  D := LI.Data;
                  Break;
                end;
            end;

          if  Assigned(D) then
            begin
              if  not S and (ActionBarItem.Items.Count > 0) then
                CreateActionSeparator;

              S := True;
              ActionClientItem := CreateActionButton(D, Category);//, Groupped);
{
              if  Groupped  then
                begin
                  Btn.Grouped := True;
                  Btn.AllowAllUp := True;
                end;
}
            end;
        end;
    end;

  begin
    ActionManager := TActionManager.Create(Component.Owner);
    ActionManager.Name := GenerateComponentName('ActionManager');
    ActionManager.Images := IL;

    ActionToolBar := TActionToolBar.Create(Owner);
    ActionToolBar.Name := GenerateComponentName('ActionToolBar');
    ActionToolBar.ShowHint := True;
    ActionToolBar.Left := 0;
    ActionToolBar.Top := TControl(Component).Top - 1;
    ActionToolBar.Width := TWinControl(Component).Parent.Width - 8;
    ActionToolBar.Height := 29;
    ActionToolBar.Align := alTop;
    ActionToolBar.Parent := TWinControl(Component).Parent;
    ActionToolBar.Caption := 'RichEdit ActionToolBar';

    {$IFDEF LMDCOMP7}
    ActionToolBar.ColorMap.HighlightColor := 15660791;
    ActionToolBar.ColorMap.BtnSelectedColor := clBtnFace;
    ActionToolBar.ColorMap.UnusedColor := 15660791;
    {$ENDIF}

    ActionToolBar.Spacing := 0;

    ActionToolBar.ActionManager := ActionManager;
    ActionToolBar.Align := alBottom;
    ActionToolBar.Align := alTop;

    ActionBarItem := ActionManager.ActionBars.Add;
    ActionBarItem.ActionBar := ActionToolBar;

    CreateSection([TLMDRichEditNew, TLMDRichEditLoad, TLMDRichEditSave], IDRTF_AC_FILE);
    CreateSection([TLMDRichEditPrint, TLMDRichEditPreview], IDRTF_AC_FILE);
    CreateSection([TLMDRichEditCut, TLMDRichEditCopy, TLMDRichEditPaste],
      IDRTF_AC_EDIT);
    CreateSection([TLMDRichEditUndo, TLMDRichEditRedo], IDRTF_AC_EDIT);
    CreateSection([TLMDRichEditTextAttributes], IDRTF_AC_FORMAT);
    CreateSection([TLMDRichEditTextBold, TLMDRichEditTextItalic,
      TLMDRichEditTextUnderline], IDRTF_AC_FORMAT);
    CreateSection([TLMDRichEditTextSubscript, TLMDRichEditTextSuperscript],
      IDRTF_AC_FORMAT, True);
    CreateSection([TLMDRichEditParaAlignLeft, TLMDRichEditParaAlignCenter,
                  TLMDRichEditParaAlignRight], IDRTF_AC_FORMAT, True);
    CreateSection([TLMDRichEditNumberingBullet, TLMDRichEditNumberingArabicNumbers],
      IDRTF_AC_FORMAT, True);
    CreateSection([TLMDRichEditIndent, TLMDRichEditUnindent], IDRTF_AC_FORMAT);
(*
    if TOF.CheckListBox.Checked[0] then
     CreateActionButton(TLMDRichEditNew, 'File', 0);
    if TOF.CheckListBox.Checked[1] then
     CreateActionButton(TLMDRichEditLoad, 'File', 1);
    if TOF.CheckListBox.Checked[2] then
     CreateActionButton(TLMDRichEditSave, 'File', 2);
    CreateActionSeparator;
    if TOF.CheckListBox.Checked[3] then
     CreateActionButton(TLMDRichEditPrint, 'File', 3);
    if TOF.CheckListBox.Checked[4] then
     CreateActionButton(TLMDRichEditPreview, 'File', 4);
    CreateActionSeparator;
    if TOF.CheckListBox.Checked[5] then
     CreateActionButton(TLMDRichEditFind, 'Edit', 24);
    CreateActionSeparator;
    if TOF.CheckListBox.Checked[6] then
     CreateActionButton(TLMDRichEditCut, 'Edit', 5);
    if TOF.CheckListBox.Checked[7] then
     CreateActionButton(TLMDRichEditCopy, 'Edit', 6);
    if TOF.CheckListBox.Checked[8] then
    CreateActionButton(TLMDRichEditPaste, 'Edit', 7);
    CreateActionSeparator;
    if TOF.CheckListBox.Checked[9] then
     CreateActionButton(TLMDRichEditUndo, 'Edit', 8);
    if TOF.CheckListBox.Checked[10] then
     CreateActionButton(TLMDRichEditRedo, 'Edit', 9);
    CreateActionSeparator;
    if TOF.CheckListBox.Checked[11] then
     CreateActionButton(TLMDRichEditTextAttributes, 'Format', 23);
    CreateActionSeparator;
    if TOF.CheckListBox.Checked[12] then
     CreateActionButton(TLMDRichEditTextBold, 'Format', 10);
    if TOF.CheckListBox.Checked[13] then
     CreateActionButton(TLMDRichEditTextItalic, 'Format', 11);
    if TOF.CheckListBox.Checked[14] then
     CreateActionButton(TLMDRichEditTextUnderline, 'Format', 12);
    CreateActionSeparator;
    if TOF.CheckListBox.Checked[15] then
     CreateActionButton(TLMDRichEditTextSubscript, 'Format', 13);
    if TOF.CheckListBox.Checked[16] then
     CreateActionButton(TLMDRichEditTextSuperscript, 'Format', 14);
    CreateActionSeparator;
    if TOF.CheckListBox.Checked[17] then
     TLMDRichEditParaAlign(CreateActionButton(TLMDRichEditParaAlign,
      'Format', 15).Action).Alignment:= paLeftJustify;
    if TOF.CheckListBox.Checked[18] then
     TLMDRichEditParaAlign(CreateActionButton(TLMDRichEditParaAlign,
      'Format', 16).Action).Alignment:= paCenter;
    if TOF.CheckListBox.Checked[19] then
     TLMDRichEditParaAlign(CreateActionButton(TLMDRichEditParaAlign,
      'Format', 17).Action).Alignment:= paRightJustify;

    CreateActionSeparator;
    if TOF.CheckListBox.Checked[20] then
     TLMDRichEditNumbering(CreateActionButton(TLMDRichEditNumbering,
      'Format', 19).Action).Numbering := TLMDNumbering(nsBullet);
    if TOF.CheckListBox.Checked[21] then
     TLMDRichEditNumbering(CreateActionButton(TLMDRichEditNumbering,
      'Format', 20).Action).Numbering := nsArabicNumbers;

    if TOF.CheckListBox.Checked[22] then
     CreateActionButton(TLMDRichEditIndent, 'Format', 21);
    if TOF.CheckListBox.Checked[23] then
     CreateActionButton(TLMDRichEditUnindent, 'Format', 22);
*)
  end;

  {------------------------------------------------------------------------------}
  procedure CreateMenuBar;
  var
    {$IFDEF LMDCOMP7}
    ACI: TActionClientItem;
    i: integer;
    {$ENDIF}
    ActionMainMenuBar: TActionMainMenuBar;
    ActionBarItem: TActionBarItem;
    ActionClientItem: TActionClientItem;

  begin
    ActionMainMenuBar := TActionMainMenuBar.Create(Component.Owner);
    ActionMainMenuBar.Name := GenerateComponentName('ActionMainMenuBar');
    ActionMainMenuBar.Parent := TForm(Component.Owner);
    ActionMainMenuBar.ActionManager := ActionManager;
    ActionMainMenuBar.Left := 0;
    ActionMainMenuBar.Top := 26;
    ActionMainMenuBar.Width := TForm(Component.Owner).Width - 8;
    ActionMainMenuBar.Height := 24;
    ActionMainMenuBar.Caption := ActionMainMenuBar.Name;
    {$IFDEF LMDCOMP7}
    ActionMainMenuBar.ColorMap.HighlightColor := 15660791;
    ActionMainMenuBar.ColorMap.BtnSelectedColor := clBtnFace;
    ActionMainMenuBar.ColorMap.UnusedColor := 15660791;
    {$ENDIF}
    ActionMainMenuBar.Font.Charset := DEFAULT_CHARSET;
    ActionMainMenuBar.Font.Color := clMenuText;
    ActionMainMenuBar.Font.Height := -11;
    ActionMainMenuBar.Font.Name := 'Tahoma';
    ActionMainMenuBar.Font.Style := [];
    ActionMainMenuBar.Spacing := 0;

    ActionBarItem := ActionManager.ActionBars.Add;
    ActionBarItem.ActionBar := ActionMainMenuBar;

    ActionClientItem := ActionBarItem.Items.Add;
    ActionClientItem.Caption := 'File';

    {$IFDEF LMDCOMP7}
    ACI := ActionManager.AddCategory('Format', ActionClientItem);

    for i := 0 to ACI.Items.Count - 1 do
     if (ACI.Items[i].Caption = '&Font...') or
        (ACI.Items[i].Caption = '&Underline') or
        (ACI.Items[i].Caption = 'Su&perscript') or
        (ACI.Items[i].Caption = 'Ali&gn') then
         ActionManager.AddSeparator(ACI.Items[i]);

    ACI := ActionManager.AddCategory('Edit', ActionClientItem);

    for i := 0 to ACI.Items.Count - 1 do
     if (ACI.Items[i].Caption = '&Find...') or
        (ACI.Items[i].Caption = '&Paste') then
         ActionManager.AddSeparator(ACI.Items[i]);

    ACI := ActionManager.AddCategory('File', ActionClientItem);

    for i := 0 to ACI.Items.Count - 1 do
     if (ACI.Items[i].Caption = '&Save') then
         ActionManager.AddSeparator(ACI.Items[i]);
    {$ENDIF IFDEF LMDCOMP7}

    ActionClientItem.Free;
  end;

  var
    ILt: TCustomImageList;
    i: integer;

begin
  if not Assigned(Component) or not (Component is TControl)
    or not Assigned(TControl(Component).Parent) or
    not Assigned(Component.Owner) then Exit;

  TOF := TToolbarOptionsForm.Create(Application);
  try
    if TOF.ShowModal <> mrOK then exit;

    Owner := Component.Owner;
    IL := TOF.CheckListBox.SmallImages;
    TOF.CheckListBox.SmallImages := nil;
    ILt := nil;

    for i := 0 to Owner.ComponentCount - 1 do
      if  Owner.Components[i] is TImageList then
        begin
          if  IsEqualImageList(IL, TImageList(Owner.Components[i])) then
            begin
              ILt := TImageList(Owner.Components[i]);
              Break;
            end;
        end;

    if  Assigned(ILt) then
      IL := ILt
    else
      begin
        IL.Name:= '';

        if  IL.Owner <> nil then
          IL.Owner.RemoveComponent(IL);

        Owner.InsertComponent(IL);
        IL.Name:= GenerateComponentName('ImageList');
      end;
{
    IL:= TImageList.Create( Component.Owner);
    IL.Name:= GenerateComponentName('ImageList');
    IL.Width:= 16;
    IL.Height:= 16;
    IL.ResInstLoad( hInstance, rtBitmap, 'LMDRTFTOOLIMAGES', clFuchsia);
}
    if TOF.ToolBarRadioButton.Checked then
     CreateToolBar
    else
     CreateActionBar;

    if TOF.MenuBarCheckBox.Checked then
     CreateMenuBar;
   finally
     TOF.Release;
   end;
end;

end.
