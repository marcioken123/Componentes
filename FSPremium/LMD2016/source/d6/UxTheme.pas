{******************************************************************************}
{                                                                              }
{  This unit is included for theme support in Delphi6 with author's permission.}
{  The unit is actually a merge of original uxtheme.pas and tmschema.pas units.}
{                                                                              }
{******************************************************************************}


{******************************************************************************}
{                                                                              }
{ Visual Styles (Themes) API interface Unit for Object Pascal                  }
{                                                                              }
{ Portions created by Microsoft are Copyright (C) 1995-2001 Microsoft          }
{ Corporation. All Rights Reserved.                                            }
{                                                                              }
{ The original file is: uxtheme.h, released June 2001. The original Pascal     }
{ code is: UxTheme.pas, released July 2001. The initial developer of the       }
{ Pascal code is Marcel van Brakel (brakelm@chello.nl).                        }
{                                                                              }
{ Portions created by Marcel van Brakel are Copyright (C) 1999-2001            }
{ Marcel van Brakel. All Rights Reserved.                                      }
{                                                                              }
{ Portions created by Mike Lischke are Copyright (C) 1999-2002                 }
{ Mike Lischke. All Rights Reserved.                                           }
{                                                                              }
{ Obtained through: Joint Endeavour of Delphi Innovators (Project JEDI)        }
{                                                                              }
{ You may retrieve the latest version of this file at the Project JEDI home    }
{ page, located at http://delphi-jedi.org or my personal homepage located at   }
{ http://members.chello.nl/m.vanbrakel2                                        }
{                                                                              }
{ The contents of this file are used with permission, subject to the Mozilla   }
{ Public License Version 1.1 (the "License"); you may not use this file except }
{ in compliance with the License. You may obtain a copy of the License at      }
{ http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Alternatively, the contents of this file may be used under the terms of the  }
{ GNU Lesser General Public License (the  "LGPL License"), in which case the   }
{ provisions of the LGPL License are applicable instead of those above.        }
{ If you wish to allow use of your version of this file only under the terms   }
{ of the LGPL License and not to allow others to use your version of this file }
{ under the MPL, indicate your decision by deleting  the provisions above and  }
{ replace  them with the notice and other provisions required by the LGPL      }
{ License.  If you do not delete the provisions above, a recipient may use     }
{ your version of this file under either the MPL or the LGPL License.          }
{                                                                              }
{ For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html }
{                                                                              }
{******************************************************************************}

unit UxTheme;

{$HPPEMIT ''}
{$HPPEMIT '#include "uxtheme.h"'}
{$HPPEMIT ''}

interface

uses
  Windows;


procedure FreeThemeLibrary;
function InitThemeLibrary: Boolean;
function UseThemes: Boolean;



//----------------------------------------------------------------------------------------------------------------------
//   TM_ENUM (must also be declared in PROPERTIES section)
//
//    these cannot be renumbered (part of uxtheme API)
//----------------------------------------------------------------------------------------------------------------------

type
  BGTYPE = Cardinal;

const
  BT_IMAGEFILE   = 0;
  BT_BORDERFILL  = 1;
  BT_NONE        = 2;

type
  IMAGELAYOUT = Cardinal;

const
  IL_VERTICAL    = 0;
  IL_HORIZONTAL  = 1;

type
  BORDERTYPE = Cardinal;

const
  BT_RECT       = 0;
  BT_ROUNDRECT  = 1;
  BT_ELLIPSE    = 2;

type
  FILLTYPE = Cardinal;

const
  FT_SOLID           = 0;
  FT_VERTGRADIENT    = 1;
  FT_HORZGRADIENT    = 2;
  FT_RADIALGRADIENT  = 3;
  FT_TILEIMAGE       = 4;

type
  SIZINGTYPE = Cardinal;

const
  ST_TRUESIZE  = 0;
  ST_STRETCH   = 1;
  ST_TILE      = 2;

type
  HALIGN = Cardinal;

const
  HA_LEFT    = 0;
  HA_CENTER  = 1;
  HA_RIGHT   = 2;

type
  CONTENTALIGNMENT = Cardinal;

const
  CA_LEFT    = 0;
  CA_CENTER  = 1;
  CA_RIGHT   = 2;

type
  VALIGN = Cardinal;

const
  VA_TOP     = 0;
  VA_CENTER  = 1;
  VA_BOTTOM  = 2;

type
  OFFSETTYPE = Cardinal;

const
  OT_TOPLEFT            = 0;
  OT_TOPRIGHT           = 1;
  OT_TOPMIDDLE          = 2;
  OT_BOTTOMLEFT         = 3;
  OT_BOTTOMRIGHT        = 4;
  OT_BOTTOMMIDDLE       = 5;
  OT_MIDDLELEFT         = 6;
  OT_MIDDLERIGHT        = 7;
  OT_LEFTOFCAPTION      = 8;
  OT_RIGHTOFCAPTION     = 9;
  OT_LEFTOFLASTBUTTON   = 10;
  OT_RIGHTOFLASTBUTTON  = 11;
  OT_ABOVELASTBUTTON    = 12;
  OT_BELOWLASTBUTTON    = 13;

type
  ICONEFFECT = Cardinal;

const
  ICE_NONE    = 0;
  ICE_GLOW    = 1;
  ICE_SHADOW  = 2;
  ICE_PULSE   = 3;
  ICE_ALPHA   = 4;

type
  TEXTSHADOWTYPE = Cardinal;

const
  TST_NONE        = 0;
  TST_SINGLE      = 1;
  TST_CONTINUOUS  = 2;

type
  GLYPHTYPE = Cardinal;

const
  GT_NONE        = 0;
  GT_IMAGEGLYPH  = 1;
  GT_FONTGLYPH   = 2;

type
  IMAGESELECTTYPE = Cardinal;

const
  IST_NONE  = 0;
  IST_SIZE  = 1;
  IST_DPI   = 2;

type
  TRUESIZESCALINGTYPE = Cardinal;

const
  TSST_NONE  = 0;
  TSST_SIZE  = 1;
  TSST_DPI   = 2;

type
  GLYPHFONTSIZINGTYPE = Cardinal;

const
  GFST_NONE  = 0;
  GFST_SIZE  = 1;
  GFST_DPI   = 2;

//----------------------------------------------------------------------------------------------------------------------
//    PROPERTIES - used by uxtheme rendering and controls
//
//    these cannot be renumbered (part of uxtheme API)
//----------------------------------------------------------------------------------------------------------------------

const

  //---- primitive types ----

  TMT_STRING = 201;
  TMT_INT = 202;
  TMT_BOOL = 203;
  TMT_COLOR = 204;
  TMT_MARGINS = 205;
  TMT_FILENAME = 206;
  TMT_SIZE = 207;
  TMT_POSITION = 208;
  TMT_RECT = 209;
  TMT_FONT = 210;
  TMT_INTLIST = 211;

  //---- special misc. properties ----

  TMT_COLORSCHEMES = 401;
  TMT_SIZES = 402;
  TMT_CHARSET = 403;

  //---- [documentation] properties ----

  TMT_DISPLAYNAME = 601;
  TMT_TOOLTIP = 602;
  TMT_COMPANY = 603;
  TMT_AUTHOR = 604;
  TMT_COPYRIGHT = 605;
  TMT_URL = 606;
  TMT_VERSION = 607;
  TMT_DESCRIPTION = 608;

  {$ifndef BCB}
    TMT_FIRST_RCSTRING_NAME = TMT_DISPLAYNAME;
    TMT_LAST_RCSTRING_NAME  = TMT_DESCRIPTION;
  {$endif BCB}

  //---- theme metrics: fonts ----

  TMT_CAPTIONFONT = 801;
  TMT_SMALLCAPTIONFONT = 802;
  TMT_MENUFONT = 803;
  TMT_STATUSFONT = 804;
  TMT_MSGBOXFONT = 805;
  TMT_ICONTITLEFONT = 806;

  {$ifndef BCB}
    TMT_FIRSTFONT = TMT_CAPTIONFONT;
    TMT_LASTFONT  = TMT_ICONTITLEFONT;
  {$endif BCB}
  
  //---- theme metrics: bools ----

  TMT_FLATMENUS = 1001;

  {$ifndef BCB}
    TMT_FIRSTBOOL = TMT_FLATMENUS;
    TMT_LASTBOOL  = TMT_FLATMENUS;
  {$endif BCB}
  
  //---- theme metrics: sizes ----

  TMT_SIZINGBORDERWIDTH = 1201;
  TMT_SCROLLBARWIDTH = 1202;
  TMT_SCROLLBARHEIGHT = 1203;
  TMT_CAPTIONBARWIDTH = 1204;
  TMT_CAPTIONBARHEIGHT = 1205;
  TMT_SMCAPTIONBARWIDTH = 1206;
  TMT_SMCAPTIONBARHEIGHT = 1207;
  TMT_MENUBARWIDTH = 1208;
  TMT_MENUBARHEIGHT = 1209;

  {$ifndef BCB}
    TMT_FIRSTSIZE  = TMT_SIZINGBORDERWIDTH;
    TMT_LASTSIZE  = TMT_MENUBARHEIGHT;
  {$endif BCB}
  
  //---- theme metrics: ints ----

  TMT_MINCOLORDEPTH = 1301;

  {$ifndef BCB}
    TMT_FIRSTINT = TMT_MINCOLORDEPTH;
    TMT_LASTINT  = TMT_MINCOLORDEPTH;
  {$endif BCB}
  
  //---- theme metrics: strings ----

  TMT_CSSNAME = 1401;
  TMT_XMLNAME = 1402;

  {$ifndef BCB}
    TMT_FIRSTSTRING  = TMT_CSSNAME;
    TMT_LASTSTRING   = TMT_XMLNAME;
  {$endif BCB}

  //---- theme metrics: colors ----

  TMT_SCROLLBAR = 1601;
  TMT_BACKGROUND = 1602;
  TMT_ACTIVECAPTION = 1603;
  TMT_INACTIVECAPTION = 1604;
  TMT_MENU = 1605;
  TMT_WINDOW = 1606;
  TMT_WINDOWFRAME = 1607;
  TMT_MENUTEXT = 1608;
  TMT_WINDOWTEXT = 1609;
  TMT_CAPTIONTEXT = 1610;
  TMT_ACTIVEBORDER = 1611;
  TMT_INACTIVEBORDER = 1612;
  TMT_APPWORKSPACE = 1613;
  TMT_HIGHLIGHT = 1614;
  TMT_HIGHLIGHTTEXT = 1615;
  TMT_BTNFACE = 1616;
  TMT_BTNSHADOW = 1617;
  TMT_GRAYTEXT = 1618;
  TMT_BTNTEXT = 1619;
  TMT_INACTIVECAPTIONTEXT = 1620;
  TMT_BTNHIGHLIGHT = 1621;
  TMT_DKSHADOW3D = 1622;
  TMT_LIGHT3D = 1623;
  TMT_INFOTEXT = 1624;
  TMT_INFOBK = 1625;
  TMT_BUTTONALTERNATEFACE = 1626;
  TMT_HOTTRACKING = 1627;
  TMT_GRADIENTACTIVECAPTION = 1628;
  TMT_GRADIENTINACTIVECAPTION = 1629;
  TMT_MENUHILIGHT = 1630;
  TMT_MENUBAR = 1631;

  {$ifndef BCB}
    TMT_FIRSTCOLOR = TMT_SCROLLBAR;
    TMT_LASTCOLOR  = TMT_MENUBAR;
  {$endif BCB}

  //---- hue substitutions ----

  TMT_FROMHUE1 = 1801;
  TMT_FROMHUE2 = 1802;
  TMT_FROMHUE3 = 1803;
  TMT_FROMHUE4 = 1804;
  TMT_FROMHUE5 = 1805;
  TMT_TOHUE1 = 1806;
  TMT_TOHUE2 = 1807;
  TMT_TOHUE3 = 1808;
  TMT_TOHUE4 = 1809;
  TMT_TOHUE5 = 1810;

  //---- color substitutions ----

  TMT_FROMCOLOR1 = 2001;
  TMT_FROMCOLOR2 = 2002;
  TMT_FROMCOLOR3 = 2003;
  TMT_FROMCOLOR4 = 2004;
  TMT_FROMCOLOR5 = 2005;
  TMT_TOCOLOR1 = 2006;
  TMT_TOCOLOR2 = 2007;
  TMT_TOCOLOR3 = 2008;
  TMT_TOCOLOR4 = 2009;
  TMT_TOCOLOR5 = 2010;

  //---- rendering BOOL properties ----

  TMT_TRANSPARENT = 2201;
  TMT_AUTOSIZE = 2202;
  TMT_BORDERONLY = 2203;
  TMT_COMPOSITED = 2204;
  TMT_BGFILL = 2205;
  TMT_GLYPHTRANSPARENT = 2206;
  TMT_GLYPHONLY = 2207;
  TMT_ALWAYSSHOWSIZINGBAR = 2208;
  TMT_MIRRORIMAGE = 2209;
  TMT_UNIFORMSIZING = 2210;
  TMT_INTEGRALSIZING = 2211;
  TMT_SOURCEGROW = 2212;
  TMT_SOURCESHRINK = 2213;

  //---- rendering INT properties ----

  TMT_IMAGECOUNT = 2401;
  TMT_ALPHALEVEL = 2402;
  TMT_BORDERSIZE = 2403;
  TMT_ROUNDCORNERWIDTH = 2404;
  TMT_ROUNDCORNERHEIGHT = 2405;
  TMT_GRADIENTRATIO1 = 2406;
  TMT_GRADIENTRATIO2 = 2407;
  TMT_GRADIENTRATIO3 = 2408;
  TMT_GRADIENTRATIO4 = 2409;
  TMT_GRADIENTRATIO5 = 2410;
  TMT_PROGRESSCHUNKSIZE = 2411;
  TMT_PROGRESSSPACESIZE = 2412;
  TMT_SATURATION = 2413;
  TMT_TEXTBORDERSIZE = 2414;
  TMT_ALPHATHRESHOLD = 2415;
  TMT_WIDTH = 2416;
  TMT_HEIGHT = 2417;
  TMT_GLYPHINDEX = 2418;
  TMT_TRUESIZESTRETCHMARK = 2419;
  TMT_MINDPI1 = 2420;
  TMT_MINDPI2 = 2421;
  TMT_MINDPI3 = 2422;
  TMT_MINDPI4 = 2423;
  TMT_MINDPI5 = 2424;

  //---- rendering FONT properties ----

  TMT_GLYPHFONT = 2601;

  //---- rendering INTLIST properties ----
  // start with 2801
                                              // (from smallest to largest)
  //---- rendering FILENAME properties ----

  TMT_IMAGEFILE = 3001;
  TMT_IMAGEFILE1 = 3002;
  TMT_IMAGEFILE2 = 3003;
  TMT_IMAGEFILE3 = 3004;
  TMT_IMAGEFILE4 = 3005;
  TMT_IMAGEFILE5 = 3006;
  TMT_STOCKIMAGEFILE = 3007;
  TMT_GLYPHIMAGEFILE = 3008;

  //---- rendering STRING properties ----

  TMT_TEXT = 3201;

  //---- rendering POSITION (x and y values) properties ----

  TMT_OFFSET = 3401;
  TMT_TEXTSHADOWOFFSET = 3402;
  TMT_MINSIZE = 3403;
  TMT_MINSIZE1 = 3404;
  TMT_MINSIZE2 = 3405;
  TMT_MINSIZE3 = 3406;
  TMT_MINSIZE4 = 3407;
  TMT_MINSIZE5 = 3408;
  TMT_NORMALSIZE = 3409;

  //---- rendering MARGIN properties ----

  TMT_SIZINGMARGINS = 3601;
  TMT_CONTENTMARGINS = 3602;
  TMT_CAPTIONMARGINS = 3603;

  //---- rendering COLOR properties ----

  TMT_BORDERCOLOR = 3801;
  TMT_FILLCOLOR = 3802;
  TMT_TEXTCOLOR = 3803;
  TMT_EDGELIGHTCOLOR = 3804;
  TMT_EDGEHIGHLIGHTCOLOR = 3805;
  TMT_EDGESHADOWCOLOR = 3806;
  TMT_EDGEDKSHADOWCOLOR = 3807;
  TMT_EDGEFILLCOLOR = 3808;
  TMT_TRANSPARENTCOLOR = 3809;
  TMT_GRADIENTCOLOR1 = 3810;
  TMT_GRADIENTCOLOR2 = 3811;
  TMT_GRADIENTCOLOR3 = 3812;
  TMT_GRADIENTCOLOR4 = 3813;
  TMT_GRADIENTCOLOR5 = 3814;
  TMT_SHADOWCOLOR = 3815;
  TMT_GLOWCOLOR = 3816;
  TMT_TEXTBORDERCOLOR = 3817;
  TMT_TEXTSHADOWCOLOR = 3818;
  TMT_GLYPHTEXTCOLOR = 3819;
  TMT_GLYPHTRANSPARENTCOLOR = 3820;
  TMT_FILLCOLORHINT = 3821;
  TMT_BORDERCOLORHINT = 3822;
  TMT_ACCENTCOLORHINT = 3823;

  //---- rendering enum properties (must be declared in TM_ENUM section above) ----

  TMT_BGTYPE = 4001;
  TMT_BORDERTYPE = 4002;
  TMT_FILLTYPE = 4003;
  TMT_SIZINGTYPE = 4004;
  TMT_HALIGN = 4005;
  TMT_CONTENTALIGNMENT = 4006;
  TMT_VALIGN = 4007;
  TMT_OFFSETTYPE = 4008;
  TMT_ICONEFFECT = 4009;
  TMT_TEXTSHADOWTYPE = 4010;
  TMT_IMAGELAYOUT = 4011;
  TMT_GLYPHTYPE = 4012;
  TMT_IMAGESELECTTYPE = 4013;
  TMT_GLYPHFONTSIZINGTYPE = 4014;
  TMT_TRUESIZESCALINGTYPE = 4015;

  //---- custom properties (used only by controls/shell) ----

  TMT_USERPICTURE = 5001;
  TMT_DEFAULTPANESIZE = 5002;
  TMT_BLENDCOLOR = 5003;

//----------------------------------------------------------------------------------------------------------------------
//   "Window" (i.e., non-client) Parts & States
//
//    these cannot be renumbered (part of uxtheme API)
//----------------------------------------------------------------------------------------------------------------------

type
  WINDOWPARTS = Cardinal;

const
  WINDOWPartFiller0                  = 0;
  WP_CAPTION                         = 1;
  WP_SMALLCAPTION                    = 2;
  WP_MINCAPTION                      = 3;
  WP_SMALLMINCAPTION                 = 4;
  WP_MAXCAPTION                      = 5;
  WP_SMALLMAXCAPTION                 = 6;
  WP_FRAMELEFT                       = 7;
  WP_FRAMERIGHT                      = 8;
  WP_FRAMEBOTTOM                     = 9;
  WP_SMALLFRAMELEFT                  = 10;
  WP_SMALLFRAMERIGHT                 = 11;
  WP_SMALLFRAMEBOTTOM                = 12;
  WP_SYSBUTTON                       = 13;
  WP_MDISYSBUTTON                    = 14;
  WP_MINBUTTON                       = 15;
  WP_MDIMINBUTTON                    = 16;
  WP_MAXBUTTON                       = 17;
  WP_CLOSEBUTTON                     = 18;
  WP_SMALLCLOSEBUTTON                = 19;
  WP_MDICLOSEBUTTON                  = 20;
  WP_RESTOREBUTTON                   = 21;
  WP_MDIRESTOREBUTTON                = 22;
  WP_HELPBUTTON                      = 23;
  WP_MDIHELPBUTTON                   = 24;
  WP_HORZSCROLL                      = 25;
  WP_HORZTHUMB                       = 26;
  WP_VERTSCROLL                      = 27;
  WP_VERTTHUMB                       = 28;
  WP_DIALOG                          = 29;
  WP_CAPTIONSIZINGTEMPLATE           = 30;
  WP_SMALLCAPTIONSIZINGTEMPLATE      = 31;
  WP_FRAMELEFTSIZINGTEMPLATE         = 32;
  WP_SMALLFRAMELEFTSIZINGTEMPLATE    = 33;
  WP_FRAMERIGHTSIZINGTEMPLATE        = 34;
  WP_SMALLFRAMERIGHTSIZINGTEMPLATE   = 35;
  WP_FRAMEBOTTOMSIZINGTEMPLATE       = 36;
  WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE  = 37;

type
  FRAMESTATES = Cardinal;

const
  FRAMEStateFiller0  = 0;
  FS_ACTIVE          = 1;
  FS_INACTIVE        = 2;

type
  CAPTIONSTATES = Cardinal;

const
  CAPTIONStateFiller0  = 0;
  CS_ACTIVE            = 1;
  CS_INACTIVE          = 2;
  CS_DISABLED          = 3;

type
  MAXCAPTIONSTATES = Cardinal;

const
  MAXCAPTIONStateFiller0  = 0;
  MXCS_ACTIVE             = 1;
  MXCS_INACTIVE           = 2;
  MXCS_DISABLED           = 3;

type
  MINCAPTIONSTATES = Cardinal;

const
  MINCAPTIONStateFiller0  = 0;
  MNCS_ACTIVE             = 1;
  MNCS_INACTIVE           = 2;
  MNCS_DISABLED           = 3;

type
  HORZSCROLLSTATES = Cardinal;

const
  HORZSCROLLStateFiller0  = 0;
  HSS_NORMAL              = 1;
  HSS_HOT                 = 2;
  HSS_PUSHED              = 3;
  HSS_DISABLED            = 4;

type
  HORZTHUMBSTATES = Cardinal;

const
  HORZTHUMBStateFiller0  = 0;
  HTS_NORMAL             = 1;
  HTS_HOT                = 2;
  HTS_PUSHED             = 3;
  HTS_DISABLED           = 4;

type
  VERTSCROLLSTATES = Cardinal;

const
  VERTSCROLLStateFiller0  = 0;
  VSS_NORMAL              = 1;
  VSS_HOT                 = 2;
  VSS_PUSHED              = 3;
  VSS_DISABLED            = 4;

type
  VERTTHUMBSTATES = Cardinal;

const
  VERTTHUMBStateFiller0  = 0;
  VTS_NORMAL             = 1;
  VTS_HOT                = 2;
  VTS_PUSHED             = 3;
  VTS_DISABLED           = 4;

type
  SYSBUTTONSTATES = Cardinal;

const
  SYSBUTTONStateFiller0  = 0;
  SBS_NORMAL             = 1;
  SBS_HOT                = 2;
  SBS_PUSHED             = 3;
  SBS_DISABLED           = 4;

type
  MINBUTTONSTATES = Cardinal;

const
  MINBUTTONStateFiller0  = 0;
  MINBS_NORMAL           = 1;
  MINBS_HOT              = 2;
  MINBS_PUSHED           = 3;
  MINBS_DISABLED         = 4;
  MINBS_INACTIVE         = 5;

type
  MAXBUTTONSTATES = Cardinal;

const
  MAXBUTTONStateFiller0  = 0;
  MAXBS_NORMAL           = 1;
  MAXBS_HOT              = 2;
  MAXBS_PUSHED           = 3;
  MAXBS_DISABLED         = 4;
  MAXBS_INACTIVE         = 5;

type
  RESTOREBUTTONSTATES = Cardinal;

const
  RESTOREBUTTONStateFiller0  = 0;
  RBS_NORMAL                 = 1;
  RBS_HOT                    = 2;
  RBS_PUSHED                 = 3;
  RBS_DISABLED               = 4;
  RBS_INACTIVE               = 5;

type
  HELPBUTTONSTATES = Cardinal;

const
  HELPBUTTONStateFiller0  = 0;
  HBS_NORMAL              = 1;
  HBS_HOT                 = 2;
  HBS_PUSHED              = 3;
  HBS_DISABLED            = 4;
  HBS_INACTIVE            = 5;

type
  CLOSEBUTTONSTATES = Cardinal;

const
  CLOSEBUTTONStateFiller0  = 0;
  CBS_NORMAL               = 1;
  CBS_HOT                  = 2;
  CBS_PUSHED               = 3;
  CBS_DISABLED             = 4;
  CBS_INACTIVE             = 5;

//----------------------------------------------------------------------------------------------------------------------
//   "Button" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  BUTTONPARTS = Cardinal;

const
  BUTTONPartFiller0  = 0;
  BP_PUSHBUTTON      = 1;
  BP_RADIOBUTTON     = 2;
  BP_CHECKBOX        = 3;
  BP_GROUPBOX        = 4;
  BP_USERBUTTON      = 5;

type
  PUSHBUTTONSTATES = Cardinal;

const
  PUSHBUTTONStateFiller0  = 0;
  PBS_NORMAL              = 1;
  PBS_HOT                 = 2;
  PBS_PRESSED             = 3;
  PBS_DISABLED            = 4;
  PBS_DEFAULTED           = 5;

type
  RADIOBUTTONSTATES = Cardinal;

const
  RADIOBUTTONStateFiller0  = 0;
  RBS_UNCHECKEDNORMAL      = 1;
  RBS_UNCHECKEDHOT         = 2;
  RBS_UNCHECKEDPRESSED     = 3;
  RBS_UNCHECKEDDISABLED    = 4;
  RBS_CHECKEDNORMAL        = 5;
  RBS_CHECKEDHOT           = 6;
  RBS_CHECKEDPRESSED       = 7;
  RBS_CHECKEDDISABLED      = 8;

type
  CHECKBOXSTATES = Cardinal;

const
  CHECKBOXStateFiller0   = 0;
  CBS_UNCHECKEDNORMAL    = 1;
  CBS_UNCHECKEDHOT       = 2;
  CBS_UNCHECKEDPRESSED   = 3;
  CBS_UNCHECKEDDISABLED  = 4;
  CBS_CHECKEDNORMAL      = 5;
  CBS_CHECKEDHOT         = 6;
  CBS_CHECKEDPRESSED     = 7;
  CBS_CHECKEDDISABLED    = 8;
  CBS_MIXEDNORMAL        = 9;
  CBS_MIXEDHOT           = 10;
  CBS_MIXEDPRESSED       = 11;
  CBS_MIXEDDISABLED      = 12;

type
  GROUPBOXSTATES = Cardinal;

const
  GROUPBOXStateFiller0  = 0;
  GBS_NORMAL            = 1;
  GBS_DISABLED          = 2;

//----------------------------------------------------------------------------------------------------------------------
//   "Rebar" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  REBARPARTS = Cardinal;

const
  REBARPartFiller0  = 0;
  RP_GRIPPER        = 1;
  RP_GRIPPERVERT    = 2;
  RP_BAND           = 3;
  RP_CHEVRON        = 4;
  RP_CHEVRONVERT    = 5;

type
  CHEVRONSTATES = Cardinal;

const
  CHEVRONStateFiller0  = 0;
  CHEVS_NORMAL         = 1;
  CHEVS_HOT            = 2;
  CHEVS_PRESSED        = 3;

//----------------------------------------------------------------------------------------------------------------------
//   "Toolbar" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  TOOLBARPARTS = Cardinal;

const
  TOOLBARPartFiller0      = 0;
  TP_BUTTON               = 1;
  TP_DROPDOWNBUTTON       = 2;
  TP_SPLITBUTTON          = 3;
  TP_SPLITBUTTONDROPDOWN  = 4;
  TP_SEPARATOR            = 5;
  TP_SEPARATORVERT        = 6;

type
  TOOLBARSTATES = Cardinal;

const
  TOOLBARStateFiller0  = 0;
  TS_NORMAL            = 1;
  TS_HOT               = 2;
  TS_PRESSED           = 3;
  TS_DISABLED          = 4;
  TS_CHECKED           = 5;
  TS_HOTCHECKED        = 6;

//----------------------------------------------------------------------------------------------------------------------
//   "Status" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  STATUSPARTS = Cardinal;

const
  STATUSPartFiller0  = 0;
  SP_PANE            = 1;
  SP_GRIPPERPANE     = 2;
  SP_GRIPPER         = 3;

//----------------------------------------------------------------------------------------------------------------------
//   "Menu" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  MENUPARTS = Cardinal;

const
  MENUPartFiller0     = 0;
  MP_MENUITEM         = 1;
  MP_MENUDROPDOWN     = 2;
  MP_MENUBARITEM      = 3;
  MP_MENUBARDROPDOWN  = 4;
  MP_CHEVRON          = 5;
  MP_SEPARATOR        = 6;

type
  MENUSTATES = Cardinal;

const
  MENUStateFiller0  = 0;
  MS_NORMAL         = 1;
  MS_SELECTED       = 2;
  MS_DEMOTED        = 3;

//----------------------------------------------------------------------------------------------------------------------
//   "ListView" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  LISTVIEWPARTS = Cardinal;

const
  LISTVIEWPartFiller0   = 0;
  LVP_LISTITEM          = 1;
  LVP_LISTGROUP         = 2;
  LVP_LISTDETAIL        = 3;
  LVP_LISTSORTEDDETAIL  = 4;
  LVP_EMPTYTEXT         = 5;

type
  LISTITEMSTATES = Cardinal;

const
  LISTITEMStateFiller0  = 0;
  LIS_NORMAL            = 1;
  LIS_HOT               = 2;
  LIS_SELECTED          = 3;
  LIS_DISABLED          = 4;
  LIS_SELECTEDNOTFOCUS  = 5;

//----------------------------------------------------------------------------------------------------------------------
//   "Header" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  HEADERPARTS = Cardinal;

const
  HEADERPartFiller0   = 0;
  HP_HEADERITEM       = 1;
  HP_HEADERITEMLEFT   = 2;
  HP_HEADERITEMRIGHT  = 3;
  HP_HEADERSORTARROW  = 4;

type
  HEADERITEMSTATES = Cardinal;

const
  HEADERITEMStateFiller0  = 0;
  HIS_NORMAL              = 1;
  HIS_HOT                 = 2;
  HIS_PRESSED             = 3;

type
  HEADERITEMLEFTSTATES = Cardinal;

const
  HEADERITEMLEFTStateFiller0  = 0;
  HILS_NORMAL                 = 1;
  HILS_HOT                    = 2;
  HILS_PRESSED                = 3;

type
  HEADERITEMRIGHTSTATES = Cardinal;

const
  HEADERITEMRIGHTStateFiller0  = 0;
  HIRS_NORMAL                  = 1;
  HIRS_HOT                     = 2;
  HIRS_PRESSED                 = 3;

type
  HEADERSORTARROWSTATES = Cardinal;

const
  HEADERSORTARROWStateFiller0  = 0;
  HSAS_SORTEDUP                = 1;
  HSAS_SORTEDDOWN              = 2;

//----------------------------------------------------------------------------------------------------------------------
//   "Progress" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  PROGRESSPARTS = Cardinal;

const
  PROGRESSPartFiller0  = 0;
  PP_BAR               = 1;
  PP_BARVERT           = 2;
  PP_CHUNK             = 3;
  PP_CHUNKVERT         = 4;

//----------------------------------------------------------------------------------------------------------------------
//   "Tab" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  TABPARTS = Cardinal;

const
  TABPartFiller0            = 0;
  TABP_TABITEM              = 1;
  TABP_TABITEMLEFTEDGE      = 2;
  TABP_TABITEMRIGHTEDGE     = 3;
  TABP_TABITEMBOTHEDGE      = 4;
  TABP_TOPTABITEM           = 5;
  TABP_TOPTABITEMLEFTEDGE   = 6;
  TABP_TOPTABITEMRIGHTEDGE  = 7;
  TABP_TOPTABITEMBOTHEDGE   = 8;
  TABP_PANE                 = 9;
  TABP_BODY                 = 10;

type
  TABITEMSTATES = Cardinal;

const
  TABITEMStateFiller0  = 0;
  TIS_NORMAL           = 1;
  TIS_HOT              = 2;
  TIS_SELECTED         = 3;
  TIS_DISABLED         = 4;
  TIS_FOCUSED          = 5;

type
  TABITEMLEFTEDGESTATES = Cardinal;

const
  TABITEMLEFTEDGEStateFiller0  = 0;
  TILES_NORMAL                 = 1;
  TILES_HOT                    = 2;
  TILES_SELECTED               = 3;
  TILES_DISABLED               = 4;
  TILES_FOCUSED                = 5;

type
  TABITEMRIGHTEDGESTATES = Cardinal;

const
  TABITEMRIGHTEDGEStateFiller0  = 0;
  TIRES_NORMAL                  = 1;
  TIRES_HOT                     = 2;
  TIRES_SELECTED                = 3;
  TIRES_DISABLED                = 4;
  TIRES_FOCUSED                 = 5;

type
  TABITEMBOTHEDGESSTATES = Cardinal;

const
  TABITEMBOTHEDGESStateFiller0  = 0;
  TIBES_NORMAL                  = 1;
  TIBES_HOT                     = 2;
  TIBES_SELECTED                = 3;
  TIBES_DISABLED                = 4;
  TIBES_FOCUSED                 = 5;

type
  TOPTABITEMSTATES = Cardinal;

const
  TOPTABITEMStateFiller0  = 0;
  TTIS_NORMAL             = 1;
  TTIS_HOT                = 2;
  TTIS_SELECTED           = 3;
  TTIS_DISABLED           = 4;
  TTIS_FOCUSED            = 5;

type
  TOPTABITEMLEFTEDGESTATES = Cardinal;

const
  TOPTABITEMLEFTEDGEStateFiller0  = 0;
  TTILES_NORMAL                   = 1;
  TTILES_HOT                      = 2;
  TTILES_SELECTED                 = 3;
  TTILES_DISABLED                 = 4;
  TTILES_FOCUSED                  = 5;

type
  TOPTABITEMRIGHTEDGESTATES = Cardinal;

const
  TOPTABITEMRIGHTEDGEStateFiller0  = 0;
  TTIRES_NORMAL                    = 1;
  TTIRES_HOT                       = 2;
  TTIRES_SELECTED                  = 3;
  TTIRES_DISABLED                  = 4;
  TTIRES_FOCUSED                   = 5;

type
  TOPTABITEMBOTHEDGESSTATES = Cardinal;

const
  TOPTABITEMBOTHEDGESStateFiller0  = 0;
  TTIBES_NORMAL                    = 1;
  TTIBES_HOT                       = 2;
  TTIBES_SELECTED                  = 3;
  TTIBES_DISABLED                  = 4;
  TTIBES_FOCUSED                   = 5;

//----------------------------------------------------------------------------------------------------------------------
//   "Trackbar" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  TRACKBARPARTS = Cardinal;

const
  TRACKBARPartFiller0  = 0;
  TKP_TRACK            = 1;
  TKP_TRACKVERT        = 2;
  TKP_THUMB            = 3;
  TKP_THUMBBOTTOM      = 4;
  TKP_THUMBTOP         = 5;
  TKP_THUMBVERT        = 6;
  TKP_THUMBLEFT        = 7;
  TKP_THUMBRIGHT       = 8;
  TKP_TICS             = 9;
  TKP_TICSVERT         = 10;

type
  TRACKBARSTATES = Cardinal;

const
  TRACKBARStateFiller0  = 0;
  TKS_NORMAL            = 1;

type
  TRACKSTATES = Cardinal;

const
  TRACKStateFiller0  = 0;
  TRS_NORMAL         = 1;

type
  TRACKVERTSTATES = Cardinal;

const
  TRACKVERTStateFiller0  = 0;
  TRVS_NORMAL            = 1;

type
  THUMBSTATES = Cardinal;

const
  THUMBStateFiller0  = 0;
  TUS_NORMAL         = 1;
  TUS_HOT            = 2;
  TUS_PRESSED        = 3;
  TUS_FOCUSED        = 4;
  TUS_DISABLED       = 5;

type
  THUMBBOTTOMSTATES = Cardinal;

const
  THUMBBOTTOMStateFiller0  = 0;
  TUBS_NORMAL              = 1;
  TUBS_HOT                 = 2;
  TUBS_PRESSED             = 3;
  TUBS_FOCUSED             = 4;
  TUBS_DISABLED            = 5;

type
  THUMBTOPSTATES = Cardinal;

const
  THUMBTOPStateFiller0  = 0;
  TUTS_NORMAL           = 1;
  TUTS_HOT              = 2;
  TUTS_PRESSED          = 3;
  TUTS_FOCUSED          = 4;
  TUTS_DISABLED         = 5;

type
  THUMBVERTSTATES = Cardinal;

const
  THUMBVERTStateFiller0  = 0;
  TUVS_NORMAL            = 1;
  TUVS_HOT               = 2;
  TUVS_PRESSED           = 3;
  TUVS_FOCUSED           = 4;
  TUVS_DISABLED          = 5;

type
  THUMBLEFTSTATES = Cardinal;

const
  THUMBLEFTStateFiller0  = 0;
  TUVLS_NORMAL           = 1;
  TUVLS_HOT              = 2;
  TUVLS_PRESSED          = 3;
  TUVLS_FOCUSED          = 4;
  TUVLS_DISABLED         = 5;

type
  THUMBRIGHTSTATES = Cardinal;

const
  THUMBRIGHTStateFiller0  = 0;
  TUVRS_NORMAL            = 1;
  TUVRS_HOT               = 2;
  TUVRS_PRESSED           = 3;
  TUVRS_FOCUSED           = 4;
  TUVRS_DISABLED          = 5;

type
  TICSSTATES = Cardinal;

const
  TICSStateFiller0  = 0;
  TSS_NORMAL        = 1;

type
  TICSVERTSTATES = Cardinal;

const
  TICSVERTStateFiller0  = 0;
  TSVS_NORMAL           = 1;

//----------------------------------------------------------------------------------------------------------------------
//   "Tooltips" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  TOOLTIPPARTS = Cardinal;

const
  TOOLTIPPartFiller0  = 0;
  TTP_STANDARD        = 1;
  TTP_STANDARDTITLE   = 2;
  TTP_BALLOON         = 3;
  TTP_BALLOONTITLE    = 4;
  TTP_CLOSE           = 5;

type
  CLOSESTATES = Cardinal;

const
  CLOSEStateFiller0  = 0;
  TTCS_NORMAL        = 1;
  TTCS_HOT           = 2;
  TTCS_PRESSED       = 3;

type
  STANDARDSTATES = Cardinal;

const
  STANDARDStateFiller0  = 0;
  TTSS_NORMAL           = 1;
  TTSS_LINK             = 2;

type
  BALLOONSTATES = Cardinal;

const
  BALLOONStateFiller0  = 0;
  TTBS_NORMAL          = 1;
  TTBS_LINK            = 2;

//----------------------------------------------------------------------------------------------------------------------
//   "TreeView" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  TREEVIEWPARTS = Cardinal;

const
  TREEVIEWPartFiller0  = 0;
  TVP_TREEITEM         = 1;
  TVP_GLYPH            = 2;
  TVP_BRANCH           = 3;

type
  TREEITEMSTATES = Cardinal;

const
  TREEITEMStateFiller0    = 0;
  TREIS_NORMAL            = 1;
  TREIS_HOT               = 2;
  TREIS_SELECTED          = 3;
  TREIS_DISABLED          = 4;
  TREIS_SELECTEDNOTFOCUS  = 5;

type
  GLYPHSTATES = Cardinal;

const
  GLYPHStateFiller0  = 0;
  GLPS_CLOSED        = 1;
  GLPS_OPENED        = 2;

//----------------------------------------------------------------------------------------------------------------------
//   "Spin" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  SPINPARTS = Cardinal;

const
  SPINPartFiller0  = 0;
  SPNP_UP          = 1;
  SPNP_DOWN        = 2;
  SPNP_UPHORZ      = 3;
  SPNP_DOWNHORZ    = 4;

type
  UPSTATES = Cardinal;

const
  UPStateFiller0  = 0;
  UPS_NORMAL      = 1;
  UPS_HOT         = 2;
  UPS_PRESSED     = 3;
  UPS_DISABLED    = 4;

type
  DOWNSTATES = Cardinal;

const
  DOWNStateFiller0  = 0;
  DNS_NORMAL        = 1;
  DNS_HOT           = 2;
  DNS_PRESSED       = 3;
  DNS_DISABLED      = 4;

type
  UPHORZSTATES = Cardinal;

const
  UPHORZStateFiller0  = 0;
  UPHZS_NORMAL        = 1;
  UPHZS_HOT           = 2;
  UPHZS_PRESSED       = 3;
  UPHZS_DISABLED      = 4;

type
  DOWNHORZSTATES = Cardinal;

const
  DOWNHORZStateFiller0  = 0;
  DNHZS_NORMAL          = 1;
  DNHZS_HOT             = 2;
  DNHZS_PRESSED         = 3;
  DNHZS_DISABLED        = 4;

//----------------------------------------------------------------------------------------------------------------------
//   "Page" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  PAGEPARTS = Cardinal;

const
  PAGEPartFiller0  = 0;
  PGRP_UP          = 1;
  PGRP_DOWN        = 2;
  PGRP_UPHORZ      = 3;
  PGRP_DOWNHORZ    = 4;

//--- Pager uses same states as Spin ---

//----------------------------------------------------------------------------------------------------------------------
//   "Scrollbar" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  SCROLLBARPARTS = Cardinal;

const
  SCROLLBARPartFiller0  = 0;
  SBP_ARROWBTN          = 1;
  SBP_THUMBBTNHORZ      = 2;
  SBP_THUMBBTNVERT      = 3;
  SBP_LOWERTRACKHORZ    = 4;
  SBP_UPPERTRACKHORZ    = 5;
  SBP_LOWERTRACKVERT    = 6;
  SBP_UPPERTRACKVERT    = 7;
  SBP_GRIPPERHORZ       = 8;
  SBP_GRIPPERVERT       = 9;
  SBP_SIZEBOX           = 10;

type
  ARROWBTNSTATES = Cardinal;

const
  ARROWBTNStateFiller0  = 0;
  ABS_UPNORMAL          = 1;
  ABS_UPHOT             = 2;
  ABS_UPPRESSED         = 3;
  ABS_UPDISABLED        = 4;
  ABS_DOWNNORMAL        = 5;
  ABS_DOWNHOT           = 6;
  ABS_DOWNPRESSED       = 7;
  ABS_DOWNDISABLED      = 8;
  ABS_LEFTNORMAL        = 9;
  ABS_LEFTHOT           = 10;
  ABS_LEFTPRESSED       = 11;
  ABS_LEFTDISABLED      = 12;
  ABS_RIGHTNORMAL       = 13;
  ABS_RIGHTHOT          = 14;
  ABS_RIGHTPRESSED      = 15;
  ABS_RIGHTDISABLED     = 16;

type
  SCROLLBARSTATES = Cardinal;

const
  SCROLLBARStateFiller0  = 0;
  SCRBS_NORMAL           = 1;
  SCRBS_HOT              = 2;
  SCRBS_PRESSED          = 3;
  SCRBS_DISABLED         = 4;

type
  SIZEBOXSTATES = Cardinal;

const
  SIZEBOXStateFiller0  = 0;
  SZB_RIGHTALIGN       = 1;
  SZB_LEFTALIGN        = 2;

//----------------------------------------------------------------------------------------------------------------------
//   "Edit" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  EDITPARTS = Cardinal;

const
  EDITPartFiller0  = 0;
  EP_EDITTEXT      = 1;
  EP_CARET         = 2;

type
  EDITTEXTSTATES = Cardinal;

const
  EDITTEXTStateFiller0  = 0;
  ETS_NORMAL            = 1;
  ETS_HOT               = 2;
  ETS_SELECTED          = 3;
  ETS_DISABLED          = 4;
  ETS_FOCUSED           = 5;
  ETS_READONLY          = 6;
  ETS_ASSIST            = 7;

//----------------------------------------------------------------------------------------------------------------------
//   "ComboBox" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  COMBOBOXPARTS = Cardinal;

const
  COMBOBOXPartFiller0  = 0;
  CP_DROPDOWNBUTTON    = 1;

type
  COMBOBOXSTATES = Cardinal;

const
  COMBOBOXStateFiller0  = 0;
  CBXS_NORMAL           = 1;
  CBXS_HOT              = 2;
  CBXS_PRESSED          = 3;
  CBXS_DISABLED         = 4;

//----------------------------------------------------------------------------------------------------------------------
//   "Taskbar Clock" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  CLOCKPARTS = Cardinal;

const
  CLOCKPartFiller0  = 0;
  CLP_TIME          = 1;

type
  CLOCKSTATES = Cardinal;

const
  CLOCKStateFiller0  = 0;
  CLS_NORMAL         = 1;

//----------------------------------------------------------------------------------------------------------------------
//   "Tray Notify" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  TRAYNOTIFYPARTS = Cardinal;

const
  TRAYNOTIFYPartFiller0  = 0;
  TNP_BACKGROUND         = 1;
  TNP_ANIMBACKGROUND     = 2;

//----------------------------------------------------------------------------------------------------------------------
//   "TaskBar" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  TASKBARPARTS = Cardinal;

const
  TASKBARPartFiller0    = 0;
  TBP_BACKGROUNDBOTTOM  = 1;
  TBP_BACKGROUNDRIGHT   = 2;
  TBP_BACKGROUNDTOP     = 3;
  TBP_BACKGROUNDLEFT    = 4;
  TBP_SIZINGBARBOTTOM   = 5;
  TBP_SIZINGBARRIGHT    = 6;
  TBP_SIZINGBARTOP      = 7;
  TBP_SIZINGBARLEFT     = 8;

//----------------------------------------------------------------------------------------------------------------------
//   "TaskBand" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  TASKBANDPARTS = Cardinal;

const
  TASKBANDPartFiller0       = 0;
  TDP_GROUPCOUNT            = 1;
  TDP_FLASHBUTTON           = 2;
  TDP_FLASHBUTTONGROUPMENU  = 3;

//----------------------------------------------------------------------------------------------------------------------
//   "StartPanel" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  STARTPANELPARTS = Cardinal;

const
  STARTPANELPartFiller0    = 0;
  SPP_USERPANE             = 1;
  SPP_MOREPROGRAMS         = 2;
  SPP_MOREPROGRAMSARROW    = 3;
  SPP_PROGLIST             = 4;
  SPP_PROGLISTSEPARATOR    = 5;
  SPP_PLACESLIST           = 6;
  SPP_PLACESLISTSEPARATOR  = 7;
  SPP_LOGOFF               = 8;
  SPP_LOGOFFBUTTONS        = 9;
  SPP_USERPICTURE          = 10;
  SPP_PREVIEW              = 11;

type
  MOREPROGRAMSARROWSTATES = Cardinal;

const
  MOREPROGRAMSARROWStateFiller0  = 0;
  SPS_NORMAL                     = 1;
  SPS_HOT                        = 2;
  SPS_PRESSED                    = 3;

type
  LOGOFFBUTTONSSTATES = Cardinal;

const
  LOGOFFBUTTONSStateFiller0  = 0;
  SPLS_NORMAL                = 1;
  SPLS_HOT                   = 2;
  SPLS_PRESSED               = 3;

//----------------------------------------------------------------------------------------------------------------------
//   "ExplorerBar" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  EXPLORERBARPARTS = Cardinal;

const
  EXPLORERBARPartFiller0      = 0;
  EBP_HEADERBACKGROUND        = 1;
  EBP_HEADERCLOSE             = 2;
  EBP_HEADERPIN               = 3;
  EBP_IEBARMENU               = 4;
  EBP_NORMALGROUPBACKGROUND   = 5;
  EBP_NORMALGROUPCOLLAPSE     = 6;
  EBP_NORMALGROUPEXPAND       = 7;
  EBP_NORMALGROUPHEAD         = 8;
  EBP_SPECIALGROUPBACKGROUND  = 9;
  EBP_SPECIALGROUPCOLLAPSE    = 10;
  EBP_SPECIALGROUPEXPAND      = 11;
  EBP_SPECIALGROUPHEAD        = 12;

type
  HEADERCLOSESTATES = Cardinal;

const
  HEADERCLOSEStateFiller0  = 0;
  EBHC_NORMAL              = 1;
  EBHC_HOT                 = 2;
  EBHC_PRESSED             = 3;

type
  HEADERPINSTATES = Cardinal;

const
  HEADERPINStateFiller0  = 0;
  EBHP_NORMAL            = 1;
  EBHP_HOT               = 2;
  EBHP_PRESSED           = 3;
  EBHP_SELECTEDNORMAL    = 4;
  EBHP_SELECTEDHOT       = 5;
  EBHP_SELECTEDPRESSED   = 6;

type
  IEBARMENUSTATES = Cardinal;

const
  IEBARMENUStateFiller0  = 0;
  EBM_NORMAL             = 1;
  EBM_HOT                = 2;
  EBM_PRESSED            = 3;

type
  NORMALGROUPCOLLAPSESTATES = Cardinal;

const
  NORMALGROUPCOLLAPSEStateFiller0  = 0;
  EBNGC_NORMAL                     = 1;
  EBNGC_HOT                        = 2;
  EBNGC_PRESSED                    = 3;

type
  NORMALGROUPEXPANDSTATES = Cardinal;

const
  NORMALGROUPEXPANDStateFiller0  = 0;
  EBNGE_NORMAL                   = 1;
  EBNGE_HOT                      = 2;
  EBNGE_PRESSED                  = 3;

type
  SPECIALGROUPCOLLAPSESTATES = Cardinal;

const
  SPECIALGROUPCOLLAPSEStateFiller0  = 0;
  EBSGC_NORMAL                      = 1;
  EBSGC_HOT                         = 2;
  EBSGC_PRESSED                     = 3;

type
  SPECIALGROUPEXPANDSTATES = Cardinal;

const
  SPECIALGROUPEXPANDStateFiller0  = 0;
  EBSGE_NORMAL                    = 1;
  EBSGE_HOT                       = 2;
  EBSGE_PRESSED                   = 3;

//----------------------------------------------------------------------------------------------------------------------
//   "TaskBand" Parts & States
//----------------------------------------------------------------------------------------------------------------------

type
  MENUBANDPARTS = Cardinal;

const
  MENUBANDPartFiller0  = 0;
  MDP_NEWAPPBUTTON     = 1;
  MDP_SEPERATOR        = 2;

type
  MENUBANDSTATES = Cardinal;

const
  MENUBANDStateFiller0  = 0;
  MDS_NORMAL            = 1;
  MDS_HOT               = 2;
  MDS_PRESSED           = 3;
  MDS_DISABLED          = 4;
  MDS_CHECKED           = 5;
  MDS_HOTCHECKED        = 6;

//----------------------------------------------------------------------------------------------------------------------














  
type
  HIMAGELIST = THANDLE; // TODO TEMPORARY
  HTHEME = THANDLE;     // handle to a section of theme data for class
  {$EXTERNALSYM HTHEME}

//----------------------------------------------------------------------------------------------------------------------
// NOTE: PartId's and StateId's used in the theme API are defined in the
//       hdr file <tmschema.h> using the TM_PART and TM_STATE macros.  For
//       example, "TM_PART(BP, PUSHBUTTON)" defines the PartId "BP_PUSHBUTTON".
//----------------------------------------------------------------------------------------------------------------------
//  OpenThemeData()     - Open the theme data for the specified HWND and
//                        semi-colon separated list of class names.
//
//                        OpenThemeData() will try each class name, one at
//                        a time, and use the first matching theme info
//                        found.  If a match is found, a theme handle
//                        to the data is returned.  If no match is found,
//                        a "NULL" handle is returned.
//
//                        When the window is destroyed or a WM_THEMECHANGED
//                        msg is received, "CloseThemeData()" should be
//                        called to close the theme handle.
//
//  hwnd                - window handle of the control/window to be themed
//
//  pszClassList        - class name (or list of names) to match to theme data
//                        section.  if the list contains more than one name,
//                        the names are tested one at a time for a match.
//                        If a match is found, OpenThemeData() returns a
//                        theme handle associated with the matching class.
//                        This param is a list (instead of just a single
//                        class name) to provide the class an opportunity
//                        to get the "best" match between the class and
//                        the current theme.  For example, a button might
//                        pass L"OkButton, Button" if its ID=ID_OK.  If
//                        the current theme has an entry for OkButton,
//                        that will be used.  Otherwise, we fall back on
//                        the normal Button entry.
//----------------------------------------------------------------------------------------------------------------------

var
  OpenThemeData: function(hwnd: HWND; pszClassList: LPCWSTR): HTHEME; stdcall;
{$EXTERNALSYM OpenThemeData}

//----------------------------------------------------------------------------------------------------------------------
//  CloseTHemeData()    - closes the theme data handle.  This should be done
//                        when the window being themed is destroyed or
//                        whenever a WM_THEMECHANGED msg is received
//                        (followed by an attempt to create a new Theme data
//                        handle).
//
//  hTheme              - open theme data handle (returned from prior call
//                        to OpenThemeData() API).
//----------------------------------------------------------------------------------------------------------------------

var
  CloseThemeData: function(hTheme: HTHEME): HRESULT; stdcall;
{$EXTERNALSYM CloseThemeData}

//----------------------------------------------------------------------------------------------------------------------
//    functions for basic drawing support
//----------------------------------------------------------------------------------------------------------------------
// The following methods are the theme-aware drawing services.
// Controls/Windows are defined in drawable "parts" by their author: a
// parent part and 0 or more child parts.  Each of the parts can be
// described in "states" (ex: disabled, hot, pressed).
//----------------------------------------------------------------------------------------------------------------------
// For the list of all themed classes and the definition of all
// parts and states, see the file "tmschmea.h".
//----------------------------------------------------------------------------------------------------------------------
// Each of the below methods takes a "iPartId" param to specify the
// part and a "iStateId" to specify the state of the part.
// "iStateId=0" refers to the root part.  "iPartId" = "0" refers to
// the root class.
//----------------------------------------------------------------------------------------------------------------------
// Note: draw operations are always scaled to fit (and not to exceed)
// the specified "Rect".
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
//  DrawThemeBackground()
//                      - draws the theme-specified border and fill for
//                        the "iPartId" and "iStateId".  This could be
//                        based on a bitmap file, a border and fill, or
//                        other image description.
//
//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number (of the part) to draw
//  pRect               - defines the size/location of the part
//  pClipRect           - optional clipping rect (don't draw outside it)
//----------------------------------------------------------------------------------------------------------------------

var
  DrawThemeBackground: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; const pRect: TRect;
    pClipRect: PRECT): HRESULT; stdcall;
{$EXTERNALSYM DrawThemeBackground}

//----------------------------------------------------------------------------------------------------------------------
//----- DrawThemeText() flags ----

const
  DTT_GRAYED = $1;         // draw a grayed-out string
  {$EXTERNALSYM DTT_GRAYED}

//----------------------------------------------------------------------------------------------------------------------
//  DrawThemeText()     - draws the text using the theme-specified
//                        color and font for the "iPartId" and
//                        "iStateId".
//
//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number (of the part) to draw
//  pszText             - actual text to draw
//  dwCharCount         - number of chars to draw (-1 for all)
//  dwTextFlags         - same as DrawText() "uFormat" param
//  dwTextFlags2        - additional drawing options
//  pRect               - defines the size/location of the part
//----------------------------------------------------------------------------------------------------------------------

var
  DrawThemeText: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; pszText: LPCWSTR; iCharCount: Integer;
    dwTextFlags, dwTextFlags2: DWORD; const pRect: TRect): HRESULT; stdcall;
{$EXTERNALSYM DrawThemeText}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeBackgroundContentRect()
//                      - gets the size of the content for the theme-defined
//                        background.  This is usually the area inside
//                        the borders or Margins.
//
//      hTheme          - theme data handle
//      hdc             - (optional) device content to be used for drawing
//      iPartId         - part number to draw
//      iStateId        - state number (of the part) to draw
//      pBoundingRect   - the outer RECT of the part being drawn
//      pContentRect    - RECT to receive the content area
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeBackgroundContentRect: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
    const pBoundingRect: TRect; pContentRect: PRECT): HRESULT; stdcall;
{$EXTERNALSYM GetThemeBackgroundContentRect}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeBackgroundExtent() - calculates the size/location of the theme-
//                               specified background based on the
//                               "pContentRect".
//
//      hTheme          - theme data handle
//      hdc             - (optional) device content to be used for drawing
//      iPartId         - part number to draw
//      iStateId        - state number (of the part) to draw
//      pContentRect    - RECT that defines the content area
//      pBoundingRect   - RECT to receive the overall size/location of part
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeBackgroundExtent: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; const pContentRect: TRect;
    var pExtentRect: TRect): HRESULT; stdcall;
{$EXTERNALSYM GetThemeBackgroundExtent}

