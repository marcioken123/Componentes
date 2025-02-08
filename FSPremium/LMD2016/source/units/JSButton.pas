{ Summary
  This unit contains the TJSCommandLinkButton class used for displaying the Command Link Button control on the dialog. }
unit JSButton;

interface

{$I lmddlgcmps.inc}

uses
  {$IFDEF DELPHIXE3}
  System.UITypes,
  {$ENDIF DELPHIXE3}
  Classes, Controls, Windows, Graphics, Messages, SysUtils, Buttons{$IFDEF DELPHI5}, Forms{$ENDIF DELPHI5},
  JSTypes, JSGraphUtil, ImgList;

type
  { Used to indicate what command link button item is to be
    painted. Also used to retrieve the paint rectangle for the
    item specified.                                            }
  TPaintStage = (
    psBorder { Border of the command link button },
    psFocus { Focus retangle of the command link button },
    psGlyph { Glyph of the command link button },
    psCaption { Caption of the command link button },
    psInfo { Information text of the command link button },
    psPicture { Picture of the command link button that is shown next to the Info text }
    );

  { Summary
    Determines the appearance of Command Link Buttons. }
  TJSButtonStyle = (
    jsbNative { Button is painted with the default Vista look. },
    jsbClassic { Button is painted with the old windows classic appearance including clBtnFace color and square borders. }
    );

  TJSCustomCommandLinkButton = class;

  { Summary
    Used for defining a TJSCommandLinkButton control custom appearance.
    Description
    Class that encapsulates all of the required color properties for customising the appearance of a
    TJSCommandLinkButton control.                                                                    }
  TJSCommandLinkColors = class(TJSChangePersistent)
  private
    FEnabled: Boolean;
    FBorderInner: TColor;
    FPressedGradientStart: TColor;
    FGradientEnd: TColor;
    FHotGradientEnd: TColor;
    FPressedGradientEnd: TColor;
    FBorderOuter: TColor;
    FGradientStart: TColor;
    FHotGradientStart: TColor;
    FFontColor: TColor;
    FFontHotColor: TColor;
    FGradientPen: TColor;
    FFontDisabledColor: TColor;
    FDefaultBorderOuter: TColor;
    FDefaultBorderInner: TColor;
    FFontPressedColor: TColor;
    FCommandLinkButton: TJSCustomCommandLinkButton;
    FColor: TColor;
    procedure SetEnabled(const Value: Boolean);
    procedure SetBorderInner(const Value: TColor);
    procedure SetBorderOuter(const Value: TColor);
    procedure SetGradientEnd(const Value: TColor);
    procedure SetGradientStart(const Value: TColor);
    procedure SetHotGradientEnd(const Value: TColor);
    procedure SetHotGradientStart(const Value: TColor);
    procedure SetPressedGradientEnd(const Value: TColor);
    procedure SetPressedGradientStart(const Value: TColor);
    procedure SetFontColor(const Value: TColor);
    procedure SetFontHotColor(const Value: TColor);
    procedure SetGradientPen(const Value: TColor);
    procedure SetFontDisabledColor(const Value: TColor);
    procedure SetDefaultBorderInner(const Value: TColor);
    procedure SetDefaultBorderOuter(const Value: TColor);
    procedure SetFontPressedColor(const Value: TColor);
    procedure SetColor(const Value: TColor);
  public
    constructor Create(AButton: TJSCustomCommandLinkButton); reintroduce;
    procedure Assign(Source: TPersistent); override;
    { Summary
      Load a specific command link color scheme that was previous saved to a file.
      Description
      Load a specific command link button color scheme from a file. The file must exist and be readable by the
      calling application when called. The only checking this method provides is to verify that the file to load
      the content from exists.
      Remarks
      The method returns true if the file to load exists on disk. A true result does not mean that the file format
      was of the expected type. }
    function LoadFromFile(const AFilename: string): Boolean;
    { Summary
      Save the command link color scheme to a file.
      Description
      Saves the specific command link button color scheme to a file.
      Remarks
      If the file already exists, it is overwritten without warning. }
    procedure SaveToFile(const AFilename: string);
  published
    { Summary
      Determines whether the custom colors are used for TJSCommandLinkButton controls.
      Description
      The default value is False, so any TJSCommandLinkButton controls will use the default colors. To use
      colors you have defined, make sure the Enabled property is set to True.                              }
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    { Summary
      Inner border color. }
    property BorderInner: TColor read FBorderInner write SetBorderInner default $00C6C6C6;
    { Summary
      Outer border color. }
    property BorderOuter: TColor read FBorderOuter write SetBorderOuter default $00EAEAEA;
    { Summary
      Default color of the control.
      Description
      This is the color used when the mouse is not within the bounds of the button or the button isn't
      being pressed.                                                                                   }
    property Color: TColor read FColor write SetColor default clWindow;
    { Summary
      The inner border color for a button where the Default property is set to true. }
    property DefaultBorderInner: TColor read FDefaultBorderInner write SetDefaultBorderInner default $00FFEFAE;
    { Summary
      The outer border color for a button where the Default property is set to true. }
    property DefaultBorderOuter: TColor read FDefaultBorderOuter write SetDefaultBorderOuter default $00FFF4C7;
    { Summary
      The color of the font for the button in its default state. }
    property FontColor: TColor read FFontColor write SetFontColor default $00551C15;
    { Summary
      Color of the font when the button control is disabled. }
    property FontDisabledColor: TColor read FFontDisabledColor write SetFontDisabledColor default clGrayText;
    { Summary
      Color of the font when the mouse is within the bounds of the control. }
    property FontHotColor: TColor read FFontHotColor write SetFontHotColor default $00E54A07;
    { Summary
      Color of the font when the button is being pressed. }
    property FontPressedColor: TColor read FFontPressedColor write SetFontPressedColor default clNone;
    { Summary
      End gradient color used when the button is in its default state. }
    property GradientEnd: TColor read FGradientEnd write SetGradientEnd default clNone;
    { Summary
      Color of a single line painted one pixel above the inner border line. }
    property GradientPen: TColor read FGradientPen write SetGradientPen default $00FBFBFB;
    { Summary
      Start gradient color used when the button is in its default state. }
    property GradientStart: TColor read FGradientStart write SetGradientStart default clNone;
    { Summary
      End gradient color used when the button is in its hot state. }
    property HotGradientEnd: TColor read FHotGradientEnd write SetHotGradientEnd default $00F6F6F6;
    { Summary
      Start gradient color used when the button is in its hot state. }
    property HotGradientStart: TColor read FHotGradientStart write SetHotGradientStart default clWhite;
    { Summary
      End gradient color used when the button is in its pressed state. }
    property PressedGradientEnd: TColor read FPressedGradientEnd write SetPressedGradientEnd default $00ECECEB;
    { Summary
      Start gradient color used when the button is in its pressed state. }
    property PressedGradientStart: TColor read FPressedGradientStart write SetPressedGradientStart default $00ECECEB;
  end;

  { This is the base class for the TJSCommandLinkButton class. }
  TJSCustomCommandLinkButton = class(TCustomControl)
  private
    FMouseInControl: Boolean;
    FPicture: TPicture;
    FGlyph: TPicture;
    FHotGlyph: TIcon;
    FColdGlyph: TIcon;
    FDownGlyph: TIcon;
    FDisabledGlyph: TIcon;
    FInfo: TJSStrings;
    FInfoFont: TFont;
    FModalResult: TModalResult;
    FShowIcon: Boolean;
    FDefaultHeight: Integer;
    FDefault: Boolean;
    FCancel: Boolean;
    FElevationRequired: Boolean;
    FRgn: HRGN;
    FStyle: TJSButtonStyle;
    FMouseButtonPressed: Boolean;
    FShowHotKey: Bool;
    FProcessEnter: Boolean;
    FProcessSpace: Boolean;
    FBackground: TJSBackground;
    FCaption: TJSString;
    FPictureImages: TCustomImageList;
    FPictureIndex: Integer;
    FGlyphImages: TCustomImageList;
    FGlyphIndex: Integer;
    FCommandLinkColors: TJSCommandLinkColors;
    procedure InfoChangeHandler(Sender: TObject);
    procedure SetMouseInControl(const Value: Boolean);
    procedure SetGlyph(const Value: TPicture);
    procedure SetPicture(const Value: TPicture);
    procedure SetInfo(const Value: TJSStrings);
    procedure SetInfoFont(const Value: TFont);
    procedure PictureChangeHandler(Sender: TObject);
    procedure SetShowIcon(const Value: Boolean);
    procedure SetDefaultHeight(const Value: Integer);
    procedure SetDefault(const Value: Boolean);
    procedure SetCancel(const Value: Boolean);
    procedure SetElevationRequired(const Value: Boolean);
    procedure SetStyle(const Value: TJSButtonStyle);
    procedure DeleteRegion;
    function IsMouseButtonPressed: Boolean;
    procedure SetShowHotKey(const Value: Bool);
    function GetMinimumWidth: Integer;
    function LeftMargin(const AStage: TPaintStage): Integer;
    procedure SetPictureImages(const Value: TCustomImageList);
    procedure SetPictureIndex(const Value: Integer);
    procedure SetGlyphImages(const Value: TCustomImageList);
    procedure SetGlyphIndex(const Value: Integer);
    procedure SetCaption(const Value: TJSString);
    procedure SetCommandLinkColors(const Value: TJSCommandLinkColors);
  protected
    { Summary
      Method to load the icons used internally by the Command Link button control.
      Description
      Virtual method that loads the icons required by the Command Link button control. Override this method
      to load custom icons for use when Command Link buttons are visible.                                   }
    procedure InitialiseGlyphs; virtual;
    { Summary
      Initialises the custom fonts used by the Command Link button control.
      Description
      This is where the instruction font color is initialised as well as the other font colors used within
      the Command Link button control.<p />
      <p />
      Override this method to define custom text color for particular sections of a Command Link button.   }
    procedure InitialiseFonts; virtual;
    procedure AdjustBounds; dynamic;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure CustomColorsChangeHandler(Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    { Summary
      Returns a TRect structure that contains the coordinates of a specific paint stage.
      Description
      Method used internally by the drawing methods of the the control to know where specific sections of
      the button are to be painted.
      Parameters
      %PAR0% :  Specifies the paint stage to return the TRect structure for.
      Returns
      Add a return value description here...
      Return Value List
      V1 :  TRect structure that contains the coordinates to draw within.
      Remarks                                                                                             }
    function GetRect(AStage: TPaintStage): TRect; virtual;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Paint; override;
    { Summary
      Paints the border of the button.
      Description
      Paints the border of the button. }
    procedure PaintBorder(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Paints the caption section of the button.
      Description
      Paints the caption section of the button. }
    procedure PaintCaption(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Paints the default border section of the button.
      Description
      Paints the default border section of the button. }
    procedure PaintDefaultBorder(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Paints the focus rectangle on the button.
      Description
      Paints the focus rectangle on the button when it has focus. }
    procedure PaintFocus(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Paints the glyph on the button.
      Description
      Paints the glyph on the button. The glyph is positioned to the left of the caption. }
    procedure PaintGlyph(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Paints the info section of the button.
      Description
      Paints the info section of the button. The info section of the button is located under the caption
      section of the button.                                                                             }
    procedure PaintInfo(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Paints the Picture associated with the info section of the button.
      Description
      Paints the Picture associated with the info section of the button. The Picture is painted to the left
      of the info section.                                                                                  }
    procedure PaintPicture(ACanvas: TCanvas; ARect: TRect); virtual;
    procedure RecreateRegion; virtual;
    function GetInfoText: TJSString; virtual;
    procedure Resize; override;
    procedure SetAutoSize(Value: Boolean);{$IFNDEF DELPHI5} override;{$ENDIF DELPHI5}
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    function PictureAssigned: Boolean; {$IFDEF INLINE}inline;{$ENDIF INLINE}
    function PictureHeight: Integer; {$IFDEF INLINE}inline;{$ENDIF INLINE}
    function PictureWidth: Integer; {$IFDEF INLINE}inline;{$ENDIF INLINE}
    function GlyphAssigned: Boolean; {$IFDEF INLINE}inline;{$ENDIF INLINE}
    function GlyphHeight: Integer; {$IFDEF INLINE}inline;{$ENDIF INLINE}
    function GlyphWidth: Integer; {$IFDEF INLINE}inline;{$ENDIF INLINE}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    { Summary
      Specifies the caption that appears on the button.
      Description
      Use Caption to specify the text string that appears on the button.

      The Caption portion of a command link button is typically displayed in a larger font than the rest of the user interface
      and also a regular button control. The font color used for the caption text is also different.

      To underline a character in a Caption that appears on the button, include an ampersand (&) before the character.
      This type of character is called an accelerator character. The user can then select the button by pressing Alt
      while typing the underlined character. To display an ampersand character in the caption, use two ampersands (&&). }
    property Caption: TJSString read FCaption write SetCaption;
    { Summary
      Specifies the background color of the button.
      Description
      Use Color to read or change the background color of the button.

      If a button's ParentColor property is true, then changing the Color property of the button's parent
      automatically changes the Color property of the button. When the value of the Color property is
      changed, the button's ParentColor property is automatically set to false.
      Remarks
      The default value for Color is clWindow.                                                            }
    property Color default clWindow;
    { Summary
      Specifies the custom colors used to define the appearance of a command link button. }
    property CommandLinkColors: TJSCommandLinkColors read FCommandLinkColors write SetCommandLinkColors;
    { The default property indicates which button is selected when
      the enter button on the dialog is pressed. The default button
      also has a different border to the other buttons on the
      dialog when pressing enter will click it.                     }
    property Default: Boolean read FDefault write SetDefault default False;
    { Summary
      Determines how the button handles the user pressing the escape key.
      Description
      The cancel property indicates that the button should be clicked if the user presses
      the escape key while the button has focus.                    }
    property Cancel: Boolean read FCancel write SetCancel default False;
    { Summary
      Specifies when the mouse cursor is within the bounds of the control.
      Description
      The MouseInControl property is used to determine how the button state should be
      painted at any particular time during the paint cycle.                    }
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
    { Summary
      Determines if the user can tab to a control.
      Description
      Use the TabStop to allow or disallow access to the control using the Tab key.

      If TabStop is true, the control is in the tab order. If TabStop is false, the control
      is not in the tab order and the user can't press the Tab key to move to the control.
      Remarks
      The default value of TabStop for the Command Link Button control is True. }
    property TabStop default True;
    { This is the default height for the button. This property is
      currently not used and may be removed in a subsequent
      release.                                                    }
    property DefaultHeight: Integer read FDefaultHeight write SetDefaultHeight default -1;
    {}
    property ElevationRequired: Boolean read FElevationRequired write SetElevationRequired default False;
    { Glyph displayed next to the button caption. By default this
      is a green arrow.                                           }
    property Glyph: TPicture read FGlyph write SetGlyph;
    { Summary
      Specifies which image to use to display a glyph on the button.
      Description
      This property is only used when the GlyphImages property is assigned an image list.<p />
      <p />
      A buttons glyph appears to the left of the buttons caption. For the glyph to display a
      TJSCustomDialog descendant must of the doCommandLinks option set in the DialogOptions property. If
      the doCommandLinksNoIcon option is set, then the button does not display any glyphs.<p />

      Remarks
      By default the Command Link Button already has default Glyphs for different button states assigned
      internally.                                                                                        }
    property GlyphIndex: Integer read FGlyphIndex write SetGlyphIndex default -1;
    { Summary
      Provides a list of images that can be used to display an image to the left of the button.
      Description
      When the GlyphImages property is assigned, the button can display images from the image list by
      setting the GlyphIndex property.
      Remarks
      By default the Command Link Button already has default Glyphs for different button states assigned
      internally.                                                                                        }
    property GlyphImages: TCustomImageList read FGlyphImages write SetGlyphImages;
    { Use the Info property to display additional text under the
      button caption. Info text can be span multiple lines and
      include new lines.                                         }
    property Info: TJSStrings read FInfo write SetInfo;
    { Summary
      Controls the attributes of information caption written on or in the control.
      Description
      To change to a new font, specify a new TFont object. To modify a font, change the value of the
      Charset, Color, Height, Name, Pitch, Size, or Style of the TFont object.<p />
      <p />
      The InfoFont property contains the font attributes for the caption at the top of the button.
      Generally this caption uses a larger font size than the regular caption, which appears underneath the
      information caption.                                                                                  }
    property InfoFont: TFont read FInfoFont write SetInfoFont;
    { Summary
      Determines where a control looks for its color information.
      Description
      To have the Command Link Button use the same color as its parent control, set ParentColor to true. If
      ParentColor is false, the control uses its own Color property.
      Remarks
      This property is only valid when themes are not enabled.                                              }
    property ParentColor default False;
    { Additional Image that can be associated with the button. This
      image will display under the caption and next to any Info
      text for the button. The picture is also indented so that it
      displays under the start of the caption and not directly
      under the buttons Glyph.                                      }
    property Picture: TPicture read FPicture write SetPicture;
    { Summary
      Specifies which image to use to display a picture on the button.
      Description
      This property is only used when the PictureImages property is assigned an image list.<p />
      <p />
      A buttons picture appears under the caption of the button and to the left of any Info text that might
      be assigned.                                                                                          }
    property PictureIndex: Integer read FPictureIndex write SetPictureIndex default -1;
    { Summary
      Provides a list of images that can be used to display an image within the button.
      Description
      When the PictureImages property is assigned, the button can display images from the image list by
      setting the PictureIndex property.                                                                }
    property PictureImages: TCustomImageList read FPictureImages write SetPictureImages;
    { Property set to true when accelerator keys are always displayed.
      Initially set by the control and should only be modified by an outside source in
      response to a key down event. }
    property ShowHotKey: Bool read FShowHotKey write SetShowHotKey;
    { Set to True to show the image set in the Glyph property if there is one

      This option does not suppress the displaying of the image set in Picture
      property. If you do not want the Picture to display then clear the Picture
      property }
    property ShowIcon: Boolean read FShowIcon write SetShowIcon default True;
    { Summary
      Style used to draw the button.
      Description
      Change the Style property to change how the command link button gets painted. }
    property Style: TJSButtonStyle read FStyle write SetStyle default jsbNative;
    { The result returned when the button is clicked. }
    property ModalResult: TModalResult read FModalResult write FModalResult default mrNone;
    { Returns the minimum required width of the button.
      Button caption must fit on the one line. }
    property MinimumWidth: Integer read GetMinimumWidth;
  end;

  { The TJSCommandLinkButton class is the default class used to
    represent the Command Links in the Dialog.

    You can change what class is used to draw the Command Links
    for your dialog by providing a OnInitControl handler that
    handles the ControlType of ctCommandLink.                   }
  TJSCommandLinkButton = class(TJSCustomCommandLinkButton)
  published
    { Summary
      Determines whether the size of the label automatically resizes to accommodate the text.
      Description
      Use AutoSize to make the label adjusts its size according to the details it is to display.<p />
      <p />
      Internally this property is not used, however it might be used when using the TJSCommandLinkButton
      component outside of a dialog.                                                                     }
    property AutoSize;
    { This is the caption of the Command Link Button. By default
      the caption is displayed in a larger font.                 }
    property Caption;
    { Summary
      Specifies the bidirectional mode for the control.
      Description
      Use BiDiMode to enable the control to adjust its appearance and behavior automatically when the
      application runs in a locale that reads from right to left instead of left to right. The
      bidirectional mode controls the reading order for the text, the placement of the vertical scroll bar,
      and whether the alignment is changed.                                                                 }
    property BiDiMode;
    { Summary
      Specifies the background color of the control. }
    property Color;
    { Summary
      Specifies the colors used to draw the command link control.
      Description
      To use the CommandLinkColors to customise the colors used to render the command link control, make sure
      the Enabled property is set to True. }
    property CommandLinkColors;
    property Default;
    property DefaultHeight;
    property ElevationRequired;
    { Specifies the font attributes the Caption will be drawn with.
      The Info text is draw with the same font attributes except
      the size is reduce 1pt.                                       }
    property Font;
    property Glyph;
  	property GlyphIndex;
  	property GlyphImages;
    { Summary
      Contains the text string that can appear when the user moves the mouse over a Command Link Button.
      Description
      Use the Hint property to provide a string of help text either as a Help Hint, or as help text on a
      particular location such as a status bar.<p />
      <p />
      Generally for a Command Link Button use the Info property.                                         }
    property Hint;
    property Info;
    property InfoFont;
    property ModalResult;
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
    property ParentColor;
    { Summary
      Determines where a Command Link Button looks to find out if its Help Hint should be shown.
      Description
      Use ParentShowHint to ensure that all the controls on a form either uniformly show their Help Hints
      or uniformly do not show them.<p />
      <p />
      If ParentShowHint is true, the control uses the ShowHint property value of its parent. If
      ParentShowHint is false, the control uses the value of its own ShowHint property.                   }
    property ParentShowHint;
    property Picture;
    property PictureIndex;
    property PictureImages;
    property ShowIcon;
    property Style;
    { Summary
      Indicates the position of the control in its parent's tab order.
      Description
      Refer to the TabOrder documentation for the TWinControl class for further details on the TabOrder
      property. }
    property TabOrder;
    property TabStop;
    { Event that is fired when the button has been clicked. }
    property OnClick;
  end;

  { Predefined styles of the TJSSymbolButton control } 
  TSymbolButtonStyle = (
    sbsNone  { Nothing is painted on the button },
    sbsEllipsis  { An ellipsis is painted on the button },
    sbsArrowDown { A arrow facing down is painted on the button },
    sbsArrowUp { A arrow facing up is painted on the button },
    sbsArrowLeft { A arrow facing left is painted on the button },
    sbsArrowRight { A arrow facing right is painted on the button }
    );

  { Button control that has predefined styles to paint a specific symbol on it. }
  TJSSymbolButton = class(TSpeedButton)
  private
    FStyle: TSymbolButtonStyle;
    FArrowSize: Integer;
    FSymbolColor: TColor;
    FSymbolShadowColor: TColor;
    procedure SetStyle(const Value: TSymbolButtonStyle);
    procedure SetArrowSize(const Value: Integer);
    procedure SetSymbolColor(const Value: TColor);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { The size of the arrow to paint on the control when the Style
      property is set to one of the following values:
        sbsArrowDown, sbsArrowUp, sbsArrowLeft, sbsArrowRight
    }
    property ArrowSize: Integer read FArrowSize write SetArrowSize default 4;
    { The color of the symbol that is painted }
    property SymbolColor: TColor read FSymbolColor write SetSymbolColor default clNone;
    { The color of the symbol's shadow that is painted. If not shadow is to be
      painted then set the SymbolShadowColor to clNone }
    property SymbolShadowColor: TColor read FSymbolShadowColor write FSymbolShadowColor default clNone;
    { The type of symbol to be painted on the button }
    property Style: TSymbolButtonStyle read FStyle write SetStyle default sbsNone;
  end;

implementation

uses
  JSGraphics, JSUnicode{$IFNDEF DELPHI5}, GraphUtil, Forms, Types{$ENDIF DELPHI5}, Math, Menus,
  JSLabel{$IFDEF DELPHIXE2}, Themes{$ENDIF DELPHIXE2}, IniFiles;

{ TCustomCommandLinkButton }

const
  CAPTION_LEFT = 16;
  { Summary
    Default value for the left margin. }
  MARGIN = 8;
  { Summary
    Default spacing for the right margin. }
  RIGHT_MARGIN = 12;
  { Summary
    Default spacing when a glyph is visible on the dialog. }
  GLYPH_SPACING = 10;
  { Summary
    Default spacing between the caption and the picture assigned
    to the button.                                               }
  PICTURE_SPACING = 4;

  { Summary
    Default drawing flags used to draw the specified text. }
  DrawCaptionFlags = DT_LEFT or DT_EXPANDTABS or DT_SINGLELINE;
  { Summary
    Default drawing flags used to calculate the size of the
    rectangle required to draw the specified text.          }
  CalcCaptionFlags = DrawCaptionFlags or DT_CALCRECT;

procedure TJSCustomCommandLinkButton.AdjustBounds;
var
  lDC: HDC;
  lRect: TRect;
  lHeight: Integer;
  lText: TJSString;
  lLeftPos: Integer;
  lWidth: Integer;
  lWidth2: Integer;
  lInfoHeight: Integer;
begin
  if not (csReading in ComponentState) then
  begin
    lLeftPos := CAPTION_LEFT;
    if ShowIcon then
      inc(lLeftPos, GlyphWidth);
    lWidth := Width - lLeftPos;
    if lWidth < 0 then
      exit;
    lWidth2 := 0;
    lRect := Rect(lLeftPos, Top, lLeftPos, Top);
    lHeight := 0;
    lDC := GetDC(0);
    try
      Canvas.Handle := lDC;
      try
        Canvas.Font.Assign(Font);
        JSDrawText(Canvas.Handle, Caption, Font, lRect, CalcCaptionFlags, True);
        inc(lHeight, lRect.Bottom - lRect.Top);
        if AutoSize then
        begin
          if ShowIcon then
            lWidth2 := lRect.Right + lLeftPos - GlyphWidth
          else
            lWidth2 := lRect.Right + lLeftPos;
          if PictureAssigned then
            lWidth := lWidth2 + PictureWidth - MARGIN
          else
            lWidth := lWidth2;
          if PictureAssigned then
            lRect := Rect(PictureWidth + MARGIN + 12, Top, lWidth, Top)
          else
            lRect := Rect(0, Top, lWidth, Top);
        end
        else
        begin
          if PictureAssigned then
            lRect := Rect(lLeftPos + PictureWidth + MARGIN + 12, Top, Width - RIGHT_MARGIN, Top)
          else
            lRect := Rect(lLeftPos, Top, Width - RIGHT_MARGIN, Top);
        end;
        if AutoSize then
        begin
          if PictureAssigned then
            lWidth2 := Max(lWidth2, lRect.Right + 28)
          else
            lWidth2 := Max(lWidth2, (lRect.Right - lRect.Left));
        end;
        lText := GetInfoText;
        if not AutoSize then
          lInfoHeight := TJSCaption.MinimumHeight(Canvas, lText, InfoFont, Width - RIGHT_MARGIN - LeftMargin(psInfo))
        else
          lInfoHeight := TJSCaption.MinimumHeight(Canvas, lText, InfoFont, lWidth2 - RIGHT_MARGIN - LeftMargin(psInfo));
        if PictureAssigned then
          inc(lHeight, Max(lInfoHeight, PictureHeight + PICTURE_SPACING))
        else
          inc(lHeight, lInfoHeight);
        if GlyphAssigned then
          lHeight := Max(GlyphHeight + PICTURE_SPACING, lHeight);
      finally
        Canvas.Handle := 0;
      end;
    finally
      ReleaseDC(0, lDC);
    end;
    inc(lHeight, 21);

    if AutoSize then
      SetBounds(Left, Top, lWidth2, lHeight)
    else
      SetBounds(Left, Top, Width, lHeight);
  end;
end;

function ActiveControlInheritsFromWinControl: Boolean; {$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  result := (Screen <> nil) and (Screen.ActiveControl <> nil) and
    Screen.ActiveControl.InheritsFrom(TWinControl)
end;

procedure TJSCustomCommandLinkButton.CMDialogChar(var Message: TCMDialogChar);
begin
  if (IsAccel(Message.CharCode, Caption) or
    ((Message.CharCode = 13) and Default and (Focused or (not ActiveControlInheritsFromWinControl))) or
    ((Message.CharCode = 27) and Cancel)) and
    CanFocus then
  begin
    SetFocus;
    if Focused then
      Click;
    Message.Result := 1;
  end
  else
    inherited;
end;

procedure TJSCustomCommandLinkButton.CMEnabledChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.CMFontchanged(var Message: TMessage);
begin
  AdjustBounds;
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.CMMouseenter(var Message: TMessage);
begin
  MouseInControl := True;
end;

procedure TJSCustomCommandLinkButton.CMMouseleave(var Message: TMessage);
begin
  MouseInControl := False;
end;

procedure TJSCustomCommandLinkButton.CMTextchanged(var Message: TMessage);
begin
  AdjustBounds;
  Invalidate;
end;

const
  { Summary
    Constant that points to the resource name of the glyph used to represent an unselected Command Link
    Button. }
  COLD_BTN = 'ZJSD_CLBCOLD';
  { Summary
    Constant that points to the resource name of the glyph used to represent a Command Link Button that
    has the mouse currently within its bounds. }
  HOT_BTN = 'ZJSD_CLBHOT';
  { Summary
    Constant that points to the resource name of the glyph used to represent a pressed Command Link
    Button. }
  DOWN_BTN = 'ZJSD_CLBDOWN';
  { Summary
    Constant that points to the resource name of the glyph used to represent an disabled Command Link
    Button. }
  DISABLED_BTN = 'ZJSD_CLBDISABLED';

  { Summary
    Default font colour for the buttons caption. }
  clCommandLinkFontColor = $00551C15;
  { Summary
    Default font colour for the buttons caption when the button
    has the mouse cursor within its bounds.                     }
  clCommandLinkFontHotColor = $00E54A07;

  {$IFDEF DELPHI5}
  SPI_GETKEYBOARDCUES = $100A;
  {$ENDIF DELPHI5}

constructor TJSCustomCommandLinkButton.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := True;
  FProcessEnter := False;
  FProcessSpace := False;
  FStyle := jsbNative;
  FDefaultHeight := -1;
  TabStop := True;
  FGlyph := TPicture.Create;
  InitialiseGlyphs;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChangeHandler;
  FInfo := TJSWideStringList.Create;
  TJSWideStringList(FInfo).OnChange := InfoChangeHandler;
  FDefault := False;
  FShowIcon := True;
  InitialiseFonts;
  FElevationRequired := False;
  SystemParametersInfo(SPI_GETKEYBOARDCUES, 0, @FShowHotKey, 0);
  FBackground := TJSBackground.Create(clNone, nil, EmptyRect, True, False);
  FGlyphIndex := -1;
  FPictureIndex := -1;
  FCommandLinkColors := TJSCommandLinkColors.Create(Self);
  FCommandLinkColors.OnChange := CustomColorsChangeHandler;
  Color := clWindow;
  ParentColor := False;
end;

procedure TJSCustomCommandLinkButton.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TJSCustomCommandLinkButton.CreateWnd;
begin
  inherited;
  RecreateRegion;
end;

procedure TJSCustomCommandLinkButton.CustomColorsChangeHandler(Sender: TObject);
begin
  Invalidate;
end;

destructor TJSCustomCommandLinkButton.Destroy;
begin
  FGlyph.Free;
  FPicture.Free;
  FHotGlyph.Free;
  FColdGlyph.Free;
  FDownGlyph.Free;
  FDisabledGlyph.Free;
  FInfo.Free;
  FInfoFont.Free;
  FBackground.Free;
  FCommandLinkColors.Free;
  DeleteRegion;
  inherited;
end;

function TJSCustomCommandLinkButton.GetInfoText: TJSString;
begin
  result := trim(Info.Text);
end;

function TJSCustomCommandLinkButton.GetMinimumWidth: Integer;
var
  lDC: HDC;
  lRect: TRect;
begin
  lDC := GetDC(0);
  try
    Canvas.Handle := lDC;
    Canvas.Font.Assign(Font);
    lRect := Rect(0, 0, 0, 0);
    JSDrawText(Canvas.Handle, Caption, Font, lRect, CalcCaptionFlags, True);
    Canvas.Handle := 0;
    result := lRect.Right - lRect.Left + CAPTION_LEFT + RIGHT_MARGIN;
    if ShowIcon then
      inc(result, GlyphWidth + GLYPH_SPACING);
  finally
    ReleaseDC(0, lDC);
  end;
end;

function TJSCustomCommandLinkButton.GetRect(AStage: TPaintStage): TRect;
var
  lRect: TRect;
  lHeight: Integer;
  lTop: Integer;
  lText: TJSString;
  LCalcFlags: LongInt;
begin
  result := ClientRect;
  case AStage of
    psBorder:
      begin
        // no change required
      end;
    psFocus:
      begin
        InflateRect(result, -3, -3);
      end;
    psGlyph:
      begin
        if ShowIcon then
        begin
          result.Top := result.Top + 13;
          result.Bottom := result.Top + GlyphHeight;
          if BiDiMode = bdLeftToRight then
          begin
            result.Left := result.Left + GLYPH_SPACING;
            result.Right := result.Left + GlyphWidth;
          end
          else
          begin
            Result.Left := Result.Right - GLYPH_SPACING - GlyphWidth;
            Result.Right := Result.Left + GlyphWidth;
          end;
        end
        else
          result := Rect(0, 0, 6, 0);
      end;
    psCaption:
      begin
        result := GetRect(psGlyph);
        if BiDiMode = bdLeftToRight then
        begin
          inc(result.Right, 7);
          result.Left := result.Right;
          result.Right := Width - RIGHT_MARGIN;
        end
        else
        begin
          Result.Right := Result.Left - 7;
          Result.Left := GLYPH_SPACING;
        end;
        result.Top := 10;
        lRect := Rect(result.Left, 0, result.Right, 0);
        Canvas.Font.Assign(Font);
        LCalcFlags := DrawTextBiDiModeFlags(CalcCaptionFlags);
        JSDrawText(Canvas.Handle, Caption, Font, lRect, LCalcFlags, True);
        result.Bottom := result.Top + lRect.Bottom;
      end;
    psInfo:
      begin
        result := GetRect(psCaption);
        result.Top := 0;
        result.Bottom := 0;
        Canvas.Font.Assign(InfoFont);
        if PictureAssigned then
        begin
          result.Right := Width - RIGHT_MARGIN - PictureWidth - MARGIN;
          inc(result.Left, PictureWidth + PICTURE_SPACING);
        end
        else
          result.Right := Width - RIGHT_MARGIN;
        lText := GetInfoText;
        lHeight := TJSCaption.MinimumHeight(Canvas, lText, InfoFont, result.Right - result.Left);
        if PictureAssigned then
          lHeight := Max(lHeight, FPicture.Height + 4);
        result := GetRect(psCaption);
        result.Top := result.Bottom + 1;
        result.Bottom := result.Top + lHeight;
        if PictureAssigned then
        begin
          if ShowIcon then
            inc(result.Left, PictureWidth + MARGIN)
          else
            inc(result.Left, PictureWidth + MARGIN);
        end
        else
          result.Right := Width - RIGHT_MARGIN;
      end;
    psPicture:
      begin
        if PictureAssigned then
        begin
          result := GetRect(psCaption);
          lTop := result.Bottom + 4; // vertical spacing
          inc(result.Left, 1);
          result.Top := lTop;
        end;
      end;
  end;
end;

function TJSCustomCommandLinkButton.GlyphAssigned: Boolean;
begin
  Result := ValidPicture(Glyph) or ((GlyphIndex <> -1) and (GlyphImages <> nil));
end;

function TJSCustomCommandLinkButton.GlyphHeight: Integer;
begin
  if ValidPicture(Glyph) then
    result := Glyph.Height
  else if GlyphImages <> nil then

    result := GlyphImages.Height
  else
    result := FColdGlyph.Height;
end;

function TJSCustomCommandLinkButton.GlyphWidth: Integer;
begin
  if ValidPicture(Glyph) then
    result := Glyph.Width
  else if GlyphImages <> nil then
    result := GlyphImages.Width
  else
    result := FColdGlyph.Width;
end;

procedure TJSCustomCommandLinkButton.InfoChangeHandler(Sender: TObject);
begin
  AdjustBounds;
  Invalidate;
end;

function TJSCustomCommandLinkButton.IsMouseButtonPressed: Boolean;
begin
  result := FMouseButtonPressed;
end;

procedure TJSCustomCommandLinkButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FProcessEnter := (Key = VK_RETURN) and (Shift = []);
  FProcessSpace := (Key = VK_SPACE) and (Shift = []);
end;

procedure TJSCustomCommandLinkButton.KeyUp(var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((Key = VK_SPACE) and FProcessSpace) or
    ((Key = VK_RETURN) and FProcessEnter) then
    Click;
end;

function TJSCustomCommandLinkButton.LeftMargin(const AStage: TPaintStage): Integer;
begin
  result := 0;
  case AStage of
    psBorder: result := -1;
    psFocus: result := -1;
    psGlyph: result := -1;
    psCaption: result := -1;
    psInfo:
      begin
        result := 7;
        if ShowIcon then
          inc(result, GlyphWidth + GLYPH_SPACING);
        if PictureAssigned then
          inc(result, PictureWidth + PICTURE_SPACING);
      end;
    psPicture: result := -1;
  end;
end;

procedure TJSCustomCommandLinkButton.Loaded;
begin
  inherited;
  AdjustBounds;
end;

procedure TJSCustomCommandLinkButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    if Enabled then
    begin
      FMouseButtonPressed := True;
      SetFocus;
      Invalidate;
    end;
  end;
end;

procedure TJSCustomCommandLinkButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Enabled then
  begin
    FMouseButtonPressed := False;
    Invalidate;
  end;
end;

// Paint method to paint each section of the button control.
procedure TJSCustomCommandLinkButton.Paint;
var
  lRect: TRect;
  LCanvas: TCanvas;
begin
  LCanvas := Canvas;
  lRect := GetClientRect;
  if FStyle = jsbNative then
  begin
    if CommandLinkColors.Enabled then
      LCanvas.Brush.Color := CommandLinkColors.Color
    else
      LCanvas.Brush.Color := Color
  end
  else if FStyle = jsbClassic then
    LCanvas.Brush.Color := clBtnFace;
  LCanvas.Brush.Style := bsSolid;
  if CommandLinkColors.Enabled then
    GradientFillCanvas(LCanvas, CommandLinkColors.GradientStart, CommandLinkColors.GradientEnd, LRect, gdVertical)
  else
    LCanvas.FillRect(lRect);
  if Enabled and MouseInControl then
  begin
    lRect := GetRect(psBorder);
    PaintBorder(LCanvas, lRect);
  end
  else if Default and (
    (Screen.ActiveControl <> nil) and
    (Screen.ActiveControl <> Self) and
    not Screen.ActiveControl.InheritsFrom(TJSCustomCommandLinkButton)) then
  begin
    lRect := GetRect(psBorder);
    PaintDefaultBorder(LCanvas, lRect);
  end
  else if (Default and
    ((not (Screen.ActiveControl = Self)))) then
    //
  else if (Default and (not IsMouseButtonPressed) or Focused) then
  begin
    lRect := GetRect(psBorder);
    PaintDefaultBorder(LCanvas, lRect);
  end
  else if FStyle = jsbClassic then
    PaintBorder(LCanvas, lRect);
  if ShowIcon then
  begin
    lRect := GetRect(psGlyph);
    PaintGlyph(LCanvas, lRect);
  end;
  lRect := GetRect(psCaption);
  PaintCaption(LCanvas, lRect);
  lRect := GetRect(psInfo);
  PaintInfo(LCanvas, lRect);
  if PictureAssigned then
  begin
    lRect := GetRect(psPicture);
    PaintPicture(LCanvas, lRect);
  end;
  if Focused then
  begin
    lRect := GetRect(psFocus);
    PaintFocus(LCanvas, lRect);
  end;
end;

const
  { Summary
    Inner border colour of the background gradient. }
  clBorderInner = $00C6C6C6;
  { Summary
    Outer border colour of the background gradient. }
  clBorderOuter = $00EAEAEA;
  { Summary
    Default start colour for the background gradient. }
  clGradientStart = $00ECECEB;
  { Summary
    Default end colour of the background gradient. }
  clGradientEnd = $00ECECEB;
  { Summary
    Default gradient pen colour. }
  clGradientPen = $00FBFBFB;
  { Summary
    The end colour used when drawing the gradient of the button when the mouse is within the buttons bounds. }
  clMouseGradientEnd = $00F6F6F6;

// This method paints the border when the button is Hovered over (mouse in control),
// pressed down (left mouse button is down) or has focus.
//
// This method does not draw the Default border for the button control.
// The PaintDefaultBorder does this.
procedure TJSCustomCommandLinkButton.PaintBorder(ACanvas: TCanvas; ARect: TRect);
var
  lRect: TRect;
begin
  if FStyle = jsbNative then
  begin
    if Enabled and IsMouseButtonPressed then
    begin
      if CommandLinkColors.Enabled then
      begin
        if (CommandLinkColors.PressedGradientStart <> clNone) and (CommandLinkColors.PressedGradientEnd <> clNone) then
          GradientFillCanvas(ACanvas, CommandLinkColors.PressedGradientStart, CommandLinkColors.PressedGradientEnd, ARect, gdVertical)
        else
          GradientFillCanvas(ACanvas, CommandLinkColors.GradientStart, CommandLinkColors.GradientEnd, ARect, gdVertical);
      end
      else
      begin
        {$IFDEF DELPHIXE2}
        if not StyleServices.Enabled or StyleServices.IsSystemStyle then
          GradientFillCanvas(ACanvas, clGradientStart, clGradientEnd, ARect, gdVertical)
        else
        begin
          // No special visual style when custom styles enabled
        end;
        {$ELSE}
        GradientFillCanvas(ACanvas, clGradientStart, clGradientEnd, ARect, gdVertical);
        {$ENDIF DELPHIXE2}
      end;
      lRect := GetRect(psFocus);
      ACanvas.Brush.Style := bsClear;
      ACanvas.Pen.Color := ACanvas.Brush.Color;
      ACanvas.Rectangle(lRect);
    end
    else if Enabled and MouseInControl then
    begin
      lRect := ARect;
      lRect.Bottom := lRect.Bottom - 1;
      if CommandLinkColors.Enabled then
      begin
        if IsMouseButtonPressed and ((CommandLinkColors.PressedGradientStart <> clNone) or (CommandLinkColors.PressedGradientEnd <> clNone)) then
          GradientFillCanvas(ACanvas, CommandLinkColors.PressedGradientStart, CommandLinkColors.PressedGradientEnd, lRect, gdVertical)
        else
          GradientFillCanvas(ACanvas, CommandLinkColors.HotGradientStart, CommandLinkColors.HotGradientEnd, lRect, gdVertical);
      end
      else
      begin
        {$IFDEF DELPHIXE2}
        if not StyleServices.Enabled or StyleServices.IsSystemStyle then
          GradientFillCanvas(ACanvas, clWhite, clMouseGradientEnd, lRect, gdVertical)
        else
        begin
          // No special visual style when custom styles enabled
        end;
        {$ELSE}
        GradientFillCanvas(ACanvas, clWhite, clMouseGradientEnd, lRect, gdVertical);
        {$ENDIF DELPHIXE2}
      end;
      if CommandLinkColors.Enabled then
        ACanvas.Pen.Color := CommandLinkColors.GradientPen
      else
        ACanvas.Pen.Color := clGradientPen;
      ACanvas.MoveTo(ARect.Left, ARect.Bottom - 2);
      ACanvas.LineTo(ARect.Right, ARect.Bottom - 2);
    end;
    if CommandLinkColors.Enabled then
    begin
      RoundRect(ACanvas, ARect, 2, 2, CommandLinkColors.BorderOuter);
      RoundRect(ACanvas, ARect, 5, 5, CommandLinkColors.BorderInner);
    end
    else
    begin
      RoundRect(ACanvas, ARect, 2, 2, CommandLinkColors.BorderOuter);
      RoundRect(ACanvas, ARect, 5, 5, CommandLinkColors.BorderInner);
    end;
  end
  else if FStyle = jsbClassic then
  begin
    if IsMouseButtonPressed then
      DrawFrameControl(ACanvas.Handle, ARect, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_PUSHED)
    else
      DrawFrameControl(ACanvas.Handle, ARect, DFC_BUTTON, DFCS_BUTTONPUSH);
  end;
end;

// Method that paints the caption of the button. The caption is painted with the font properties
// specified in the Font property.
procedure TJSCustomCommandLinkButton.PaintCaption(ACanvas: TCanvas; ARect: TRect);
var
  lStr: TJSString;
  LDrawFlags: LongInt;
begin
  if (FStyle = jsbClassic) and IsMouseButtonPressed then
    OffsetRect(ARect, 1, 1);
  ACanvas.Brush.Style := bsClear;
  ACanvas.Font.Assign(Font);
  if Enabled then
  begin
    if MouseInControl and not IsMouseButtonPressed then
    begin
      if CommandLinkColors.Enabled then
        ACanvas.Font.Color := CommandLinkColors.FontHotColor
      else
        ACanvas.Font.Color := clCommandLinkFontHotColor;
    end
    else
    begin
      if IsMouseButtonPressed then
      begin
        if CommandLinkColors.Enabled and (CommandLinkColors.FontPressedColor <> clNone) then
          ACanvas.Font.Color := CommandLinkColors.FontPressedColor
        else
          ACanvas.Font.Color := clCommandLinkFontColor;
      end
      else
      begin
        if CommandLinkColors.Enabled then
          ACanvas.Font.Color := CommandLinkColors.FontColor
        else
          ACanvas.Font.Color := clCommandLinkFontColor;
      end;
    end;
  end
  else
  begin
    if CommandLinkColors.Enabled then
      ACanvas.Font.Color := CommandLinkColors.FontDisabledColor
    else
      ACanvas.Font.Color := clGrayText;
  end;
  if not FShowHotKey then
    lStr := StripHotkey(Caption)
  else
    lStr := Caption;
  LDrawFlags := DrawTextBiDiModeFlags(DrawCaptionFlags);
  JSDrawText(ACanvas.Handle, lStr, ACanvas.Font, ARect, LDrawFlags);
end;

const
  { Summary
    Default inner border colour of the background gradient. }
  clDefaultBorderInner = $00FFEFAE;
  { Summary
    Default outer border colour of the background gradient. }
  clDefaultBorderOuter = $00FFF4C7;

// Method that paints the border of the button when it is the default button control.
procedure TJSCustomCommandLinkButton.PaintDefaultBorder(ACanvas: TCanvas; ARect: TRect);
begin
  if FStyle = jsbNative then
  begin
    if CommandLinkColors.Enabled then
    begin
      RoundRect(ACanvas, ARect, 2, 2, CommandLinkColors.DefaultBorderOuter);
      RoundRect(ACanvas, ARect, 5, 5, CommandLinkColors.DefaultBorderInner);
    end
    else
    begin
      RoundRect(ACanvas, ARect, 2, 2, CommandLinkColors.DefaultBorderOuter);
      RoundRect(ACanvas, ARect, 5, 5, CommandLinkColors.DefaultBorderInner);
    end;
  end
  else if FStyle = jsbClassic then
  begin
    // todo: Delphi XE2
    DrawFrameControl(ACanvas.Handle, ARect, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_HOT);
  end;
end;

// Method to paint the Focus rectangle
procedure TJSCustomCommandLinkButton.PaintFocus(ACanvas: TCanvas; ARect: TRect);
begin
  if Enabled then
  begin
    ACanvas.Pen.Color := clBlack;
    ACanvas.Brush.Style := bsSolid;
    DrawFocusRect(ACanvas.Handle, ARect);
    ACanvas.Brush.Style := bsClear;
  end;
end;

// Method to paint the Glyph
//
// Painting of the Glyph is suppressed if the ShowIcon property is <b>False</b>.
procedure TJSCustomCommandLinkButton.PaintGlyph(ACanvas: TCanvas; ARect: TRect);
begin
  if (FStyle = jsbClassic) and IsMouseButtonPressed then
    OffsetRect(ARect, 1, 1);
  if GlyphAssigned then
  begin
    if ValidPicture(Glyph) then
    begin
      FGlyph.Graphic.Transparent := True;
      ACanvas.Draw(ARect.Left, ARect.Top, FGlyph.Graphic);
    end
    else
      GlyphImages.Draw(ACanvas, ARect.Left, ARect.Top, GlyphIndex, Enabled);
  end
  else
  begin
    if Enabled then
    begin
      if MouseInControl then
      begin
        if IsMouseButtonPressed then
          ACanvas.Draw(ARect.Left, ARect.Top, FDownGlyph)
        else
          ACanvas.Draw(ARect.Left, ARect.Top, FHotGlyph)
      end
      else
        ACanvas.Draw(ARect.Left, ARect.Top, FColdGlyph)
    end
    else
      ACanvas.Draw(ARect.Left, ARect.Top, FDisabledGlyph);
  end;
end;

// Method to paint the Info lines. Is painted next to the image in the
// Picture property if a valid image exists.
procedure TJSCustomCommandLinkButton.PaintInfo(ACanvas: TCanvas; ARect: TRect);
var
  lText: TJSString;
begin
  if (FStyle = jsbClassic) and IsMouseButtonPressed then
    OffsetRect(ARect, 1, 1);
  ACanvas.Font.Assign(InfoFont);
  if Enabled and MouseInControl and not IsMouseButtonPressed then
  begin
    if CommandLinkColors.Enabled then
      ACanvas.Font.Color := CommandLinkColors.FontHotColor
    else
      ACanvas.Font.Color := clCommandLinkFontHotColor;
  end
  else if Enabled then
  begin
    if IsMouseButtonPressed then
    begin
      if CommandLinkColors.Enabled and (CommandLinkColors.FontPressedColor <> clNone) then
        ACanvas.Font.Color := CommandLinkColors.FontPressedColor
      else
        ACanvas.Font.Color := clCommandLinkFontColor;
    end
    else
    begin
      if CommandLinkColors.Enabled then
        ACanvas.Font.Color := CommandLinkColors.FontColor
      else
        ACanvas.Font.Color := clCommandLinkFontColor;
    end;
  end
  else
  begin
    if CommandLinkColors.Enabled then
      ACanvas.Font.Color := CommandLinkColors.FontDisabledColor
    else
      ACanvas.Font.Color := clGrayText;
  end;
  lText := GetInfoText;
  if lText <> '' then
  begin
    FBackground.CopyRect := ARect;
    TJSCaption.PaintCaption(ACanvas, lText, FBackground, ACanvas.Font, TJSCaption.TranslateRect(ARect), Self, BiDiMode);
  end;
end;

// Method to paint a picture to the left of the Info lines.
procedure TJSCustomCommandLinkButton.PaintPicture(ACanvas: TCanvas; ARect: TRect);
begin
  if ValidPicture(FPicture) then
  begin
    if (FStyle = jsbClassic) and IsMouseButtonPressed then
      OffsetRect(ARect, 1, 1);
    FPicture.Graphic.Transparent := True;
    ACanvas.Draw(ARect.Left, ARect.Top, FPicture.Graphic);
  end
  else if (PictureIndex > -1) and (PictureImages <> nil) then
  begin
    if (FStyle = jsbClassic) and IsMouseButtonPressed then
      OffsetRect(ARect, 1, 1);
    PictureImages.Draw(ACanvas, ARect.Left, ARect.Top, PictureIndex, Enabled);
  end;
end;

function TJSCustomCommandLinkButton.PictureAssigned: Boolean;
begin
  result := ValidPicture(Picture) or ((PictureIndex > -1) and (PictureImages <> nil));
end;

procedure TJSCustomCommandLinkButton.PictureChangeHandler(Sender: TObject);
begin
  AdjustBounds;
  Invalidate;
end;

function TJSCustomCommandLinkButton.PictureHeight: Integer;
begin
  if ValidPicture(Picture) then
    result := Picture.Height
  else
    result := PictureImages.Height;
end;

function TJSCustomCommandLinkButton.PictureWidth: Integer;
begin
  if ValidPicture(Picture) then
    result := Picture.Width
  else
    result := PictureImages.Width;
end;

procedure TJSCustomCommandLinkButton.RecreateRegion;
begin
  if (Parent = nil) or not HandleAllocated then
    exit;
  DeleteRegion;
  if FStyle = jsbNative then
  begin
    FRgn := CreateRoundRectRgn(0, 0, Width + 1, Height + 1, 2, 2);
    // todo : Delphi XE2
    SetWindowRgn(Handle, FRgn, True);
  end;
end;

procedure TJSCustomCommandLinkButton.Resize;
begin
  inherited;
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.SetAutoSize(Value: Boolean);
begin
  {$IFNDEF DELPHI5}
  inherited;
  {$ENDIF DELPHI5}
  AdjustBounds;
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited;
  RecreateRegion;
end;

procedure TJSCustomCommandLinkButton.InitialiseFonts;
var
  lMetrics: {$IFDEF DELPHI2009}tagNONCLIENTMETRICS{$ELSE}tagNONCLIENTMETRICSA{$ENDIF};
begin
  FInfoFont := TFont.Create;
  FInfoFont.OnChange := InfoChangeHandler;
  lMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @lMetrics, 0) then
  begin
    Font.Handle := CreateFontIndirect(lMetrics.lfMessageFont);
    FInfoFont.Handle := CreateFontIndirect(lMetrics.lfMessageFont);
  end;
  Font.Size := 12;
  FInfoFont.Size := 9;
  Font.Color := clCommandLinkFontColor;
  FInfoFont.Color := clCommandLinkFontColor;
end;

procedure TJSCustomCommandLinkButton.InitialiseGlyphs;
begin
  FColdGlyph := TIcon.Create;
  FColdGlyph.Handle := LoadImage(hInstance, COLD_BTN, IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
  FHotGlyph := TIcon.Create;
  FHotGlyph.Handle := LoadImage(hInstance, HOT_BTN, IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
  FDownGlyph := TIcon.Create;
  FDownGlyph.Handle := LoadImage(hInstance, DOWN_BTN, IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
  FDisabledGlyph := TIcon.Create;
  FDisabledGlyph.Handle := LoadImage(hInstance, DISABLED_BTN, IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
end;

procedure TJSCustomCommandLinkButton.DeleteRegion;
begin
  if FRgn <> 0 then
    DeleteObject(FRgn);
end;

procedure TJSCustomCommandLinkButton.SetCancel(const Value: Boolean);
begin
  if FCancel <> Value then
    FCancel := Value;
end;

procedure TJSCustomCommandLinkButton.SetCaption(const Value: TJSString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.SetCommandLinkColors(
  const Value: TJSCommandLinkColors);
begin
  FCommandLinkColors.Assign(Value);
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.SetDefault(const Value: Boolean);
begin
  if FDefault <> Value then
  begin
    FDefault := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.SetDefaultHeight(const Value: Integer);
begin
  if FDefaultHeight <> Value then
  begin
    FDefaultHeight := Value;
    AdjustBounds;
  end;
end;

procedure TJSCustomCommandLinkButton.SetElevationRequired(const Value: Boolean);
begin
  if FElevationRequired <> Value then
  begin
    FElevationRequired := Value;
    if Value then
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHIELD_SML')
    else
      FGlyph.Assign(nil);
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.SetGlyph(const Value: TPicture);
begin
  FGlyph.Assign(Value);
  if ValidPicture(Value) then
    FGlyph.Graphic.Transparent := True;
  AdjustBounds;
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.SetGlyphImages(const Value: TCustomImageList);
begin
  if FGlyphImages <> Value then
  begin
    FGlyphImages := Value;
    if FGlyphImages <> nil then
      FGlyphImages.FreeNotification(Self);
  end;
end;

procedure TJSCustomCommandLinkButton.SetGlyphIndex(const Value: Integer);
begin
  if FGlyphIndex <> Value then
  begin
    FGlyphIndex := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.SetInfo(const Value: TJSStrings);
begin
  if Value.Text <> FInfo.Text then
  begin
    FInfo.Assign(Value);
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.SetInfoFont(const Value: TFont);
begin
  FInfoFont.Assign(Value);
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.SetPictureImages(
  const Value: TCustomImageList);
begin
  if FPictureImages <> Value then
  begin
    FPictureImages := Value;
    if FPictureImages <> nil then
      FPictureImages.FreeNotification(Self);
  end;
end;

procedure TJSCustomCommandLinkButton.SetPictureIndex(const Value: Integer);
begin
  if FPictureIndex <> Value then
  begin
    FPictureIndex := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.SetShowIcon(const Value: Boolean);
begin
  if FShowIcon <> Value then
  begin
    FShowIcon := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.SetStyle(const Value: TJSButtonStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCommandLinkButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TJSCustomCommandLinkButton.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  SetFocus;
  Invalidate;
end;

procedure TJSCustomCommandLinkButton.SetShowHotKey(const Value: Bool);
begin
  if FShowHotKey <> Value then
  begin
    FShowHotKey := Value;
    Invalidate;
  end;
end;

{ TJSSymbolButton }

constructor TJSSymbolButton.Create(AOwner: TComponent);
begin
  inherited;
  FArrowSize := 4;
  FStyle := sbsNone;
  FSymbolColor := clNone;
  FSymbolShadowColor := clNone;
end;

procedure SetupCanvas(ACanvas: TCanvas; const AColor, ADefault: TColor);{$IFDEF INLINE}inline;{$ENDIF}
begin
  if AColor = clNone then
  begin
    ACanvas.Pen.Color := ADefault;
    ACanvas.Brush.Color := ADefault;
  end
  else
  begin
    ACanvas.Pen.Color := AColor;
    ACanvas.Brush.Color := AColor;
    ACanvas.Brush.Style := bsSolid;
  end;
end;

procedure TJSSymbolButton.Paint;
var
  lPt: TPoint;
begin
  inherited;
  if FStyle <> sbsNone then
  begin
    SetupCanvas(Canvas, FSymbolShadowColor, clWhite);
    case FStyle of
      sbsEllipsis:
        begin
          lPt.X := (Width - 10) div 2;
          lPt.Y := (Height div 3) * 2;
          inc(lPt.X);
          inc(lPt.Y);
          if FState = bsDown then
          begin
            inc(lPt.X);
            inc(lPt.Y);
          end;
          Canvas.Rectangle(lPt.X, lPt.Y, lPt.X + 2, lPt.Y + 2);
          inc(lPt.X, 4);
          Canvas.Rectangle(lPt.X, lPt.Y, lPt.X + 2, lPt.Y + 2);
          inc(lPt.X, 4);
          Canvas.Rectangle(lPt.X, lPt.Y, lPt.X + 2, lPt.Y + 2);
          SetupCanvas(Canvas, FSymbolColor, clBtnText);
          lPt.X := (Width - 10) div 2;
          lPt.Y := (Height div 3) * 2;
          if FState = bsDown then
          begin
            inc(lPt.X);
            inc(lPt.Y);
          end;
          Canvas.Rectangle(lPt.X, lPt.Y, lPt.X + 2, lPt.Y + 2);
          inc(lPt.X, 4);
          Canvas.Rectangle(lPt.X, lPt.Y, lPt.X + 2, lPt.Y + 2);
          inc(lPt.X, 4);
          Canvas.Rectangle(lPt.X, lPt.Y, lPt.X + 2, lPt.Y + 2);
        end;
      sbsArrowDown, sbsArrowUp:
        begin
          lPt.X := (Width div 2) - FArrowSize;
          lPt.Y := (Height div 2) - 3;
          if FState = bsDown then
          begin
            inc(lPt.X);
            inc(lPt.Y);
          end;
          inc(lPt.X);
          if FStyle = sbsArrowDown then
            inc(lPt.Y)
          else
            dec(lPt.Y);
          SetupCanvas(Canvas, FSymbolShadowColor, clWhite);
          if FStyle = sbsArrowDown then
            DrawArrow(Canvas, sdDown, lPt, FArrowSize)
          else
            DrawArrow(Canvas, sdUp, lPt, FArrowSize);
          lPt.X := (Width div 2) - FArrowSize;
          lPt.Y := (Height div 2) - 3;
          if FState = bsDown then
          begin
            inc(lPt.X);
            inc(lPt.Y);
          end;
          SetupCanvas(Canvas, FSymbolColor, clBtnText);
          if FStyle = sbsArrowDown then
            DrawArrow(Canvas, sdDown, lPt, FArrowSize)
          else
            DrawArrow(Canvas, sdUp, lPt, FArrowSize);
        end;
      sbsArrowLeft:
        begin
          lPt.X := (Width div 2) - 3;
          lPt.Y := (Height div 2) - (FArrowSize + 1);
          if FState = bsDown then
          begin
            inc(lPt.X);
            inc(lPt.Y);
          end;
          SetupCanvas(Canvas, FSymbolColor, clBtnText);
          DrawArrow(Canvas, sdLeft, lPt, FArrowSize);
        end;
      sbsArrowRight:
        begin
          lPt.X := (Width div 2) - 3;
          lPt.Y := (Height div 2) - (FArrowSize + 1);
          if FState = bsDown then
          begin
            inc(lPt.X);
            inc(lPt.Y);
          end;
          SetupCanvas(Canvas, FSymbolColor, clBtnText);
          DrawArrow(Canvas, sdRight, lPt, FArrowSize);
        end;
    end;
  end;
end;

procedure TJSSymbolButton.SetArrowSize(const Value: Integer);
begin
  if FArrowSize <> Value then
  begin
    FArrowSize := Value;
    Invalidate;
  end;
end;

procedure TJSSymbolButton.SetStyle(const Value: TSymbolButtonStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

procedure TJSSymbolButton.SetSymbolColor(const Value: TColor);
begin
  if FSymbolColor <> Value then
  begin
    FSymbolColor := Value;
    Invalidate;
  end;
end;

{ TJSCustomColors }

procedure TJSCommandLinkColors.Assign(Source: TPersistent);
var
  LSrc: TJSCommandLinkColors;
begin
  if Source is TJSCommandLinkColors then
  begin
    LSrc := TJSCommandLinkColors(Source);
    FBorderInner := LSrc.BorderInner;
    FBorderOuter := LSrc.BorderOuter;
    FColor := LSrc.Color;
    FDefaultBorderInner := LSrc.DefaultBorderInner;
    FDefaultBorderOuter := LSrc.DefaultBorderOuter;
    FEnabled := LSrc.Enabled;
    FFontColor := LSrc.FontColor;
    FFontDisabledColor := LSrc.FontDisabledColor;
    FFontHotColor := LSrc.FontHotColor;
    FFontPressedColor := LSrc.FontPressedColor;
    FGradientEnd := LSrc.GradientEnd;
    FGradientPen := LSrc.GradientPen;
    FGradientStart := LSrc.GradientStart;
    FHotGradientEnd := LSrc.HotGradientEnd;
    FHotGradientStart := LSrc.HotGradientStart;
    FPressedGradientEnd := LSrc.PressedGradientEnd;
    FPressedGradientStart := LSrc.PressedGradientStart;
  end
  else
    inherited;
end;

constructor TJSCommandLinkColors.Create(AButton: TJSCustomCommandLinkButton);
begin
  inherited Create;
  FEnabled := False;
  FBorderInner := $00C6C6C6;
  FBorderOuter := $00EAEAEA;
  FColor := clWindow;
  FDefaultBorderInner := $00FFEFAE;
  FDefaultBorderOuter := $00FFF4C7;
  FFontColor := $00551C15;
  FFontDisabledColor := clGrayText;
  FFontHotColor := $00E54A07;
  FFontPressedColor := clNone;
  FGradientEnd := clNone;
  FGradientPen := $00FBFBFB;
  FGradientStart := clNone;
  FHotGradientEnd := $00F6F6F6;
  FHotGradientStart := clWhite;
  FPressedGradientEnd := $00ECECEB;
  FPressedGradientStart := $00ECECEB;
  FCommandLinkButton := AButton;
end;

function TJSCommandLinkColors.LoadFromFile(const AFilename: string): Boolean;
var
  LFile: TIniFile;
begin
  Result := FileExists(AFilename);
  if Result then
  begin
    LFile := TIniFile.Create(AFilename);
    try
      // Do not localise
      BorderInner := StringToColor(LFile.ReadString('Color', 'BorderInner', '$00C6C6C6'));
      BorderOuter := StringToColor(LFile.ReadString('Color', 'BorderOuter', '$00EAEAEA'));
      DefaultBorderInner := StringToColor(LFile.ReadString('Color', 'DefaultBorderInner', '$00FFEFAE'));
      DefaultBorderOuter := StringToColor(LFile.ReadString('Color', 'DefaultBorderOuter', '$00FFF4C7'));
      FontColor := StringToColor(LFile.ReadString('Color', 'FontColor', '$00551C15'));
      FontPressedColor := StringToColor(LFile.ReadString('Color', 'FontPressedColor', 'clNone'));
      FontHotColor := StringToColor(LFile.ReadString('Color', 'FontHotColor', '$00E54A07'));
      FontDisabledColor := StringToColor(LFile.ReadString('Color', 'FontDisabledColor', 'clGrayText'));
      GradientStart := StringToColor(LFile.ReadString('Color', 'GradientStart', 'clWindow'));
      GradientEnd := StringToColor(LFile.ReadString('Color', 'GradientEnd', 'clWindow'));
      HotGradientStart := StringToColor(LFile.ReadString('Color', 'HotGradientStart', 'clWhite'));
      HotGradientEnd := StringToColor(LFile.ReadString('Color', 'HotGradientEnd', '$00F6F6F6'));
      PressedGradientStart := StringToColor(LFile.ReadString('Color', 'PressedGradientStart', '$00ECECEB'));
      GradientPen := StringToColor(LFile.ReadString('Color', 'GradientPen', '$00FBFBFB'));
      PressedGradientEnd := StringToColor(LFile.ReadString('Color', 'PressedGradientEnd', '$00ECECEB'));
      Color := StringToColor(LFile.ReadString('Color', 'Color', 'clWindow'));
    finally
      LFile.Free;
    end;
  end;
end;

procedure TJSCommandLinkColors.SaveToFile(const AFilename: string);
var
  LFile: TIniFile;
begin
  LFile := TIniFile.Create(AFilename);
  try
    // Do not localise
    LFile.WriteInteger('General', 'Version', 1);
    LFile.WriteString('Color', 'BorderInner', ColorToString(BorderInner));
    LFile.WriteString('Color', 'BorderOuter', ColorToString(BorderOuter));
    LFile.WriteString('Color', 'DefaultBorderInner', ColorToString(DefaultBorderInner));
    LFile.WriteString('Color', 'DefaultBorderOuter', ColorToString(DefaultBorderOuter));
    LFile.WriteString('Color', 'FontColor', ColorToString(FontColor));
    LFile.WriteString('Color', 'FontPressedColor', ColorToString(FontPressedColor));
    LFile.WriteString('Color', 'FontHotColor', ColorToString(FontHotColor));
    LFile.WriteString('Color', 'FontDisabledColor', ColorToString(FontDisabledColor));
    LFile.WriteString('Color', 'GradientStart', ColorToString(GradientStart));
    LFile.WriteString('Color', 'GradientEnd', ColorToString(GradientEnd));
    LFile.WriteString('Color', 'HotGradientStart', ColorToString(HotGradientStart));
    LFile.WriteString('Color', 'HotGradientEnd', ColorToString(HotGradientEnd));
    LFile.WriteString('Color', 'PressedGradientStart', ColorToString(PressedGradientStart));
    LFile.WriteString('Color', 'GradientPen', ColorToString(GradientPen));
    LFile.WriteString('Color', 'PressedGradientEnd', ColorToString(PressedGradientEnd));
    LFile.WriteString('Color', 'Color', ColorToString(Color));
  finally
    LFile.Free;
  end;
end;

procedure TJSCommandLinkColors.SetBorderInner(const Value: TColor);
begin
  if FBorderInner <> Value then
  begin
    FBorderInner := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetBorderOuter(const Value: TColor);
begin
  if FBorderOuter <> Value then
  begin
    FBorderOuter := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if FCommandLinkButton <> nil then
      FCommandLinkButton.Color := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetDefaultBorderInner(const Value: TColor);
begin
  if FDefaultBorderInner <> Value then
  begin
    FDefaultBorderInner := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetDefaultBorderOuter(const Value: TColor);
begin
  if FDefaultBorderOuter <> Value then
  begin
    FDefaultBorderOuter := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetFontColor(const Value: TColor);
begin
  if FFontColor <> Value then
  begin
    FFontColor := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetFontDisabledColor(const Value: TColor);
begin
  if FFontDisabledColor <> Value then
  begin
    FFontDisabledColor := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetFontHotColor(const Value: TColor);
begin
  if FFontHotColor <> Value then
  begin
    FFontHotColor := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetFontPressedColor(const Value: TColor);
begin
  if FFontPressedColor <> Value then
  begin
    FFontPressedColor := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetGradientEnd(const Value: TColor);
begin
  if FGradientEnd <> Value then
  begin
    FGradientEnd := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetGradientPen(const Value: TColor);
begin
  if FGradientPen <> Value then
  begin
    FGradientPen := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetGradientStart(const Value: TColor);
begin
  if FGradientStart <> Value then
  begin
    FGradientStart := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetHotGradientEnd(const Value: TColor);
begin
  if FHotGradientEnd <> Value then
  begin
    FHotGradientEnd := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetHotGradientStart(const Value: TColor);
begin
  if FHotGradientStart <> Value then
  begin
    FHotGradientStart := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetPressedGradientEnd(const Value: TColor);
begin
  if FPressedGradientEnd <> Value then
  begin
    FPressedGradientEnd := Value;
    DoChange;
  end;
end;

procedure TJSCommandLinkColors.SetPressedGradientStart(const Value: TColor);
begin
  if FPressedGradientStart <> Value then
  begin
    FPressedGradientStart := Value;
    DoChange;
  end;
end;

end.
