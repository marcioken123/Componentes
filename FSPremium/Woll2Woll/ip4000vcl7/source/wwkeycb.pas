unit Wwkeycb;
{
//
// Components : TwwIncrementalSearch, wwKeyCombo
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
// 11/5/97 - Use IndexDefs property for 3rd party engines
// 2/18/98 - Backwards logic before in case sensitivity for clientdatasets.
// 2/19/98 - Support client-datasets with TwwKeyCombo (Use IndexFieldNames
//           property
// 5/30/98 - Support automatic refresh of keycombo when table changes index
// 7/4/98  - Support picture masks
// 8/27/98 - Virtual dataset fix for keycombo
// 9/15/98 - Only show visible fields in ClientDataSet
// 9/15/98 - SkipRefresh patch in Change method
// 10/12/98 - Remove error message when attached to child table
// 11/12/98 - Map fieldname to displayname in TClientDataSet
// 3/18/99 - Don't add calculated or lookupfields to list
// 1/6/00 - es_multiline style does not pass carriage return/line feed to form so
//            we pass it ourselves
// 1/31/2000 - Fix problem of tab not being passed
// 2/3/2000 - Check for nil dataset in change method
// 3/12/00 - Cast to TTable, not TwwTable
// 5/19/00 - Carriage return going to next line when borderstyle=bsnone
//           Also fix escape not closing dialog problem after backspace entered
// 1/21/01 - Give priority to indexes with 1 field index
}

interface

{$i wwIfDef}

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, StdCtrls, db, dbtables, wwtable, wwstr, dialogs, wwcommon,
  wwSystem, ExtCtrls, wwdatsrc, menus, wwtypes, wwpict, wwframe, wwdbcomb,
{$IFDEF WIN32}
bde
{$ELSE}
dbiprocs, dbiTypes, dbierrs
{$ENDIF}           
;


type

  TwwKeyDataLink = class;
  TwwIncrementalSearch = class;
  TwwAfterSearchEvent = Procedure(Sender: TwwIncrementalSearch; MatchFound: boolean) of object;

//  TwwKeyCombo = class(TCustomComboBox)
  TwwKeyCombo = class(TwwDBCustomComboBox)
    private
      FDataLink: TwwKeyDataLink;
      FShowAllIndexes: boolean;
      FPrimaryKeyName: string;
      skipReload: boolean;
      FShowAllFields: boolean;

    protected
      procedure CloseUp(Accept: Boolean); override;
      procedure Change; override;
      procedure SetDataSource(value : TDataSource);
      Function GetDataSource: TDataSource;
      Function GetPrimaryName: string;
      procedure SetShowAllIndexes(value: boolean);
      procedure SetShowAllFields(value: boolean);
      procedure Notification(AComponent: TComponent;
        Operation: TOperation); override;

    public
      Patch: Variant;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure LinkActive(active: Boolean);
      procedure DataChanged; virtual;
      procedure InitCombo;
      procedure InitComboWithGrid(grid: TComponent);
      procedure RefreshDisplay;
      procedure DropDown; override;
      function UseAllFields(value: TDataSet): boolean; virtual;
      property ShowAllFields: boolean read FShowAllFields write SetShowAllFields;

    published
      {$ifdef wwDelphi4Up}
      property Anchors;
      property Constraints;
      {$endif}

      property Style; {Must be published before Items}
      property AutoSize;
      property BorderStyle;
      property Color;
      property Ctl3D;
      property DragMode;
      property DragCursor;
      property DropDownCount;
      property Enabled;
      property Font;
      property ItemHeight;
{      property Items;}
      property MaxLength;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property Sorted;
      property TabOrder;
      property TabStop;
      property Text;
      property Visible;
      property OnChange;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnDrawItem;
      property OnDropDown;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMeasureItem;
      property ShowAllIndexes: boolean read FShowAllIndexes write SetShowAllIndexes;
      property DataSource: TDataSource read getDataSource write setDataSource;
      property PrimaryKeyName: string read FPrimaryKeyName write FPrimaryKeyName;

      property ButtonEffects;
      property Frame;
      property ButtonWidth;
      property ButtonGlyph;
      property ButtonStyle;

  end;


  TwwSearchCaseSensitivity = (wwcsAutoDetect, wwcsCaseSensitive, wwcsCaseInsensitive);

  TwwIncrementalSearch = class(TCustomEdit)
    private
      FDataLink: TDataLink;
      FTimerInterval: integer;
      FTimer: TTimer;
      FOnAfterSearch: TwwAfterSearchEvent;
      FShowMatchText: boolean;
      LastValue: string;
      FieldNo: integer;
      FSearchField: string;
      FPictureMask: string;
      FPictureMaskAutoFill: boolean;
      FPictureMaskFromField: boolean;
      FFrame: TwwEditFrame;
      FFocused: boolean;
      FCanvas: TControlCanvas;
      FSearchDelay: integer;
      FCaseSensitivity: TwwSearchCaseSensitivity;
      FOnPerformCustomSearch: TwwPerformSearchEvent;
      function isTransparentEffective: boolean;
      procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
      procedure CMExit(var Message: TCMExit); message CM_EXIT;
      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
      procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
      procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN; {handle tab}
      procedure WMSetFont(var Message: TWMSetFont); message WM_SETFONT;

    protected
      procedure SetDataSource(value : TDataSource);
      Function GetDataSource: TDataSource;
      Function FindSearchField: string;
      procedure CreateParams(var Params: TCreateParams); override;
      procedure CreateWnd; override;
      procedure SetEditRect; virtual;
      procedure PerformCustomSearch(
              SearchField: string;
              SearchValue: string;
              PerformLookup: boolean;
              var Found: boolean); virtual;

    public
      Patch: Variant;
      property DelayTimer : TTimer read FTimer;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure FindValue;
      procedure OnEditTimerEvent(Sender: TObject);
      procedure KeyPress(var Key: Char); override;
      procedure KeyUp(var Key: Word; Shift: TShiftState); override;
      procedure SetSearchField(ASearchField: string);
      procedure Clear;
      {$ifdef wwDelphi3Up} override; {$endif}


    published
      {$ifdef wwDelphi4Up}
      property Anchors;
      property Constraints;
      {$endif}
      property Frame: TwwEditFrame read FFrame write FFrame;
      property DataSource: TDataSource read getDataSource write setDataSource;
      property SearchField : string read FSearchField write FSearchField;
      property OnAfterSearch: TwwAfterSearchEvent read FOnAfterSearch write FOnAfterSearch;
      property ShowMatchText: boolean read FShowMatchText write FShowMatchText default False;
      property PictureMask: string read FPictureMask write FPictureMask;
      property PictureMaskAutoFill: boolean read FPictureMaskAutoFill write FPictureMaskAutoFill default True;
      property PictureMaskFromField: boolean read FPictureMaskFromField write FPictureMaskFromField default False;
      property SearchDelay: integer read FSearchDelay write FSearchDelay default 0;
      property CaseSensitivity: TwwSearchCaseSensitivity read FCaseSensitivity write FCaseSensitivity default wwcsAutoDetect;
      property OnPerformCustomSearch: TwwPerformSearchEvent read FOnPerformCustomSearch write FOnPerformCustomSearch;
      property AutoSelect;
      property AutoSize;
      property BorderStyle;
      property CharCase;
      property Color;
      property Ctl3D;
      property DragCursor;
      property DragMode;
      property Enabled;
      property Font;
      property HideSelection;
      {$ifdef wwDelphi3Up}
      property ImeMode;
      property ImeName;
      {$endif}
      property MaxLength;
      property OEMConvert;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PasswordChar;
      property PopupMenu;
      property ReadOnly;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property Visible;
      property OnChange;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
  end;


  TwwKeyDataLink = class(TDataLink)
    private
      FwwKeyCombo: TwwKeyCombo;
    protected
      procedure DataSetChanged; override;
      procedure ActiveChanged; override;
    public
      constructor Create(key: TwwKeyCombo);
  end;