//----------------------------------------------------------------------------------------------------------------------

type
  THEMESIZE = (
    TS_MIN,             // minimum size
    TS_TRUE,            // size without stretching
    TS_DRAW             // size that theme mgr will use to draw part
  );
  {$EXTERNALSYM THEMESIZE}
  //TThemeSize = THEMESIZE;

//----------------------------------------------------------------------------------------------------------------------
//  GetThemePartSize() - returns the specified size of the theme part
//
//  hTheme              - theme data handle
//  hdc                 - HDC to select font into & measure against
//  iPartId             - part number to retrieve size for
//  iStateId            - state number (of the part)
//  prc                 - (optional) rect for part drawing destination
//  eSize               - the type of size to be retreived
//  psz                 - receives the specified size of the part
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemePartSize: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; prc: PRECT; eSize: THEMESIZE;
    var psz: TSize): HRESULT; stdcall;
{$EXTERNALSYM GetThemePartSize}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeTextExtent() - calculates the size/location of the specified
//                         text when rendered in the Theme Font.
//
//  hTheme              - theme data handle
//  hdc                 - HDC to select font & measure into
//  iPartId             - part number to draw
//  iStateId            - state number (of the part)
//  pszText             - the text to be measured
//  dwCharCount         - number of chars to draw (-1 for all)
//  dwTextFlags         - same as DrawText() "uFormat" param
//  pszBoundingRect     - optional: to control layout of text
//  pszExtentRect       - receives the RECT for text size/location
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeTextExtent: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; pszText: LPCWSTR;
    iCharCount: Integer; dwTextFlags: DWORD; pBoundingRect: PRECT; var pExtentRect: TRect): HRESULT; stdcall;
{$EXTERNALSYM GetThemeTextExtent}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeTextMetrics()
//                      - returns info about the theme-specified font
//                        for the part/state passed in.
//
//  hTheme              - theme data handle
//  hdc                 - optional: HDC for screen context
//  iPartId             - part number to draw
//  iStateId            - state number (of the part)
//  ptm                 - receives the font info
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeTextMetrics: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
    var ptm: TEXTMETRIC): HRESULT; stdcall;
{$EXTERNALSYM GetThemeTextMetrics}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeBackgroundRegion()
//                      - computes the region for a regular or partially
//                        transparent theme-specified background that is
//                        bound by the specified "pRect".
//                        If the rectangle is empty, sets the HRGN to NULL
//                        and return S_FALSE.
//
//  hTheme              - theme data handle
//  hdc                 - optional HDC to draw into (DPI scaling)
//  iPartId             - part number to draw
//  iStateId            - state number (of the part)
//  pRect               - the RECT used to draw the part
//  pRegion             - receives handle to calculated region
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeBackgroundRegion: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; const pRect: TRect;
    var pRegion: HRGN): HRESULT; stdcall;
{$EXTERNALSYM GetThemeBackgroundRegion}

