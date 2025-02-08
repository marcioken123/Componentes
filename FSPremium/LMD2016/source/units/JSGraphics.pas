{ Unit that contains the class for painting formatted text on to
  a Canvas. Also includes a TCustomControl implementation that
  can display formatted text and accept focus.                 }
unit JSGraphics;

interface

{$I lmddlgcmps.inc}
{$WARNINGS OFF}

uses
    Windows
  , Graphics
  {$IFNDEF DELPHI5}
  , Types
  {$ENDIF DELPHI5}
  {$IFDEF DELPHIXE3}
  , System.UITypes
  {$ENDIF DELPHIXE}
  , JSTypes
  {$IFDEF BDS}
  , GraphUtil
  {$ENDIF BDS}
  , JSGraphUtil
  , Contnrs
  , Controls
  , Classes
  , Forms
  , Messages
  ;

const
  { Summary
    Initialised TRect constant that is considered empty. }
  EmptyRect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
  { Summary
    Initialised TPoint constant that is considered empty. }
  EmptyPoint: TPoint = (x: 0; y: 0);
  { Summary
    Cursor value for the default handpoint cursor. }
  crJSHand = 3124;

type
  { Summary
    Contains a list of all TJSLinkRect instances for a TJSCaption descendant.
    Description
    This class holds all of the TJSLinkRect instances for a TJSCaption descendant. Using this class,
    addition TJSLinkRect instances are added or cleared for a caption.<p />
    <p />
    The TJSLinkRect instances are added to a TObjectList where they are freed once the TJSLinkRects class
    is freed.                                                                                             }
  TJSLinkRects = class
  private
    FLinkRects: TObjectList;
    function GetItem(Index: Integer): TRect;
    procedure SetItem(Index: Integer; const Value: TRect);
    function IsUnique(const aRect: TRect): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    { Summary
      Add a new TJSLinkRect instance.
      Description
      Call the Add method to add a new TJSLinkRect instance to the list of current instances. The aRect
      parameter is the Rect value you want the TJSLinkRect instance to have.                            }
    procedure Add(const aRect: TRect);
    { Summary
      Clears all TJSLinkRect instances.
      Description
      Call Clear to remove all TJSLinkRect instances from the internal list. }
    procedure Clear;
    { Summary
      Determines if a particular point is contained with a TJSLinkRect.
      Description
      Call InLink to determine if a particular X, Y coordinate is within a TJSLinkRect instance.
      Returns
      Returns True if the point is contained within a TJSLinkRect instance.                     }
    function InLink(const X, Y: Integer): Boolean;
    { Summary
      Returns the number of TJSLinkRect instances.
      Description
      Call count to determine how many TJSLinkRect instances there are for the TJSCaption descendant.
      Returns
      Returns the number of TJSLinkRect instances.                                                   }
    function Count: Integer;
    { Summary
      Allows access to each of the TJSLinkRect instance by index.
      Description
      Access each of the TJSLinkRect instances by index.          }
    property Items[Index: Integer]: TRect read GetItem write SetItem; default;
  end;

  { Summary
    Contains the location of the link in the TJSCaption descendant.
    Description
    This class holds the Rect value of the link in a TJSCaption descendant. It is possible that one
    single link has more than one TJSLinkRect instance associated with it. This is due to the fact that
    links that wrap within the dialog need more than one TJSLinkRect instance to describe the true
    location of the entire link.                                                                        }
  TJSLinkRect = class
  private
    FRect: TRect;
  public
    constructor Create(const aRect: TRect);
    { Summary
      Specifies the location of the link (or part of) within a TJSCaption descendant.
      Description
      Specifies the location of the link (or part of) within a TJSCaption descendant.
      See Also
      TJSLinkRect                                                                     }
    property Rect: TRect read FRect write FRect;
  end;

  { Summary
    Contains information about a link found in the text property of a TJSCaption descendant class.
    Description
    Contains the Link and the Text associated with the link which was found in the text property of a
    TJSCaption descendant class.                                                                      }
  TJSLinkInfo = class
  public
    { Summary
      Contains the text associated with the link.
      Description
      This is the text description associated with the link. The text description is what the user sees on
      the dialog.<p />
      There is no reason that the Link and Text properties could not be the same values.                   }
    Text: TJSString;
    { Summary
      Contains the value of the link.
      Description
      This is the actual link that needs to be navigated to when this link has been clicked on. }
    Link: TJSString;
    constructor Create(const aText, aLink: TJSString);
  end;

  { Summary
    The TJSCaption class has the ability to draw html formatted text.
    Description
    The following html tags are supported for formatting text:
      < b > for <b>Bold</b> text.
      < i > for <i>Italic</i> text.
      < u > for <u>Underlined</u> text.

      Tags cannot be embedded. Once you have opened a tag, that tag must be completed before opening another tag. }
  TJSCaption = class
  private
    FLinkRects: TJSLinkRects;
    FLinkInfo: TJSLinkInfo;
    FBackground: TJSBackground;
    FCaption: TJSString;
    FCanvas: TCanvas;
    FRawCaption: TJSString;
    FCaptionSegments: TJSWideStringList;
    FWidth: Integer;
    FHeight: Integer;
    FColor: TColor;
    FFont: TFont;
    FLinkFont: TFont;
    FLeft: Integer;
    FTop: Integer;
    FOffSet: TPoint;
    FTreatAsLink: Boolean;
    FBidiMode: TBiDiMode;
    FControl: TControl;
    procedure SetColor(const Value: TColor);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetFont(const Value: TFont);
    procedure SetCaption(const Value: TJSString);
    procedure GetFormatingForSegment(var AUPos: Integer; var APosEnd: Integer;
      out AIsUnderline: Boolean; out AIsBold: Boolean; ACaption: TJSString;
      var APos: Integer; var AIPos: Integer; out AIsItalic: Boolean;
      var ALPos: Integer; out AIsLink: Boolean);
    procedure SetBackground(const Value: TJSBackground);
    procedure SetLinkFont(const Value: TFont);
  protected
    FRequiredHeight: Integer;
    { Summary
      Analyses the caption and places all parts of the caption into a list.
      Description
      Analyses the caption for formatting or link tags and places all element types into a list object.
      The list object is then used to paint the caption on the Canvas provided. }
    procedure ParseCaption; virtual;
    { Summary
      Paints the caption.
      Description
      Paint the caption on the provided Canvas. If the ADoPaint parameter is false, then nothing is
      actually painted on the provided Canvas. If ADoPaint is false, then generally the required height of the
      Canvas is being calculated. }
    procedure PaintCaption(const ADoPaint: Boolean); overload;
  public
    constructor Create(ACanvas: TCanvas; const ACaption: TJSString; const ABackground: TJSBackground;
      const AFont: TFont; const AHeight, AWidth: Integer; const AOffSet: TPoint; AControl: TControl = nil; const ABiDiMode: TBiDiMode = bdLeftToRight); reintroduce; virtual;
    destructor Destroy; override;
    { Summary
      Returns the link rect for the specified index. }
    function GetLinkRect(const AIndex: Integer): TRect;
    { Summary
      Returns the number of links for the caption. }
    function LinkRectCount: Integer;
    { Summary
      Returns True if the mouse position is located in the bounds of a link within the caption. }
    function MouseInLink(const AX, AY: Integer): Boolean;
    { Summary
      Method to paint a caption to the desired canvas. }
    class procedure PaintCaption(ACanvas: TCanvas; const ACaption: TJSString;
      ABackground: TJSBackground; const AFont: TFont; const ALeft, ATop, AWidth, AHeight: Integer;
      const AOffSet: TPoint; AControl: TControl; const BiDiMode: TBiDiMode); overload;
    { Summary
      Method to paint a caption to the desired canvas. }
    class procedure PaintCaption(ACanvas: TCanvas; const ACaption: TJSString;
      ABackground: TJSBackground; const AFont: TFont; const ARect: TRect; const AOffSet: TPoint); overload;
    { Summary
      Method to paint a caption to the desired canvas. }
    class procedure PaintCaption(ACanvas: TCanvas; const ACaption: TJSString;
      ABackground: TJSBackground; const AFont: TFont; const ARect: TRect); overload;
    { Summary
      Method to paint a caption to the desired canvas. }
    class procedure PaintCaption(ACanvas: TCanvas; const ACaption: TJSString;
      ABackground: TJSBackground; const AFont: TFont; const ARect: TRect; AControl: TControl; const BiDiMode: TBiDiMode); overload;
    { Summary
      Returns the minimum height that is required to draw the given caption with the desired width.
      Description
      The TJSCaption class does not calculate a best fit for the caption.
      Remarks
      The width parameter must always be known. }
    class function MinimumHeight(ACanvas: TCanvas; const ACaption: TJSString; const AFont: TFont;
      const AWidth: Integer): Integer;
    { Summary
      Returns the minimum width required for the caption to be drawn.
      Description
      Calculate the maximum length of a line for the ACaption value while allowing the AWidth parameter to be
      the longest long allowed for the caption. Generally this method will return a value smaller than the
      AWidth parameter value, due to the caption requiring to wrap as longer words do not fit on the rest of
      a line.
      Remarks
      The width parameter must always be known. }
    class function MinimumWidth(ACanvas: TCanvas; const ACaption: TJSString; const AFont: TFont;
      const AWidth: Integer): Integer;
    { Summary
      Transform a TRect value into the required TRect format for the TJSCaption class.
      Description
      The TJSCaption class requires the ARect parameter in the PaintCaption and Create methods to have
      the Bottom and Right parameters to actually reflect the Height and Width of the area to be painted.

      Call TranslateRect to create the desired TRect format for the functions mentioned above. }
    class function TranslateRect(const ARect: TRect): TRect;
    { Summary
      Force an update to the Caption instance.
      Description
      This method should be called sparingly, instead you should rely on the control that owns the Canvas
      being drawn on to invalidate the caption when required. }
    procedure Paint; virtual;
    { Contains information about the captions background. }
    property Background: TJSBackground read FBackground write SetBackground;
    { Summary
      The canvas that the caption is to be drawn on.
      Description
      Set the canvas at the time of creating the TJSCaption instance. }
    property Canvas: TCanvas read FCanvas;
    { The text that will be painted on the Canvas provided. }
    property Caption: TJSString read FCaption write SetCaption;
    { The background color of the text that will be painted on the Canvas provided. }
    property Color: TColor read FColor write SetColor;
    { The font used for painting the text. }
    property Font: TFont read FFont write SetFont;
    { The font used for painting link text. }
    property LinkFont: TFont read FLinkFont write SetLinkFont;
    { The height of the caption area. }
    property Height: Integer read FHeight write SetHeight;
    { The width of the caption area. }
    property Width: Integer read FWidth write SetWidth;
    { Summary
      Paint all text as thought they are links.
      Description
      Set TreatAsLink to True when you want then entire caption to be formatted as a link. }
    property TreatAsLink: Boolean read FTreatAsLink write FTreatAsLink;
  end;

  { Summary
    Event triggered when a link has been clicked on }
  TJSLinkClickEvent = procedure (Sender: TObject; const Link: TJSString; var Handled: Boolean) of object;

  { Summary
    Publishable implementation of the TPoint type
    Description: The TJSPoint class can be used to represent a TPoint property on a component. }
  TJSPoint = class(TPersistent)
  private
    FX: Integer;
    FY: Integer;
    FOnChange: TNotifyEvent;
    procedure SetX(const Value: Integer);
    procedure SetY(const Value: Integer);
  protected
    { Triggers the OnChange event. }
    procedure DoChange; virtual;
  public
    { Assign the values of different TJSPoint to this instance. }
    procedure Assign(Source: TPersistent); override;
    constructor Create;
    { Return the values as TPoint. }
    function AsPoint: TPoint;
    { Event that is triggered whenever the X or Y values are updated. }
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    { Value for X. }
    property X: Integer read FX write SetX default 0;
    { Value for Y. }
    property Y: Integer read FY write SetY default 0;
  end;

  { Base implementation of the formatted caption control }
  TJSCustomCaptionControl = class(TCustomControl)
  private
    FCaption: TJSCaption;
    FText: TJSWideStringList;
    FLinkFont: TFont;
    FOnLinkClick: TJSLinkClickEvent;
    FBorderStyle: TBorderStyle;
    FBackground: TJSBackground;
    FOffSet: TJSPoint;
    FAutoSize: Boolean;
    FTreatAsLink: Boolean;
    procedure LinkFontChanged(Sender: TObject);
    procedure OffSetChanged(Sender: TObject);
    procedure SetText(const Value: TJSWideStringList);
    procedure SetLinkFont(const Value: TFont);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetOffSet(const Value: TJSPoint);
    procedure TextChangedHandler(Sender: TObject);
    procedure SetTreatAsLink(const Value: Boolean);
    procedure SetBackground(const Value: TJSBackground);
  protected
    { Summary
      Method called to adjust the size of the control.
      Description
      The AdjustBounds method is called when the Autosize property is true. The controls bounds is
      automatically sized to accommodate the content it has to display.                            }
    procedure AdjustBounds; virtual;
    { Summary
      Function that returns the availablity of painting links in the text. }
    function CanUseLink: Boolean; {$IFDEF INLINE}inline;{$ENDIF INLINE}
    procedure Click; override;
    procedure CMColorchanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CreateParams(var Params: TCreateParams); override;
    { Summary
      Method to call the OnLinkClick event.
      Description
      Override this event in descendants to perform a before and/or after action when a link is clicked. }
    procedure DoLinkClick; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    { AutoSize will automatically adjust the height of the control }
    property AutoSize: Boolean read FAutoSize write FAutoSize default True;
    { Background values to use when painting the caption }
    property Background: TJSBackground read FBackground write SetBackground;
    { Use to set the border style of the control }
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsNone;
    { The font attributes to use when painting a link in the Text }
    property LinkFont: TFont read FLinkFont write SetLinkFont;
    { The text that the control is to paint on its canvas.
      You can insert formatting into the text by using simple html tags.
        b tag for <b>Bold</b>
        i tag for <i>Italic</i>
        u tag for <u>Underline</u>
        a tag for <a href="http://www.lmd.de">LMD Innovative Home Page</a>

      <b>Note: </b>You cannot embed tags, which means each tag must be closed before
      using another one.
    }
    property Text: TJSWideStringList read FText write SetText;
    { Event triggered when the user clicks on a Link within the text. Handling this event
      is optional as by default ShellExecuteW is called with the 'Open' parameter.

      If you need to override the default handling, handle this event and set the Handled
      parameter of the event to True. }
    property OnLinkClick: TJSLinkClickEvent read FOnLinkClick write FOnLinkClick;
    { The OffSet in which to start painting the text. Values are in pixels and are read
      from the top left corner of the Canvas. }
    property OffSet: TJSPoint read FOffSet write SetOffSet;
    { Summary
      Specifies that the entire text should be treated as it is a link.
      Description
      When TreatAsLink is True the text of the TJSCaption descendant is painted using the LinkFont
      information and the mouse cursor when moved or hovered over the text always shows a handpoint. }
    property TreatAsLink: Boolean read FTreatAsLink write SetTreatAsLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Summary
      Specifies the number of links with in the caption.
      This method should be used to determine if the TabStop property should be turned off. }
    function HasLinks: Boolean;
  end;

  { Published implementation of the formatted caption control }
  TJSCaptionControl = class(TJSCustomCaptionControl)
  public
    { Summary
      Occurs when the user clicks the control.
      Description
      Use the OnClick event handler to respond when the user clicks the control. If the control has an
      associated action, and that action has an OnExecute method, the action's OnExecute method responds to
      click events unless it is superseded by an OnClick event handler.<p />
      <p />
      Usually, OnClick occurs when the user presses and releases the left mouse button with the mouse
      pointer over the control. This event can also occur when:<p />
      <p />
      The user selects an item in a grid, outline, list, or combo box by pressing an arrow key.<p />
      The user presses the SPACEBAR while a button or check box has focus.<p />
      The user presses ENTER when the active form has a default button (specified by the Default property).<p />
      The user presses ESC when the active form has a cancel button (specified by the Cancel property).<p />
      The user presses the accelerator key for a button or check box. For example, if the value of the
      Caption property of a check box is '&amp;Bold', the B is underlined at run time and the OnClick event
      of the check box is triggered when the user presses Alt+B. However, focus does not move to the
      control in these instances.<p />
      The Checked property of a radio button is set to <b>True</b>.<p />
      The value of the Checked property of a check box is changed.<p />
      The Click method of a menu item is called.<p />
      For a form, an OnClick event occurs when the user clicks a disabled component or in a blank area of
      the form.<p />
      <p />
      OnClick is an event handler of type TNotifyEvent.                                                          }
    property OnClick;
  published
    { Summary
      Determines how the control aligns within its container (parent control).
      Description
      Use Align to align a control to the top, bottom, left, or right of a form or panel and have it remain
      there even if the size of the form, panel, or component that contains the control changes. When the
      parent is resized, an aligned control also resizes so that it continues to span the top, bottom,
      left, or right edge of the parent.<p />
      <p />
      For example, to use a panel component with various controls on it as a tool palette, change the
      panel's Align value to alLeft. The value of alLeft for the Align property of the panel guarantees
      that the tool palette remains on the left side of the form and always equals the client height of the
      form.<p />
      <p />
      The default value of Align is alNone, which means a control remains where it is positioned on a form
      or panel.<p />
      <p />
      <b>Tip</b>: If Align is set to alClient, the control fills the entire client area so that it is
      impossible to select the parent form by clicking it. In this case, select the parent by selecting the
      control on the form and pressing Esc, or by using the Object Inspector.<p />
      Any number of child components within a single parent can have the same Align value, in which case
      they stack up along the edge of the parent. The child controls stack up in z-order. To adjust the
      order in which the controls stack up, drag the controls into their desired positions.<p />
      <p />
      <b>Note</b>: To cause a control to maintain a specified relationship with an edge of its parent, but
      not necessarily lie along one edge of the parent, use the Anchors property instead.                   }
    property Align;
    { Summary
      Specifies how the control is anchored to its parent.
      Description
      Use Anchors to ensure that a control maintains its current position relative to an edge of its
      parent, even if the parent is resized. When its parent is resized, the control holds its position
      relative to the edges to which it is anchored.<p />
      <p />
      If a control is anchored to opposite edges of its parent, the control stretches when its parent is
      resized. For example, if a control has its Anchors property set to [akLeft, akRight], the control
      stretches when the width of its parent changes.<p />
      <p />
      Anchors is enforced only when the parent is resized. Thus, for example, if a control is anchored to
      opposite edges of a form at design time and the form is created in a maximized state, the control is
      not stretched because the form is not resized after the control is created.<p />
      <p />
      <b>Note</b>: If a control should maintain contact with three edges of its parent (hugging one side of
      the parent and stretching the length of that side), use the Align property instead. Unlike Anchors,
      Align allows controls to adjust to changes in the size of other aligned sibling controls as well as
      changes to the parent's size.                                                                         }
    property Anchors;
    property AutoSize;
    property Background;
    { Summary
      Specifies the bidirectional mode for the control.
      Description
      Use BiDiMode to enable the control to adjust its appearance and behavior automatically when the
      application runs in a locale that reads from right to left instead of left to right. The
      bidirectional mode controls the reading order for the text, the placement of the vertical scroll bar,
      and whether the alignment is changed.<p />
      <p />
      Alignment does not change for controls that are known to contain number, date, time, or currency
      values. For example, with data-aware controls, the alignment does not change for the following field
      types: ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,
      ftAutoInc.                                                                                            }
    property BiDiMode;
    { Summary
      Specifies the background color of the control.
      Description
      Use Color to read or change the background color of the control.<p />
      <p />
      If a control's ParentColor property is True, then changing the Color property of the control's parent
      automatically changes the Color property of the control. When the value of the Color property is
      changed, the control's ParentColor property is automatically set to <b>False</b>.                     }
    property Color;
    { Summary
      Specifies the attributes of text written on or in the control.
      Description
      To change to a new font, specify a new TFont object. To modify a font, change the value of the
      Charset, Color, Height, Name , Pitch, Size, or Style of the TFont object.<p />
      <p />
      <b>Note</b>: Changing the font color of the Caption is not supported for some controls (such as
      TButton). In most cases, there is an alternate control you can use whose Font property will change
      the color of the caption or text (such as TBitBtn or TSpeedButton).                                }
    property Font;
    { Summary
      Specifies the vertical size of the control in pixels.
      Description
      Use the Height property to read or change the height of the control. }
    property Height;
    property LinkFont;
    property OffSet;
    { Summary
      Specifies whether the control uses its parent's BiDiMode.
      Description
      Use ParentBiDiMode to get or set whether the control uses its parent's BiDiMode. When ParentBiDiMode
      is true, the control's BiDiMode property is always equal to that of its parent. If ParentBiDiMode is
      false, the control uses its own BiDiMode property.<p />
      <p />
      Set ParentBiDiMode to true for all controls in a form to ensure that the entire user interface
      adjusts to Middle Eastern locales in a uniform manner.<p />
      <p />
      When the value of the control's BiDiMode property changes, ParentBiDiMode becomes false
      automatically.                                                                                       }
    property ParentBiDiMode;
    { Summary
      Specifies where a control looks for its color information.
      Description
      To have a control use the same color as its parent control, set ParentColor to true. If ParentColor
      is false, the control uses its own Color property.<p />
      <p />
      Set ParentColor to true for all controls to ensure that all the controls on a form have a uniform
      appearance. For example, if ParentColor is true for all controls in a form, changing the background
      color of the form to gray causes all the controls on the form to also have a gray background.<p />
      <p />
      When the value of a control's Color property changes, ParentColor becomes false automatically.      }
    property ParentColor default False;
    { Summary
      Specifies where a control looks for its font information.
      Description
      To have a control use the same font as its parent control, set ParentFont to true. If ParentFont is
      false, the control uses its own Font property. Many controls default ParentFont to true so that all
      the controls in a form or other container present a uniform appearance. When the value of a control's
      Font property changes, ParentFont becomes false automatically.<p />
      <p />
      When ParentFont is true for a form, the form uses the default font.                                   }
    property ParentFont;
    { Summary
      Determines whether the user can tab to a control.
      Description
      Use the TabStop to allow or disallow access to the control using the Tab key.<p />
      <p />
      If TabStop is True, the control is in the tab order. If TabStop is False, the control is not in the
      tab order and the user can't press the Tab key to move to the control.<p />
      <p />
      <b>Note</b>: TabStop is not meaningful for a form unless the form assigns another form to be its
      parent.                                                                                             }
    property TabStop default True;
    property Text;
    property TreatAsLink default False;
    { Summary
      Specifies whether the component appears onscreen.
      Description
      Use the Visible property to control the visibility of the control at run time. If Visible is True,
      the control appears. If Visible is False, the control is not visible.

      Calling the Show method sets the control's Visible property to True. Calling the Hide method sets it to False. }
    property Visible;
    { Summary
      Specifies the horizontal size of the control in pixels.
      Description
      Use the Width property to read or change the width of the control. }
    property Width;
  end;

implementation

uses
  SysUtils, ShellAPI, JSUnicode;

const
  { Used internally by the TJSCaption class }
  NEWLINE = '<NEWLINE>'; // not to be localised

resourcestring
  { Exception raised when either TJSLinkRects.GetItem or TJSLinkRects.SetItem
    is called with an invalid index }
  StrInvalidIndex = 'Invalid index';
  
{ TJSCaption }

constructor TJSCaption.Create(ACanvas: TCanvas;
  const ACaption: TJSString; const ABackground: TJSBackground; const AFont: TFont;
  const AHeight, AWidth: Integer; const AOffSet: TPoint; AControl: TControl = nil;
  const ABiDiMode: TBiDiMode = bdLeftToRight);
begin
  inherited Create;
  FLinkRects := TJSLinkRects.Create;
  FLinkInfo := TJSLinkInfo.Create('', '');
  FCaptionSegments := TJSWideStringList.Create;
  FCanvas := ACanvas;
  FCaption := ACaption;
  FHeight := AHeight;
  FWidth := AWidth;
  FLeft := 0;
  FTop := 0;
  FColor := ABackground.Color;
  FOffSet := AOffSet;
  FFont := TFont.Create;
  FFont.Assign(AFont);
  FLinkFont := TFont.Create;
  FLinkFont.Assign(AFont);
  FLinkFont.Color := clBlue;
  FLinkFont.Style := FLinkFont.Style + [fsUnderline];
  FBackground := TJSBackground.Create(ABackground.Color, ABackground.Gradient, ABackground.CopyRect, ABackground.Buffered);
  FBidiMode := ABiDiMode;
  FControl := AControl;
  ParseCaption;
end;

destructor TJSCaption.Destroy;
begin
  FFont.Free;
  FLinkFont.Free;
  FCaptionSegments.Free;
  FBackground.Free;
  FLinkRects.Free;
  FLinkInfo.Free;
  inherited;
end;

procedure TJSCaption.Paint;
begin
  PaintCaption(True);
end;

class procedure TJSCaption.PaintCaption(ACanvas: TCanvas;
  const ACaption: TJSString; ABackground: TJSBackground; const AFont: TFont;
  const ALeft, ATop, AWidth, AHeight: Integer; const AOffSet: TPoint; AControl: TControl; const BiDiMode: TBiDiMode);
var
  lFC: TJSCaption;
begin
  if AHeight < 0 then
    Exit;
  lFC := TJSCaption.Create(ACanvas, ACaption, ABackground, AFont, AHeight, AWidth, AOffSet, AControl, BiDiMode);
  try
    lFC.FLeft := ALeft;
    lFC.FTop := ATop; 
    lFC.PaintCaption(True);
  finally
    lFC.Free;
  end;
  if ABackground.AutoFree then
    FreeAndNil(ABackground);
end;

procedure TJSCaption.GetFormatingForSegment(var AUPos: Integer; var APosEnd: Integer;
  out AIsUnderline: Boolean; out AIsBold: Boolean; ACaption: TJSString;
  var APos: Integer; var AIPos: Integer; out AIsItalic: Boolean; var ALPos: Integer; out AIsLink: Boolean);
begin
  AIsBold := False;
  AIsUnderline := False;
  AIsItalic := False;
  AIsLink := False;
  APos := POS('<b>', ACaption);
  APosEnd := POS('</b>', ACaption);
  AUPos := POS('<u>', ACaption);
  AIPos := POS('<i>', ACaption);
  ALPos := POS('<a', ACaption);
  if (APos > 0) and (APosEnd > APos) and
    (((APos < AUPos) or (AUPos = 0)) and
    ((APos < AIPos) or (AIPos = 0)) and
    ((APos < ALPos) or (ALPos = 0))) then
  begin
    if (APos > 0) and (APosEnd > 0) then
      AIsBold := True;
  end
  else
  begin
    APos := POS('<u>', ACaption);
    if APos > 0 then
      APosEnd := POS('</u>', ACaption);
    if (APos > 0) and (APosEnd > 0) and
      ((APos < AIPos) or (AIPos = 0)) and
      ((APos < ALPos) or (ALPos = 0)) then
      AIsUnderline := True
    else
    begin
      APos := POS('<i>', ACaption);
      if APos > 0 then
        APosEnd := POS('</i>', ACaption);
      if (APos > 0) and (APosEnd > 0) and ((APos < ALPos) or (ALPos = 0)) then
        AIsItalic := True
      else
      begin
        APos := POS('<a', ACaption);
        if APos > 0 then
          APosEnd := POS('</a>', ACaption);
        if (APos > 0) and (APosEnd > 0) then
          AIsLink := True
        else
          APos := -1;
      end;
    end;
  end;
end;

function TJSCaption.GetLinkRect(const AIndex: Integer): TRect;
begin
  if (AIndex > -1) and (AIndex < LinkRectCount) then
    Result := FLinkRects[AIndex]
  else
    Result := EmptyRect;
end;

function TJSCaption.LinkRectCount: Integer;
begin
  Result := FLinkRects.Count;
end;

class function TJSCaption.MinimumHeight(ACanvas: TCanvas; const ACaption: TJSString; const AFont: TFont;
  const AWidth: Integer): Integer;
var
  lFC: TJSCaption;
  lBackground: TJSBackground;
begin
  if AWidth > 0 then
  begin
    lBackground := TJSBackground.Create(clNone, nil, Rect(0, 0, 0, 0));
    try
      lFC := TJSCaption.Create(ACanvas, ACaption, lBackground, AFont, -1, AWidth, Point(0, 0));
      try
        lFC.FLeft := 0;
        lFC.FTop := 0;
        lFC.PaintCaption(False);
        result := lFC.Height;
      finally
        lFC.Free;
      end;
    finally
      lBackground.Free;
    end;
  end
  else
    Result := 0;
end;

class function TJSCaption.MinimumWidth(ACanvas: TCanvas; const ACaption: TJSString; const AFont: TFont;
  const AWidth: Integer): Integer;
var
  lCalcFlags: Cardinal;
  lCalcRect: TRect;
begin
  lCalcFlags := DT_CALCRECT or DT_EXPANDTABS or DT_NOPREFIX or DT_WORDBREAK;
  lCalcRect := Rect(0, 0, AWidth, 0);
  ACanvas.Font.Assign(AFont);
  {$IFDEF UNICODE}
  DrawTextW(ACanvas.Handle, PWideChar(ACaption), Length(ACaption), lCalcRect, lCalcFlags);
  {$ELSE}
  DrawText(ACanvas.Handle, PChar(ACaption), Length(ACaption), lCalcRect, lCalcFlags);
  {$ENDIF UNICODE}
  result := lCalcRect.Right;
end;

function TJSCaption.MouseInLink(const AX, AY: Integer): Boolean;
begin
  Result := FLinkRects.InLink(AX, AY);
end;

procedure TJSCaption.PaintCaption(const ADoPaint: Boolean);
var
  lStr: TJSString;
  lOrigStr: TJSString;
  lNewStr: TJSString;
  lOrigNewStr: TJSString;
  lOriginalStr: TJSString;
  lRect: TRect;
  lLinkRect: TRect;
  i, j: Integer;

  lCalcRect: TRect;
  lIsBold: Boolean;

  lDrawFlags: LongInt;
  lCalcFlags: LongInt;

  lBitmap: TBitmap;
  lIsUnderline: Boolean;
  lIsItalic: Boolean;
  lIsLink: Boolean;

  lIsNewLine: Boolean;

  lPaintToCanvas: TCanvas; // canvas to draw on
  LCurLineLen: Integer;
  LBreakLine: Boolean;
  LCalcWidth: Integer; // Length of the current line in pixels
begin

  FLinkRects.Clear;

  FRequiredHeight := 0;

  LBitmap := nil;
  if FBackground.Buffered then
  begin
    lBitmap := TBitmap.Create;
  end;

  try

    if FBackground.Buffered then
    begin
      if FWidth <= 0 then
        lBitmap.Width := 200
      else
        lBitmap.Width := FWidth;
      if FHeight <= 0 then
        lBitmap.Height := 200
      else
        lBitmap.Height := FHeight;
      lPaintToCanvas := lBitmap.Canvas;
    end
    else
      lPaintToCanvas := FCanvas;

    if ADoPaint then
    begin
      if not FBackground.Gradient.Enabled then
      begin
        if FBackground.Color = clNone then
        begin
          if not IsRectEmpty(FBackground.CopyRect) then
            lPaintToCanvas.CopyRect(Rect(0, 0, FWidth, FHeight), FCanvas, FBackground.CopyRect);
          lPaintToCanvas.Brush.Style := bsClear;
        end
        else
        begin
          lPaintToCanvas.Brush.Color := FBackground.Color;
          if Height = -1 then
            lPaintToCanvas.FillRect(Rect(0, 0, Width, 200))
          else
            lPaintToCanvas.FillRect(Rect(0, 0, Width, Height));
        end;
      end
      else
      begin
        lRect := Rect(0, 0, lBitmap.Width, lBitmap.Height);

        GradientFillCanvas(lPaintToCanvas, FBackground.Gradient.StartColor, FBackground.Gradient.EndColor,
          lRect, FBackground.Gradient.Direction);
        lPaintToCanvas.Brush.Style := bsClear;
      end;
    end;

    if FBiDiMode = bdRightToLeft then
    begin

      lPaintToCanvas.Font.Assign(Font);

      LCalcFlags := DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX or DT_CALCRECT;
      if FControl <> nil then
        LCalcFlags := FControl.DrawTextBiDiModeFlags(LCalcFlags);
      JSDrawText(LPaintToCanvas.Handle, Caption, Font, LRect, LCalcFlags, True);

      LRect.Left := FOffSet.X;
      LRect.Top := FOffset.Y;
      LRect.Right := Width;
      LRect.Bottom := Height;
      lDrawFlags := DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX;
      if FControl <> nil then
        LDrawFlags := FControl.DrawTextBiDiModeFlags(LDrawFlags);
      JSDrawText(LPaintToCanvas.Handle, Caption, Font, LRect, LDrawFlags, True);

    end
    else
    begin

      lRect := Rect(FOffSet.X, FOffSet.Y, 0, FOffSet.Y)  ;

//    if FTreatAsLink then
//      lPaintToCanvas.Font.Assign(LinkFont)
//    else
      lPaintToCanvas.Font.Assign(Font);

      lCalcRect := lRect;

      lDrawFlags := DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX;

      lCalcFlags := DT_CALCRECT or DT_EXPANDTABS or DT_NOPREFIX;

      LCurLineLen := 0;

      for j := 0 to FCaptionSegments.Count - 1 do
      begin
        lNewStr := '';
        lStr := FCaptionSegments[j];
        lIsBold := POS('<BOLD>', lStr) > 0;
        lIsUnderline := POS('<UNDERLINE>', lStr) > 0;
        lIsItalic := POS('<ITALIC>', lStr) > 0;
        lIsLink := POS('<LINK>', lStr) > 0;

        lIsNewLine := POS(NEWLINE, lStr) > 0;
        if lIsNewLine then
        begin
          lRect.Right := 0;
          lCalcRect.Right := 0;
          lCalcRect.Left := FOffSet.X;
          inc(lCalcRect.Top, JSTextHeight(lPaintToCanvas, 'SpgqwWq'));
          inc(FRequiredHeight, JSTextHeight(lPaintToCanvas, 'SpgqwWq'));
          LCurLineLen := 0;
          continue;
        end;

        if lIsBold then
        begin
          lStr := Copy(lStr, 7, Length(lStr));
          lPaintToCanvas.Font.Assign(Font);
          lPaintToCanvas.Font.Style := lPaintToCanvas.Font.Style + [fsBold];
        end
        else if lIsUnderline then
        begin
          lStr := Copy(lStr, 12, Length(lStr));
          lPaintToCanvas.Font.Assign(Font);
          lPaintToCanvas.Font.Style := lPaintToCanvas.Font.Style + [fsUnderline];
        end
        else if lIsItalic then
        begin
          lStr := Copy(lStr, 9, Length(lStr));
          lPaintToCanvas.Font.Assign(Font);
          lPaintToCanvas.Font.Style := lPaintToCanvas.Font.Style + [fsItalic];
        end
        else if lIsLink then
        begin
          lStr := FLinkInfo.Text;
          lPaintToCanvas.Font.Assign(FLinkFont);
        end
        else
          lPaintToCanvas.Font.Assign(Font);

        if FControl <> nil then
        begin
          LCalcFlags := FControl.DrawTextBiDiModeFlags(LCalcFlags);
        end;

        JSDrawText(lPaintToCanvas.Handle, lStr, lPaintToCanvas.Font, lCalcRect, lCalcFlags, True);

        Inc(LCurLineLen, LCalcRect.Right - LCalcRect.Left);

        // italicised text rect not calculated 100% by DrawTextW
        if (fsItalic in lPaintToCanvas.Font.Style) and
          ((fsBold in lPaintToCanvas.Font.Style) or (lPaintToCanvas.Font.Size > 8)) then
          inc(lCalcRect.Right, 3);

        if POS(#13#10, lStr) = 1 then
        begin
          lRect.Right := 0;
          LCurLineLen := 0;
        end;

        // Break up the line to be drawn because it it too long to fit
        if FBiDiMode = bdLeftToRight then
          LBreakLine := lRect.Right + lCalcRect.Right > Width
        else
          LBreakLine := LCurLineLen > Width;
        if LBreakLine then
        begin
          // need to reduce the line length
          if lStr > '' then
          begin
            while (JSTextWidth(lPaintToCanvas, lStr) > Width - lRect.Right) do
            begin
              if lStr = '' then
                break;
              lNewStr := lNewStr + lStr[Length(lStr)];
              lStr := Copy(lStr, 1, Length(lStr) - 1);
            end;

            if lStr <> '' then
            begin
              lOrigStr := lStr;
              lOrigNewStr := lNewStr;
              if (lStr[Length(lStr)] <> ' ') then
              begin
                while lStr[Length(lstr)] <> ' ' do
                begin
                  lNewStr := lNewStr + lStr[Length(lStr)];
                  lStr := Copy(lStr, 1, Length(lStr) - 1);
                  if lStr = '' then
                    break;
                end;
              end;
              // wrap at the original position
              if lStr = '' then
              begin
                // force new line if this is a segment that won't fit unbroken
                if lRect.Right <> 0 then
                begin
                  inc(lRect.Top, JSTextHeight(lPaintToCanvas, lStr));
                  inc(FRequiredHeight, JSTextHeight(lPaintToCanvas, lStr));
                  lRect.Right := 0;
                end
                else
                begin
                  lStr := lOrigStr;
                  lNewStr := lOrigNewStr;
                end;
              end;
            end;

            LCurLineLen := 0;

          end;

          if POS(#13#10, lStr) > 0 then
          begin
            inc(lRect.Top, JSTextHeight(lPaintToCanvas, lStr));
            inc(FRequiredHeight, JSTextHeight(lPaintToCanvas, lStr));
            lRect.Right := 0;
            LCurLineLen := 0;
          end;

        end;

        if POS(#13#10, lStr) > 0 then
        begin
          lCalcRect.Left := FOffSet.X;
          LCurLineLen := 0;
        end
        else
        begin
          if FBiDiMode = bdLeftToRight then
            lCalcRect.Left := lRect.Right
          else
            LCalcRect.Left := Width - LCurLineLen;
          // need to make sure FOffSet is observed if starting a newline
          { TODO : This condition is incorrect as-is }
  //        if (lCalcRect.Left = 0) then
  //          lCalcRect.Left := FOffSet;
        end;
        lCalcRect.Right := lCalcRect.Left + lCalcRect.Right;

        // right trim the string if it was broken
        if lNewStr > '' then
          lStr := TrimRight(lStr);

        if (lCalcRect.Left = 0) and (FOffSet.X <> 0) then
          lCalcRect.Left := FOffSet.X;

        if ADoPaint and (lNewStr = '') and (FCaptionSegments.Count = 1) then
        begin
          // if only painting a single line, centre it vertically
          lDrawFlags := lDrawFlags or DT_VCENTER or DT_SINGLELINE;
          lCalcRect.Top := 0;
          lCalcRect.Bottom := FHeight;
        end;

        if FControl <> nil then
        begin
          LCalcFlags := FControl.DrawTextBiDiModeFlags(LCalcFlags);
          LDrawFlags := FControl.DrawTextBiDiModeFlags(LDrawFlags);
        end;

        JSDrawText(lPaintToCanvas.Handle, lStr, lPaintToCanvas.Font, lCalcRect, lDrawFlags);

        Inc(LCurLineLen, LCalcRect.Right - LCalcRect.Left);

        // need to draw the rest of the string. This string might wrap so as each
        // line is drawn, the lNewStr value is reduced.

        if lIsLink and ADoPaint then
          FLinkRects.Add(lCalcRect);

        if lNewStr <> '' then
        begin
          if lRect.Top > lCalcRect.Top then
            lCalcRect.Top := lRect.Top;
        end;

        LCalcWidth := 0;
        while lNewStr > '' do
        begin
          inc(lCalcRect.Top, JSTextHeight(lPaintToCanvas, lNewStr));
          inc(FRequiredHeight, JSTextHeight(lPaintToCanvas, lNewStr));
          lStr := '';
          // put the string the correct way round
          for i := Length(lNewStr) downto 1 do
            lStr := lStr + lNewStr[i];
          // trim left so the newline doesn't start with a space
    //      lStr := TrimLeft(lStr);
          // check to see if the new str is too large for the current
          // control width and needs to wrap onto further lines
          lOrigNewStr := '';
          while JSTextWidth(lPaintToCanvas, lStr) > Width do
          begin
            lOrigNewStr := lOrigNewStr + lStr[Length(lStr)];
            lStr := Copy(lStr, 1, Length(lStr) - 1);
          end;

          // store the original wrapped values incase a space can't
          // be found and we need to force wrap at the original point
          lOriginalStr := lOrigNewStr;
          lOrigStr := lStr;

          // need to check for word break
          if LStr[Length(LStr)] <> ' ' then
          begin
            if (lStr <> '') and (lOrigNewStr <> '') and (lOrigNewStr[{1}Length(lOrigNewStr)] <> ' ') then
            begin
              for i := Length(lStr) downto 1 do
              begin
                lOrigNewStr := lOrigNewStr + lStr[i];
                lStr := Copy(lStr, 1, Length(lStr) - 1);
                if lStr = '' then
                  break;
                if lStr[Length(lStr)] = ' ' then
                  break;
              end;
            end;
          end;
          // check to see if no clean word break was possible
          if lStr = '' then
          begin
            lOrigNewStr := lOriginalStr;
            lStr := lOrigStr;
          end;
          lCalcRect.Bottom := lCalcRect.Top;
          lCalcRect.Left := FOffSet.X;
          JSDrawText(lPaintToCanvas.Handle, lStr, lPaintToCanvas.Font, lCalcRect, lCalcFlags);
          if FBidiMode <> bdLeftToRight then
          begin
            LCalcWidth := (LCalcRect.Right - LCalcRect.Left);
            LCalcRect.Left := Width - LCalcWidth;
            LCalcRect.Right := LCalcRect.Left + LCalcWidth;
          end;
          JSDrawText(lPaintToCanvas.Handle, lStr, lPaintToCanvas.Font, lCalcRect, lDrawFlags);
          Inc(LCurLineLen, LCalcWidth);
          if lIsLink and ADoPaint then
            FLinkRects.Add(lCalcRect);

          lNewStr := lOrigNewStr;
        end;
        lRect := lCalcRect;
        if lRect.Right - 5 >= Width then
        begin
          inc(lLinkRect.Top, JSTextHeight(lPaintToCanvas, lStr));
          inc(FRequiredHeight, JSTextHeight(lPaintToCanvas, lStr));
        end;

        // add carriage returns
        if POS(#13#10, lStr) > 0 then
        begin
          inc(lRect.Top, JSTextHeight(lPaintToCanvas, lStr));
          inc(FRequiredHeight, JSTextHeight(lPaintToCanvas, lStr));
          // reset left pos
          lRect.Right := 0;
        end;

        lCalcRect := Rect(0, lRect.Top, 0, lRect.Top);
      end;
    end;

    if FBackground.Buffered and (FHeight = -1) then
    begin
      try
        if LBitmap.Width > Screen.Width then
          LBitmap.Width := Screen.Width - 20;
        if FRequiredHeight > Screen.Height then
          LBitmap.Height := Screen.Height - 20
        else
          LBitmap.Height := FRequiredHeight;
      except
        on E: EOutOfResources do
          lBitmap.Height := 200;
      end;
      if (Caption <> '') then
        lBitmap.Height := lBitmap.Height + JSTextHeight(lPaintToCanvas, 'SpgqwWq');
    end;

    if ADoPaint and FBackground.Buffered then
      Canvas.Draw(FLeft, FTop, lBitmap);
    if (FHeight = -1) and FBackground.Buffered then
      FHeight := lBitmap.Height;

  finally
    if FBackground.Buffered then
      lBitmap.Free;
  end;
end;

function ReplaceLineFeeds(const AStr: TJSString): TJSString;
begin
  result := JSStringReplace(AStr, #13#10, NEWLINE, [rfReplaceAll]);
end;

procedure TJSCaption.ParseCaption;

  procedure ReplaceNewLines(const aStr: TJSString);
  var
    lNL: Integer;
    lNLStr: TJSString;
    lAddStr: TJSString;
  begin
    lNLStr := ReplaceLineFeeds(aStr);
    lNL := POS(NEWLINE, lNLStr);
    if lNL > 0 then
    begin
      while lNL > 0 do
      begin
        if lNL > 1 then
        begin
          lAddStr := Copy(lNLStr, 1, lNL - 1);
          FCaptionSegments.Add(lAddStr);
          Delete(lNLStr, 1, Length(lAddStr));
        end;
        lAddStr := Copy(lNLStr, 1, Length(NEWLINE));
        FCaptionSegments.Add(lAddStr);
        Delete(lNLStr, 1, Length(NEWLINE));
        lNL := POS(NEWLINE, lNLStr);
      end;
      if Length(lNLStr) > 0 then
      begin
        // trim the string if the previous line was a new line

      { TODO : This requires more thought }

//        if FCaptionSegments[FCaptionSegments.Count - 1] = NEWLINE then
//          lNLStr := TrimLeft(lNLStr);
        FCaptionSegments.Add(lNLStr);
      end;
    end
    else
      FCaptionSegments.Add(aStr);
  end;

var
  lCaption: TJSString;
  lActualCaption: TJSString;
  lDelPosStart: Integer;
  lPos: Integer;
  lPosEnd: Integer;
  lUPos: Integer;
  lIPos: Integer;
  lLPos: Integer;
  lStr: TJSString;
  lIsBold: Boolean;
  lIsUnderline: Boolean;
  lIsItalic: Boolean;
  lIsLink: Boolean;
  i: Integer;
  lLineLen: Integer;
  // link specific locals
  lLinkData: TJSString;
  lUrlInHere: TJSString;
  lTextInHere: TJSString;
  lPosTagEnd: Integer;
begin
  FCaptionSegments.Clear;
  FLinkInfo.Link := '';
  FLinkInfo.Text := '';
  if Caption = '' then
    exit;

  if FBiDiMode = bdRightToLeft then
  begin
    FCaptionSegments.Add(Caption);
    FRawCaption := Caption;
    Exit;
  end;

  lCaption := JSLowerCase(Caption);
  lActualCaption := Caption;

  while True do
  begin
    GetFormatingForSegment(lUPos, lPosEnd, lIsUnderline, lIsBold, lCaption,
                           lPos, lIPos, lIsItalic, lLPos, lIsLink);

    if lPos = -1 then
    begin
      lStr := lActualCaption;
      ReplaceNewLines(lStr);
      Break;
    end;
    
    lDelPosStart := 0;
    lStr := Copy(lActualCaption, 1, lPos - 1);
    lLineLen := Length(lStr);
    ReplaceNewLines(lStr);
    inc(lDelPosStart, lLineLen);

    lPosTagEnd := 0;
    if lIsLink then
    begin
      lLinkData := Copy(lActualCaption, lPos, lPosEnd - lPos + 4);
      lPosTagEnd := POS('">', lLinkData);
      lUrlInHere := Copy(lLinkData, POS('href="', lLinkData) + 6, lPosTagEnd - (POS('href="', lLinkData) + 6));
      FLinkInfo.Link := lUrlInHere;
      lPosEnd := POS('</a>', JSLowerCase(lLinkData));
      lTextInHere := Copy(lLinkData, lPosTagEnd + 2, lPosEnd - lPosTagEnd - 2);
      FLinkInfo.Text := lTextInHere;

      lStr := FLinkInfo.Text;
      //lStr := Copy(lActualCaption, lPos + Length('<b>'), lPosEnd - (lPos + Length('<b>')));
    end
    else
    begin
      lStr := Copy(lActualCaption, lPos + Length('<b>'), lPosEnd - (lPos + Length('<b>')));
    end;
    inc(lDelPosStart, Length(lStr));
    if lIsBold then
    begin
      FCaptionSegments.Add('<BOLD>' + lStr)
    end
    else if lIsUnderline then
    begin
      FCaptionSegments.Add('<UNDERLINE>' + lStr);
    end
    else if lIsItalic then
    begin
      FCaptionSegments.Add('<ITALIC>' + lStr);
    end
    else if lIsLink then
    begin
      FCaptionSegments.Add('<LINK>' + lStr);
    end;
    if not lIsLink then
      inc(lDelPosStart, Length('<b>') + Length('</b>'))
    else
    begin
      // process link clean up
      inc(lDelPosStart, lPosTagEnd + 1 + Length('</a>'));
    end;

    if lDelPosStart = 0 then
      break;
    lCaption := Copy(lCaption, lDelPosStart + 1, Length(lCaption));
    lActualCaption := Copy(lActualCaption, lDelPosStart + 1, Length(lActualCaption));
    if Length(lCaption) = 0 then
      break;
  end;

//  ShowMessageFmt('Count: %d'#13#10#13#10'%s', [FCaptionSegments.Count, FCaptionSegments.Text]);

    FRawCaption := '';
    for i := 0 to FCaptionSegments.Count - 1 do
    begin
      if POS('<BOLD>', FCaptionSegments[i]) = 1 then
        FRawCaption := FRawCaption + Copy(FCaptionSegments[i], Length('<BOLD>') + 1, Length(FCaptionSegments[i]))
      else if POS('<UNDERLINE>', FCaptionSegments[i]) = 1 then
        FRawCaption := FRawCaption + Copy(FCaptionSegments[i], Length('<UNDERLINE>') + 1, Length(FCaptionSegments[i]))
      else if POS('<ITALIC>', FCaptionSegments[i]) = 1 then
        FRawCaption := FRawCaption + Copy(FCaptionSegments[i], Length('<ITALIC>') + 1, Length(FCaptionSegments[i]))
      else if POS('<LINK>', FCaptionSegments[i]) = 1 then
        FRawCaption := FRawCaption + Copy(FCaptionSegments[i], Length('<LINK>') + 1, Length(FCaptionSegments[i]))
      else
        FRawCaption := FRawCaption + FCaptionSegments[i];
    end;

//  FCaptionSegments.SaveToFile('c:\caption.txt');

end;

procedure TJSCaption.SetBackground(const Value: TJSBackground);
begin
  if FBackground <> Value then
  begin
    if (FBackground <> nil) and (FBackground.AutoFree) then
      FreeAndNil(FBackground);
    FBackground := TJSBackground.Create(Value.Color, Value.Gradient, Value.CopyRect, Value.Buffered);
  end;
end;

procedure TJSCaption.SetCaption(const Value: TJSString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    ParseCaption;
    Paint;
  end;
end;

procedure TJSCaption.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Paint;
  end;
end;

procedure TJSCaption.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Paint;
end;

procedure TJSCaption.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Paint;
  end;
end;

procedure TJSCaption.SetLinkFont(const Value: TFont);
begin
  FLinkFont.Assign(Value);
  Paint;
end;

procedure TJSCaption.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := abs(Value);
    Paint;
  end;
end;

class function TJSCaption.TranslateRect(const ARect: TRect): TRect;
begin
  result.Left := ARect.Left;
  result.Top := ARect.Top;
  result.Right := ARect.Right - ARect.Left;
  result.Bottom := ARect.Bottom - ARect.Top;
end;

class procedure TJSCaption.PaintCaption(ACanvas: TCanvas;
  const ACaption: TJSString; ABackground: TJSBackground; const AFont: TFont;
  const ARect: TRect; const AOffSet: TPoint);
begin
  TJSCaption.PaintCaption(ACanvas, ACaption, ABackground, AFont, ARect.Left,
    ARect.Top, ARect.Right, ARect.Bottom, AOffSet, nil, bdLeftToRight);
end;

class procedure TJSCaption.PaintCaption(ACanvas: TCanvas; const ACaption: TJSString; ABackground: TJSBackground;
  const AFont: TFont; const ARect: TRect);
begin
  TJSCaption.PaintCaption(ACanvas, ACaption, ABackground, AFont, ARect.Left,
    ARect.Top, ARect.Right, ARect.Bottom, Point(0, 0), nil, bdLeftToRight);
end;

{ TLinkRect }

constructor TJSLinkRect.Create(const aRect: TRect);
begin
  FRect := ARect;
end;

{ TLinkRects }

procedure TJSLinkRects.Add(const aRect: TRect);
begin
  if IsUnique(aRect) then
    FLinkRects.Add(TJSLinkRect.Create(aRect));
end;

procedure TJSLinkRects.Clear;
begin
  FLinkRects.Clear;
end;

function TJSLinkRects.Count: Integer;
begin
  result := FLinkRects.Count;
end;

constructor TJSLinkRects.Create;
begin
  FLinkRects := TObjectList.Create;
end;

destructor TJSLinkRects.Destroy;
begin
  FLinkRects.Free;
  inherited;
end;

function TJSLinkRects.GetItem(Index: Integer): TRect;
begin
  if FLinkRects.Count > Index then
    result := TJSLinkRect(FLinkRects[Index]).Rect
  else
    raise Exception.Create(StrInvalidIndex);
end;

function TJSLinkRects.InLink(const X, Y: Integer): Boolean;
var
  i: Integer;
begin
  for i := 0 to FLinkRects.Count - 1 do
  begin
    result := PtInRect(TJSLinkRect(FLinkRects[i]).Rect, Point(X, Y));
    if result then
      exit;
  end;
  result := False;
end;

function IsDifferent(const aRect1, aRect2: TRect): Boolean;
begin
  result := (aRect1.Left <> aRect2.Left) and
            (aRect1.Right <> aRect2.Right) and
            (aRect1.Top <> aRect2.Top) and
            (aRect1.Bottom <> aRect2.Bottom);
end;

function TJSLinkRects.IsUnique(const aRect: TRect): Boolean;
var
  i: Integer;
  lRect: TJSLinkRect;
begin
  for i := 0 to FLinkRects.Count - 1 do
  begin
    lRect := TJSLinkRect(FLinkRects[i]);
    if not IsDifferent(lRect.Rect, aRect) then
    begin
      result := False;
      exit;
    end;
  end;
  result := True;
end;

procedure TJSLinkRects.SetItem(Index: Integer; const Value: TRect);
begin
  if FLinkRects.Count > Index then
    TJSLinkRect(FLinkRects[Index]).Rect := Value
  else
    raise Exception.Create(StrInvalidIndex);
end;

{ TLinkInfo }

constructor TJSLinkInfo.Create(const aText, aLink: TJSString);
begin
  inherited Create;
  Text := aText;
  Link := aLink;
end;

class procedure TJSCaption.PaintCaption(ACanvas: TCanvas;
  const ACaption: TJSString; ABackground: TJSBackground; const AFont: TFont;
  const ARect: TRect; AControl: TControl; const BiDiMode: TBiDiMode);
begin
  TJSCaption.PaintCaption(ACanvas, ACaption, ABackground, AFont, ARect.Left,
    ARect.Top, ARect.Right, ARect.Bottom, Point(0, 0), AControl, BiDiMode);
end;

{ TJSCustomCaptionControl }

procedure TJSCustomCaptionControl.AdjustBounds;
var
  lCanvas: TCanvas;
  lDC: HDC;
begin
  if (Height = 0) and (Width > 0) and (FText.Text <> '') then
  begin
    lDC := GetDC(0);
    try
      lCanvas := TCanvas.Create;
      try
        lCanvas.Handle := lDC;
        Height := TJSCaption.MinimumHeight(lCanvas, FText.Text, Font, Width);
      finally
        lCanvas.Handle := 0;
        lCanvas.Free;
      end;
    finally
      ReleaseDC(0, lDC);
    end;
  end;
end;

function TJSCustomCaptionControl.CanUseLink: Boolean;
begin
  result := (FCaption <> nil);
end;

procedure TJSCustomCaptionControl.Click;
begin
  inherited;
end;

procedure TJSCustomCaptionControl.CMColorchanged(var Message: TMessage);
begin
  inherited;
  FBackground.Color := Color;
  Invalidate;
end;

procedure TJSCustomCaptionControl.CMFontchanged(var Message: TMessage);
begin
  inherited;
  if AutoSize then
    AdjustBounds;
  Invalidate;
end;

constructor TJSCustomCaptionControl.Create(AOwner: TComponent);
begin
  inherited;
  FOffSet := TJSPoint.Create;
  FOffSet.OnChange := OffSetChanged;
  FBackground := TJSBackground.Create(Color, nil, EmptyRect, True, False);
  FText := TJSWideStringList.Create;
  FText.OnChange := TextChangedHandler;
  FLinkFont := TFont.Create;
  FLinkFont.Assign(Font);
  FLinkFont.Color := clBlue;
  FLinkFont.Style := FLinkFont.Style + [fsUnderline];
  FLinkFont.OnChange := LinkFontChanged;
  FBorderStyle := bsNone;
  FAutoSize := True;
  ParentColor := False;
  TabStop := True;
end;

procedure TJSCustomCaptionControl.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or BorderStyles[FBorderStyle];
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
  begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  Params.WindowClass.style := Params.WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

destructor TJSCustomCaptionControl.Destroy;
begin
  FText.Free;
  FLinkFont.Free;
  FCaption.Free;
  FBackground.Free;
  FOffSet.Free;
  inherited;
end;

procedure TJSCustomCaptionControl.DoLinkClick;
var
  lHandled: Boolean;
  LS:       WideString;
begin
  lHandled := False;
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, FCaption.FLinkInfo.Link, lHandled);
  if not lHandled then
  begin
    LS := FCaption.FLinkInfo.Link;
    ShellExecuteW(0, 'open', PWideChar(LS), nil, nil, SW_NORMAL);
  end;
end;

function TJSCustomCaptionControl.HasLinks: Boolean;
begin
  Result := CanUseLink and (FCaption.LinkRectCount > 0);
end;

procedure TJSCustomCaptionControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_SPACE then
    Click;
end;

procedure TJSCustomCaptionControl.LinkFontChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TJSCustomCaptionControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if not Focused then
  begin
    SetFocus;
    Invalidate;
  end;
end;

procedure TJSCustomCaptionControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if CanUseLink then
  begin
    if TreatAsLink or (CanUseLink and FCaption.MouseInLink(X, Y)) then
      Cursor := crJSHand
    else
      Cursor := crDefault;
  end;
end;

procedure TJSCustomCaptionControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button = mbLeft) and CanUseLink and FCaption.MouseInLink(X, Y) then
    DoLinkClick;
end;

procedure TJSCustomCaptionControl.OffSetChanged(Sender: TObject);
begin
  if FCaption <> nil then
  begin
    FCaption.FOffSet := FOffSet.AsPoint;
    Invalidate;
  end;
end;

procedure TJSCustomCaptionControl.Paint;
var
  lRect: TRect;
  i: Integer;
begin
  if FCaption = nil then
    FCaption := TJSCaption.Create(Canvas, FText.Text, FBackground, Font, Height, abs(Width), FOffSet.AsPoint, Self, BiDiMode)
  else
  begin
    FCaption.Background := FBackground;
  end;
  FCaption.Font := Font;
  FCaption.LinkFont := FLinkFont;
  FCaption.Height := Height;
  FCaption.Width := Width;
  FCaption.TreatAsLink := FTreatAsLink;
  TabStop := HasLinks;
  FCaption.Paint;

  if Focused then
  begin
    // Draw the focus rectangle for any links
    Canvas.Brush.Style := bsSolid;
    for i := 0 to FCaption.LinkRectCount - 1 do
    begin
      lRect := FCaption.GetLinkRect(i);
      dec(lRect.Left, 1);
      if (lRect.Left = 0) and (i = 0) then
        inc(lRect.Left, 1);
      inc(lRect.Right, 1);
      inc(lRect.Bottom, 1);
      Canvas.DrawFocusRect(lRect)
    end;
  end;

end;

procedure TJSCustomCaptionControl.Resize;
begin
  inherited;
  Invalidate;
end;

procedure TJSCustomCaptionControl.SetBackground(const Value: TJSBackground);
begin
  FBackground.Assign(Value);
end;

procedure TJSCustomCaptionControl.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TJSCustomCaptionControl.SetLinkFont(const Value: TFont);
begin
  FLinkFont.Assign(Value);
  Invalidate;
end;

procedure TJSCustomCaptionControl.SetOffSet(const Value: TJSPoint);
begin
  FOffSet.Assign(Value);
  Invalidate;
end;

procedure TJSCustomCaptionControl.SetText(const Value: TJSWideStringList);
begin
  FText.Assign(Value);
  if FCaption <> nil then
    FCaption.Caption := Value.Text;
  Invalidate;
end;

procedure TJSCustomCaptionControl.SetTreatAsLink(const Value: Boolean);
begin
  if FTreatAsLink <> Value then
  begin
    FTreatAsLink := Value;
    if AutoSize then
      AdjustBounds;
    Invalidate;
  end;
end;

procedure TJSCustomCaptionControl.TextChangedHandler(Sender: TObject);
begin
  inherited;
  if AutoSize then
    AdjustBounds;
  Invalidate;
  if FCaption <> nil then
    FCaption.Caption := FText.Text;
end;

procedure TJSCustomCaptionControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TJSCustomCaptionControl.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TJSCustomCaptionControl.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  SetFocus;
  Invalidate;
end;

{ TPersitentPoint }

function TJSPoint.AsPoint: TPoint;
begin
  result := Point(FX, FY);
end;

procedure TJSPoint.Assign(Source: TPersistent);
begin
  if Source is TJSPoint then
  begin
    FX := (Source as TJSPoint).X;
    FY := (Source as TJSPoint).Y;
    DoChange;
  end
  else
    inherited;
end;

constructor TJSPoint.Create;
begin
  inherited;
  FX := 0;
  FY := 0;
end;

procedure TJSPoint.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TJSPoint.SetX(const Value: Integer);
begin
  if FX <> Value then
  begin
    FX := Value;
    DoChange;
  end;
end;

procedure TJSPoint.SetY(const Value: Integer);
begin
  if FY <> Value then
  begin
    FY := Value;
    DoChange;
  end;
end;

initialization
  Screen.Cursors[crJSHand] := LoadCursor(0, IDC_HAND);

end.