implementation

uses wwlocate, wwdbigrd, typinfo, wwintl,
{$ifdef wwDelphi6Up}
variants,
{$endif}
 wwquery;
 
constructor TwwKeyDataLink.Create(key: TwwKeyCombo);
begin
   inherited Create;
   FwwKeyCombo:= key;
end;

procedure TwwKeyDataLink.ActiveChanged;
begin
   if FwwKeyCombo=Nil then exit;
   FwwKeyCombo.linkActive(active);
end;

constructor TwwKeyCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowAllFields := False;
  FDataLink:= TwwKeyDataLink.create(self);

  style:= csDropDownList;
  FPrimaryKeyName:='PrimaryKey';

  Patch:= VarArrayCreate([0, 0], varVariant);
  Patch[0]:= False; { SkipRefresh in Change method }

end;

destructor TwwKeyCombo.Destroy;
begin
  FDataLink.dataSource:= nil;
  FDataLink.free;
  FDataLink:= Nil;
  inherited destroy;
end;

procedure TwwKeyCombo.CloseUp(Accept: Boolean);
begin
   inherited CloseUp(Accept);
   ShowMatchText:= False;
   if Style=csDropDownList then Windows.HideCaret(Handle);
end;

procedure TwwKeyCombo.DropDown;
begin
   ShowMatchText:= True;
   inherited DropDown;
end;

function TwwKeyCombo.UseAllFields(value: TDataSet): boolean;
begin
   result:=
      wwIsClass(value.classType, 'TClientDataSet') or ShowAllFields or

      { Require client-side cursor if all fields are being shown in combo }
      ((wwGetDatabaseCursorType(value)=1) and

       // 8/14/02 - Support TADODataSet indexes
       (wwIsClass(value.classType, 'TADOTable') or wwIsClass(value.classType, 'TADODataSet')));

{   if result and wwIsClass(value.ClassType, 'TADODataSet') then
   begin
      if (wwGetCommandType(value)<>2) and
         (wwGetCommandType(value)<>3) then result:=false;
   end;
}
end;

procedure TwwKeyCombo.SetDataSource(value : TDataSource);
var PropInfo: PPropInfo;
begin
   if (value<>Nil) and
      (value.dataSet<>Nil) and
      { 2/19/98 - Allow table or clientdataset }
      not (wwIsClass(value.dataset.classType, 'TTable') or
           UseAllFields(value.dataset)) then
   begin
      PropInfo:= Typinfo.GetPropInfo(Value.DataSet.ClassInfo,'IndexDefs');
      if PropInfo=Nil then begin
         MessageDlg('DataSource must point to a dataset containing index information.',
                    mtWarning, [mbok], 0);
         exit;
      end
   end;

   FDataLink.dataSource:= value;
{$IFDEF WIN32}
   if value<>Nil then Value.FreeNotification(self); { Win95}
{$ENDIF}
   LinkActive(FdataLink.active);
end;

Function TwwKeyCombo.GetDataSource: TDataSource;
begin
   if FDataLink=Nil then Result:=Nil
   else Result:= FDataLink.dataSource;
end;

procedure TwwKeyCombo.LinkActive(active: Boolean);
begin
   if not Active then exit;
   InitCombo;
end;

Function TwwKeyCombo.GetPrimaryName: string;
begin
   if FPrimaryKeyName='' then result:= 'PrimaryKey'
   else result:= FPrimaryKeyName;
end;

procedure TwwKeyCombo.SetShowAllIndexes(value: boolean);
begin
   FShowAllIndexes:= value;
   if (datasource<>nil) {and (FShowAllIndexes<>value) }then
   begin
      initCombo;
   end
end;

procedure TwwKeyCombo.SetShowAllFields(value: boolean);
begin
   FShowAllFields:= value;
   if (datasource<>nil) then
   begin
      initCombo;
   end