//----------------------------------------------------------------------------------------------------------------------
//----- HitTestThemeBackground, HitTestThemeBackgroundRegion flags ----

//  Theme background segment hit test flag (default). possible return values are:
//  HTCLIENT: hit test succeeded in the middle background segment
//  HTTOP, HTLEFT, HTTOPLEFT, etc:  // hit test succeeded in the the respective theme background segment.

const
  HTTB_BACKGROUNDSEG         = $0000;
  {$EXTERNALSYM HTTB_BACKGROUNDSEG}

//  Fixed border hit test option.  possible return values are:
//  HTCLIENT: hit test succeeded in the middle background segment
//  HTBORDER: hit test succeeded in any other background segment

  HTTB_FIXEDBORDER           = $0002;  // Return code may be either HTCLIENT or HTBORDER.
  {$EXTERNALSYM HTTB_FIXEDBORDER}

//  Caption hit test option.  Possible return values are:
//  HTCAPTION: hit test succeeded in the top, top left, or top right background segments
//  HTNOWHERE or another return code, depending on absence or presence of accompanying flags, resp.

  HTTB_CAPTION               = $0004;
  {$EXTERNALSYM HTTB_CAPTION}

//  Resizing border hit test flags.  Possible return values are:
//  HTCLIENT: hit test succeeded in middle background segment
//  HTTOP, HTTOPLEFT, HTLEFT, HTRIGHT, etc:    hit test succeeded in the respective system resizing zone
//  HTBORDER: hit test failed in middle segment and resizing zones, but succeeded in a background border segment

  HTTB_RESIZINGBORDER_LEFT   = $0010; // Hit test left resizing border,
  {$EXTERNALSYM HTTB_RESIZINGBORDER_LEFT}
  HTTB_RESIZINGBORDER_TOP    = $0020; // Hit test top resizing border
  {$EXTERNALSYM HTTB_RESIZINGBORDER_TOP}
  HTTB_RESIZINGBORDER_RIGHT  = $0040; // Hit test right resizing border
  {$EXTERNALSYM HTTB_RESIZINGBORDER_RIGHT}
  HTTB_RESIZINGBORDER_BOTTOM = $0080; // Hit test bottom resizing border
  {$EXTERNALSYM HTTB_RESIZINGBORDER_BOTTOM}

  HTTB_RESIZINGBORDER        = (HTTB_RESIZINGBORDER_LEFT or HTTB_RESIZINGBORDER_TOP or
                                HTTB_RESIZINGBORDER_RIGHT or HTTB_RESIZINGBORDER_BOTTOM);
  {$EXTERNALSYM HTTB_RESIZINGBORDER}

