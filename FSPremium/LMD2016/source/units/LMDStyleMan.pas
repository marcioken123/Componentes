unit LMDStyleMan;
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

LMDStyleMan unit - Core Library (VB)
--------------------------------------------
Description

ToDo
----
* Clean up and test, optimize for speed


Release 8.0 (July 2006)

* Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Messages, Graphics, ImgList, Controls, Forms, StdCtrls,
  TypInfo, SysUtils, LMDIniCtrl,
  LMDCustomComponent, LMDBaseController, LMDProcs, LMDStrings, LMDCFCStateObject;

const sDefaultStyleName = '(Default)';
      sTempStyleName    = '...Temp';
      AncestorDelim     = '|';
      TypeNameDelim     = ':';
      StylePrefix       = '.';
      StyleKindStringID = '_StyleKind';
      StateStyleNames: array[TLMDStateKind] of string = ('.focused', '.hot', '.pressed', '.modified', '.readonly', '.wrongdata', '.disabled');

type
  TLMDStyleManager = class;

  TLMDStyleManager = class(TLMDBaseController)
  private
  protected
    FStyleNames  : TStringList;
    FStyles      : TLMDIniCtrl;
    FUpdateCount : integer;
    FUsesList,
    FValues      : TStringList;

    procedure TriggerChange; virtual;
    procedure DoApplyStyle(AComponent : TComponent; StyleName : string);
    procedure WriteStyle(Stream: TStream);
    procedure ReadStyle(Stream: TStream);
    procedure DefineProperties(Filer : TFiler); override;
    procedure Loaded; override;
    procedure AssignTo(Dest : TPersistent); override;
  public
    procedure ApplyStyle(AComponent : TComponent; AStyleNameQualifier: string;
      ACascadeStyles: boolean = true; AStateStyleName: string = '');
    procedure BeginUpdate;
    procedure Clear;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure EndUpdate;
    procedure LoadFromFile(FileName: string);
    procedure LoadFromStream(Stream : TStream);
    procedure SaveToFile(FileName: string);
    procedure SaveToStream(Stream : TStream);

    //style content handling routines
    procedure EraseProperty(AStyleName, APropName, ATypeName : string);
    procedure EraseStyle(AStyleName: string);
    procedure GetStyleNames(SL : TStrings);
    procedure GetProperties(AStyleName : string; APropNames : TStrings);
    function  IsStateStyle(AStyleName: string): boolean;
    function  IsValidStyleName(AStyleName: string): boolean;
    function  PropValueExists(AStyleName, APropName, ATypeName : string): boolean;
    procedure RenameStyle(AOldName, ANewName: string);
    procedure ReadPropValue(AStyleName, APropName, ATypeName : string; var AValue: integer); overload;
    procedure ReadPropValue(AStyleName, APropName, ATypeName : string; var AValue: double); overload;
    procedure ReadPropValue(AStyleName, APropName, ATypeName : string; var AValue: string); overload;
    procedure ReadPropValue(AStyleName, APropName, ATypeName : string; var AValue: TMemoryStream); overload;
    procedure WritePropValue(AStyleName, APropName, ATypeName : string; AValue: integer); overload;
    procedure WritePropValue(AStyleName, APropName, ATypeName : string; AValue: double); overload;
    procedure WritePropValue(AStyleName, APropName, ATypeName : string; AValue: string); overload;
    procedure WritePropValue(AStyleName, APropName, ATypeName : string; AValue: TStream); overload;
  published
  end;

implementation

uses
  LMDObject, LMDControl, LMDTypes;

constructor TLMDStyleManager.Create(AOwner : TComponent);
begin
  inherited;
  FUsesList := TStringList.Create;
  FValues := TStringList.Create;
  FStyles := TLMDIniCtrl.Create(Self);
  FStyles.IniPrefix := ppProgram;
  FStyles.Target := itMemIniFile;
  FStyleNames := TStringList.Create;
  FStyleNames.Sorted := true;
end;

procedure TLMDStyleManager.BeginUpdate;
begin
  inc(FUpdateCount);
end;

procedure TLMDStyleManager.EndUpdate;
begin
  dec(FUpdateCount);
  if FUpdateCount = 0 then
    TriggerChange;
end;

procedure TLMDStyleManager.TriggerChange;
var
  i: integer;
begin
  if not (csLoading in ComponentState) then
    begin
      Change;
      GetStyleNames(FStyleNames);
      //State styles are not needed in FStyleNames list
      for i := FStyleNames.Count - 1 downto 0 do
        if IsStateStyle(FStyleNames[i]) then
          FStyleNames.Delete(i);
    end;
end;

