unit LMDNoteBook;
{$I lmdcmps.INC}

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

LMDNoteBook unit (RM)
---------------------
Replacement for TNoteBook class with additional features (Transparency,
better Component Editor etc.)

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Menus, StdCtrls, Forms, Messages,
  LMDBase, LMDClass, LMDCustomSheetControl;

type
  TLMDNoteBookPage=class(TLMDCustomSheet)
  published
    property BackFX;
    property BackFXPass;
    property Included;
    property Transparent;
  end;

  TLMDNoteBookPageChangeEvent=procedure(Sender:TObject; NewPage:TLMDNoteBookPage; var Cancel:Boolean) of object;

  {------------------------- TLMDNoteBook -------------------------------------}
  TLMDNoteBook=class(TLMDCustomSheetControl)
  private
    FOnPageChange:TLMDNoteBookPageChangeEvent;
    procedure SetActivePage(aValue:TLMDNoteBookPage);
    function GetPage(Index:Integer):TLMDNoteBookPage;
    function GetActivePage:TLMDNoteBookPage;
  protected
    procedure DoPageChange(NewPage:TLMDCustomSheet; var Cancel:Boolean);override;
  public
    constructor Create(AnOwner: TComponent);  override;
    function GetSheetClass:TLMDSheetClass;override;
    property CtlXP default false;  // compatibility
    property Page[Index:Integer]:TLMDNoteBookPage read GetPage;
  published
    property ActivePage: TLMDNoteBookPage read GetActivePage write SetActivePage;
    property PageIndex;
    property ThemeMode default ttmNone;
    property ThemeGlobalMode;    
    property OnChanging:TLMDNoteBookPageChangeEvent read FOnPageChange write FOnPageChange;
  end;

implementation
uses
  LMDGraph, LMDResWinControl, LMDProcs, LMDGraphUtils, LMDButtonBase;

var
  nbRegistered:Boolean;

{************************ Object TLMDNoteBook *********************************}
{----------------------- private ----------------------------------------------}
procedure TLMDNoteBook.SetActivePage(aValue: TLMDNoteBookPage);
begin
  ActiveSheet:=aValue;
end;

{------------------------------------------------------------------------------}
function TLMDNoteBook.GetActivePage: TLMDNoteBookPage;
begin
  result:=TLMDNoteBookPage(ActiveSheet);
end;

{------------------------------------------------------------------------------}
function TLMDNoteBook.GetPage(Index:Integer):TLMDNoteBookPage;
begin
  Result:=TLMDNoteBookPage(Sheet[Index]);
end;

{----------------------- protected --------------------------------------------}
procedure TLMDNoteBook.DoPageChange(NewPage:TLMDCustomSheet; var Cancel:Boolean);
begin
  if Assigned(FOnPageChange) then
    FOnPageChange(self, TLMDNoteBookPage(NewPage), Cancel);
end;

{----------------------- public -----------------------------------------------}
constructor TLMDNoteBook.Create(AnOwner: TComponent);
begin
  inherited;
  NeedInvalidate:=false;
  FThemeMode := ttmNone;
  if not nbRegistered then
    begin
      RegisterClass(TLMDNoteBookPage);
      nbRegistered:=true;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDNoteBook.GetSheetClass: TLMDSheetClass;
begin
  result:=TLMDNoteBookPage;
end;

initialization
  nbRegistered:=False;

end.