end;

procedure TwwKeyCombo.InitCombo;
begin
   InitComboWithGrid(nil);
end;

procedure TwwKeyCombo.RefreshDisplay;
begin
   SkipReload:= True;
   try
      InitComboWithGrid(nil);
   finally
      SkipReload:= False;
   end
end;

procedure TwwKeyCombo.InitComboWithGrid(grid: TComponent);
var parts : TStrings;
    i: integer;
    activeIndex, fieldTitle: string;
    dataset: TDataSet;
    masterSource: TDataSource;
    tempIndexName : string;
    tempVisible: boolean;
    selIndex: integer;
    IndexDefs: TIndexDefs;
    PropInfo: PPropInfo;
    APos: integer;
    tempItemIndex: integer;
    tempField: TField;
    activeDescending: boolean;

    function GetIndexName: string;
    begin
       Result:= '';
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexName');
       if PropInfo<>Nil then Result:= GetStrProp(DataSource.DataSet, PropInfo);
    end;
    function GetIndexFieldNames: string;
    begin
       Result:= '';
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexFieldNames');
       if PropInfo<>Nil then Result:= GetStrProp(DataSource.DataSet, PropInfo);
    end;

    function DisplayLabelsChanged: boolean;
    var i: integer;
    begin
       result:= False;
       for i:= 0 to Items.count-1 do begin
          if wwGetFieldNameFromTitle(datasource.dataSet, Items[i])='' then
          begin
             result:= True;
             break;
          end
       end
    end;


begin
   if datasource=nil then exit;
   if DataSource.DataSet=nil then exit;

   if dataSource.dataSet is TTable then
   begin
      dataset:= dataSource.dataSet;
      indexDefs:= (datasource.dataset as TTable).indexdefs;
      if wwIsTableQuery(Dataset) then begin
         MessageDlg('TwwKeyCombo: DataSet cannot be a TwwTable using a Query.',
                 mtWarning, [mbok], 0);
         exit;
      end;
   end
   else if UseAllFields(datasource.dataset) then
   begin
      if not SkipReload then
      begin
         Items.clear;
         with Datasource.dataset do
         begin
            for i:= 0 to FieldCount-1 do
            begin
               if wwValidFilterableFieldType(Fields[i].datatype) and
                 { 3/18/99 - Don't add calculated or lookupfields to list}
                 (not Fields[i].lookup) and (not Fields[i].Calculated) then
               begin
                  { 9/15/98 - Only show visible fields in ClientDataSet }
                  if (grid=nil) then tempVisible:= Fields[i].visible
                  else tempVisible:= wwFindSelected((grid as TwwCustomDBGrid).selected, Fields[i].FieldName, SelIndex);

                  if tempVisible or ShowAllIndexes then begin
                     fieldTitle:=  strReplaceChar(Fields[i].displayLabel, '~', ' ');
                     Items.add(fieldTitle);
                  end
               end
            end
         end;
      end;

      APos:= 1;
      tempIndexName:= strGetToken(GetIndexFieldNames, ';', APos);

      { 11/12/98 - Map fieldname to displayname }
      tempField:= datasource.dataset.findfield(tempindexname);
      if tempfield<>nil then tempIndexName:=tempField.displaylabel;

      ItemIndex:= Items.indexOf(TempIndexName);
      exit;
   end
   else begin
      dataset:= dataSource.dataSet;
      PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexDefs');
      if PropInfo<>Nil then IndexDefs:= TIndexDefs(GetOrdProp(DataSource.DataSet, PropInfo))
      else begin
//         MessageDlg('TwwKeyCombo: DataSet does not have index information available.',
//                    mtWarning, [mbok], 0);
         exit;
      end
   end;

   PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'MasterSource');
   if PropInfo<>Nil then masterSource:= TDataSource(GetOrdProp(DataSource.DataSet, PropInfo))
   else masterSource:= nil;
   if masterSource<>Nil then begin
{      MessageDlg('TwwKeyCombo: Data Source can not be a child table.' + #13 +
              'Component ' + self.name + ' has a MasterSource defined.',
              mtWarning, [mbok], 0);}
      exit;
   end;

   if (not SkipReload) or DisplayLabelsChanged then
   begin
      SkipReload:= False;
      Items.clear;
      ActiveIndex:= '';

      IndexDefs.update;  { refreshes Index list }

      if ShowAllIndexes then begin
         for i:= 0 to IndexDefs.count-1 do begin
            tempIndexName:= IndexDefs.Items[i].Name;
            if tempIndexName='' then tempIndexName:= GetPrimaryName;
            self.items.add(tempIndexName);
         end;
      end
   end;

   if ShowAllIndexes then begin
      tempIndexName:= GetIndexName;
      if tempIndexName='' then tempIndexName:= GetPrimaryName;
      ItemIndex:= Items.indexOf(tempIndexName);
      exit;
   end;

   ActiveDescending:= False;

   { Fill combo box with list of index names - but show field titles instead of index names}
   parts := TStringList.create;

   { 6/6/97 - Use wwEqualStr function to make comparisons case insensitive }
   for i:= 0 to IndexDefs.count-1 do begin
      with IndexDefs.Items[i] do begin
          strBreakApart(fields, ';', parts);
          if not wwDataSetIsValidField(Dataset, parts[0]) then continue;
          if (grid=nil) then tempVisible:= dataset.fieldByName(parts[0]).visible
          else tempVisible:= wwFindSelected((grid as TwwCustomDBGrid).selected, parts[0], SelIndex);
          if tempVisible then begin
             fieldTitle:=  strReplaceChar(Dataset.fieldByName(parts[0]).displayLabel, '~', ' ');
             if (ixDescending in Options) then begin
                if (fieldTitle<>'') then
                begin
                   if GetIndexFieldNames = '' then begin
                      if wwEqualStr(IndexDefs.Items[i].name, GetIndexName) then
                      begin
                         activeIndex:= fieldTitle;
                         activeDescending:= True;
                      end;
                   end
                   else begin
                      if wwEqualStr(GetIndexFieldNames,Fields) then
                      begin
                         activeIndex:= fieldTitle;
                         activeDescending:= True;
                      end;
                   end;

                   if (self.items.indexOf(fieldTitle + ' - Desc')<0) then
                   begin
                      if (not SkipReload) then self.items.add(fieldTitle + ' - Desc')
                   end
                end
             end
             else begin
                if (fieldTitle<>'') then
                begin
                   if GetIndexFieldNames = '' then begin
                      if wwEqualStr(IndexDefs.Items[i].name, GetIndexName) then
                         activeIndex:= fieldTitle;
                   end
                   else begin
                      if wwEqualStr(GetIndexFieldNames, Fields) then
                         activeIndex:= fieldTitle;
                   end;

                   if (self.items.indexOf(fieldTitle)<0) then
                   begin
                      if (not SkipReload) then self.items.add(fieldTitle)
                   end
                end
             end
          end
      end
   end;

   {6/16/97 - Support descending index type }
   TempItemIndex:= -1;
   for i:= 0 to Items.count-1 do
   begin
      if wwEqualStr(Items[i], activeIndex) then
      begin
        { 8/17/99 - Fix bug in confusing which index is the active index }
         if not ActiveDescending then TempItemIndex:= i
      end
      else if wwEqualStr(Items[i], activeIndex + ' - Desc') then
      begin
         if ActiveDescending then TempItemIndex:= i
      end
   end;
   if ItemIndex<>TempItemIndex then
      ItemIndex:= TempItemIndex;
   parts.free;