// Resizing border is specified as a template, not just window edges.
// This option is mutually exclusive with HTTB_SYSTEMSIZINGWIDTH; HTTB_SIZINGTEMPLATE takes precedence

  HTTB_SIZINGTEMPLATE        = $0100;
  {$EXTERNALSYM HTTB_SIZINGTEMPLATE}

// Use system resizing border width rather than theme content margins.
// This option is mutually exclusive with HTTB_SIZINGTEMPLATE, which takes precedence.

  HTTB_SYSTEMSIZINGMARGINS   = $0200;
  {$EXTERNALSYM HTTB_SYSTEMSIZINGMARGINS}

//----------------------------------------------------------------------------------------------------------------------
//  HitTestThemeBackground()
//                      - returns a HitTestCode (a subset of the values
//                        returned by WM_NCHITTEST) for the point "ptTest"
//                        within the theme-specified background
//                        (bound by pRect).  "pRect" and "ptTest" should
//                        both be in the same coordinate system
//                        (client, screen, etc).
//
//      hTheme          - theme data handle
//      hdc             - HDC to draw into
//      iPartId         - part number to test against
//      iStateId        - state number (of the part)
//      pRect           - the RECT used to draw the part
//      hrgn            - optional region to use; must be in same coordinates as
//                      -    pRect and pTest.
//      ptTest          - the hit point to be tested
//      dwOptions       - HTTB_xxx constants
//      pwHitTestCode   - receives the returned hit test code - one of:
//
//                        HTNOWHERE, HTLEFT, HTTOPLEFT, HTBOTTOMLEFT,
//                        HTRIGHT, HTTOPRIGHT, HTBOTTOMRIGHT,
//                        HTTOP, HTBOTTOM, HTCLIENT
//----------------------------------------------------------------------------------------------------------------------

