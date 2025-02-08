unit LMDCFCSettingObject;
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

LMDCFCSettingObject unit (JH)
-----------------------------
Stores any kind of TPersistent object to a stream

If a new settings object is added, changes as follows are necessary:
[1] Update CreateCFCObject method [2] Update LMDCFCGetSettingstKind

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDObject, Controls, Classes, Graphics;

type

  TLMDCFCSettingObjectKind = (cfcUnknown,     // 0 = invalid
                              cfcFont,        // 1
                              cfcFont3D,      // 2
                              cfcFontFX,      // 3
                              cfcFillObject,  // 4
                              cfcBitmapEffect,// 5
                              cfcBevel,       // 6
                              cfcColor,       // 7
                              cfcCtlSettings, // 8
                              cfcStyle        // 9
                              );

  { ******************** TLMDCFCSettingObjects ********************************}
  TLMDCFCSettingObjects = class(TComponent)
  private
    FList:TStringList;
    function GetCount:Integer;
    function GetItem(index:integer):TPersistent;
    procedure SetItem(Index: Integer; aObject: TPersistent);
    function GetObjName(Index: Integer): String;
    procedure SetObjName(Index: Integer; const Value: String);
    procedure ReadData(Reader:TReader);
    procedure WriteData(Writer:TWriter);
  protected
    //procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy; override;

    procedure Assign(Source:TPersistent);override;
    function Add(aObject: TPersistent; aName:String=''): Integer;overload;
    function Add(aKind: TLMDCFCSettingObjectKind): Integer;overload;

    procedure Clear;
    class procedure CreateCFCObject(aClass:TPersistentClass; var anObject: TPersistent);
    function FindInstanceOf(AClass: TPersistentClass; AExact: Boolean = True; AStartAt: Integer = 0): Integer;

    procedure Insert(Index: Integer; aObject: TPersistent; const aName:String='');

    function IndexOf(const aName:String): Integer;
    function IndexOfObject(aObject: TPersistent): Integer;
    function NameOfObject(aObject: TPersistent):String;

    function Remove(aObject: TPersistent): Integer;
    function UniqueName(const BaseName:String):String;

    // i/o
    procedure SaveToStream(Stream:TStream);
    procedure SaveToFile(const aFilename: string);
    procedure LoadFromStream(Stream:TStream);
    procedure LoadFromFile(const aFilename: string);

    property Count:Integer read GetCount;

    property Items[Index: Integer]: TPersistent read GetItem write SetItem; default;
    property Names[Index: Integer]: String read GetObjName write SetObjName;
  end;

  { ******************** TLMDColorObject **************************************}
  TLMDColorObject=class(TLMDObject)
  private
    FColor: TColor;
    procedure SetColor(const Value: TColor);
  protected
    procedure Change;override;
  public
    constructor Create(AOwner:TPersistent=nil);override;
    procedure Assign(Source:TPersistent);override;
    function GetSetStr : String; override;
  published
    property Color:TColor read FColor write SetColor default clBtnFace;
  end;

  { ******************** TLMDColorObject **************************************}
  TLMDCtlSettings=class(TLMDObject)
  private
    FTransparent: Boolean;
    FCtlXP:Boolean;
    procedure SetBoolean(Index:Integer; const Value: Boolean);
    function GetBoolean(Index:Integer):Boolean;
  protected
    procedure Change;override;
  public
    constructor Create(AOwner:TPersistent=nil);override;
    procedure Assign(Source:TPersistent);override;
    function GetSetStr : String; override;
  published
    property Transparent:Boolean index 0 read GetBoolean write SetBoolean default false;
    property CtlXP:Boolean index 1 read GetBoolean write SetBoolean default True;
  end;

  { ******************** TLMDStyleObject **************************************}
  TLMDStyleObject=class(TLMDObject)
  private
    FStyleName: string;
    procedure SetStyleName(const Value: string);
  protected
    procedure Change;override;
  public
    constructor Create(AOwner:TPersistent=nil);override;
    procedure Assign(Source:TPersistent);override;
    function GetSetStr : String; override;
  published
    property StyleName: string read FStyleName write SetStyleName;
  end;

  // helper methods
  function LMDCFCGetSettingsKindClass(aObject:TPersistentClass):TLMDCFCSettingObjectKind;
  function LMDCFCGetSettingsKindObject(aObject:TPersistent):TLMDCFCSettingObjectKind;
  function LMDCFCGetSettingsClass(aKind:TLMDCFCSettingObjectKind):TPersistentClass;

implementation