end;

procedure TwwKeyCombo.Change;
var i: integer;
    found: boolean;
    IndexTitle: String;
    parts: TStrings;
    dataset: TDataset;
    PropInfo: PPropInfo;
    Indexdefs: TIndexDefs;

    function GetIndexName: string;
    begin
       Result:= '';
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexName');
       if PropInfo<>Nil then Result:= GetStrProp(DataSource.DataSet, PropInfo);
    end;

    procedure SetIndexName(val: string);
    begin
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexName');
       if PropInfo<>Nil then
          SetStrProp(Datasource.dataset,PropInfo, val);
    end;

    procedure SetIndexFieldNames(val: string);
    begin
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexFieldNames');
       if PropInfo<>Nil then
          SetStrProp(Datasource.dataset,PropInfo, val);
    end;

    function GetIndexFieldNames: string;
    begin
       Result:= '';
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexFieldNames');
       if PropInfo<>Nil then Result:= GetStrProp(DataSource.DataSet, PropInfo);
    end;

   Function useThisIndex: boolean;
   begin
      result:= False;
      with IndexDefs do begin
          if (ixDescending in Items[i].Options) then begin
             if (IndexTitle =
                 strReplaceChar(Dataset.fieldByName(Parts[0]).displayLabel + ' - Desc','~', ' ')) then
             begin
                {$ifdef wwDelphi3Up}
                if Dataset is TBDEDataSet then
                   wwTableChangeIndex(Dataset, Items[i])
                else SetIndexName(Items[i].name);
                {$else}
                wwTableChangeIndex(Dataset, Items[i]);
                {$endif}
                result:= True;
                exit;
             end
          end
          else begin
             if (IndexTitle = strReplaceChar(Dataset.fieldByName(Parts[0]).displayLabel, '~', ' ')) then
             begin
                {$ifdef wwDelphi3Up}
                if Dataset is TBDEDataSet then
                   wwTableChangeIndex(Dataset, Items[i])
                else SetIndexName(Items[i].name);
                {$else}
                wwTableChangeIndex(Dataset, Items[i]);
                {$endif}

                result:= True;
                exit;
             end
          end
      end
   end;

   function IsAlone(aFields, aField: string): Boolean;
   begin
     Result:= aFields = aField;
   end;


begin

   if dataSource=Nil then exit;
   if dataSource.dataset=Nil then exit; { 2/3/2000 - Check for nil or inactive dataset }
   if not dataSource.dataset.active then exit;

   if dataSource.dataSet is TTable then
   begin
      dataset:= dataSource.dataSet;
      indexDefs:= (datasource.dataset as TTable).indexdefs;
      if wwIsTableQuery(Dataset) then begin
         MessageDlg('TwwKeyCombo: DataSet cannot be a TwwTable using a Query.',
                 mtWarning, [mbok], 0);
         exit;
      end;
   end
   else if useAllFields(datasource.dataset) then
   begin
      if Text<>'' then
      begin
         Patch[0]:= True;// SkipRefresh:= True;
         try
           SetIndexFieldNames(wwGetFieldNameFromTitle(datasource.DataSet, Text));
         finally
           Patch[0]:= False;// SkipRefresh:= False;
         end
      end;
      inherited change;
      exit;
   end
   else begin
      {$ifndef wwdelphi4up}
      {$ifndef ver110}
      dataset:= dataSource.dataSet; { Uncomment - 8/27/98 }
      {$endif}
      {$endif}
      PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexDefs');
      if PropInfo<>Nil then IndexDefs:= TIndexDefs(GetOrdProp(DataSource.DataSet, PropInfo))
      else begin
         MessageDlg('TwwKeyCombo: Virtual DataSet does not have index information available.',
                    mtWarning, [mbok], 0);
         exit;
      end
   end;


   IndexTitle:= Text;

   if ShowAllIndexes then begin
      if IndexTitle=GetPrimaryName then IndexTitle:= '';
      SetIndexName(indexTitle);
{      (dataSource.dataSet as TTable).indexName:= indexTitle;}
      inherited change;  { added 7/20/95}
      exit;
   end;

   parts:= TStringList.Create;

   { Look for case insensitive index for this field }
   { If not found then use case sensitive index     }
   IndexDefs.update;  { refreshes Index list }

   found:= False;
   for i:= 0 to IndexDefs.count-1 do begin
      with IndexDefs do begin
          strBreakApart(Items[i].fields, ';', parts);
          if not ( wwDataSetIsValidField(Dataset, Parts[0]) and
                  (ixCaseInsensitive in Items[i].Options)) then continue;
          if useThisIndex then begin
             Found:= True;
             break;
          end
       end
   end;

   // 1/21/01 - Give priority to indexes with 1 field index
   if not Found then begin
      for i:= 0 to IndexDefs.count-1 do begin
         with IndexDefs do begin
             strBreakApart(Items[i].fields, ';', parts);
             if not wwDataSetIsValidField(Dataset, Parts[0]) then continue;
             if IsAlone(Items[i].fields, Parts[0]) and useThisIndex then begin
                Found:= True;
                break;
             end
          end
      end;
   end;

   if not Found then begin
      for i:= 0 to IndexDefs.count-1 do begin
         with IndexDefs do begin
             strBreakApart(Items[i].fields, ';', parts);
             if not wwDataSetIsValidField(Dataset, Parts[0]) then continue;
             if useThisIndex then break;
          end
      end;
   end;

   parts.Free;

   itemIndex:= items.indexOf(IndexTitle); {ft5 bug requires this redundancy}

   inherited change;

