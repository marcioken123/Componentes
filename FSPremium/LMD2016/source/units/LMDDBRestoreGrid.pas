unit LMDDBRestoreGrid;
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

LMDDBRestoreGrid unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DB,
  DBCtrls,
  Classes,
  LMDCustomIniComponent;

type
  TLMDDBRestoreGridOption=(rgIndex, rgVisible, rgWidth);
  TLMDDBRestoreGridOptions=set of TLMDDBRestoreGridOption;

  {------------------------------- TLMDDBGrid ---------------------------------}
  TLMDDBRestoreGrid = class(TLMDCustomIniComponent)
  private
    FDataSource:TDataSource;
    FOptions:TLMDDBRestoreGridOptions;
    procedure SetDataSource(aValue:TDataSource);
  protected
    procedure CreateSectionDefault(var aValue:String);override;
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;
  public
    constructor Create(aOwner:TComponent);override;
    procedure RestoreState;override;
    procedure SaveState;override;
    procedure ReadData;
    procedure WriteData;
  published
    property About;
    property DataSource:TDataSource read FDataSource write SetDataSource;
    property IniLink;
    property IniUse;
    property Options:TLMDDBRestoreGridOptions read FOptions write FOptions default [rgIndex, rgVisible, rgwidth];
    property Section;
  end;

implementation

uses
  Forms,
  SysUtils,
  LMDConst,
  LMDClass,
  LMDStrings,
  LMDIniCtrl;

{------------------------------------------------------------------------------}
procedure TLMDDBRestoreGrid.SetDataSource(aValue:TDataSource);
begin
  if FDataSource<>aValue then
    begin
      FDataSource:=aValue;
      if FDataSource=nil then
        begin
          Section:='';
          SetSectionDefault;
        end
      else
        FDataSource.FreeNotification(Self);
    end;
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDDBRestoreGrid.Notification(AComponent:TComponent;Operation:TOperation);
var
  i,l,comp : Integer;
begin
  inherited Notification(aComponent,Operation);
  if (Operation=opRemove) and (aComponent=FDataSource) then FDataSource:=nil;

  if (Operation=opInsert) then
    begin
      if (AComponent is TDataSource) and not Assigned(FDataSource)then
        begin
          FDataSource := TDataSource(AComponent);
          SetSectionDefault;
        end;

      if (IniUse=ioUseLink) and (aComponent is TLMDIniCtrl) and (IniLink=nil) then
        IniLink:=TLMDIniCtrl(aComponent);

      if (Owner is TForm) and (aComponent=Self) then
        begin
          comp:=0;
          SetSectionDefault;
          l:=0;
          for i:=0 to Pred(TForm(Owner).ComponentCount) do
            if TForm(Owner).Components[i] is TDataSource then
              begin
                Comp:=i;
                inc(l);
              end;
          if l=1 then
            begin
              FDataSource:=TDataSource(TForm(Owner).Components[Comp]);
              SetSectionDefault;
            end;
          l := 0;
          if IniUse=ioUseLink then
            begin
              for i := 0 to Pred(TForm(Owner).ComponentCount) do
                if TForm(Owner).Components[i] is TLMDIniCtrl then
                  begin
                    Comp := i;
                    inc(l);
                  end;
              if l=1 then
                IniLink:=TLMDIniCtrl(TForm(Owner).Components[Comp]);
            end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBRestoreGrid.CreateSectionDefault(var aValue:String);
begin
  if LMDAnsiEmpty(aValue) then
    if (FDataSource<>nil) and (FDataSource.DataSet<>nil) then
      aValue:=TComponent(Owner).Name+'.'+FDataSource.DataSet.Name+'.'+copy(ClassName, 5, 13)
    else
      aValue:=TComponent(Owner).Name+'.'+copy(ClassName, 5, 13);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBRestoreGrid.RestoreState;

  procedure ReadFieldStates(aLink:TLMDIniCtrl);
  var
    List : TStrings;
    i,l  : Integer;
    s, s2: String;
  begin
    if not Assigned(FDataSource) then exit;
    if FDataSource.DataSet=nil then exit;
    with FDataSource.DataSet, aLink do
      begin
        List:=TStringList.Create;
        try
          ReadSectionValues(inherited Section, List);
          if List.Count=0 then exit;
          for i:=0 to Pred(FieldCount) do
            begin
              s:=List.Values['E'+IntToStr(i)];
              s2:={$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF}(s, IDS_DEFAULTDELIMITER, 0);
              if s2<>'' then
                for l := 0 to Pred(FieldCount) do
                  if Fields[l].FieldName=s2 then
                    begin
                      if rgIndex in FOptions then Fields[l].Index:=i;
                      if rgWidth in FOptions then
                        Fields[i].DisplayWidth:=StrToInt({$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF}(s, IDS_DEFAULTDELIMITER, 1));
                      if rgVisible in FOptions then
                        Fields[l].Visible:=Boolean(StrToInt({$IFDEF LMD_NATIVEUNICODE}LMDGetCodedString{$ELSE}LMDAnsiGetCodedString{$ENDIF}(s, IDS_DEFAULTDELIMITER, 2)));
                      break;
                    end;
            end;
        finally
          List.Free;
        end;
      end;
  end;

begin
  case IniUse of
    ioUseLink  :if IniLink<>nil then ReadFieldStates(IniLink);
    ioUseGlobal:ReadFieldStates(LMDApplication.Ini);
    ioNone: ;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBRestoreGrid.SaveState;

  procedure writeFieldStates(aLink:TLMDIniCtrl);
  var
    i: integer;
    l: TStrings;
  begin
    if not Assigned(FDataSource) then exit;
    if FDataSource.DataSet=nil then exit;
    with FDataSource.DataSet, aLink do
      begin
        l:=TStringList.Create;
        try
          for i:=0 to Pred(FieldCount) do
            l.Add({$IFDEF LMD_NATIVEUNICODE}LMDCodeString{$ELSE}LMDAnsiCodeString{$ENDIF}
                  ([Fields[i].FieldName,
                  IntToStr(Fields[i].DisplayWidth),
                  IntToStr(Byte(Fields[i].Visible))], IDS_DEFAULTDELIMITER));

          EraseSection(inherited Section);
          if FieldCount>0 then
            WriteStringsExt(inherited Section, 'E', l, Pred(FieldCount));

        finally
          l.Free;
        end;
      end;
  end;

begin
  if not(csDesigning in ComponentState) then
    case IniUse of
      ioUseLink  :if IniLink<>nil then writeFieldStates(IniLink);
      ioUseGlobal:writeFieldStates(LMDApplication.Ini);
      ioNone: ;
    end;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDDBRestoreGrid.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FOptions:=[rgIndex, rgVisible, rgwidth]
end;

{------------------------------------------------------------------------------}
procedure TLMDDBRestoreGrid.ReadData;
begin
  RestoreState;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBRestoreGrid.WriteData;
begin
  SaveState;
end;

end.
 
