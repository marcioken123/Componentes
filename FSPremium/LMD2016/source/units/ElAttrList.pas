unit ElAttrList;
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

ElAttrList unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  SysUtils,
  ElInterfaceClasses;

type
  TElAttributeListException = class(Exception);

  IElAttributeList = interface
  ['{47F41D19-EE3C-4E0A-9F06-3CEF29F64000}']
    function GetStrictXML: Boolean;
    procedure SetStrictXML(const Value: Boolean);
    function GetText: String;
    procedure SetText(const Text: String);
    function GetName(const Index: Integer): String;
    function GetValue(const Index: Integer): String;
    procedure SetValue(const Index: Integer; const AValue: String);
    function GetCount: Integer;
    function GetAttribute(const AName: String): String;
    procedure SetAttribute(const AName: String; const AValue: String; Additive: Boolean);
    procedure _SetAttribute(const AName: String; const AValue: String);
    procedure RemoveAttribute(const AName: String);
    procedure Clear;

    property StrictXML: Boolean read GetStrictXML write SetStrictXML;
    property Text: String read GetText write SetText;
    property Names[const Index: Integer]: String read GetName;
    property Values[const Index: Integer]: String read GetValue write SetValue;
    property Count: Integer read GetCount;
    property Attributes[const Name: String]: String read GetAttribute write _SetAttribute;
  end;

  TElAttributeList = class(TInterfacedObject, IElAttributeList)
  private
    FStrictXML: Boolean;
    FNames: TStrings;
    FValues: TStrings;
  protected
    { IElAttributeList }
    function GetStrictXML: Boolean;
    procedure SetStrictXML(const Value: Boolean);
    function GetText: String;
    procedure SetText(const Text: String);
    function GetName(const Index: Integer): String;
    function GetValue(const Index: Integer): String;
    procedure SetValue(const Index: Integer; const AValue: String);
    function GetCount: Integer;
    function GetAttribute(const AName: String): String;
    procedure SetAttribute(const AName: String; const AValue: String; Additive: Boolean);
    procedure _SetAttribute(const AName: String; const AValue: String);
    procedure RemoveAttribute(const AName: String);
    procedure Clear;
  public
    procedure AfterConstruction; override;
    destructor Destroy; override;
  end;

implementation

uses
  ElXmlConsts,
  ElXmlUtils,
  ElStrUtils;

{ TElAttributeList }

procedure TElAttributeList.AfterConstruction;
begin
  inherited;
  FStrictXML := False;
  FNames := TStringList.Create;
  FValues := TStringList.Create;
end;

procedure TElAttributeList.Clear;
begin
  FNames.Clear;
  FValues.Clear;
end;

destructor TElAttributeList.Destroy;
begin
  FNames.Free;
  FValues.Free;
  inherited;
end;

function TElAttributeList.GetAttribute(const AName: String): String;
var
  Index: Integer;
begin
  Index := FNames.IndexOf(AName);
  if Index >= 0 then
  begin
    Result := FValues[Index];
  end
  else
  begin
    Result := '';
  end;
end;

function TElAttributeList.GetCount: Integer;
begin
  Result := FNames.Count;
end;

function TElAttributeList.GetName(const Index: Integer): String;
begin
  Result := FNames[Index];
end;

function TElAttributeList.GetStrictXML: Boolean;
begin
  Result := FStrictXML;
end;

function TElAttributeList.GetText: String;
var
  I: Integer;
  Name: String;
  Value: String;
begin
  Result := '';
  for I := 0 to Pred(FNames.Count) do
  begin
    Name := FNames[I];
    Value := FValues[I];
    if LastDelimiter(XmlWhitespaces, Name) > 0 then
    begin
      Name := '"' + Name + '"';
    end;
    Result := Result + ' ' + Name + '="' + EncodeXmlChars(Value) + '"';
  end;
  Result := Trim(Result);
end;

function TElAttributeList.GetValue(const Index: Integer): String;
begin
  Result := FValues[Index];
end;

procedure TElAttributeList.RemoveAttribute(const AName: String);
var
  Index: Integer;
begin
  Index := FNames.IndexOf(AName);
  if Index >= 0 then
  begin
    FNames.Delete(Index);
    FValues.Delete(Index);
  end;
end;

procedure TElAttributeList.SetAttribute(const AName, AValue: String; Additive: Boolean);
var
  Index: Integer;
  O: String;
  V: String;
begin
  Index := FNames.IndexOf(AName);
  if Index >= 0 then
  begin
    V := AValue;
    if Additive then
    begin
      if V = '' then Exit;
      O := FValues[Index];
      if O <> '' then
      begin
        V := AValue + '; ' + O;
      end;
    end;
    FValues[Index] := V;
  end
  else
  begin
    if FStrictXML and (not IsXmlIdentStr(AName)) then
    begin
      raise TElAttributeListException.CreateFmt(SSayFatalError + SSayFErrAttributeListBadAttrubuteName, [AName]);
    end;
    FNames.Add(AName);
    FValues.Add(AValue);
  end;
end;

procedure TElAttributeList.SetStrictXML(const Value: Boolean);
begin
  FStrictXML := Value;
end;

procedure TElAttributeList.SetText(const Text: String);
var
  I: Integer;
  QuoteChar: Char;
  Name: String;
  Value: String;
begin
  Clear;
  I := 1;

  while I < Length(Text) do
  begin
    if not IsDelimiter(XmlWhitespaces, Text, I) then
    begin
      // parse name
      Name := '';
      while I < Length(Text) do
      begin
        if IsDelimiter('=' + XmlWhitespaces, Text, I) then break;
        Name := Name + Text[I];
        Inc(I);
      end;
      Value := '';
      // skip to '='
      while I < Length(Text) do
      begin
        if Text[I] = '=' then break;
        if not IsDelimiter(XmlWhitespaces, Text, I) then
        begin
          { TODO : Error: '=' expected }
        end;
        Inc(I);
      end;
      if I < Length(Text) then
      begin
        Inc(I); // skip '='
      end;
      // skip to quote
      while I < Length(Text) do
      begin
        if IsDelimiter(XmlQuotes, Text, I) then break;
        if not IsDelimiter(XmlWhitespaces, Text, I) then
        begin
          { TODO : Error: Start quote expected }
        end;
        Inc(I);
      end;
      if I < Length(Text) then
      begin
        QuoteChar := Text[I];
        Inc(I); // skip quote
        while I < Length(Text) do
        begin
          if Text[I] = QuoteChar then Break;
          Value := Value + Text[I];
          Inc(I);
        end;
        if Text[I] <> QuoteChar then
        begin
          { TODO : Error: End quote expected }
        end;
      end;
      SetAttribute(Name, DecodeXmlChars(Value), True);
    end;
    Inc(I);
  end;
end;

procedure TElAttributeList.SetValue(const Index: Integer;
  const AValue: String);
begin
  FValues[Index] := AValue;
end;

procedure TElAttributeList._SetAttribute(const AName, AValue: String);
begin
  SetAttribute(AName, AValue, False);
end;

end.