uses
  SysUtils, TypInfo,
  LMDProcs, LMDTypes, LMDBevel, LMD3DCaption,LMDFXCaption, LMDFillObject,
  LMDBitmapEffectObject;

{ ---------------------------------------------------------------------------- }
function LMDCFCGetSettingsKindObject(aObject:TPersistent):TLMDCFCSettingObjectKind;
begin
  result:=LMDCFCGetSettingsKindClass(GetClass(aObject.ClassName));
end;
{ ---------------------------------------------------------------------------- }
function LMDCFCGetSettingsKindClass(aObject:TPersistentClass):TLMDCFCSettingObjectKind;

  function checkClass(cClass:TPersistentClass; ctype:TLMDCFCSettingObjectKind; var rtype:TLMDCFCSettingObjectKind):Boolean;
  begin
    result:=aObject=cClass;
    if result then rtype:=cType;
  end;

begin
  result:=cfcUnknown;
  if checkClass(TFont, cfcFont, result) then exit;
  if checkClass(TLMD3DCaption, cfcFont3D, result) then exit;
  if checkClass(TLMDFxCaption, cfcFontFX, result) then exit;
  if checkClass(TLMDBevel, cfcBevel, result) then exit;
  if checkClass(TLMDBitmapEffectObject, cfcBitmapEffect, result) then exit;
  if checkClass(TLMDFillObject, cfcFillObject, result) then exit;
  if checkClass(TLMDColorObject, cfcColor, result) then exit;
  if checkClass(TLMDCtlSettings, cfcCtlSettings, result) then exit;
  if checkClass(TLMDStyleObject, cfcStyle, result) then exit;
end;

{ ---------------------------------------------------------------------------- }
function LMDCFCGetSettingsClass(aKind:TLMDCFCSettingObjectKind):TPersistentClass;
begin
  case aKind of
    cfcFont:result:=TFont;
    cfcFont3D:result:=TLMD3DCaption;
    cfcFontFX:result:=TLMDFxCaption;
    cfcFillObject:result:=TLMDFillObject;
    cfcBitmapEffect:result:=TLMDBitmapEffectObject;
    cfcBevel:result:=TLMDBevel;
    cfcColor:result:=TLMDColorObject;
    cfcCtlSettings:result:=TLMDCtlSettings;
    cfcStyle:result:=TLMDStyleObject;
  else
    result:=nil;
  end;
end;

type
  TWriterHack = class (TWriter)
  public
    procedure WriteProperty(Instance: TPersistent; PropInfo: PPropInfo);
  end;

  { ---------------------------------------------------------------------------- }
  procedure TWriterHack.WriteProperty(Instance: TPersistent; PropInfo: PPropInfo);
  begin
    inherited WriteProperty (Instance, PropInfo);
  end;

type
  TReaderHack = class (TReader)
  public
    procedure ReadProperty(AInstance: TPersistent);
  end;

  { ---------------------------------------------------------------------------- }
  procedure TReaderHack.ReadProperty(AInstance: TPersistent);
  begin
    inherited ReadProperty (AInstance);
  end;

{ ******************** TLMDCFCSettingObjects *************************************}
{----------------------- private ----------------------------------------------}
procedure TLMDCFCSettingObjects.SetItem(Index: Integer; aObject: TPersistent);
begin
  FList.Objects[Index] := aObject;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.SetObjName(Index: Integer; const Value: String);