end;


constructor TwwIncrementalSearch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink:= TDataLink.create;
  FTimer:= TTimer.create(self);
  FTimer.enabled:= False;
  FTimerInterval:= 200;
  FTimer.Interval:= FTimerInterval;
  FTimer.OnTimer:= OnEditTimerEvent;
  LastValue:= '';
  Text:= '';
  FieldNo:= 0;
  FPictureMaskAutoFill:= True;
  FPictureMaskFromField:= False;
  FFrame:= TwwEditFrame.create(self);
  FCaseSensitivity:= wwcsAutoDetect;
end;

destructor TwwIncrementalSearch.Destroy;
begin
  FDataLink.free;
  FTimer.free;
  FFrame.Free;
  FCanvas.Free;
  inherited destroy;
end;

procedure TwwIncrementalSearch.OnEditTimerEvent(Sender: TObject);
begin
   if not FTimer.enabled then exit;
   FTimer.enabled:= False;
   if text <> lastValue then
   begin
      findValue;
      lastValue:= text;
   end;
end;

procedure TwwIncrementalSearch.SetDataSource(value : TDataSource);
begin
   FDataLink.dataSource:= value;
end;

Function TwwIncrementalSearch.GetDataSource: TDataSource;
begin
   Result:= FdataLink.dataSource;
end;

procedure TwwIncrementalSearch.KeyUp(var Key: Word; Shift: TShiftState);
   Function isValidChar(key: word): boolean;
   begin
      result:= (key = VK_BACK) or (key=VK_SPACE) or (key=VK_DELETE) or
               ((key >= ord('0')) and (key<=VK_DIVIDE)) or
               (key>VK_SCROLL); { Support international characters }
   end;
begin
  inherited KeyUp(Key, Shift);
  if ((lastValue<>Text) and IsValidChar(Key)) then
  begin
     if FShowMatchText and (key in [VK_BACK, VK_DELETE]) then begin
        { 1/29/97 - Cancel range when blank }
        if (datasource.dataset is TwwTable) and (datasource.dataset as TwwTable).narrowSearch
           and (Text = '') then
           (datasource.dataset as TwwTable).FastCancelRange;
        exit;
     end;

     FTimer.enabled:= False;
     if (dataSource=Nil) then begin
         MessageDlg('DataSource not defined - object ' + name, mtWarning, [mbok], 0);
         exit;
     end;
     if (dataSource.dataSet=Nil) then begin
         MessageDlg('Dataset not defined for DataSource', mtWarning, [mbok], 0);
         exit;
     end;

     if FSearchDelay<>0 then FTimer.Interval:= FSearchDelay
     else if not wwIsClass(DataSource.DataSet.classType, 'TClientDataSet') then
     begin
        if datasource.dataset.active then
           if (datasource.dataset is TDBDataSet) then { 9/20/97}
              if not (datasource.dataSet as TDBDataSet).database.isSQLBased then
                 FTimer.Interval:= FTimerInterval div 2;
     end;
     FTimer.enabled:= True;
  end
end;

procedure TwwIncrementalSearch.PerformCustomSearch(
   SearchField: string; SearchValue: string;
   PerformLookup: boolean; var Found: boolean);
begin
   if Assigned(FOnPerformCustomSearch) and Assigned(DataSource.DataSet) then
   begin
      FOnPerformCustomSearch(self, DataSource.DataSet,
          SearchField, SearchValue, PerformLookup, Found);
   end
end;

procedure TwwIncrementalSearch.FindValue;
var
   dataSet : TDataSet;
   SearchIndex: integer;
   i: integer;
   tempSearchField: wwSmallString;
   SearchText: string;
   isQuery, isFound: boolean;
   {$ifdef wwDelphi3Up}
   curField: TField;
   IndexDefs: TIndexDefs;
   apos, idx: integer;
   {$endif}

   PropInfo: PPropInfo;
   CaseSensitive: boolean;

   TempText : string;

   Function isExpressionIndex(table: TDataSet): boolean;
   var curpos: integer;
       expression: string;
       curWord: wwSmallString;
   begin
      result:= False;
      with Table as TTable do begin
         if (TableType = ttDBase) or
            (CompareText(ExtractFileExt(TableName), '.DBF') = 0) then
         begin
            if (IndexDefs.indexof(IndexName)>=0) and
               (ixExpression in IndexDefs.Items[IndexDefs.indexof(IndexName)].Options) then
            begin
               TempSearchField:= SearchField;
               if SearchField<>'' then begin
                  result:= True;
               end
               else begin
                  expression:= Uppercase(IndexDefs.Items[IndexDefs.indexOf(IndexName)].expression);
                  curPos:= 1;
                  repeat
                     curWord:=
                        wwGetWord(Expression, curpos, [wwgwSkipLeadingBlanks],
                            [ ')','(', '+', '-', '*', '/']);
                     if FindField(curWord)<>Nil then begin
                        TempSearchField:= curWord;
                        result:= True;
                        exit;
                     end
                  until (curWord='');
               end
            end
         end
      end
   end;

    function GetIndexFieldNames: string;
    begin
       Result:= '';
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexFieldNames');
       if PropInfo<>Nil then Result:= GetStrProp(DataSource.DataSet, PropInfo);
    end;

    function GetIndexName: string;
    begin
       Result:= '';
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexName');
       if PropInfo<>Nil then Result:= GetStrProp(DataSource.DataSet, PropInfo);
    end;