destructor TLMDStyleManager.Destroy;
begin
  FreeAndNil(FStyleNames);
  FreeAndNil(FUsesList);
  FreeAndNil(FValues);
  FStyles.Clear;
  FreeAndNil(FStyles);
  inherited;
end;

procedure TLMDStyleManager.ApplyStyle(AComponent: TComponent; AStyleNameQualifier: string; ACascadeStyles: boolean = true; AStateStyleName: string = '');
var
  s, lStyle: string;
  len, i, j, L, n, k: integer;
  cl: TClass;
  lStyleFound: boolean;

  procedure CopyStyleInfo(CopyFrom, CopyTo : string);
  var
    Ancestor : string;
    LValues  : TStringList;
    i: integer;
  begin
    Ancestor := LMDAnsiGetRightTrimmedString(CopyFrom, AncestorDelim);
    if Ancestor = CopyFrom then
      Ancestor := sDefaultStyleName;

    if Ancestor <> CopyFrom then
    begin
      if FUsesList.IndexOf(Ancestor) = -1 then
      begin
        FUsesList.Add(Ancestor);
        CopyStyleInfo(Ancestor, CopyTo);
      end
      else
        Ancestor := '';
    end;
    LValues := TStringList.Create;
    FStyles.ReadSectionValues(CopyFrom, LValues);
    for i:=0 to LValues.Count - 1 do
      FStyles.WriteString(CopyTo, LValues.Names[i], LValues.Values[LValues.Names[i]]);
    LValues.Clear;
    LValues.Free;
  end;

begin
  if not ACascadeStyles then
    begin
      DoApplyStyle(AComponent, AStyleNameQualifier);
      exit;
    end;
  FStyles.EraseSection(sTempStyleName);
  lStyle := AStyleNameQualifier;
  n := LMDAnsiCount(lStyle, StylePrefix);
  //lIsDefControlStyle := (LMDAnsiCount(AStyleNameQualifier, StylePrefix) = 0)
  //  and (LMDAnsiCount(AStyleNameQualifier, AncestorDelim) = 0);
  len := length(AStyleNameQualifier);
  i := FStyleNames.IndexOf(AStyleNameQualifier);
  if (i >= 0) then
    begin
      //This part handles styles like ".red|TLMDEdit", i.e. specific style is used to group component styles
      j := i;
      while (i < FStyleNames.Count) and (Copy(FStyleNames[i],1,len) = AStyleNameQualifier) do
        begin
          s := Copy(FStyleNames[i], len + 2, length(FStyleNames[i]));
          if (s='') or (Pos(StylePrefix, s) > 0) then
            begin
              inc(i);
              continue;
            end;
          if Pos(AComponent.ClassName, s) > 0 then
            begin
              j := i;
              break;
            end;
          cl := AComponent.ClassParent;
          while cl <> TControl do
            begin
              if Pos(cl.ClassName, s) > 0 then
                j := i;
              cl := cl.ClassParent;
            end;
          inc(i);
        end;
      lStyle := FStyleNames[j];
    end
  else
  //if not lIsDefControlStyle or (lStyle = '') then
    begin
      cl := AComponent.ClassType;
      while cl <> TControl do
        begin
          L := length(cl.ClassName);
          //<--
          i := -1;
          for k := FStyleNames.Count -1 downto 0 do
            begin
              j := Length(FStyleNames[k]) - L;
              if j < 1 then
                j := 1;
              s := Copy(FStyleNames[k], j + 1, j + L);
              if Pos(AncestorDelim, s) > 0 then
                continue;
              if s = cl.ClassName then
                begin
                  i := k;
                  break;
                end;
            end;
          //-->
          //i := FStyleNames.IndexOf(cl.ClassName);
          if i < 0 then
            begin
              cl := cl.ClassParent;
              continue;
            end;
          if lStyle = '' then
            begin
              lStyle := FStyleNames[i];
              break;
            end;
          lStyleFound := false;
          s := FStyleNames[i];
          L := length(s);
          while (i < FStyleNames.Count) and (Copy(FStyleNames[i],1,L) = s) do
            begin
              if (Copy(FStyleNames[i], length(FStyleNames[i]) - len + 1, len) = lStyle) and
                (LMDAnsiCount(FStyleNames[i], StylePrefix) = n ) then
                 begin
                   lStyle := FStyleNames[i];
                   lStyleFound := true;
                   break;
                 end;
               inc(i);
            end;
          if lStyleFound then
            break
          else
            cl := cl.ClassParent;
        end
    end;
  FUsesList.Clear;
  if AStateStyleName <> '' then
    lStyle := lStyle + AncestorDelim + AStateStyleName;
  CopyStyleInfo(lStyle, sTempStyleName);

  DoApplyStyle(AComponent, sTempStyleName);
  FStyles.EraseSection(sTempStyleName);
