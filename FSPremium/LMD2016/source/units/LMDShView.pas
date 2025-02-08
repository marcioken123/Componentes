unit LMDShView;
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

LMDShView unit (DS)
------------------------
Contains shell view interface (MVC).


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  ShlObj,
  LMDShBase;
  const
  IID_ILMDShellView : TGUID = '{3E2D823C-8076-4FB1-8676-CE94E56ED34F}';

type
  {****************************************************************************}
  TLMDShellItemFilter = procedure(Sender : TObject; ShellItem : TLMDCustomShellItem; var Accept : Boolean) of object;

  {****************************************************************************}
  TLMDShellItemEvent = procedure(Sender : TObject; Item : TLMDCustomShellItem) of object;

  {****************************************************************************}
  //TLMDShellInfoEvent = procedure (Sender: TObject; Count: LongInt; Size: Int64) of object;

  {****************************************************************************}
  ILMDShellView = interface
    ['{3E2D823C-8076-4FB1-8676-CE94E56ED34F}']
    procedure BeginUpdate;
    procedure EndUpdate;

    procedure BeginEnumeration;
    procedure EndEnumeration;
    function TerminateEnumeration : boolean;    
    procedure AddItem(aItem : TLMDCustomShellItem);
    procedure ActiveFolderChanged;
    function  Controller:TLMDCustomShellController;

    procedure DoFileChange(aPIDL : PItemIDList);
    procedure DoFileCreate(aPIDL : PItemIDList);
    procedure DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoFolderChange(aPIDL : PItemIDList);
    procedure DoFolderCreate(aPIDL : PItemIDList);
    procedure DoFolderDelete(aPIDL : PItemIDList);
    procedure DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);

  end;

  {****************************************************************************}
  ILMDShellEdit = interface
    ['{CF5219D0-A7F6-494D-9329-D38F24217EEC}']
    function Editable:Boolean;
    function CanCut:Boolean;
    function CanCopy:Boolean;
    function CanDelete:Boolean;
    function CanPaste:Boolean;
    function CanRename:Boolean;
    function CanAccessItem:Boolean;

    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    procedure DeleteItems;
    procedure ShowProperties;
    procedure CopyFileNameAsText;
    procedure CopyPathAsText;
    function  NewFolder: Boolean;
    procedure Open;
    procedure OpenWith;
    function  Rename: Boolean;

    procedure CopyItems(const Target:String);
    procedure MoveItems(const Target:String);

    procedure ExecuteCommand(const Verb: String; var Handled: Boolean);
  end;

implementation

end.