begin
   if dataSource=Nil then exit;
   if dataSource.dataSet=Nil then exit;
   if not Assigned(FOnPerformCustomSearch) then
   begin
     if not dataSource.dataset.Active then exit;
   end;
   dataSet := dataSource.DataSet as TDataSet;
   isQuery:= False;
   TempSearchField:= SearchField;

   {$ifdef wwDelphi3Up}
   if not (dataSet is TBDEDataset) then begin
      if (Text='') then begin { 9/15/99 - Locate causes exception if passing blank value so we skip locate }
         DataSet.First;
         exit;
      end;
      caseSensitive:= False;
      PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexDefs');
      if PropInfo<>Nil then begin
         IndexDefs:= TIndexDefs(GetOrdProp(DataSource.DataSet, PropInfo));
         idx:= IndexDefs.indexof(GetIndexName);
         if idx>=0 then begin
            caseSensitive:= not (ixCaseInsensitive in IndexDefs.Items[idx].Options);
            APos:= 1;
            if TempSearchField='' then
               TempSearchField:= strGetToken(IndexDefs.items[idx].fields, ';', APos);
         end
         else begin
            caseSensitive:= False;
         end
      end
   end
   else caseSensitive:= False;
   {$endif}

   case FCaseSensitivity of
      wwcsAutoDetect:;
      wwcsCaseSensitive: caseSensitive:= True;
      wwcsCaseInsensitive: caseSensitive:= False;
   end;

   if Assigned(FOnPerformCustomSearch) then
   begin
      if SearchField='' then TempSearchField:= dataset.fields[0].FieldName
      else TempSearchField:= SearchField;
      curField:= DataSet.FindField(TempSearchField);
      if (curField is TStringField) and (curField.size>0) and (curField.size<length(Text)) then
          TempText:= copy(Text, 1, curField.size)
      else TempText:=Text;

      PerformCustomSearch(TempSearchField, TempText, False, IsFound);
   end
   else if (dataSet is TTable) then begin
     with (DataSet as TTable) do
        if not wwIsTableQuery(DataSet) and (IndexDefs.count=0) then IndexDefs.update;  { refreshes Index list }

     if ((dataset as TTable).indexFieldCount=0) and wwIsTableQuery(DataSet) then begin
        isQuery:= True;
        if SearchField='' then TempSearchField:= dataset.fields[0].FieldName
        else TempSearchField:= SearchField;
        if (FCaseSensitivity=wwcsAutoDetect) then
           isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, False)
        else
           isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, caseSensitive)
     end
     else if isExpressionIndex(dataSet) then
     begin
        with DataSet as TTable do begin
           if not wwFieldIsValidValue(FieldbyName(TempSearchField), text) then exit;
           EditKey;
           FieldByName(TempSearchField).asString:= text;
           GoToNearest;
           isFound:= pos(Uppercase(Text), Uppercase(FieldByName(TempSearchField).asString))=1;
        end
     end
     else begin
        SearchIndex:= 0;
        if SearchField<>'' then with DataSet as TTable do begin
           for i:= 0 to indexFieldCount-1 do
              if (lowercase(SearchField)=lowercase(indexFields[i].fieldName)) then
                 SearchIndex:= i;
        end;
        if ((DataSet as TTable).indexFieldCount>0) and (CaseSensitivity = wwcsAutoDetect) then
           isFound:= wwTableFindNearest(dataSet as TTable, Text, SearchIndex)
        else begin
           if SearchField='' then TempSearchField:= dataset.fields[0].FieldName
           else TempSearchField:= SearchField;
           isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, caseSensitive);
        end
     end
   end
   else begin
      isQuery:= True;

      if SearchField='' then begin
         if TempSearchField='' then
             if GetIndexFieldNames<>'' then
             begin
                APos:= 1;
                TempSearchField:= strGetToken(GetIndexFieldNames, ';', APos);
             end
             else
                TempSearchField:= dataset.fields[0].FieldName
         else { TempSearchField assigned above }
      end
      else TempSearchField:= SearchField;

      {$ifdef wwDelphi3Up}
      curField:= DataSet.FindField(TempSearchField);
      if (not wwFieldIsValidLocateValue(curField, Text)) then begin { If invalid value type then skip search }
         isFound:= False;
      end
      else if (not wwIsClass(DataSet.classType, 'TwwQuery')) or  {ClientDataSet Locate fails on partial match }
              (not wwInternational.UseLocateMethodForSearch) then
      begin
         if  wwInternational.UseLocateMethodForSearch then
         begin
            { 11/4/97 - Replace wwDataSetFindRecord call with Locate to allow 3rd party engines
                        opportunity to take advantage of the index. Code assumes
                        case sensitive index if not using the BDE. }
            Screen.cursor:= crHourGlass;
            if (dataset is TBDEDataSet) and (FCaseSensitivity=wwcsAutoDetect) then
               isFound:= Dataset.Locate(TempSearchField, Text, [loPartialKey, loCaseInsensitive])
            else begin
               if caseSensitive then { 2/18/98 - Backwards logic before }
                  isFound:= Dataset.Locate(TempSearchField, Text,
                             [loPartialKey])
               else
                  isFound:= Dataset.Locate(TempSearchField, Text,
                             [loPartialKey, loCaseInsensitive])
            end;

            Screen.cursor:= crDefault;
         end
         else begin
            if (FCaseSensitivity=wwcsAutoDetect) then
               isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, False)
            else
               isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, caseSensitive)
         end
      end
      else begin
         { Require seq search on live parameterized query as Delphi Locate does not support this}
         if (DataSet is TwwQuery) and TwwQuery(DataSet).RequestLive and
                   TwwQuery(DataSet).CanModify and (TwwQuery(DataSet).DataSource<>Nil) then
         begin
             isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, False);
         end
         else begin
            Screen.cursor:= crHourGlass;
            try
              if TwwQuery(DataSet).isValidIndexField(TempSearchField, False) then
                 isFound:= DataSet.Locate(TempSearchField, Text, [loPartialKey, loCaseInsensitive])
              else if TwwQuery(DataSet).isValidIndexField(TempSearchField, True) then
                 isFound:= DataSet.Locate(TempSearchField, Text, [loPartialKey])
              else
                 isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, False);
            except { 7/1/97 - In case of capability not supported }
              isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, False);
            end;
            Screen.cursor:= crDefault;
         end
      end;
      {$else}
      isFound:= wwDataSetFindRecord(DataSet, Text, TempSearchField, mtPartialMatchStart, False);
      {$endif}

   end;

   if Assigned(FOnAfterSearch) then FOnAfterSearch(self, isFound);

   if FShowMatchText and isFound then begin
      SearchText:= Text;
      if isQuery then
         Text:=  DataSource.DataSet.FieldByName(TempSearchField).asString
      else if (TempSearchField<>'') then  { 4/11/97 - Support searchfield }
         Text:=  DataSource.DataSet.FieldByName(TempSearchField).asString