var
  HitTestThemeBackground: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; dwOptions: DWORD;
    const pRect: TRect; hrgn: HRGN; ptTest: TPoint; var pwHitTestCode: WORD): HRESULT; stdcall;
{$EXTERNALSYM HitTestThemeBackground}

//----------------------------------------------------------------------------------------------------------------------
//  DrawThemeEdge()     - Similar to the DrawEdge() API, but uses part colors
//                        and is high-DPI aware
//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number of part
//  pDestRect           - the RECT used to draw the line(s)
//  uEdge               - Same as DrawEdge() API
//  uFlags              - Same as DrawEdge() API
//  pContentRect        - Receives the interior rect if (uFlags & BF_ADJUST)
//----------------------------------------------------------------------------------------------------------------------

var
  DrawThemeEdge: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; const pDestRect: TRect; uEdge,
    uFlags: UINT; pContentRect: PRECT): HRESULT; stdcall;
{$EXTERNALSYM DrawThemeEdge}

//----------------------------------------------------------------------------------------------------------------------
//  DrawThemeIcon()     - draws an image within an imagelist based on
//                        a (possible) theme-defined effect.
//
//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number of part
//  pRect               - the RECT to draw the image within
//  himl                - handle to IMAGELIST
//  iImageIndex         - index into IMAGELIST (which icon to draw)
//----------------------------------------------------------------------------------------------------------------------