end;

procedure TLMDStyleManager.DoApplyStyle(AComponent : TComponent; StyleName: string);
var i,
    j : integer;

    dv: double;
    s : string;
    CL: TObject;
    Stream : TStream;
    CurObj : TObject;

    PropInfo: PPropInfo;
    PropType,
    PropName,
    ValueName : string;
    LContinueFlag: boolean;

    function IsStringListClass(Info : TLMDTypeInfo) : boolean;
    var
      LTData : TLMDTypeData;
    begin
      LTData := GetTypeData(Info);
      result := (LTData^.ClassType.InheritsFrom(TStrings));
    end;

    function IsImageClass(Info : PTypeInfo) : boolean;
    var
      LTData : TLMDTypeData;
    begin
      LTData := GetTypeData(Info);
      result := (LTData^.ClassType.InheritsFrom(TBitmap)) or (LTData.ClassType.InheritsFrom(TIcon));
    end;

    function IsComponentClass(Info : PTypeInfo) : boolean;
    var
      LTData : TLMDTypeData;
    begin
      LTData := GetTypeData(Info);
      result := (LTData^.ClassType.InheritsFrom(TComponent));
    end;

begin
  if AComponent.InheritsFrom(TLMDObject) then
    TLMDObject(AComponent).BeginUpdate
  else
    if AComponent.InheritsFrom(TLMDBaseCustomControl) then
      TLMDBaseCustomControl(AComponent).BeginUpdate;


  FValues.Clear;
  FStyles.ReadSectionValues(StyleName,FValues);
  for i := 0 to FValues.Count - 1 do
  begin
    ValueName := FValues.Names[i];
    if (ValueName = StyleKindStringID+':integer') then
      continue;
    CurObj := AComponent;

    j := Pos(TypeNameDelim, ValueName);
    if j = 0 then
      begin
        PropName := ValueName;
        PropType := ValueName;
      end
    else
      begin
        PropName := Copy(ValueName, 1, Pred(j));
        PropType := Copy(ValueName, Succ(j), length(ValueName));
      end;

    s := PropName;

    LContinueFlag := false;
    if Pos('.', s) <> 0 then
      repeat
        j := Pos('.', s);
        if j = 0 then
          PropName := s
        else
          begin
            PropName := Copy(s, 1, Pred(j));
            s := Copy(s, Succ(j), length(s));
          end;
        PropInfo := GetPropInfo(CurObj.ClassInfo, PropName);
        if PropInfo = nil then
          begin
            LContinueFlag := true;
            break;
          end;
        if (PropInfo.PropType^.Kind <> tkClass) or (IsComponentClass(PropInfo.PropType^)) then
        begin
            LContinueFlag := true;
            break;
          end;
        PropName := s;
        CurObj := GetObjectProp(CurObj, PropInfo);
      until (Pos('.', s) = 0);

    if LContinueFlag then
      continue;

    PropInfo := GetPropInfo(CurObj.ClassInfo, PropName);
    if PropInfo <> nil then
    begin
      if PropType <> '' then
      begin
        if Uppercase(String(PropInfo.PropType^.Name)) <> Uppercase(PropType) then
          Continue;
      end;

      S := FStyles.ReadString(StyleName, ValueName, '');
      case PropInfo.PropType^.Kind  of
        tkInteger,
        tkEnumeration:
          begin
            if PropInfo.PropType^.Name='TColor' then
              j := StringToColor(S)
            else
              j := FStyles.ReadInteger(StyleName, ValueName, 0);
            SetOrdProp(CurObj, PropInfo, Integer(j));
          end;
        tkFloat:
          begin
            dv := FStyles.ReadFloat(StyleName, ValueName, 0);
            SetFloatProp(CurObj, PropInfo, dv);
          end;
        tkSet:
          begin
            if S = '' then
              S := '[]';
            SetSetProp(CurObj, PropInfo, S)
          end;
        tkChar, tkString, tkLString, tkWString:
          SetStrProp(CurObj, PropInfo, S);
        tkClass:
          if IsImageClass(PropInfo.PropType^) then
            try
              Stream := TMemoryStream.Create;
              FStyles.MemIniFile.ReadBinaryStream(StyleName, ValueName, Stream);
              Stream.Seek(0,soFromBeginning);
              CL := GetObjectProp(CurObj, PropInfo);
              if CL is TBitmap then
                TBitmap(CL).LoadFromStream(Stream)
              else
              if CL is TIcon then
                TIcon(CL).LoadFromStream(Stream)
            finally
              FreeAndNil(Stream);
            end
        end // case
    end // if
  end; // for

  if AComponent.InheritsFrom(TLMDObject) then
    TLMDObject(AComponent).EndUpdate(True)
  else
    if AComponent.InheritsFrom(TLMDBaseCustomControl) then
      TLMDBaseCustomControl(AComponent).EndUpdate(true);