//      else Text:=  (DataSource.DataSet as TwwTable).IndexFields[0].asString;
      else Text:=  (DataSource.DataSet as TTable).IndexFields[0].asString; { 3/12/00 - Cast to TTable, not TwwTable }
      selStart:= length(SearchText);
      selLength:= length(Text)-length(SearchText)
   end

end;

Function TwwIncrementalSearch.FindSearchField: string;
var
   dataSet : TDataSet;
   tempSearchField: wwSmallString;
   {$ifdef wwDelphi3Up}
   IndexDefs: TIndexDefs;
   apos, idx: integer;
   {$endif}
   PropInfo: PPropInfo;

    function GetIndexName: string;
    begin
       PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexName');
       if PropInfo<>Nil then Result:= GetStrProp(DataSource.DataSet, PropInfo);
    end;

begin
   if dataSource=Nil then exit;
   if dataSource.dataSet=Nil then exit;
   if not dataSource.dataset.Active then exit;
   dataSet := dataSource.DataSet as TDataSet;
   TempSearchField:= SearchField;

   if not (dataSet is TBDEDataset) then begin
      PropInfo:= Typinfo.GetPropInfo(DataSource.DataSet.ClassInfo,'IndexDefs');
      if PropInfo<>Nil then begin
         IndexDefs:= TIndexDefs(GetOrdProp(DataSource.DataSet, PropInfo));
         idx:= IndexDefs.indexof(GetIndexName);
         if idx>=0 then begin
            APos:= 1;
            if TempSearchField='' then
               TempSearchField:= strGetToken(IndexDefs.items[idx].fields, ';', APos);
         end
      end
   end;

   if (dataSet is TTable) then begin
     with (DataSet as TTable) do
        if not wwIsTableQuery(DataSet) and (IndexDefs.count=0) then IndexDefs.update;  { refreshes Index list }

     if ((dataset as TTable).indexFieldCount=0) then begin
        if SearchField='' then TempSearchField:= dataset.fields[0].FieldName
        else TempSearchField:= SearchField;
     end
     else begin
        if (DataSet as TTable).indexFieldCount>0 then
           TempSearchField:= (Dataset as TTAble).indexFields[0].FieldName;
     end
   end
   else begin
      if (SearchField='') and (TempSearchField='') then
         TempSearchField:= dataset.fields[0].FieldName
      else TempSearchField:= SearchField;
   end;
   result:= TempSearchField;
end;

procedure TwwIncrementalSearch.SetSearchField(ASearchField: string);
begin
   SearchField:= ASearchField;
end;

procedure TwwIncrementalSearch.Clear;
begin
   Text:= '';
   LastValue:= '';
end;

procedure TwwKeyCombo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;


procedure TwwIncrementalSearch.KeyPress(var Key: Char);
var tempSearchField: string;
    Mask: string;
    dummy1, dummy2: boolean;
begin
  inherited KeyPress(Key);

  if FPictureMask<>'' then
     wwApplyPictureMask(self, PictureMask, PictureMaskAutoFill, Key)
  else if FPictureMaskFromField then
  begin
     tempSearchField:= FindSearchField;
     if tempSearchField='' then exit;
     wwPictureByField(datasource.dataset, TempSearchField, False, Mask,
                      dummy1, dummy2);
     if Mask<>'' then
        wwApplyPictureMask(self, Mask, PictureMaskAutoFill, Key)
  end
end;

procedure TwwKeyDataLink.DataSetChanged;
begin
  FwwKeyCombo.DataChanged;
end;

procedure TwwKeyCombo.DataChanged;
begin
  if Patch[0]=True then exit; // not SkipRefresh
  if not HandleAllocated then Exit;
  if Datasource.state=dsBrowse then RefreshDisplay;
end;

function TwwIncrementalSearch.isTransparentEffective: boolean;
begin
   result:= Frame.Transparent and Frame.enabled and
      not (csDesigning in ComponentState) {UnderlineControl}
