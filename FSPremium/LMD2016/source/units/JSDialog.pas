{ Summary
  This unit contains the main TJSDialog class implementation.
  Description
  This unit contains the main implementation of the TJSDialog
  as well as several global utilities functions useful for when
  working with the dialog.                                      }
unit JSDialog;

interface

{$I lmddlgcmps.inc}

uses
    Windows
  , ComCtrls
  , Messages
  , Graphics
  , Controls
  , SysUtils
  , Contnrs
  , StdCtrls
  , Classes
  , JSRichEdit
  , JSLabel
  , JSProgressBar
  , JSCheckBox
  {$IFDEF TNTUnicode}
  , TntStdCtrls
  , TntForms
  {$ENDIF TNTUnicode}
  , Forms
  , ExtCtrls
  , Buttons
  , JSDialogs
  {$IFDEF BDS}
  , GraphUtil
  {$ENDIF BDS}
  , JSGraphUtil
  , ImgList
  {$IFNDEF DELPHI5}
  , Types
  , StrUtils
  {$ENDIF DELPHI5}
  , JSTypes
  , JSGraphics
  , JSButton
  {$IFDEF DELPHIXE3}
  , System.UITypes
  {$ENDIF}
  ;

const
  { Default Color used for the dialog instruction }
  clInstruction = $00993300;
  { Color constant defined for the color used in vista to draw
    the divider line between the content section of the dialog
    and the common button section.                             }
  clVistaSeparator = $00DFDFDF;

  { Message sent to the TJSTaskDialogForm instance when the
    dialog is being closed and it is not a modal dialog }
  WM_NONMODAL_FREE = WM_USER + 47;
  { Message sent to the TJSTaskDialogForm instance when the
    user has the mouse option set where the mouse should move
    automatically to the default button on a dialog }
  WM_PERFORMSNAPTO = WM_USER + 43;

  { Specifies the first value of a custom button on a dialog. }
  BASE_CUSTOMBUTTON = 100;
  { Specifies the first value of a radio button on a dialog. }
  BASE_RADIOBUTTON = 200;

type
  {$IFDEF DELPHI5}
  { Type required for Delphi 5 compatibility. }
  THelpContext = -MaxLongint..MaxLongint;
  {$ENDIF DELPHI5}

  { Summary
    Type of exception raised when no help file has been found for
    the current application
    Description
    When a help link has been clicked but the application does
    not have a help file associated to it, then an exception of
    this type is raised.                                          }
  JSNoHelpFileException = class(Exception);

  { Summary
    Type of exception raised when TJSDialogSheet specific exceptions occur.
    Description
    Add a description here...                                               }
  EDialogSheet = class(Exception);

  { Summary
    Determines what section the font method being called will modify. }
  TJSFontType = (
    ftContent { This is the font to be used when drawing the dialogs Content. },
    ftInstruction { This is the font to be used when drawing the dialogs Instruction. },
    ftHeader { This is the font to be used when drawing the dialogs Header. },
    ftFooter { This is the font to be used when drawing the dialogs Footer. },
    ftExpando { This is the font to be used when drawing the dialogs Expando button. }
  );

  { Summary
    Defines the location of a mouse click on a dialog. }
  TJSDialogHitTest = (
    htNone { Location of hit test is nowhere. },
    htHeader { Location of hit test is within the header section. },
    htHeaderImage { Location of hit test is on the header image. },
    htInstruction { Location of hit test is within the instruction section. },
    htInstructionImage { Location of hit test is on the instruction image. },
    htContent { Location of hit test is within the content section. },
    htMainIcon { Location of hit test is on the main icon glyph. },
    htButtonBar { Location of hit test is within the button bar. },
    htExpandedSection { Location of hit test is within the expanded section. },
    htFooter { Location of hit test is within the footer section. },
    htFooterImage { Location of hit test is on the image in the footer. }
  );

  { Summary
    Used to retrieve the location for the item specified. }
  TPaintStage = (
    psGlyph { Location of the dialog Glyph. },
    psInstruction { Location of the dialog Instruction. },
    psContent { Location of the dialog Content. },
    psMoreLines { Location of the More text when ShowInFooter is False. },
    psRadio { Location of the Radio Buttons. },
    psCommand { Location of the Command Link Buttons. },
    psHeader { Location of the Header. },
    psFooter { Location of the Footer. This will not always be at the bottom of the dialog. See psMoreFooter for additional information. },
    psMoreFooter { When ShowInFooter is True when Expando button is visible this is used for the location of more text. },
    psButtonBar { Location that displays the Common Buttons, More Button and Verification check box.
      Can also be the location when CustomButtons are displayed when not using CommandLinks. },
    psHelpLink { Location of the Help Link label. },
    psProgressBar { Location of the Progress Bar. },
    psInstructBounds { This rect includes the spacing around the instruction section }
  );

  { Overview: Type of control that the dialog is asking for information on.
    This allows you to typecast the TControl parameter with
    assurance that the control matches the type you specified.    }
  TControlType = (
    ctButton { This control type is used for the buttons that appear in the
      ButtonBar. When doCommandLinks is not specified in the
      DialogOptions property, any custom buttons also use this
      control type.                                                },
    ctCommandLink { Control type used for the command links. Command Links are
      only available when doCommandLinks or doCommandLinksNoIcon
      is specified in DialogOptions. Additional command link
      properties are to be read from the corresponding
      CustomButtonItem class.                                     },
    ctCheckBox { This control type is used as the verification control. This
      control type appears in the footer of the dialog.           },
    ctMoreButton { This control type is for the control that shows the user that
      there is more information available for viewing. This control
      must allow for an HideText and ShowText caption as well as
      provide visual feedback to the user to let them know that
      more information is available.                                },
    ctRichEdit { This control type is used when the Expando text is to be
      displayed in the Footer. For the Expando text to be
      displayed in the footer the ShowInFooter property must be
      true.                                                        },
    ctLinkLabel { This control type is the clickable label that provides
      additional help information to the user. Clicking this
      control type should open the applications Help File and
      activate the topic that is specified by the HelpLink
      property.                                               },
    ctURLLabel { This control type is used in the footer of the dialog. Any
      class that is used in the footer should be able to support
      embedded hyperlinks.                                       },
    ctRadioButton{ RadioButton control. This control is used when displaying a
      list of options to the user.

      Specify the radio buttons properties using the
      RadioButtonItem collection item class created when adding
      items to the RadioButtons property.                         },
    ctProgressBar { This control type is used when displaying some progress
      within the dialog },
    ctRadioGroup { This control type is used when the RadioButton.ShowBorder
      property is True. It also allows the radio buttons to be displayed in
      columns },
    ctMaxLines { This control type is used when the MaxLines value is greater than
      0 and the content of the dialog has reached the maximum number of lines to display }
  );


  { Class used to compare a set of two integers against each other.
    This class is used to check if the dimensions of a custom icon has changed. }
  TJSSizeComparer = class
  private
    FWidth: Integer;
    FHeight: Integer;
  public
    { Create a TJSSizeComparer instance with the default Width and Height set }
    constructor Create(const aWidth, aHeight: Integer);
    { Call this method to check the AWidth and AHeight parameters against the
      default Width and Height parameters set when constructed. }
    function IsEqual(const aWidth, aHeight: Integer): Boolean;
  end;

  TJSCustomDialog = class;

  TJSDialog = class;

  TJSCustomButtons = class;

  { Overview
    Class used to store information about a custom button that is used in the dialog }
  TJSCustomButtonItem = class(TCollectionItem)
  private
    FCaption: TJSString;
    FValue: Integer;
    FOwner: TJSCustomButtons;
    FGlyph: TPicture;
    FImageIndex: Integer;
    FModalResult: TModalResult;
    FDefault: Boolean;
    FHint: TJSString;
    FCancel: Boolean;
    FInfo: TJSStrings;
    FElevationRequired: Boolean;
    FPicture: TPicture;
    FEnabled: Boolean;
    FPictureIndex: Integer;
    FVisible: Boolean;
    procedure SetCaption(const Value: TJSString);
    procedure SetGlyph(const Value: TPicture);
    procedure SetHint(const Value: TJSString);
    procedure SetInfo(const Value: TJSStrings);
    procedure SetPicture(const Value: TPicture);
    procedure SetValue(const Value: Integer);
    procedure SetEnabled(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  protected
    { Returns the owner of the isntance }
    function GetOwner: TPersistent; override;
    { Returns the value to display in the collection editor at design time }
    function GetDisplayName: string; override;
  public
    { Override constructor to initialise default values }
    constructor Create(Collection: TCollection); override;
    { Override destructor to clean up any created objects }
    destructor Destroy; override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { When True the shield icon is displayed on the custom button. It doesn't matter
      if command links are being displayed, the shield is displayed regardless. }
    property ElevationRequired: Boolean read FElevationRequired write FElevationRequired default False;
    { The text that appears on the button }
    property Caption: TJSString read FCaption write SetCaption;
    { The custom image associated with the button. This image should be only 16 x 16 pixels.
      NOTE: Only valid when Command Links are being used. }
    property Glyph: TPicture read FGlyph write SetGlyph;
    { If the CustomButtons have an image list assigned then the button will
      display the image at the index specified in that image list.
      NOTE: Only valid when Command Links are being used. }
    property ImageIndex: Integer read FImageIndex write FImageIndex default -1;
    { The return value that is used to identify when this button has been clicked in the dialog.
      Handle the OnControlClick event and check the Value parameter to identify which button has
      actually been clicked. }
    property Value: Integer read FValue write SetValue;
    { The return result that the dialogs ModalResult property is set to when this button is clicked. }
    property ModalResult: TModalResult read FModalResult write FModalResult default mrNone;
    { Determines whether the button's OnClick event handler executes when the Enter key is pressed.
      If Default is true, the button's OnClick event handler executes when the user presses Enter.

      Although an application can have more than one Default button, the form calls the OnClick event
      handler only for the first visible button in the tab order. Moreover, any button that has focus
      becomes the Default button temporarily; hence, if the user selects another button before
      pressing Enter, the selected button's OnClick event handler executes instead. }
    property Default: Boolean read FDefault write FDefault default False;
    { Determines whether the button's OnClick event handler executes when the Escape key is pressed.
      If Cancel is true, the button's OnClick event handler executes when the user presses Esc.
      Although an application can have more than one Cancel button, the form calls the OnClick event
      handler only for the first visible button in the tab order. }
    property Cancel: Boolean read FCancel write FCancel default False;
    { Contains the text string that can appear when the user moves the mouse over the control. }
    property Hint: TJSString read FHint write SetHint;
    { Additional text information that is displayed under the buttons Caption and to the right of
      any Picture that is associated with the button.
      NOTE: Only valid when Command Links are being used. }
    property Info: TJSStrings read FInfo write SetInfo;
    { Assign a picture to your custom button to display an image under the Caption and to the left of
      any assigned Info text. While the picture can be any size you choose, the recommended maximum
      size if 48 x 48 pixels.
      NOTE: Only valid when Command Links are being used. }
    property Picture: TPicture read FPicture write SetPicture;
    { If the CustomButtons have a Picture image list assigned then the button will
      display the image at the index specified in that image list.
      NOTE: Only valid when Command Links are being used.
      See Also: Picture }
    property PictureIndex: Integer read FPictureIndex write FPictureIndex default -1;
    { Default Enabled state for the button. }
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    { Default Visible state for the button.
      NOTE: If the button has Visible set to false, then the button cannot be made visible until
      the dialog has been closed. }
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  { Overview
    Collection that maintains the list of custom button items. }
  TJSCustomButtons = class(TOwnedCollection)
  private
    FImages: TCustomImageList;
    FPictureImages: TCustomImageList;
    function GetMessagePanel: TJSCustomDialog;
    function GetItem(Index: Integer): TJSCustomButtonItem;
    procedure SetItem(Index: Integer; const Value: TJSCustomButtonItem);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetPictureImages(const Value: TCustomImageList);
    function GetVisibleCount: Integer;
  protected
    {$IFNDEF DELPHI5}
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    {$ENDIF DELPHI5}
  public
    { Creates and initialises a TJSCustomButtons instance. }
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    { Destroys the collection and each item in it. }
    destructor Destroy; override;
    { Copies the contents of another collection to the object where the method is executed. }
    procedure Assign(Source: TPersistent); override;
    { Returns the owner of the collection }
    property MessagePanel: TJSCustomDialog read GetMessagePanel;
    { Creates a new TJSCustomButtonItem instance and adds it to the Items array. }
    function Add: TJSCustomButtonItem;
    { Returns the modal result of the TJSCustomButtonItem that has the Value equal to
      the AValue parameter }
    function GetModalResult(const aValue: Integer): Integer;
    { Lists the items in the collection. }
    property Items[Index: Integer]: TJSCustomButtonItem read GetItem write SetItem; default;
    { Returns the number of Visible buttons in the collection }
    property VisibleCount: Integer read GetVisibleCount;
  published
    { ImageList to be used for items that have the ImageIndex property set
      See Also: TCustomButtonItem.ImageIndex
      See Also: TCustomButtonItem.Glyph }
    property Images: TCustomImageList read FImages write SetImages;
    { ImageList to be used for items that have the PictureIndex property set
      See Also: TCustomButtonItem.PictureIndex
      See Also: TCustomButtonItem.Picture }
    property PictureImages: TCustomImageList read FPictureImages write SetPictureImages;
  end;

  TJSRadioButtons = class;

  { Describes the appearance of any radio buttons on the dialog. }
  TJSRadioButtonItem = class(TCollectionItem)
  private
    FCaption: TJSString;
    FValue: Integer;
    FChecked: Boolean;
    FEnabled: Boolean;
    procedure SetCaption(const Value: TJSString);
    function CanUpdateControls(out ADialog: TJSCustomDialog): Boolean; {$IFDEF INLINE}inline;{$ENDIF INLINE}
  protected
    function GetDisplayName: string; override;
  public
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
    { Creates and initializes a TJSRadioButtonItem instance. }
    constructor Create(Collection: TCollection); override;
  published
    { Caption of the radio button. }
    property Caption: TJSString read FCaption write SetCaption;
    { Determines whether the radio button is checked when it is
      first displayed. Remember that since only one radio button
      can be checked at a time, if you specify Checked for more
      than one radio button only the last radio button created will
      be checked.                                                   }
    property Checked: Boolean read FChecked write FChecked default False;
    { If Enabled is TRUE then the user to change the checked state
      of the radio button.                                        }
    property Enabled: Boolean read FEnabled write FEnabled default True;
    { The internal value assigned to the radio button. This helps
      you determine which radio button has been checked. Radio
      Button values are automatically assigned when the radio
      button is added and start at 200. You shouldn't need to
      modify this value.                                          }
    property Value: Integer read FValue write FValue;
  end;

  { Collection that maintains the list of radio button items.
    Keywords: radio buttons;TJSRadioButtonItem;TJSRadioButtons}
  TJSRadioButtons = class(TOwnedCollection)
  private
    function GetMessagePanel: TJSCustomDialog;
    function GetItem(Index: Integer): TJSRadioButtonItem;
    procedure SetItem(Index: Integer; const Value: TJSRadioButtonItem);
  protected
    {$IFNDEF DELPHI5}
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    {$ENDIF DELPHI5}
  public
    { Returns the owner of the collection }
    property MessagePanel: TJSCustomDialog read GetMessagePanel;
    { Creates a new TJSRadioButtonItem instance and adds it to the Items array. }
    function Add: TJSRadioButtonItem;
    { Returns the item that has the Value equal to the AValue parameter }
    function ItemWithValue(const AValue: Integer): TJSRadioButtonItem;
    { Changes the Enabled value of a Radio Button before it has been created.
      If you want to change the enabled value after the dialog has been displayed use the
      EnableRadioButton method. }
    procedure SetEnabled(const AValue: Integer; const AEnabled: Boolean);
    { Lists the items in the collection. }
    property Items[Index: Integer]: TJSRadioButtonItem read GetItem write SetItem; default;
  end;

  { Summary
    A TPersistent class that is owned by a TJSCustomDialog. }
  TJSDialogOwnedPersistent = class(TJSChangePersistent)
  private
    FDialog: TJSCustomDialog;
  protected
    { Returns the owner of the TJSDialogOwnedPersistent class }
    property Dialog: TJSCustomDialog read FDialog;
  public
    { Creates and initializes a TJSDialogOwnedPersistent instance. }
    constructor Create(ADialog: TJSCustomDialog); reintroduce; virtual;
  end;

  { Class that contains displayable text on the dialog }
  TJSTextSection = class(TJSDialogOwnedPersistent)
  end;

  { Clas that contains the options for customising the appearance of command link buttons. }
  TJSButtonOptions = class(TJSDialogOwnedPersistent)
  private
    FCommandLinkColors: TJSCommandLinkColors;
    procedure SetCommandLinkColors(const Value: TJSCommandLinkColors);
  public
    constructor Create(ADialog: TJSCustomDialog); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    { Summary
      Links to the properties used to control the style of the command link button.
      Description
      Used to customise the appearance of the TJSCommandLinkButton instances displayed on the dialog. }
    property CommandLinkColors: TJSCommandLinkColors read FCommandLinkColors write SetCommandLinkColors;
  end;

  { Class that holds the settings for when a progress bar is
    displayed on the dialog.

    For the progress bar to be visible you must have either
    doProgressBar or doProgressBarMarquee set in the
    DialogOptions property.                                  }
  TJSProgress = class(TJSDialogOwnedPersistent)
  private
    FMax: Integer;
    FMin: Integer;
    FStep: Integer;
    FPosition: Integer;
    FState: TProgressBarState;
    FInterval: Cardinal;
    FUseNativeProgressbar: Boolean;
    FShowOnTaskBar: Boolean;
    procedure SetInterval(const Value: Cardinal);
    procedure SetMax(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetState(const Value: TProgressBarState);
    procedure SetStep(const Value: Integer);
    procedure SetUseNativeProgressBar(const Value: Boolean);
    procedure SetShowOnTaskBar(const Value: Boolean);
  public
    { Creates and initializes a TJSProgress instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { Set the interval to control the scrolling speed when a
      Marquee progress bar is being displayed. The lower the
      interval, the faster the scrolling speed.              }
    property Interval: Cardinal read FInterval write SetInterval default 100;
    { The maximum value of the progress bar. Once the progress has
      reached the Max value, the dialog is automatically closed.   }
    property Max: Integer read FMax write SetMax default 100;
    { The start value for the progress bar. }
    property Min: Integer read FMin write FMin default 0;
    { The amount the Progress property is updated by when
      UpdateProgress method is called on the TJSDialog.   }
    property Step: Integer read FStep write SetStep default 1;
    { The current position of the progress bar. While the dialog is
      being displayed the position value will change as the
      progress progresses.                                          }
    property Position: Integer read FPosition write SetPosition default 0;
    { Display the progress bar progress in the task bar for the application. This option
      is only available on Windows 7 systems. }
    property ShowOnTaskBar: Boolean read FShowOnTaskBar write SetShowOnTaskBar default False;
    { The state of the progress bar. Currently only supported for
      non-themed dialogs. The possible states are Normal, Paused
      and Error.                                                  }
    property State: TProgressBarState read FState write SetState default pbstNormal;
    { Summary
      Determines if the dialog should use the native progress bar if possible.
      Description
      Set the UseNativeProgressBar property to False to always use the TJSProgressBar control. The
      advantage of not using the native progress bar is when you display a marquee. The marquee style in
      TJSProgressBar is threaded which means that even in a long running progress, updates are visible.
      This is not the case with the native progress bar control.
      Remarks
      When the progress bar of a dialog is to be shown as a marquee (DialogOptions contains
      doProgressBarMarquee) then the minimum operating system for using the native progress bar is Windows
      XP. If the operating system is earlier than Windows XP then the TJSProgressBar control is always
      used.                                                                                                }
    property UseNativeProgressBar: Boolean read FUseNativeProgressbar write SetUseNativeProgressBar default True;
  end;

  { Type used in the OnUpdateProgressBar event that helps update
    the progress bar style when using a custom progress bar.     }
  TUpdateProgressBarStateEvent = procedure (Sender: TObject; Control: TControl; const State: TProgressBarState) of object;
  { Summary
    Type used in the OnUpdateProgressBar event. }
  TUpdateProgressBarEvent = procedure (Sender: TObject; Control: TControl; const Position: Integer; var CloseDialog: Boolean) of object;
  { Type of event to handle when the progress bar changes in doProgressBar is set in the DialogOptions property. }
  TProgressEvent = procedure (Sender: TObject; const Position: Integer) of object;

  { Type of event OnGetMoreFileName }
  TGetMoreFileNameEvent = procedure(Sender: TObject; var FileName: TJSString) of object;

  { Summary
    Type of event to handle when the timer is fired.
    Description
    This event is only fired when doTimer is set in DialogOptions.
    The event is triggered at the interval set in JSTimer.Interval property
    See Also: TJSTimer;DialogOptions;JSTimer }
  TTimerEvent = procedure (Sender: TObject; const TimeSince: Cardinal) of object;

  { Summary
    Specifies the format of the More text. }
  TMoreFormat = (
    mfText { The text is ANSI text. },
    mfRTF { The text is RTF format and therefore contain links. This type is only supported when MoreSource is either msStream or msFile. }
  );

  { Summary
    Used to determine the source of the More text. }
  TMoreSource = (
    msDefault { Using msDefault uses the text set in the Text property of the TExpando class.                                           },
    msStream { When using msStream, handle the OnMoreStream event. },
    msFile { When using msFile, handle the OnMoreFile event. }
  );

  { Summary
    Determines the values permitted when setting the Speed property for animation.
    Description
    Type used to restrict the value defined for the Speed property for Expando animation effects. }
  TJSSpeedRange = 2..50;
  { Summary
    Determines the values permitted when setting the Step property for animation.
    Description
    Type used to restrict the value defined for the Step property for Expando animation effects. }
  TJSStepRange = 1..10;

  { Summary
    Class used to hold the options for animating the dialog when it is either expanding or collapsing. }
  TJSAnimate = class(TPersistent)
  private
    FEnabled: Boolean;
    FStep: TJSStepRange;
    FSpeed: TJSSpeedRange;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create;
  published
    { Summary
      Determines whether the dialog animates while expanding or collapsing.
      Description
      Set the Enabled property to have the dialog animation the change in height when either showing or
      hiding additional content on the dialog.                                                          }
    property Enabled: Boolean read FEnabled write FEnabled default False;
    { Summary
      Determines the frequency of updating the dialog's height while animating.
      Description
      The amount of time between updating the dialog's height when collapsing or expanding. The longer the
      value the slower the animation will take.<p />
      <p />
      The elapsed time for the animation to complete also depends on the size of the expanded content.     }
    property Speed: TJSSpeedRange read FSpeed write FSpeed default 10;
    { Summary
      Determines the increment the dialog's height changes by when animating.
      Description
      The amount the dialog height changes by at the lapse of each <link JSDialog.TJSAnimate.Speed, Speed>
      interval.                                                                                            }
    property Step: TJSStepRange read FStep write FStep default 2;
  end;

  { Summary
    Class that describes the how the dialog will appear when it
    has been expanded or collapsed.
    Description
    Visible must be True for the Expando control to be displayed. }
  TJSExpando = class(TJSTextSection)
  private
    FFont: TFont;
    FLines: TJSStrings;
    FVisible: Boolean;
    FShowMore: Boolean;
    FShowText: TJSString;
    FHideText: TJSString;
    FShowInFooter: Boolean;
    FMoreHeight: Integer;
    FMoreFormat: TMoreFormat;
    FMoreScrollbars: TScrollStyle;
    FMoreSource: TMoreSource;
    FShowing: Boolean;
    FAnimate: TJSAnimate;
    procedure SetFont(const Value: TFont);
    procedure SetLines(const Value: TJSStrings);
    procedure SetVisible(const Value: Boolean);
    procedure SetHideText(const Value: TJSString);
    procedure SetShowText(const Value: TJSString);
    procedure SetShowInFooter(const Value: Boolean);
    procedure SetMoreHeight(const Value: Integer);
    procedure SetShowing(const Value: Boolean);
    function IsFontStored: Boolean;
    procedure LinesChangedHandler(Sender: TObject);
    procedure SetAnimate(const Value: TJSAnimate);
  public
    { Creates and initialises a TJSExpando instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Destroys the TJSExpando instance and frees its memory. }
    destructor Destroy; override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { Summary
      Contains the values appropriate to animation.
      Description
      The Animate property allows for enabling Animation effects while expanding or collapsing a dialog use
      the Expando control. For animation to be visible, the Expando.Visible property should be true as well
      as the Animate.Enabled property.                                                                      }
    property Animate: TJSAnimate read FAnimate write SetAnimate;
    { The text that is displayed when the dialog has been expanded. }
    property Lines: TJSStrings read FLines write SetLines;
    { Font to use when drawing the Expando control. }
    property Font: TFont read FFont write SetFont stored IsFontStored;
    { Summary
      Set Showing to True to have the dialog display expanded when
      first displayed.
      Description
      The dialog does not change the value of the Showing property
      even if the Expando section of the dialog has been selected.
      If you want to change the way a dialog initially displays,
      you should modified the Showing property value before
      executing the dialog.<p />
      <p />
      The default value for Showing is False.                      }
    property Showing: Boolean read FShowing write SetShowing default False;
    { Show the expanded text in the footer of the dialog. The
      default is to show the expanded text under the Content
      section of the dialog.                                  }
    property ShowInFooter: Boolean read FShowInFooter write SetShowInFooter default False;
    { The height of the expanded section when the section is the
      footer. ShowInFooter must be TRUE for MoreHeight to be used. }
    property MoreHeight: Integer read FMoreHeight write SetMoreHeight default 0;
    { The format of the expanded text. }
    property MoreFormat: TMoreFormat read FMoreFormat write FMoreFormat default mfText;
    { Summary
      Determines the scrollbar setting to used for the more format source
      Description
      The scrollbar setting to use when the MoreSource is set to RTF. }
    property MoreScrollbars: TScrollStyle read FMoreScrollbars write FMoreScrollbars default ssBoth;
    { Source of the expanded text. It is possible to set the
      expanded text source to be file, stream or the default. The
      default means the expanded text comes from the Lines
      property. There are events (OnGetFileName, OnGetFileStream)
      for the other text source types.                            }
    property MoreSource: TMoreSource read FMoreSource write FMoreSource default msDefault;
    { Determines whether the Expando control is displayed or not.
      Set Visible to TRUE for the control to be displayed.        }
    property Visible: Boolean read FVisible write SetVisible default False;
    { The Expando control text used when the dialog is current
      collapsed.                                               }
    property ShowText: TJSString read FShowText write SetShowText;
    { The text to display when the dialog has been expanded. }
    property HideText: TJSString read FHideText write SetHideText;
  end;

  { Type of event for OnHelpLinkClick. }
  THelpLinkClickEvent = procedure (Sender: TObject; var Handled: Boolean) of object;

  { Settings for how the Help Link is displayed in the dialog. To
    make the Help Link display in the dialog you must specific
    doHelpLinks in the DialogOptions.                             }
  TJSHelpLink = class(TJSDialogOwnedPersistent)
  private
    FHelpType: THelpType;
    FHelpKeyword: TJSString;
    FHelpContext: THelpContext;
    FText: TJSString;
    FFont: TFont;
    procedure SetText(const Value: TJSString);
    procedure SetFont(const Value: TFont);
    function IsFontStored: Boolean;
  public
    { Creates and initialises a TJSHelpLink instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Destroys the TJSHelpLink instance and frees its memory. }
    destructor Destroy; override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { Font to use when drawing the Help Link. }
    property Font: TFont read FFont write SetFont stored IsFontStored;
    { The Help Context Id used when the Help Link is activated. For
      the HelpContext to be used HelpType must be htContext.        }
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    { Determines which method of accessing the help is used. Set
      HelpType to htContext to use the HelpContext or htKeyword to
      use HelpKeyword.                                             }
    property HelpType: THelpType read FHelpType write FHelpType default htContext;
    { The keyword used when the Help Link is activated. For the
      HelpKeyword to be used HelpType must be htKeyword.        }
    property HelpKeyword: TJSString read FHelpKeyword write FHelpKeyword;
    { The Help Link text that is displayed on the dialog. }
    property Text: TJSString read FText write SetText;
  end;

  { Summary
    Specifies the alignment of the Header and Footer images. }
  TJSImageAlignment = (
    jsImageAlignLeft { Image is aligned to the left of the text. },
    jsImageAlignRight { Image is alignment to the right of the text. }
  );

  { Summary
    Base class for the TJSHeader and TJSFooter classes.
    Description
    Contains all of the shared properties required by both the header and footer sections of
    a dialog. }
  TJSBaseOptions = class(TJSDialogOwnedPersistent)
  private
    FVisible: Boolean;
    FText: TJSString;
    FGlyph: TPicture;
    FIcon: TTaskDialogIcon;
    FFont: TFont;
    FColor: TColor;
    FImageAlignment: TJSImageAlignment;
    procedure SetText(const Value: TJSString);
    procedure SetVisible(const Value: Boolean);
    procedure SetGlyph(const Value: TPicture);
    procedure SetIcon(const Value: TTaskDialogIcon);
    procedure SetFont(const Value: TFont);
    function IsFontStored: Boolean;
  protected
    { Summary
      Specifies whether the font has been changed from its original values.
      Description
      By default the fonts used by a dialog section is determined at runtime depending on which operating
      system the dialog is being displayed in.<p />
      <p />
      This method allows checking specific font sub properties to see if they have been altered, therefore
      altering the font from its default value.
      Returns
      Returns True if the font has been modified from its default values.                                 }
    function FontModified: Boolean; virtual;
  public
    { Creates and initialises a TJSBaseOptions instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Destroys the TJSBaseOptions instance and frees its memory. }
    destructor Destroy; override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { Background color of the Header section.}
    property Color: TColor read FColor write FColor;
    { Text to display }
    property Text: TJSString read FText write SetText;
    { Custom image to display to the left of the section }
    property Glyph: TPicture read FGlyph write SetGlyph;
    { Font used to display the section text }
    property Font: TFont read FFont write SetFont stored IsFontStored;
    { Icon to display }
    property Icon: TTaskDialogIcon read FIcon write SetIcon default tdiNone;
    { Visiblity of the section }
    property Visible: Boolean read FVisible write SetVisible default False;
    { Summary
      Determines the alignment of the associated image.
      Description
      The associated image can either be aligned to the left of the text or to the right of any text.

      The default alignment is to the left of the text.
      Remarks
      Handle the OnDialogClick event to determine where on the dialog the user has clicked. }
    property ImageAlignment: TJSImageAlignment read FImageAlignment write FImageAlignment default jsImageAlignLeft;
  end;

  { Overview: Size of icon to draw in the Header of the dialog }
  TJSIconSize = (isSmall { Icon drawn is 16 x 16 },
                isMedium { Icon drawn is 24 x 24 },
                isLarge  { Icon drawn is 32 x 32 });

  { Summary
    Class used to represent the information that needs to appear in the Header section of the dialog. }
  TJSHeader = class(TJSBaseOptions)
  private
    FIconSize: TJSIconSize;
    FGradient: TJSGradient;
    procedure SetGradient(const Value: TJSGradient);
  protected
    function FontModified: Boolean; override;
  public
    { Creates and initialises a TJSHeader instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Destroys the TJSHeader instance and frees its memory. }
    destructor Destroy; override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { The background color of the header section. }
    property Color default clWindow;
    { The gradient properties for the header section. }
    property Gradient: TJSGradient read FGradient write SetGradient;
    { Size of the Icon to use in the header section. }
    property IconSize: TJSIconSize read FIconSize write FIconSize default isLarge;
  end;

  { Summary
    Class used to represent the information that needs to appear on the footer of the dialog. }
  TJSFooter = class(TJSBaseOptions)
  public
    { Creates and initialises a TJSFooter instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
  published
    { Summary
      Defines the color of the border.
      Description
      The default color of the footer is clBtnFace, which is the same as the default ButtonBar color. }
    property Color default clBtnFace;
  end;

  { Summary
    Class used to represent the appearance of a border around the contents of the dialog.
    Description
    By default the Border is not visible. The color and width of the border is customisable. }
  TJSBorder = class(TJSDialogOwnedPersistent)
  private
    FWidth: Integer;
    FColor: TColor;
    FVisible: Boolean;
  public
    { Creates and initialises a TJSBorder instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { Summary
      Sets the color of the border.
      Description
      Use the Color property to change the color of the border around the dialog.
      The border is not visible by default, change the Visible property to True to display the border. 
      Remarks
      The default values is clGray. }
    property Color: TColor read FColor write FColor default clGray;
    { Summary
      Sets the width of the border to be displayed.
      Description
      Modify the Width property to make the border wider or narrower. Using a border on a dialog is
      only advisable when the dialog does not have a regular border.
      Remarks
      The default value is 1. }
    property Width: Integer read FWidth write FWidth default 1;
    { Summary
      Determines whether the border is visible or not.
      Description
      Modify the Visible property to show or hide the border.

      <b>NOTE:<b> This property does not control the normal border for a window. This is done by with the
      BorderStyle property of the TJSDialog component.
      Remarks
      The default value is False. }
    property Visible: Boolean read FVisible write FVisible default False;
  end;

  { Class that controls the appearance of the Instruction section of the dialog. }
  TJSInstruction = class(TJSTextSection)
  private
    FFont: TFont;
    FText: WideString;
    FShowAtTop: Boolean;
    FShowGlyph: Boolean;
    FGlyph: TPicture;
    FIcon: TTaskDialogIcon;
    FColor: TColor;
    procedure SetFont(const Value: TFont);
    procedure SetShowAtTop(const Value: Boolean);
    procedure SetText(const Value: WideString);
    procedure SetGlyph(const Value: TPicture);
    procedure SetShowGlyph(const Value: Boolean);
    procedure SetIcon(const Value: TTaskDialogIcon);
    function IsFontStored: Boolean;
    procedure SetColor(const Value: TColor);
  public
    { Creates and initializes a TJSInstruction instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Destroys the TJSInstruction instance and frees its memory. }
    destructor Destroy; override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
    { Summary
      Specifies the height of the glyph to be drawn in the instruction section of a dialog. }
    function GlyphHeight: Integer;
    { Summary
      Specifies the width of the glyph to be drawn in the instruction section of a dialog. }
    function GlyphWidth: Integer;
    { Summary
      Specifies if a custom glyph is to be drawn in the instruction section of a dialog.
      Description
      The instruction section has a custom glyph if either the ShowGlyph property is true and the
      Glyph property contains valid graphic content or the Icon property is tdiCustom and the Glyph property
      contains valid graphic content.
      Returns
      Returns True when the Icon value is tdiCustom and the Glyph property has valid graphic content. }
    function HasCustomGlyph: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    { Summary
      Specifies if a known glyph is to be drawn in the instruction section of a dialog.
      Description
      A known glyph is a valid when the Icon value is not either tdiNone and tdiCustom.
      Returns
      Returns True if the Icon value is not one of tdiNone and tdiCustom. }
    function HasGlyph: Boolean;
    { Summary
      Specifies if the instruction has a glyph that is required to be painted.
      Description
      Internally this method calls the HasCustomGlyph and HasGlyph methods. If either of those methods return
      True then this method returns true.

      This method tells you if the instruction section has a glyph to be painted.
      The GlyphHeight and GlyphWidth methods hold the dimensions of the glyph to be painted.
      Returns
      Method returns True when either HasCustomGlyph or HasGlyph returns true. }
    function GlyphAvailable: Boolean;
  published
    { Background color of the Instruction section.}
    property Color: TColor read FColor write SetColor default clNone;
    { Font used to draw the Instruction for the dialog. }
    property Font: TFont read FFont write SetFont stored IsFontStored;
    { The text of the instruction. It is recommended that this be in the form of a question. }
    property Text: WideString read FText write SetText;
    { Display the at the left most possible margin.

    This means that if the MainIcon property is set then the instruction will appear on top of the icon. }
    property ShowAtTop: Boolean read FShowAtTop write SetShowAtTop default False;
    { The instruction can contain display an image. }
    property Glyph: TPicture read FGlyph write SetGlyph;
    { Set the icon style to display one of the predefined images. }
    property Icon: TTaskDialogIcon read FIcon write SetIcon default tdiNone;
    { Set ShowGlyph to true to display the image specified in the Glyph property. }
    property ShowGlyph: Boolean read FShowGlyph write SetShowGlyph default False;
  end;

  { Options for controlling the appearance of the button section
    that appears at the base of the dialog. }
  TJSButtonBarOptions = class(TJSDialogOwnedPersistent)
  private
    FButtons: TCommonButtons;
    FVisible: Boolean;
    FColor: TColor;
    FCancel: TCommonButton;
    FDefault: TCommonButton;
    FShowDivider: Boolean;
    FUseCancel: Boolean;
    FUseDefault: Boolean;
    procedure SetButtons(const Value: TCommonButtons);
    procedure SetVisible(const Value: Boolean);
    procedure SetColor(const Value: TColor);
    procedure SetCancel(const Value: TCommonButton);
    procedure SetDefault(const Value: TCommonButton);
    function IsColorStored: Boolean;
  public
    { Creates and initializes a TJSButtonBarOptions instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
    { Summary
      Use this method to have the dialog determine the best values for the Default and Cancel properties.
      Description
      This method determines what are the best values for the Default and Cancel properties given the current value
      of the Buttons property.

      The Default value is determined in the following order:
          cbYes
          cbOK
          cbRetry
          cbClose
          cbAll
          cbYesToAll
          cbHelp

      The Cancel value is determined in the following order:
          cbNo
          cbCancel
          cbClose
          cbAbort
          cbIgnore
          cbHelp

      Remarks
      This method should be called everytime the Buttons property is changed. }
    procedure DetermineDefaults;
  published
    { Set of Common Buttons to display. }
    property Buttons: TCommonButtons read FButtons write SetButtons default [cbOK, cbCancel];
    { Backgound color of the Button Bar section. }
    property Color: TColor read FColor write SetColor stored IsColorStored default clBtnFace;
    { Set to False to hide the Button Bar. Default value is True. }
    property Visible: Boolean read FVisible write SetVisible default True;
    { Set the Default common button for the dialog. }
    property Default: TCommonButton read FDefault write SetDefault default cbOK;
    { Set the Cancel common button for the dialog. }
    property Cancel: TCommonButton read FCancel write SetCancel default cbCancel;
    { Displays the top line of the Button Bar. You might want to hide the divider to 
      use the dialog in legacy mode. }
    property ShowDivider: Boolean read FShowDivider write FShowDivider default True;
    { Set this property to True if you want to use the values set in the Default property.

      You may want to set this property to False if you have a Command Link Button that you
      want to be the default button for the dialog. }
    property UseDefault: Boolean read FUseDefault write FUseDefault default True;
    { Set this property to True if you want to use the values set in the Cancel property. 

      You may want to set this property to False if you have a Command Link Button that you
      want to be the default button for the dialog. }
    property UseCancel: Boolean read FUseCancel write FUseCancel default True;
  end;

  { Class that holds details about the verification control on the dialog. }
  TJSVerification = class(TJSDialogOwnedPersistent)
  private
    FVisible: Boolean;
    FText: TJSString;
    FInitialState: Boolean;
    procedure SetText(const Value: TJSString);
    procedure SetVisible(const Value: Boolean);
  public
    { Creates and initializes a TJSVerification instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { Summary
      Determines whether the verification checkbox is checked when
      the dialog first shows.
      Description
      Set InitialState to True when you want the verification
      checkbox to be checked when the dialog is initially shown.<p />
      <p />
      When the execute method is called for the dialog, the
      verifications checkbox value is always reset to the value of
      the InitialState property. Even if the user had previously
      toggled the verification checkbox.                              }
    property InitialState: Boolean read FInitialState write FInitialState default False;
    { Text to display next to the verification check box. }
    property Text: TJSString read FText write SetText;
    { Set to True to display the verification check box. }
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

  { Type used in the OnGetButtonClass event when using a custom
    button component.                                           }
  TButtonClass = class of TControl;

  { Type of event OnGetControlClass. }
  TGetControlClassEvent = procedure (Sender: TObject; ControlType: TControlType; var ControlClass: TControlClass) of object;
  { Type of event OnInitControl event }
  TInitControlEvent = procedure (Sender: TObject; ControlType: TControlType; Control: TControl; ControlItem: TCollectionItem; var Handled: Boolean) of object;

  { Type of event for OnGetMoreStream. }
  TGetMoreStreamEvent = procedure (Sender: TObject; var Stream: TMemoryStream) of object;
  { Control Click event type. }
  TControlClickEvent = procedure (Sender: TObject; ControlType: TControlType; Control: TControl; const Value: Integer; var Handled: Boolean) of object;

  { Type of event OnGetVerificationResult }
  TGetVerificationResult = procedure (Sender: TObject; Control: TControl; var VerificationResult: Boolean) of object;

  { Type of event OnGetRadioButtonChecked. }
  TGetRadioButtonChecked = procedure (Sender: TObject; Control: TControl; var Checked: Boolean; var Handled: Boolean) of object;

  { Type of event triggered when the dialog is closed }
  TDialogCloseEvent = procedure (Sender: TJSCustomDialog) of object;

  { Summary
    Type of event triggered when the dialog area is click on
    Description
    This event is triggered when an area on the dialog is click on. }
  TDialogClickEvent = procedure (Sender: TObject; HitTest: TJSDialogHitTest) of object;

  { Summary
    Type of event triggered when the cbHelp common button is clicked
    Description
    You do not have to handle this event if you have a Help button on the button bar. If you do not
    handle this event, Application.HelpContext is called with the HelpContext value assigned to the TJSDialog
    HelpContext property.
    To prevent the default behaviour set handled to True in your event handler }
  THelpButtonClickEvent = procedure (Sender: TObject; var Handled: Boolean) of object;

  { Summary
    Type of event triggered when a dialog is displayed to play a specific sound.
    Description
    Allows the user to return the name of the sound to be played as well as the flags required to play the sound. If
    you choose to not handle this event and the PlaySounds property is true, the system default sound for the MainIcon
    value will display.
    Remarks
    If the MainIcon value is tdiCustom, then no sound will play.
    If the MainIcon value is tdiShield and the operating system is not Vista or higher, then no sound will play when
    the dialog is displayed. }
  TGetCustomSoundEvent = procedure (Sender: TObject; var Sound: string; var Flags: Cardinal; var Handled: Boolean) of object;

  { Summary
    Type used in the OnVerificationClick event. }
  TVerificationClickEvent = procedure (Sender: TObject; const Checked: Boolean) of object;

  { Summary
    Options to determine the visual display of the dialog. }
  TDialogOption = (
    doShowHelpLink { Display a clickable label that links to additional help information about the dialog.

      Customise the label by using the HelpLink property.     },
    doRadioButtons { Display radio buttons for the items specified in the RadioButtons property. },
    doCommandLinks { Display any custom buttons as Command Link Buttons but do not display any Glyphs with the buttons. },
    doCommandLinksNoIcon { Display any custom buttons as Command Link Buttons but do not display any Glyphs with the buttons.
    If the Picture property is set, the picture will still be displayed. },
    doProgressBar { Display a progress bar on the dialog. },
    doProgressBarMarquee { Display a progress bar on the dialog that displays as indeterminate. },
    doTimer { This feature is currently not implemented. },
    doTopMost { Set this option to make the dialog display stay on top. },
    doModal { Display the dialog as modal. This is the default setting for DialogOptions. }
  );

  { Summary
    Set of TDialogOption
    Description
    Set that controls which sections and features the dialog will have. }
  TDialogOptions = set of TDialogOption;

  { Summary
    Applicable dialog styles. }
  TJSDialogStyle = (
    dsDialog { Display the dialog as a modal or non-modal dialog. },
    dsSheet { Display the dialog as a drop down sheet to either the active form or desktop. }
  );

  { Type used to hold the Dialog results values. }
  TJSDialogResult = record
    { The ModalResult value of the Button (CommonButton or
      CustomButton) that was selected.                     }
    ModalResult: TModalResult;
    { Whether the Verification check box was checked or not.
      Returns True or False.                                }
    VerificationResult: Boolean;
    { The value of the Radio Button that was checked. Radio Button
      results generally start at 200 and increase by 1, but the
      value can be changed as desired.                             }
    RadioResult: Integer;
    { The value of the Custom Button that was checked. Custom
      Button results generally start at 100 and increase by 1, but
      the value can be changed as desired.                         }
    CustomButtonResult: Integer;
  end;

  { Class that holds the dialog position values for when the
    Position property of the TJSDialog component is dpDesigned. }
  TJSLocation = class(TPersistent)
  private
    FTop: Integer;
    FLeft: Integer;
  public
    { Creates and initializes a TJSLocation instance. }
    constructor Create;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { Specifies the Left position of the created dialog. }
    property Left: Integer read FLeft write FLeft default -1;
    { Specifies the Top position of the created dialog. }
    property Top: Integer read FTop write FTop default -1;
  end;

  { Summary
    Class that holds timer specific options.
    Description
    This class holds options that can be customized when a dialog
    has the doTimer option set in the DialogOptions property.     }
  TJSTimer = class(TJSDialogOwnedPersistent)
  private
    FInterval: Cardinal;
  public
    { Creates and initializes a TJSTimer instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { The delay in which the timer if fired. Amount specified is in milliseconds.
      1000 milliseconds = 1 second }
    property Interval: Cardinal read FInterval write FInterval default 1000;
  end;

  { Class that helps specify the appearance of radio buttons
    when they are displayed on a dialog. }
  TJSRadioButton = class(TJSDialogOwnedPersistent)
  private
    FShowBorder: Boolean;
    FCaption: WideString;
    FColumns: Integer;
  public
    { Creates and initializes a TJSRadioButton instance. }
    constructor Create(ADialog: TJSCustomDialog); override;
    { Copies the contents of another, similar object. }
    procedure Assign(Source: TPersistent); override;
  published
    { Number of columns to use when displaying the radio buttons.
      Note: Only valid if ShowBorder is True
      See Also: TJSRadioButton.ShowBorder }
    property Columns: Integer read FColumns write FColumns default 1;
    { Set to True to show a border around the radio buttons. }
    property ShowBorder: Boolean read FShowBorder write FShowBorder default False;
    { Displays a caption in the border when ShowBorder is True.
      Note: Only valid if ShowBorder is True
      See Also: TJSRadioButton.ShowBorder }
    property Caption: WideString read FCaption write FCaption;
  end;

  { Summary
    Defines where a TJSDialogSheet displays. }
  TJSSheetLocation = (slActiveForm, { Summary
    The sheet is displayed at the top of the active form in the application.
    Description
    Add a description here...                                                }
   slDesktop { Summary
     The sheet is displayed at the top of the active monitor in the application.
     Description
     If the active monitor cannot be determined successfully, the sheet will display on the systems
     default monitor.                                                                               }
   );

  { Summary
    Specifies options specific to the sheet DialogStyle.
    Description
    When the DialogStyle property is set to dsSheet, these options are used to determine the behaviour of
    particular aspects of the TJSDialogSheet implementation.                                              }
  TJSSheetOptions = class(TJSDialogOwnedPersistent)
  private
    FInterval: Cardinal;
    FStyle: TJSSheetLocation;
    procedure SetInterval(const Value: Cardinal);
    procedure SetStyle(const Value: TJSSheetLocation);
  public
    constructor Create(ADialog: TJSCustomDialog); override;
    procedure Assign(Source: TPersistent); override;
  published
    { Summary
      Determines where the sheet is to be displayed
      Description
      Allows you to specify if the sheet is to be displayed on the applications active form or
      at the top of the screen where the applications currently active form is displayed.
      Remarks
      The default value for this property is slActiveForm   }
    property Location: TJSSheetLocation read FStyle write SetStyle default slActiveForm;
    { Summary
      Determines the elapsed time for the sheet to slide fully into view.
      Description
      Determines the elapsed time for the sheet to slide fully into view.
      Remarks
      The default value for this property is 500ms (half of one second) }
    property Interval: Cardinal read FInterval write SetInterval default 500;
  end;

  { Summary
    Type for determining whether the dialog is currently being previewed. }
  TJSDialogState = (dsNormal, { The dialog is not being displayed as a preview. }
   dsPreview { The dialog is currently being previewed. }
  );
  { Summary
    Set type that holds the current internal dialog states.
    Description
    Type that defines the internal state of the current dialog. }
  TJSDialogStates = set of TJSDialogState;

  { Summary
    The base class for the form used to display the dialogs. }
  TJSCustomTaskDialogForm = class({$IFDEF TNTUnicode}TTntForm{$ELSE}TForm{$ENDIF})
  end;

  { Summary
    TJSCustomDialog is the base class for objects that represent dialogs.
    Description
    The TJSCustomDialog component is the base class for dialogs. Dialogs consist of many different
    sections that contain text, graphics or controls.<p />
    <p />
    TJSCustomDialog is intended only as a base class. To add a dialog to a form, use a TJSCustomDialog
    descendant such as TJSDialog.<p />
    <p />
    Other TJSCustomDialog descendants included in JSDialog Pack are:
    <table>
    Classname                 \Description
    ------------------------  ---------------------------------------------------------------------------
    TJSDialog                 Main TJSCustomDialog descendant that exposes the main functionality.
    TJSDialogCheck            Replaces the Radio Button option with Check Boxes.
    TJSEditDialog (requires   Allows for including specific controls on the dialog. Controls can also be
     TJSEditDialog purchase)   customised.
    </table>                                                                                              }
  TJSCustomDialog = class(TComponent)
  private
    FDialogState: TJSDialogStates;
    FContent: TJSStrings;
    FGlyph: TPicture;
    FLeftMargin: Integer;
    FRightMargin: Integer;
    FVertMargin: Integer; { Space from top or bottom to a set of controls }
    FVertSpacing: Integer; { Space between like controls }
    FHorzSpacing: Integer;
    FButtonSpacing: Integer;
    FExpando: TJSExpando;
    FRadioButtons: TJSRadioButtons;
    FCustomButtons: TJSCustomButtons;
    FCreatedRadioButtons: TObjectList;
    FRadioGroup: TControl;
    FCreatedCustomButtons: TObjectList;
    FCreatedButtonBarButtons: TObjectList;
    FButtonBar: TJSButtonBarOptions;
    FButtonBarHeight: Integer;
    FInstruction: TJSInstruction;
    FVerification: TJSVerification;
    FText: TJSString;
    FVerificationCheckBox: TControl;
    FShowMoreButton: TJSMoreLabel;
    FRadioResult: Integer;
    FVerificationResult: Boolean;
    FFooter: TJSFooter;
    FHeader: TJSHeader;
    FMoreRichEdit: TJSRichEdit;
    FOnGetMoreFileName: TGetMoreFileNameEvent;
    FModalResult: TModalResult;
    FFooterLabel: TJSCaptionControl;
    FMainIcon: TTaskDialogIcon;
    FOnInitControl: TInitControlEvent;
    FOnGetControlClass: TGetControlClassEvent;
    FOnGetMoreStream: TGetMoreStreamEvent;
    FDialogOptions: TDialogOptions;
    FDialogStyle: TJSDialogStyle;
    FHelpLinkLabel: TJSCaptionControl;
    FOnHelpLinkClick: THelpLinkClickEvent;
    FHelpLink: TJSHelpLink;
    FOnControlClick: TControlClickEvent;
    FCustomButtonResult: Integer;
    FFocusedControl: TWinControl;
    FEmulateMessageDlg: Boolean;
    FOldFontChanged: TNotifyEvent;
    FProgressBar: TControl;
    FCalcAutosizing: Boolean;
    FCalcLayout: Boolean;
    FProgress: TJSProgress;
    FBorder: TJSBorder;
    FAssigning: Boolean;
    FOnDialogExpand: TNotifyEvent;
    FOnDialogCollapse: TNotifyEvent;
    FOnGetVerificationResult: TGetVerificationResult;
    FOnUpdateProgressBarState: TUpdateProgressBarStateEvent;
    FOnUpdateProgressBar: TUpdateProgressBarEvent;
    FShowMoreButtonWidth: Integer;
    FExpanding: Boolean;
    FCollapsing: Boolean;
    FColor: TColor;
    FFont: TFont;
    FTitle: TJSString;
    FPosition: TDialogPosition;
    FLocation: TJSLocation;
    FHelpContext: Integer;
    FBorderStyle: TFormBorderStyle;
    FIcon: TIcon;
    FUseDefaultFonts: Boolean;
    FHelpType: THelpType;
    FHelpKeyword: TJSString;
    FOnDialogClose: TDialogCloseEvent;
    FOnDialogClick: TDialogClickEvent;
    FDialogResult: TJSDialogResult;
    FInitialisingFonts: Boolean;
    FWidth: Integer;
    FOnCleanUpDialog: TNotifyEvent;
    FAllowCancel: Boolean;
    FAllowMinimize: Boolean;
    FFirstButtonLeftPos: Integer; // the left position of the FIRST button bar button
    FWidthOfLastCommonButton: Integer; // the width of the last common button placed in the button bar
    FOnDialogConstructed: TNotifyEvent;
    FOnCreated: TNotifyEvent;
    FOnDestroyed: TNotifyEvent;
    FActiveControlType: TControlType;
    FOnProgress: TProgressEvent;
    FInvalidateOnPosition: Boolean; // when PositionControls is called a full Invalidate will take place when True
    FDefaultButton: TControl;
    FUseOldStyleSetting: Boolean;
    FAcceleratorState: Longint;
    FTimer: TJSTimer;
    FOnTimer: TTimerEvent;
    FOnGetRadioButtonChecked: TGetRadioButtonChecked;
    FOnHelpButtonClick: THelpButtonClickEvent;
    FBackground: TJSBackground;
    FRadioButton: TJSRadioButton;
    FClientWidth: Integer;
    FClientHeight: Integer;
    FOnKeyPress: TKeyEvent;
    FBiDiMode: TBiDiMode;
    FShowHint: Boolean;
    FOnVerificationClick: TVerificationClickEvent;
    FShowHelpButton: Boolean;
    FInstructionLabel: TJSCaptionControl;
    FContentLabel: TJSCaptionControl;
    FMoreLinesLabel: TJSCaptionControl;
    FContentMaxLines: TControl;
    FOnGetCustomSound: TGetCustomSoundEvent;
    FPlaySounds: Boolean;
    FMaxLines: Integer;
    FResetMaxLines: Boolean;
    FOnDialogShow: TNotifyEvent;
    FDefaultMonitor: TDefaultMonitor;
    FExpandingHeight: Integer;
    FExpandedHeight: Integer;
    FExpandedAmount: Integer;
    FExpandedLeftOver: Integer;
    FButton: TJSButtonOptions;
    FSheet: TJSSheetOptions;
    FTaskBarProgressImpl: TJSTaskBarProgressImpl;
    FPreviousProgressPosition: Integer;
    procedure SetLines(const Value: TJSStrings);
    procedure SetGlyph(const Value: TPicture);
    procedure SetExpando(const Value: TJSExpando);
    procedure ExpandoChangedHandler(Sender: TObject);
    procedure InstructionChangeHandler(Sender: TObject);
    procedure ContentChangeHandler(Sender: TObject);
    procedure VerificationChangeHandler(Sender: TObject);
    procedure SetRadioButtons(const Value: TJSRadioButtons);
    procedure SetCustomButtons(const Value: TJSCustomButtons);
    procedure SetButtonBar(const Value: TJSButtonBarOptions);
    procedure SetInstruction(const Value: TJSInstruction);
    procedure SetText(const Value: TJSString);
    procedure SetVerification(const Value: TJSVerification);
    function GetRadioResult: Integer;
    function GetVerificationResult: Boolean;
    procedure SetRadioResult(const Value: Integer);
    procedure SetVerificationResult(const Value: Boolean);
    procedure ButtonClickHandler(Sender: TObject);
    procedure HelpButtonClickHandler(Sender: TObject);
    procedure RadioButtonClickHandler(Sender: TObject);
    procedure ShowMoreButtonCollapsedHandler(Sender: TObject);
    procedure ShowMoreButtonExpandedHandler(Sender: TObject);
    procedure FooterChange(Sender: TObject);
    procedure SetFooter(const Value: TJSFooter);
    procedure SetHeader(const Value: TJSHeader);
    procedure SetForm(const Value: TJSCustomTaskDialogForm);
    function GetModalResult: TModalResult;
    procedure SetModalResult(const Value: TModalResult);
    procedure SetMainIcon(const Value: TTaskDialogIcon);
    procedure SetDialogOptions(const Value: TDialogOptions);
    procedure SetDialogStyle(const Value: TJSDialogStyle);
    procedure HelpLinkLabelClickHandler(Sender: TObject);
    procedure SetHelpLink(const Value: TJSHelpLink);
    procedure SetCustomButtonResult(const Value: Integer);
    function ShowCommandLinks: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    function ShowProgressBar: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    function ShowProgressBarOnTaskBar: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    function ShowRadioButtons: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    procedure NewFontChanged(Sender: TObject);
    procedure SetProgress(const Value: TJSProgress);
    procedure SetBorder(const Value: TJSBorder);
    procedure CheckBoxClickHandler(Sender: TObject);
    function GetShowMoreButtonWidth: Integer;
    function IsCustomButtonsStored: Boolean;
    function IsRadioButtonsStored: Boolean;
    function Canvas: TCanvas; {$IFDEF INLINE}inline;{$ENDIF}
    procedure SetFont(const Value: TFont);
    procedure SetIcon(const Value: TIcon);
    procedure SetUseDefaultFonts(const Value: Boolean);
    procedure DialogCloseHandler(Sender: TObject; var Action: TCloseAction);
    procedure DialogCloseQueryHandler(Sender: TObject; var CanClose: Boolean);
    procedure DialogDestroyHandler(Sender: TObject);
    procedure DialogShowHandler(Sender: TObject);
    procedure DialogKeyUpHandler(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DialogClientClickHandler(Sender: TObject; const APt: TPoint);
    function IsExpanded: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    function IsDialogAvailable: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    procedure SetColor(const Value: TColor);
    function IsFontStored: Boolean;
    function GetIconHeightFromIconSize(const aIconSize: TJSIconSize): Integer; {$IFDEF INLINE}inline;{$ENDIF}
    procedure SetLocation(const Value: TJSLocation);
    procedure SetWidth(const Value: Integer);
    procedure HeaderFontChange(Sender: TObject);
    procedure ProgressChangeHandler(Sender: TObject);
    procedure TimerChangeHandler(Sender: TObject);
    procedure SetActiveControlType(const Value: TControlType);
    function CreateGraphic(const AIcon: TTaskDialogIcon; const ASize: TJSIconSize): TGraphic;
    procedure SetTimer(const Value: TJSTimer);
    procedure GlyphChangeHandler(Sender: TObject);
    procedure SetRadioButton(const Value: TJSRadioButton);
    function HasElevationButton: Boolean;
    procedure SetShowHint(const Value: Boolean);
    procedure SetTitle(const Value: TJSString);
    procedure SetPlaySounds(const Value: Boolean);
    {$IFDEF JSDEBUG}
    procedure DEBUG_ActiveControlChangeHandler(Sender: TObject);
    {$ENDIF JSDEBUG}
    function StripFormatting(const AStr: string): string;
    procedure LoadStringIntoRichEdit(const AString: TJSString);
    function RetrievePlainTextFromRichEdit: TJSString;
    function GetHitTest(const APt: TPoint): TJSDialogHitTest;
    procedure FooterClickHandler(Sender: TObject);
    procedure ContentClickHandler(Sender: TObject);
    procedure InstructionClickHandler(Sender: TObject);
    procedure MoreLinesClickHandler(Sender: TObject);
    function IsColorStored: Boolean;
    procedure SetButton(const Value: TJSButtonOptions);
    procedure SetSheet(const Value: TJSSheetOptions);
  protected
    { Summary
      Reference to the created form for the dialog.
      Description
      FForm is available so descendant dialogs have direct access to the created form. }
    FForm: TJSCustomTaskDialogForm;
    { Summary
      Specifies if a button on the dialog has been clicked. }
    FButtonClicked: Boolean;
    { Summary
      Specifies if automatic snap to default button is ignored. }
    FIgnoreSnapTo: Boolean;
    { Summary
      Determines the height of the button bar section of a dialog.
      Description
      A descendant dialog might want to override the return value to make the button bar section of a dialog
      taller than what it is by default.
      Returns
      The height of the button bar section.  }
    function AdjustButtonBarHeight: Integer; virtual;
    { Summary
      Method that creates the common button specified by the ACommonBtn parameter.
      Description
      Method that creates the common button specified by the ACommonBtn parameter. }
    procedure CreateCommonButton(ACommonBtn: TCommonButton; ADialogUnits: TPoint; AButtonHeight: Integer);
    { Summary
      Method called when a button on a dialog has been clicked. }
    procedure DoButtonClick(Sender: TObject); virtual;
    { Summary
      Method called when a Help button on a dialog has been clicked.
      Description
      For a button to be determined a Help button, its Common Button value must be cbHelp. }
    procedure DoHelpButtonClick(Sender: TObject); virtual;
    { Summary
      Method that triggers the OnControlClick event. }
    procedure DoControlClick(Sender: TObject; ControlType: TControlType; const Value: Integer; var Handled: Boolean); virtual;
    { Summary
      Default event handler for the OnCloseQuery event for the dialog.
      Description
      Override this method to perform additional handling in the OnCloseQuery event to provide additional functionality
      such as dialog validation.
      Remarks
      The TJSEditDialog, TJSPasswordDialog and TJSChangePasswordDialog components override this event to perform
      validation on the dialogs input. }
    procedure DoDialogCloseQuery(Sender: TObject; var CanClose: Boolean); virtual;
    { Summary
      Method that triggers the OnGetCustomSound event. }
    procedure DoGetCustomSound(var ASound: string; var AFlags: Cardinal; var AHandled: Boolean); virtual;
    { Summary
      Method that triggers the OnKeyPress event. }
    procedure DoKeyPressHandler(var Key: Word; Shift: TShiftState); virtual;
    { Summary
      Method that returns the state of the Verification check box on the dialog.
      Returns
      DoGetVerificationResult returns True when the Verification check box is checked. }
    function DoGetVerificationResult: Boolean; virtual;
    { Summary
      Method that returns the bounding rect for a particular section of the dialog. }
    function GetRect(AStage: TPaintStage): TRect;
    { Summary
      Calculates the height required to paint the instruction within the instruction section.
      Description
      Performs the calculation required to paint the dialogs instruction text with in the instruction section.
      If True, the IncludeGlyphHeight parameter makes sure that the result is larger than the height of any
      glyph that will also be painted within the instruction section of a dialog. }
    function GetInstructionHeight(const AIncludeGlyphHeight: Boolean): Integer;
    { Summary
      Calculates the minimum width required to paint the instruction section.
      Description
      Performs the calculations needed to make sure that the instruction section, including caption and optional
      glyph fit within the allowed dialog width.
      Remarks
      The allowed dialog width is different if a dialog has visible Command Link Buttons. }
    function GetInstructionWidth: Integer;
    { Summary
      Calculates the minimum width required to paint the content section.
      Description
      Performs the calculations needed to make sure that the content section, including caption and optional
      glyph fit within the allowed dialog width.
      Remarks
      The allowed dialog width is different if a dialog has visible either Command Link Buttons or is being emulated. }
    function GetContentWidth: Integer;
    { Summary
      Method that returns the required height for the footer section of a dialog.
      Returns
      The required footer section height. }
    function GetFooterHeight: Integer;
    { Summary
      Method that returns the width of the image to be displayed in the footer of the dialog.
      Description
      By default the width of the footer image is 16 pixels (at 96dpi). Unless a custom image is used. }
    function GetFooterImageWidth: Integer;
    { Summary
      Method that returns the width of the image to be displayed in the header of the dialog.
      Description
      By default the width of the header image is 32 pixels (at 96dpi). Unless a custom image is used. }
    function GetHeaderImageWidth: Integer;
    { Summary
      Method that returns the required height for the expanded footer section of a dialog.
      Returns
      The required expanded footer section height. }
    function GetMoreFooterHeight: Integer;
    { Summary
      Method that paints the glyph and background associated with the Instruction section. }
    procedure PaintMainInstruction(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Method that paints additional text within the content section of the dialog. }
    procedure PaintMoreLines(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Method that paints the glyph associated with the image.
      Description
      The glyph can be either an inbuilt one as determined by the MainIcon value, or it the MainIcon value
      is tdiCustom then the user defined glyph is painted from the Glyph property. }
    procedure PaintGlyph(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Method that paints the header section of the dialog. }
    procedure PaintHeader(ACanvas: TCanvas; ARect: TRect); virtual;
    procedure PaintMoreFooter(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Method that paints the Button Bar section of the dialog. }
    procedure PaintButtonBar(ACanvas: TCanvas; ARect: TRect); virtual;
    { Summary
      Method that paints the footer section of the dialog. }
    procedure PaintFooter(ACanvas: TCanvas); virtual;
    { Summary
      Method that paints the footer separator of a dialog that has a visible footer section. }
    procedure PaintFooterSeparator(ACanvas: TCanvas; const ARect: TRect); virtual;
    { Summary
      Method that calls all of the relevant section paint methods to paint the dialog. }
    procedure Paint;

    { Summary
      Method that allows descendant classes to override the minimum height check.
      Description
      This method is overridden in TJSCustomDialog since the minimum height constraints do not apply to edit dialogs.
      The minimum height for a dialog is stored in the MIN_DIALOG_HEIGHT constant. }
    function CheckMinimumHeight: Boolean; virtual;
    { Summary
      Calculates the minimum width required by the dialog when certain sections are active for a dialog.
      Description
      Sets the minimum width for the dialog based on what settings have been selected. It is only called
      when CommandLinks are visible in the dialog. }
    function CalculateWidth: Integer; virtual;
    { Summary
      Initialises the margin values used to control the dialogs layout. }
    procedure InitialiseMargins; virtual;
    { Summary
      Calculates the size of the dialog. }
    procedure CalculateAutoSize(out AHeight, AWidth: Integer; const AApply: Boolean = True); virtual;
    { Summary
      Method that allows descendant classes to change the calculated height of a dialog. }
    function HeightAdjustment: Integer; virtual;
    { Summary
      Method that allows descendant classes to change the calculated width of a dialog.
      Description
      This value is the required width of the dialog. If there is a difference between the calculated dialog width and
      the value returned from the WidthAdjustment method, the difference is added to the calculated dialog width. }
    function WidthAdjustment: Integer; virtual;
    { Summary
      Method that calls all section control creator methods to create the controls used to display the dialog. }
    procedure CreateControls; virtual;
    { Summary
      Method that recreates temporary controls as used by the dialog. }
    procedure RecreateControls; virtual;
    { Summary
      Method that reinitialises specific control types. }
    procedure ReinitialiseControls; virtual;

    { Summary
      Method that creates the required radio button controls to support the dialogs radio button section. }
    procedure CreateRadioButtons; virtual;
    { Summary
      Method that positions the radio buttons. }
    procedure PositionRadioButtons; virtual;
    { Summary
      Method that creates the required custom button controls to support the dialogs radio button section.
      Description
      Custom buttons include Custom Buttons on the button bar section and also Command Link Buttons. }
    procedure CreateCustomButtons; virtual;
    { Summary
      Method that positions the custom buttons. }
    procedure PositionCustomButtons; virtual;
    { Summary
      Method that creates the required button bar buttons to support the dialogs radio button section.
      Description
      Button Bar Buttons are only the buttons that are a Common Button. }
    procedure CreateButtonBarButtons; virtual;
    { Summary
      Method that positions the button bar buttons. }
    procedure PositionButtonBarButtons; virtual;
    { Summary
      Method that creates the required check box control to support the dialogs verification section. }
    procedure CreateVerificationCheckBox; virtual;
    { Summary
      Method that positions the verification check box. }
    procedure PositionVerificationCheckBox; virtual;
    { Summary
      Method that creates the required control to allow a dialog to be expanded and collapsed. }
    procedure CreateExpandoButton; virtual;
    { Summary
      Method that positions the expando control on the dialog. }
    procedure PositionExpandoButton; virtual;
    { Summary
      Method that creates the control required to draw the instruction section of a dialog. }
    procedure CreateInstruction; virtual;
    { Summary
      Method that positions the instruction control on the dialog. }
    procedure PositionInstruction; virtual;
    { Summary
      Method that creates the control required to draw the content section of a dialog. }
    procedure CreateContent; virtual;
    { Summary
      Method that positions the content control on the dialog. }
    procedure PositionContent; virtual;
    { Summary
      Method that creates the control required to draw the footer section of a dialog. }
    procedure CreateFooter; virtual;
    { Summary
      Method that positions the footer control on the dialog. }
    procedure PositionFooter; virtual;
    { Summary
      Method that creates the rich edit based control required for the footer section of a dialog. }
    procedure CreateMoreInFooter; virtual;
    { Summary
      Method that creates the control responsible for drawing the expanded content in the dialog. }
    procedure CreateMoreLines; virtual;
    { Summary
      Method that positions the additional content displayed when the dialog is expanded.  }
    procedure PositionMoreLines; virtual;
    { Summary
      Method that positions the rich edit control when displayed in the footer section of a dialog. }
    procedure PositionMoreRichEdit; virtual;
    function  LoadLines(L: TStrings): Boolean;
    function  LoadLinesW(L: TJSStrings): Boolean;
    { Summary
      This method currently has no implementation but may be introduced later. }
    procedure CreateHeader; virtual;
    { Summary
      Method that creates the control required to draw the help link section of a dialog. }
    procedure CreateHelpLinkLabel; virtual;
    { Summary
      Method that positions the help link control on the dialog. }
    procedure PositionHelpLinkLabel; virtual;
    { Summary
      Method that creates the progress bar control used when a dialog needs to show progress information. }
    procedure CreateProgressBar; virtual;
    { Summary
      Method that positions the progress bar control on the dialog. }
    procedure PositionProgressBar; virtual;
    { Summary
      This method has no implementation in TJSCustomDialog descendants, but is used in TJSCustomEditDialog descendants. }
    procedure CreateEditControls; virtual;

    { Summary
      Method returns the default control class type for a specific TControlType.
      Description
      To use a different control class to represent a specific TControlType on a dialog, descendant controls should
      override this method in order to return the new control class to use.
      Remarks
      It is recommended if you override the InitialiseControlClass method that you also override the InitaliseControl
      method. }
    procedure InitialiseControlClass(AControlType: TControlType; var AControlClass: TControlClass); virtual;
    { Summary
      Method that calls the InitialiseControlClass method to get the default control class for a specific TControlType.
      Description
      This method also triggers the OnGetControlClass event that allows you to specify a different control class to
      the default class.
      Remarks
      It is recommended if you override the InitialiseControlClass method that you also override the InitaliseControl
      method. }
    function DoGetControlClass(AControlType: TControlType): TControlClass; virtual;
    { Summary
      Method that calls the InitialiseControl method to initialise the default control instance for a specific
      TControlType.
      Description
      This method also triggers the OnInitControl event that allows you to initialise different control class to
      the default class.
      Remarks
      It is recommended if you override the InitialiseControlClass method that you also override the InitaliseControl
      method. }
    procedure DoInitControl(AControlType: TControlType; AControl: TControl; AControlItem: TCollectionItem); virtual;
    { Summary
      Method use to initialise a specific TControlType.
      Description
      Each supported TControlType has a default implementation for initialising the default control class
      used to represent the specific TControlType on the dialog.

      <table>
      Supported control types
      ------------------------
      ctButton
      ctCheckBox
      ctCommandLink
      ctProgressBar
      ctRadioButton
      ctRadioGroup
      </table>

      Descendants that override the InitialiseControlClass method should either handle the OnInitControl
      event and make sure the Handled parameter of the event is set to True or override the
      InitialiseControl method making sure to only handle the overridden control type.
      Remarks
      It is recommended if you override the InitialiseControlClass method that you also override the InitaliseControl
      method. }
    procedure InitialiseControl(AControlType: TControlType; AControl: TControl; AControlItem: TCollectionItem); virtual;
    { Summary
      Method that triggers the OnGetMoreFileName event.
      Description
      Handle this event when your dialog has a visible Expando section and the Expando.MoreSource property is set to
      msFile. This event should return the name of the text based file to load when the dialog shows the expanded
      view. }
    procedure DoGetMoreFileName(var aFileName: TJSString); virtual;
    { Summary
      Method that triggers the OnGetMoreFileName event.
      Description
      Handle this event when your dialog has a visible Expando section and the Expando.MoreSource property is set to
      msStream. This event should update the aStream parameter to include the text to show when the dialog is
      expanded. }
    procedure DoGetMoreStream(var aStream: TMemoryStream); virtual;
    { Summary
      Method that triggers the OnHelpLinkClick event.
      Description
      The DoHelpLinkClick method also provides addition default processing if the OnHelpLinkClick is not handled.

      If the application has a Help File associated with it, then depending on the HelpLink.HelpType value either
      Application.HelpContext(HelpLink.HelpContext) or Application.HelpKeyword(HelpLink.HelpKeyword) is called. }
    procedure DoHelpLinkClick; virtual;
    { Summary
      Method that either expands or collapses the dialog and calls the appropriate event for the AExpand value. }
    procedure ExpandDialog(const AExpand: Boolean); virtual;
    { Summary
      Method that determines which control should have focus when the dialog is displayed.
      Returns
      Returns the ActiveControl determined by the ActiveControlType property. }
    function GetActiveControl: TWinControl; virtual;
    { Summary
      Method that loads the appropriate system image for a particular TTaskDialogIcon value. }
    class procedure SetTaskIcon(const aIcon: TTaskDialogIcon; aGlyph: TPicture);
    { Summary
      Method that checks to see if the dialog is allowed to process Progress Bar update messages.
      Returns
      Returns True if the dialog has a non marquee style progress bar on it. }
    function CanUpdateProgress: Boolean;{$IFDEF INLINE}inline;{$ENDIF}
    { Summary
      Method that repaints all buttons on the dialog. }
    procedure InvalidateButtons;
    { Summary
      Method that triggers the OnExpand event. }
    procedure DoExpand; virtual;
    { Summary
      Method that triggers the OnCollapse event. }
    procedure DoCollapse; virtual;
    { Summary
      Method that triggers the OnUpdateProgressBarState event. }
    procedure DoUpdateProgressBarState(AState: TProgressBarState); virtual;
    { Summary
      Method that triggers the OnUpdateProgressBar event. }
    procedure DoUpdateProgressBar(const APosition: Integer; var ACloseDialog: Boolean); virtual;
    { Summary
      Method that triggers the OnProgress event. }
    procedure DoProgress(const APosition: Integer); virtual;
    { Summary
      Method that triggers the OnDialogClose event after calling the UpdateDialogResult method. }
    procedure DoDialogClose(Sender: TObject); virtual;
    { Summary
      Method that triggers the OnDialogClick event. }
    procedure DoDialogClick(Sender: TObject; const AHitTest: TJSDialogHitTest); virtual;
    { Summary
      Method that updates the internal record that holds the various result values for the dialog. }
    procedure UpdateDialogResult; virtual;
    { Summary
      Method that triggers the OnCleanUpDialog event and calls the CleanUpDialog method. }
    procedure DoCleanUpDialog; virtual;
    { Summary
      Method that triggers the OnTimer event. }
    procedure DoTimerEvent(const aTimeSince: Cardinal); virtual;
    { Virtual method that destroys any created controls on the
      dialog before being closed.                              }
    procedure CleanUpDialog; virtual;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    { Summary
      Method that triggers the OnCreated event. }
    procedure DoCreated; virtual;
    { Summary
      Method that triggers the OnDestroyed event. }
    procedure DoDestroyed; virtual;
    { Method that calls the OnDialogConstructed event if one is assigned.
      The event parameter is the actual form created. }
    procedure DoDialogConstructed; virtual;
    { Summary
      Method that makes sure that Command Link button hotkeys are visible. }
    procedure ShowCommandLinkHotKeys;
    { Summary
      Method that returns the checked state for a particular radio button control.
      Description
      This method calls on the OnGetRadioButtonChecked event. If that event is not handled then the default
      handling is used to determine if a particular radio button control is checked on a dialog.
      Returns
      If the control is checked then the method returns True. }
    function DoGetRadioButtonChecked(AControl: TControl): Boolean; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Summary
      Method that resets a marquee style progress bar when displayed on a dialog. }
    procedure ResetProgressBar; virtual;
    { Summary
      Method that triggers the OnVerificationClick event.
      Description
      Handle the OnVerificationClick event when you need to perform additional processing when the verification
      check box is clicked when the dialog is visible. }
    procedure DoVerificationClick(const Checked: Boolean); virtual;
    { Summary
      Method that specifies if system sounds are to be played when the dialog is displayed.
      Description
      Override the PlaySystemSounds method if you want to prevent system sounds from playing.
      Returns
      Returns True when a system sound is meant to be played when the dialog is displayed.
      Remarks
      Currently the PlaySystemSounds method just checks the PlaySounds property value of the dialog.   }
    function PlaySystemSounds: Boolean; virtual;
    { Summary
      Specifies the system sound to play for the dialog specified.
      Description
      The GetSystemSound method returns the sound to play when the dialog displays for a particular TTaskDialogIcon
      type. The flags used to play the sound are also specified in the method call.
      Returns
      The sound to be played. }
    function GetSystemSound(const AIcon: TTaskDialogIcon; var AFlags: Cardinal): string; virtual;
    { Summary
      Triggers the OnDialogShow event if one has been assigned. }
    procedure DoDialogShow; virtual;
    { Summary
      Method that is responsible for making the dialog visible and modal. }
    procedure DoShowDialogModal; virtual;
    { Summary
      Method that is responsible for making the dialog visible and non-modal. }
    procedure DoShowDialogNonModal; virtual;
    { Summary
      Method that calculates the position of the dialog if the DialogStyle property is set to dsSheet. }
    procedure CalculateSheetPosition; virtual;
    { Summary
      Override this method to modify the calculated top position for the dialog sheet. }
    function AdjustSheetTopPosition(const ATop: Integer): Integer; virtual;
    { Summary
      Returns the height of the title bar for the form specified
      Description
      If no form has been specified, then the applications active form is used for the calculation }
    function GetCaptionHeight(AForm: TCustomForm): Integer;
    { Summary
      Returns the number of pixels the content section has.
      Description
      Use this method to help determine the width you want the dialog to display. This calculation includes icon width and 
      default margins values.
      Remarks
      Use the ContentLineWidth to calculate the width required for a particular line of text to display. }
    function HorzPadding: Integer; virtual;
    { Summary
      Specifies the value used for the left margin.
      Description
      This value is used to calculate the left coordinates for
      controls.                                                }
    property LeftMargin: Integer read FLeftMargin;
    { Summary
      Specifies the value used for the right margin.
      Description
      This value is used to calculate the right coordinates for
      controls.                                                 }
    property RightMargin: Integer read FRightMargin;
    { Summary
      Specifies the value used for the vertical margins of the
      dialog.
      Description
      This value is used to calculate the vertical coordinates for
      controls that are displayed on the dialog.                   }
    property VertMargin: Integer read FVertMargin;
    { Use this property to determine if a preview of a dialog is being shown. }
    property DialogState: TJSDialogStates read FDialogState;
  public
    { Creates and initializes a TJSCustomDialog instance. }
    constructor Create(AOwner: TComponent); override;
    { Destroys the TJSCustomDialog instance and frees its memory. }
    destructor Destroy; override;
    { Call the execute method to display the dialog.
      keywords: Execute;Show;Display }
    function Execute: Integer; overload;
    { Call the execute method to display the dialog.

      Specify the owner of the dialog using the aOwner parameter

      keywords: Execute;Show;Display }
    function Execute(aOwner: TComponent): Integer; overload; virtual;
    {       
      The ExecutePreview method should only be used by the Component Editor, 
      the DialogOptions and Position properties are modified before the dialog 
      is displayed in the IDE. }
    function ExecutePreview: Integer;
    { Summary
      Returns the number of pixels the string passed in needs to be displayed in the dialog content.
      Description
      Use this method to help determine the width you want the dialog to display as.
      Remarks
      There is no need to add the result of ContentLineWidth to the result of the HorzPadding since it is included
      in the result. }
    function ContentLineWidth(const ALine: string): Integer;
    { Summary
      Returns the number of pixels the string passed in needs to be displayed with the specific default dialog font.
      Description
      Use this method to help determine the width you want the dialog needs to display to force a particular line of
      text to be display on one line. Pass in the specific font you want to use to accurately calculated the size.
      Remarks
      To calculate the width for the content, use the ContentLineWidth method unless you need to know the width without
      creating an instance of a dialog.
      For a custom font you will need to calculate the size yourself using the specific font characteristics. }
    class function RequiredWidth(const ALine: string; AFontType: TJSFontType): Integer;
    {
      Call the Close method to close the dialog.

      Specify the dialog result by using the AModalResult parameter. }  
    function Close(const AModalResult: Integer = 0): Integer; virtual;
    { Summary
      Method that can be used to force the dialog to repaint. }
    procedure Update;
    { Positions controls to make sure that the sections on the
      dialog are correct.                                      }
    procedure PositionControls; virtual;
    { Set the default radio button for when the dialog is displayed. The aIndex parameter
      is the index of the radio button as it appears. The first radio button is at index 0. }
    procedure DefaultRadioButton(const aIndex: Integer);
    { Summary
      Returns the checked state for the radiobutton value
      Description
      Call IsChecked to get the checked state of the Radio Button control
      that corresponds to the result value passed in.

      Note: Use RadioResult to determine which Radio Button is checked if the dialog has been closed. }
    function IsChecked(const aValue: Integer): Boolean;
    { Overview: Show the dialog after Execute has been called.
      Description: You can only use Show if you have previously called Execute. DialogOptions must not have doModal set
      show to be effective. }
    procedure Show;
    { Calling this overloaded version of UpdateProgress increments
      the progress bars current position by the Step amount.       }
    function UpdateProgress: Integer; overload;
    { This overloaded version of UpdateProgress sets the current
      progress bars position to the aPosition parameter value.   }
    function UpdateProgress(const aPosition: Integer): Integer; overload;
    { This overloaded version of UpdateProgress sets the position
      of the progress bar to the aPosition parameter and changes
      the Step property value to the aStep parameter value.       }
    function UpdateProgress(const aPosition, aStep: Integer): Integer; overload;
    { Set the state of the progress bar.
      Depending on your operating system the progress bar color may change. }
    procedure SetProgressState(const aState: TProgressBarState);
    { Set the radio button whose value is passed in as the aValue parameter to False.
      Passing in -1 for the aValue parameter, unchecks all radio buttons. }
    procedure SetUnchecked(const aValue: Integer = -1);
    { Set the radio button whose value is passed in as the aValue parameter to the checked
      state set in the aChecked parameter. }
    procedure SetChecked(const aValue: Integer; const aChecked: Boolean);
    { Copies the content of another TJSDialog to this object. }
    procedure Assign(Source: TPersistent); override;
    { Returns the instance of the control that corresponds to the control type requested in the
      AControlType parameter. If you use a control type that contains multiple controls, such as
      ctRadioButton or ctCommandLink than pass in the Value for the required control in the
      AValue parameter.  }
    function GetControl(const AControlType: TControlType; const AValue: Integer = -1): TControl;
    { Summary
      Set the Enabled property of a custom button control.
      Parameters
      AValue :    Custom button value to modify.
      AEnabled :  Specifies the new state of the button.
      Description
      Allows you to modify the enabled state of a button while the
      dialog is visible.                                           }
    procedure EnableButton(const AValue: Integer; const AEnabled: Boolean);
    { Summary
      Set the Enabled property of a radio button control.
      Parameters
      aValue :    Radio button value to modify.
      aEnabled :  Specifies the new state of the button.
      Description
      Allows you to modify the enabled state of a radio button
      while the dialog is visible.
      Example
      Use a Custom Button to make the second radio button on the
      dialog enabled.
      <code lang="delphi">

      procedure TfrmMain.JSDialog1ControlClick(Sender: TObject; ControlType: TControlType; Control: TControl;
        const Value: Integer; var Handled: Boolean);
      begin
        if ControlType = ctCommandLink then
        begin
          // Enable the second radio button in the dialog
          TJSDialog(Sender).EnableRadioButton(BASE_RADIOBUTTON + 1, True);
          Handled := True;
        end;
      end;
      </code>                                                                                                 }
    procedure EnableRadioButton(const aValue: Integer; const aEnabled: Boolean);
    { Summary
      Use to click a custom button
      Description
      Call to progmatically click the custom button whose value property is the same
      as the aValue parameter. }
    procedure PerformAction(const aValue: Integer);
    { Summary
      Use to change the custom buttons Caption, Hint and Info values.
      Description
      Call to change a custom buttons Caption, Hint and Info values for a custom button when the dialog is currently
      being displayed.
      Remarks
      This method works on Custom Buttons only but will work when the Custom Buttons are regular buttons or when the buttons
      are displayed as command link buttons.
      Do not use this method when the dialog is not currently visible. It will have no effect on the passed in button values. }
    procedure UpdateCustomButtonDetails(const aValue: Integer; const aCaption, aHint: TJSString; aInfo: TJSStrings);
    { Summary
      Dialog can be minimized.
      Description
      Setting AllowMinimize to true means that the dialog will have the minimize button in the title bar. }
    property AllowMinimize: Boolean read FAllowMinimize write FAllowMinimize default False;
    { Summary
      Dialog can be cancelled.
      Description
      Setting AllowCancel to true means that the dialog will have the close button in the title bar.
    }
    property AllowCancel: Boolean read FAllowCancel write FAllowCancel default True;
    { Summary
      References the form for the dialog when displayed.
      Description
      The Form reference is only value when the dialog is visible.
      When the dialog is not visible, then the Form property will
      be either nil or unassigned.                                 }
    property Form: TJSCustomTaskDialogForm read FForm write SetForm;
    { Summary
      Determines which control type has the focus when the dialog is displayed.
      Description
      Use ActiveControlType to set what control type has focus when the dialog is displayed. By default the default button will have the focus.
      Remarks
      Selecting ctRadioButton means that the first Radio Button will be focused.
    }
    property ActiveControlType: TControlType read FActiveControlType write SetActiveControlType default ctButton;
    { Specifies the font attributes to use for the content section
      of the dialog. This font is also used for the Verification
      check box.                                                   }
    property Font: TFont read FFont write SetFont stored IsFontStored;
    { The background color for the dialog. This color controls the
      background color for all of the dialog and its controls
      except for the button section. To set the color of the button
      section, use the ButtonBar Color property.                    }
    property Color: TColor read FColor write SetColor stored IsColorStored default clWindow;
    { Text that is displayed in the content section of the dialog. }
    property Content: TJSStrings read FContent write SetLines;
    { Holds the properties that control how the expando control. }
    property Expando: TJSExpando read FExpando write SetExpando;
    { Holds the image to be displayed in the content section of the
      dialog.                                                       }
    property Glyph: TPicture read FGlyph write SetGlyph;
    { Contains the list of radio buttons that the dialog is to
      display. Requires the doRadioButtons value set in
      DialogOptions.                                           }
    property RadioButtons: TJSRadioButtons read FRadioButtons write SetRadioButtons stored IsRadioButtonsStored;
    { Overview: Contains the list of custom buttons that the dialog is to
      display.

      Description: CustomButtons are displayed as normal buttons on the
      ButtonBar if neither the doCommandLinks or doCommandLinksNoIcon
      options are specified in the DialogOptions property. If custom
      buttons are being used, then common buttons are not displayed.

      keywords: CommandLinks;Buttons;Custom buttons;TJSCustomButtonItem }
    property CustomButtons: TJSCustomButtons read FCustomButtons write SetCustomButtons stored IsCustomButtonsStored;
    { Holds the properties that control how the button section is
      displayed.                                                  }
    property ButtonBar: TJSButtonBarOptions read FButtonBar write SetButtonBar;
    { Holds the properties that control how the instruction is
      displayed.
      keywords: Instruction;Text}
    property Instruction: TJSInstruction read FInstruction write SetInstruction;
    { Holds the properties that control how the verification check
      box is displayed.                                            }
    property Verification: TJSVerification read FVerification write SetVerification;
    { Summary
      This property is no longer used and could be removed in a
      future release.                                           }
    property Text: TJSString read FText write SetText;
    { Icon that is displayed on the left edge of the dialog. }
    property MainIcon: TTaskDialogIcon read FMainIcon write SetMainIcon default tdiNone;
    { Controls the appearance of the different dialog sections and
      controls.                                                    }
    property DialogOptions: TDialogOptions read FDialogOptions write SetDialogOptions default [doModal];
    { Summary
      Determines the style of the dialog to be displayed.
      Description
      Allows you to control how the dialog is presented to the user. If the style is set to dsSheet then
      the dialog will either drop down central to the active form or central to the current monitor.
      Remarks
      The default value for this property is dsDialog. }
    property DialogStyle: TJSDialogStyle read FDialogStyle write SetDialogStyle default dsDialog;
    { Holds the properties that control how the help link is
      displayed.                                             }
    property HelpLink: TJSHelpLink read FHelpLink write SetHelpLink;
    { Holds the properties that control how the progress bar
      functions.                                             }
    property Progress: TJSProgress read FProgress write SetProgress;
    { Specifies the appearance of the dialog border. The border is
      not visible by default.                                      }
    property Border: TJSBorder read FBorder write SetBorder;
    { Holds the properties relating to customised button appearance. }
    property Button: TJSButtonOptions read FButton write SetButton;
    { Holds the properties that control how the footer section is
      displayed.                                                  }
    property Footer: TJSFooter read FFooter write SetFooter;
    { Holds the properties that control how the header section is
      displayed.                                                  }
    property Header: TJSHeader read FHeader write SetHeader;
    { The title of the dialog. The Title text appears in the
      caption of the created dialog providing the BorderStyle is
      not bsNone.                                                }
    property Title: TJSString read FTitle write SetTitle; 
    { Determines the Position of the dialog. When Position is set
      to dpDesigned then the top and left values are retrieved from
      the Location property. If the Location property has one value
      of -1, then the dialog is displayed centered.                }
    property Position: TDialogPosition read FPosition write FPosition default dpScreenCenter;
    { Context used when F1 has been pressed and HelpType is
      htContext.                                            }
    property HelpContext: Integer read FHelpContext write FHelpContext default 0;
    { Set to use the default fonts that have been set in the
      DefaultFonts global variable. When TRUE all specific Font
      sections are ignored.
      keywords: Fonts;DefaultFonts;TDefaultFont }
    property UseDefaultFonts: Boolean read FUseDefaultFonts write SetUseDefaultFonts default True;
    { Specifies the appearance and behavior of the form border. }
    property BorderStyle: TFormBorderStyle read FBorderStyle write FBorderStyle default bsDialog;
    { Holds the Icon that is used in the dialogs title bar.
      BorderIcons must include biSystemMenu for the Icon to be
      displayed.                                               }
    property Icon: TIcon read FIcon write SetIcon;
    { Invocation method for help when the user presses F1. }
    property HelpType: THelpType read FHelpType write FHelpType default htContext;
    { Keyword used when F1 has been pressed and HelpType is
      htKeyword.                                            }
    property HelpKeyword: TJSString read FHelpKeyword write FHelpKeyword;
    { Properties that controls the appearance of the dialog. When
      TRUE the dialog will look like older style dialogs from
      operating systems prior to Windows Vista.

      You should avoid setting this property directly unless you
      are sure you want this to occur. For a consistent look and
      feel for all dialogs use the OldDialogStyle exclusively.
      keywords: Appearance;OldDialogStyle;EmulateMessageDlg}
    property EmulateMessageDlg: Boolean read FEmulateMessageDlg write FEmulateMessageDlg;
    { The coordinates of the dialog when the Position property is
      dpDesigned. The Location values are ignored if one of them is
      -1.                                                          }
    property Location: TJSLocation read FLocation write SetLocation;
    { Summary
      Determines if the dialog plays a sound when displayed on screen.
      Description
      Depending on the MainIcon value for the dialog, the dialog will play the default system sound
      associated with the icon type.
      <table>
      MainIcon value    Default Sound
      ----------------  ------------------------------
      tdiNone           No sound is played
      tdiWarning        SystemExclamation
      tdiError          SystemHand
      tdiInformation    SystemAsterisk
      tdiConfirmation   SystemQuestion
      tdiCustom         No sound is played by default
      tdiShield         WindowsUAC
      </table>
      Remarks
        * The WindowsUAC sound is only applicable to Windows Vista or greater operating systems
        * You can override the default sound by either overriding the GetSystemSound method in a descendant
          or handling the OnGetCustomSound event.                                                           }
    property PlaySounds: Boolean read FPlaySounds write SetPlaySounds;
    { Summary
      Determines the width of the client area of the dialog.
      Description
      The Width of the dialog when it is displayed. By default the
      width is determined by the dialog contents. Change the Width
      property from 0 to force the dialog to display at a
      particular width.

      The Width property has no effect when emulating old dialogs
      (OldDialogStyle = TRUE).

      There is no way to control the Height of a dialog. This is
      calculated and cannot be modified.
      Remarks
      The width value doesn't not include any operating system border width used in displaying the dialog.
      Keywords
      Width;OldDialogStyle;Emulation }
    property Width: Integer read FWidth write SetWidth default 0;
    { Summary
      Specifies if the dialog should be displayed as if the
      MessageDlg function has been called.
      Description
      When True, this property forces the look of the dialog to be
      native to the operating system that the application is
      currently running on.                                        }
    property UseOldStyleSetting: Boolean read FUseOldStyleSetting write FUseOldStyleSetting default True;
    { Overiew: The value of the selected radio button.
      Description: Specifies the checked value of the radio button on the dialog. }
    property RadioResult: Integer read GetRadioResult write SetRadioResult;
    { Overview: The result of the verification check box.
      Description: Specifies the checked state of the verification checkbox of the dialog.
      Result values start at 200 for the first radio button and increase in value by one. }
    property VerificationResult: Boolean read GetVerificationResult write SetVerificationResult;
    { Overview: The modal result value of the button that was clicked to close the dialog.
      Description: Set by the control that closes the dialog. To directly influence the ModalResult of the dialog, call the Close method.
      keywords: ModalResult;Close;Dialog Closing;Closing the dialog}
    property ModalResult: TModalResult read GetModalResult write SetModalResult;
    { Overview: The value of the button that was clicked.
      Description: Use to determine which custom button on the dialog was clicked.
      If the custom button has a modal result assigned you could also use the return value after calling the dialogs Execute method.
      Result values start at 100 for the first custom button and increase in value by one.
      keywords: CommandLinks;Buttons;Custom buttons;TJSCustomButtonItem}
    property CustomButtonResult: Integer read FCustomButtonResult write SetCustomButtonResult;
    { Holds the properties that control how the doTimer flag works }
    property Timer: TJSTimer read FTimer write SetTimer;
    { Holds the properties that allow the extending of the RadioButton functionality } 
    property RadioButton: TJSRadioButton read FRadioButton write SetRadioButton;
    { Summary
      Specifies the bi-directional mode for the control.
      Description
      Use BiDiMode to enable the control to adjust its appearance and behavior automatically
      when the application runs in a locale that reads from right to left instead of left to right.
      The bi-directional mode controls the reading order for the text, the placement of the vertical scroll bar,
      and whether the alignment is changed. }
    property BiDiMode: TBiDiMode read FBiDiMode write FBiDiMode default bdLeftToRight;
    { Summary
      Applicable options when the DialogStyle is set to dsSheet }
    property Sheet: TJSSheetOptions read FSheet write SetSheet;
    { Sumamry
      Specifies if the Help button is displayed in the dialogs caption.
      Description
      Specify to display a help button in the caption of the dialog.
      A question mark appears in the form's title bar and when clicked, the cursor changes to crHelp; otherwise, no question mark appears.

      The help button will only appear when AllowMinimize is false. }
    property ShowHelpButton: Boolean read FShowHelpButton write FShowHelpButton default False;
    { Summary
      Specifies whether hints are visible on the dialog.
      Description
      Set ShowHint to true to allow for hints on CommandLinkButtons
      to be shown.                                                  }
    property ShowHint: Boolean read FShowHint write SetShowHint default False;
    { Summary
      The maximum number of content lines to display.
      Description
      Determines the maximum number of content lines that are displayed until the content is displayed in a scrollable memo control.

      }
    property MaxLines: Integer read FMaxLines write FMaxLines default 0;
    { Summary
      The monitor on which to display the dialog on.
      Description
      Use this property to manipulate which monitor you want the dialog to display on.

      Example
      To display the dialog on a secondary monitor (which is setup to the left of the primary monitor) and the active form is on
      the primary monitor, use the following:
      <code lang="delphi">
      JSDialog1.DefaultMonitor := dmDesktop;
      JSDialog1.Location.X := -500;
      JSDialog1.Location.Y := 0;
      JSDialog1.Position := dpDesigned;
      JSDialog1.Execute;
      </code>

      Remarks
      This setting is ignored when the Position is set to dpOwnerFormCenter.
    }
    property DefaultMonitor: TDefaultMonitor read FDefaultMonitor write FDefaultMonitor default dmActiveForm;
    { Summary
      Triggered when the dialog is created.
      Description
      Handle the OnCreated event to write code that requires the
      Form property of TJSCustomDialog to be a valid reference.  }
    property OnCreated: TNotifyEvent read FOnCreated write FOnCreated;
    { Summary
      Triggered once the Form reference that contains the dialog is
      destroyed.
      Description
      This event is triggered after the OnCleanUpDialog event is
      triggered.                                                    }
    property OnDestroyed: TNotifyEvent read FOnDestroyed write FOnDestroyed;
    { Summary
      Triggered once the dialog has been setup and is about to be
      shown.
      Description
      This event is triggered once the dialog is about to be made
      visible. After this event has been called, only the timer is
      started if doTimer is specified in the DialogOptions property
      before the dialog is made visible.                            }
    property OnDialogConstructed: TNotifyEvent read FOnDialogConstructed write FOnDialogConstructed;
    { Event triggered when the Dialog has been closed. }
    property OnDialogClose: TDialogCloseEvent read FOnDialogClose write FOnDialogClose;
    { Event triggered when the Dialog area is clicked. }
    property OnDialogClick: TDialogClickEvent read FOnDialogClick write FOnDialogClick;
    { Summary
      Triggered once the Form reference that contains the dialog is
      destroyed.
      Description
      This event is triggered before the OnDestroyed event is
      triggered.                                                    }
    property OnCleanUpDialog: TNotifyEvent read FOnCleanUpDialog write FOnCleanUpDialog;
    { Summary
      Triggered when the dialog is first displayed. }
    property OnDialogShow: TNotifyEvent read FOnDialogShow write FOnDialogShow;
    { Event triggered when the MoreSource value in the Expando options is msFilename. }
    property OnGetMoreFileName: TGetMoreFileNameEvent read FOnGetMoreFileName write FOnGetMoreFileName;
    { Event triggered when the MoreSource value in the Expando options is msStream. }
    property OnGetMoreStream: TGetMoreStreamEvent read FOnGetMoreStream write FOnGetMoreStream;

    { Handle this event to setup a custom control. }
    property OnInitControl: TInitControlEvent read FOnInitControl write FOnInitControl;
    { Event triggered when the dialog is looking for what control
      class will be used for a specific control on the dialog. }
    property OnGetControlClass: TGetControlClassEvent read FOnGetControlClass write FOnGetControlClass;
    { Event triggered when the dialog has been expanded by pressing
      the Expando button.                                           }
    property OnDialogExpand: TNotifyEvent read FOnDialogExpand write FOnDialogExpand;
    { Event triggered when the dialog has been collapsed by pressing the Expando button. }
    property OnDialogCollapse: TNotifyEvent read FOnDialogCollapse write FOnDialogCollapse;
    { Summary
      Event triggered when a dialog that has a MainIcon value of tdiCustom is displayed.
      Description
      This event allows you to specify a custom sound to be played when the dialog is being displayed. }
    property OnGetCustomSound: TGetCustomSoundEvent read FOnGetCustomSound write FOnGetCustomSound;
    { Handle this event to retrieve the Verification result. }
    property OnGetVerificationResult: TGetVerificationResult read FOnGetVerificationResult write FOnGetVerificationResult;
    { Handle this event to perform custom actions when the cbHelp common button bar button is clicked }
    property OnHelpButtonClick: THelpButtonClickEvent read FOnHelpButtonClick write FOnHelpButtonClick;
    { Overview: Handle this event to process the Help Link being clicked.
      Description: Set the Handled parameter to True if you do not want the default action to be done. }
    property OnHelpLinkClick: THelpLinkClickEvent read FOnHelpLinkClick write FOnHelpLinkClick;
    { Event triggered when a control on the dialog has been clicked. }
    property OnControlClick: TControlClickEvent read FOnControlClick write FOnControlClick;
    { Event triggered when a control on the dialog has been clicked. }
    property OnGetRadioButtonChecked: TGetRadioButtonChecked read FOnGetRadioButtonChecked write FOnGetRadioButtonChecked;
    { Overview: Event triggered when the progress bars position changes
      Description: This event is triggered each time the progress bar is updated.
      <b>Note</b>: This event does not trigger for the Marquee progress bar. }
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    { Handle this event to update the state of a custom progress bar. }
    property OnUpdateProgressBarState: TUpdateProgressBarStateEvent read FOnUpdateProgressBarState write FOnUpdateProgressBarState;
    { Handle this event to update a custom progress bar. }
    property OnUpdateProgressBar: TUpdateProgressBarEvent read FOnUpdateProgressBar write FOnUpdateProgressBar;
    { This event is triggered every time the Timer interval has elasped }
    property OnTimer: TTimerEvent read FOnTimer write FOnTimer;
    { Overview: Respond to specific key presses on the dialog by using this event
      Description: By using this event you can assign shortcut keys to specific custom buttons and progmatically
      click those buttons by using the PerformAction method. }
    property OnKeyPress: TKeyEvent read FOnKeyPress write FOnKeyPress;
    { Summary
      Use the OnVerificationClick event handler to respond when the
      user clicks the verification control.                         }
    property OnVerificationClick: TVerificationClickEvent read FOnVerificationClick write FOnVerificationClick;
  end;

  { This component is registered in the Tool (Component) Palette
    of the selected IDE and is the main component in JSDialog
    Pack.                                                        }
  {$IFDEF DELPHI_XE2}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64{ or pidOSX32})]
  {$ENDIF}
  TJSDialog = class(TJSCustomDialog)
  published
    property ActiveControlType;
    property AllowCancel;
    property AllowMinimize;
    property BiDiMode;
    property Button;
    property Content;
    property DefaultMonitor;
    property DialogOptions;
    property DialogStyle;
    property Expando;
    property Glyph;
    property Instruction;
    property RadioButtons;
    property CustomButtons;
    property ButtonBar;
    property Verification;
    property Footer;
    property Header;
    property MainIcon;
    property HelpLink;
    property Progress;
    property Border;
    property Title;
    property Position;
    property Color;
    property Font;
    property UseDefaultFonts;
    property BorderStyle;
    property Icon;
    property HelpContext;
    property HelpType;
    property HelpKeyword;
    property Location;
    property Width;
    property UseOldStyleSetting;
    property Sheet;
    property Timer;
    property RadioButton;
    property ShowHint;
    property MaxLines;
    // events
    property OnCleanUpDialog;
    property OnCreated;
    property OnDestroyed;
    property OnDialogClick;
    property OnDialogClose;
    property OnDialogConstructed;
    property OnGetMoreFileName;
    property OnGetMoreStream;
    property OnHelpLinkClick;
    property OnHelpButtonClick;
    property OnGetControlClass;
    property OnInitControl;
    property OnControlClick;
    property OnDialogCollapse;
    property OnDialogExpand;
    property OnDialogShow;
    property OnGetRadioButtonChecked;
    property OnGetVerificationResult;
    property OnProgress;
    property OnUpdateProgressBarState;
    property OnUpdateProgressBar;
    property OnTimer;
    property OnKeyPress;
    property OnVerificationClick;
  end;

  { Summary
    TJSDialogClass defines the metaclass for TJSDialog.
    Description
    TJSDialogClass is the metaclass for TJSDialog. Its value is the class reference for TJSDialog or for
    one of its descendants.                                                                              }
  TJSDialogClass = class of TJSDialog;

  { Summary
    Type used in the TJSTaskDialogForm's OnClientClick event handler. }
  TJSTaskDialogFormClientClickEvent = procedure (Sender: TObject; const APt: TPoint) of object;

  { Summary
    The dialog created, descends from TJSTaskDialogForm. }
  TJSTaskDialogForm = class(TJSCustomTaskDialogForm)
  private
    FDialog: TJSCustomDialog;
    FLastTimer: Cardinal;
    FOnClientClick: TJSTaskDialogFormClientClickEvent;
    procedure WMNonModalFree(var Message: TMessage); message WM_NONMODAL_FREE;
    procedure WMPerformSnapTo(var Message: TMessage); message WM_PERFORMSNAPTO;
  protected
    { Summary
      Overridden to make sure that buttons on the form draw correctly.
      Description
      Overridden to make sure that buttons on the form draw correctly.

      Note: This is for supporting Command Link Buttons.                   }
    procedure ActiveChanged; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoClose(var Action: TCloseAction); override;
    { Returns a string describing the contents of the dialog in a text format. }
    function GetTaskDialogText: TJSString; virtual;
    { Summary
      Overridden to process specific key sequence required by a TJSDialog or descendant.
      Description
      The KeyDown event also handles the copying of the dialog contents to the clipboard when the Ctrl+C
      shortcut is pressed.

      The checking to see if using Alt+F4 to close the dialog is permitted is also done as well as making
      sure the accelerator keys are displayed for Command Link Buttons when necessary.                    }
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMWinIniChange(var Message: TMessage); message WM_WININICHANGE;
    procedure Paint; override;
    procedure CreateWnd; override;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
    { Summary
      Starts a timer that allows the form to receive WM_TIMER messages.
      Description
      Starts a timer that allows the form to receive WM_TIMER messages.

      Used for when the dialog associated with the TJSTaskDialogForm instance has doTimer set in the
      DialogOptions property.

      <b>Note</b>: There should be no need to call this method explicitly.                           }
    procedure StartTimer;
    { Summary
      Stops the form from receiving WM_TIMER messages.
      Description
      Stops the form from receiving WM_TIMER messages.

      Used for when the dialog associated with the TJSTaskDialogForm instance has doTimer set in the
      DialogOptions property.

      <b>Note</b>: There should be no need to call this method explicitly.                           }
    procedure EndTimer;
    { Summary
      Method that triggeres the OnClientClick event.
      Description
      Override this method if you are required to perform additional processing either before or after the
      OnClickClick event has been triggered.                                                               }
    procedure DoClientClick(const APt: TPoint); virtual;
    procedure Click; override;
    { Reference to the TJSDialog component that the dialog is based upon. }
    property Dialog: TJSCustomDialog read FDialog write FDialog;
  public
    { Summary
      Creates and initializes a TJSTaskDialogForm instance.
      Description
      This method is overridden to help initialize private variables and various properties of the
      TCustomForm descendant.                                                                      }
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    { Summary
      Event triggered when the mouse is client on the dialog area.
      Description
      This event is triggered when a click to the form that represents the dialog occurs at runtime. This
      method is handled internally by the TJSCustomDialog instance to then perform hit testing and trigger
      the OnDialogClick event.                                                                             }
    property OnClientClick: TJSTaskDialogFormClientClickEvent read FOnClientClick write FOnClientClick;
  end;

{ Register the Font attributes to use for a certain font type.
  The registered font is used when called the DialogParams
  method to initialise a TDialogParams instance with default
  values.                                                      }
procedure RegisterFont(AFontType: TJSFontType; AFont: TFont); overload;

{ Overview: Register a font for a specific section of the dialog 
  Description: Register the Font attributes to use for a certain font type.
  The registered font is used when consntructing a dialog }
procedure RegisterFont(AFontType: TJSFontType; const AName: string; const ASize: Integer; const AColor: TColor = clNone); overload;

{ Overview: Register the systems default font for this font type.
  Description: Call this version of register font to use the systems default font. }
procedure RegisterFont(AFontType: TJSFontType); overload;

{ Overview: Get the currently registered font.
  Description: Returns the currently registered font according to the font type passed in. }
function GetRegisteredFont(AFontType: TJSFontType): TFont;

{ Overview: Reset the default fonts back to their original values.
  Description: Call the ResetRegisteredFonts method to return all section fonts back to their default values.
  The default fonts will be retrieved from the system, the default fonts are not cached but read on demand. }
procedure ResetRegisteredFonts;

{ GetIcon returns the resourcename for the icon to load from the Windows resource library. }
function GetIcon(const Value: TTaskDialogIcon; var AIsCustomShield: Boolean): PChar;

{ Global function that returns true when running under Windows Vista }
function IsVista: Boolean;{$IFDEF INLINE}inline;{$ENDIF}

{ Global function that adjusts the value to resize correctly under a DPI that isn't 96 }
function AFFS(const AValue: Integer): Integer;{$IFDEF INLINE}inline;{$ENDIF INLINE}

const
  { Summary
    Name of the control that represents the instruction section of the dialog }
  JSDIALOG_CTRL_INSTRUCTION = 'JSDialogInstructionControl';
  { Summary
    Name of the control that represents the content section of the dialog }
  JSDIALOG_CTRL_CONTENT = 'JSDialogContentControl';
  { Summary
    Name of the control that represents the verification checkbox on the dialog }
  JSDIALOG_CTRL_VERIFICATION = 'JSDialogVerificationControl';
  { Summary
    Name of the control that represents the expando button on the dialog }
  JSDIALOG_CTRL_EXPANDO = 'JSDialogExpandoControl';
  { Summary
    Name of the control that display expanded rich content on the dialog }
  JSDIALOG_CTRL_RICHEDIT = 'JSDialogMoreRichEdit';
  { Summary
    Name of the control that display expanded content on the dialog }
  JSDIALOG_CTRL_MORELINES = 'JSDialogMoreLinesControl';
  { Summary
    Name of the control that displays the progress bar on the dialog }
  JSDIALOG_CTRL_PROGRESSBAR = 'JSDialogProgressControl';
  { Summary
    Name of the control that represents a group of radio buttons on the dialog }
  JSDIALOG_CTRL_RADIOGROUP = 'JSDialogRadioGroupControl';
  { Summary
    Name of the control that represents the content of the dialog when the maximum displayable lines has been reached }
  JSDIALOG_CTRL_CONTENTMEMO = 'JSDialogContentMemoControl';
  { Summary
    Name of the control that represents the footer section of the dialog }
  JSDIALOG_CTRL_FOOTER = 'JSDialogFooterControl';
  { Summary
    Name of the control that represents the help link on the dialog }
  JSDIALOG_CTRL_HELPLINK = 'JSDialogHelpLinkControl';
  { Summary
    Name of the form that represents the dialog }
  JSDIALOG_FORM = 'JSDialogForm';

var
  { Summary
    Global variable that controls the dialog appearance.
    Description
    Used to allow dialogs created with the MessageDlg function to display like the dialogs do in Windows
    2000 and WindowsXP operating systems.

    Changing this variable has no effect of dialogs created using the TJSDialog component. This value is
    used by some of the wrapper functions to maintain backwards compatibility. }
  UseOldDialogStyle: Boolean = False;

  { Summary
    Always use the system defined fonts for created dialogs.
    Description
    Global variable that allows you to ignore the font settings for dialogs that get created.

    This setting is for instances where the TJSDialog component is used and not one of the wrapper functions. }
  AlwaysUseDefaultFonts: Boolean = False;

  { Summary
    Class to use when creating dialogs with the wrapper functions.
    Description
    Set the JSDialogClass global variable if you have created a TJSDialog descendant component that you want
    the wrapper functions to create instead of the default TJSDialog.

    One reason to set JSDialogClass is if you are using third party controls to replace some of the controls
    that are used on the dialog, so your dialogs  better fit in with your applications unique theme. }
  JSDialogClass: TJSDialogClass;

implementation

{$R vistaimg.res}

uses
  Math, Consts, Clipbrd{$IFDEF THEMES}, Themes{$ENDIF THEMES}, MMSystem,
  CommCtrl, JSDialogStrs, JSUnicode, JSDialogSheet;
{$IFDEF TRIAL}
 procedure LMDCheckVALIDInfo;
var
  temp:String;
  result:Byte;
begin
  result:=0;
  try

    { 1. TAppBuilder-Window vorhanden?}
    temp:='TAPPBUILDER';
    if FindWindow({$IFDEF CLR}temp{$ELSE}PChar(temp){$ENDIF}, nil ) = 0 then Exit;
    inc(result);

    {2. Test}
    Inc(result);
  finally
    if result<>2 then    
      begin        
        {$IFNDEF BCB}    
        temp:='Delphi';
        {$ELSE}
        temp:='C++ Builder';
        {$ENDIF}
        showmessage('WARNING!'#13'This program was compiled with an unregistered '+
                    'version of a LMD Innovative product and will only run in the '+temp+'-IDE. For further '+
                    'information please contact'#13#13'LMD Innovative'#13'Jakob-Steffan-Str. 12a,'+
                    #13'55122 Mainz, Germany'#13'Internet: http://www.lmd.de'#13'e-mail: '+
                    'sales@lmd.de'#13#13'Application will be terminated now...');
        Halt;
      end;
  end;
end;
{$ENDIF}
const
  { The default vertical margin of the displayed dialog. }
  DEF_VERTMARGIN = 8;
  { The default horizontal margin between controls that are not
    the same.                                                   }
  DEF_HORZMARGIN = 8;
  { The default vertical spacing between controls that are the
    same.                                                      }
  DEF_VERTSPACING = 4;
  { The default spacing between the same types of controls. }
  DEF_HORZSPACING = 8;
  { The default horizontal spacing of buttons in the ButtonBar. }
  DEF_BUTTONSPACING = 4;

  { Specifies the minimum width for a dialog. }
  MIN_DIALOG_WIDTH = 360;
  { If doCommandLinks or doCommandLinkNoIcon is set in DialogOptions and the dialog has a visible verification
    check box then this is the minimum dialog width }
  MIN_CL_VERIFICATION_BASE = 388;
  { If doCommandLinks or doCommandLinkNoIcon is set in DialogOptions and the dialog has a visible footer
    then this is the minimum dialog width }
  MIN_CL_FOOTER_BASE = 415;
  { If doCommandLinks or doCommandLinkNoIcon is set in DialogOptions and the dialog has a visible expando
    then this is the minimum dialog width }
  MIN_CL_EXPANDO_BASE = 406;
  { If doCommandLinks or doCommandLinkNoIcon is set in DialogOptions then this is the minimum dialog width }
  MIN_COMMANDLINK_BASE = 360;
  { Summary
    Specifies the minimum additional width of the footer section for a
    dialog.
    Description
    This value is only used when a footer is visible on the
    dialog.                                                 }
  MIN_FOOTER_WIDTH = 27;
  { Additional dialog width if the dialog has content }
  MIN_CONTENT_WIDTH = 12;
  { Additional dialog width if the dialog has a visible Expando
    button.                                                     }
  MIN_EXPANDO_WIDTH = 18;
  { Additional dialog width if the dialog has a main instruction. }
  MIN_INSTRUCTION_WIDTH = 23;
  { Additional dialog width if the dialog has a verification check box visible }
  MIN_VERIFICATION_WIDTH = 14;

  { Specifies the minimum height for a dialog. }
  MIN_DIALOG_HEIGHT = 93;

  { Summary
    Resource name for the tdiShield Task Dialog Icon.
    Description
    The large shield icon is used in either the Header or Content section of the dialog.

    To see the shield icon in the Content section, set the MainIcon property to tdiShield.
    To see the shield icon in the Header section, make sure the Header section is visible
    using the Visible property of the Header class and set the Icon property to tdiShield. }
  JSD_SHIELD = 'JSD_SHIELD2';
  { Summary
    Resource name for the tdiShield Task Dialog Icon in the small size.
    Description
    The small shield icon is used in the footer section of a dialog. }
  JSD_SHIELD_SML = 'JSD_SHIELD_SML';

  { Constant array that contains all of the TTaskDialogIcon types
    that are loaded from the operating system.                    }
  KnownIcons = [tdiWarning, tdiError, tdiInformation, tdiConfirmation, tdiShield];

  { Default DrawText flags used when drawing text on the dialog }
  DefaultDrawFlags = DT_LEFT or DT_WORDBREAK or DT_NOPREFIX;

  { Default width of a small dialog icon }
  SMALL_ICONX = 16;
  { Default height of a small dialog icon }
  SMALL_ICONY = 16;

  { Default width of a medium dialog icon }
  MEDIUM_ICONX = 24;
  { Default height of a medium dialog icon }
  MEDIUM_ICONY = 24;

  { Default width of a large dialog icon }
  LARGE_ICONX = 32;
  { Default height of a large dialog icon }
  LARGE_ICONY = 32;

type
  { Class that holds the default font information for the various
    dialog sections.                                              }
  TJSDefaultFonts = class(TObject)
  private
    FFonts: TObjectList;
  public
    { Creates and initializes a TJSDefaultFonts instance. }
    constructor Create;
    { Destroys the TJSDefaultFonts instance and frees its memory. }
    destructor Destroy; override;
    { Returns the Font information for the TJSFontType specified. }
    function GetFont(AFontType: TJSFontType): TFont;
    { Sets the Font information for the TJSFontType specified. }
    procedure SetFont(AFontType: TJSFontType; AFont: TFont);
  end;

var
  { Global variable that allows access to the default font
    information.                                           }
  DefaultFonts: TJSDefaultFonts;

procedure RegisterFont(AFontType: TJSFontType; AFont: TFont);
begin
  DefaultFonts.SetFont(AFontType, AFont);
end;

procedure RegisterFont(AFontType: TJSFontType; const AName: string; const ASize: Integer; const AColor: TColor); overload;
var
  lFont: TFont;
begin
  lFont := TFont.Create;
  try
    if AName <> '' then
      lFont.Name := AName;
    lFont.Size := ASize;
    if AColor <> clNone then
      lFont.Color := AColor;
    RegisterFont(AFontType, lFont);
  finally
    lFont.Free;
  end;
end;

procedure RegisterFont(AFontType: TJSFontType);
var
  lFont: TFont;
begin
  lFont := TFont.Create;
  try
    RegisterFont(AFontType, lFont);
  finally
    lFont.Free;
  end;
end;

function GetRegisteredFont(AFontType: TJSFontType): TFont;
begin
  result := DefaultFonts.GetFont(AFontType);
end;

procedure ResetRegisteredFonts;
begin
  // recreate the default fonts
  DefaultFonts.Free;
  DefaultFonts := TJSDefaultFonts.Create;
end;

// This method increases the AValue parameter if the pixels per inch value of the
// current application is not 96dpi.
function AFFS(const AValue: Integer): Integer;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  result := MulDiv(AValue, Screen.PixelsPerInch, 96);
end;

const
  { Value used to calculate the horizontal margin of a dialog. }
  mcHorzMargin = 8;
  { Value used to calculate the vertical margins of a dialog. }
  mcVertMargin = 8;
  { Value used to calculate the horizontal spacing on a dialog. }
  mcHorzSpacing = 10;
  { Value used to calculate the vertical spacing of dialog
    buttons.                                               }
  mcVertSpacing = 10;
  { Value used to calculate the width of a dialog button. }
  mcButtonWidth = 50;
  { Value used to calculate the height of a dialog button. }
  mcButtonHeight = 14;
  { Value used to calculate the spacing between buttons on a dialog. }
  mcButtonSpacing = 4;

function GetIcon(const Value: TTaskDialogIcon; var AIsCustomShield: Boolean): PChar;
begin
  result := nil;
  if (Value < tdiShield) or ((Value = tdiShield) and (IsVista)) then
  begin
    AIsCustomShield := False;
    case Value of
      tdiWarning: result := MakeIntResource(MD_ICON_WARNING); // 32515
      tdiError: result := MakeIntResource(MD_ICON_ERROR); // 32513
      tdiInformation: result := MakeIntResource(MD_ICON_INFORMATION); // 32516
      tdiConfirmation: result := MakeIntResource(MD_ICON_QUESTION); // 32514
      tdiShield: result := MakeIntResource(MD_ICON_SHIELD);
    end;
  end
  else
  begin
    if Value = tdiShield then
    begin
      result := 'VISTA_SHIELD';
      AIsCustomShield := True;
    end;
  end;
end;

function IsVista: Boolean;
begin
  result := Win32MajorVersion > 5;
end;

procedure FillBackground(ACanvas: TCanvas; ARect: TRect; AColor: TColor);
begin
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(ARect);
  ACanvas.Brush.Style := bsClear;
end;

procedure SnapToDefaultButton(AButton: TControl);
var
  lSnap: Integer;
  lPt: TPoint;
begin
  if (AButton <> nil) and AButton.Visible and AButton.Enabled then
  begin
    SystemParametersInfo(SPI_GETSNAPTODEFBUTTON, 0, @lSnap, 0);
    if lSnap > 0 then
    begin
      lPt := AButton.ClientOrigin;
      Inc(lPt.X, AButton.ClientWidth div 2);
      Inc(lPt.Y, AButton.ClientHeight div 2);
      Windows.SetCursorPos(lPt.X, lPt.Y);
    end;
  end;
end;

function GetCtrlWidth(AFont: TFont; const AText: TJSString): Integer;
var
  lDC: HDC;
  lSaveFont: HFont;
  lTextSize: TSize;
begin
  lDC := GetDC(0);
  try
    lSaveFont := SelectObject(lDC, AFont.Handle);
    {$IFDEF BDS}
      {$IFDEF UNICODE}
      GetTextExtentPoint32W(lDC, PWideChar(AText), Length(AText), lTextSize);
      {$ELSE}
      if JSSupportsUnicode then
        GetTextExtentPoint32W(lDC, PWideChar(AText), Length(AText), lTextSize)
      else
      begin
        {$IFDEF FORCEUNICODE}
        GetTextExtentPoint32A(lDC, PAnsiChar(JSAnsiStringFromUnicodeWideString(AText, AFont.Charset)), Length(AText), lTextSize);
        {$ELSE}
        GetTextExtentPoint32(lDC, AText, Length(AText), lTextSize);
        {$ENDIF FORCEUNICODE}
      end;
      {$ENDIF UNICODE}
    {$ELSE}
      GetTextExtentPoint32(lDC, PChar(AText), Length(AText), lTextSize);
    {$ENDIF BDS}
    SelectObject(lDC, lSaveFont);
  finally
    ReleaseDC(0, lDC);
  end;
  result := lTextSize.cx;
end;

function GetCtrlHeight(AFontHandle: THandle): Integer;
var
  lDC: HDC;
  lSaveFont: HFont;
  lTextSize: TSize;
begin
  lDC := GetDC(0);
  try
    lSaveFont := SelectObject(lDC, AFontHandle);
    GetTextExtentPoint32(lDC, 'Text height test', Length('Text height test'), lTextSize);
    SelectObject(lDC, lSaveFont);
  finally
    ReleaseDC(0, lDC);
  end;
  result := lTextSize.cy;
end;

{$IFDEF DELPHI}
function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
begin
  Result := (Win32MajorVersion > AMajor) or
            ((Win32MajorVersion = AMajor) and
             (Win32MinorVersion >= AMinor));
end;
{$ENDIF DELPHI}

{ TJSCustomDialog }

function TJSCustomDialog.AdjustButtonBarHeight: Integer;
begin
  if (FShowMoreButton = nil) then
    CreateExpandoButton;
  if (FVerificationCheckBox = nil) then
    CreateVerificationCheckBox;
  if (FShowMoreButton <> nil) and (FVerificationCheckBox <> nil) then
    result := FShowMoreButton.Height + FVerificationCheckBox.Height + FVertSpacing + (FVertMargin * 2) + 1
  else
    result := 0;
end;

function TJSCustomDialog.AdjustSheetTopPosition(const ATop: Integer): Integer;
begin
  Result := ATop;
end;

procedure TJSCustomDialog.Assign(Source: TPersistent);
var
  lDlg: TJSDialog;
begin
  if Source is TJSDialog then
  begin
    lDlg := (Source as TJSDialog);
    FAssigning := True;
    try
      FOnGetControlClass := lDlg.OnGetControlClass;
      FOnGetMoreFileName := lDlg.OnGetMoreFileName;
      FOnInitControl := lDlg.OnInitControl;
      FOnGetMoreStream := lDlg.OnGetMoreStream;
      FOnHelpLinkClick := lDlg.OnHelpLinkClick;
      FOnControlClick := lDlg.OnControlClick;
      FOnDialogExpand := lDlg.OnDialogExpand;
      FOnDialogCollapse := lDlg.OnDialogCollapse;
      FOnGetVerificationResult := lDlg.OnGetVerificationResult;
      FOnDialogClose := lDlg.OnDialogClose;
      FOnDialogClick := lDlg.OnDialogClick;
      FOnCleanUpDialog := lDlg.OnCleanUpDialog;
      FOnDestroyed := lDlg.OnDestroyed;
      FOnCreated := lDlg.OnCreated;
      ActiveControlType := lDlg.ActiveControlType;
      BiDiMode := LDlg.BiDiMode;
      Color := lDlg.Color;
      Font := lDlg.Font;
      EmulateMessageDlg := lDlg.EmulateMessageDlg;
      Content := lDlg.Content;
      Glyph := lDlg.Glyph;
      CustomButtons := lDlg.CustomButtons;
      ButtonBar := lDlg.ButtonBar;
      RadioButtons := lDlg.RadioButtons;
      Expando := lDlg.Expando;
      Verification := lDlg.Verification;
      Footer := lDlg.Footer;
      Header := lDlg.Header;
      HelpLink := lDlg.HelpLink;
      HelpKeyword := lDlg.HelpKeyword;
      HelpType := lDlg.HelpType;
      HelpContext := lDlg.HelpContext;
      Progress := lDlg.Progress;
      Instruction := lDlg.Instruction;
      Border := lDlg.Border;
      DialogOptions := lDlg.DialogOptions;
      DialogStyle := LDlg.DialogStyle;
      MainIcon := lDlg.MainIcon;
      Title := lDlg.Title;
      UseDefaultFonts := lDlg.UseDefaultFonts;
      Location := lDlg.Location;
      Icon := lDlg.Icon;
      BorderStyle := lDlg.BorderStyle;
      AllowCancel := lDlg.AllowCancel;
      AllowMinimize := lDlg.AllowMinimize;
      Position := lDlg.Position;
      Width := lDlg.Width;
      Timer := lDlg.Timer;
      RadioButton := lDlg.RadioButton;
      Button := LDlg.Button;
      Sheet := LDlg.Sheet;
    finally
      FAssigning := False;
    end;
  end
  else
    inherited;
end;

procedure TJSCustomDialog.PositionExpandoButton;
var
  lRect: TRect;
begin
  if not FAssigning then
  begin
    if FShowMoreButton <> nil then
    begin
      lRect := GetRect(psButtonBar);
      FShowMoreButton.Top := lRect.Top + AFFS(10);

      if BiDiMode = bdLeftToRight then
        FShowMoreButton.Left := lRect.Left + AFFS(10)
      else
        FShowMoreButton.Left := FClientWidth - FShowMoreButton.Width - AFFS(10);

      if EmulateMessageDlg then
      begin
        if Verification.Visible then
          FShowMoreButton.Top := lRect.Bottom - AFFS(16)
        else
          FShowMoreButton.Top := lRect.Bottom;
      end;
      if Expando.ShowInFooter then
        FShowMoreButton.Anchors := [akLeft, akTop]
      else
        FShowMoreButton.Anchors := [akLeft, akBottom];
    end;
  end;
end;

function TJSCustomDialog.LoadLines(L: TStrings): Boolean;
var
  lFileName: TJSString;
  lStream:   TMemoryStream;
begin
  if Expando.MoreSource = msFile then
  begin
    lFileName := '';
    DoGetMoreFileName(lFileName);
    if FileExists(lFileName) then
      L.LoadFromFile(lFileName);
    Result := True;
  end
  else if Expando.MoreSource = msStream then
  begin
    lStream := TMemoryStream.Create;
    try
      DoGetMoreStream(lStream);
      lStream.Position := 0;
      L.LoadFromStream(lStream);
    finally
      lStream.Free;
    end;
    Result := True;
  end
  else
    Result := False;
end;

function TJSCustomDialog.LoadLinesW(L: TJSStrings): Boolean;
var
  lFileName: TJSString;
  lStream:   TMemoryStream;
begin
  if Expando.MoreSource = msFile then
  begin
    lFileName := '';
    DoGetMoreFileName(lFileName);
    if FileExists(lFileName) then
      L.LoadFromFile(lFileName);
    Result := True;
  end
  else if Expando.MoreSource = msStream then
  begin
    lStream := TMemoryStream.Create;
    try
      DoGetMoreStream(lStream);
      lStream.Position := 0;
      L.LoadFromStream(lStream);
    finally
      lStream.Free;
    end;
    Result := True;
  end
  else
    Result := False;
end;

procedure TJSCustomDialog.LoadStringIntoRichEdit(const AString: TJSString);
var
  LInsertStream: TStringStream;
begin
  LInsertStream := TStringStream.Create(AString);
  try
    LInsertStream.Position := 0;
    FMoreRichEdit.Lines.LoadFromStream(LInsertStream);
  finally
    LInsertStream.Free;
  end;
end;

procedure TJSCustomDialog.MoreLinesClickHandler(Sender: TObject);
begin
  DoDialogClick(Self, htExpandedSection);
end;

procedure TJSCustomDialog.PositionMoreLines;
var
  LRect: TRect;
begin
  if IsExpanded then
  begin
    if not Expando.ShowInFooter then
    begin
      LRect := GetRect(psMoreLines);
      if FMoreLinesLabel <> nil then
      begin
        FMoreLinesLabel.SetBounds(FLeftMargin, LRect.Top, FForm.ClientWidth - FRightMargin - FLeftMargin, LRect.Bottom - LRect.Top);
        FMoreLinesLabel.Visible := True;
      end;
    end
    else if Expando.MoreFormat = mfText then
    begin
      LRect := GetRect(psMoreFooter);

      Inc(lRect.Top, FVertMargin);
      Inc(lRect.Left, FHorzSpacing);
      Dec(lRect.Right, FHorzSpacing);

      if FMoreLinesLabel <> nil then
      begin
        FMoreLinesLabel.SetBounds(LRect.Left, LRect.Top, LRect.Right -
                                  LRect.Left, LRect.Bottom - LRect.Top);
        FMoreLinesLabel.Visible := True;

        if not LoadLinesW(FMoreLinesLabel.Text) then
          FMoreLinesLabel.Text.Text := Expando.Lines.Text;
      end;
    end;
  end;
end;

procedure TJSCustomDialog.PositionMoreRichEdit;
begin
  if FMoreRichEdit = nil then
    Exit;

  if FShowMoreButton.Expanded then
  begin
    FMoreRichEdit.Height := FExpando.MoreHeight;
    FMoreRichEdit.Top := FClientHeight - FVertMargin - FExpando.MoreHeight;
    FMoreRichEdit.Width := FClientWidth - (2 * FHorzSpacing);

    if not LoadLines(FMoreRichEdit.Lines) then
      LoadStringIntoRichEdit(Expando.Lines.Text);
  end;

  if FMoreRichEdit <> nil then
    FMoreRichEdit.Visible := FShowMoreButton.Expanded and
                             Expando.ShowInFooter and
                             not FExpanding and not FCollapsing;
end;

procedure TJSCustomDialog.PositionProgressBar;
var
  lRect: TRect;
  lWidth: Integer;
begin
  if FProgressBar <> nil then
  begin
    lRect := GetRect(psProgressBar);
    lWidth := FClientWidth - FLeftMargin - FRightMargin;
    FProgressBar.SetBounds(FLeftMargin, lRect.Top, lWidth, FProgressBar.Height);
  end;
end;

procedure TJSCustomDialog.ButtonClickHandler(Sender: TObject);
begin
  DoButtonClick(Sender);
end;

procedure TJSCustomDialog.CalculateAutoSize(out AHeight, AWidth: Integer; const AApply: Boolean = True);
var
  lWidth: Integer;
  lHeight: Integer;
  lRect: TRect;
  lContentHeight: Integer;
  lBtnBarWidth: Integer;
  i: Integer; // required width of button bar
  lMoreWidth: Integer;
  lVerificationWidth: Integer;
  lInstructionWidth: Integer;
  lCurrentHeight: Integer;
  lCurrentWidth: Integer;
  lCommandLinkWidth: Integer; // minimum width required for a command link button
  lClientRect: TRect;
  lAdjusted: Integer;
begin
  InitialiseMargins;
  if FForm = nil then
    exit;
  FCalcAutosizing := True;
  try
    lCurrentHeight := FForm.Height;
    lCurrentWidth := FForm.Width;

    // calculate width of dialog
    lWidth := (2 * FHorzSpacing); // margin either side
    lInstructionWidth := GetInstructionWidth;
    if lInstructionWidth < AFFS(16) then
      lInstructionWidth := GetContentWidth + 7;
    inc(lWidth, lInstructionWidth);

    if (ValidPicture(Glyph) or (MainIcon in KnownIcons)) or
       (Instruction.ShowGlyph and not Instruction.ShowAtTop and
       (ValidPicture(Instruction.Glyph) or (Instruction.Icon in KnownIcons))) then
    begin
      if ValidPicture(Glyph) then
        inc(lWidth, Glyph.Graphic.Width + FHorzSpacing)
      else if ValidPicture(Instruction.Glyph) then
        inc(lWidth, Instruction.Glyph.Graphic.Width + FHorzSpacing)
      else
        inc(lWidth, AFFS(32) + FHorzSpacing);
    end
    else
    begin
      if EmulateMessageDlg then
      begin
        if not (MainIcon in [tdiNone, tdiCustom]) then
          inc(lWidth, AFFS(32) + FHorzSpacing);
      end;
    end;

    if ButtonBar.Visible then
    begin
      if ShowCommandLinks then
      begin
        lBtnBarWidth := (2 * FHorzSpacing); // 8 pixels either size for margin
        for i := 0 to FCreatedButtonBarButtons.Count - 1 do
          inc(lBtnBarWidth, TControl(FCreatedButtonBarButtons[i]).Width + FHorzSpacing);
      end
      else
      begin
        lBtnBarWidth := (2 * FHorzSpacing); // 8 pixels either size for margin
        for i := 0 to FCreatedCustomButtons.Count - 1 do
          inc(lBtnBarWidth, TControl(FCreatedCustomButtons[i]).Width + FHorzSpacing);
        if FCreatedCustomButtons.Count > 0 then
          inc(lBtnBarWidth, FButtonSpacing);
        for i := 0 to FCreatedButtonBarButtons.Count - 1 do
          inc(lBtnBarWidth, TControl(FCreatedButtonBarButtons[i]).Width + FHorzSpacing);
      end;
      // increment width for More button
      if FExpando.Visible then
        lMoreWidth := GetShowMoreButtonWidth
      else
        lMoreWidth := 0;
      // increment width for check box option
      if FVerification.Visible then
      begin
        if FVerificationCheckBox <> nil then
          lVerificationWidth := FVerificationCheckBox.Width + FHorzSpacing
        else
          lVerificationWidth := 0;
      end
      else
        lVerificationWidth := 0;
      inc(lBtnBarWidth, Max(lMoreWidth, lVerificationWidth));
    end
    else
      lBtnBarWidth := 0;

    // make sure we are at least the minimum dialog width
    // minimum doesn't apply to emulation MessageDlg mode
    if (not FEmulateMessageDlg) then
    begin
      if Width = 0 then
      begin
        if ShowCommandLinks then
          lWidth := Max(CalculateWidth, lWidth)
        else
          lWidth := Max(MIN_DIALOG_WIDTH, lWidth);
      end
      else
        lWidth := Width;
    end
    else
      inc(lWidth, AFFS(20));

    if ShowCommandLinks then
    begin
      // make sure the width of the dialog fits in the
      // command link instruction text
      for i := 0 to FCreatedCustomButtons.Count - 1 do
      begin
        lCommandLinkWidth := TJSCommandLinkButton(FCreatedCustomButtons[i]).MinimumWidth;
        lWidth := Max(lWidth, FLeftMargin + lCommandLinkWidth + FRightMargin);
      end;
    end;

    FClientWidth := Max(lBtnBarWidth, lWidth);

    //
    if FContentMaxLines <> nil then
      Inc(FClientWidth, AFFS(8));

    // Apply WidthAdjustment value if necessary
    lAdjusted := WidthAdjustment;
    if (lAdjusted > 0) and (FClientWidth < lAdjusted) then
      FClientWidth := FClientWidth + (lAdjusted - FClientWidth);

    //////////////////////////
    //
    // calculate dialog height
    //
    //////////////////////////

    lHeight := 0;

    lRect := GetRect(psContent);
    lContentHeight := lRect.Bottom - lRect.Top;

    if lContentHeight > Screen.Height - (0.1 * Screen.Height) then
    begin
      // switch modes
      MaxLines := trunc((Screen.Height div 2) / TJSCaption.MinimumHeight(FForm.Canvas, 'One line', Font, FClientWidth - FLeftMargin - FRightMargin));
    end;

    inc(lHeight, lRect.Bottom);
    if lContentHeight > 0 then
      inc(lHeight, AFFS(9)); // spacing between content and button bar

    if ShowProgressBar then
    begin
      lRect := GetRect(psProgressBar);
      inc(lHeight, lRect.Bottom - lRect.Top);
    end;

    if IsExpanded or FExpanding then
    begin
      if not Expando.ShowInFooter then
      begin
        lRect := GetRect(psMoreLines);
        inc(lHeight, lRect.Bottom - lRect.Top);
        if lContentHeight = 0 then
          inc(lHeight, FVertMargin);
      end
      else
      begin
        if Expando.MoreFormat = mfRTF then
        begin
          inc(lHeight, FVertMargin * 2); // top and bottom margin
          inc(lHeight, FExpando.MoreHeight);
        end
        else
        begin
          lRect := GetRect(psMoreFooter);
          inc(lHeight, lRect.Bottom - lRect.Top);
        end;
      end;
    end;
    if ShowRadioButtons then
    begin
      lRect := GetRect(psRadio);
      inc(lHeight, lRect.Bottom - lRect.Top);
    end;
    if ShowCommandLinks then
    begin
      for i := 0 to FCreatedCustomButtons.Count - 1 do
      begin
        TControl(FCreatedCustomButtons[i]).Width := FClientWidth - FLeftMargin - FRightMargin;
        TControl(FCreatedCustomButtons[i]).Perform(CM_Fontchanged, 0, 0);
        inc(lHeight, TControl(FCreatedCustomButtons[i]).Height);
      end;
      inc(lHeight, FVertSpacing);
      if (Content.Text = '') and (Instruction.Text <> '') then
        inc(lHeight, AFFS(15))
      else if (Content.Text <> '') or (Instruction.Text <> '') then
        inc(lHeight, AFFS(6))
      else
        inc(lHeight, AFFS(22));
    end;

    if doShowHelpLink in FDialogOptions then
    begin
      if FHelpLinkLabel <> nil then
        inc(lHeight, FHelpLinkLabel.Height + (2 * FVertSpacing));
    end;

    // At this point the height calculated is the height of the content area (area above the button bar)
    if (MainIcon = tdiCustom) and ValidPicture(Glyph) then
    begin
      lHeight := Max(lHeight, Glyph.Graphic.Height + AFFS(5) * FVertSpacing);
    end;

    if FButtonBar.Visible then
    begin
      if FExpando.Visible and FVerification.Visible then
        inc(lHeight, Max(FButtonBarHeight, AdjustButtonBarHeight))
      else
        inc(lHeight, FButtonBarHeight);
    end
    else
    begin
      if not ShowCommandLinks and (CustomButtons.Count > 0) then
        inc(lHeight, FButtonBarHeight - FVertMargin)
      else if ShowCommandLinks then
        inc(lHeight, FVertMargin);
    end;
    if FFooter.Visible then
    begin
      inc(lHeight, GetFooterHeight);
    end;

    if not FEmulateMessageDlg and CheckMinimumHeight then
      lHeight := Max(MIN_DIALOG_HEIGHT, lHeight);

    FClientHeight := lHeight + HeightAdjustment { used by descendants} ;

    lClientRect := FForm.ClientRect;

    if AApply then
    begin
      FForm.SetBounds(FForm.Left, FForm.Top,
        FForm.Width - lClientRect.Right + FClientWidth,
        FForm.Height - lClientRect.Bottom + FClientHeight);
    end;

    AHeight := FClientHeight;
    AWidth := FClientWidth;

    FInvalidateOnPosition := (lCurrentHeight <> FForm.Height) or (lCurrentWidth <> FForm.Width);
  finally
    FCalcAutosizing := False;
  end;
end;

function TJSCustomDialog.GetCaptionHeight(AForm: TCustomForm): Integer;
begin
  Result := 0;
  if AForm = nil then
    AForm := Screen.ActiveCustomForm;
  if AForm = nil then
    Exit;
  if AForm.BorderStyle <> bsNone then
  begin
    if not (AForm.BorderStyle in [bsToolWindow, bsSizeToolWin]) then
      Result := Max(GetSystemMetrics(SM_CYCAPTION), 20)
    else
    begin
      Result := GetSystemMetrics(SM_CYCAPTION);
      if AForm.BorderStyle = bsToolWindow then
        Dec(Result, AFFS(3))
      else
        Inc(Result, AFFS(2));
    end;
    if AForm.BorderStyle = bsSizeable then
      Inc(Result, GetSystemMetrics(SM_CYFRAME))
    else
      Inc(Result, AFFS(3));
  end
  else
    Result := 0;
end;

procedure TJSCustomDialog.CalculateSheetPosition;
var
  LMonitor: TMonitor;
begin
  if Position <> dpDesigned then
    raise EDialogSheet.Create('The position property must be set to dpDesigned for the TJSDialogSheet class');
  case Sheet.Location of
    slActiveForm:
      begin
        FForm.Top := Screen.ActiveCustomForm.Top + GetCaptionHeight(Screen.ActiveCustomForm);
        FForm.Top := AdjustSheetTopPosition(FForm.Top);
        FForm.Left := Screen.ActiveCustomForm.Left + ((Screen.ActiveCustomForm.Width - FForm.Width) div 2);
      end;
    slDesktop:
      begin
        if Screen.ActiveCustomForm <> nil then
          LMonitor := Screen.ActiveCustomForm.Monitor
        else
          LMonitor := Screen.Monitors[0];
        FForm.Top := LMonitor.Top;
        FForm.Left := (LMonitor.Width - FForm.Width) div 2;
      end;
  end;
end;

function TJSCustomDialog.CalculateWidth: Integer;
begin
  result := 0;
  if Expando.Visible then
  begin
    result := MIN_CL_EXPANDO_BASE;
    if Verification.Visible then
      inc(result, MIN_VERIFICATION_WIDTH);
    if Footer.Visible then
      inc(result, MIN_FOOTER_WIDTH);
  end
  else if Verification.Visible then
  begin
    result := MIN_CL_VERIFICATION_BASE;
    if Footer.Visible then
      inc(result, MIN_FOOTER_WIDTH);
  end
  else if Footer.Visible then
    result := MIN_CL_FOOTER_BASE;
  if Instruction.Text <> '' then
    inc(result, MIN_INSTRUCTION_WIDTH);
  if Content.Text <> '' then
    inc(result, MIN_CONTENT_WIDTH);
  result := Max(MIN_COMMANDLINK_BASE, result);
end;

function TJSCustomDialog.CanUpdateProgress: Boolean;
begin
  result := (doProgressBar in DialogOptions) and (FProgressBar <> nil);
end;

procedure TJSCustomDialog.CheckBoxClickHandler(Sender: TObject);
begin
  FVerificationResult := TJSCheckBox(Sender).Checked;
  DoVerificationClick(FVerificationResult); 
end;

function TJSCustomDialog.CheckMinimumHeight: Boolean;
begin
  result := True;
end;

procedure TJSCustomDialog.ContentChangeHandler(Sender: TObject);
var
  lOldHeight: Integer;
  LHeight: Integer;
  LWidth: Integer;
begin
  if FInitialisingFonts then
    exit;
  if not (FCalcLayout) and (not FAssigning) then
  begin
    if FForm <> nil then
    begin
      lOldHeight := FClientHeight;
      CalculateAutoSize(LHeight, LWidth);
      PositionControls;
      if lOldHeight = FClientHeight then
      begin
        Canvas.Font.Assign(Font);
        if EmulateMessageDlg then
          Canvas.Brush.Color := clBtnFace
        else
          Canvas.Brush.Color := Color;
        Canvas.Brush.Style := bsSolid;
        if FContentLabel <> nil then
        begin
          FContentLabel.Color := Canvas.Brush.Color;
          FContentLabel.Invalidate;
        end;
        if FContentMaxLines <> nil then
        begin
          TMemo(FContentMaxLines).Color := Canvas.Brush.Color;
          FContentMaxLines.Invalidate;
        end;
      end
      else
        FForm.Invalidate;
    end;
  end;
end;

procedure TJSCustomDialog.ContentClickHandler(Sender: TObject);
begin
  DoDialogClick(Self, htContent);
end;

function TJSCustomDialog.ContentLineWidth(const ALine: string): Integer;
begin
  Result := HorzPadding + TJSCustomDialog.RequiredWidth(ALine, ftContent);
end;

procedure TJSCustomDialog.CleanUpDialog;
begin
  FTaskBarProgressImpl := nil;
  FreeAndNil(FCreatedRadioButtons);
  FreeAndNil(FCreatedCustomButtons);
  FreeAndNil(FCreatedButtonBarButtons);
  FreeAndNil(FProgressBar);
  FreeAndNil(FHelpLinkLabel);
  FreeAndNil(FShowMoreButton);
  FreeAndNil(FVerificationCheckBox);
  FreeAndNil(FMoreRichEdit);
  FreeAndNil(FFooterLabel);
  FreeAndNil(FInstructionLabel);
  FreeAndNil(FContentLabel);
  FreeAndNil(FMoreLinesLabel);
  FreeAndNil(FContentMaxLines);
end;

function TJSCustomDialog.Close(const AModalResult: Integer): Integer;
begin
  if FForm <> nil then
  begin
    FDialogResult.ModalResult := AModalResult;
    ModalResult := AModalResult;
    Progress.Position := FPreviousProgressPosition;
    FButtonClicked := True;
    FForm.Close;
    if not (doModal in DialogOptions) then
      FreeAndNil(FForm);
    result := FDialogResult.ModalResult;
  end
  else
    result := -1;
end;

procedure TJSCustomDialog.CMFontchanged(var Message: TMessage);
begin
  // once the font has been changed, set the
  // UseDefaultFonts property accordingly
  if not (csLoading in ComponentState) then
    FUseDefaultFonts := False;
end;

constructor TJSCustomDialog.Create(AOwner: TComponent);
begin
  inherited;
  FIgnoreSnapTo := False;
  FActiveControlType := ctButton;
  FUseOldStyleSetting := True;
  FFirstButtonLeftPos := -1;
  FWidthOfLastCommonButton := 0;
  FVerificationResult := False;
  FCreatedRadioButtons := nil;
  FCreatedCustomButtons := nil;
  FCreatedButtonBarButtons := nil;
  FDefaultMonitor := dmActiveForm;
  FBorderStyle := bsDialog;
  FAllowMinimize := False;
  FAllowCancel := True;
  FPosition := dpScreenCenter;
  FHelpContext := 0;
  FHelpType := htContext;
  FExpanding := False;
  FCollapsing := False;
  FFocusedControl := nil;
  FCalcAutosizing := False;
  FFont := TFont.Create;
  FOldFontChanged := Font.OnChange;
  Font.OnChange := NewFontChanged;
  FDialogOptions := [doModal];
  FDialogStyle := dsDialog;
  FForm := nil;
  FVerificationCheckBox := nil;
  FShowMoreButton := nil;
  FMoreRichEdit := nil;
  FContent := TJSWideStringList.Create;
  FInstruction := TJSInstruction.Create(Self);
  FVerification := TJSVerification.Create(Self);
  FGlyph := TPicture.Create;
  Font.Assign(DefaultFonts.GetFont(ftContent));
  FExpando := TJSExpando.Create(Self);
  FExpando.Font.Assign(Font);
  FRightMargin := AFFS(10);
  FVertSpacing := AFFS(DEF_VERTSPACING);
  FVertMargin := AFFS(DEF_VERTMARGIN);
  FHorzSpacing := AFFS(DEF_HORZSPACING);
  FButtonSpacing := AFFS(DEF_BUTTONSPACING);
  FRadioButtons := TJSRadioButtons.Create(Self, TJSRadioButtonItem);
  FCustomButtons := TJSCustomButtons.Create(Self, TJSCustomButtonItem);
  FButtonBarHeight := AFFS(41);
  FButtonBar := TJSButtonBarOptions.Create(Self);
  FButton := TJSButtonOptions.Create(Self);
  FFooter := TJSFooter.Create(Self);
  FHeader := TJSHeader.Create(Self);
  FMainIcon := tdiNone;
  FHelpLink := TJSHelpLink.Create(Self);
  EmulateMessageDlg := False;
  FProgress := TJSProgress.Create(Self);
  FBorder := TJSBorder.Create(Self);
  FShowMoreButtonWidth := -1;
  FBackground := TJSBackground.Create(Color, nil, EmptyRect, True, False); // must be initialized before Color assignment
  Color := clWindow;
  FLocation := TJSLocation.Create;
  FUseDefaultFonts := True;
  FTimer := TJSTimer.Create(Self);
  FRadioButton := TJSRadioButton.Create(Self);
  FSheet := TJSSheetOptions.Create(Self);
  // assign OnChange handlers for properties
  FInstruction.OnChange := InstructionChangeHandler;
  TJSWideStringList(FContent).OnChange := ContentChangeHandler;
  FVerification.OnChange := VerificationChangeHandler;
  FExpando.OnChange := ExpandoChangedHandler;
  FFooter.OnChange := FooterChange;
  FHeader.OnChange := FooterChange;
  FHeader.Font.OnChange := HeaderFontChange;
  FProgress.OnChange := ProgressChangeHandler;
  FTimer.OnChange := TimerChangeHandler;
  FGlyph.OnChange := GlyphChangeHandler;
  FIcon := TIcon.Create;
  FBiDiMode := bdLeftToRight;
  FPlaySounds := True;
  FMaxLines := 0;
end;

function CommonButtonCaptions(const ABtn: TCommonButton): TJSString;
begin
  case ABtn of
    cbYes: result := GetTranslatedString(sBtnYes);
    cbNo: result := GetTranslatedString(sBtnNo);
    cbOK: result := GetTranslatedString(sBtnOK);
    cbCancel: result := GetTranslatedString(sBtnCancel);
    cbAbort: result := GetTranslatedString(sBtnAbort);
    cbRetry: result := GetTranslatedString(sBtnRetry);
    cbIgnore: result := GetTranslatedString(sBtnIgnore);
    cbAll: result := GetTranslatedString(sBtnAll);
    cbNoToAll: result := GetTranslatedString(sBtnNoToAll);
    cbYesToAll: result := GetTranslatedString(sBtnYesToAll);
    cbHelp: result := GetTranslatedString(sBtnHelp);
    cbClose: result := GetTranslatedString(sBtnClose);
  else
    result := '';
  end;
end;

const
  { Internal button names of the common buttons. Doing a
    FindComponent call for a common button should return a valid
    reference to the common button.
    keywords: TCommonButtons;TCommonButton;TJSButtonBarOptions;ButtonBar}
  CommonButtonNames: array[TCommonButton] of string = (
    'bYes', 'bNo', 'bOK', 'bCancel', 'bAbort', 'bRetry', 'bIgnore', 'bAll', 'bNoToAll',
    'bYesToAll', 'bHelp', 'bClose');

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do
    Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do
    Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

var
  ButtonWidths: array[TCommonButton] of integer;  // initialized to zero

{$IFNDEF DELPHI2009}
const
  mrClose = 11;
{$ENDIF DELPHI2009}

function CommonButtonToModalResult(const aCommonButton: TCommonButton): TModalResult; {$IFDEF INLINE}inline;{$ENDIF}
begin
  case aCommonButton of
    cbCancel: result := mrCancel;
    cbOK: result := mrOK;
    cbNo: result := mrNo;
    cbYes: result := mrYes;
    cbIgnore: result := mrIgnore;
    cbRetry: result := mrRetry;
    cbAbort: result := mrAbort;
    cbAll: result := mrAll;
    cbNoToAll: result := mrNoToAll;
    cbYesToAll: result := mrYesToAll;
    cbHelp: result := mrNone;
    cbClose: result := mrClose;
  else
    result := mrNone;
  end;
end;

type
  TControlCracker = class(TControl);

const
  { Summary
    Specifies the adjustment value for a buttons height when
    placed on a dialog.
    Description
    The value is required due to Vista dialog layouts being
    different to other operating system layouts.             }
  AdjBtnHeight: array [Boolean] of Integer = (0, 3);
  { Summary
    Specifies the adjustment value for a buttons width when
    placed on a dialog.
    Description
    The value is required due to Vista dialog layouts being
    different to other operating system layouts.            }
  AdjBtnWidth: array [Boolean] of Integer = (0, 7);

procedure TJSCustomDialog.CreateButtonBarButtons;
var
  lRect: TRect;
  lCommonBtn: TCommonButton;
  lDialogUnits: TPoint;
  lButtonHeight: Integer;
  LPerformAdjustment: Boolean;
begin
  FCreatedButtonBarButtons := TObjectList.Create(True);

  // only create ButtonBar buttons when visible
  if not ButtonBar.Visible then
    Exit;

  lRect := GetRect(psButtonBar);
  if FCreatedButtonBarButtons.Count = 0 then
  begin
    Canvas.Font.Assign(Font);
    if IsVista and (Canvas.Font.Size < 9) then
      Canvas.Font.Size := 9;
    lDialogUnits := GetAveCharSize(Canvas);
    LPerformAdjustment := IsVista{$IFDEF THEMES} and {$IFNDEF DELPHIXE2}(ThemeServices.ThemesEnabled){$ELSE}StyleServices.Enabled{$ENDIF}{$ENDIF THEMES};
    lButtonHeight := MulDiv(mcButtonHeight, lDialogUnits.Y, 8) - AdjBtnHeight[LPerformAdjustment];
    for lCommonBtn := low(TCommonButton) to high(TCommonButton) do
    begin
      if lCommonBtn in FButtonBar.Buttons then
      begin
        CreateCommonButton(lCommonBtn, lDialogUnits, lButtonHeight);
      end;
    end;
    // Only possible to swap buttons when there are at least two buttons present
    if FCreatedButtonBarButtons.Count > 1 then
    begin
      // If the dialog has a Close and Help button, make sure the Help button is the
      // right most button on the dialog.
      if (FButtonBar.Buttons * [cbClose, cbHelp] = [cbClose, cbHelp]) then
        FCreatedButtonBarButtons.Move(FCreatedButtonBarButtons.Count - 1, FCreatedButtonBarButtons.Count - 2);
    end;
  end;
end;

procedure TJSCustomDialog.CreateControls;
begin
  CreateInstruction;
  CreateContent;
  CreateHeader;
  CreateProgressBar;
  CreateHelpLinkLabel;
  CreateRadioButtons;
  if ShowCommandLinks then
  begin
    CreateCustomButtons;
    CreateEditControls;
  end
  else
  begin
    CreateEditControls;
    CreateCustomButtons;
  end;
  CreateButtonBarButtons;
  CreateExpandoButton;
  CreateVerificationCheckBox;
  CreateFooter;
  CreateMoreLines;
  CreateMoreInFooter;
end;

function GetButtonWidth(AForm: TCustomForm; ACanvas: TCanvas; AFont: TFont;
  ACaption: TJSString; ADialogUnits: TPoint; out ADefButtonWidth,
  AButtonWidth: Integer): Boolean;
var
  lCalcRect: TRect;
  lFlags: LongInt;
begin
  Result := IsVista{$IFDEF THEMES} and {$IFNDEF DELPHIXE2}(ThemeServices.ThemesEnabled){$ELSE}StyleServices.Enabled{$ENDIF}{$ENDIF THEMES};

  ADefButtonWidth := MulDiv(mcButtonWidth, ADialogUnits.X, 4) - AdjBtnWidth[Result];
  lCalcRect := Rect(0, 0, 0, 0);
  lFlags := DT_CALCRECT or DT_LEFT or DT_SINGLELINE or AForm.DrawTextBiDiModeFlagsReadingOnly;

  ACanvas.Font := AFont;
  JSDrawText(ACanvas.Handle, ACaption, AFont, lCalcRect, lFlags, True);
  AButtonWidth := lCalcRect.Right - lCalcRect.Left + 16;
end;

procedure TJSCustomDialog.CreateCustomButtons;
var
  i: Integer;
  lBtn: TControl;
  lBtnItem: TJSCustomButtonItem;
  lBtnWidth: Integer;
  lBtnHeight: Integer;
  lDialogUnits: TPoint;
  LPerformAdjustment: Boolean;
  lDefBtnWidth: Integer;
begin
  if not ButtonBar.Visible and not ShowCommandLinks then
    Exit;
  FCreatedCustomButtons := TObjectList.Create(False);

  if FCreatedCustomButtons.Count = 0 then
  begin
    for i := 0 to CustomButtons.Count - 1 do
    begin
      lBtnItem := CustomButtons.Items[i];
      if lBtnItem.Visible then
      begin
        if ShowCommandLinks then
          lBtn := DoGetControlClass(ctCommandLink).Create(FForm)
        else
          lBtn := DoGetControlClass(ctButton).Create(FForm);
        lBtn.Parent := FForm;
        lBtn.Hint := lBtnItem.Hint;
        lBtn.Tag := lBtnItem.Value;
        if Expando.Visible and not Expando.ShowInFooter then
        begin
          if ShowCommandLinks then
            lBtn.Anchors := [akLeft, akBottom, akRight]
          else
            lBtn.Anchors := [akBottom, akRight];
        end;
        if ShowCommandLinks then
        begin
          DoInitControl(ctCommandLink, lBtn, lBtnItem);
          TJSCommandLinkButton(lBtn).Info := lBtnItem.Info;
          TJSCommandLinkButton(lBtn).ShowIcon := not (doCommandLinksNoIcon in FDialogOptions);
          TJSCommandLinkButton(lBtn).ElevationRequired := lBtnItem.ElevationRequired;
          TJSCommandLinkButton(lBtn).Picture := lBtnItem.Picture;
          TJSCommandLinkButton(lBtn).Hint := lBtnItem.Hint;
          TJSCommandLinkButton(lBtn).CommandLinkColors.Assign(Button.CommandLinkColors);
          {$IFDEF DELPHIXE2}
          if StyleServices.Enabled then
            TJSCommandLinkButton(lBtn).Color := StyleServices.GetSystemColor(Color);
          {$ENDIF DELPHIXE2}
          if (lBtnItem.PictureIndex > -1) and (lBtnItem.FOwner.PictureImages <> nil) then
          begin
            TJSCommandLinkButton(lBtn).PictureIndex := lBtnItem.PictureIndex;
            TJSCommandLinkButton(lBtn).PictureImages := lBtnItem.FOwner.PictureImages;
          end;
        end
        else
        begin
          DoInitControl(ctButton, lBtn, lBtnItem);
          TControlCracker(lBtn).OnClick := ButtonClickHandler;
          if lBtnItem.Default then
          begin
            if lBtn is TWinControl then
              FFocusedControl := lBtn as TWinControl;
            FDefaultButton := lBtn;
          end;
          Canvas.Font.Assign(Font);
          if IsVista and (Canvas.Font.Size < 9) then
            Canvas.Font.Size := 9;

          lDialogUnits := GetAveCharSize(Canvas);
          LPerformAdjustment := GetButtonWidth(FForm, Canvas, Font, lBtnItem.Caption, lDialogUnits, lDefBtnWidth, lBtnWidth);

          if (lBtn is TBitBtn) then
          begin
            if not (lBtn as TBitBtn).Glyph.Empty then
              inc(lBtnWidth, (lBtn as TBitBtn).Glyph.Width + (lBtn as TBitBtn).Spacing);
          end
          else
          begin
            if lBtnItem.ElevationRequired then
              inc(lBtnWidth, 20);
          end;

          lBtnHeight := MulDiv(mcButtonHeight, lDialogUnits.Y, 8) - AdjBtnHeight[LPerformAdjustment];
          lBtn.Width := Max(lDefBtnWidth, lBtnWidth);
          lBtn.Height := lBtnHeight;
        end;
        FCreatedCustomButtons.Add(lBtn);
      end;
    end;
  end;
end;

procedure TJSCustomDialog.CreateFooter;
begin
  if (FFooterLabel = nil) and (Footer.Text <> '') then
  begin
    GetRect(psFooter);
    FFooterLabel := TJSCaptionControl.Create(nil);
    FFooterLabel.Parent := FForm;
    FFooterLabel.Name := JSDIALOG_CTRL_FOOTER;
    FFooterLabel.Font := FFooter.Font;
    FFooterLabel.LinkFont.Size := FFooterLabel.Font.Size;
    FFooterLabel.Color := Footer.Color;
    FFooterLabel.Text.Text := FFooter.Text;
    FFooterLabel.OnClick := FooterClickHandler;
  end;
end;

procedure TJSCustomDialog.CreateHeader;
begin

end;

procedure TJSCustomDialog.CreateHelpLinkLabel;
var
  LHeight: Integer;
begin
  if doShowHelpLink in DialogOptions then
  begin
    if FHelpLinkLabel = nil then
    begin
      FHelpLinkLabel := TJSCaptionControl.Create(Self);
      FHelpLinkLabel.Parent := FForm;
      FHelpLinkLabel.Name := JSDIALOG_CTRL_HELPLINK;
      FHelpLinkLabel.AutoSize := False;
      if not (csDesigning in ComponentState) then
        FHelpLinkLabel.OnClick := HelpLinkLabelClickHandler;
      FHelpLinkLabel.Font := HelpLink.Font;
      FHelpLinkLabel.LinkFont := HelpLink.Font;
      FHelpLinkLabel.TreatAsLink := True;
      if FExpando.Visible and not FExpando.ShowInFooter then
        FHelpLinkLabel.Anchors := [akLeft, akBottom, akRight];
//      FHelpLinkLabel.LinkFont.Size := FHelpLinkLabel.Font.Size;
    end;
    if FClientWidth <= 0 then
      LHeight := AFFS(13)
    else
      LHeight := TJSCaption.MinimumHeight(FForm.Canvas, HelpLink.Text, HelpLink.Font, FClientWidth - FHorzSpacing - LeftMargin);
    FHelpLinkLabel.Height := Max(LHeight, AFFS(13));
    FHelpLinkLabel.Text.Text := HelpLink.Text;
    FHelpLinkLabel.Color := Color;
    FHelpLinkLabel.HelpContext := HelpLink.HelpContext;
    {$IFNDEF DELPHI5}
    FHelpLinkLabel.HelpKeyword := HelpLink.HelpKeyword;
    FHelpLinkLabel.HelpType := HelpLink.HelpType;
    {$ENDIF DELPHI5}
    GetRect(psInstruction);
  end
  else
    FreeAndNil(FHelpLinkLabel);
end;

procedure TJSCustomDialog.CreateInstruction;
begin
  if (FInstructionLabel = nil) and (Instruction.Text <> '') then
  begin
    GetRect(psFooter);
    FInstructionLabel := TJSCaptionControl.Create(nil);
    FInstructionLabel.Parent := FForm;
    FInstructionLabel.Name := JSDIALOG_CTRL_INSTRUCTION;
    FInstructionLabel.Font := Instruction.Font;
    FInstructionLabel.LinkFont.Size := FInstructionLabel.Font.Size;
    if Instruction.ShowAtTop and (Instruction.Color <> clNone) then
      FInstructionLabel.Color := Instruction.Color
    else
      FInstructionLabel.Color := Color;
    FInstructionLabel.Text.Text := Instruction.Text;
    FInstructionLabel.OnClick := InstructionClickHandler;
  end;
end;

procedure TJSCustomDialog.CreateContent;
begin
  if (FContentLabel = nil) and (FContentMaxLines = nil) then
  begin
    GetRect(psFooter);
    if (MaxLines > 0) and (Content.Count > MaxLines) then
    begin
      FContentMaxLines := TMemo.Create(nil);
      FContentMaxLines.Parent := FForm;
      FContentMaxLines.Name := JSDIALOG_CTRL_CONTENTMEMO;
      TMemo(FContentMaxLines).Font := Font;
      TMemo(FContentMaxLines).Color := Color;
      TMemo(FContentMaxLines).Lines.Assign(Content);
      TMemo(FContentMaxLines).ReadOnly := True;
      TMemo(FContentMaxLines).ScrollBars := ssVertical;
    end
    else
    begin
      FContentLabel := TJSCaptionControl.Create(nil);
      FContentLabel.Parent := FForm;
      FContentLabel.Name := JSDIALOG_CTRL_CONTENT;
      FContentLabel.Font := Font;
      FContentLabel.LinkFont.Size := Font.Size;
      FContentLabel.Color := Color;
      FContentLabel.Text.Text := Content.Text;
      FContentLabel.OnClick := ContentClickHandler;
    end;
  end;
end;

procedure TJSCustomDialog.CreateEditControls;
begin
  //
end;

procedure TJSCustomDialog.CreateExpandoButton;
begin
  if FExpando.Visible then
  begin
    if FShowMoreButton = nil then
    begin
      FShowMoreButton := TJSMoreLabel.Create(Self);
      FShowMoreButton.Parent := FForm;
      FShowMoreButton.Name := JSDIALOG_CTRL_EXPANDO;
      FShowMoreButton.Font := Font;
      if not FExpando.ShowInFooter then
        FShowMoreButton.Anchors := [akBottom, akLeft];
      FShowMoreButton.OnCollapsed := ShowMoreButtonCollapsedHandler;
      FShowMoreButton.OnExpanded := ShowMoreButtonExpandedHandler;
    end;
    FShowMoreButton.Color := FButtonBar.Color;
    if FExpando.Showing then
    begin
      FShowMoreButton.Caption := FExpando.HideText;
      FShowMoreButton.Expanded := True;
    end
    else
    begin
      FShowMoreButton.Caption := FExpando.ShowText;
      FShowMoreButton.Expanded := False;
    end;
  end;
  if (FShowMoreButton <> nil) then
    FShowMoreButton.Visible := FExpando.Visible and ButtonBar.Visible;
end;

procedure TJSCustomDialog.CreateMoreInFooter;
begin
  if Expando.Visible and Expando.ShowInFooter and (Expando.MoreFormat = mfRTF) then
  begin
    if FMoreRichEdit = nil then
    begin
      FMoreRichEdit := TJSRichEdit.Create(Self);
      FMoreRichEdit.Parent := FForm;
      FMoreRichEdit.Name := JSDIALOG_CTRL_RICHEDIT;
      FMoreRichEdit.Height := FExpando.MoreHeight;
      FMoreRichEdit.Left := FHorzSpacing;
      FMoreRichEdit.ReadOnly := True;
      FMoreRichEdit.ScrollBars := FExpando.MoreScrollbars;
      FMoreRichEdit.Visible := False;
      DoInitControl(ctRichEdit, FMoreRichEdit, nil);
    end;
  end;
end;

procedure TJSCustomDialog.CreateMoreLines;
begin
  if (FMoreLinesLabel = nil) then
  begin
    FMoreLinesLabel := TJSCaptionControl.Create(nil);
    FMoreLinesLabel.Parent := FForm;
    FMoreLinesLabel.Name := JSDIALOG_CTRL_MORELINES;
    FMoreLinesLabel.Font := Font;
    FMoreLinesLabel.LinkFont.Size := Font.Size;
    if Expando.ShowInFooter and (Expando.MoreFormat = mfText) then
      FMoreLinesLabel.Color := ButtonBar.Color
    else
      FMoreLinesLabel.Color := Color;
    FMoreLinesLabel.Visible := False;
    FMoreLinesLabel.OnClick := MoreLinesClickHandler;
  end;
end;

procedure TJSCustomDialog.CreateProgressBar;
begin
  if ShowProgressBar then
  begin
    if FProgressBar = nil then
    begin
      FProgressBar := DoGetControlClass(ctProgressBar).Create(FForm);
      FProgressBar.Parent := FForm;
      FProgressBar.Name := JSDIALOG_CTRL_PROGRESSBAR;
      FProgressBar.Left := FHorzSpacing * 2;
      DoInitControl(ctProgressBar, FProgressBar, nil);
      FProgressBar.Visible := ShowProgressBar;
      if FExpando.Visible and not FExpando.ShowInFooter then
        FProgressbar.Anchors := [akLeft, akBottom, akRight];
    end;
  end;
end;

procedure TJSCustomDialog.CreateRadioButtons;
var
  i: Integer;
  lBtn: TControl;
  lRect: TRect;
  lRadioItem: TJSRadioButtonItem;
begin
  if not (doRadioButtons in FDialogOptions) then
    exit;
  lRect := GetRect(psRadio);
  if FCreatedRadioButtons = nil then
  begin
    FCreatedRadioButtons := TObjectList.Create(False);
    if RadioButton.ShowBorder then
    begin
      FRadioGroup := DoGetControlClass(ctRadioGroup).Create(FForm);
      FRadioGroup.Parent := FForm;
      FRadioGroup.Name := JSDIALOG_CTRL_RADIOGROUP;
      if FExpando.Visible and not FExpando.ShowInFooter then
        FRadioGroup.Anchors := [akLeft, akBottom, akRight];
      if FRadioGroup is TRadioGroup then
      begin
        TRadioGroup(FRadioGroup).Caption := RadioButton.Caption;
        TRadioGroup(FRadioGroup).Columns := RadioButton.Columns;
        for i := 0 to RadioButtons.Count - 1 do
        begin
          lRadioItem := RadioButtons.Items[i];
          TRadioGroup(FRadioGroup).Items.Add(lRadioItem.Caption);
          TRadioGroup(FRadioGroup).Controls[TRadioGroup(FRadioGroup).Items.Count - 1].Tag := lRadioItem.Value;
          TRadioGroup(FRadioGroup).Controls[TRadioGroup(FRadioGroup).Items.Count - 1].Name := 'rb' + IntToStr(lRadioItem.Value);
          if lRadioItem.Checked then
            TRadioGroup(FRadioGroup).ItemIndex := (FRadioGroup as TRadioGroup).Items.Count - 1;
        end;
        TRadioGroup(FRadioGroup).OnClick := RadioButtonClickHandler;
      end
      else
      begin
        DoInitControl(ctRadioGroup, FRadioGroup, nil);
      end;
    end
    else
    begin
      for i := 0 to RadioButtons.Count - 1 do
      begin
        lRadioItem := RadioButtons.Items[i];
        lBtn := DoGetControlClass(ctRadioButton).Create(FForm);
        lBtn.Parent := FForm;
        lBtn.Tag := lRadioItem.Value;
        DoInitControl(ctRadioButton, lBtn, lRadioItem);
        lBtn.Name := 'rb' + IntToStr(lBtn.Tag);
        FCreatedRadioButtons.Add(lBtn);
        lBtn.Width := FClientWidth - FLeftMargin - AFFS(8) - FRightMargin;
        if FExpando.Visible and not FExpando.ShowInFooter then
          lBtn.Anchors := [akLeft, akBottom, akRight];
      end;
    end;
  end;
end;

procedure TJSCustomDialog.CreateVerificationCheckBox;
begin
  if FVerification.Visible then
  begin
    if (FVerificationCheckBox = nil) then
    begin
      FVerificationCheckBox := DoGetControlClass(ctCheckBox).Create(FForm);
      FVerificationCheckBox.Parent := FForm;
      FVerificationCheckBox.Name := JSDIALOG_CTRL_VERIFICATION;
      if FExpando.Visible and not FExpando.ShowInFooter then
        FVerificationCheckBox.Anchors := [akLeft, akBottom];
    end;
    DoInitControl(ctCheckBox, FVerificationCheckBox, nil);
  end;
  if (FVerificationCheckBox <> nil) then
    FVerificationCheckBox.Visible := FVerification.Visible and FButtonBar.Visible;
end;

{$IFDEF JSDEBUG}
procedure TJSCustomDialog.DEBUG_ActiveControlChangeHandler(Sender: TObject);
begin
  if FForm = nil then
    Exit;
  if Screen.ActiveControl = nil then
    Exit;
  FForm.Caption := Format('%s: %s', [Screen.ActiveControl.Name, Screen.ActiveControl.ClassName]);
end;
{$ENDIF JSDEBUG}

procedure TJSCustomDialog.DefaultRadioButton(const aIndex: Integer);
var
  i: Integer;
begin
  if RadioButtons.Count >= aIndex then
  begin
    // Have to iterate over all RadioButtonItems to make sure that
    // only one Radio Button has its checked property set.
    for i := 0 to RadioButtons.Count - 1 do
    begin
      TJSRadioButtonItem(RadioButtons.Items[i]).Checked := (i = aIndex);
    end;
  end;
end;

destructor TJSCustomDialog.Destroy;
begin
  // During normal processing, the internal form used to display the dialog should be automatically destroyed.
  // If it is not, it is due to the following circumstances:
  //   * Dialog is non-modal
  //   * The owner of the component is different to the owner of the dialog
  //   * The owner of the dialog is nil
  if (FForm <> nil) then
  begin
    FreeAndNil(FForm);
  end;
  FreeAndNil(FCustomButtons);
  FreeAndNil(FVerification);
  FreeAndNil(FExpando);
  FreeAndNil(FHeader);
  FreeAndNil(FButtonBar);
  FreeAndNil(FRadioButtons);
  FreeAndNil(FFooter);
  FreeAndNil(FHelpLink);
  FreeAndNil(FContent);
  FreeAndNil(FInstruction);
  FreeAndNil(FGlyph);
  FreeAndNil(FProgress);
  FreeAndNil(FBorder);
  FreeAndNil(FFont);
  FreeAndNil(FLocation);
  FreeAndNil(FIcon);
  FreeAndNil(FTimer);
  FreeAndNil(FBackground);
  FreeAndNil(FRadioButton);
  FreeAndNil(FShowMoreButton);
  FreeAndNil(FButton);
  FreeAndNil(FSheet);
  if (FForm <> nil) and (FForm is TJSTaskDialogForm) then
    TJSTaskDialogForm(FForm).Dialog := nil;
  FForm := nil;
  inherited;
end;

procedure TJSCustomDialog.DialogClientClickHandler(Sender: TObject; const APt: TPoint);
var
  LHitTest: TJSDialogHitTest;
  LPt: TPoint;
begin
  LPt := FForm.ScreenToClient(APt);
  LHitTest := GetHitTest(LPt);
  DoDialogClick(Sender, LHitTest);
end;

procedure TJSCustomDialog.DialogCloseHandler(Sender: TObject; var Action: TCloseAction);
begin
  DoDialogClose(Sender);
end;

procedure TJSCustomDialog.DialogCloseQueryHandler(Sender: TObject; var CanClose: Boolean);
begin
  DoDialogCloseQuery(Sender, CanClose);
end;

procedure TJSCustomDialog.DialogDestroyHandler(Sender: TObject);
begin
  DoCleanUpDialog;
  DoDestroyed;
end;

procedure TJSCustomDialog.DialogKeyUpHandler(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  DoKeyPressHandler(Key, Shift);
end;

procedure TJSCustomDialog.DialogShowHandler(Sender: TObject);
var
  lActiveCtrl: TWinControl;
  lSound: string;
  lFlags: Cardinal;
begin
  // Only setup the active control and snap to the default button if the dialog is a true dialog,
  // or if the dialog is a sheet, then it must be a modal sheet.
  if (DialogStyle = dsDialog) or ((DialogStyle = dsSheet) and (doModal in DialogOptions)) then
  begin
    lActiveCtrl := GetActiveControl;
    // if lActiveCtrl is nil, then a Focus message is
    // being Posted to a specific control
    if (lActiveCtrl <> nil) and (lActiveCtrl.CanFocus) then
      FForm.ActiveControl := lActiveCtrl;
    if (not FIgnoreSnapTo) and not (dsPreview in FDialogState) then
      PostMessage(FForm.Handle, WM_PERFORMSNAPTO, 0, 0);
  end;
  if PlaySystemSounds{ and not (dsPreview in FDialogState)} then
  begin
    lFlags := SND_ASYNC or SND_NODEFAULT or SND_NOSTOP;
    lSound := GetSystemSound(MainIcon, lFlags);
    sndPlaySound(PChar(lSound), lFlags);
  end;
  DoDialogShow;
end;

procedure TJSCustomDialog.EnableButton(const AValue: Integer; const AEnabled: Boolean);
var
  lBtnIndex: Integer;
begin
  if AValue < BASE_CUSTOMBUTTON then
  begin
    for lBtnIndex := 0 to FCreatedButtonBarButtons.Count - 1 do
    begin
      if TControl(FCreatedButtonBarButtons[lBtnIndex]).Tag = AValue then
      begin
        TControl(FCreatedButtonBarButtons[lBtnIndex]).Enabled := AEnabled;
        break;
      end;
    end;
  end
  else
  begin
    if (FCreatedCustomButtons <> nil) and (FCreatedCustomButtons.Count > 0) then
    begin
      lBtnIndex := -1;
      if (AValue - BASE_CUSTOMBUTTON < FCreatedCustomButtons.Count) and
        (AValue - BASE_CUSTOMBUTTON >= 0) then
      begin
        // Is this a valid button
        lBtnIndex := AValue - BASE_CUSTOMBUTTON;
      end;
      if lBtnIndex > -1 then
        TControl(FCreatedCustomButtons[lBtnIndex]).Enabled := AEnabled;
    end;
  end;
end;

procedure TJSCustomDialog.EnableRadioButton(const aValue: Integer; const aEnabled: Boolean);
var
  lBtnIndex: Integer;
begin
  if aValue < BASE_RADIOBUTTON then
  begin
    for lBtnIndex := 0 to FCreatedRadioButtons.Count - 1 do
    begin
      if TControl(FCreatedRadioButtons[lBtnIndex]).Tag = AValue then
      begin
        TControl(FCreatedRadioButtons[lBtnIndex]).Enabled := aEnabled;
        break;
      end;
    end;
  end
  else
  begin
    if (FCreatedRadioButtons <> nil) and (FCreatedRadioButtons.Count > 0) then
    begin
      lBtnIndex := -1;
      if (aValue - BASE_RADIOBUTTON < FCreatedRadioButtons.Count) and
        (aValue - BASE_RADIOBUTTON >= 0) then
      begin
        // Is this a valid radio button
        lBtnIndex := aValue - BASE_RADIOBUTTON;
      end;
      if lBtnIndex > -1 then
        TControl(FCreatedRadioButtons[lBtnIndex]).Enabled := aEnabled;
    end;
  end;
end;

procedure TJSCustomDialog.DoButtonClick(Sender: TObject);
var
  lHandled: Boolean;
begin
  if FVerificationCheckBox <> nil then
    VerificationResult := DoGetVerificationResult
  else
    VerificationResult := False;
  lHandled := False;
  if SameText(Sender.ClassName, DoGetControlClass(ctButton).ClassName) and
    (TControl(Sender).Tag <= mrYesToAll) then
  begin
    ModalResult := TControl(Sender).Tag;
    DoControlClick(Sender as TControl, ctButton, TControl(Sender).Tag, lHandled);
  end
  else
  begin
    ModalResult := FCustomButtons.GetModalResult(TControl(Sender).Tag);
    DoControlClick(Sender as TControl, ctCommandLink, TControl(Sender).Tag, lHandled);
  end;
  if (FForm <> nil) and not lHandled then
  begin
    FButtonClicked := True;
//    if ModalResult <> mrNone then
      Close(ModalResult);
  end;
end;

procedure TJSCustomDialog.DoCleanUpDialog;
begin
  FTaskBarProgressImpl.Free;
  if Assigned(FOnCleanUpDialog) then
    FOnCleanUpDialog(Self);
  CleanUpDialog;
end;

procedure TJSCustomDialog.DoCollapse;
begin
  if Assigned(FOnDialogCollapse) then
    FOnDialogCollapse(Self);
end;

procedure TJSCustomDialog.DoControlClick(Sender: TObject; ControlType: TControlType; const Value: Integer; var Handled: Boolean);
begin
  FCustomButtonResult := Value;
  if Assigned(FOnControlClick) then
    FOnControlClick(Self, ControlType, Sender as TControl, Value, Handled);
end;

procedure TJSCustomDialog.DoCreated;
begin
  if Assigned(FOnCreated) then
    FOnCreated(Self);
end;

procedure TJSCustomDialog.DoDestroyed;
begin
  if Assigned(FOnDestroyed) then
    FOnDestroyed(Self);
end;

procedure TJSCustomDialog.DoDialogClick(Sender: TObject; const AHitTest: TJSDialogHitTest);
begin
  if Assigned(FOnDialogClick) then
    FOnDialogClick(Sender, AHitTest);
end;

procedure TJSCustomDialog.DoDialogClose(Sender: TObject);
begin
  UpdateDialogResult;
  if Assigned(FOnDialogClose) then
    FOnDialogClose(Self);
end;

procedure TJSCustomDialog.DoDialogCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if DialogStyle = dsSheet then
  begin
    if CanClose then
      AnimateWindow(FForm.Handle, Sheet.Interval, AW_VER_NEGATIVE or AW_SLIDE or AW_HIDE);
  end;
end;

procedure TJSCustomDialog.DoDialogConstructed;
{$IFDEF DELPHI2007}
var
  lCtrl: TControl;
  i: Integer;
{$ENDIF DELPHI2007}
begin
  {$IFDEF DELPHI2007}
  if FCreatedCustomButtons <> nil then
    for i := 0 to FCreatedCustomButtons.Count - 1 do
    begin
      lCtrl := TControl(FCreatedCustomButtons[i]);
      if (lCtrl is TJSButton) and (i < CustomButtons.Count) and (CustomButtons[i].ElevationRequired) then
        Button_SetElevationRequiredState((lCtrl as TJSButton).Handle, True);
    end;
  {$ENDIF DELPHI2007}
  if Assigned(FOnDialogConstructed) then
    FOnDialogConstructed(FForm);
end;

procedure TJSCustomDialog.DoDialogShow;
begin
  if Assigned(FOnDialogShow) then
    FOnDialogShow(Self);
  if DialogStyle = dsSheet then
  begin
    AnimateWindow(FForm.Handle, Sheet.Interval, AW_VER_POSITIVE or AW_SLIDE);
    if doTimer in DialogOptions then
      TJSTaskDialogForm(FForm).StartTimer;
    FForm.Update;
  end;
end;

procedure TJSCustomDialog.DoExpand;
begin
  if Assigned(FOnDialogExpand) then
    FOnDialogExpand(Self);
end;

function TJSCustomDialog.DoGetControlClass(AControlType: TControlType): TControlClass;
begin
  InitialiseControlClass(AControlType, result);
  if Assigned(FOnGetControlClass) then
    FOnGetControlClass(Self, AControlType, result);
  // if even returns nil, revert class to default
  if result = nil then
  begin
    InitialiseControlClass(AControlType, result);
  end;
end;

procedure TJSCustomDialog.DoGetCustomSound(var ASound: string; var AFlags: Cardinal; var AHandled: Boolean);
begin
  if Assigned(FOnGetCustomSound) then
    FOnGetCustomSound(Self, ASound, AFlags, AHandled);
end;

procedure TJSCustomDialog.DoGetMoreFileName(var aFileName: TJSString);
begin
  if Assigned(FOnGetMoreFileName) then
    FOnGetMoreFileName(Self, aFileName);
end;

procedure TJSCustomDialog.DoHelpButtonClick(Sender: TObject);
var
  lHandled: Boolean;
begin
  lHandled := False;
  if Assigned(FOnHelpButtonClick) then
    FOnHelpButtonClick(Sender, lHandled);
  if not lHandled then
    Application.HelpContext(HelpContext);
end;

procedure TJSCustomDialog.DoHelpLinkClick;
var
  lHandled: Boolean;
begin
  lHandled := False;
  if Assigned(FOnHelpLinkClick) then
    FOnHelpLinkClick(FHelpLinkLabel, lHandled);
  if not lHandled then
  begin
    if Application.HelpFile <> '' then
    begin
      {$IFNDEF DELPHI5}
      if HelpLink.HelpType = htContext then
        Application.HelpContext(HelpLink.HelpContext)
      else
        Application.HelpKeyword(HelpLink.HelpKeyword);
      {$ENDIF DELPHI5}
    end
    else
      raise JSNoHelpFileException.Create(GetTranslatedString(StrYouMustAssociateA));
  end;
end;

procedure TJSCustomDialog.FooterChange(Sender: TObject);
var
  LHeight: Integer;
  LWidth: Integer;
begin
  if not (FCalcLayout) and (not FAssigning) then
  begin
    if FForm <> nil then
    begin
      CalculateAutoSize(LHeight, LWidth);
      if (FFooterLabel = nil) and (Footer.Text <> '') then
        CreateFooter;
      PositionControls;
    end;
  end;
end;

procedure TJSCustomDialog.FooterClickHandler(Sender: TObject);
begin
  DoDialogClick(Self, htFooter);
end;

function TJSCustomDialog.GetActiveControl: TWinControl;
begin
  result := nil;
  case ActiveControlType of
    ctButton: result := FFocusedControl;
    ctCommandLink:
      begin
        if FCreatedCustomButtons.Count > 0 then
        begin
          TControl(FCreatedCustomButtons[0]).Perform(WM_SETFOCUS, 0, 0);
          exit;
        end;
      end;
    ctCheckBox:
      begin
        if FVerificationCheckBox <> nil then
        begin
          FVerificationCheckBox.Perform(WM_SETFOCUS, 0, 0);
          exit;
        end;
      end;
    ctMoreButton:
      if FShowMoreButton <> nil then
        result := FShowMoreButton;
    ctRichEdit:
      if (FMoreRichEdit <> nil) and IsExpanded then
        result := FMoreRichEdit;
    ctLinkLabel:
      begin
        if FHelpLinkLabel <> nil then
        begin
          FHelpLinkLabel.Perform(WM_SETFOCUS, 0, 0);
          exit;
        end;
      end;
    ctURLLabel:
      begin
        if FFooterLabel <> nil then
        begin
          FFooterLabel.Perform(WM_SETFOCUS, 0, 0);
          exit;
        end;
      end;
    ctRadioButton:
      begin
        if FCreatedRadioButtons.Count > 0 then
        begin
          TControl(FCreatedRadioButtons[0]).Perform(WM_SETFOCUS, 0, 0);
          exit;
        end;
      end;
    ctProgressBar: result := FFocusedControl;
  end;
  if result = nil then
    result := FFocusedControl;
end;

function TJSCustomDialog.Canvas: TCanvas;
begin
  if FForm <> nil then
    result := FForm.Canvas
  else
    result := nil;
end;

function TJSCustomDialog.GetContentWidth: Integer;
begin
  if FEmulateMessageDlg then
    result := (Screen.Width div 2) - FLeftMargin
  else if ShowCommandLinks then
    result := CalculateWidth - FLeftMargin
  else if FLeftMargin >= MIN_DIALOG_WIDTH then
  begin
    if (MainIcon <> tdiNone) then
      Result := MIN_DIALOG_WIDTH - AFFS(32) - (FHorzSpacing * 3) - FRightMargin
    else
      Result := MIN_DIALOG_WIDTH - FHorzSpacing - FRightMargin
  end
  else
    result := MIN_DIALOG_WIDTH - FLeftMargin;
  result := TJSCaption.MinimumWidth(Canvas, Content.Text, Font, result);
end;

function TJSCustomDialog.GetControl(const AControlType: TControlType; const AValue: Integer = -1): TControl;
var
  I: Integer;
begin
  Result := nil;
  case AControlType of
    ctButton:
      begin
        for I := 0 to FCreatedButtonBarButtons.Count - 1 do
        begin
          if TControl(FCreatedButtonBarButtons[I]).Tag = AValue then
          begin
            Result := TControl(FCreatedButtonBarButtons[I]);
            Break;
          end;
        end;
      end;
    ctCommandLink:
      begin
        if FCreatedCustomButtons.Count > AValue - BASE_CUSTOMBUTTON then
        begin
          Result := TControl(FCreatedCustomButtons[AValue - BASE_CUSTOMBUTTON]);
        end;
      end;
    ctCheckBox:
      begin
        if Verification.Visible then
          Result := FVerificationCheckBox;
      end;
    ctMoreButton:
      begin
        if Expando.Visible then
        begin
          Result := FShowMoreButton;
        end;
      end;
    ctRichEdit:
      begin
        if Expando.Visible and Expando.ShowInFooter and (Expando.MoreFormat = mfRTF) then
        begin
          Result := FMoreRichEdit;
        end;
      end;
    ctLinkLabel:
      begin
        if (doShowHelpLink in DialogOptions) then
        begin
          Result := FHelpLinkLabel;
        end;
      end;
    ctURLLabel:
      begin
        if Footer.Text <> '' then
        begin
          Result := FFooterLabel;
        end;
      end;
    ctRadioButton:
      begin
        if FCreatedRadioButtons.Count > AValue - BASE_RADIOBUTTON then
        begin
          Result := TControl(FCreatedRadioButtons[AValue - BASE_RADIOBUTTON]);
        end;
      end;
    ctProgressBar:
      begin
        if ShowProgressBar then
        begin
          Result := FProgressBar;
        end;
      end;
    ctRadioGroup:
      begin
        if (doRadioButtons in DialogOptions) and RadioButton.ShowBorder then
        begin
          Result := FRadioGroup;
        end;
      end;
    ctMaxLines:
      begin
        Result := FContentMaxLines;
      end;
  end;
end;

{$IFNDEF THEMES}
// PosEx function doesn't exist in Delphi 6
function PosEx(const SubStr, S: string; const OffSet: Integer): Integer;
var
  i: Integer;
begin
  for i := OffSet + 1 to Length(S) do
  begin
    if POS(SubStr, Copy(S, i, Length(S))) = 1 then
    begin
      result := i;
      exit;
    end;
  end;
  result := 0;
end;
{$ENDIF THEMES}

function RemoveLink(const aLinkStr: TJSString): TJSString; {$IFDEF INLINE}inline;{$ENDIF}
var
  lStr: TJSString;
  lPos: Integer;
  lPosEnd: Integer;
begin
  if Length(trim(aLinkStr)) = 0 then
  begin
    result := aLinkStr;
    exit;
  end;
  lStr := aLinkStr;
  lPos := POS('<a href', lStr);
  lPosEnd := PosEx('>', lStr, lPos);
  lStr := Copy(lStr, 1, lPos - 1) + Copy(lStr, lPosEnd + 1, Length(lStr));
  lStr := JSStringReplace(lStr, '</a>', '', [rfReplaceAll]);
  result := lStr;
end;

function TJSCustomDialog.GetFooterHeight: Integer;
const
  FooterOffset: array [Boolean] of Integer = (0, 5);
var
  lLeftOffset: Integer;
begin
  if not Footer.Visible then
    Result := 0
  else
  begin
    lLeftOffset := AFFS(11);
    if Footer.Icon <> tdiNone then
    begin
      inc(lLeftOffset, AFFS(8));
      if Footer.Icon = tdiCustom then
        inc(lLeftOffset, Footer.Glyph.Width)
      else
        inc(lLeftOffset, AFFS(16));
    end;
    if Footer.Text <> '' then
      result := TJSCaption.MinimumHeight(Canvas, Footer.Text, Footer.Font, FClientWidth - FHorzSpacing - lLeftOffset)
    else
      Result := 0;
    if Footer.Icon = tdiCustom then
      result := Max(result, Footer.Glyph.Height);
    inc(result, AFFS(16 + FooterOffset[IsVista]));
  end;
end;

function TJSCustomDialog.GetFooterImageWidth: Integer;
begin
  Result := 0;
  if Footer.Icon <> tdiNone then
  begin
    if Footer.Icon = tdiCustom then
    begin
      if ValidPicture(Footer.Glyph) then
        Result := Footer.Glyph.Width;
    end
    else
      Result := AFFS(SMALL_ICONX);
  end;
end;

function TJSCustomDialog.GetHeaderImageWidth: Integer;
begin
  Result := 0;
  if Header.Icon <> tdiNone then
  begin
    if Header.Icon = tdiCustom then
    begin
      if ValidPicture(Header.Glyph) then
        Result := Header.Glyph.Width;
    end
    else
    begin
      case Header.IconSize of
        isMedium: Result := AFFS(MEDIUM_ICONX);
        isLarge: Result := AFFS(LARGE_ICONX);
      else
        Result := AFFS(SMALL_ICONX);
      end;
    end;
  end;
end;

function TJSCustomDialog.GetHitTest(const APt: TPoint): TJSDialogHitTest;
var
  I: TPaintStage;
  LRect: TRect;
begin
  Result := htNone;
  for I := low(TPaintStage) to high(TPaintStage) do
  begin
    LRect := GetRect(I);
    // The instruction section is a special case where it is handled by a direct click
    // on the instruction control. Therefore the instruction paint stage allows us to
    // check if the click has occurred on the image associated with the instruction.
    if (I = psInstruction) and Instruction.GlyphAvailable then
      LRect := Rect(FHorzSpacing, LRect.Top, LRect.Left - FHorzSpacing, LRect.Bottom);
    if PtInRect(LRect, APt) then
    begin
      case I of
        psGlyph: Result := htMainIcon;
        psInstruction: Result := htInstructionImage;
        psContent: Result := htContent;
        psMoreLines: Result := htExpandedSection;
        psRadio: Result := htNone;
        psCommand: Result := htNone;
        psHeader:
          begin
            Result := htHeader;
            if Header.ImageAlignment = jsImageAlignLeft then
              LRect := Rect(LRect.Left + FHorzSpacing, LRect.Top, LRect.Left + FHorzSpacing + GetHeaderImageWidth, LRect.Bottom)
            else
              LRect := Rect(LRect.Right - FHorzSpacing - GetHeaderImageWidth, LRect.Top, LRect.Right - FHorzSpacing, LRect.Bottom);
            if PtInRect(LRect, APt) then
              Result := htHeaderImage;
          end;
        psFooter:
          begin
            Result := htFooter;
            if Footer.ImageAlignment = jsImageAlignLeft then
              LRect := Rect(LRect.Left + FHorzSpacing, LRect.Top, LRect.Left + FHorzSpacing + GetFooterImageWidth, LRect.Bottom)
            else
              LRect := Rect(LRect.Right - FHorzSpacing - GetFooterImageWidth, LRect.Top, LRect.Right - FHorzSpacing, LRect.Bottom);
            if PtInRect(LRect, APt) then
              Result := htFooterImage;
          end;
        psMoreFooter: Result := htExpandedSection;
        psButtonBar: Result := htButtonBar;
        psHelpLink: Result := htNone;
        psProgressBar: Result := htNone;
//        psInstructBounds: ;
      else
        Result := htNone;
      end;
      Break;
    end;
  end;
end;

function TJSCustomDialog.GetModalResult: TModalResult;
begin
  result := FModalResult;
end;

function TJSCustomDialog.GetMoreFooterHeight: Integer;
begin
  Result := TJSCaption.MinimumHeight(Canvas, trim(Expando.Lines.Text), Expando.Font, FClientWidth - (2 * FHorzSpacing));
  inc(Result, VertMargin * 2);
end;

function TJSCustomDialog.GetRadioResult: Integer;
var
  i: Integer;
  lGrp: TRadioGroup;
begin
  if FCreatedRadioButtons <> nil then
  begin
    if FRadioGroup <> nil then
    begin
      if (FRadioGroup is TRadioGroup) then
      begin
        lGrp := (FRadioGroup as TRadioGroup);
        if lGrp.ItemIndex = -1 then
          result := -1
        else
          result := lGrp.Controls[lGrp.ItemIndex].Tag;
        exit;
      end;
    end
    else
    begin
      for i := 0 to FCreatedRadioButtons.Count - 1 do
      begin
        if TJSRadioButtonCtrl(FCreatedRadioButtons[i]).Checked then
        begin
          result := TJSRadioButtonCtrl(FCreatedRadioButtons[i]).Tag;
          exit;
        end;
      end;
    end;
  end;
  result := FDialogResult.RadioResult;
end;

function TJSCustomDialog.GetRect(AStage: TPaintStage): TRect;
var
  lHeight: Integer;
  lRect: TRect;
  lLine: TJSString;
  lBtnBarHeight: Integer;
  lHeaderHeight: Integer; // height of the HEADER section
  lMoreFooterHeight: Integer;
  lFooterHeight: Integer;
  lHeaderOffset: Integer;
  lHeaderTextHeight: Integer;
  LClientHeight: Integer;
begin
  result := Rect(0, 0, 0, 0); // initial result
  if FClientWidth = 0 then
    exit;
  case AStage of
    psGlyph:
      begin
        if ValidPicture(FGlyph) then
        begin
          if FHeader.Visible then
          begin
            lRect := GetRect(psHeader);
            lHeaderHeight := lRect.Bottom - lRect.Top;
          end
          else
            lHeaderHeight := 0;
          result := Rect(AFFS(10), AFFS(10) + lHeaderHeight, AFFS(10) + FGlyph.Width, AFFS(10) + FGlyph.Height + lHeaderHeight);
          if Instruction.GlyphAvailable then
          begin
            lRect := GetRect(psInstruction);
            inc(result.Top, lRect.Bottom - lHeaderHeight);
            inc(result.Bottom, lRect.Bottom - lHeaderHeight);
          end;
          if BiDiMode <> bdLeftToRight then
          begin
            Result.Left := FClientWidth - FGlyph.Width - AFFS(10);
            Result.Right := FClientWidth - AFFS(10);
          end;
        end;
      end;
    psInstructBounds:
      begin
        if FHeader.Visible then
        begin
          lRect := GetRect(psHeader);
          lHeaderHeight := lRect.Bottom - lRect.Top;
        end
        else
          lHeaderHeight := 0;
        lRect := GetRect(psInstruction);
        result.Top := lHeaderHeight;
        result.Left := 0;
        result.Right := FClientWidth;
        result.Bottom := lRect.Bottom;
      end;
    psInstruction:
      begin
        if FHeader.Visible then
        begin
          lRect := GetRect(psHeader);
          lHeaderHeight := lRect.Bottom - lRect.Top;
        end
        else
          lHeaderHeight := 0;
        if (Instruction.Text > '') or (Instruction.GlyphAvailable) then
        begin
          result := Rect(FLeftMargin, AFFS(10) + lHeaderHeight, FForm.ClientRect.Right - FRightMargin, AFFS(10) + GetInstructionHeight(False) + lHeaderHeight);
          if ValidPicture(Glyph) and FInstruction.ShowAtTop and not Instruction.HasGlyph and not Instruction.HasCustomGlyph then
          begin
            FLeftMargin := AFFS(8) + FGlyph.Graphic.Width + FHorzSpacing;
            Dec(Result.Right, AFFS(8) + FGlyph.Graphic.Width + FHorzSpacing);
          end
          else if ValidPicture(Glyph) and (Instruction.GlyphAvailable) then
          begin
            FLeftMargin := AFFS(8) + Instruction.GlyphWidth + FHorzSpacing;
            Dec(Result.Right, AFFS(8) + Instruction.GlyphWidth + FHorzSpacing);
          end
          else if (MainIcon <> tdiNone) then
          begin
            if BiDiMode <> bdLeftToRight then
              Dec(Result.Right, AFFS(32) + AFFS(8));
          end;
          if Instruction.GlyphAvailable then
            result.Bottom := result.Top + Max(result.Bottom - lHeaderHeight, FVertSpacing + Instruction.GlyphHeight + FVertSpacing);
        end
        else
        begin
          result := Rect(FLeftMargin, lHeaderHeight, FForm.ClientRect.Right - FRightMargin, lHeaderHeight);
        end;
      end;
    psContent:
      begin
        lLine := Content.Text;
        if trim(lLine) = '' then
        begin
          // This can mean that the Radio Buttons section can start under the Main Icon bounds
          result.Top := GetRect(psInstruction).Bottom;
          if (trim(Instruction.Text) <> '') and (MainIcon <> tdiNone) then
            inc(result.Top, AFFS(32)) { MainIcon height }
          else
            inc(result.Top, VertMargin);
          result.Bottom := result.Top;
          exit;
        end;
        Canvas.Font.Assign(Font);
        result.Left := FLeftMargin;
        result.Right := FClientWidth - FRightMargin;

        // lLine := TrimRight(lLine); // todo test more... (works well for emulated dialogs, not for regular dialogs)

        if FContentLabel <> nil then
          lHeight := TJSCaption.MinimumHeight(Canvas, lLine, Font, result.Right - result.Left)
        else
          LHeight := TJSCaption.MinimumHeight(Canvas, 'One line', Font, result.Right - result.Left) * (MaxLines + 1); // do not localise
        lRect := GetRect(psInstruction);
        if lRect.Bottom <> 0 then
          inc(result.Top, AFFS(7));
        inc(result.Top, lRect.Bottom + VertMargin); // added spacing
        if lRect.Bottom = 0 then
          inc(result.Top, VertMargin);
        Result.Right := LRect.Right;
        result.Bottom := result.Top + lHeight; // added spacing
      end;
    psMoreLines:
      begin
        if not Expando.ShowInFooter then
        begin
          lLine := {TrimRight}(Expando.Lines.Text);
          Canvas.Font.Assign(Expando.Font);
          result.Left := FLeftMargin;
          result.Right := FClientWidth - FRightMargin;
          lHeight := TJSCaption.MinimumHeight(Canvas, lLine, Expando.Font, result.Right - result.Left);
          result.Top := GetRect(psContent).Bottom;
          result.Right := FClientWidth - FRightMargin;
          result.Bottom := result.Top + lHeight;
        end;
      end;
    psRadio:
      begin
        if ShowProgressBar then
          result.Top := GetRect(psProgressBar).Bottom
        else if (IsExpanded or FExpanding) and (not FExpando.ShowInFooter) then
          result.Top := GetRect(psMoreLines).Bottom
        else
          result.Top := GetRect(psContent).Bottom;
        if RadioButton.ShowBorder then
        begin
          lRect := GetRect(psContent);
          result.Bottom := result.Top +
            (round(FRadioButtons.Count / RadioButton.Columns) * (GetCtrlHeight(Font.Handle) + AFFS(1)));
          inc(result.Bottom, round(FRadioButtons.Count / RadioButton.Columns) * 4);
          inc(result.Bottom, FVertMargin);
          if lRect.Bottom - lRect.Top = 0 then
            inc(result.Bottom, FVertMargin);
        end
        else
        begin
          result.Bottom := result.Top + ((FRadioButtons.Count * (GetCtrlHeight(Font.Handle) + 1))); // radio spacing
          inc(result.Bottom, FVertMargin);
        end;
        inc(result.Bottom, AFFS(6) * (Radiobuttons.Count - 1));
        inc(result.Bottom, AFFS(5) + (3 * (RadioButtons.Count - 1)));

        // if a dialog has no content then make the dialog taller
        lRect := GetRect(psContent);
        if (lRect.Bottom = lRect.Top) then
          inc(result.Bottom, 2 * VertMargin);
        result.Left := 0;
        result.Right := FClientWidth;
      end;
    psCommand:
      begin
        if ShowRadioButtons then
          result.Top := GetRect(psRadio).Bottom
        else if ShowProgressBar then
          result.Top := GetRect(psProgressBar).Bottom
        else if (IsExpanded or FExpanding) and not Expando.ShowInFooter then
          result.Top := GetRect(psMoreLines).Bottom
        else
          result.Top := GetRect(psContent).Bottom;// + FVertMargin;
        result.Left := 0;
        result.Right := FClientWidth;
        result.Bottom := result.Top + AFFS(10);
      end;
    psButtonBar:
      begin
        lBtnBarHeight := FButtonBarHeight;
        LClientHeight := FForm.ClientHeight;
        if FVerification.Visible and FExpando.Visible then
          lBtnBarHeight := Max(lBtnBarHeight, AdjustButtonBarHeight) + AFFS(2);

        if (IsExpanded or FExpanding) and Expando.ShowInFooter then
        begin
          if (Expando.MoreFormat = mfText) and (Expando.MoreSource = msDefault) then
          begin
            lMoreFooterHeight := TJSCaption.MinimumHeight(Canvas, trim(Expando.Lines.Text), Expando.Font, FClientWidth - (2 * FHorzSpacing));
            inc(lMoreFooterHeight, VertMargin * 2);
          end
          else
          begin
            lMoreFooterHeight := FExpando.MoreHeight;
          end;
          if not Footer.Visible then
          begin
            if (Expando.MoreFormat = mfText) and (Expando.MoreSource = msDefault) then
              result.Top := FClientHeight - lMoreFooterHeight - lBtnBarHeight
            else
              result.Top := FClientHeight - lMoreFooterHeight - lBtnBarHeight - AFFS(16);
          end
          else
          begin
            if FExpanding then
              result.Top := LClientHeight - GetFooterHeight - lBtnBarHeight - FExpandedLeftOver
            else
            begin
              // When displaying RTF content the control has an 8 pixel top and bottom offset
              if Expando.MoreFormat = mfRTF then
                result.Top := LClientHeight - GetFooterHeight - lBtnBarHeight - lMoreFooterHeight - AFFS(16)
              else
                result.Top := LClientHeight - GetFooterHeight - lBtnBarHeight - lMoreFooterHeight;
            end;
          end;
        end
        else if FCollapsing then
        begin
          if Expando.ShowInFooter then
            result.Top := LClientHeight - GetFooterHeight - LBtnBarHeight - FExpandedLeftOver
          else
            result.Top := LClientHeight - GetFooterHeight - LBtnBarHeight;
        end
        else if Footer.Visible then
        begin
          result.Top := FClientHeight - lBtnBarHeight - GetFooterHeight
        end
        else
          result.Top := FClientHeight - lBtnBarHeight;

        if FExpanding and not Expando.ShowInFooter then
        begin
          Dec(result.Top, FExpandedAmount - FExpandedLeftOver);
        end;

        if EmulateMessageDlg then
        begin
          if Verification.Visible then
          begin
            if FVerificationCheckBox <> nil then
              dec(result.Top, FVerificationCheckBox.Height + FVertSpacing);
          end;
          if Expando.Visible then
          begin
            if FShowMoreButton <> nil then
              dec(result.Top, FShowMoreButton.Height + FVertSpacing);
          end;
        end;

        result.Bottom := result.Top + lBtnBarHeight;
        result.Right := FClientWidth;
      end;
    psHelpLink:
      begin
        if FHelpLinkLabel <> nil then
        begin
          if ButtonBar.Visible then
          begin
            result := GetRect(psButtonBar);
            result.Top := result.Top - FHelpLinkLabel.Height - (2 * FVertSpacing);
            result.Bottom := result.Top + FHelpLinkLabel.Height + (2 * FVertSpacing);
          end
          else if ShowCommandLinks then
          begin
            result.Top := FClientHeight - FVertMargin - FVertSpacing - FHelpLinkLabel.Height;
            result.Right := FClientWidth;
            result.Left := FLeftMargin;
            result.Bottom := result.Top + FHelpLinkLabel.Height;
          end
          else
          begin
            result := GetRect(psContent);
            result.Top := result.Bottom + (2 * FVertSpacing);
            result.Bottom := result.Top + FHelpLinkLabel.Height + (2 * FVertSpacing);
          end;
        end;
      end;
    psFooter:
      begin
        if Footer.Visible then
        begin
          lFooterHeight := GetFooterHeight;
          if FExpanding then
          begin
            if Expando.ShowInFooter then
            begin
              Result.Top := FForm.ClientHeight - LFooterHeight - FExpandedLeftOver;
            end
            else
            begin
              Result.Top := FForm.ClientHeight - LFooterHeight;
            end;
            Result.Bottom := Result.Top + LFooterHeight;
            Result.Right := FClientWidth;
          end
          else if FCollapsing then
          begin
            if Expando.ShowInFooter then
            begin
              Result.Top := FForm.ClientHeight - LFooterHeight - FExpandedLeftOver;
            end
            else
            begin
              Result.Top := FForm.ClientHeight - LFooterHeight;
            end;
            Result.Bottom := Result.Top + LFooterHeight;
            Result.Right := FClientWidth;
          end
          else
          begin
            if (IsExpanded) and Expando.ShowInFooter then
            begin
              lRect := GetRect(psMoreFooter);
              result.Top := lRect.Top - lFooterHeight;
            end
            else
              result.Top := FClientHeight - lFooterHeight;
            result.Bottom := result.Top + lFooterHeight;
            result.Right := FClientWidth;
          end;
        end;
      end;
    psMoreFooter:
      begin
        if IsExpanded then
        begin
          LClientHeight := FForm.ClientHeight;
          if (Expando.MoreFormat = mfRTF) or (Expando.MoreSource in [msStream, msFile]) then
          begin
            result.Top := FClientHeight - FExpando.MoreHeight - (2 * FVertMargin);
            result.Bottom := result.Top + FExpando.MoreHeight + (2 * FVertMargin);
          end
          else
          begin
            if FCollapsing then
              lMoreFooterHeight := FExpandedLeftOver
            else
            begin
              lMoreFooterHeight := GetMoreFooterHeight;
            end;
            result.Top := LClientHeight - GetMoreFooterHeight;
            result.Bottom := result.Top + LMoreFooterHeight;
          end;
        end
        else
        begin
          Result := GetRect(psFooter);
          LClientHeight := FForm.ClientHeight;
          if Result.Bottom = 0 then
            Result.Bottom := LClientHeight - FExpandedLeftOver;
          Result.Top := Result.Bottom;
          if Result.Top = 0 then
            Result.Bottom := 0
          else
          begin
            if (Expando.MoreFormat = mfRTF) or (Expando.MoreSource in [msStream, msFile]) then
            begin
              result.Bottom := result.Top + FExpando.MoreHeight + (2 * FVertMargin);
            end
            else
            begin
              if FCollapsing then
                lMoreFooterHeight := FExpandedLeftOver
              else
              begin
                lMoreFooterHeight := GetMoreFooterHeight;
              end;
              result.Bottom := result.Top + LMoreFooterHeight;
            end;
          end;
        end;
        result.Right := FClientWidth;
      end;
    psHeader:
      begin
        if Header.Visible then
        begin
          lRect := Rect(0, 0, 0, FClientWidth);
          lHeaderOffSet := 0;
          if ValidPicture(Header.Glyph) and (Header.Icon = tdiCustom) then
          begin
            inc(lRect.Left, Header.Glyph.Height + (2 * FHorzSpacing));
            lHeaderHeight := (FVertSpacing * 3) + FHeader.Glyph.Height;
            inc(lHeaderOffset, FHeader.Glyph.Width);
          end
          else if (Header.Icon in KnownIcons) then
          begin
            lHeaderHeight := (FVertSpacing * 2) + GetIconHeightFromIconSize(Header.IconSize);
            inc(lHeaderOffset, GetIconHeightFromIconSize(Header.IconSize)); // known icons are square
          end
          else
            lHeaderHeight := 0;

          inc(lHeaderOffset, (FHorzSpacing * 2));
          lHeaderTextHeight := TJSCaption.MinimumHeight(Canvas, Header.Text, Header.Font,
            FClientWidth - lHeaderOffset);
          result.Bottom := Max(FVertSpacing + lHeaderTextHeight + FVertSpacing, lHeaderHeight);
          result.Right := FClientWidth;
        end;
      end;
    psProgressBar:
      begin
        if FProgressBar <> nil then
        begin
          if (IsExpanded or FExpanding or FCollapsing) and (not FExpando.ShowInFooter) then
            lRect := GetRect(psMoreLines)
          else
            lRect := GetRect(psContent);
          result.Top := lRect.Bottom;
          result.Bottom := result.Top + AFFS(25);
          result.Left := 0;
          result.Right := FClientWidth;
        end;
      end;
  end;
end;

function TJSCustomDialog.GetShowMoreButtonWidth: Integer;
var
  lAlternateWidth: Integer;
  lAlternateText: TJSString;
begin
  if FShowMoreButton = nil then
    CreateExpandoButton;
  if FShowMoreButtonWidth = -1 then
  begin
    FShowMoreButtonWidth := FShowMoreButton.Width + FHorzSpacing;
    // need to now calculate the width of the button in the
    // opposite state to what it is currently in.
    // This prevents the dialog from resizing horizonatally
    // when expanded or collapsed when the dialog width is
    // dependant on the ShowMoreButton label
    if not FExpando.Showing then
      lAlternateText := FExpando.HideText
    else
      lAlternateText := FExpando.ShowText;
    lAlternateWidth := GetCtrlWidth(FShowMoreButton.Font, lAlternateText);
    if ValidPicture(FShowMoreButton.Glyph) then
      inc(lAlternateWidth, FShowMoreButton.Glyph.Width + FShowMoreButton.Spacing);
    FShowMoreButtonWidth := Max(FShowMoreButtonWidth, lAlternateWidth + FHorzSpacing);
  end;
  result := FShowMoreButtonWidth;
end;

function TJSCustomDialog.GetSystemSound(const AIcon: TTaskDialogIcon; var AFlags: Cardinal): string;
var
  LHandled: Boolean;
begin
  LHandled := AIcon = tdiCustom;
  DoGetCustomSound(result, AFlags, LHandled);
  if not LHandled then
  begin
    case AIcon of
      tdiWarning: result := 'SystemExclamation';
      tdiError: result := 'SystemHand';
      tdiInformation: result := 'SystemAsterisk';
      tdiConfirmation: result := 'SystemQuestion';
      tdiShield: result := 'WindowsUAC';
    else
      result := '';//'.Default';
    end;
    AFlags := AFlags or SND_ALIAS;
  end;
end;

function TJSCustomDialog.GetInstructionHeight(const AIncludeGlyphHeight: Boolean): Integer;
begin
  result := TJSCaption.MinimumHeight(Canvas, Instruction.Text, Instruction.Font, FClientWidth - FRightMargin - FLeftMargin);
  if AIncludeGlyphHeight and (Instruction.HasCustomGlyph or Instruction.HasGlyph) then
    result := Max(result, Instruction.GlyphHeight);
end;

function TJSCustomDialog.GetInstructionWidth: Integer;
begin
  if ShowCommandLinks then
    result := CalculateWidth
  else
    result := MIN_DIALOG_WIDTH;
  result := TJSCaption.MinimumWidth(Canvas, Instruction.Text, Instruction.Font, result) + AFFS(8);
  if Instruction.GlyphAvailable and (Instruction.Text <> '') then
    inc(result, Instruction.GlyphWidth);
end;

function TJSCustomDialog.GetVerificationResult: Boolean;
begin
  result := DoGetVerificationResult;
end;

procedure TJSCustomDialog.GlyphChangeHandler(Sender: TObject);
begin
  // 
end;

function TJSCustomDialog.HasElevationButton: Boolean;
var
  i: Integer;
begin
  if not ShowCommandLinks then
  begin
    for i := 0 to CustomButtons.Count - 1 do
    begin
      result := CustomButtons[i].ElevationRequired;
      if result then
        exit;
    end;
  end;
  result := False;
end;

procedure TJSCustomDialog.HeaderFontChange(Sender: TObject);
begin
  //
end;

function TJSCustomDialog.HeightAdjustment: Integer;
begin
  result := 0;
end;

procedure TJSCustomDialog.HelpButtonClickHandler(Sender: TObject);
begin
  DoHelpButtonClick(Sender);
end;

procedure TJSCustomDialog.HelpLinkLabelClickHandler(Sender: TObject);
begin
  DoHelpLinkClick;
end;

function TJSCustomDialog.HorzPadding: Integer;
begin
  Result := AFFS(10) * 2;
  if ValidPicture(Glyph) then
  begin
    Inc(Result, FGlyph.Graphic.Width + FHorzSpacing);
  end
  else if not (MainIcon in [tdiNone, tdiCustom]) then
    Inc(Result, Icon.Width);
  // Include the border sizes in the result
  Inc(Result, ((GetSystemMetrics(SM_CXFRAME) + GetSystemMetrics(SM_CYFIXEDFRAME) + GetSystemMetrics(SM_CXBORDER)) * 2));
end;

procedure TJSCustomDialog.ExpandoChangedHandler(Sender: TObject);
var
  lRect: TRect;
  LHeight: Integer;
  LWidth: Integer;
begin
  if csLoading in ComponentState then
    exit;
  if FInitialisingFonts then
    exit;
  if FExpanding then
    exit;
  if not (FCalcLayout) and (not FAssigning) then
  begin
    FShowMoreButtonWidth := -1;
    CalculateAutoSize(LHeight, LWidth);
    PositionControls;
    if Expando.Visible and (FForm <> nil) then
    begin
      lRect := GetRect(psMoreLines);
      InvalidateRect(FForm.Handle, @lRect, True);
      if Expando.ShowInFooter and (Expando.MoreFormat = mfRTF) then
        CreateMoreInFooter;
    end;
  end;
end;

procedure TJSCustomDialog.NewFontChanged(Sender: TObject);
begin
  if Assigned(FOldFontChanged) then
    FOldFontChanged(Sender);
  RecreateControls;
end;

procedure TJSCustomDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if (FCustomButtons <> nil) then
    begin
      if AComponent = FCustomButtons.Images then
        FCustomButtons.Images := nil
      else if AComponent = FCustomButtons.PictureImages then
        FCustomButtons.PictureImages := nil;
    end;
    if (AComponent = FForm) then
    begin
      FForm := nil;
    end;
  end;
end;

procedure TJSCustomDialog.Paint;
var
  lRect: TRect;
  LBitmap: TBitmap;
  LCanvas: TCanvas;
begin
  {$IFNDEF DELPHI5}
  if not Canvas.HandleAllocated then
    exit;
  {$ENDIF DELPHI5}
  if csDestroying in ComponentState then
    exit;
  if FCalcAutosizing then
    exit;
  if FCalcLayout then
    exit;
  lRect := FForm.ClientRect;

  LBitmap := TBitmap.Create;
  try
    {$IFDEF DELPHI2006}
    LBitmap.SetSize(LRect.Right, LRect.Bottom);
    {$ELSE}
    LBitmap.Width := LRect.Right;
    LBitmap.Height := LRect.Bottom;
    {$ENDIF DELPHI2006}
    LCanvas := {Canvas;//}LBitmap.Canvas;
    LCanvas.Brush.Color := FForm.Color;
    LCanvas.Brush.Style := bsSolid;
    LCanvas.FillRect(lRect);
    if FHeader.Visible then
    begin
      lRect := GetRect(psHeader);
      PaintHeader(LCanvas, lRect);
    end;
    lRect := GetRect(psInstruction);
    PaintMainInstruction(LCanvas, lRect);
    lRect := GetRect(psGlyph);
    PaintGlyph(LCanvas, lRect);
//    if (IsExpanded or FExpanding) and FExpando.Visible then
//    begin
//      lRect := GetRect(psMoreLines);
//      PaintMoreLines(LCanvas, lRect);
//    end;
    lRect := GetRect(psButtonBar);
    PaintButtonBar(LCanvas, lRect);
    if (Footer.Visible) or (Expando.ShowInFooter and Expando.Visible) then
      PaintFooter(LCanvas);
    if (Border.Visible) and (not FEmulateMessageDlg) then
    begin
      LCanvas.Brush.Style := bsClear;
      LCanvas.Pen.Color := Border.Color;
      LCanvas.Pen.Width := Border.Width;
      lRect := FForm.ClientRect;
      if Border.Width > 1 then
      begin
        inc(lRect.Top);
        inc(lRect.Left);
        dec(lRect.Right);
        dec(lRect.Bottom);
      end;
      LCanvas.Rectangle(lRect);
    end;

//    if ShowProgressBar then
//      FillBackground(LCanvas, GetRect(psProgressBar), clYellow);
//
//    if ShowRadioButtons then
//      FillBackground(LCanvas, GetRect(psRadio), clBlue);
//
//    if ShowCommandLinks then
//      FillBackground(LCanvas, GetRect(psCommand), clFuchsia);

    BitBlt(Canvas.Handle, 0, 0, LBitmap.Width, LBitmap.Height, LBitmap.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    LBitmap.Free;
  end;

end;

procedure PaintSeparator(ACanvas: TCanvas);
begin
  {$IFDEF DELPHIXE2}
  if StyleServices.Enabled then
  begin
    if Win32MajorVersion > 5 then
      ACanvas.Pen.Color := StyleServices.GetSystemColor(clVistaSeparator)
    else
      ACanvas.Pen.Color := StyleServices.GetSystemColor(clLtGray);
  end
  else
  begin
    if Win32MajorVersion > 5 then
      ACanvas.Pen.Color := clVistaSeparator
    else
      ACanvas.Pen.Color := clLtGray;
  end;
  {$ELSE}
  if Win32MajorVersion > 5 then
    ACanvas.Pen.Color := clVistaSeparator
  else
    ACanvas.Pen.Color := clLtGray;
  {$ENDIF DELPHIXE2}
end;

procedure TJSCustomDialog.PaintButtonBar(ACanvas: TCanvas; ARect: TRect);
begin
  if FButtonBar.Visible then
  begin
    FillBackground(ACanvas, ARect, FButtonBar.Color);
    if ButtonBar.ShowDivider then
    begin
      ACanvas.Pen.Width := 1;
      PaintSeparator(ACanvas);
      ACanvas.MoveTo(ARect.Left, ARect.Top);
      ACanvas.LineTo(ARect.Right, ARect.Top);
    end;
  end;
end;

procedure TJSCustomDialog.PaintFooterSeparator(ACanvas: TCanvas; const ARect: TRect);
begin
  ACanvas.Pen.Width := 1;
  PaintSeparator(ACanvas);
  ACanvas.MoveTo(ARect.Left, ARect.Top);
  ACanvas.LineTo(ARect.Right, ARect.Top);
  ACanvas.Pen.Color := clWhite;
  ACanvas.MoveTo(ARect.Left, ARect.Top + 1);
  ACanvas.LineTo(ARect.Right, ARect.Top + 1);
end;

const
  { Summary
    Specifies the offset value when placing the footers glyph on
    a dialog.
    Description
    The offset is required due to Vista dialog layouts being
    different to other operating system layouts.                 }
  FooterGlyphOffsetV: array [Boolean] of Integer = (0, 4);
  { Summary
    Specifies the offset value when placing the footer on a
    dialog.
    Description
    The offset is required due to Vista dialog layouts being
    different to other operating system layouts.             }
  FooterOffSetV: array [Boolean] of Integer = (0, 3);

procedure TJSCustomDialog.PaintFooter(ACanvas: TCanvas);
var
  lRect: TRect;
  lDrawRect: TRect;
  lGraphic: TGraphic;
  lIcon: PChar;
  LIsCustomShield: Boolean;

  function CreateGraphic: TGraphic;
  begin
    if (Win32MajorVersion < 6) and (Footer.Icon = tdiShield) then
    begin
      result := TBitmap.Create;
      try
        (result as TBitmap).LoadFromResourceName(hInstance, JSD_SHIELD_SML);
      except
        Footer.Icon := tdiNone;
      end;
      result.Transparent := True;
    end
    else
      result := TIcon.Create;
  end;

begin
  if Footer.Visible or FExpanding then
  begin
    lRect := GetRect(psFooter);
    FillBackground(ACanvas, lRect, Footer.Color);
    PaintFooterSeparator(ACanvas, lRect);

    if Footer.Icon <> tdiNone then
    begin
      inc(lRect.Left, AFFS(12));
      inc(lRect.Top, AFFS(7 + FooterGlyphOffsetV[IsVista]));
      if (Footer.ImageAlignment = jsImageAlignLeft) and (BidiMode = bdLeftToRight) then
      begin
        if Footer.Icon = tdiCustom then
        begin
          if ValidPicture(Footer.Glyph) then
            lDrawRect := Rect(lRect.Left, lRect.Top, lRect.Left + Footer.Glyph.Width, lRect.Top + Footer.Glyph.Height)
          else
            lDrawRect := Rect(lRect.Left, lRect.Top, lRect.Left + AFFS(SMALL_ICONX), lRect.Top + AFFS(SMALL_ICONY));
        end
        else
          lDrawRect := Rect(lRect.Left, lRect.Top, lRect.Left + AFFS(SMALL_ICONX), lRect.Top + AFFS(SMALL_ICONY));
      end
      else
      begin
        if Footer.Icon = tdiCustom then
        begin
          if ValidPicture(Footer.Glyph) then
            lDrawRect := Rect(lRect.Right - Footer.Glyph.Width - FHorzSpacing, lRect.Top, lRect.Right - FHorzSpacing, lRect.Top + Footer.Glyph.Height)
          else
            lDrawRect := Rect(lRect.Left - FHorzSpacing, lRect.Top, lRect.Left + AFFS(SMALL_ICONX) - FHorzSpacing, lRect.Top + AFFS(SMALL_ICONY));
        end
        else
          lDrawRect := Rect(lRect.Right - AFFS(SMALL_ICONX) - FHorzSpacing, lRect.Top, lRect.Right - FHorzSpacing, lRect.Top + AFFS(SMALL_ICONY));
      end;
      if Footer.Icon = tdiCustom then
      begin
        if ValidPicture(Footer.Glyph) then
        begin
          if Footer.Glyph.Bitmap <> nil then
            Footer.Glyph.Bitmap.Transparent := True;
          ACanvas.StretchDraw(lDrawRect, Footer.Glyph.Graphic);
        end;
      end
      else
      begin
        lGraphic := CreateGraphic;
        try
          if lGraphic is TIcon then
          begin
            lIcon := GetIcon(Footer.Icon, LIsCustomShield);
            if (LIcon <> nil) and not LIsCustomShield then
              (lGraphic as TIcon).Handle := LoadImage(0, lIcon, IMAGE_ICON, AFFS(SMALL_ICONX), AFFS(SMALL_ICONY), LR_DEFAULTCOLOR)
            else if LIsCustomShield then
              (LGraphic as TIcon).Handle := LoadImage(hInstance, LIcon, IMAGE_ICON, AFFS(SMALL_ICONX), AFFS(SMALL_ICONY), LR_DEFAULTCOLOR);
          end;
          ACanvas.Draw(lDrawRect.Left, lDrawRect.Top, lGraphic);
          inc(lRect.Left, (3 * FVertMargin) + FVertSpacing);
        finally
          lGraphic.Free;
        end;
      end;
    end;
  end;
  if (IsExpanded or FExpanding or FCollapsing) and Expando.ShowInFooter then
  begin
    lRect := GetRect(psMoreFooter);
    FillBackground(ACanvas, lRect, ButtonBar.Color);
    PaintFooterSeparator(ACanvas, lRect);
  end;
end;

procedure TJSCustomDialog.PaintGlyph(ACanvas: TCanvas; ARect: TRect);
begin
  if ValidPicture(FGlyph) then
  begin
    if EmulateMessageDlg then
      FillBackground(ACanvas, ARect, clBtnFace)
    else
      FillBackground(ACanvas, ARect, Color);
    FGlyph.Graphic.Transparent := True;
    ACanvas.Draw(ARect.Left, ARect.Top, FGlyph.Graphic);
  end;
end;

function TJSCustomDialog.CreateGraphic(const AIcon: TTaskDialogIcon; const ASize: TJSIconSize): TGraphic;
begin
  if (not IsVista) and (AIcon = tdiShield) then
  begin
    result := TBitmap.Create;
    if ASize = isSmall then
      (result as TBitmap).LoadFromResourceName(hInstance, JSD_SHIELD_SML)
    else
      (result as TBitmap).LoadFromResourceName(hInstance, JSD_SHIELD);
    result.Transparent := True;
  end
  else
    result := TIcon.Create;
end;

procedure TJSCustomDialog.PaintHeader(ACanvas: TCanvas; ARect: TRect);
var
  lOffSet: TPoint;
  lGraphic: TGraphic;
  lDrawRect: TRect;
  lRect: TRect;
  lIconHeight: Integer;
  LIconWidth: Integer;
  lIcon: PChar;
  {$IFNDEF DELPHI5}
  lBrushRecall: TBrushRecall;
  {$ENDIF DELPHI5}
  lBackground: TJSBackground;
  LIsCustomShield: Boolean;
  LPaintPt: TPoint;
begin
  {$IFNDEF DELPHI5}
  lBrushRecall := TBrushRecall.Create(ACanvas.Brush);
  {$ENDIF DELPHI5}
  try
    lRect := GetRect(psHeader);
    lGraphic := nil;
    lIconHeight := 0;
    LIconWidth := 0;
    if (Header.Icon <> tdiNone) then
    begin
      if Header.Icon <> tdiCustom then
      begin
        lIconHeight := GetIconHeightFromIconSize(Header.IconSize);
        LIconWidth := LIconHeight;
      end
      else if ValidPicture(Header.Glyph) then
      begin
        lIconHeight := Header.Glyph.Height;
        LIconWidth := Header.Glyph.Width;
      end;
    end;
    if ValidPicture(FHeader.Glyph) or (lGraphic <> nil) or (lIconHeight > 0) then
      lOffSet.X := lRect.Left + FHorzSpacing + lIconWidth + FHorzSpacing
    else
      lOffSet.X := FHorzSpacing;
    lOffSet.Y := FVertSpacing;
    LPaintPt := LOffset;
    if Header.ImageAlignment = jsImageAlignRight then
    begin
      LRect.Right := LRect.Right - LOffset.X;
      LPaintPt := Point(FHorzSpacing, LOffset.X);
    end;
    lBackground := TJSBackground.Create(Header.Color, Header.Gradient, EmptyRect, True, False);
    try
      TJSCaption.PaintCaption(ACanvas, Header.Text, lBackground, Header.Font, LRect, LPaintPt);
    finally
      lBackground.Free;
    end;

    lRect := GetRect(psHeader);
    if (Header.Icon <> tdiNone) then
    begin
      LIconWidth := -1;
      if Header.Icon <> tdiCustom then
      begin
        lIconHeight := GetIconHeightFromIconSize(Header.IconSize);
        LIconWidth := LIconHeight;
      end
      else if ValidPicture(Header.Glyph) then
      begin
        lIconHeight := Header.Glyph.Height;
        LIconWidth := Header.Glyph.Width;
      end
      else
        lIconHeight := -1;
      if lIconHeight > -1 then
      begin
        if Header.ImageAlignment = jsImageAlignLeft then
        begin
          lDrawRect := Rect(lRect.Left + FHorzSpacing, lRect.Top + FVertSpacing,
            lRect.Left + FHorzSpacing + lIconWidth, lRect.Top + FVertSpacing + lIconHeight);
        end
        else
        begin
          lDrawRect := Rect(lRect.Right - FHorzSpacing - LIconWidth, lRect.Top + FVertSpacing,
            lRect.Right - FHorzSpacing, lRect.Top + FVertSpacing + lIconHeight);
        end;
        if Header.Icon = tdiCustom then
        begin
          Header.Glyph.Graphic.Transparent := True;
          ACanvas.StretchDraw(lDrawRect, Header.Glyph.Graphic);
        end
        else
        begin
          lGraphic := CreateGraphic(Header.Icon, Header.IconSize);
          try
            if lGraphic is TIcon then
            begin
              lIcon := GetIcon(Header.Icon, LIsCustomShield);
              if (LIcon <> nil) and not LIsCustomShield then
                (lGraphic as TIcon).Handle := LoadImage(0, lIcon, IMAGE_ICON, lIconHeight, LIconWidth, LR_DEFAULTCOLOR)
              else if LIsCustomShield then
                (LGraphic as TIcon).Handle := LoadImage(hInstance, LIcon, IMAGE_ICON, lIconHeight, lIconWidth, LR_DEFAULTCOLOR);
            end;
            ACanvas.Draw(lDrawRect.Left, lDrawRect.Top, lGraphic);
            inc(lRect.Left, (3 * FVertMargin) + FVertSpacing);
          finally
            lGraphic.Free;
          end;
        end;
      end;
    end;

  finally
    {$IFNDEF DELPHI5}
    lBrushRecall.Free;
    {$ENDIF DELPHI5}
  end;
end;

procedure TJSCustomDialog.PaintMoreFooter(ACanvas: TCanvas; ARect: TRect);
begin
  //
end;

procedure TJSCustomDialog.PaintMoreLines(ACanvas: TCanvas; ARect: TRect);
var
  LHeight: Integer;
//  LOldColor: TColor;
begin
Exit;
  if (IsExpanded {or FExpanding or FCollapsing}) and (ARect.Right > 0) then
  begin
    LHeight := TJSCaption.MinimumHeight(ACanvas, Expando.Lines.Text, Expando.Font, ARect.Right - ARect.Left);
//    LOldColor := Fbackground.Color;
//    FBackground.Color := clYellow;
    if ARect.Bottom - ARect.Top >= LHeight then
      TJSCaption.PaintCaption(ACanvas, Expando.Lines.Text, FBackground, Expando.Font, TJSCaption.TranslateRect(ARect), FForm, BiDiMode);
//    Fbackground.Color := LOldColor;
  end;
end;

procedure TJSCustomDialog.PerformAction(const aValue: Integer);
var
  lCtrl: TControl;
begin
  lCtrl := GetControl(ctCommandLink, aValue);
  if lCtrl <> nil then
    DoButtonClick(lCtrl);
end;

function TJSCustomDialog.PlaySystemSounds: Boolean;
begin
  result := PlaySounds;
end;

procedure TJSCustomDialog.PaintMainInstruction(ACanvas: TCanvas; ARect: TRect);
var
  lRect: TRect;
  lIcon: PChar;
  lGraphic: TGraphic;
  LIsCustomShield: Boolean;
begin
  if (Instruction.Color <> clNone) and ((MainIcon = tdiNone) or (Instruction.ShowAtTop)) then
  begin
    lRect := GetRect(psInstructBounds);
    FillBackground(Canvas, lRect, Instruction.Color);
  end;
  if Instruction.HasCustomGlyph or Instruction.HasGlyph then
  begin
    if (Instruction.Icon in KnownIcons) then
    begin
      lGraphic := CreateGraphic(Instruction.Icon, isLarge);
      try
        if lGraphic is TIcon then
        begin
          lIcon := GetIcon(Instruction.Icon, LIsCustomShield);
          if (lIcon <> nil) and not LIsCustomShield then
            TIcon(lGraphic).Handle := LoadImage(0, lIcon, IMAGE_ICON, AFFS(32), AFFS(32), LR_DEFAULTCOLOR)
          else if LIsCustomShield then
            TIcon(lGraphic).Handle := LoadImage(hInstance, LIcon, IMAGE_ICON, AFFS(32), AFFS(32), LR_DEFAULTCOLOR);
        end;
        ACanvas.Draw(ARect.Left - lGraphic.Width - 8, ARect.Top, lGraphic);
        inc(lRect.Left, (3 * FVertMargin) + FVertSpacing);
      finally
        lGraphic.Free;
      end;
    end
    else if ValidPicture(Instruction.Glyph) then
    begin
      Instruction.Glyph.Graphic.Transparent := True;
      if Instruction.Text <> '' then
        ACanvas.Draw(ARect.Left - Instruction.Glyph.Graphic.Width - AFFS(8), ARect.Top, Instruction.Glyph.Graphic)
      else
        ACanvas.Draw(ARect.Left, ARect.Top, Instruction.Glyph.Graphic);
    end;
  end;
end;

procedure TJSCustomDialog.PositionButtonBarButtons;
var
  lLeft: Integer;
  i: Integer;
  lBtn: TControl;
  lWidthOfButtons: Integer;
  lRect: TRect;
begin
  if FCreatedButtonBarButtons = nil then
    Exit;
  lRect := GetRect(psButtonBar);
  if not FEmulateMessageDlg then
    lLeft := 0
  else
  begin
    lWidthOfButtons := 0;
    for i := FCreatedButtonBarButtons.Count - 1 downto 0 do
      inc(lWidthOfButtons, TControl(FCreatedButtonBarButtons[i]).Width);
    inc(lWidthOfButtons, (FCreatedButtonBarButtons.Count - 1) * FButtonSpacing);
    lLeft := (FClientWidth - lWidthOfButtons) div 2;
  end;
  FWidthOfLastCommonButton := 0;
  if FEmulateMessageDlg then
  begin
    for i := 0 to FCreatedButtonBarButtons.Count - 1 do
    begin
      lBtn := TControl(FCreatedButtonBarButtons[i]);
      if not FEmulateMessageDlg then
      begin
        if i = FCreatedButtonBarButtons.Count - 1 then
          lLeft := lRect.Right - lBtn.Width - (2 * FButtonSpacing)
        else
          dec(lLeft, lBtn.Width + FButtonSpacing);
      end;

      if Expando.Visible and Verification.Visible then
        lBtn.Top := (lRect.Bottom - lRect.Top - lBtn.Height) div 2 + lRect.Top - 9
      else
        lBtn.Top := (lRect.Bottom - lRect.Top - lBtn.Height) div 2 + lRect.Top;

      lBtn.Left := lLeft;
      if FEmulateMessageDlg then
        inc(lLeft, lBtn.Width + FButtonSpacing);

      if Expando.ShowInFooter then
        LBtn.Anchors := [akRight, akTop]
      else
        LBtn.Anchors := [akRight, akBottom];
    end;
  end
  else
  begin
    for i := FCreatedButtonBarButtons.Count - 1 downto 0 do
    begin
      lBtn := TControl(FCreatedButtonBarButtons[i]);
      if i = FCreatedButtonBarButtons.Count - 1 then
      begin
        if BiDiMode = bdLeftToRight then
          lLeft := lRect.Right - lBtn.Width - (2 * FButtonSpacing) - 2
        else
          LLeft := FLeftMargin;
      end
      else
      begin
        if BiDiMode = bdLeftToRight then
          dec(lLeft, lBtn.Width + FButtonSpacing + 2)
        else
          Inc(LLeft, LBtn.Width + FButtonSpacing + 2);
      end;

      if Expando.Visible and Verification.Visible then
        lBtn.Top := (lRect.Bottom - lRect.Top - lBtn.Height) div 2 + lRect.Top - 9
      else
        lBtn.Top := (lRect.Bottom - lRect.Top - lBtn.Height) div 2 + lRect.Top;
      lBtn.Left := lLeft;

      if Expando.ShowInFooter then
      begin
        if BiDiMode = bdLeftToRight then
          LBtn.Anchors := [akRight, akTop]
        else
          LBtn.Anchors := [akLeft, akTop];
      end
      else
      begin
        if BiDiMode = bdLeftToRight then
          LBtn.Anchors := [akRight, akBottom]
        else
          LBtn.Anchors := [akLeft, akBottom];
      end;
      FWidthOfLastCommonButton := LBtn.Width;
    end;
    // FFirstButtonLeftPos is used when aligning ButtonBar buttons and custom buttons on the same line
    if FCreatedButtonBarButtons.Count > 0 then
      FFirstButtonLeftPos := lLeft + FButtonSpacing;
  end;
end;

procedure TJSCustomDialog.PositionControls;
begin
  if FForm = nil then
    exit;
  FCalcLayout := True;
  try
    PositionInstruction;
    PositionContent;
    PositionRadioButtons;
    PositionHelpLinkLabel;
    if ShowCommandLinks then
      PositionCustomButtons;
    PositionProgressBar;
    PositionButtonBarButtons;
    if not ShowCommandLinks then
      PositionCustomButtons;
    PositionExpandoButton;
    PositionVerificationCheckBox;
    PositionMoreLines;
    PositionMoreRichEdit;
    PositionFooter;
    if FInvalidateOnPosition and (FForm <> nil) then
    begin
      FForm.Invalidate;
      FInvalidateOnPosition := False;
    end;
  finally
    FCalcLayout := False;
  end
end;

procedure TJSCustomDialog.PositionCustomButtons;
var
  i: Integer;
  lBtn: TControl;
  lTop: Integer;
  lLeft: Integer;
  lRect: TRect;
  lRightMargin: Integer;
  LLastBtnWidth: Integer;
begin
  if FCreatedCustomButtons = nil then
    Exit;
  if ShowCommandLinks then
  begin
    lRect := GetRect(psCommand);
    lTop := lRect.Top + 2;
    for i := 0 to FCreatedCustomButtons.Count - 1 do
    begin
      lBtn := TControl(FCreatedCustomButtons[i]);
      lBtn.SetBounds(FLeftMargin, lTop, FClientWidth - FLeftMargin - FRightMargin, lBtn.Height);
      inc(lTop, lBtn.Height);
    end;
  end
  else
  begin
    lRect := GetRect(psButtonBar);
    if FFirstButtonLeftPos <> -1 then
      lRightMargin := FFirstButtonLeftPos
    else
    begin
      if BiDiMode = bdLeftToRight then
        lRightMargin := lRect.Right
      else
        LRightMargin := 10 - FButtonSpacing;
    end;
    lLeft := 0;
    LLastBtnWidth := 0;
    for i := FCreatedCustomButtons.Count - 1 downto 0 do
    begin
      lBtn := TControl(FCreatedCustomButtons[i]);
      if BiDiMode = bdLeftToRight then
      begin
        if i = FCreatedCustomButtons.Count - 1 then
          lLeft := lRightMargin - lBtn.Width - (2 * FButtonSpacing) - 2
        else
          dec(lLeft, lBtn.Width + FButtonSpacing + 2);
      end
      else
      begin
        if i = FCreatedCustomButtons.Count - 1 then
        begin
          lLeft := lRightMargin + FWidthOfLastCommonButton + FButtonSpacing;
        end
        else
          Inc(lLeft, LLastBtnWidth + FButtonSpacing + 2);
      end;
      lBtn.Left := lLeft;
      LLastBtnWidth := LBtn.Width;
      if Expando.Visible and Verification.Visible then
        lBtn.Top := (lRect.Bottom - lRect.Top - lBtn.Height) div 2 + lRect.Top - 9
      else
        lBtn.Top := (lRect.Bottom - lRect.Top - lBtn.Height) div 2 + lRect.Top;
    end;
  end;
end;

procedure TJSCustomDialog.PositionFooter;
var
  lRect: TRect;
  lHeight: Integer;
  LLeft: Integer;
begin
  if FFooterLabel <> nil then
  begin
    lRect := GetRect(psFooter);
    FFooterLabel.Top := lRect.Top + FVertMargin + FooterOffSetV[IsVista];
    if Footer.Icon <> tdiNone then
    begin
      LLeft := AFFS(11);
      if (Footer.ImageAlignment <> jsImageAlignRight) or (BiDiMode <> bdLeftToRight) then
      begin
        Inc(LLeft, GetFooterImageWidth);
        Inc(LLeft, FHorzSpacing);
      end;
      FFooterLabel.Left := LLeft;
      FFooterLabel.Width := FClientWidth - FFooterLabel.Left - FHorzSpacing;
      if (Footer.ImageAlignment = jsImageAlignRight) or (BiDiMode <> bdLeftToRight) then
        FFooterLabel.Width := FFooterLabel.Width - FHorzSpacing - GetFooterImageWidth;
    end
    else
    begin
      FFooterLabel.Left := AFFS(11);
      FFooterLabel.Width := FClientWidth - FHorzSpacing - FRightMargin;
    end;
    FFooterLabel.Text.Text := FFooter.Text;
    FFooterLabel.Visible := FFooter.Visible;
    if FClientWidth <= 0 then
      lHeight := AFFS(13)
    else
      lHeight := TJSCaption.MinimumHeight(FForm.Canvas, Footer.Text, Footer.Font, FFooterLabel.Width);
    FFooterLabel.Height := lHeight;
    if Expando.Visible and Expando.ShowInFooter then
      FFooterLabel.Anchors := [akLeft, akTop]
    else
      FFooterLabel.Anchors := [akLeft, akBottom];
  end;
end;

procedure TJSCustomDialog.PositionHelpLinkLabel;
var
  lRect: TRect;
  LHeight: Integer;
begin
  if FHelpLinkLabel <> nil then
  begin
    lRect := GetRect(psHelpLink);
    FHelpLinkLabel.Left := FLeftMargin;
    FHelpLinkLabel.Top := lRect.Top;
    FHelpLinkLabel.Width := FClientWidth - FLeftMargin - FRightMargin;
    if FClientWidth <= 0 then
      LHeight := AFFS(13)
    else
      LHeight := TJSCaption.MinimumHeight(FForm.Canvas, HelpLink.Text, HelpLink.Font, FClientWidth - FHorzSpacing - LeftMargin);
    FHelpLinkLabel.Height := Max(LHeight, AFFS(13));
    FHelpLinkLabel.Text.Text := HelpLink.Text;

//    FHelpLinkLabel.Height := lRect.Bottom - lRect.Top;
  end;
end;

procedure TJSCustomDialog.PositionInstruction;
var
  lRect: TRect;
begin
  if FInstructionLabel <> nil then
  begin
    lRect := GetRect(psInstruction);
    FInstructionLabel.Top := lRect.Top;
    if Instruction.ShowAtTop then
    begin
      if Instruction.GlyphAvailable then
      begin
        FInstructionLabel.Left := FLeftMargin;
        FInstructionLabel.Width := lRect.Right - lRect.Left;
      end
      else
      begin
        FInstructionLabel.Left := AFFS(10);
        FInstructionLabel.Width := FForm.ClientWidth - AFFS(10) - FRightMargin;
      end;
    end
    else
    begin
      FInstructionLabel.Left := FLeftMargin;
      FInstructionLabel.Width := lRect.Right - lRect.Left;
    end;
    FInstructionLabel.Height := lRect.Bottom - lRect.Top;
    FInstructionLabel.Text.Text := FInstruction.Text;
    FInstructionLabel.Visible := FInstruction.Text <> '';
  end;
end;

procedure TJSCustomDialog.PositionContent;
var
  lRect: TRect;
begin
  if (FContentLabel <> nil) then
  begin
    lRect := GetRect(psContent);
    FContentLabel.Top := lRect.Top;
    FContentLabel.Height := lRect.Bottom - lRect.Top;
    FContentLabel.Left := FLeftMargin;
    FContentLabel.Width := lRect.Right - lRect.Left;
    FContentLabel.Text.Text := Content.Text;
    FContentLabel.Visible := Content.Text <> '';
  end;
  if (FContentMaxLines <> nil) then
  begin
    lRect := GetRect(psContent);
    FContentMaxLines.Top := lRect.Top;
    FContentMaxLines.Left := FLeftMargin;
    FContentMaxLines.Height := lRect.Bottom - lRect.Top;
    FContentMaxLines.Width := lRect.Right - lRect.Left;
    TMemo(FContentMaxLines).Lines.Text := StripFormatting(Content.Text);
    FContentMaxLines.Visible := Content.Text <> '';
  end;
end;

procedure TJSCustomDialog.PositionRadioButtons;
var
  i: Integer;
  lBtn: TJSRadioButtonCtrl;
  lRect: TRect;
  lTop: Integer;
  lContentRect: TRect;
begin
  if not (doRadioButtons in FDialogOptions) then
    exit;
  if FCreatedRadioButtons = nil then
    exit;
  lRect := GetRect(psRadio);
  lTop := lRect.Top;
  Inc(LTop, FVertMargin);
  if (RadioButton.ShowBorder) and (FRadioGroup <> nil) then
  begin
    lContentRect := GetRect(psContent);
    if lContentRect.Bottom - lContentRect.Top = 0 then
      FRadioGroup.SetBounds(FLeftMargin, lTop,
        FClientWidth - FLeftMargin - FRightMargin, lRect.Bottom - lRect.Top - FVertMargin - FVertMargin)
    else
      FRadioGroup.SetBounds(FLeftMargin, lTop,
        FClientWidth - FLeftMargin - FRightMargin, lRect.Bottom - lRect.Top - FVertMargin);
  end
  else
  begin
    for i := 0 to FCreatedRadioButtons.Count - 1 do
    begin
      lBtn := TJSRadioButtonCtrl(FCreatedRadioButtons[i]);
      lBtn.SetBounds(FLeftMargin + AFFS(8), lTop, FClientWidth - FLeftMargin - AFFS(8) - FRightMargin, GetCtrlHeight(lBtn.Font.Handle));
      inc(lTop, lBtn.Height + (2 * FVertSpacing) - AFFS(1)); // radio spacing
    end;
  end;
end;

procedure TJSCustomDialog.PositionVerificationCheckBox;
var
  lRect: TRect;
begin
  if not FAssigning then
  begin
    if FVerificationCheckBox <> nil then
    begin
      lRect := GetRect(psButtonBar);
      if FExpando.Visible then
        FVerificationCheckBox.Top := lRect.Top + FShowMoreButton.Height + FVertSpacing + AFFS(11)
      else
        FVerificationCheckBox.Top := lRect.Top + AFFS(15);
      if EmulateMessageDlg then
      begin
        if not Expando.Visible then
          FVerificationCheckBox.Top := lRect.Bottom
        else
          FVerificationCheckBox.Top := lRect.Bottom + FVertSpacing;
      end;
      if BiDiMode = bdLeftToRight then
        FVerificationCheckBox.Left := lRect.Left + AFFS(12)
      else
        FVerificationCheckBox.Left := FClientWidth - FVerificationCheckBox.Width - AFFS(12);
      if Expando.ShowInFooter then
        FVerificationCheckBox.Anchors := [akLeft, akTop]
      else
        FVerificationCheckBox.Anchors := [akLeft, akBottom];
    end;
  end;
end;

procedure TJSCustomDialog.ProgressChangeHandler(Sender: TObject);
var
  lProgressBar: TJSProgressBar;
  lProgressBarEx: TJSProgressBarEx;
begin
  if csDestroying in ComponentState then
    exit;
  if FProgressBar <> nil then
  begin
    if FProgressBar is TJSProgressBar then
    begin
      lProgressBar := FProgressBar as TJSProgressBar;
      lProgressBar.Max := FProgress.Max;
      //lProgressBar.Min := FProgress.Min;
      lProgressBar.Position := FProgress.Position;
      lProgressBar.State := FProgress.FState;
      lProgressBar.Interval := FProgress.Interval;
    end
    else if FProgressBar is TJSProgressBarEx then
    begin
      lProgressBarEx := FProgressBar as TJSProgressBarEx;
      lProgressBarEx.Max := FProgress.Max;
      lProgressBarEx.Position := FProgress.Position;
      lProgressBarEx.State := {$IFDEF DELPHI2009}ComCtrls.{$ENDIF}TProgressBarState(ord(FProgress.FState));
      lProgressBarEx.Interval := FProgress.Interval;
    end;
  end;
end;

procedure TJSCustomDialog.RadioButtonClickHandler(Sender: TObject);
var
  lHandled: Boolean;
begin
  lHandled := False;
  if Sender is TRadioGroup then
    DoControlClick(Sender, ctRadioGroup, BASE_RADIOBUTTON + TRadioGroup(Sender).ItemIndex, lHandled)
  else
    DoControlClick(Sender, ctRadioButton, TComponent(Sender).Tag, lHandled);
end;

procedure TJSCustomDialog.RecreateControls;
begin
  if FVerificationCheckBox <> nil then
  begin
    FreeAndNil(FVerificationCheckBox);
    CreateVerificationCheckBox;
  end;
  if FShowMoreButton <> nil then
  begin
    FreeAndNil(FShowMoreButton);
    CreateExpandoButton;
  end;
  if FMoreRichEdit <> nil then
  begin
    FreeAndNil(FMoreRichEdit);
    CreateMoreInFooter;
  end;
end;

procedure TJSCustomDialog.ReinitialiseControls;
var
  i: Integer;
begin
  if FCreatedRadioButtons <> nil then
  begin
    for i := 0 to FCreatedRadioButtons.Count - 1 do
      FCreatedRadioButtons[i].Free;
    FCreatedRadioButtons.Clear;
    FreeAndNil(FCreatedRadioButtons);
  end;
  if FCreatedCustomButtons <> nil then
  begin
    for i := 0 to FCreatedCustomButtons.Count - 1 do
      FCreatedCustomButtons[i].Free;
    FCreatedCustomButtons.Clear;
    FreeAndNil(FCreatedCustomButtons);
  end;
  if FCreatedButtonBarButtons <> nil then
  begin
    for i := 0 to FCreatedButtonBarButtons.Count - 1 do
      FCreatedButtonBarButtons[i].Free;
    FreeAndNil(FCreatedButtonBarButtons);
  end;
  FreeAndNil(FShowMoreButton);
  FreeAndNil(FVerificationCheckBox);
  FreeAndNil(FProgressBar);
  if FForm <> nil then 
    FVerification.InitialState := FVerificationResult; 
end;

class function TJSCustomDialog.RequiredWidth(const ALine: string; AFontType: TJSFontType): Integer;
var
  LDC: HDC;
  LCanvas: TCanvas;
begin
  LCanvas := TCanvas.Create;
  try
    LDC := GetDC(0);
    try
      LCanvas.Handle := LDC;
      LCanvas.Font.Assign(GetRegisteredFont(AFontType));
      Result := LCanvas.TextWidth(ALine);
    finally
      DeleteDC(LDC);
    end;
  finally
    LCanvas.Free;
  end;
end;

procedure TJSCustomDialog.ResetProgressBar;
var
  lProgress: TControl;
begin
  lProgress := GetControl(ctProgressBar);
  if lProgress is TJSProgressBar then
  begin
    (lProgress as TJSProgressBar).Deactivate;
    (lProgress as TJSProgressBar).Activate(Progress.Interval);
  end
  else if lProgress is TJSProgressBarEx then
  begin
    if (doProgressBarMarquee in DialogOptions) then
    begin
      (lProgress as TJSProgressBarEx).Active := False;
      (lProgress as TJSProgressBarEx).Active := True;
    end;
  end;
end;

function TJSCustomDialog.RetrievePlainTextFromRichEdit: TJSString;
var
  LRichEdit: TJSRichEdit;
  LStream: TMemoryStream;
begin
  LRichEdit := TJSRichEdit.Create(nil);
  try
    LRichEdit.Parent := Form;
    LRichEdit.SetBounds(-MAXINT, -MAXINT, Form.Width, Form.Height);
    LRichEdit.ScrollBars := ssBoth;
    LStream := TMemoryStream.Create;
    try
      FMoreRichEdit.Lines.SaveToStream(LStream);
      LStream.Seek(0, soFromBeginning);
      LRichEdit.PlainText := False;
      LRichEdit.Lines.LoadFromStream(LStream);
      LRichEdit.PlainText := True;
      Result := LRichEdit.Lines.Text;
    finally
      LStream.Free;
    end;
  finally
    LRichEdit.Free;
  end;
end;

procedure TJSCustomDialog.SetActiveControlType(const Value: TControlType);
begin
  if FActiveControlType <> Value then
  begin
    FActiveControlType := Value;
    // allow for setting when the dialog is actually being displayed??
  end;
end;

procedure TJSCustomDialog.SetBorder(const Value: TJSBorder);
begin
  FBorder.Assign(Value);
end;

procedure TJSCustomDialog.SetButton(const Value: TJSButtonOptions);
begin
  FButton.Assign(Value);
end;

procedure TJSCustomDialog.SetButtonBar(const Value: TJSButtonBarOptions);
begin
  FButtonBar.Assign(Value);
end;

procedure TJSCustomDialog.SetChecked(const aValue: Integer; const aChecked: Boolean);
var
  i: Integer;
begin
  for i := 0 to FRadioButtons.Count - 1 do
  begin
    if FRadioButtons[i].Value = aValue then
      FRadioButtons[i].Checked := aChecked;
  end;
end;

procedure TJSCustomDialog.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FBackground.Color := Value;
    if FForm <> nil then
      FForm.Invalidate;
  end;
end;

procedure TJSCustomDialog.SetCustomButtonResult(const Value: Integer);
begin
  FCustomButtonResult := Value;
end;

procedure TJSCustomDialog.SetCustomButtons(const Value: TJSCustomButtons);
begin
  FCustomButtons.Assign(Value);
end;

procedure TJSCustomDialog.SetDialogOptions(const Value: TDialogOptions);
begin
  if FDialogOptions <> Value then
  begin
    FDialogOptions := Value;
    if csDesigning in ComponentState then
      exit;
    ReinitialiseControls;
    if not FAssigning and (FForm <> nil) then
    begin
      CreateControls;
      PositionControls;
    end;
  end;
end;

procedure TJSCustomDialog.SetDialogStyle(const Value: TJSDialogStyle);
begin
  if FDialogStyle <> Value then
    FDialogStyle := Value;
end;

procedure TJSCustomDialog.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TJSCustomDialog.SetFooter(const Value: TJSFooter);
begin
  FFooter.Assign(Value);
  if not FAssigning and (FForm <> nil) then
    PositionControls;
end;

procedure TJSCustomDialog.SetForm(const Value: TJSCustomTaskDialogForm);
begin
  FForm := Value;
end;

procedure TJSCustomDialog.SetGlyph(const Value: TPicture);
begin
  FGlyph.Assign(Value);
  if not FAssigning and (FForm <> nil) then
  begin
    PositionControls;
    FForm.Invalidate;
    if Canvas.HandleAllocated then
      PaintGlyph(Canvas, GetRect(psGlyph));
  end;
end;

procedure TJSCustomDialog.SetHeader(const Value: TJSHeader);
begin
  FHeader.Assign(Value);
  if not FAssigning and (FForm <> nil) then
    PositionControls;
end;

procedure TJSCustomDialog.SetHelpLink(const Value: TJSHelpLink);
begin
  FHelpLink.Assign(Value);
  if not FAssigning and (FForm <> nil) then
    PositionControls;
end;

procedure TJSCustomDialog.SetMainIcon(const Value: TTaskDialogIcon);
var
  lHasGlyph: Boolean;
  lSize: TJSSizeComparer;
  lPositionChange: Boolean;
begin
  if Value in [tdiNone] then
    Glyph.Assign(nil);
  lHasGlyph := ValidPicture(Glyph);
  if lHasGlyph then
    lSize := TJSSizeComparer.Create(Glyph.Graphic.Width, Glyph.Graphic.Height)
  else
    lSize := nil;
  try
    FMainIcon := Value;
    if FForm <> nil then
    begin
      TJSCustomDialog.SetTaskIcon(FMainIcon, Glyph);
      if ValidPicture(Glyph) and (lSize <> nil) then
        lPositionChange := not lSize.IsEqual(Glyph.Graphic.Width, Glyph.Graphic.Height)
      else
        lPositionChange := True;
      if lPositionChange then
      begin
        PositionControls;
        FForm.Invalidate;
      end
      else if Canvas.HandleAllocated then
        PaintGlyph(Canvas, GetRect(psGlyph));
    end;
  finally
    lSize.Free;
  end;
end;

procedure TJSCustomDialog.SetLines(const Value: TJSStrings);
begin
  FContent.Assign(Value);
  if (not FAssigning) then
    PositionControls;
end;

procedure TJSCustomDialog.SetLocation(const Value: TJSLocation);
begin
  FLocation.Assign(Value);
end;

procedure TJSCustomDialog.SetModalResult(const Value: TModalResult);
begin
  FModalResult := Value;
end;

procedure TJSCustomDialog.SetExpando(const Value: TJSExpando);
begin
  FExpando.Assign(Value);
end;

procedure TJSCustomDialog.SetPlaySounds(const Value: Boolean);
begin
  if FPlaySounds <> Value then
    FPlaySounds := Value;
end;

procedure TJSCustomDialog.SetProgress(const Value: TJSProgress);
begin
  FProgress.Assign(Value);
end;

procedure TJSCustomDialog.SetProgressState(const aState: TProgressBarState);
var
  LState: Integer;
begin
  FProgress.State := aState;
  if FProgressBar <> nil then
  begin
    {$IFDEF DELPHI2009}
    if FProgressBar is TProgressBar then
      TProgressBar(FProgressBar).State := {$IFDEF DELPHI2009}ComCtrls.{$ENDIF}TProgressBarState(ord(AState))
    else
    {$ENDIF DELPHI2009}
    if FProgressBar is TJSProgressBar then
      TJSProgressBar(FProgressBar).State := TProgressBarState(ord(aState))
    else if FProgressBar is TJSProgressBarEx then
      TJSProgressBarEx(FProgressBar).State := {$IFDEF DELPHI2009}ComCtrls.{$ENDIF}TProgressBarState(ord(aState))
    else if Assigned(FOnUpdateProgressBarState) then
      DoUpdateProgressBarState(TProgressBarState(ord(aState)));
    if ShowProgressBarOnTaskBar then
    begin
      case AState of
        pbstError: LState := TBPF_ERROR;
        pbstPaused: LState := TBPF_PAUSED;
      else
        LState := TBPF_NORMAL;
      end;
      FTaskBarProgressImpl.SetProgressState(LState);
    end;
  end;
end;

procedure TJSCustomDialog.SetRadioButton(const Value: TJSRadioButton);
begin
  FRadioButton.Assign(Value);
end;

procedure TJSCustomDialog.SetRadioButtons(const Value: TJSRadioButtons);
begin
  FRadioButtons.Assign(Value);
end;

procedure TJSCustomDialog.SetRadioResult(const Value: Integer);
begin
  FRadioResult := Value;
end;

procedure TJSCustomDialog.SetSheet(const Value: TJSSheetOptions);
begin
  FSheet.Assign(Value);
end;

procedure TJSCustomDialog.SetShowHint(const Value: Boolean);
begin
  if FShowHint <> Value then
  begin
    FShowHint := Value;
    if FForm <> nil then
      FForm.ShowHint := Value;
  end;
end;

class procedure TJSCustomDialog.SetTaskIcon(const aIcon: TTaskDialogIcon; aGlyph: TPicture);
var
  lIconId: PChar;
  LIsCustomShield: Boolean;
begin
  if aIcon = tdiNone then
    aGlyph.Assign(nil)
  else if not (aIcon in [tdiCustom]) then
  begin
    lIconId := GetIcon(aIcon, LIsCustomShield);
    if (lIconId <> nil) and not LIsCustomShield then
    begin
      aGlyph.Icon.Handle := LoadIcon(0, lIconId)
    end
    else if LIsCustomShield then
      aGlyph.Bitmap.LoadFromResourceName(hInstance, JSD_SHIELD)
    else
      aGlyph.Assign(nil);
  end;
end;

procedure TJSCustomDialog.SetText(const Value: TJSString);
begin
  if FText <> Value then
  begin
    FText := Value;
  end;
end;

procedure TJSCustomDialog.SetTimer(const Value: TJSTimer);
begin
  FTimer.Assign(Value);
end;

procedure TJSCustomDialog.SetTitle(const Value: TJSString);
var
  LStr: AnsiString; 
begin 
  if FTitle <> Value then 
  begin 
    FTitle := Value; 
    if FForm <> nil then
    begin
      {$IFDEF TNTUnicode}
      FForm.Caption := Value;
      {$ELSE}
        {$IFDEF UNICODE}
        LStr := JSAnsiStringFromUnicodeWideString(Value, Font.Charset);
        FForm.Caption := LStr;
        {$ELSE}
        if JSSupportsUnicode then
        begin
          LStr := JSAnsiStringFromUnicodeWideString(Value, Font.Charset);
          {$WARNINGS OFF}
          FForm.Caption := LStr;
          {$WARNINGS ON}
        end
        else
        begin
          {$IFDEF FORCEUNICODE}
          LStr := JSAnsiStringFromUnicodeWideString(Value, Font.Charset);
          FForm.Caption := LStr;
          {$ELSE}
          FForm.Caption := Value;
          {$ENDIF FORCEUNICODE}
        end;
        {$ENDIF UNICODE}
      {$ENDIF TNTUnicode}
    end;
  end; 
end; 
procedure TJSCustomDialog.SetIcon(const Value: TIcon);
begin
  FIcon.Assign(Value);
end;

procedure TJSCustomDialog.SetUnchecked(const aValue: Integer);
var
  i: Integer;
begin
  for i := 0 to FRadioButtons.Count - 1 do
  begin
    if (aValue <> -1) and (FRadioButtons[i].Value = aValue) then
      FRadioButtons[i].Checked := False
    else
      FRadioButtons[i].Checked := False;
  end;
end;

procedure TJSCustomDialog.SetUseDefaultFonts(const Value: Boolean);
begin
  FUseDefaultFonts := Value;
end;

procedure TJSCustomDialog.SetInstruction(const Value: TJSInstruction);
begin
  FInstruction.Assign(Value);
end;

procedure TJSCustomDialog.SetVerification(const Value: TJSVerification);
begin
  FVerification.Assign(Value);
  if (not FAssigning) then
    PositionControls;
end;

procedure TJSCustomDialog.SetVerificationResult(const Value: Boolean);
begin
  if FVerificationResult <> Value then
    FVerificationResult := Value;
end;

procedure TJSCustomDialog.SetWidth(const Value: Integer);
var
  LHeight: Integer;
  LWidth: Integer;
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    if FForm <> nil then
    begin
      CalculateAutoSize(LHeight, LWidth);
      PositionControls;
    end;
  end;
end;

procedure TJSCustomDialog.Show;
begin
  if (FForm <> nil) and (not (doModal in DialogOptions)) then
    FForm.Show;
end;

procedure TJSCustomDialog.ShowCommandLinkHotKeys;
var
  i: Integer;
begin
  if not ShowCommandLinks then
    exit;
  for i := 0 to FCreatedCustomButtons.Count - 1 do
    TJSCommandLinkButton(FCreatedCustomButtons[i]).ShowHotKey := True;
end;

function TJSCustomDialog.ShowCommandLinks: Boolean;
begin
  result := (doCommandLinks in FDialogOptions) or (doCommandLinksNoIcon in FDialogOptions);
end;

procedure TJSCustomDialog.ExpandDialog(const AExpand: Boolean);
var
  LHeight: Integer;
  LWidth: Integer;
begin
  FExpanding := AExpand;
  FCollapsing := not AExpand;
  try
    FExpandingHeight := FForm.ClientHeight;
    if AExpand then
    begin
      FShowMoreButton.Caption := FExpando.HideText;
      DoExpand;
    end
    else
    begin
      FShowMoreButton.Caption := FExpando.ShowText;
      if FMoreLinesLabel <> nil then
        FMoreLinesLabel.Visible := False;
      DoCollapse;
    end;
    if Expando.Animate.Enabled then
    begin
      if AExpand then
      begin
        FExpandedAmount := 0;
        FExpandedHeight := 0;
        CalculateAutoSize(LHeight, LWidth, False);
        FExpandedHeight := LHeight;
        FExpandedAmount := LHeight - FForm.ClientHeight;
        FExpandedLeftOver := 0;
        LHeight := FForm.Height;
        while FForm.ClientHeight < FExpandedHeight do
        begin
          Inc(LHeight, Expando.Animate.Step);
          Inc(FExpandedLeftOver, Expando.Animate.Step);
          sleep(Expando.Animate.Speed);
          FForm.Height := LHeight;
          if Expando.Visible and not Expando.ShowInFooter then
            FForm.Invalidate;
          Application.ProcessMessages;
          if Expando.ShowInFooter and (Expando.MoreFormat = mfRTF) then
            PositionMoreRichEdit;
        end;
        FExpandedHeight := -1;
      end
      else
      begin
        FExpandedAmount := 0;
        FExpandedHeight := 0;
        CalculateAutoSize(LHeight, LWidth, False);
        FExpandedHeight := LHeight;
        FExpandedAmount := FForm.ClientHeight - LHeight;
        LHeight := FForm.Height;
        FExpandedLeftOver := FExpandedAmount;
        while FForm.ClientHeight > FExpandedHeight do
        begin
          Dec(LHeight, Expando.Animate.Step);
          Dec(FExpandedLeftOver, Expando.Animate.Step);
          FForm.Height := LHeight;
          sleep(Expando.Animate.Speed);
          if Expando.Visible and not Expando.ShowInFooter then
            FForm.Invalidate;
          Application.ProcessMessages;
          if Expando.ShowInFooter and (Expando.MoreFormat = mfRTF) then
            PositionMoreRichEdit;
        end;
        FExpandedHeight := -1;
      end;
    end;
    FExpanding := False;
    FCollapsing := False;
    CalculateAutoSize(LHeight, LWidth);
    if AExpand then
    begin
      if (FMoreRichEdit <> nil) and (not FMoreRichEdit.Visible) then
        FMoreRichEdit.Width := FClientWidth - (2 * FHorzSpacing);
    end;
    if Expando.Visible and not Expando.ShowInFooter then
      FForm.Invalidate;
    PositionControls;
  finally
    FExpanding := False;
    FCollapsing := False;
  end;
end;

procedure TJSCustomDialog.ShowMoreButtonCollapsedHandler(Sender: TObject);
begin
  ExpandDialog(False);
end;

procedure TJSCustomDialog.ShowMoreButtonExpandedHandler(Sender: TObject);
begin
  ExpandDialog(True);
end;

function TJSCustomDialog.ShowProgressBar: Boolean;
begin
  result := (doProgressBar in DialogOptions) or (doProgressBarMarquee in DialogOptions);
end;

function TJSCustomDialog.ShowProgressBarOnTaskBar: Boolean;
begin
  Result := ShowProgressBar and FProgress.ShowOnTaskBar;
end;

function TJSCustomDialog.ShowRadioButtons: Boolean;
begin
  result := (doRadioButtons in DialogOptions) and (FRadioButtons.Count > 0);
end;

function TJSCustomDialog.StripFormatting(const AStr: string): string;
begin
  Result := StringReplace(AStr, '<b>', '', [rfReplaceAll]);
  Result := StringReplace(Result, '</b>', '', [rfReplaceAll]);
  Result := StringReplace(Result, '<i>', '', [rfReplaceAll]);
  Result := StringReplace(Result, '</i>', '', [rfReplaceAll]);
  Result := StringReplace(Result, '<u>', '', [rfReplaceAll]);
  Result := StringReplace(Result, '</u>', '', [rfReplaceAll]);
end;

procedure TJSCustomDialog.TimerChangeHandler(Sender: TObject);
begin
  if FForm <> nil then
  begin
    TJSTaskDialogForm(FForm).EndTimer;
    if doTimer in DialogOptions then
      TJSTaskDialogForm(FForm).StartTimer;
  end;
end;

function TJSCustomDialog.UpdateProgress: Integer;
var
  lCloseDialog: Boolean;
begin
  Result := 0;
  if not IsDialogAvailable then
    Exit;
  if FProgressBar is TJSProgressBar then
  begin
    Result := UpdateProgress(TJSProgressBar(FProgressBar).Position, TJSProgressBar(FProgressBar).Step);
    if IsDialogAvailable then
      DoProgress(TJSProgressBar(FProgressBar).Position);
  end
  else if FProgressBar is TJSProgressBarEx then
  begin
    Result := UpdateProgress(TJSProgressBarEx(FProgressBar).Position, TJSProgressBarEx(FProgressBar).Step);
    if IsDialogAvailable then
      DoProgress(TJSProgressBarEx(FProgressBar).Position);
  end
  else if FProgressBar is TProgressBar then
  begin
    Result := UpdateProgress(TProgressBar(FProgressBar).Position, TProgressBar(FProgressBar).Step);
    if IsDialogAvailable then
      DoProgress(TProgressBar(FProgressBar).Position);
  end
  else
  begin
    lCloseDialog := False;
    DoUpdateProgressBar(-1, lCloseDialog);
    if ShowProgressBarOnTaskBar then
      FTaskBarProgressImpl.SetProgressState(TBPF_NOPROGRESS);
    if lCloseDialog then
    begin
      FProgress.Position := 0;
      Close(mrNone);
    end
    else
      DoProgress(FProgress.Position);
    Result := FProgress.Position;
  end;
end;

function TJSCustomDialog.UpdateProgress(const aPosition: Integer): Integer;
begin
  Result := UpdateProgress(aPosition, 0);
end;

procedure TJSCustomDialog.Update;
begin
  if FForm <> nil then
  begin
    if FProgressBar <> nil then
      FProgressBar.Invalidate;
    FForm.Update;
  end;
end;

procedure TJSCustomDialog.UpdateCustomButtonDetails(const aValue: Integer; const aCaption, aHint: TJSString;
  aInfo: TJSStrings);
var
  LControl: TControl;
  LIdx: Integer;
  LDefButtonWidth: Integer;
  LButtonWidth: Integer;
  LDialogUnits: TPoint;
  LHeight: Integer;
  LWidth: Integer;
begin
  LIdx := BASE_CUSTOMBUTTON - aValue;
  if (LIdx >= 0) and (LIdx < FCreatedCustomButtons.Count) then
  begin
    LControl := TControl(FCreatedCustomButtons[LIdx]);
    if LControl is TJSCommandLinkButton then
    begin
      TJSCommandLinkButton(LControl).Caption := aCaption;
      TJSCommandLinkButton(LControl).Hint := aHint;
      if aInfo <> nil then
        TJSCommandLinkButton(LControl).Info.Assign(aInfo);
    end
    else if LControl is TJSButton then
    begin
      TJSButton(LControl).Caption := aCaption;
      TJSButton(LControl).Hint := aHint;
      lDialogUnits := GetAveCharSize(Canvas);
      GetButtonWidth(FForm, Canvas, Font, aCaption, LDialogUnits, LDefButtonWidth, LButtonWidth);
      TJSButton(LControl).Width := Max(LDefButtonWidth, LButtonWidth);
    end;
  end;
  CalculateAutoSize(LHeight, LWidth);
  Update;
end;

procedure TJSCustomDialog.CreateCommonButton(ACommonBtn: TCommonButton;
  ADialogUnits: TPoint; AButtonHeight: Integer);
var
  lBtn: TControl;
  lButtonWidth: Integer;
  j: TCommonButton;
  lCalcRect: TRect;
  lFlags: Integer;
  lItem: TJSCustomButtonItem;
  LDefButtonWidth: Integer;
begin
  lBtn := DoGetControlClass(ctButton).Create(nil);
  lBtn.Parent := FForm;
  lBtn.Name := CommonButtonNames[ACommonBtn];
  TControlCracker(lBtn).Font := Font;
  lItem := TJSCustomButtonItem.Create(nil);
  try
    lItem.Caption := JSUnicodeWideStringFromCompilerString(CommonButtonCaptions(ACommonBtn));
    lItem.ModalResult := CommonButtonToModalResult(ACommonBtn);
    lItem.Default := ButtonBar.UseDefault and (ButtonBar.Default = ACommonBtn);
    lItem.Cancel := (ButtonBar.UseCancel) and (ButtonBar.Cancel = ACommonBtn);
    DoInitControl(ctButton, lBtn, lItem);
    if ACommonBtn = cbHelp then
      TControlCracker(lBtn).OnClick := HelpButtonClickHandler
    else
      TControlCracker(lBtn).OnClick := ButtonClickHandler;
    if lItem.Default then
    begin
      if lBtn is TWinControl then
        FFocusedControl := lBtn as TWinControl;
      FDefaultButton := lBtn;
    end;
    lBtn.Tag := lItem.ModalResult;

    GetButtonWidth(FForm, Canvas, Font, LItem.Caption, ADialogUnits, LDefButtonWidth, LButtonWidth);
    // Only change the buttons width if it is larger than the default button width
    if LButtonWidth < LDefButtonWidth then
      LButtonWidth := LDefButtonWidth;

    for j := Low(TCommonButton) to High(TCommonButton) do
    begin
      if j in ButtonBar.Buttons then
      begin
        if ButtonWidths[j] = 0 then
        begin
          lCalcRect := Rect(0, 0, 0, 0);
          lFlags := DT_CALCRECT or DT_LEFT or DT_SINGLELINE or FForm.DrawTextBiDiModeFlagsReadingOnly;
          JSDrawText(Canvas.Handle, lItem.Caption, Font, lCalcRect, lFlags, True);
          ButtonWidths[j] := lCalcRect.Right - lCalcRect.Left + AFFS(8);
        end;
        if ButtonWidths[j] > lButtonWidth then
          lButtonWidth := ButtonWidths[j];
      end;
    end;
    lBtn.Width := lButtonWidth;
    lBtn.Height := AButtonHeight;
    if FExpando.Visible and not FExpando.ShowInFooter then
      LBtn.Anchors := [akBottom, akRight];
    FCreatedButtonBarButtons.Add(lBtn);
  finally
    lItem.Free;
  end;
end;

procedure TJSCustomDialog.UpdateDialogResult;
begin
  // if no button was clicked, then the dialog must
  // have been closed with the X on the title bar
  if not FButtonClicked then
    ModalResult := mrCancel;
  FDialogResult.ModalResult := ModalResult;
  FDialogResult.VerificationResult := VerificationResult;
  FDialogResult.RadioResult := RadioResult;
  FDialogResult.CustomButtonResult := CustomButtonResult;
end;

function TJSCustomDialog.UpdateProgress(const aPosition, aStep: Integer): Integer;
var
  lCloseDialog: Boolean;
  LCheckProgress: Boolean;
begin
  if CanUpdateProgress then
  begin
    LCheckProgress := True;
    if FProgressBar is TJSProgressBar then
    begin
      TJSProgressBar(FProgressBar).Position := aPosition + aStep;
      FProgress.Position := TJSProgressBar(FProgressBar).Position;
    end
    else if FProgressBar is TJSProgressBarEx then
    begin
      TJSProgressBarEx(FProgressBar).Position := aPosition + aStep;
      FProgress.Position := TJSProgressBarEx(FProgressBar).Position;
    end
    else if FProgressBar is TProgressBar then
    begin
      TProgressBar(FProgressBar).Position := aPosition + aStep;
      FProgress.Position := TProgressBar(FProgressBar).Position;
    end
    else
    begin
      LCheckProgress := False;
      lCloseDialog := False;
      DoUpdateProgressBar(aPosition + aStep, lCloseDialog);
      if lCloseDialog then
      begin
        FProgress.Position := 0;
        Close(mrNone);
      end
      else
        DoProgress(FProgress.Position);
    end;
    if LCheckProgress then
    begin
      if FProgress.Position >= FProgress.Max then
      begin
        FProgress.Position := 0;
        Close(mrNone);
      end
      else
        DoProgress(FProgress.Position);
    end;
    Result := FProgress.Position;
  end
  else
    Result := 0;
end;

procedure TJSCustomDialog.DoInitControl(AControlType: TControlType; AControl: TControl; AControlItem: TCollectionItem);
var
  lHandled: Boolean;
begin
  lHandled := False;
  if Assigned(FOnInitControl) then
    FOnInitControl(Self, AControlType, AControl, AControlItem, lHandled);
  if not lHandled then
  begin
    InitialiseControl(AControlType, AControl, AControlItem);
  end;
end;

procedure TJSCustomDialog.DoKeyPressHandler(var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnKeyPress) then
    FOnKeyPress(Self, Key, Shift);
end;

procedure TJSCustomDialog.DoProgress(const APosition: Integer);
begin
  if ShowProgressBarOnTaskBar then
    FTaskBarProgressImpl.SetProgressValue(APosition, FProgress.Max);
  if Assigned(FOnProgress) then
    FOnProgress(Self, APosition);
end;

procedure TJSCustomDialog.DoShowDialogModal;
begin
  if DialogStyle = dsSheet then
    CalculateSheetPosition;
  FForm.ShowModal;
end;

procedure TJSCustomDialog.DoShowDialogNonModal;
begin
  if DialogStyle = dsSheet then
  begin
    CalculateSheetPosition;
    FForm.Visible := True;
  end
  else
    FForm.Show;
end;

procedure TJSCustomDialog.DoTimerEvent(const aTimeSince: Cardinal);
begin
  if Assigned(FOnTimer) then
    FOnTimer(Self, aTimeSince);
end;

procedure TJSCustomDialog.DoUpdateProgressBar(const APosition: Integer; var ACloseDialog: Boolean);
begin
  if Assigned(FOnUpdateProgressBar) then
    FOnUpdateProgressBar(Self, FProgressBar, APosition, ACloseDialog);
end;

procedure TJSCustomDialog.DoUpdateProgressBarState(AState: TProgressBarState);
begin
  if Assigned(FOnUpdateProgressBarState) then
    FOnUpdateProgressBarState(Self, FProgressBar, AState);
end;

procedure TJSCustomDialog.DoVerificationClick(const Checked: Boolean); 
begin 
  if Assigned(FOnVerificationClick) then 
    FOnVerificationClick(Self, Checked); 
end; 

procedure TJSCustomDialog.DoGetMoreStream(var aStream: TMemoryStream);
begin
  if Assigned(FOnGetMoreStream) then
    FOnGetMoreStream(Self, aStream);
end;

function TJSCustomDialog.DoGetRadioButtonChecked(AControl: TControl): Boolean;
var
  lHandled: Boolean;
begin
  lHandled := False;
  result := False;
  if Assigned(FOnGetRadioButtonChecked) then
    OnGetRadioButtonChecked(Self, AControl, result, lHandled);
  if not lHandled then
  begin
    if AControl is TJSRadioButtonCtrl then
      result := TJSRadioButtonCtrl(AControl).Checked;
  end;
end;

function TJSCustomDialog.DoGetVerificationResult: Boolean;
begin
  result := False;
  if FVerificationCheckBox <> nil then
  begin
    if (FVerificationCheckBox is TJSCheckBox) then
      result := (FVerificationCheckBox as TJSCheckBox).Checked
    else if Assigned(FOnGetVerificationResult) then
      FOnGetVerificationResult(Self, FVerificationCheckBox, result);
    FVerificationResult := result;
  end
  else
    result := FDialogResult.VerificationResult;
end;

function TJSCustomDialog.GetIconHeightFromIconSize(const aIconSize: TJSIconSize): Integer;
begin
  case aIconSize of
    isSmall: result := SMALL_ICONY;
    isMedium: result := MEDIUM_ICONY;
    isLarge: result := LARGE_ICONY;
  else
    result := 0;
  end;
  Result := AFFS(Result);
end;

procedure TJSCustomDialog.InitialiseControl(AControlType: TControlType; AControl: TControl;
  AControlItem: TCollectionItem);
var
  lCmdBtn: TJSCommandLinkButton;
  lBtnItem: TJSCustomButtonItem;
  {$IFNDEF DELPHI2009}
  lBtn: TButton;
  {$ELSE}
  lBtn: TCustomButton;
  {$ENDIF}
begin
  if AControl is TJSCommandLinkButton then
  begin
    lBtnItem := (AControlItem as TJSCustomButtonItem);
    lCmdBtn := (AControl as TJSCommandLinkButton);
    lCmdBtn.ModalResult := lBtnItem.ModalResult;
    lCmdBtn.Glyph := lBtnItem.Glyph;
    if (lBtnItem.ImageIndex > -1) and (lBtnItem.FOwner.Images <> nil) then
    begin
      lCmdBtn.GlyphIndex := lBtnItem.ImageIndex;
      lCmdBtn.GlyphImages := lBtnItem.FOwner.Images;
    end;
    lCmdBtn.Default := lBtnItem.Default;
    if EmulateMessageDlg then
      lCmdBtn.Style := jsbClassic;
    if lCmdBtn.Default then
    begin
      FFocusedControl := lCmdBtn;
      FDefaultButton := lCmdBtn;
    end;
    lCmdBtn.Cancel := lBtnItem.Cancel;
    lCmdBtn.Caption := lBtnItem.Caption;
    lCmdBtn.Enabled := lBtnItem.Enabled;
    lCmdBtn.OnClick := ButtonClickHandler;
    lCmdBtn.ShowHotKey := (FAcceleratorState and UISF_HIDEACCEL) = 0;
    lCmdBtn.Hint := lBtnItem.Hint;
  end
  {$IFNDEF DELPHI2009}
  else if (AControl is TJSButton) then
  {$ELSE}
  else if (AControl is TCustomButton) then
  {$ENDIF}
  begin
    lBtnItem := (AControlItem as TJSCustomButtonItem);
    {$IFNDEF DELPHI2009}
    lBtn := AControl as TJSButton;
    {$ELSE}
    lBtn := AControl as TCustomButton;
    {$ENDIF}
    lBtn.ModalResult := lBtnItem.ModalResult;
    {$IFNDEF DELPHI2009}
    {$IFDEF TNTUnicode}
    TJSButton(lBtn).Caption := lBtnItem.Caption;
    TJSButton(lBtn).Hint := lBtnItem.Hint;
    {$ELSE TNTUnicode}
    if JSSupportsUnicode then
    begin
      TJSButton(lBtn).Caption := JSCompilerStringFromUnicodeWideString(lBtnItem.Caption);
      lBtn.Hint := JSCompilerStringFromUnicodeWideString(lBtnItem.Hint);
    end
    else
    begin
      lBtn.Caption := lBtnItem.Caption;
      lBtn.Hint := lBtnItem.Hint;
    end;
    {$ENDIF TNTUnicode}
    TJSButton(lBtn).OnClick := ButtonClickHandler;
    {$ELSE}
    if lBtn is TJSButton then
    begin
      TJSButton(lBtn).Caption := lBtnItem.Caption;
      TJSButton(lBtn).OnClick := ButtonClickHandler;
    end
    else
    begin
      TBitBtn(lBtn).Caption := lBtnItem.Caption;
      TBitBtn(lBtn).OnClick := ButtonClickHandler;
    end;
    {$ENDIF}
    lBtn.Default := lBtnItem.Default;
    lBtn.Hint := lBtnItem.Hint;
    if lBtn.Default then
    begin
      FFocusedControl := lBtn;
      FDefaultButton := lBtn;
    end;
    lBtn.Cancel := lBtnItem.Cancel;
    lBtn.Enabled := lBtnItem.Enabled;
    if lBtnItem.ElevationRequired then
    begin
      if lBtn is TBitBtn then
        (lBtn as TBitBtn).Glyph.LoadFromResourceName(hInstance, JSD_SHIELD_SML)
      {$IFDEF DELPHI2007}
      else
        Button_SetElevationRequiredState(lBtn.Handle, True)
      {$ENDIF DELPHI2007};
    end;
  end
  else if AControl is TJSCheckBox then
  begin
    TJSCheckBox(AControl).Transparent := False;
    TJSCheckBox(AControl).Font := Font;
    TJSCheckBox(AControl).Color := FButtonBar.Color;
    TJSCheckBox(AControl).Caption := '  ' + FVerification.Text;
    Canvas.Font.Assign(Font);
    TJSCheckBox(AControl).Width := AFFS(20) + JSTextWidth(Canvas, TJSCheckBox(AControl).Caption);
    TJSCheckBox(AControl).Checked := FVerification.InitialState;
    TJSCheckBox(AControl).OnClick := CheckBoxClickHandler;
  end
  else if AControlType = ctCheckBox then
  begin
    TControlCracker(AControl).OnClick := CheckBoxClickHandler;
  end
  else if AControl is TJSProgressBar then
  begin
    if doProgressBar in DialogOptions then
      TJSProgressBar(AControl).Style := psNormal
    else
      TJSProgressBar(AControl).Style := psMarquee;
    TJSProgressBar(AControl).Interval := FProgress.Interval;
    TJSProgressBar(AControl).Max := FProgress.Max;
    TJSProgressBar(AControl).Step := FProgress.Step;
    TJSProgressBar(AControl).State := TProgressBarState(ord(FProgress.State));
    TJSProgressBar(AControl).Position := FProgress.Position;
//    AControl.Height := AControl.Height - 2;
    if doProgressBarMarquee in DialogOptions then
      TJSProgressBar(AControl).Activate(FProgress.Interval);
  end
  else if AControl is TJSProgressBarEx then
  begin
    TJSProgressBarEx(AControl).Interval := FProgress.Interval;
    TJSProgressBarEx(AControl).Max := FProgress.Max;
    TJSProgressBarEx(AControl).Step := FProgress.Step;
    TJSProgressBarEx(AControl).State := {$IFDEF DELPHI2009}ComCtrls.{$ENDIF}TProgressBarState(ord(FProgress.State));
    TJSProgressBarEx(AControl).Position := FProgress.Position;
    if doProgressBarMarquee in DialogOptions then
      TJSProgressBarEx(AControl).Active := True;
  end
  {$IFDEF DELPHI2009}
  else if AControl is TProgressBar then
  begin
    TProgressBar(AControl).MarqueeInterval := FProgress.Interval;
    TProgressBar(AControl).Max := FProgress.Max;
    TProgressBar(AControl).Step := FProgress.Step;
    TProgressBar(AControl).Position := FProgress.Position;
    if doProgressBarMarquee in DialogOptions then
      TProgressBar(AControl).Style := pbstMarquee
    else
      TProgressBar(AControl).Style := TProgressBarStyle.pbstNormal;
  end
  {$ENDIF}
  else if AControl is TJSRadioButtonCtrl then
  begin
    TJSRadioButtonCtrl(AControl).Caption := TJSRadioButtonItem(AControlItem).Caption;
    TJSRadioButtonCtrl(AControl).ParentFont := True;
    TJSRadioButtonCtrl(AControl).Checked := TJSRadioButtonItem(AControlItem).Checked;
    TJSRadioButtonCtrl(AControl).Enabled := TJSRadioButtonItem(AControlItem).Enabled;
    TJSRadioButtonCtrl(AControl).OnClick := RadioButtonClickHandler;
    if FRadioResult = -1 then
      TJSRadioButtonCtrl(AControl).Checked := TJSRadioButtonCtrl(AControl).Tag = BASE_RADIOBUTTON;
  end;
end;

procedure TJSCustomDialog.InitialiseControlClass(AControlType: TControlType; var AControlClass: TControlClass);
begin
  case AControlType of
    ctButton,
    ctCommandLink:
      begin
        if (AControlType = ctCommandLink) and ShowCommandLinks then
          AControlClass := TJSCommandLinkButton
        else if (IsVista) or (not HasElevationButton) then
          AControlClass := TJSButton
        else
          AControlClass := TBitBtn;
      end;
    ctCheckBox: AControlClass := TJSCheckBox;
    ctMoreButton: AControlClass := TJSMoreLabel;
    ctRichEdit: AControlClass := TJSRichEdit;
    ctLinkLabel: AControlClass := TJSCaptionControl;
    ctURLLabel: AControlClass := TJSCaptionControl;
    ctRadioButton: AControlClass := TJSRadioButtonCtrl;
    ctProgressBar:
      begin
        {$IFDEF DELPHI2009}
        if Progress.UseNativeProgressbar then
        begin
          if doProgressBarMarquee in DialogOptions then
          begin
            if CheckWin32Version(5, 1) then
              AControlClass := TProgressBar
            else
              AControlClass := TJSProgressBarMarquee;
          end
          else
          begin
            AControlClass := TProgressBar;
          end;
        end
        else
        begin
          if doProgressBarMarquee in DialogOptions then
            AControlClass := TJSProgressBar
          else
            AControlClass := TJSProgressBarEx;
        end;
        {$ELSE}
        if Progress.UseNativeProgressbar and CheckWin32Version(5, 1)
          {$IFDEF THEMES}and ThemeServices.ThemesEnabled{$ENDIF} then
        begin
          if doProgressBarMarquee in DialogOptions then
            AControlClass := TJSProgressBarMarquee
          else
            AControlClass := TJSProgressBarEx;
        end
        else
          AControlClass := TJSProgressBar;
        {$ENDIF}
        if ShowProgressBarOnTaskBar then
        begin
          FTaskBarProgressImpl := TJSTaskBarProgressImpl.Create;
          if doProgressBarMarquee in DialogOptions then
            FTaskBarProgressImpl.SetProgressState(TBPF_INDETERMINATE)
          else
            FTaskBarProgressImpl.SetProgressState(TBPF_NORMAL);
        end;
      end;
    ctRadioGroup: AControlClass := TRadioGroup;
  end;
end;

procedure TJSCustomDialog.InitialiseMargins;
begin
  if (not Instruction.HasCustomGlyph) and (not FInstruction.ShowAtTop) and (ValidPicture(Glyph) or (MainIcon in KnownIcons)) then
  begin
    if MainIcon in KnownIcons then
    begin
      if BiDiMode = bdLeftToRight then
        FLeftMargin := 11 + 32 + FHorzSpacing // 32 is known icon width
      else
        FLeftMargin := 11;
    end
    else
    begin
      if BiDiMode = bdLeftToRight then
        FLeftMargin := 11 + FGlyph.Graphic.Width + FHorzSpacing
      else
        FLeftMargin := 11;
    end;
  end
  else if Instruction.HasCustomGlyph then
  begin
    if ValidPicture(Instruction.Glyph) then
      FLeftMargin := 11 + FInstruction.Glyph.Graphic.Width + FHorzSpacing
    else
      FLeftMargin := 11 + 32 + FHorzSpacing
  end
  else if ((Instruction.Icon in KnownIcons) or (MainIcon in KnownIcons)) and not Instruction.ShowAtTop then
    FLeftMargin := 11 + 32 + FHorzSpacing // 32 is known icon width
  else
    FLeftMargin := 11;
  if FEmulateMessageDlg then
    FLeftMargin := FLeftMargin + 4
  else
  begin
    if (MainIcon = tdiNone) and (trim(Content.Text) = '') and (trim(Instruction.Text) = '') then
      FLeftMargin := 10
    else
      FLeftMargin := FLeftMargin + 1;
  end;
  FRightMargin := AFFS(10);
  if BiDiMode <> bdLeftToRight then
  begin
    Inc(FRightMargin, 32 + FHorzSpacing);
  end;
  FLeftMargin := AFFS(FLeftMargin);
end;

procedure TJSCustomDialog.InstructionChangeHandler(Sender: TObject);
var
  lRect: TRect;
  lOldHeight: Integer;
  LHeight: Integer;
  LWidth: Integer;
begin
  if FInitialisingFonts then
    exit;
  if not (FCalcLayout) and (not FAssigning) then
  begin
    if (FForm <> nil) and (FCreatedCustomButtons <> nil) then
    begin
      lOldHeight := FClientHeight;
      CalculateAutoSize(LHeight, LWidth);
      if FInstructionLabel = nil then
        CreateInstruction;
      PositionControls;
      if Instruction.ShowAtTop and (Instruction.Color <> clNone) then
        FInstructionLabel.Color := Instruction.Color
      else
        FInstructionLabel.Color := Color;
      FInstructionLabel.Font := Instruction.Font;
      if lOldHeight = FClientHeight then
      begin
        PaintMainInstruction(Canvas, lRect);
        FInstructionLabel.Invalidate;
      end
      else
        FForm.Invalidate;
    end;
  end;
end;

procedure TJSCustomDialog.InstructionClickHandler(Sender: TObject);
begin
  DoDialogClick(Self, htInstruction);
end;

procedure TJSCustomDialog.InvalidateButtons;
var
  i: Integer;
begin
  // no buttons to invalidate
  if FCreatedCustomButtons = nil then
    exit;
  for i := 0 to FCreatedCustomButtons.Count - 1 do
    TControl(FCreatedCustomButtons[i]).Invalidate;
end;

procedure TJSCustomDialog.VerificationChangeHandler(Sender: TObject);
var
  LHeight: Integer;
  LWidth: Integer;
begin
  if FInitialisingFonts then
    exit;
  if not (FCalcLayout) and (not FAssigning) then
  begin
    if FForm <> nil then
    begin
      if Verification.Visible then
      begin
        if FVerificationCheckBox = nil then
          CreateVerificationCheckBox;
      end
      else
        FreeAndNil(FVerificationCheckBox);
      CalculateAutoSize(LHeight, LWidth);
      PositionControls;
    end;
  end;
end;

function TJSCustomDialog.WidthAdjustment: Integer;
begin
  result := 0;
end;

{ TJSExpando }

procedure TJSExpando.Assign(Source: TPersistent);
var
  lSrc: TJSExpando;
begin
  if Source is TJSExpando then
  begin
    lSrc := TJSExpando(Source);
    Font := lSrc.Font;
    Lines := lSrc.Lines;
    FVisible := lSrc.Visible;
    FShowing := lSrc.Showing;
    FShowInFooter := lSrc.ShowInFooter;
    FMoreHeight := lSrc.MoreHeight;
    FMoreFormat := lSrc.MoreFormat;
    FMoreScrollbars := LSrc.MoreScrollbars;
    FMoreSource := lSrc.MoreSource;
    FShowText := lSrc.ShowText;
    FHideText := lSrc.HideText;
  end;
end;

constructor TJSExpando.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FFont := TFont.Create;
  FAnimate := TJSAnimate.Create;
  FLines := TJSWideStringList.Create;
  TJSWideStringList(FLines).OnChange := LinesChangedHandler;
  FVisible := False;
  FShowing := False;
  FShowMore := False;
  FShowInFooter := False;
  FMoreHeight := 0;
  FMoreFormat := mfText;
  FMoreSource := msDefault;
  FMoreScrollbars := ssBoth;
end;

destructor TJSExpando.Destroy;
begin
  FFont.Free;
  FLines.Free;
  FAnimate.Free;
  inherited;
end;

function TJSExpando.IsFontStored: Boolean;
begin
  result := not Dialog.UseDefaultFonts;
end;

procedure TJSExpando.LinesChangedHandler(Sender: TObject);
begin
  DoChange;
end;

procedure TJSExpando.SetAnimate(const Value: TJSAnimate);
begin
  FAnimate.Assign(Value);
end;

procedure TJSExpando.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  DoChange;
end;

procedure TJSExpando.SetHideText(const Value: TJSString);
begin
  if FHideText <> Value then
  begin
    FHideText := Value;
    DoChange;
  end;
end;

procedure TJSExpando.SetLines(const Value: TJSStrings);
begin
  if FLines.Text <> Value.Text then
  begin
    FLines.Assign(Value);
    DoChange;
  end;
end;

procedure TJSExpando.SetMoreHeight(const Value: Integer);
begin
  if FMoreHeight <> Value then
  begin
    FMoreHeight := Value;
    DoChange;
  end;
end;

procedure TJSExpando.SetShowInFooter(const Value: Boolean);
begin
  if FShowInFooter <> Value then
  begin
    FShowInFooter := Value;
    DoChange;
  end;
end;

procedure TJSExpando.SetShowing(const Value: Boolean);
begin
  if FShowing <> Value then
  begin
    FShowing := Value;
    DoChange;
  end;
end;

procedure TJSExpando.SetShowText(const Value: TJSString);
begin
  if FShowText <> Value then
  begin
    FShowText := Value;
    DoChange;
  end;
end;

procedure TJSExpando.SetVisible(const Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    DoChange;
  end;
end;

{ TJSRadioButtonItem }

procedure TJSRadioButtonItem.Assign(Source: TPersistent);
var
  lSrc: TJSRadioButtonItem;
begin
  if (Source is TJSRadioButtonItem) then
  begin
    lSrc := TJSRadioButtonItem(Source);
    FCaption := lSrc.Caption;
    FValue := lSrc.Value;
    FChecked := lSrc.Checked;
    FEnabled := lSrc.Enabled;
  end
  else
    inherited;
end;

function TJSRadioButtonItem.CanUpdateControls(out ADialog: TJSCustomDialog): Boolean;
begin
  ADialog := TJSRadioButtons(Collection).MessagePanel;
  Result := not (csReading in ADialog.ComponentState) or
    not (csLoading in ADialog.ComponentState);
end;

constructor TJSRadioButtonItem.Create(Collection: TCollection);
begin
  inherited;
  FEnabled := True;
  FChecked := False;
end;

function TJSRadioButtonItem.GetDisplayName: string;
begin
  if Caption <> '' then
    result := Caption
  else
    result := inherited GetDisplayName;
end;

procedure TJSRadioButtonItem.SetCaption(const Value: TJSString);
var
  LDialog: TJSCustomDialog;
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if CanUpdateControls(LDialog) then
      LDialog.PositionRadioButtons;
  end;
end;

{ TJSRadioButtons }

function TJSRadioButtons.Add: TJSRadioButtonItem;
begin
  result := TJSRadioButtonItem(inherited Add);
  result.FValue := BASE_RADIOBUTTON + Count - 1;
  // check the first item by default
  if Count = 1 then
    result.Checked := True;
  {$IFDEF DELPHI5}
  result.Caption := JSFormat('Radio Button %d', [Count - 1]);
  {$ENDIF DELPHI5}
end;

{$IFNDEF DELPHI5}
procedure TJSRadioButtons.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  if Action = cnAdded then
  begin
    TJSRadioButtonItem(Item).FValue := BASE_RADIOBUTTON + Count - 1;
    TJSRadioButtonItem(Item).Caption := JSFormat('Radio Button %d', [Count - 1]);
  end;
end;
{$ENDIF DELPHI5}

function TJSRadioButtons.GetItem(Index: Integer): TJSRadioButtonItem;
begin
  result := TJSRadioButtonItem(inherited GetItem(Index));
end;

function TJSRadioButtons.GetMessagePanel: TJSCustomDialog;
begin
  result := GetOwner as TJSCustomDialog;
end;

function TJSRadioButtons.ItemWithValue(const AValue: Integer): TJSRadioButtonItem;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    result := Items[i];
    if result.Value = AValue then
      exit;
  end;
  result := nil;
end;

procedure TJSRadioButtons.SetEnabled(const AValue: Integer; const AEnabled: Boolean);
var
  lItem: TJSRadioButtonItem;
begin
  lItem := ItemWithValue(AValue);
  if lItem <> nil then
    lItem.Enabled := AEnabled;
end;

procedure TJSRadioButtons.SetItem(Index: Integer; const Value: TJSRadioButtonItem);
begin
  inherited SetItem(Index, Value);
end;

{ TJSCustomButtons }

function TJSCustomButtons.Add: TJSCustomButtonItem;
begin
  result := TJSCustomButtonItem(inherited Add);
  result.FValue := BASE_CUSTOMBUTTON + Count - 1;
end;

{$IFNDEF DELPHI5}
procedure TJSCustomButtons.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  if Action = cnAdded then
    TJSCustomButtonItem(Item).FValue := BASE_CUSTOMBUTTON + Count - 1;
end;
{$ENDIF DELPHI5}

procedure TJSCustomButtons.Assign(Source: TPersistent);
var
  lSrc: TJSCustomButtons;
begin
  inherited;
  if Source is TJSCustomButtons then
  begin
    lSrc := (Source as TJSCustomButtons);
    Images := lSrc.Images;
    PictureImages := lSrc.PictureImages;
  end;
end;

constructor TJSCustomButtons.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
end;

destructor TJSCustomButtons.Destroy;
begin
  inherited;
end;

function TJSCustomButtons.GetItem(Index: Integer): TJSCustomButtonItem;
begin
  result := TJSCustomButtonItem(inherited GetItem(Index));
end;

function TJSCustomButtons.GetMessagePanel: TJSCustomDialog;
begin
  result := GetOwner as TJSCustomDialog;
end;

function TJSCustomButtons.GetModalResult(const aValue: Integer): Integer;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].Value = aValue then
    begin
      result := Items[i].ModalResult;
      exit;
    end;
  end;
  result := mrNone;
end;

function TJSCustomButtons.GetVisibleCount: Integer;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Visible then
      inc(result);
  end;
end;

procedure TJSCustomButtons.SetImages(const Value: TCustomImageList);
begin
  if Images <> Value then
  begin
    FImages := Value;
    if Images <> nil then
      Images.FreeNotification(GetOwner as TJSCustomDialog);
  end;
end;

procedure TJSCustomButtons.SetItem(Index: Integer; const Value: TJSCustomButtonItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TJSCustomButtons.SetPictureImages(const Value: TCustomImageList);
begin
  if PictureImages <> Value then
  begin
    FPictureImages := Value;
    if PictureImages <> nil then
      PictureImages.FreeNotification(GetOwner as TJSCustomDialog);
  end;
end;

{ TJSCommandButtonItem }

procedure TJSCustomButtonItem.Assign(Source: TPersistent);
var
  lSrc: TJSCustomButtonItem;
begin
  if Source is TJSCustomButtonItem then
  begin
    lSrc := TJSCustomButtonItem(Source);
    FCaption := lSrc.Caption;
    FValue := lSrc.Value;
    Glyph := lSrc.Glyph;
    Picture := lSrc.Picture;
    FImageIndex := lSrc.ImageIndex;
    FPictureIndex := lSrc.PictureIndex;
    FModalResult := lSrc.ModalResult;
    FDefault := lSrc.Default;
    FCancel := lSrc.Cancel;
    FHint := lSrc.Hint;
    Info := lSrc.Info;
    FElevationRequired := lSrc.ElevationRequired;
    FEnabled := lSrc.Enabled;
    FVisible := lSrc.Visible;
  end;
end;

constructor TJSCustomButtonItem.Create(Collection: TCollection);
begin
  inherited;
  FOwner := TJSCustomButtons(Collection);
  FGlyph := TPicture.Create;
  FPicture := TPicture.Create;
  FImageIndex := -1;
  FPictureIndex := -1;
  FModalResult := mrNone;
  FDefault := False;
  FCancel := False;
  FInfo := TJSWideStringList.Create;
  FElevationRequired := False;
  FEnabled := True;
  FVisible := True;
end;

destructor TJSCustomButtonItem.Destroy;
begin
  FGlyph.Free;
  FPicture.Free;
  FInfo.Free;
  inherited;
end;

function TJSCustomButtonItem.GetDisplayName: string;
begin
  if Caption <> '' then
  begin
    if Info.Text <> '' then
      result := Format('%s - %s', [Caption, trim(Info.Text)])
    else
      result := Caption
  end
  else
    result := inherited GetDisplayName;
end;

function TJSCustomButtonItem.GetOwner: TPersistent;
begin
  result := FOwner;
end;

procedure TJSCustomButtonItem.SetCaption(const Value: TJSString);
begin
  FCaption := Value;
end;

procedure TJSCustomButtonItem.SetEnabled(const Value: Boolean);
var
  lDlg: TJSCustomDialog;
  LOwner: TPersistent;
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    LOwner := GetOwner;
    if LOwner <> nil then
    begin
      lDlg := (LOwner as TJSCustomButtons).GetMessagePanel;
      if (lDlg <> nil) then
      begin
        lDlg.EnableButton(FValue, Enabled);
      end;
    end;
  end;
end;

procedure TJSCustomButtonItem.SetGlyph(const Value: TPicture);
begin
  FGlyph.Assign(Value);
end;

procedure TJSCustomButtonItem.SetHint(const Value: TJSString);
begin
  FHint := Value;
end;

procedure TJSCustomButtonItem.SetInfo(const Value: TJSStrings);
begin
  FInfo.Assign(Value);
end;

procedure TJSCustomButtonItem.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TJSCustomButtonItem.SetValue(const Value: Integer);
begin
  // this is a dummy setter.
  // You cannot set the VALUE for custom buttons or radiobuttons
  //FValue := Value;
end;

procedure TJSCustomButtonItem.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

{ TJSButtonBarOptions }

procedure TJSButtonBarOptions.Assign(Source: TPersistent);
var
  lSrc: TJSButtonBarOptions;
begin
  if Source is TJSButtonBarOptions then
  begin
    lSrc := TJSButtonBarOptions(Source);
    FButtons := lSrc.Buttons;
    FVisible := lSrc.Visible;
    FDefault := lSrc.Default;
    FCancel := lSrc.Cancel;
    FColor := lSrc.Color;
    FShowDivider := lSrc.ShowDivider;
    FUseDefault := lSrc.UseDefault;
    FUseCancel := lSrc.UseCancel;
  end
  else
    inherited;
end;

constructor TJSButtonBarOptions.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FButtons := [cbOK, cbCancel];
  FVisible := True;
  {$IFDEF DELPHIXE2}
  if StyleServices.Enabled then
    FColor := StyleServices.GetSystemColor(clBtnFace)
  else
    FColor := clBtnFace;
  {$ELSE}
  FColor := clBtnFace;
  {$ENDIF}
  FDefault := cbOK;
  FCancel := cbCancel;
  FShowDivider := True;
  FUseDefault := True;
  FUseCancel := True;
end;

procedure TJSButtonBarOptions.DetermineDefaults;
begin
  // Determine the best option for the Default button
  if cbYes in Buttons then
    Default := cbYes
  else if cbOK in Buttons then
    Default := cbOK
  else if cbRetry in Buttons then
    Default := cbRetry
  else if cbClose in Buttons then
    Default := cbClose
  else if cbAll in Buttons then
    Default := cbAll
  else if cbYesToAll in Buttons then
    Default := cbYesToAll
  else if cbHelp in Buttons then
    Default := cbHelp;

  // Determine the best option for the Cancel button
  if cbCancel in Buttons then
    Cancel := cbCancel
  else if cbNo in Buttons then
    Cancel := cbNo
  else if cbClose in Buttons then
    Cancel := cbClose
  else if cbAbort in Buttons then
    Cancel := cbAbort
  else if cbIgnore in Buttons then
    Cancel := cbIgnore
  else if cbNoToAll in Buttons then
    Cancel := cbNoToAll
  else if cbHelp in Buttons then
    Cancel := cbHelp;
end;

function TJSButtonBarOptions.IsColorStored: Boolean;
begin
  {$IFDEF DELPHIXE2}
  Result := not StyleServices.Enabled or StyleServices.IsSystemStyle;
  {$ELSE}
  Result := True;
  {$ENDIF}
end;

procedure TJSButtonBarOptions.SetButtons(const Value: TCommonButtons);
begin
  if FButtons <> Value then
  begin
    FButtons := Value;
    DoChange;
  end;
end;                  

procedure TJSButtonBarOptions.SetCancel(const Value: TCommonButton);
begin
  if FCancel <> Value then
  begin
    FCancel := Value;
    DoChange;
  end;
end;

procedure TJSButtonBarOptions.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    DoChange;
  end;
end;

procedure TJSButtonBarOptions.SetDefault(const Value: TCommonButton);
begin
  if FDefault <> Value then
  begin
    FDefault := Value;
    DoChange;
  end;
end;

procedure TJSButtonBarOptions.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    DoChange;
  end;
end;

{ TJSInstruction }

procedure TJSInstruction.Assign(Source: TPersistent);
var
  lSrc: TJSInstruction;
begin
  if Source is TJSInstruction then
  begin
    lSrc := TJSInstruction(Source);
    IgnoreChange := True;
    try
      Font := lSrc.Font;
      Glyph := lSrc.Glyph;
      FText := lSrc.Text;
      FShowAtTop := lSrc.ShowAtTop;
      FShowGlyph := lSrc.ShowGlyph;
      FIcon := lSrc.Icon;
      FColor := lSrc.Color;
    finally
      FIgnoreChange := False;
      DoChange;
    end;
  end
  else
    inherited;
end;

constructor TJSInstruction.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FColor := clNone;
  FFont := TFont.Create;
  FFont.Assign(DefaultFonts.GetFont(ftInstruction));
  FGlyph := TPicture.Create;
  FShowAtTop := False;
  FShowGlyph := False;
  FIcon := tdiNone;
end;

destructor TJSInstruction.Destroy;
begin
  FFont.Free;
  FGlyph.Free;
  inherited;
end;

function TJSInstruction.GlyphAvailable: Boolean;
begin
  result := HasCustomGlyph or HasGlyph;
end;

function TJSInstruction.GlyphHeight: Integer;
begin
  result := 0;
  if ValidPicture(Glyph) then
    result := Glyph.Graphic.Height
  else if Icon in KnownIcons then
    result := 32;
end;

function TJSInstruction.GlyphWidth: Integer;
begin
  result := 0;
  if ValidPicture(Glyph) then
    result := Glyph.Graphic.Width
  else if Icon in KnownIcons then
    result := 32;
end;

function TJSInstruction.HasCustomGlyph: Boolean;
begin
  result := (ShowGlyph or (Icon = tdiCustom)) and ValidPicture(Glyph);
end;

function TJSInstruction.HasGlyph: Boolean;
begin
  result := (Icon in KnownIcons);
end;

function TJSInstruction.IsFontStored: Boolean;
begin
  result := not Dialog.UseDefaultFonts;
end;

procedure TJSInstruction.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    DoChange;
  end;
end;

procedure TJSInstruction.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  DoChange;
end;

procedure TJSInstruction.SetGlyph(const Value: TPicture);
begin
  FGlyph.Assign(Value);
end;

procedure TJSInstruction.SetIcon(const Value: TTaskDialogIcon);
begin
  if FIcon <> Value then
  begin
    FIcon := Value;
    if (FIcon <> tdiCustom) then
      Glyph.Assign(nil);
    DoChange;
  end;
end;

procedure TJSInstruction.SetShowAtTop(const Value: Boolean);
begin
  if FShowAtTop <> Value then
  begin
    FShowAtTop := Value;
    DoChange;
  end;
end;

procedure TJSInstruction.SetShowGlyph(const Value: Boolean);
begin
  if FShowGlyph <> Value then
  begin
    FShowGlyph := Value;
    DoChange;
  end;
end;

procedure TJSInstruction.SetText(const Value: WideString);
begin
  if FText <> Value then
  begin
    FText := Value;
    DoChange;
  end;
end;

{ TJSVerificationOptions }

procedure TJSVerification.Assign(Source: TPersistent);
var
  lSrc: TJSVerification;
begin
  if Source is TJSVerification then
  begin
    lSrc := TJSVerification(Source);
    InitialState := lSrc.InitialState;
    Visible := lSrc.Visible;
    Text := lSrc.Text;
  end
  else
    inherited;
end;

constructor TJSVerification.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FInitialState := False;
  FVisible := False;
  FText := '';
end;

procedure TJSVerification.SetText(const Value: TJSString);
begin
  if FText <> Value then
  begin
    FText := Value;
    DoChange;
  end;
end;

procedure TJSVerification.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    DoChange;
  end;
end;

{ TJSBaseOptions }

procedure TJSBaseOptions.Assign(Source: TPersistent);
var
  lSrc: TJSBaseOptions;
begin
  if (Source is TJSBaseOptions) then
  begin
    lSrc := TJSBaseOptions(Source);
    FText := lSrc.Text;
    FVisible := lSrc.Visible;
    Glyph := lSrc.Glyph;
    FIcon := lSrc.Icon;
    Font := lSrc.Font;
    FColor := lSrc.Color;
    FImageAlignment := LSrc.ImageAlignment;
    DoChange;
  end
  else
    inherited;
end;

constructor TJSBaseOptions.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FGlyph := TPicture.Create;
  FIcon := tdiNone;
  FVisible := False;
  FFont := TFont.Create;
  FImageAlignment := jsImageAlignLeft;
end;

destructor TJSBaseOptions.Destroy;
begin
  FGlyph.Free;
  FFont.Free;
  inherited;
end;

function TJSBaseOptions.FontModified: Boolean;
begin
  result := False;
end;

function TJSBaseOptions.IsFontStored: Boolean;
begin
  result := (not Dialog.UseDefaultFonts) or (Self.InheritsFrom(TJSHeader) and FontModified);
end;

procedure TJSBaseOptions.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TJSBaseOptions.SetGlyph(const Value: TPicture);
begin
  FGlyph.Assign(Value);
end;

procedure TJSBaseOptions.SetIcon(const Value: TTaskDialogIcon);
begin
  if FIcon <> Value then
  begin
    FIcon := Value;
    // Only call the OnChange when visible
    if FVisible then
      DoChange;
  end;
end;

procedure TJSBaseOptions.SetText(const Value: TJSString);
begin
  if FText <> Value then
  begin
    FText := Value;
    // Only call the OnChange when visible
    if FVisible then
      DoChange;
  end;
end;

procedure TJSBaseOptions.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  DoChange;
end;

{ TJSHelpLink }

procedure TJSHelpLink.Assign(Source: TPersistent);
var
  lSrc: TJSHelpLink;
begin
  if Source is TJSHelpLink then
  begin
    lSrc := TJSHelpLink(Source);
    Font := lSrc.Font;
    FHelpType := lSrc.HelpType;
    FHelpKeyword := lSrc.HelpKeyword;
    FHelpContext := lSrc.HelpContext;
    FText := lSrc.Text;
  end;
end;

constructor TJSHelpLink.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FFont := TFont.Create;
  FFont.Name := ADialog.Font.Name;
  FFont.Size := ADialog.Font.Size;
  FFont.Style := [fsUnderline];
  FFont.Color := clBlue;
  FHelpType := htContext;
  FHelpContext := 0;
end;

destructor TJSHelpLink.Destroy;
begin
  FFont.Free;
  inherited;
end;

function TJSHelpLink.IsFontStored: Boolean;
begin
  result := not Dialog.UseDefaultFonts;
end;

procedure TJSHelpLink.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  DoChange;
end;

procedure TJSHelpLink.SetText(const Value: TJSString);
begin
  if FText <> Value then
  begin
    FText := Value;
    DoChange;
  end;
end;

function TJSCustomDialog.Execute: Integer;
var
  lOwner: TComponent;
begin
  lOwner := Self.Owner;
  if lOwner = nil then
  begin
    lOwner := Screen.ActiveForm;
    if (lOwner = nil) or (not TJSCustomTaskDialogForm(lOwner).Visible) then
    begin
      lOwner := Application.MainForm;
      if (lOwner = nil) or (not TJSCustomTaskDialogForm(lOwner).Visible) then
        lOwner := Application;
    end;
  end;
  result := Execute(lOwner);
end;

function TJSCustomDialog.Execute(aOwner: TComponent): Integer;
var
  lUIState: Longint;
  LMaxLines: Integer;
  LHeight: Integer;
  LWidth: Integer;
  LDialogName: string;
  LDialogNamePrefix: string;
  LId: Integer;
begin
  if (DialogStyle = dsSheet) and not (doModal in DialogOptions) and not Self.InheritsFrom(TJSCustomDialogSheet) then
    raise EDialogSheet.Create('Non-Modal sheets should use the TJSDialogSheet component or a descendant of TJSDialogSheet.');
  FDialogState := FDialogState + [dsNormal];
  if (FForm = nil) or (not FForm.Visible) then
  begin
    FButtonClicked := False;
    EmulateMessageDlg := UseOldDialogStyle and UseOldStyleSetting;
    FPreviousProgressPosition := Progress.Position;
    FForm := TJSTaskDialogForm.CreateNew(AOwner);
    Self.FreeNotification(FForm);
    // Only name the dialog if the owner is not nil
    if AOwner <> nil then
    begin
      if Trim(Name) <> '' then
        LDialogNamePrefix := JSDIALOG_FORM + Name
      else
        LDialogNamePrefix := JSDIALOG_FORM;
      LId := 1;
      LDialogName := LDialogNamePrefix;
      while AOwner.FindComponent(LDialogName) <> nil do
      begin
        LDialogName := Format('%s%d', [LDialogNamePrefix, LId]);
        Inc(LId);
      end;
      FForm.Name := LDialogName;
    end;
    {$IFDEF JSDEBUG}
    Screen.OnActiveControlChange := DEBUG_ActiveControlChangeHandler;
    {$ENDIF JSDEBUG}
    {$IFDEF DELPHIXE2}
    if StyleServices.Enabled and not StyleServices.IsSystemStyle then
    begin
      FButtonBar.Color := StyleServices.GetSystemColor(clBtnFace);
      Color := StyleServices.GetSystemColor(clWindow);
      Footer.Color := StyleServices.GetSystemColor(clBtnFace);
    end;
    {$ENDIF}
    DoCreated;
    FForm.OnShow := DialogShowHandler;
    FForm.OnClose := DialogCloseHandler;
    FForm.OnCloseQuery := DialogCloseQueryHandler;
    FForm.OnDestroy := DialogDestroyHandler;
    FForm.OnKeyUp := DialogKeyUpHandler;
    TJSTaskDialogForm(FForm).OnClientClick := DialogClientClickHandler;
    {$IFDEF BDS}
    if (aOwner <> nil) and (aOwner is TCustomForm) then
      FForm.PopupParent := (aOwner as TCustomForm);
    {$ENDIF BDS}
    if (aOwner <> nil) and (aOwner is TCustomForm) then
      lUIState := SendMessage((aOwner as TCustomForm).Handle, WM_QUERYUISTATE, 0, 0)
    else
      lUIState := 0;
    FAcceleratorState := lUIState;
    FForm.ShowHint := ShowHint;
    TJSTaskDialogForm(FForm).Dialog := Self;
    // border style is currently confined to either Single or Dialog
    if AllowMinimize or ValidIcon(Icon) then
      FForm.BorderStyle := bsSingle
    else
    begin
      if ShowHelpButton then
        FForm.BorderIcons := FForm.BorderIcons + [biHelp];
      FForm.BorderStyle := BorderStyle;
    end;
    FForm.HelpContext := HelpContext;
    {$IFNDEF DELPHI5}
    FForm.HelpType := HelpType;
    FForm.HelpKeyword := HelpKeyword;
    {$ENDIF DELPHI5}
    FForm.BiDiMode := BiDiMode;
    // replace fonts for sections if we are
    // using the default fonts
    if AlwaysUseDefaultFonts or (FUseDefaultFonts) then
    begin
      FInitialisingFonts := True;
      try
        Font := GetRegisteredFont(ftContent);
        Instruction.Font := GetRegisteredFont(ftInstruction);
        //Header.Font := GetRegisteredFont(ftHeader);
        Footer.Font := GetRegisteredFont(ftFooter);
        Expando.Font := GetRegisteredFont(ftExpando);
      finally
        FInitialisingFonts := False;
      end;
    end;
    FForm.Font := Font;
    CreateControls;
    if doTopMost in DialogOptions then
      FForm.FormStyle := fsStayOnTop;
    SetMainIcon(MainIcon);
    LMaxLines := MaxLines;
    FResetMaxLines := False;
    CalculateAutoSize(LHeight, LWidth);
    // Check to see if the size calculation needed to change the
    // MaxLines property so that the dialog will fit on the screen
    if MaxLines <> LMaxLines then
    begin
      FResetMaxLines := True;
      CleanUpDialog;
      CreateControls;
      CalculateAutosize(LHeight, LWidth);
    end;
    PositionControls;

    FForm.Icon.Assign(FIcon);
    FForm.Caption := FTitle;

    if EmulateMessageDlg then
    begin
      FForm.Color := clBtnFace;
      if FContentLabel <> nil then
        FContentLabel.Color := FForm.Color;
      if FContentMaxLines <> nil then
        TMemo(FContentMaxLines).Color := FForm.Color;
      FInstructionLabel.Color := FForm.Color;
      ButtonBar.ShowDivider := False;
    end
    else
      FForm.Color := Color;

    if FPosition = dpDesigned then
    begin
      FForm.Position := poDesigned;
      FForm.Left := FLocation.Left;
      FForm.Top := FLocation.Top;
    end
    else
      FForm.Position := Forms.TPosition(ord(FPosition) + 4);
    if FForm.Position = poOwnerFormCenter then
      FForm.DefaultMonitor := dmDesktop
    else
      FForm.DefaultMonitor := DefaultMonitor;
    if FAllowCancel then
    begin
      ModalResult := mrCancel;
      FForm.BorderIcons := FForm.BorderIcons + [biSystemMenu];
    end
    else
      FForm.BorderIcons := FForm.BorderIcons - [biSystemMenu];

    if FAllowMinimize then
      FForm.BorderIcons := FForm.BorderIcons + [biSystemMenu, biMinimize]
    else
      FForm.BorderIcons := FForm.BorderIcons - [biMinimize];

    DoDialogConstructed;
    if doTimer in DialogOptions then
      TJSTaskDialogForm(FForm).StartTimer;
    if doModal in DialogOptions then
    begin
      DoShowDialogModal;
      result := FDialogResult.ModalResult;
      if doTimer in DialogOptions then
        TJSTaskDialogForm(FForm).EndTimer;
      FreeAndNil(FForm);
    end
    else
    begin
      FDialogResult.ModalResult := mrNone;
      DoShowDialogNonModal;
      result := -1;
    end;
  end
  else if (FForm <> nil) then
  begin
    FForm.Show;
    FForm.BringToFront;
    result := -1;
  end
  else
    result := -1;
  if FResetMaxLines then
  begin
    MaxLines := 0;
    FResetMaxLines := False;
  end;
  FDialogState := FDialogState - [dsNormal];
end;

function TJSCustomDialog.ExecutePreview: Integer;
var
  lOptions: TDialogOptions;
  lPosition: TDialogPosition;
  lOwner: TComponent;
  lAllowCancel: Boolean;
begin
  FDialogState := [dsPreview];
  lOptions := DialogOptions;
  lPosition := Position;
  lAllowCancel := AllowCancel;
  try
    Position := dpScreenCenter;
    DialogOptions := DialogOptions + [doModal];
    // allowcancel must always be true when previewing a dialog in the IDE
    AllowCancel := True;
    if Self.Owner = nil then
      lOwner := Application
    else
      lOwner := Self.Owner;
    FFocusedControl := nil;
    result := Execute(lOwner);
  finally
    DialogOptions := lOptions;
    Position := lPosition;
    AllowCancel := lAllowCancel;
    FDialogState := FDialogState - [dsPreview];
  end;
end;

{ TJSHeader }

procedure TJSHeader.Assign(Source: TPersistent);
var
  lSrc: TJSHeader;
begin
  if Source is TJSHeader then
  begin
    lSrc := (Source as TJSHeader);
    FIconSize := lSrc.IconSize;
    FGradient.Assign(lSrc.Gradient);    
  end;
  inherited;
end;

constructor TJSHeader.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FGradient := TJSGradient.Create;
  Color := clWindow;
  FIconSize := isLarge;
end;

destructor TJSHeader.Destroy;
begin
  FGradient.Free;
  inherited;
end;

function TJSHeader.FontModified: Boolean;
begin
{$IFDEF DELPHI2009}
{$WARN EXPLICIT_STRING_CAST OFF}
{$ENDIF DELPHI2009}
  result := (Font.Height <> DefFontData.Height) or
    {$IFDEF BDS}
    (Font.Orientation <> DefFontData.Orientation) or
    {$ENDIF BDS}
    (Font.Pitch <> DefFontData.Pitch) or
    (Font.Style <> DefFontData.Style) or
    (Font.Charset <> DefFontData.Charset) or
    (Font.Name <> string(DefFontData.Name));
{$IFDEF DELPHI2009}
{$WARN EXPLICIT_STRING_CAST ON}
{$ENDIF DELPHI2009}
end;

procedure TJSHeader.SetGradient(const Value: TJSGradient);
begin
  FGradient.Assign(Value);
end;

{ TJSSizeComparer }

constructor TJSSizeComparer.Create(const aWidth, aHeight: Integer);
begin
  FWidth := aWidth;
  FHeight := aHeight;
end;

function TJSSizeComparer.IsEqual(const aWidth, aHeight: Integer): Boolean;
begin
  result := (aWidth = FWidth) and (aHeight = FHeight);
end;

{ TJSProgress }

procedure TJSProgress.Assign(Source: TPersistent);
var
  lSrc: TJSProgress;
begin
  if Source is TJSProgress then
  begin
    IgnoreChange := True;
    try
      lSrc := Source as TJSProgress;
      FMax := lSrc.Max;
      FMin := lSrc.Min;
      FStep := lSrc.Step;
      FPosition := lSrc.Position;
      FState := lSrc.State;
      FInterval := lSrc.Interval;
      FUseNativeProgressbar := lSrc.UseNativeProgressBar;
    finally
      IgnoreChange := False;
      DoChange;
    end;
  end
  else
    inherited;
end;

constructor TJSProgress.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FInterval := 100;
  FMin := 0;
  FPosition := 0;
  FMax := 100;
  FStep := 1;
  FState := pbstNormal;
  FUseNativeProgressBar := True;
end;

procedure TJSProgress.SetInterval(const Value: Cardinal);
begin
  if FInterval <> Value then
  begin
    FInterval := Value;
    DoChange;
  end;
end;

procedure TJSProgress.SetMax(const Value: Integer);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    DoChange;
  end;
end;

procedure TJSProgress.SetPosition(const Value: Integer);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    DoChange;
  end;
end;

procedure TJSProgress.SetShowOnTaskBar(const Value: Boolean);
begin
  if FShowOnTaskBar <> Value then
  begin
    FShowOnTaskBar := Value;
    DoChange;
  end;
end;

procedure TJSProgress.SetState(const Value: TProgressBarState);
begin
  if FState <> Value then
  begin
    FState := Value;
    DoChange;
  end;
end;

procedure TJSProgress.SetStep(const Value: Integer);
begin
  if FStep <> Value then
  begin
    FStep := Value;
    DoChange;
  end;
end;

procedure TJSProgress.SetUseNativeProgressBar(const Value: Boolean);
begin
  if FUseNativeProgressbar <> Value then
  begin
    FUseNativeProgressbar := Value;
    DoChange;
  end;
end;

{ TJSBorder }

procedure TJSBorder.Assign(Source: TPersistent);
var
  lSrc: TJSBorder;
begin
  if Source is TJSBorder then
  begin
    lSrc := Source as TJSBorder;
    Color := lSrc.Color;
    Visible := lSrc.Visible;
    Width := lSrc.Width;
  end
  else
    inherited;
end;

constructor TJSBorder.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  Color := clGray;
  Visible := False;
  Width := 1;
end;

{ TJSTaskDialogForm }

procedure TJSTaskDialogForm.ActiveChanged;
begin
  inherited;
  if (FDialog <> nil) then
    FDialog.InvalidateButtons;
end;

procedure TJSTaskDialogForm.Click;
begin
  inherited;
  DoClientClick(Mouse.CursorPos);
end;

constructor TJSTaskDialogForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
  KeyPreview := True;
  BorderIcons := [biSystemMenu];
  FDialog := nil;
  FLastTimer := 0;
end;

procedure TJSTaskDialogForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
//  if (Dialog <> nil) and (Dialog.BiDiMode <> bdLeftToRight) then
//    Params.ExStyle := Params.ExStyle or WS_EX_LAYOUTRTL// or WS_EX_NOINHERITLAYOUT
end;

procedure TJSTaskDialogForm.CreateWnd;
var
  lProgress: TControl;
begin
  inherited;
  if not Dialog.AllowCancel then
    EnableMenuItem(GetSystemMenu(Handle, False), SC_CLOSE, MF_DISABLED or MF_GRAYED);
  if Dialog.ShowProgressBar then
  begin

    lProgress := Dialog.GetControl(ctProgressBar);
    if lProgress is TJSProgressBar then
    begin
      (lProgress as TJSProgressBar).Deactivate;
      (lProgress as TJSProgressBar).Activate(Dialog.Progress.Interval);
    end
    else if lProgress is TJSProgressBarEx then
    begin
      if (doProgressBarMarquee in Dialog.DialogOptions) then
      begin
        (lProgress as TJSProgressBarEx).Active := False;
        (lProgress as TJSProgressBarEx).Active := True;
      end;
    end;
//    Dialog.ResetProgressBar;
  end;
end;

procedure TJSTaskDialogForm.DoClientClick(const APt: TPoint);
begin
  if Assigned(FOnClientClick) then
    FOnClientClick(Self, APt);
end;

procedure TJSTaskDialogForm.DoClose(var Action: TCloseAction);
begin
  inherited;
  if Dialog <> nil then
  begin
    // need to free the form explicitly when closed when the
    // form isn't modal. This is a massive hoop jumping
    // expedition to support Delphi version 6, 7 and 2005.
    if not (doModal in Dialog.DialogOptions) then
      PostMessage(Handle, WM_NONMODAL_FREE, 0, 0);
  end
  else
    PostMessage(Handle, WM_NONMODAL_FREE, 0, 0);
end;

procedure TJSTaskDialogForm.EndTimer;
begin
  KillTimer(Handle, 1);
end;

function TJSTaskDialogForm.GetTaskDialogText: TJSString;
const
  VerificationChar: array [Boolean] of TJSString = (' ', 'X');
  ExpandoChar: array [Boolean] of TJSString = ('V', '^');
  NewLine = #13#10;
  NewLines = NewLine + NewLine;
var
  i: Integer;
  j: TCommonButton;
  lFileName: TJSString;
  lStream: TMemoryStream;

  function RemovePrefix(const aStr: TJSString): TJSString;
  begin
    result := JSStringReplace(aStr, '&', '', []);
  end;

  function GetExpandoText(Showing: Boolean): TJSString;
  begin
    if Showing then
      result := FDialog.Expando.HideText
    else
      result := FDialog.Expando.ShowText;
    result := RemovePrefix(result);
  end;

begin
  result := '[Window Title]' + NewLine;
  result := result + FDialog.Title + NewLines;
  if FDialog.Header.Visible then
  begin
    result := JSFormat('%s[Header]%s', [result, NewLine]);
    result := result + FDialog.Header.Text + NewLines;
  end;
  if FDialog.Instruction.Text <> '' then
  begin
    result := JSFormat('%s[Main Instruction]%s', [result, NewLine]);
    result := result + FDialog.Instruction.Text + NewLines;
  end;
  if FDialog.Content.Text <> '' then
  begin
    result := JSFormat('%s[Content]%s', [result, NewLine]);
    result := result + FDialog.Content.Text + NewLines;
  end;
  if FDialog.Expando.Visible and not FDialog.Expando.ShowInFooter then
  begin
    result := JSFormat('%s[Expanded Information]%s', [result, NewLine]);
    if FDialog.FMoreRichEdit <> nil then
    begin
      FDialog.LoadStringIntoRichEdit(FDialog.Expando.Lines.Text);
      result := result + FDialog.RetrievePlainTextFromRichEdit + NewLines;
    end
    else
      result := result + FDialog.Expando.Lines.Text + NewLines;
  end;
  if (doCommandLinks in FDialog.DialogOptions) or
    (doCommandLinksNoIcon in FDialog.DialogOptions) then
  begin
    for i := 0 to FDialog.CustomButtons.Count - 1 do
    begin
      result := result + '[' + FDialog.CustomButtons[i].Caption + ']' + NewLine;
      if trim(FDialog.CustomButtons[i].Info.Text) <> '' then
        result := result + JSFormat('  %s' + NewLine, [FDialog.CustomButtons[i].Info.Text]);
    end;
    result := result + NewLine;
  end;
  if (doShowHelpLink in FDialog.DialogOptions) and
     (FDialog.HelpLink.Text <> '') then
    result := JSFormat('%s[HelpLink]%s%s%s', [result, NewLine, FDialog.HelpLink.Text, NewLines]);
  if FDialog.Expando.Visible then
  begin
    result := JSFormat('%s[%s] %s  ', [result, ExpandoChar[FDialog.IsExpanded],
      GetExpandoText(FDialog.IsExpanded)]);
    if FDialog.Verification.Visible then
      result := result + NewLine;
  end;
  if FDialog.Verification.Visible then
  begin
    result := JSFormat('%s[%s] %s  ', [result, VerificationChar[FDialog.VerificationResult],
      RemovePrefix(FDialog.Verification.Text)]);
  end;
  if FDialog.ButtonBar.Visible and ((FDialog.FCustomButtons.Count > 0) and (FDialog.ShowCommandLinks)) or
    (FDialog.FCustomButtons.Count = 0) then
  begin
    for j := low(TCommonButton) to high(TCommonButton) do
    begin
      if j in FDialog.ButtonBar.Buttons then
      begin
        result := JSFormat('%s[%s] ', [result, RemovePrefix(JSUnicodeWideStringFromCompilerString(CommonButtonCaptions(j)))]);
      end;
    end;
    result := result + NewLines;
  end
  else if (not FDialog.Verification.Visible) and (not FDialog.Expando.Visible) then
    result := result + NewLine;
  if (FDialog.CustomButtons.Count > 0) and
    (not (doCommandLinks in FDialog.DialogOptions) and not (doCommandLinksNoIcon in FDialog.DialogOptions)) then
  begin
    for i := 0 to FDialog.CustomButtons.Count - 1 do
    begin
      result := JSFormat('%s[%s] ', [result, FDialog.CustomButtons[i].Caption]);
    end;
    result := result + NewLine;
  end;
  if FDialog.Footer.Visible then
  begin
    result := JSFormat('%s[Footer]%s', [result, NewLine]);
    result := result + FDialog.Footer.Text + NewLine;
  end;
  if FDialog.Expando.Visible and FDialog.Expando.ShowInFooter then
  begin
    result := JSFormat('%s%s[Expanded Information]%s', [result, NewLine, NewLine]);
    // need to make sure the richedit control is the correct width
    if (FDialog.FMoreRichEdit <> nil) and
      (not FDialog.FMoreRichEdit.Visible) then
      FDialog.FMoreRichEdit.Width := ClientWidth - (2 * FDialog.FHorzSpacing);
    if FDialog.FMoreRichEdit <> nil then
    begin
      if FDialog.Expando.MoreSource = msFile then
      begin
        lFileName := '';
        FDialog.DoGetMoreFileName(lFileName);
        if FileExists(lFileName) then
          FDialog.FMoreRichEdit.Lines.LoadFromFile(lFileName);
      end
      else if FDialog.Expando.MoreSource = msStream then
      begin
        lStream := TMemoryStream.Create;
        try
          FDialog.DoGetMoreStream(lStream);
          lStream.Position := 0;
          FDialog.FMoreRichEdit.Lines.LoadFromStream(lStream);
        finally
          lStream.Free;
        end;
      end
      else
      begin
        FDialog.LoadStringIntoRichEdit(FDialog.Expando.Lines.Text);
      end;
      result := result + FDialog.RetrievePlainTextFromRichEdit + NewLines;
    end
    else
      result := result + FDialog.Expando.Lines.Text;
  end;
end;

procedure TJSTaskDialogForm.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = Word('C')) then
  begin
    Beep;
    Clipboard.AsText := GetTaskDialogText;
  end;
  if (Shift = [ssAlt]) then
  begin
    if (Key = VK_F4) and not Dialog.AllowCancel then
      Key := 0
    else
      Dialog.ShowCommandLinkHotKeys;
  end;
end;

procedure TJSTaskDialogForm.Paint;
begin
  if FDialog <> nil then
    FDialog.Paint
  else
    Close;
end;

procedure TJSTaskDialogForm.StartTimer;
begin
  if not (csDesigning in ComponentState) then
    SetTimer(Handle, 1, Dialog.Timer.Interval, nil);
end;

procedure TJSTaskDialogForm.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TJSTaskDialogForm.WMNonModalFree(var Message: TMessage);
var
  lForm: TJSCustomTaskDialogForm;
begin
  if Dialog <> nil then
  begin
    if doTimer in Dialog.DialogOptions then
      EndTimer;
    // it isn't pretty but it works
    lForm := Dialog.FForm;
    Dialog.FForm := nil;
    FreeAndNil(lForm);
  end;
end;

procedure TJSTaskDialogForm.WMPerformSnapTo(var Message: TMessage);
begin
  if FDialog <> nil then
    SnapToDefaultButton(FDialog.FDefaultButton);
end;

procedure TJSTaskDialogForm.WMTimer(var Message: TWMTimer);
begin
  if Message.TimerID = 1 then
  begin
    if FDialog <> nil then
    begin
      if FLastTimer = 0 then
        FDialog.DoTimerEvent(0)
      else
        FDialog.DoTimerEvent(GetTickCount - FLastTimer);
    end;
    FLastTimer := GetTickCount;
  end;
end;

procedure TJSTaskDialogForm.WMWinIniChange(var Message: TMessage);
begin
  inherited;
//  if (Dialog <> nil) and (Dialog.BiDiMode <> bdLeftToRight) then
//    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYOUTRTL);
end;

{ TJSDefaultFonts }

const
  { Name of the default font to use }
  DEF_FONTNAME = 'Segoe UI';
  { Name of the backup font if the DEF_FONTNAME font is not available }
  BACKUP_FONTNAME = 'Tahoma';

constructor TJSDefaultFonts.Create;
const
  // Vista requires font size increased by 1
  IncFontSize: array [Boolean] of Integer = (0, 1);
var
  lFont: TFont;
  lSrcFont: TFont;
  lFontName: string;
  lMetrics: TNonClientMetrics;
begin
  inherited;
  FFonts := TObjectList.Create(True);
  // (ftContent, ftInstruction, ftHeader, ftFooter, ftExpando)
  // Index of the Font in the list is the
  // ordinal value of the TJSFontType enum.
  lSrcFont := TFont.Create;
  try
    // load the OS MessageFont to default font settings
    lMetrics.cbSize:= SizeOf(NonClientMetrics);
    {$WARNINGS OFF}
    if not SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @lMetrics, 0) then
    {$WARNINGS ON}
    begin
      if IsVista then
        lFontName := DEF_FONTNAME
      else
        lFontName := BACKUP_FONTNAME;
      lSrcFont.Name := lFontName;
      lSrcFont.Size := 8 + IncFontSize[IsVista];
      lSrcFont.Charset := DefFontData.Charset;
    end
    else
      lSrcFont.Handle := CreateFontIndirect(lMetrics.lfMessageFont);
    lFont := TFont.Create;
    lFont.Assign(lSrcFont);
    FFonts.Add(lFont);
    lFont := TFont.Create;
    lFont.Assign(lSrcFont);
    lFont.Size := 11 + IncFontSize[IsVista];
    lFont.Color := clInstruction;
    FFonts.Add(lFont);
    lFont := TFont.Create;
    lFont.Assign(lSrcFont);
    FFonts.Add(lFont);
    lFont := TFont.Create;
    lFont.Assign(lSrcFont);
    FFonts.Add(lFont);
    lFont := TFont.Create;
    lFont.Assign(lSrcFont);
    FFonts.Add(lFont);
  finally
    lSrcFont.Free;
  end;
end;

destructor TJSDefaultFonts.Destroy;
begin
  FFonts.Free;
  inherited;
end;

function TJSDefaultFonts.GetFont(AFontType: TJSFontType): TFont;
begin
  result := TFont(FFonts[ord(AFontType)]);
end;

procedure TJSDefaultFonts.SetFont(AFontType: TJSFontType; AFont: TFont);
begin
  TFont(FFonts[ord(AFontType)]).Assign(AFont);
end;

function TJSCustomDialog.IsChecked(const aValue: Integer): Boolean;
var
  lComp: TComponent;
  lCtrl: TControl;
begin
  result := False;
  if FForm = nil then
    Exit;
  lComp := FForm.FindComponent('rb' + IntToStr(aValue));
  if (lComp <> nil) and (lComp is TControl) then
  begin
    lCtrl := lComp as TControl;
    result := DoGetRadioButtonChecked(lCtrl);
  end;
end;

function TJSCustomDialog.IsColorStored: Boolean;
begin
  {$IFDEF DELPHIXE2}
  Result := not StyleServices.Enabled or StyleServices.IsSystemStyle;
  {$ELSE}
  Result := True;
  {$ENDIF DELPHIXE2}
end;

function TJSCustomDialog.IsCustomButtonsStored: Boolean;
begin
  result := (FCustomButtons <> nil) and (FCustomButtons.Count > 0);
end;

function TJSCustomDialog.IsDialogAvailable: Boolean;
begin
  Result := FForm <> nil;
end;

function TJSCustomDialog.IsExpanded: Boolean;
begin
  result := (FShowMoreButton <> nil) and (FShowMoreButton.Expanded) and not FExpanding;
end;

function TJSCustomDialog.IsFontStored: Boolean;
begin
  result := not UseDefaultFonts
end;

function TJSCustomDialog.IsRadioButtonsStored: Boolean;
begin
  result := (FRadioButtons <> nil) and (FRadioButtons.Count > 0);
end;

{ TJSDialogOwnerPersistent }

constructor TJSDialogOwnedPersistent.Create(ADialog: TJSCustomDialog);
begin
  inherited Create; // keep .NET happy
  FDialog := ADialog;
end;

{ TJSLocation }

procedure TJSLocation.Assign(Source: TPersistent);
var
  lSrc: TJSLocation;
begin
  if Source is TJSLocation then
  begin
    lSrc := Source as TJSLocation;
    Left := lSrc.Left;
    Top := lSrc.Top;
  end;
end;

constructor TJSLocation.Create;
begin
  inherited;
  FLeft := -1;
  FTop := -1;
end;

{ TJSFooter }

constructor TJSFooter.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  Color := clBtnFace;
end;

{ TJSTimer }

procedure TJSTimer.Assign(Source: TPersistent);
begin
  if Source is TJSTimer then
    FInterval := (Source as TJSTimer).Interval
  else
    inherited;
end;

constructor TJSTimer.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FInterval := 1000;
end;

{ TJSRadioButton }

procedure TJSRadioButton.Assign(Source: TPersistent);
var
  lSrc: TJSRadioButton;
begin
  if Source is TJSRadioButton then
  begin
    lSrc := Source as TJSRadioButton;
    FShowBorder := lSrc.ShowBorder;
    FCaption := lSrc.Caption;
    FColumns := lSrc.Columns;
  end;
end;

constructor TJSRadioButton.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FShowBorder := False;
  FCaption := '';
  FColumns := 1;
end;

{ TJSAnimate }

procedure TJSAnimate.Assign(Source: TPersistent);
var
  LSrc: TJSAnimate;
begin
  if Source is TJSAnimate then
  begin
    LSrc := TJSAnimate(Source);
    Enabled := LSrc.Enabled;
    Speed := LSrc.Speed;
    Step := LSrc.Step;
  end
  else
    inherited;
end;

constructor TJSAnimate.Create;
begin
  inherited;
  FEnabled := False;
  FSpeed := 10;
  FStep := 2;
end;


{ TJSButtonOptions }

procedure TJSButtonOptions.Assign(Source: TPersistent);
var
  LSrc: TJSButtonOptions;
begin
  if Source is TJSButtonOptions then
  begin
    LSrc := TJSButtonOptions(Source);
    CommandLinkColors := LSrc.CommandLinkColors;
  end
  else
    inherited;
end;

constructor TJSButtonOptions.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FCommandLinkColors := TJSCommandLinkColors.Create(nil);
end;

destructor TJSButtonOptions.Destroy;
begin
  FCommandLinkColors.Free;
  inherited;
end;

procedure TJSButtonOptions.SetCommandLinkColors(const Value: TJSCommandLinkColors);
begin
  FCommandLinkColors.Assign(Value);
end;

{ TJSSheetOptions }

procedure TJSSheetOptions.Assign(Source: TPersistent);
var
  LSrc: TJSSheetOptions;
begin
  if Source is TJSSheetOptions then
  begin
    LSrc := TJSSheetOptions(Source);
    FInterval := LSrc.Interval;
    FStyle := LSrc.Location;
  end
  else
    inherited;
end;

constructor TJSSheetOptions.Create(ADialog: TJSCustomDialog);
begin
  inherited;
  FInterval := 500;
  FStyle := slActiveForm;
end;

procedure TJSSheetOptions.SetInterval(const Value: Cardinal);
begin
  if FInterval <> Value then
  begin
    FInterval := Value;
    DoChange;
  end;
end;

procedure TJSSheetOptions.SetStyle(const Value: TJSSheetLocation);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    DoChange;
  end;
end;

initialization
  DefaultFonts := TJSDefaultFonts.Create;
{$IFDEF TRIAL}
  LMDCheckVALIDInfo;
{$ENDIF}
finalization
  DefaultFonts.Free;

end.