var
  DrawThemeIcon: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer; const pRect: TRect; himl: HIMAGELIST;
    iImageIndex: Integer): HRESULT; stdcall;
{$EXTERNALSYM DrawThemeIcon}

//----------------------------------------------------------------------------------------------------------------------
//  IsThemePartDefined() - returns TRUE if the theme has defined parameters
//                         for the specified "iPartId" and "iStateId".
//
//  hTheme              - theme data handle
//  iPartId             - part number to find definition for
//  iStateId            - state number of part
//----------------------------------------------------------------------------------------------------------------------

var
  IsThemePartDefined: function(hTheme: HTHEME; iPartId, iStateId: Integer): BOOL; stdcall;
{$EXTERNALSYM IsThemePartDefined}

//----------------------------------------------------------------------------------------------------------------------
//  IsThemeBackgroundPartiallyTransparent()
//                      - returns TRUE if the theme specified background for
//                        the part/state has transparent pieces or
//                        alpha-blended pieces.
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//----------------------------------------------------------------------------------------------------------------------

var
  IsThemeBackgroundPartiallyTransparent: function(hTheme: HTHEME; iPartId, iStateId: Integer): BOOL; stdcall;
{$EXTERNALSYM IsThemeBackgroundPartiallyTransparent}

//----------------------------------------------------------------------------------------------------------------------
//    lower-level theme information services
//----------------------------------------------------------------------------------------------------------------------
// The following methods are getter routines for each of the Theme Data types.
// Controls/Windows are defined in drawable "parts" by their author: a
// parent part and 0 or more child parts.  Each of the parts can be
// described in "states" (ex: disabled, hot, pressed).
//----------------------------------------------------------------------------------------------------------------------
// Each of the below methods takes a "iPartId" param to specify the
// part and a "iStateId" to specify the state of the part.
// "iStateId=0" refers to the root part.  "iPartId" = "0" refers to
// the root class.
//----------------------------------------------------------------------------------------------------------------------
// Each method also take a "iPropId" param because multiple instances of
// the same primitive type can be defined in the theme schema.
//----------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------
//  GetThemeColor()     - Get the value for the specified COLOR property
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pColor              - receives the value of the property
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeColor: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; var pColor: COLORREF): HRESULT; stdcall;
{$EXTERNALSYM GetThemeColor}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeMetric()    - Get the value for the specified metric/size
//                        property
//
//  hTheme              - theme data handle
//  hdc                 - (optional) hdc to be drawn into (DPI scaling)
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  piVal               - receives the value of the property
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeMetric: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId, iPropId: Integer;
    var piVal: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetThemeMetric}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeString()    - Get the value for the specified string property
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pszBuff             - receives the string property value
//  cchMaxBuffChars     - max. number of chars allowed in pszBuff
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeString: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; pszBuff: LPWSTR;
    cchMaxBuffChars: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetThemeString}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeBool()      - Get the value for the specified BOOL property
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pfVal               - receives the value of the property
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeBool: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; var pfVal: BOOL): HRESULT; stdcall;
{$EXTERNALSYM GetThemeBool}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeInt()       - Get the value for the specified int property
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  piVal               - receives the value of the property
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeInt: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; var piVal: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetThemeInt}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeEnumValue() - Get the value for the specified ENUM property
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  piVal               - receives the value of the enum (cast to int*)
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeEnumValue: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; var piVal: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetThemeEnumValue}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemePosition()  - Get the value for the specified position
//                        property
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pPoint              - receives the value of the position property
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemePosition: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;var pPoint: TPoint): HRESULT; stdcall;
{$EXTERNALSYM GetThemePosition}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeFont()      - Get the value for the specified font property
//
//  hTheme              - theme data handle
//  hdc                 - (optional) hdc to be drawn to (DPI scaling)
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pFont               - receives the value of the LOGFONT property
//                        (scaled for the current logical screen dpi)
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeFont: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId, iPropId: Integer;
    var pFont: LOGFONT): HRESULT; stdcall;
{$EXTERNALSYM GetThemeFont}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeRect()      - Get the value for the specified RECT property
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pRect               - receives the value of the RECT property
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeRect: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; var pRect: TRect): HRESULT; stdcall;
{$EXTERNALSYM GetThemeRect}

//----------------------------------------------------------------------------------------------------------------------

type
  _MARGINS = record
    cxLeftWidth: Integer;      // width of left border that retains its size
    cxRightWidth: Integer;     // width of right border that retains its size
    cyTopHeight: Integer;      // height of top border that retains its size
    cyBottomHeight: Integer;   // height of bottom border that retains its size
  end;
  {$EXTERNALSYM _MARGINS}
  MARGINS = _MARGINS;
  {$EXTERNALSYM MARGINS}
  PMARGINS = ^MARGINS;
  {$EXTERNALSYM PMARGINS}
  //TMargins = MARGINS;

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeMargins()   - Get the value for the specified MARGINS property
//
//      hTheme          - theme data handle
//      hdc             - (optional) hdc to be used for drawing
//      iPartId         - part number
//      iStateId        - state number of part
//      iPropId         - the property number to get the value for
//      prc             - RECT for area to be drawn into
//      pMargins        - receives the value of the MARGINS property
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeMargins: function(hTheme: HTHEME; hdc: HDC; iPartId, iStateId, iPropId: Integer; prc: PRECT;
    var pMargins: MARGINS): HRESULT; stdcall;
{$EXTERNALSYM GetThemeMargins}

//----------------------------------------------------------------------------------------------------------------------

