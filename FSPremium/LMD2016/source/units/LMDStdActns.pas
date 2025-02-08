unit LMDStdActns;
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

LMDStdActns unit (AH)
---------------------
Standard actions for LMD ActionList

Changes
-------
Release 9.0 (September 2008)
 - Initial Release

###############################################################################}

interface

uses
  Classes, ActnList, StdActns, LMDUtils, LMDUnicodeControl, LMDActnList;

type
  TLMDHintAction = class(THintAction{$IFDEF LMDCOMP17});{$ELSE}{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}{$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUEditAction = class(TEditAction{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUEditCut = class(TEditCut{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUEditCopy = class(TEditCopy{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUEditPaste = class(TEditPaste{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUEditSelectAll = class(TEditSelectAll{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUEditUndo = class(TEditUndo{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUEditDelete = class(TEditDelete{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUWindowAction = class(TWindowAction{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUWindowClose = class(TWindowClose{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUWindowCascade = class(TWindowCascade{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUWindowTileHorizontal = class(TWindowTileHorizontal{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUWindowTileVertical = class(TWindowTileVertical{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUWindowMinimizeAll = class(TWindowMinimizeAll{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUWindowArrange = class(TWindowArrange{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUHelpAction = class(THelpAction{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUHelpContents = class(THelpContents{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUHelpTopicSearch = class(THelpTopicSearch{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUHelpOnHelp = class(THelpOnHelp{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUHelpContextAction = class(THelpContextAction{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUCommonDialogAction = class(TCommonDialogAction{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUFileAction = class(TFileAction{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUFileOpen = class(TFileOpen{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUFileOpenWith = class(TFileOpenWith{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUFileSaveAs = class(TFileSaveAs{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUFilePrintSetup = class(TFilePrintSetup{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  {$IFDEF LMDCOMP7}
  TLMDUFilePageSetup = class(TFilePageSetup{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}
  {$ENDIF IFDEF LMDCOMP7}

  TLMDUFileExit = class(TFileExit{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUSearchAction = class(TSearchAction{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUSearchFind = class(TSearchFind{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUSearchReplace = class(TSearchReplace{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUSearchFindFirst = class(TSearchFindFirst{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUSearchFindNext = class(TSearchFindNext{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUFontEdit = class(TFontEdit{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUColorSelect = class(TColorSelect{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  TLMDUPrintDlg = class(TPrintDlg{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

  {$ifdef LMDCOMP9}
  TLMDUBrowseForFolder = class(TBrowseForFolder{$IFDEF LMDCOMP17});{$ELSE}, ILMDUnicodeAction){$ENDIF}
  {$IFNDEF LMDCOMP17}
  private
    FCaption: WideString;
    FHint: WideString;
    function GetCaption: WideString;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    property Caption: WideString read GetCaption write SetCaption;
  published
   property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}
  {$endif}

implementation
{$IFNDEF LMDCOMP17}
type
  THackLMDActionLink = class(TActionLink);

{ TLMDHintAction }
{ ---------------------------------------------------------------------------- }
procedure TLMDHintAction.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHintAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHintAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHintAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHintAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHintAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUEditAction }
{ ---------------------------------------------------------------------------- }
procedure TLMDUEditAction.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUEditCut }

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditCut.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditCut.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditCut.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditCut.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditCut.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditCut.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUEditCopy }

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditCopy.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditCopy.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditCopy.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditCopy.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditCopy.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditCopy.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUEditPaste }

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditPaste.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditPaste.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditPaste.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditPaste.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditPaste.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditPaste.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUEditSelectAll }

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditSelectAll.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditSelectAll.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditSelectAll.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditSelectAll.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditSelectAll.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditSelectAll.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUEditUndo }

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditUndo.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditUndo.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditUndo.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditUndo.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditUndo.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditUndo.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUEditDelete }

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditDelete.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditDelete.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditDelete.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUEditDelete.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditDelete.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUEditDelete.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUWindowAction }

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowAction.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUWindowClose }

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowClose.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowClose.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowClose.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowClose.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowClose.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowClose.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUWindowCascade }

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowCascade.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowCascade.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowCascade.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowCascade.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowCascade.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowCascade.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUWindowTileHorizontal }

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowTileHorizontal.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowTileHorizontal.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowTileHorizontal.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowTileHorizontal.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowTileHorizontal.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowTileHorizontal.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUWindowTileVertical }

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowTileVertical.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowTileVertical.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowTileVertical.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowTileVertical.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowTileVertical.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowTileVertical.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUWindowMinimizeAll }

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowMinimizeAll.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowMinimizeAll.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowMinimizeAll.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowMinimizeAll.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowMinimizeAll.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowMinimizeAll.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUWindowArrange }

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowArrange.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowArrange.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowArrange.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUWindowArrange.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowArrange.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUWindowArrange.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUHelpAction }

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpAction.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpAction.GetHint: WideString;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUHelpContents }

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpContents.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpContents.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpContents.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpContents.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpContents.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpContents.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUHelpTopicSearch }

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpTopicSearch.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpTopicSearch.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpTopicSearch.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpTopicSearch.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpTopicSearch.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpTopicSearch.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUHelpOnHelp }

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpOnHelp.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpOnHelp.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpOnHelp.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpOnHelp.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpOnHelp.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpOnHelp.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUHelpContextAction }

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpContextAction.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpContextAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpContextAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUHelpContextAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpContextAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUHelpContextAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUCommonDialogAction }

{ ---------------------------------------------------------------------------- }
procedure TLMDUCommonDialogAction.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUCommonDialogAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUCommonDialogAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUCommonDialogAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUCommonDialogAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUCommonDialogAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUFileAction }

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileAction.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUFileOpen }

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileOpen.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileOpen.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileOpen.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileOpen.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileOpen.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileOpen.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUFileOpenWith }

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileOpenWith.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileOpenWith.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileOpenWith.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileOpenWith.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileOpenWith.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileOpenWith.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUFileSaveAs }

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileSaveAs.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileSaveAs.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileSaveAs.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileSaveAs.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileSaveAs.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileSaveAs.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUFilePrintSetup }

{ ---------------------------------------------------------------------------- }
procedure TLMDUFilePrintSetup.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFilePrintSetup.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFilePrintSetup.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFilePrintSetup.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFilePrintSetup.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFilePrintSetup.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUFilePageSetup }
{$IFDEF LMDCOMP7}
{ ---------------------------------------------------------------------------- }
procedure TLMDUFilePageSetup.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFilePageSetup.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFilePageSetup.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFilePageSetup.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFilePageSetup.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFilePageSetup.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;
{$ENDIF IFDEF LMDCOMP7}

{ TLMDUFileExit }

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileExit.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileExit.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileExit.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFileExit.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileExit.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFileExit.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUSearchAction }

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchAction.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchAction.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchAction.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchAction.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchAction.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUSearchFind }

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFind.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFind.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchFind.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchFind.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFind.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFind.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUSearchReplace }

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchReplace.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchReplace.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchReplace.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchReplace.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchReplace.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchReplace.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUSearchFindFirst }

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFindFirst.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFindFirst.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchFindFirst.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchFindFirst.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFindFirst.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFindFirst.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUSearchFindNext }

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFindNext.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFindNext.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchFindNext.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUSearchFindNext.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFindNext.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUSearchFindNext.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUFontEdit }

{ ---------------------------------------------------------------------------- }
procedure TLMDUFontEdit.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFontEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFontEdit.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUFontEdit.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFontEdit.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUFontEdit.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUColorSelect }

{ ---------------------------------------------------------------------------- }
procedure TLMDUColorSelect.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUColorSelect.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUColorSelect.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUColorSelect.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUColorSelect.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUColorSelect.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{ TLMDUPrintDlg }

{ ---------------------------------------------------------------------------- }
procedure TLMDUPrintDlg.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUPrintDlg.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUPrintDlg.GetCaption: WideString;
begin
  Result := FCaption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUPrintDlg.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUPrintDlg.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUPrintDlg.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;

{$ifdef LMDCOMP9}
{ TLMDUBrowseForFolder }
{ ---------------------------------------------------------------------------- }
procedure TLMDUBrowseForFolder.Assign(Source: TPersistent);
begin
  inherited;
  LMDAssignAction(Self as ILMDUnicodeAction, Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUBrowseForFolder.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDUBrowseForFolder.GetCaption: WideString;
begin
  Result := FCaption;
end;

function TLMDUBrowseForFolder.GetHint: WideString;
begin
  Result := FHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUBrowseForFolder.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    LMDSetCaptionForTAction(FClients, FCaption);
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUBrowseForFolder.SetHint(const Value: WideString);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    LMDSetHintForTAction(FClients, FHint);
    Change;
  end;
end;
{$endif}
{$ENDIF}

procedure Init;
begin
  RegisterClass(TLMDUEditAction);
  RegisterClass(TLMDUEditCut);
  RegisterClass(TLMDUEditCopy);
  RegisterClass(TLMDUEditPaste);
  RegisterClass(TLMDUEditSelectAll);
  RegisterClass(TLMDUEditUndo);
  RegisterClass(TLMDUEditDelete);
  RegisterClass(TLMDUWindowAction);
  RegisterClass(TLMDUWindowClose);
  RegisterClass(TLMDUWindowCascade);
  RegisterClass(TLMDUWindowTileHorizontal);
  RegisterClass(TLMDUWindowTileVertical);
  RegisterClass(TLMDUWindowMinimizeAll);
  RegisterClass(TLMDUWindowArrange);
  RegisterClass(TLMDUHelpAction);
  RegisterClass(TLMDUHelpContents);
  RegisterClass(TLMDUHelpTopicSearch);
  RegisterClass(TLMDUHelpOnHelp);
  RegisterClass(TLMDUHelpContextAction);
  RegisterClass(TLMDUCommonDialogAction);
  RegisterClass(TLMDUFileAction);
  RegisterClass(TLMDUFileOpen);
  RegisterClass(TLMDUFileOpenWith);
  RegisterClass(TLMDUFileSaveAs);
  RegisterClass(TLMDUFilePrintSetup);
  {$IFDEF LMDCOMP7}
  RegisterClass(TLMDUFilePageSetup);
  {$ENDIF}
  RegisterClass(TLMDUFileExit);
  RegisterClass(TLMDUSearchAction);
  RegisterClass(TLMDUSearchFind);
  RegisterClass(TLMDUSearchReplace);
  RegisterClass(TLMDUSearchFindFirst);
  RegisterClass(TLMDUSearchFindNext);
  RegisterClass(TLMDUFontEdit);
  RegisterClass(TLMDUColorSelect);
  RegisterClass(TLMDUPrintDlg);
  {$ifdef LMDCOMP9}
  RegisterClass(TLMDUBrowseForFolder);
  {$endif}
end;

initialization
  Init;

end.
