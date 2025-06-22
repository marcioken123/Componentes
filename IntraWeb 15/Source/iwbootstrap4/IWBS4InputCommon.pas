unit IWBS4InputCommon;

interface

uses
  Classes, SysUtils, SyncObjs, Controls, IWHTMLTag, IWBS4Region, IWBS4InputForm,
  IWBS4ButtonGroup, IWBS4InputTypes;

function IWBS4CreateFormGroup(AParent: TControl; AParentForm: TIWBS4InputForm; ATag: TIWHTMLTag; const AHTMLName: string; ASpanDiv: Boolean): TIWHTMLTag;

function IWBS4CreateInputFormGroup(AControl, AParent: TControl; ATag: TIWHTMLTag; const ACaption, AHTMLName: string): TIWHTMLTag;

function IWBS4CreateCheckBoxFormGroup(AParent: TControl; ATag: TIWHTMLTag; const ACss, ACaption, AHint, AHTMLName: string; AShowHint: Boolean): TIWHTMLTag;

function IWBS4CreateInputGroupAddOn(ATag: TIWHTMLTag; const AHTMLName, ACss: string): TIWHTMLTag;

implementation

uses
  IWBaseHTMLControl;
{$region 'FormGroup functions'}
function IWBS4CreateFormGroup(AParent: TControl; AParentForm: TIWBS4InputForm; ATag: TIWHTMLTag; const AHTMLName: string; ASpanDiv: Boolean): TIWHTMLTag;
(*var
  LSpanDiv: TIWHTMLTag;*)
begin
  if (AParentForm <> nil) and not ((AParent is TIWBS4Region) and (TIWBS4Region(AParent).BSRegionType = bs4rtFormGroup)) and not (AParent is TIWBS4ButtonGroup) then
  begin
    Result := TIWHTMLTag.CreateTag('div');
    Result.AddClassParam('form-group');
    Result.AddStringParam('id', AHTMLName + '_FG');
  (*if ASpanDiv and (AParentForm.BSFormType = bs4ftHorizontal) then
    begin
      LSpanDiv := Result.Contents.AddTag('div');
      LSpanDiv.AddClassParam(AParentForm.BSFormOptions.GetOffsetClassString);
      LSpanDiv.Contents.AddTagAsObject(aTag);
    end else
    begin*)
    Result.Contents.AddTagAsObject(ATag);
  (*end;*)
  end
  else
  begin
    Result := ATag;
  end;
end;

function IWBS4CreateInputFormGroup(AControl, AParent: TControl; ATag: TIWHTMLTag; const ACaption, AHTMLName: string): TIWHTMLTag;
var
  lablTag(*, editTag*): TIWHTMLTag;
  InputForm: TIWBS4InputForm;
begin
  InputForm := IWBS4FindParentInputForm(AParent);
  if ACaption <> '' then
  begin
    Result := TIWHTMLTag.CreateTag('div');
    try
      Result.AddClassParam('form-group');
      Result.AddStringParam('id', AHTMLName + '_FG');
      lablTag := Result.Contents.AddTag('label');
      lablTag.AddClassParam('control-label');
      lablTag.AddStringParam('for', AHTMLName);
      lablTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ACaption));
    (*if (InputForm <> nil) and (InputForm.BSFormType = bs4ftHorizontal) then
      begin
        lablTag.AddClassParam(InputForm.BSFormOptions.CaptionsSize.GetClassString);
        editTag := Result.Contents.AddTag('div');
        editTag.AddClassParam(InputForm.BSFormOptions.InputsSize.GetClassString);
        editTag.Contents.AddTagAsObject(aTag);
      end else
      begin*)
      Result.Contents.AddTagAsObject(ATag);
    (*end;*)
    except
      FreeAndNil(Result);
      FreeAndNil(ATag);
      raise;
    end;
  end
  else
  begin
    Result := IWBS4CreateFormGroup(AParent, InputForm, ATag, AHTMLName, True);
  end;
end;

function IWBS4CreateCheckBoxFormGroup(AParent: TControl; ATag: TIWHTMLTag; const ACss, ACaption, AHint, AHTMLName: string; AShowHint: Boolean): TIWHTMLTag;
var
  lablTag: TIWHTMLTag;
  InputForm: TIWBS4InputForm;
begin
  InputForm := IWBS4FindParentInputForm(AParent);
  Result := TIWHTMLTag.CreateTag('div');
  try
    lablTag := Result.Contents.AddTag('label');
    if SameText(ACss, 'radio') then
    begin
      Result.AddStringParam('id', AHTMLName);
      Result.AddStringParam('data-type', 'IWRADIOBUTTON');
      lablTag.AddStringParam('for', AHTMLName + '_INPUT');
    end
    else
    begin
      Result.AddStringParam('id', AHTMLName + '_DIV');
      lablTag.AddStringParam('for', AHTMLName);
    end;
    if (InputForm <> nil) and (InputForm.BSFormType = bs4ftInline) then
      Result.AddClassParam(ACss + '-inline')
    else
      Result.AddClassParam(ACss);
    //if (InputForm <> nil) and (InputForm.BSFormType = bsftHorizontal) then
    //  Result.AddClassParam(InputForm.BSFormOptions.GetOffsetClassString);
    if AShowHint and (AHint <> '') then
      lablTag.AddStringParam('title', AHint);
    lablTag.Contents.AddTagAsObject(ATag);
    lablTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ACaption));

    Result := IWBS4CreateFormGroup(AParent, InputForm, Result, AHTMLName, False);
  except
    FreeAndNil(Result);
    FreeAndNil(ATag);
    raise;
  end;
end;
{$endregion}

{$region 'InputGroup functions'}

function IWBS4CreateInputGroupAddOn(ATag: TIWHTMLTag; const AHTMLName, ACss: string): TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('span');
  try
    Result.AddClassParam('input-group-' + ACss);
    Result.Contents.AddTagAsObject(ATag);
  except
    FreeAndNil(Result);
    FreeAndNil(ATag);
    raise;
  end;
end;
{$endregion}

end.