end;

procedure TLMDStyleManager.LoadFromFile;
var
  T: TStream;
begin
  T := nil;
  try
    T := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    LoadFromStream(T);
  finally
    T.Free;
  end;
end;

procedure TLMDStyleManager.SaveToFile;
var
  T: TStream;
begin
  T := nil;
  try
    T := TFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
    SaveToStream(T);
  finally
    T.Free;
  end;
end;

procedure TLMDStyleManager.LoadFromStream(Stream : TStream);
var
  LStrings: TStringList;
begin
  LStrings := TStringList.Create;
  try
    LStrings.LoadFromStream(Stream);
    FStyles.MemIniFile.SetStrings(LStrings);
    TriggerChange;
  finally
    LStrings.Clear;
    LStrings.Free;
  end;
end;

procedure TLMDStyleManager.SaveToStream(Stream : TStream);
var
  LStrings: TStringList;
begin
  LStrings := TStringList.Create;
  try
    FStyles.MemIniFile.GetStrings(LStrings);
    LStrings.SaveToStream(Stream);
  finally
    LStrings.Clear;
    LStrings.Free;
  end;
end;

procedure TLMDStyleManager.WriteStyle(Stream: TStream);
begin
  SaveToStream(Stream);
end;

procedure TLMDStyleManager.ReadStyle(Stream: TStream);
begin
  BeginUpdate;
  LoadFromStream(Stream);
  EndUpdate;
end;

procedure TLMDStyleManager.DefineProperties(Filer : TFiler);
var
  LStrings: TStringList;
begin
  inherited;
  LStrings := TStringList.Create;
  try
    FStyles.MemIniFile.GetStrings(LStrings);
    Filer.DefineBinaryProperty('Style', ReadStyle, WriteStyle, LStrings.Count > 0);
  finally
    LStrings.Clear;
    LStrings.Free;
  end;
end;

procedure TLMDStyleManager.Loaded;
begin
  inherited;
  TriggerChange;
end;

procedure TLMDStyleManager.AssignTo(Dest : TPersistent);
var
  Stream: TMemoryStream;
begin
  if Dest is TLMDStyleManager then
  begin
    TLMDStyleManager(Dest).BeginUpdate;
    try
      Stream := TMemoryStream.Create;
      try
        SaveToStream(Stream);
        Stream.Position := 0;
        TLMDStyleManager(Dest).LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    finally
      TLMDStyleManager(Dest).EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TLMDStyleManager.Clear;
begin
  FStyles.Clear;
end;

procedure TLMDStyleManager.GetStyleNames(SL : TStrings);
begin
  FStyles.MemIniFile.ReadSections(SL);
end;

procedure TLMDStyleManager.GetProperties(AStyleName : string; APropNames :
    TStrings);
var
  LProps : TStringList;
  i      : integer;
begin
  LProps := TStringList.Create;
  try
    FStyles.ReadSection(AStyleName,LProps);
    APropNames.Clear;
    for i := 0 to LProps.Count - 1 do
      APropNames.Add(LProps[i]);
  finally
    LProps.Clear;
    LProps.Free;
  end;
end;

function TLMDStyleManager.IsStateStyle(AStyleName: string): boolean;
var
  LStyleId: TLMDStateKind;
begin
  AStyleName := lowercase(AStyleName);
  result := false;
  for LStyleID := low(TLMDStateKind) to high(TLMDStateKind) do
    if Pos(StateStyleNames[LStyleID],AStyleName) > 0 then
      begin
        result := true;
        break;
      end;
end;

function TLMDStyleManager.IsValidStyleName(AStyleName: string): boolean;
begin
  result := not ((AStyleName = '') or (AStyleName = StylePrefix) or
    (Pos(AncestorDelim, AStyleName)>0));
end;

procedure TLMDStyleManager.RenameStyle(AOldName, ANewName: string);
var
  i, len: integer;
  LSl: TStringList;
  s1, s2: string;
