unit LMDBookmarkList;
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

LMDBookmarkList unit ()
-----------------------

A list of database bookmarks.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DB,
  Classes,
  Controls;

const
  CM_LMDBOOKMARKCHANGED = CM_BASE + 1;

type
  { -------------------- TLMDBookmarkList ------------------------------------ }
  TLMDBookmarkList=class(TList)
  private
    function GetBookmark(Index: integer):TBookmark;
  protected
  public
    procedure PutBookmark(Index: integer; aValue: TBookmark);
    procedure AddBookmark(aValue: TBookmark);
    property Bookmarks[Index: integer]:TBookmark read GetBookmark write PutBookmark; default;
  end;

implementation

uses
  Windows,
  Forms;

{-------------------------- Private -------------------------------------------}
function TLMDBookmarkList.GetBookmark(Index: integer):TBookmark;
begin
  result := nil;
  if Index>Count-1 then exit;
  result := TBookmark(Items[Index]);
end;

{------------------------------------------------------------------------------}
procedure TLMDBookmarkList.PutBookmark(Index: integer; aValue: TBookmark);
begin
  if Index>Count-1 then exit;
  Items[Index]:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDBookmarkList.AddBookmark(aValue: TBookmark);
begin
  Add(nil);
  PutBookmark(Count-1,aValue);
  PostMessage (Application.Handle, CM_LMDBOOKMARKCHANGED, 0, 0);
end;

end.
 