begin
  if FList.IndexOf(Value)=-1 then
    FList[Index]:=Value
  else
    FList[Index]:=UniqueName(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.GetItem(index: integer): TPersistent;
begin
  Result := TPersistent(FList.Objects[Index]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.GetCount: Integer;
begin
  result:=FList.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.GetObjName(Index: Integer): String;
begin
  result:=FList[Index]
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.ReadData(Reader: TReader);
var
  aObject:TPersistent;
  aReader: TReaderHack;
  aClassName, aObjectName:String;
begin
  aReader := TReaderHack(Reader);
  aReader.ReadListBegin;
  // --------
  while not aReader.EndOfList do
    begin
      aReader.ReadListBegin;
      aClassName:=aReader.ReadString;
      CreateCFCObject(GetClass(aClassName), aObject);
      // read id
      aObjectName:=Reader.ReadString;
      aReader.ReadListEnd;
      Add(aObject, aObjectName);
      aReader.ReadListBegin;
      // --------
      while not aReader.EndOfList do
        aReader.ReadProperty(aObject);
        // --------
      aReader.ReadListEnd;
    end;
  // --------
  aReader.ReadListEnd;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.WriteData(Writer: TWriter);
var
  i, j: Integer;
  aObject:TPersistent;
  PropList:  TLMDPropList;
  PropInfo:  TLMDPropInfo;
  CTypeInfo: TLMDTypeInfo;
  CTypeData: TLMDTypeData;
  aWriter:   TWriterHack;
  s:         Integer;
begin
  aWriter := TWriterHack(Writer);

  aWriter.WriteListBegin;
  //-------
  for i:=0 to FList.Count-1 do
    begin
      aObject:=TPersistent(FList.Objects[i]);
        aWriter.WriteListBegin;
        // write classname first, so that Reader can identify object
        aWriter.WriteString(aObject.ClassName);
        // write Name of object
        aWriter.WriteString(FList[i]);
        aWriter.WriteListEnd;
      // Retrieve class type info
      CTypeInfo:=aObject.ClassInfo;
      // Retrieve class type data - required for access properties of object
      CTypeData:=GetTypeData(CTypeInfo);
      if CTypeData.PropCount>0 then
        begin

          s:=CTypeData.PropCount*SizeOf(Pointer);
          GetMem(PropList, s);

          try

            GetPropInfos(CTypeInfo, PropList);

            aWriter.WriteListBegin;  // mark for loop
            //---
            for j:=0 to CTypeData.PropCount-1 do
              begin
                PropInfo:=PropList[j];
                if IsStoredProp(aObject,PropInfo) then
                  aWriter.WriteProperty(aObject, PropInfo);
                  end;
            // ---
            aWriter.WriteListEnd;
          finally

            FreeMem(PropList, s);

          end;
        end;
    end;
  //-------
  aWriter.WriteListEnd;
end;

{----------------------- protected --------------------------------------------}
class procedure TLMDCFCSettingObjects.CreateCFCObject(aClass:TPersistentClass; var anObject: TPersistent);
begin
  anObject:=nil;
  if aClass=TFont then anObject := TFont.Create;
  if aClass=TLMD3DCaption then anObject := TLMD3DCaption.Create;
  if aClass=TLMDFxCaption then anObject := TLMDFxCaption.Create;
  if aClass=TLMDBevel then anObject := TLMDBevel.Create;
  if aClass=TLMDBitmapEffectObject then anObject := TLMDBitmapEffectObject.Create;
  if aClass=TLMDFillObject then anObject := TLMDFillObject.Create;
  if aClass=TLMDColorObject then anObject := TLMDColorObject.Create;
  if aClass=TLMDCtlSettings then anObject := TLMDCtlSettings.Create;
  if aClass=TLMDStyleObject then anObject := TLMDStyleObject.Create;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Settings', ReadData, WriteData, FList.Count>0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.UniqueName(const BaseName: String): String;
var
  i:Integer;
  tmp:String;
begin
  result:='';i:=0;
  while result='' do
    begin
      tmp:=BaseName+Inttostr(i);
      if FList.IndexOf(tmp)>-1 then
        Inc(i)
      else
        result:=tmp;
    end;
end;

{----------------------- public -----------------------------------------------}
constructor TLMDCFCSettingObjects.Create(aOwner:TComponent);
begin
  inherited;
  FList:=TStringList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCFCSettingObjects.Destroy;
begin
  Clear;
  FreeAndNil(FList);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.Add(aObject: TPersistent; aName:String=''): Integer;
begin
  result:=-1;
  if aObject=nil then exit;
  if aName='' then aName:=UniqueName(aObject.ClassName);
  result:=FList.AddObject(aName, aObject);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.Add(aKind: TLMDCFCSettingObjectKind): Integer;
var
  aSettingObject: TPersistent;
begin
  CreateCFCObject(LMDCFCGetSettingsClass(aKind), aSettingObject);
  result:=Add(aSettingObject);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.Assign(Source: TPersistent);
var
  cr:TPersistentClass;
  aObject:TPersistent;
  i:Integer;
  S: TLMDCFCSettingObjects;
begin
  if (Source is self.ClassType) then
    begin
      Clear;
      S := TLMDCFCSettingObjects(Source);
      FList.Capacity := S.FList.Capacity;
      for i:=0 to S.Count-1 do
        if Assigned(S.Items[i]) then  // create a copy of data
           begin
             cr:=GetClass(S.Items[i].ClassName);
             // unfortunately cr.Create does not call correct constructor of persistent class,
             // therefore helper method
             CreateCFCObject(cr, aObject);
             if Assigned(aObject) then
               aObject.Assign(S.Items[i]);
             Add(aObject, S.Names[i]);
           end
         else
           Add(nil);
      Exit;

    end;
  inherited Assign(Source);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.FindInstanceOf(AClass: TPersistentClass; AExact: Boolean; AStartAt: Integer): Integer;
var
  i:Integer;
begin
  result:=-1;
  for i:=AStartAt to Count-1 do
    if (AExact and (Items[I].ClassType = AClass)) or
       (not AExact and Items[I].InheritsFrom(AClass)) then
      begin
        result:=i;
        break;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.Clear;
begin
  while FList.Count>0 do
    Remove(Items[FList.Count-1]);
  FList.Clear;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.IndexOf(const aName: String): Integer;
begin
  result:=FList.IndexOf(aName);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.IndexOfObject(aObject: TPersistent): Integer;
begin
  Result := FList.IndexOfObject(aObject);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.NameOfObject(aObject: TPersistent):String;
begin
  result:=FList[IndexOfObject(aObject)];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.Insert(Index: Integer; aObject: TPersistent; const aName:String='');
begin
  FList.InsertObject(Index, Name, aObject);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.LoadFromStream(Stream: TStream);
begin
  Stream.ReadComponent(self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCFCSettingObjects.Remove(aObject: TPersistent):Integer;
begin
  result:=IndexOfObject(aObject);
  if result=-1 then exit;
  FreeAndNil(aObject);
  FList.Delete(result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.SaveToStream(Stream: TStream);
begin
  Stream.WriteComponent(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.LoadFromFile(const aFilename: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(aFileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCFCSettingObjects.SaveToFile(const aFilename: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(aFileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

{ ******************** TLMDColorObject ****************************************}
{----------------------- private ----------------------------------------------}
procedure TLMDColorObject.SetColor(const Value: TColor);
begin
  if FColor<>Value then
    begin
      FColor := Value;
      Change;
    end;
end;

{----------------------- protected --------------------------------------------}
procedure TLMDColorObject.Change;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorObject.GetSetStr: String;
begin
  result:=ColorToString(FColor);
end;

{----------------------- public -----------------------------------------------}
constructor TLMDColorObject.Create;
begin
  inherited;
  FColor:=clBtnFace;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorObject.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDColorObject then
    begin
      FColor:=TLMDColorObject(Source).Color;
      Change;
      exit;
    end;
  inherited;
end;

{ **************************** TLMDCtlSettings ********************************}
{----------------------- private ----------------------------------------------}
procedure TLMDCtlSettings.SetBoolean(Index: Integer; const Value: Boolean);
begin
  case Index of
    0: if Value<>FTransparent then FTransparent:=Value else Exit;
    1: if Value<>FCtlXP then FCtlXP:=Value else Exit;
  end;
  Change;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCtlSettings.GetBoolean(Index: Integer): Boolean;
begin
  result:=false;
  case Index of
    0: result:=FTransparent;
    1: result:=FCtlXP;
  end;
end;

{----------------------- protected --------------------------------------------}
procedure TLMDCtlSettings.Change;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCtlSettings.GetSetStr: String;
const
  BoolStr:array[Boolean] of String=('False', 'True');
begin
  result:='Transp.: '+BoolStr[FTransparent]+', CtlXP: '+BoolStr[FCtlXP];
end;

{----------------------- public -----------------------------------------------}
constructor TLMDCtlSettings.Create;
begin
  inherited;
  FCtlXP:=True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCtlSettings.Assign(Source: TPersistent);
begin
  if Source=self then Exit;
  if Source is TLMDCtlSettings then
    begin
      FTransparent:=TLMDCtlSettings(Source).Transparent;
      FCtlXP:=TLMDCtlSettings(Source).CtlXP;
      Change;
      exit;
    end;
  inherited;
end;

{ ******************** TLMDStyleObject  ************************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDStyleObject.Assign(Source: TPersistent);
begin
  if Source=self then Exit;
  if Source is TLMDStyleObject then
    begin
      FStyleName:=TLMDStyleObject(Source).StyleName;
      Change;
      exit;
    end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStyleObject.Change;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDStyleObject.Create;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDStyleObject.GetSetStr: String;
begin
  Result := FStyleName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStyleObject.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    begin
      FStyleName := Value;
      Change;
    end;
end;

initialization
  RegisterClasses([TLMDBevel, TLMD3DCaption, TLMDFXCaption, TLMDFillObject, TFont,
                   TLMDBitmapEffectObject, TLMDColorObject, TLMDCtlSettings, TLMDStyleObject]);
end.