begin
  LSl := TStringList.Create;
  try
    FStyles.MemIniFile.ReadSections(LSl);
    len := length(AOldName);
    for i := 0 to LSl.Count - 1 do
      begin
        if (LSl[i] = sDefaultStyleName) then
          continue;
        s1 := Copy(LSl[i], 1, len);
        s2 := Copy(LSl[i], len + 1, length(LSl[i]));
        if s1 = AOldName then
          begin
            s1 := ANewName + s2;
            FStyles.MemIniFile.RenameSection(LSl[i], s1);
          end
      end
  finally
    LSl.Clear;
    LSl.Free;
  end
end;

procedure TLMDStyleManager.EraseProperty(AStyleName, APropName,
  ATypeName: string);
begin
  FStyles.MemIniFile.DeleteKey(AStyleName, APropName + TypeNameDelim + ATypeName);
end;

procedure TLMDStyleManager.EraseStyle(AStyleName: string);
var
  i, len: integer;
  LSl: TStringList;
  s1: string;
begin
  LSl := TStringList.Create;
  try
    FStyles.MemIniFile.ReadSections(LSl);
    len := length(AStyleName);
    for i := 0 to LSl.Count - 1 do
      begin
        if (LSl[i] = sDefaultStyleName) then
          continue;
        s1 := Copy(LSl[i], 1, len);
        if s1 = AStyleName then
          FStyles.MemIniFile.EraseSection(LSl[i]);
      end
  finally
    LSl.Clear;
    LSl.Free;
  end
end;

procedure TLMDStyleManager.WritePropValue(AStyleName, APropName,
  ATypeName: string; AValue: integer);
var
  LEntryName: string;
begin
  LEntryName := APropName + TypeNameDelim + ATypeName;
  if ATypeName = 'TColor' then
    FStyles.WriteColor(AStyleName, LEntryName, AValue)
  else
    FStyles.WriteInteger(AStyleName, LEntryName, AValue);
  TriggerChange;
end;

procedure TLMDStyleManager.WritePropValue(AStyleName, APropName,
  ATypeName: string; AValue: double);
var
  LEntryName: string;
begin
  LEntryName := APropName + TypeNameDelim + ATypeName;
  if ATypeName = 'TDateTime' then
    FStyles.WriteDateTime(AStyleName, LEntryName, AValue)
  else
    FStyles.WriteFloat(AStyleName, LEntryName, AValue);
  TriggerChange;
end;

procedure TLMDStyleManager.WritePropValue(AStyleName, APropName, ATypeName,
  AValue: string);
var
  LEntryName: string;
begin
  LEntryName := APropName + TypeNameDelim + ATypeName;
  FStyles.WriteString(AStyleName, LEntryName, AValue);
  TriggerChange;
end;

procedure TLMDStyleManager.WritePropValue(AStyleName, APropName,
  ATypeName: string; AValue: TStream);
var
  LEntryName: string;
begin
  LEntryName := APropName + TypeNameDelim + ATypeName;
  FStyles.MemIniFile.WriteBinaryStream(AStyleName, LEntryName, AValue);
  TriggerChange;
end;

procedure TLMDStyleManager.ReadPropValue(AStyleName, APropName,
  ATypeName: string; var AValue: double);
var
  LEntryName: string;
begin
  LEntryName := APropName + TypeNameDelim + ATypeName;
  if ATypeName='TDateTime' then
    AValue := FStyles.ReadDateTime(AStyleName, LEntryName, 0)
  else
    AValue := FStyles.ReadFloat(AStyleName, LEntryName, 0);
end;

procedure TLMDStyleManager.ReadPropValue(AStyleName, APropName,
  ATypeName: string; var AValue: integer);
var
  LEntryName: string;
begin
  LEntryName := APropName + TypeNameDelim + ATypeName;
  if ATypeName = 'TColor' then
    AValue := FStyles.ReadColor(AStyleName, LEntryName, 0)
  else
    AValue := FStyles.ReadInteger(AStyleName, LEntryName, 0);
end;

procedure TLMDStyleManager.ReadPropValue(AStyleName, APropName,
  ATypeName: string; var AValue: TMemoryStream);
var
  LEntryName: string;
begin
  LEntryName := APropName + TypeNameDelim + ATypeName;
  FStyles.MemIniFile.ReadBinaryStream(AStyleName, LEntryName, AValue);
end;

procedure TLMDStyleManager.ReadPropValue(AStyleName, APropName,
  ATypeName: string; var AValue: string);
var
  LEntryName: string;
begin
  LEntryName := APropName + TypeNameDelim + ATypeName;
  AValue := FStyles.ReadString(AStyleName, LEntryName, '');
end;

function TLMDStyleManager.PropValueExists(AStyleName, APropName,
  ATypeName: string): boolean;
begin
  result := FStyles.MemIniFile.ValueExists(AStyleName,
    APropName + TypeNameDelim + ATypeName);
end;

end.
