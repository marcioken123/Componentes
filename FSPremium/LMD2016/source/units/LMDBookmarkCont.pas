unit LMDBookmarkCont;
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

LMDBookmarkCont unit ()
-----------------------

Database bookmarks container component.

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
  LMDBookmarkList,
  LMDCustomComponent;

type
  TLMDBookmarkCont=class(TLMDCustomComponent)
  private
    FBookList:TLMDBookmarkList;
    FGotoBook:Integer;
    FDataLink:TFieldDataLink;
    FUniqueBookmarks : Boolean;
    FOnAfterAdd,
    FOnAfterGoto,
    FOnAfterDelete : TNotifyEvent;
    procedure SetUniqueBookmarks (aValue : Boolean);
    function GetCount : Integer;
    procedure SetGotoBook (aValue : Integer);
    procedure SetDataSource (aValue : TDataSource);
    function GetDatasource : TDataSource;
  protected
    property Bookmarks : TLMDBookmarkList read FBookList;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure GotoBookmark;
    procedure AddBookmark;
    procedure DeleteBookmark;
    function IsBookmarked : Boolean;
  published
    property About;
    property Count : Integer read GetCount;
    property Bookmark : Integer read FGotoBook write SetGotoBook default -1;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property UniqueBookmarks : Boolean read FUniqueBookmarks write SetUniqueBookmarks default true;

    property OnAfterGoto : TNotifyEvent read FOnAfterGoto write FOnAfterGoto;
    property OnAfterAdd : TNotifyEvent read FOnAfterAdd write FOnAfterAdd;
    property OnAfterDelete : TNotifyEvent read FOnAfterDelete write FOnAfterDelete;
  end;

implementation

{ ------------------------------- private ------------------------------------ }
procedure TLMDBookmarkCont.SetUniqueBookmarks (aValue : Boolean);
var
  i, j : Integer;
  BM: TBookmark;
begin
  if aValue <> FUniqueBookmarks then
    begin
      FUniqueBookmarks := aValue;
      i := 0;
      if (FUniqueBookmarks) and (Count > 1) then
        while i < Count - 1 do
          begin
            j := i + 1;
            while j < Count do
              begin
                if FDataLink.DataSource.DataSet.CompareBookmarks(
                        FBookList[i], FBookList[j])= 0 then
                  begin
                    BM := FBookList[j];
                    FDataLink.DataSource.DataSet.FreeBookmark (BM);
                    Bookmarks.Delete (j);
                    dec(j);
                  end;
                inc(j);
              end;
            inc(i);
          end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBookmarkCont.SetGotoBook (aValue : Integer);
begin
  if aValue > Count-1 then aValue := Count-1;
  if aValue < 0 then aValue := 0;
  FGotoBook := aValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBookmarkCont.GetCount : Integer;
begin
  if (FDataLink.DataSource = nil) then
    begin
      result := 0;
      exit;
    end;
  result := FBookList.Count;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBookmarkCont.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBookmarkCont.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDBookmarkCont.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  FBookList := TLMDBookmarkList.Create;
  FDataLink := TFieldDataLink.Create;
  FUniqueBookmarks := true;
  FGotoBook := -1;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDBookmarkCont.Destroy;
begin
  FGotoBook := 0;
  while Count > 0 do
    DeleteBookmark;
  FDataLink.Free;
  FBookList.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBookmarkCont.AddBookmark;
var
  i : Integer;
  aVal : TBookmark;
begin
  if (FDataLink.DataSource = nil) then exit;
  i := 0;
  if (FUniqueBookmarks) and (Count > 0) then
    begin
      aVal := FDataLink.DataSource.DataSet.GetBookmark;
      while i < Count do
        begin
          if FDataLink.DataSource.DataSet.CompareBookmarks(TBookmark(FBookList.Items[i]), aVal) = 0 then
            begin
              FDataLink.DataSource.DataSet.FreeBookmark (aVal);
              exit;
            end;
          inc(i);
        end;
    end;

  FBookList.AddBookmark(FDataLink.DataSource.DataSet.GetBookmark);
  if Assigned (FOnAfterAdd) then FOnAfterAdd(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBookmarkCont.DeleteBookmark;
var
  BM: TBookmark;
begin
  if (FGotoBook = -1) or (Count = 0) or (FDataLink.DataSource = nil) then exit;
  BM := Bookmarks[FGotoBook];
  FDataLink.DataSource.DataSet.FreeBookmark (BM);
  Bookmarks.Delete (FGotoBook);
  if FGotoBook > Count then
    FGotoBook := Count - 1;
  if Assigned (FOnAfterDelete) then FOnAfterDelete(self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBookmarkCont.IsBookmarked : Boolean;
var
  FBookmark : TBookmark;
  i : Integer;
begin
  result := false;
  if (FDataLink.DataSource = nil) then exit;
  FBookmark := FDataLink.DataSource.DataSet.GetBookmark;
  try
    i := 0;
    while (i < Count) and (FDataLink.DataSource.DataSet.CompareBookmarks(TBookmark(FBookList.Items[i]), FBookmark) <> 0) do
     inc(i);
    if (i < count) and (FDataLink.DataSource.DataSet.CompareBookmarks(TBookmark(FBookList.Items[i]), FBookmark) = 0) then
      result := true;
  finally
    FDataLink.DataSource.DataSet.FreeBookmark (FBookmark);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBookmarkCont.GotoBookmark;
begin
  if (FGotoBook = -1) or (Count = 0) or (FDataLink.DataSource = nil) then exit;
  if FDataLink.DataSource.DataSet.BookmarkValid (FBookList[FGotoBook]) then
    FDataLink.DataSource.DataSet.GotoBookmark (FBookList[FGotoBook])
  else
    DeleteBookmark;
  if Assigned (FOnAfterGoto) then FOnAfterGoto(self);
end;

end.
 