const
  MAX_INTLIST_COUNT = 10;
  {$EXTERNALSYM MAX_INTLIST_COUNT}

type
  _INTLIST = record
    iValueCount: Integer;      // number of values in iValues
    iValues: array [0..MAX_INTLIST_COUNT - 1] of Integer;
  end;
  {$EXTERNALSYM _INTLIST}
  INTLIST = _INTLIST;
  {$EXTERNALSYM INTLIST}
  PINTLIST = ^INTLIST;
  {$EXTERNALSYM PINTLIST}
  //TIntList = INTLIST;

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeIntList()   - Get the value for the specified INTLIST struct
//
//      hTheme          - theme data handle
//      iPartId         - part number
//      iStateId        - state number of part
//      iPropId         - the property number to get the value for
//      pIntList        - receives the value of the INTLIST property
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeIntList: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; var pIntList: INTLIST): HRESULT; stdcall;
{$EXTERNALSYM GetThemeIntList}

//----------------------------------------------------------------------------------------------------------------------

type
  PROPERTYORIGIN = (
    PO_STATE,           // property was found in the state section
    PO_PART,            // property was found in the part section
    PO_CLASS,           // property was found in the class section
    PO_GLOBAL,          // property was found in [globals] section
    PO_NOTFOUND);       // property was not found
  {$EXTERNALSYM PROPERTYORIGIN}
  //TPropertyOrigin = PROPERTYORIGIN;

//----------------------------------------------------------------------------------------------------------------------
//  GetThemePropertyOrigin()
//                      - searches for the specified theme property
//                        and sets "pOrigin" to indicate where it was
//                        found (or not found)
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to search for
//  pOrigin             - receives the value of the property origin
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemePropertyOrigin: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    var pOrigin: PROPERTYORIGIN): HRESULT; stdcall;
{$EXTERNALSYM GetThemePropertyOrigin}

//----------------------------------------------------------------------------------------------------------------------
//  SetWindowTheme()
//                      - redirects an existing Window to use a different
//                        section of the current theme information than its
//                        class normally asks for.
//
//  hwnd                - the handle of the window (cannot be NULL)
//
//  pszSubAppName       - app (group) name to use in place of the calling
//                        app's name.  If NULL, the actual calling app
//                        name will be used.
//
//  pszSubIdList        - semicolon separated list of class Id names to
//                        use in place of actual list passed by the
//                        window's class.  if NULL, the id list from the
//                        calling class is used.
//----------------------------------------------------------------------------------------------------------------------
// The Theme Manager will remember the "pszSubAppName" and the
// "pszSubIdList" associations thru the lifetime of the window (even
// if themes are subsequently changed).  The window is sent a
// "WM_THEMECHANGED" msg at the end of this call, so that the new
// theme can be found and applied.
//----------------------------------------------------------------------------------------------------------------------
// When "pszSubAppName" or "pszSubIdList" are NULL, the Theme Manager
// removes the previously remember association.  To turn off theme-ing for
// the specified window, you can pass an empty string (L"") so it
// won't match any section entries.
//----------------------------------------------------------------------------------------------------------------------

var
  SetWindowTheme: function(hwnd: HWND; pszSubAppName: LPCWSTR; pszSubIdList: LPCWSTR): HRESULT; stdcall;
{$EXTERNALSYM SetWindowTheme}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeFilename()  - Get the value for the specified FILENAME property.
//
//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to search for
//  pszThemeFileName    - output buffer to receive the filename
//  cchMaxBuffChars     - the size of the return buffer, in chars
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeFilename: function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer; pszThemeFileName: LPWSTR;
    cchMaxBuffChars: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetThemeFilename}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeSysColor()  - Get the value of the specified System color.
//
//  hTheme              - the theme data handle.  if non-NULL, will return
//                        color from [SysMetrics] section of theme.
//                        if NULL, will return the global system color.
//
//  iColorId            - the system color index defined in winuser.h
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeSysColor: function(hTheme: HTHEME; iColorId: Integer): COLORREF; stdcall;
{$EXTERNALSYM GetThemeSysColor}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeSysColorBrush()
//                      - Get the brush for the specified System color.
//
//  hTheme              - the theme data handle.  if non-NULL, will return
//                        brush matching color from [SysMetrics] section of
//                        theme.  if NULL, will return the brush matching
//                        global system color.
//
//  iColorId            - the system color index defined in winuser.h
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeSysColorBrush: function(hTheme: HTHEME; iColorId: Integer): HBRUSH; stdcall;
{$EXTERNALSYM GetThemeSysColorBrush}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeSysBool()   - Get the boolean value of specified System metric.
//
//  hTheme              - the theme data handle.  if non-NULL, will return
//                        BOOL from [SysMetrics] section of theme.
//                        if NULL, will return the specified system boolean.
//
//  iBoolId             - the TMT_XXX BOOL number (first BOOL
//                        is TMT_FLATMENUS)
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeSysBool: function(hTheme: HTHEME; iBoolId: Integer): BOOL; stdcall;
{$EXTERNALSYM GetThemeSysBool}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeSysSize()   - Get the value of the specified System size metric.
//                        (scaled for the current logical screen dpi)
//
//  hTheme              - the theme data handle.  if non-NULL, will return
//                        size from [SysMetrics] section of theme.
//                        if NULL, will return the global system metric.
//
//  iSizeId             - the following values are supported when
//                        hTheme is non-NULL:
//
//                          SM_CXBORDER   (border width)
//                          SM_CXVSCROLL  (scrollbar width)
//                          SM_CYHSCROLL  (scrollbar height)
//                          SM_CXSIZE     (caption width)
//                          SM_CYSIZE     (caption height)
//                          SM_CXSMSIZE   (small caption width)
//                          SM_CYSMSIZE   (small caption height)
//                          SM_CXMENUSIZE (menubar width)
//                          SM_CYMENUSIZE (menubar height)
//
//                        when hTheme is NULL, iSizeId is passed directly
//                        to the GetSystemMetrics() function
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeSysSize: function(hTheme: HTHEME; iSizeId: Integer): Integer; stdcall;
{$EXTERNALSYM GetThemeSysSize}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeSysFont()   - Get the LOGFONT for the specified System font.
//
//  hTheme              - the theme data handle.  if non-NULL, will return
//                        font from [SysMetrics] section of theme.
//                        if NULL, will return the specified system font.
//
//  iFontId             - the TMT_XXX font number (first font
//                        is TMT_CAPTIONFONT)
//
//  plf                 - ptr to LOGFONT to receive the font value.
//                        (scaled for the current logical screen dpi)
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeSysFont: function(hTheme: HTHEME; iFontId: Integer; var plf: LOGFONT): HRESULT; stdcall;
{$EXTERNALSYM GetThemeSysFont}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeSysString() - Get the value of specified System string metric.
//
//  hTheme              - the theme data handle (required)
//
//  iStringId           - must be one of the following values:
//
//                          TMT_CSSNAME
//                          TMT_XMLNAME
//
//  pszStringBuff       - the buffer to receive the string value
//
//  cchMaxStringChars   - max. number of chars that pszStringBuff can hold
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeSysString: function(hTheme: HTHEME; iStringId: Integer; pszStringBuff: LPWSTR;
    cchMaxStringChars: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetThemeSysString}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeSysInt() - Get the value of specified System int.
//
//  hTheme              - the theme data handle (required)
//
//  iIntId              - must be one of the following values:
//
//                          TMT_DPIX
//                          TMT_DPIY
//                          TMT_MINCOLORDEPTH
//
//  piValue             - ptr to int to receive value
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeSysInt: function(hTheme: HTHEME; iIntId: Integer; var piValue: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetThemeSysInt}

//----------------------------------------------------------------------------------------------------------------------
//  IsThemeActive()     - can be used to test if a system theme is active
//                        for the current user session.
//
//                        use the API "IsAppThemed()" to test if a theme is
//                        active for the calling process.
//----------------------------------------------------------------------------------------------------------------------

var
  IsThemeActive: function: BOOL; stdcall;
{$EXTERNALSYM IsThemeActive}

//----------------------------------------------------------------------------------------------------------------------
//  IsAppThemed()       - returns TRUE if a theme is active and available to
//                        the current process
//----------------------------------------------------------------------------------------------------------------------

var
  IsAppThemed: function: BOOL; stdcall;
{$EXTERNALSYM IsAppThemed}

//----------------------------------------------------------------------------------------------------------------------
//  GetWindowTheme()    - if window is themed, returns its most recent
//                        HTHEME from OpenThemeData() - otherwise, returns
//                        NULL.
//
//      hwnd            - the window to get the HTHEME of
//----------------------------------------------------------------------------------------------------------------------

var
  GetWindowTheme: function(hwnd: HWND): HTHEME; stdcall;
{$EXTERNALSYM GetWindowTheme}

//----------------------------------------------------------------------------------------------------------------------
//  EnableThemeDialogTexture()
//
//  - Enables/disables dialog background theme.  This method can be used to
//    tailor dialog compatibility with child windows and controls that
//    may or may not coordinate the rendering of their client area backgrounds
//    with that of their parent dialog in a manner that supports seamless
//    background texturing.
//
//      hdlg         - the window handle of the target dialog
//      dwFlags      - ETDT_ENABLE to enable the theme-defined dialog background texturing,
//                     ETDT_DISABLE to disable background texturing,
//                     ETDT_ENABLETAB to enable the theme-defined background
//                          texturing using the Tab texture
//----------------------------------------------------------------------------------------------------------------------

const
  ETDT_DISABLE       = $00000001;
  {$EXTERNALSYM ETDT_DISABLE}
  ETDT_ENABLE        = $00000002;
  {$EXTERNALSYM ETDT_ENABLE}
  ETDT_USETABTEXTURE = $00000004;
  {$EXTERNALSYM ETDT_USETABTEXTURE}
  ETDT_ENABLETAB     = (ETDT_ENABLE or ETDT_USETABTEXTURE);
  {$EXTERNALSYM ETDT_ENABLETAB}

var
  EnableThemeDialogTexture: function(hwnd: HWND; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM EnableThemeDialogTexture}

//----------------------------------------------------------------------------------------------------------------------
//  IsThemeDialogTextureEnabled()
//
//  - Reports whether the dialog supports background texturing.
//
//      hdlg         - the window handle of the target dialog
//----------------------------------------------------------------------------------------------------------------------

var
  IsThemeDialogTextureEnabled: function(hwnd: HWND): BOOL; stdcall;
{$EXTERNALSYM IsThemeDialogTextureEnabled}

//----------------------------------------------------------------------------------------------------------------------
//---- flags to control theming within an app ----

const
  STAP_ALLOW_NONCLIENT   = (1 shl 0);
  {$EXTERNALSYM STAP_ALLOW_NONCLIENT}
  STAP_ALLOW_CONTROLS    = (1 shl 1);
  {$EXTERNALSYM STAP_ALLOW_CONTROLS}
  STAP_ALLOW_WEBCONTENT  = (1 shl 2);
  {$EXTERNALSYM STAP_ALLOW_WEBCONTENT}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeAppProperties()
//                      - returns the app property flags that control theming
//----------------------------------------------------------------------------------------------------------------------

var
  GetThemeAppProperties: function: DWORD; stdcall;
{$EXTERNALSYM GetThemeAppProperties}

//----------------------------------------------------------------------------------------------------------------------
//  SetThemeAppProperties()
//                      - sets the flags that control theming within the app
//
//      dwFlags         - the flag values to be set
//----------------------------------------------------------------------------------------------------------------------

var
  SetThemeAppProperties: procedure(dwFlags: DWORD); stdcall;
{$EXTERNALSYM SetThemeAppProperties}

