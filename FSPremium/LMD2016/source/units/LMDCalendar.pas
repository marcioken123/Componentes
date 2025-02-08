unit LMDCalendar;
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

LMDCalendar unit (JH)
---------------------

calendar class

wrapper for TLMDCustomCalendar - makes props visible

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDCal;

type
  TLMDCalendar = class (TLMDCustomCalendar)
  public
    property DockManager;
  published
    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;

    property About;
    property Align;
    property BackFX;
    property FaceController;
    property Bevel;
    property CellStyle;
    property Cursor;
    property Date;
    property Day;
    property DayCaptionCellStyle;
    property DayCaptions;
    property DayDirection;
    property DragMode;
    property DragCursor;
    property FillObject;
    property FixedDimens;
    property Flat;
    property GridPen;
    property Header;
    property Height;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property ImageList;
    property InactiveCellStyle;
    property Left;
    property ListIndex;
    property MarkedCellStyle;
    property Marked2CellStyle;
    property MarkedDay;
    property MarkedDay2;
    property Month;
    property Name;
    property PopupMenu;
    property ReadOnly;
    property SelectedCellStyle;
    property ShowDayHint;
    property ShowGrid;
    property ShowHint;
    property ShowSpecialDayHint;
    property SpecialDates;
    property StartDay;
    property StartWithActualDate;
    property TabOrder;
    property TabStop;
    property Tag;
    property Top;
    property Transparent;
    property UseLongDayNames;
    property Width;
    property Year;
    { events }
    property OnClick;
    property OnDayChange;
    property OnDateSel;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDraw;
    property OnEndDrag;
    property OnKeyPressed;
    property OnMonthChange;
    property OnMouseClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnStartDrag;
    property OnYearChange;
    property OnGetCellSettings;    
  end;

implementation

end.