end;

procedure TwwIncrementalSearch.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);

   if (BorderStyle = bsNone) then begin
      Params.Style:= Params.Style or ES_MULTILINE;

     { 5/19/00 - Carriage return going to next line when borderstyle=bsnone }
     Params.Style := Params.Style and not (ES_AUTOVSCROLL or ES_WANTRETURN);
   end;

   if Frame.enabled then Params.Style:= Params.Style and not WS_BORDER;

   if IsTransparentEffective and Frame.CreateTransparent then
     Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TwwIncrementalSearch.CMEnter(var Message: TCMEnter);
var exStyle, origStyle: longint;
begin
  SetEditRect;

  FFocused:= True;
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  
  inherited;

  if IsTransparentEffective then begin
     Frame.CreateTransparent:= False;
     OrigStyle:= Windows.GetWindowLong(handle, GWL_EXSTYLE);
     exStyle:= OrigStyle and not WS_EX_TRANSPARENT;
     Windows.SetWindowLong(handle, GWL_EXSTYLE, exStyle);
     invalidate;
  end;

  if Frame.enabled then invalidate; { See if this causes any flicker }
end;

procedure TwwIncrementalSearch.CMExit(var Message: TCMExit);
begin
  inherited;

  FFocused:= False;
  if IsTransparentEffective then begin
     Frame.CreateTransparent:= True;
     RecreateWnd;
  end;

  if Frame.enabled then
  begin
     invalidate; { See if this causes any flicker }
     wwInvalidateTransparentArea(self, True);
  end;
end;

procedure TwwIncrementalSearch.CreateWnd;
begin
   inherited CreateWnd;
   if (BorderStyle=bsNone) and AutoSize then Frame.AdjustHeight;
   SetEditRect;

   if IsTransparentEffective then
   begin
     wwDisableParentClipping(Parent);
   end
end;


procedure TwwIncrementalSearch.SetEditRect;
var
  Loc: TRect;
begin
  if not Frame.enabled then exit;

  Loc.Bottom :=ClientHeight+1;
  Loc.Right := ClientWidth-1;

  Frame.GetEditRectForFrame(Loc);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;


procedure TwwIncrementalSearch.WMPaint(var Message: TWMPaint);
var
  PS: TPaintStruct;
  Indent, Left: Integer;
  ARect: TRect;
  DC: HDC;
  TempLeft, TempIndent: integer;
  WriteOptions: TwwWriteTextOptions;
//  r: TRect;

  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;

begin
  if ((not Frame.enabled) or FFocused) then
  begin
     inherited;
     if Frame.enabled then
     begin
       CanvasNeeded;
       FCanvas.Handle:= message.DC;
       wwDrawEdge(self, Frame, FCanvas, FFocused);
       FCanvas.Handle:= 0;
     end;
     Exit;
  end;

  { if not editable with focus, need to do drawing to show proper focus }
  CanvasNeeded;

  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;

    with FCanvas do
    begin
      ARect := ClientRect;

      if (not enabled) and (color<>clInactiveCaption) then font.color:= clInactiveCaption;
      Brush.Color := Color;

      // 4/15/01 - Back-color support
      if (not IsTransparentEffective) then
      begin
         if Frame.Enabled and (not FFocused) and (Frame.NonFocusColor<>clNone) then
         begin
            Brush.Color:= Frame.NonFocusColor;
            FillRect (ARect);
         end
      end;

      ARect:= ClientRect;
      InflateRect(ARect, -1, -1);  {Added for csDropDownList style }

//      Width := TextWidth(Text);

      Indent:= 1;

      if Frame.enabled then {IsTransparentEffective then}
      begin
         Frame.GetFrameTextPosition(Left, Indent, FFocused);
      end
      else Left:= Indent + 1;

      { 12/20/96 - Support multiple lines }
      TempIndent:= Indent;
      TempLeft:= Left;

      WriteOptions:= [wtoTransparent];

      if (not FFocused) and IsTransparentEffective and (Frame.NonFocusTransparentFontColor<>clNone) then
         FCanvas.Font.Color:= Frame.NonFocusTransparentFontColor
      // 4/15/01
      else if (not FFocused) and (Frame.Enabled) and
              (Frame.NonFocusFontColor<>clNone) then
         FCanvas.Font.Color:= Frame.NonFocusFontColor;

      wwWriteTextLinesT(FCanvas, ARect, TempLeft-1, TempIndent-1,
                Pchar(Text), taLeftJustify, WriteOptions);

    end;

    if Frame.enabled then
    begin
       wwDrawEdge(self, Frame, FCanvas, FFocused);
    end;

  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure TwwIncrementalSearch.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if (IsTransparentEffective and not FFocused) then
  begin
     Message.result:= 1;
  end
  else
     inherited;
end;

procedure TwwIncrementalSearch.CNKeyDown(var Message: TWMKeyDown);
begin
  if not (csDesigning in ComponentState) then with Message do
  begin
       { 1/4/2000 es_multiline style does not pass carriage return/line feed to form so
         we pass it ourselves }
       if ((charcode=vk_return) or (charcode=vk_escape)) then
       begin
//          if (not modified) or (charcode = vk_return) then { 5/19/00 - This test causes escape to fail when its modified }
            if (Windows.GetWindowLong(handle, GWL_STYLE) and es_multiline)<>0 then
            begin
               SendMessage(GetParent(Handle), TMessage(Message).Msg,
                 TMessage(Message).wParam, TMessage(Message).lParam);
            end
       end;
  end;
  inherited; { 1/31/2000 - Fix problem of tab not being passed }
end;

// 11/9/01 - Some fonts change the margin, so let us reset back to 0 so that
// borders will be ok
procedure TwwIncrementalSearch.WMSetFont(var Message: TWMSetFont);
begin
  inherited;
  if Frame.Enabled and NewStyleControls then
     SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, 0);
end;

end.