//----------------------------------------------------------------------------------------------------------------------
//  GetCurrentThemeName()
//                      - Get the name of the current theme in-use.
//                        Optionally, return the ColorScheme name and the
//                        Size name of the theme.
//
//  pszThemeFileName    - receives the theme path & filename
//  cchMaxNameChars     - max chars allowed in pszNameBuff
//
//  pszColorBuff        - (optional) receives the canonical color scheme name
//                        (not the display name)
//  cchMaxColorChars    - max chars allowed in pszColorBuff
//
//  pszSizeBuff         - (optional) receives the canonical size name
//                        (not the display name)
//  cchMaxSizeChars     - max chars allowed in pszSizeBuff
//----------------------------------------------------------------------------------------------------------------------

var
  GetCurrentThemeName: function(pszThemeFileName: LPWSTR; cchMaxNameChars: Integer; pszColorBuff: LPWSTR;
    cchMaxColorChars: Integer; pszSizeBuff: LPWSTR; cchMaxSizeChars: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetCurrentThemeName}

//----------------------------------------------------------------------------------------------------------------------
//  GetThemeDocumentationProperty()
//                      - Get the value for the specified property name from
//                        the [documentation] section of the themes.ini file
//                        for the specified theme.  If the property has been
//                        localized in the theme files string table, the
//                        localized version of the property value is returned.
//
//  pszThemeFileName    - filename of the theme file to query
//  pszPropertyName     - name of the string property to retreive a value for
//  pszValueBuff        - receives the property string value
//  cchMaxValChars      - max chars allowed in pszValueBuff
//----------------------------------------------------------------------------------------------------------------------

const
  SZ_THDOCPROP_DISPLAYNAME               = WideString('DisplayName');
  {$EXTERNALSYM SZ_THDOCPROP_DISPLAYNAME}
  SZ_THDOCPROP_CANONICALNAME             = WideString('ThemeName');
  {$EXTERNALSYM SZ_THDOCPROP_CANONICALNAME}
  SZ_THDOCPROP_TOOLTIP                   = WideString('ToolTip');
  {$EXTERNALSYM SZ_THDOCPROP_TOOLTIP}
  SZ_THDOCPROP_AUTHOR                    = WideString('author');
  {$EXTERNALSYM SZ_THDOCPROP_AUTHOR}

var
  GetThemeDocumentationProperty: function(pszThemeName, pszPropertyName: LPCWSTR; pszValueBuff: LPWSTR;
    cchMaxValChars: Integer): HRESULT; stdcall;
{$EXTERNALSYM GetThemeDocumentationProperty}

//----------------------------------------------------------------------------------------------------------------------
//  Theme API Error Handling
//
//      All functions in the Theme API not returning an HRESULT (THEMEAPI_)
//      use the WIN32 function "SetLastError()" to record any call failures.
//
//      To retreive the error code of the last failure on the
//      current thread for these type of API's, use the WIN32 function
//      "GetLastError()".
//
//      All Theme API error codes (HRESULT's and GetLastError() values)
//      should be normal win32 errors which can be formatted into
//      strings using the Win32 API FormatMessage().
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
// DrawThemeParentBackground()
//                      - used by partially-transparent or alpha-blended
//                        child controls to draw the part of their parent
//                        that they appear in front of.
//
//  hwnd                - handle of the child control
//  hdc                 - hdc of the child control
//  prc                 - (optional) rect that defines the area to be
//                        drawn (CHILD coordinates)
//----------------------------------------------------------------------------------------------------------------------

var
  DrawThemeParentBackground: function(hwnd: HWND; hdc: HDC; prc: PRECT): HRESULT; stdcall;
{$EXTERNALSYM DrawThemeParentBackground}

//----------------------------------------------------------------------------------------------------------------------
//  EnableTheming()     - enables or disables themeing for the current user
//                        in the current and future sessions.
//
//  fEnable             - if FALSE, disable theming & turn themes off.
//                      - if TRUE, enable themeing and, if user previously
//                        had a theme active, make it active now.
//----------------------------------------------------------------------------------------------------------------------

var
  EnableTheming: function(fEnable: BOOL): HRESULT; stdcall;
{$EXTERNALSYM EnableTheming}

implementation

uses
  SyncObjs;

//----------------------------------------------------------------------------------------------------------------------

const
  themelib = 'uxtheme.dll';

var
  ThemeLibrary: THandle;
  ReferenceCount: Integer;  // We have to keep track of several load/unload calls.
  Lock: TCriticalSection;

procedure FreeThemeLibrary;

begin
  Lock.Enter;
  try
    if ReferenceCount > 0 then
      Dec(ReferenceCount);

    if (ThemeLibrary <> 0) and (ReferenceCount = 0) then
    begin
      FreeLibrary(ThemeLibrary);
      ThemeLibrary := 0;

      OpenThemeData := nil;
      CloseThemeData := nil;
      DrawThemeBackground := nil;
      DrawThemeText := nil;
      GetThemeBackgroundContentRect := nil;
      GetThemeBackgroundExtent := nil;
      GetThemePartSize := nil;
      GetThemeTextExtent := nil;
      GetThemeTextMetrics := nil;
      GetThemeBackgroundRegion := nil;
      HitTestThemeBackground := nil;
      DrawThemeEdge := nil;
      DrawThemeIcon := nil;
      IsThemePartDefined := nil;
      IsThemeBackgroundPartiallyTransparent := nil;
      GetThemeColor := nil;
      GetThemeMetric := nil;
      GetThemeString := nil;
      GetThemeBool := nil;
      GetThemeInt := nil;
      GetThemeEnumValue := nil;
      GetThemePosition := nil;
      GetThemeFont := nil;
      GetThemeRect := nil;
      GetThemeMargins := nil;
      GetThemeIntList := nil;
      GetThemePropertyOrigin := nil;
      SetWindowTheme := nil;
      GetThemeFilename := nil;
      GetThemeSysColor := nil;
      GetThemeSysColorBrush := nil;
      GetThemeSysBool := nil;
      GetThemeSysSize := nil;
      GetThemeSysFont := nil;
      GetThemeSysString := nil;
      GetThemeSysInt := nil;
      IsThemeActive := nil;
      IsAppThemed := nil;
      GetWindowTheme := nil;
      EnableThemeDialogTexture := nil;
      IsThemeDialogTextureEnabled := nil;
      GetThemeAppProperties := nil;
      SetThemeAppProperties := nil;
      GetCurrentThemeName := nil;
      GetThemeDocumentationProperty := nil;
      DrawThemeParentBackground := nil;
      EnableTheming := nil;
    end;
  finally
    Lock.Leave;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function InitThemeLibrary: Boolean;

begin
  Lock.Enter;
  try
    Inc(ReferenceCount);

    if ThemeLibrary = 0 then
    begin
      ThemeLibrary := LoadLibrary(themelib);
      if ThemeLibrary > 0 then
      begin
        OpenThemeData := GetProcAddress(ThemeLibrary, 'OpenThemeData');
        CloseThemeData := GetProcAddress(ThemeLibrary, 'CloseThemeData');
        DrawThemeBackground := GetProcAddress(ThemeLibrary, 'DrawThemeBackground');
        DrawThemeText := GetProcAddress(ThemeLibrary, 'DrawThemeText');
        GetThemeBackgroundContentRect := GetProcAddress(ThemeLibrary, 'GetThemeBackgroundContentRect');
        GetThemeBackgroundExtent := GetProcAddress(ThemeLibrary, 'GetThemeBackgroundExtent');
        GetThemePartSize := GetProcAddress(ThemeLibrary, 'GetThemePartSize');
        GetThemeTextExtent := GetProcAddress(ThemeLibrary, 'GetThemeTextExtent');
        GetThemeTextMetrics := GetProcAddress(ThemeLibrary, 'GetThemeTextMetrics');
        GetThemeBackgroundRegion := GetProcAddress(ThemeLibrary, 'GetThemeBackgroundRegion');
        HitTestThemeBackground := GetProcAddress(ThemeLibrary, 'HitTestThemeBackground');
        DrawThemeEdge := GetProcAddress(ThemeLibrary, 'DrawThemeEdge');
        DrawThemeIcon := GetProcAddress(ThemeLibrary, 'DrawThemeIcon');
        IsThemePartDefined := GetProcAddress(ThemeLibrary, 'IsThemePartDefined');
        IsThemeBackgroundPartiallyTransparent := GetProcAddress(ThemeLibrary, 'IsThemeBackgroundPartiallyTransparent');
        GetThemeColor := GetProcAddress(ThemeLibrary, 'GetThemeColor');
        GetThemeMetric := GetProcAddress(ThemeLibrary, 'GetThemeMetric');
        GetThemeString := GetProcAddress(ThemeLibrary, 'GetThemeString');
        GetThemeBool := GetProcAddress(ThemeLibrary, 'GetThemeBool');
        GetThemeInt := GetProcAddress(ThemeLibrary, 'GetThemeInt');
        GetThemeEnumValue := GetProcAddress(ThemeLibrary, 'GetThemeEnumValue');
        GetThemePosition := GetProcAddress(ThemeLibrary, 'GetThemePosition');
        GetThemeFont := GetProcAddress(ThemeLibrary, 'GetThemeFont');
        GetThemeRect := GetProcAddress(ThemeLibrary, 'GetThemeRect');
        GetThemeMargins := GetProcAddress(ThemeLibrary, 'GetThemeMargins');
        GetThemeIntList := GetProcAddress(ThemeLibrary, 'GetThemeIntList');
        GetThemePropertyOrigin := GetProcAddress(ThemeLibrary, 'GetThemePropertyOrigin');
        SetWindowTheme := GetProcAddress(ThemeLibrary, 'SetWindowTheme');
        GetThemeFilename := GetProcAddress(ThemeLibrary, 'GetThemeFilename');
        GetThemeSysColor := GetProcAddress(ThemeLibrary, 'GetThemeSysColor');
        GetThemeSysColorBrush := GetProcAddress(ThemeLibrary, 'GetThemeSysColorBrush');
        GetThemeSysBool := GetProcAddress(ThemeLibrary, 'GetThemeSysBool');
        GetThemeSysSize := GetProcAddress(ThemeLibrary, 'GetThemeSysSize');
        GetThemeSysFont := GetProcAddress(ThemeLibrary, 'GetThemeSysFont');
        GetThemeSysString := GetProcAddress(ThemeLibrary, 'GetThemeSysString');
        GetThemeSysInt := GetProcAddress(ThemeLibrary, 'GetThemeSysInt');
        IsThemeActive := GetProcAddress(ThemeLibrary, 'IsThemeActive');
        IsAppThemed := GetProcAddress(ThemeLibrary, 'IsAppThemed');
        GetWindowTheme := GetProcAddress(ThemeLibrary, 'GetWindowTheme');
        EnableThemeDialogTexture := GetProcAddress(ThemeLibrary, 'EnableThemeDialogTexture');
        IsThemeDialogTextureEnabled := GetProcAddress(ThemeLibrary, 'IsThemeDialogTextureEnabled');
        GetThemeAppProperties := GetProcAddress(ThemeLibrary, 'GetThemeAppProperties');
        SetThemeAppProperties := GetProcAddress(ThemeLibrary, 'SetThemeAppProperties');
        GetCurrentThemeName := GetProcAddress(ThemeLibrary, 'GetCurrentThemeName');
        GetThemeDocumentationProperty := GetProcAddress(ThemeLibrary, 'GetThemeDocumentationProperty');
        DrawThemeParentBackground := GetProcAddress(ThemeLibrary, 'DrawThemeParentBackground');
        EnableTheming := GetProcAddress(ThemeLibrary, 'EnableTheming');
      end;
    end;
    Result := ThemeLibrary > 0;
  finally
    Lock.Leave;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function UseThemes: Boolean;

begin
  Result := ThemeLibrary > 0;
  if Result then
    Result := IsAppThemed and IsThemeActive;
end;

//----------------------------------------------------------------------------------------------------------------------

initialization
  Lock := TCriticalSection.Create;
finalization
  while ReferenceCount > 0 do
    FreeThemeLibrary;
  Lock.Free;


end.

