{******************************************************************************}
{                                                                              }
{                           GmConst.pas v2.61 Pro                              }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmConst;

interface

uses Windows, Messages;

const
  SUITE_VERSION     = 2.61;



  MM_PER_INCH       = 25.4;
  DEFAULT_MARGIN    = 2000;  // (2 cm)
  DEFAULT_DRAW_DPI  = 600;
  SCREEN_PPI        = 96;
  DEFAULT_ZOOM      = 20;
  DEFAULT_GUTTER    = 30;
  DEFAULT_HEIGHT    = 304;
  DEFAULT_WIDTH     = 234;
  DEFAULT_FONT      = 'Arial';
  DEFAULT_FONT_SIZE = 12;
  DEFAULT_ZOOM_INC  = 10;
  DEFAULT_TITLE     = '<document>';
  DEFAULT_PAGE_CAPTION = 'Page #';
  DEFAULT_MAX_ZOOM  = 200;
  DEFAULT_MIN_ZOOM  = 10;

  // paper constants...
  C_A3      = 'A3';
  C_A4      = 'A4';
  C_A5      = 'A5';
  C_A6      = 'A6';
  C_B5      = 'B5';
  C_C5      = 'C5';
  C_LEGAL   = 'Legal';
  C_LETTER  = 'Letter';
  C_CUSTOM  = 'Custom';

  GM_PREVIEW_UPDATED      = WM_USER + 6000;
  GM_CHANGE_DRAWING_PPI   = WM_USER + 6001;
  GM_DEFAULT_DRAWING_PPI  = WM_USER + 6002;
  GM_NUMPAGES_CHANGED     = WM_USER + 6003;
  GM_MULTIPAGE_CHANGED    = WM_USER + 6004;
  GM_ORIENTATION_CHANGED  = WM_USER + 6005;
  GM_PRINTER_CHANGED      = WM_USER + 6006;
  GM_PAGE_CHANGED         = WM_USER + 6006;

  GM_PREVIEW_BEGINUPDATE  = WM_USER + 6007;
  GM_PREVIEW_ENDUPDATE    = WM_USER + 6008;
  GM_PREVIEW_CLEARED      = WM_USER + 6009;

  C_OBJECT    = 10;
  C_OBJECT_ID = 10.01;
  C_OBJECT_PAGE           = 10.02;
  C_OBJECT_X1             = 10.03;
  C_OBJECT_Y1             = 10.04;
  C_OBJECT_X2             = 10.05;
  C_OBJECT_Y2             = 10.06;
  C_OBJECT_X3             = 10.07;
  C_OBJECT_Y3             = 10.08;
  C_OBJECT_X4             = 10.09;
  C_OBJECT_Y4             = 10.10;
  C_OBJECT_DATA1          = 10.50;
  C_OBJECT_LINE_TYPE      = 11.00;
  
  C_NEW_PAGE              = 1;
  C_PAGE_SETUP            = 2;
  C_PAGE_WIDTH            = 2.01;
  C_PAGE_HEIGHT           = 2.02;
  C_PAPER_SIZE            = 2.03;
  C_ORIENTATION           = 2.04;

  C_MARGIN                = 3;
  C_MARGIN_LEFT           = 3.01;
  C_MARGIN_TOP            = 3.02;
  C_MARGIN_RIGHT          = 3.03;
  C_MARGIN_BOTTOM         = 3.04;
  C_MARGIN_VISIBLE        = 3.05;
  C_PRINT_MARGIN_VISIBLE  = 3.06;
  C_MARGINS_PEN_1         = 3.07;
  C_MARGINS_PEN_2         = 3.08;

  C_SHADOW                = 4;
  C_SHADOW_COLOR          = 4.01;
  C_SHADOW_WIDTH          = 4.02;
  C_SHADOW_VISIBLE        = 4.03;

  C_DOCUMENT              = 5;
  C_DOCUMENT_CREATED      = 5.01;
  C_DOCUMENT_NUMPAGES     = 5.02;

  C_HEADER                = 6;
  C_HEADER_ALIGN          = 6.01;
  C_HEADER_SHOWLINE       = 6.03;
  C_HEADER_VISIBLE        = 6.04;

  C_FOOTER                = 7;
  C_FOOTER_ALIGN          = 7.01;
  C_FOOTER_SHOWLINE       = 7.03;
  C_FOOTER_VISIBLE        = 7.04;

  // object constants...
  GM_TEXT_ID        = 1;
  GM_LINE_ID        = 2;
  GM_ELLIPSE_ID     = 3;
  GM_RECTANGLE_ID   = 4;
  GM_ROUNDRECT_ID   = 5;
  GM_TEXTBOX_ID     = 6;
  GM_POLYGON_ID     = 7;
  GM_POLYLINE_ID    = 8;
  GM_GRAPHIC_ID     = 9;
  GM_ARC_ID         = 10;
  GM_CHORD_ID       = 11;
  GM_PIE_ID         = 12;
  GM_POLYBEZIER_ID  = 13;

  //GM_BEGIN_PATH     = 16;
  //GM_END_PATH       = 17;
  //GM_CLOSEFIGURE    = 18;

  GM_POLYLINETO_ID  = 19;
  GM_POLYBEZIERTO_ID= 20;
  GM_FILLRECT_ID    = 21;

  //GM_RTF_TEXT       = 22;
  //GM_RTF_TEXTBOX_ID = 23;

  GM_PATH_OBJECT_ID = 24;

  C_EXTENDED        = 1000;
  C_INTEGER         = 1001;
  C_STRING          = 1002;
  C_BRUSH           = 1003;
  C_FONT            = 1004;
  C_PEN             = 1005;


  C_BRUSH_COLOR           = 20.00;
  C_BRUSH_STYLE           = 20.01;
  C_BRUSH_BITMAP          = 20.02;

  C_FONT_NAME             = 30.00;
  C_FONT_SIZE             = 30.01;
  C_FONT_STYLE            = 30.02;
  C_FONT_COLOR            = 30.03;
  C_FONT_PPI              = 30.04;
  C_FONT_ANGLE            = 30.05;

  C_PEN_COLOR             = 40.00;
  C_PEN_STYLE             = 40.01;
  C_PEN_WIDTH             = 40.02;
  C_PEN_MODE              = 40.03;

  C_CAPTION               = 50.00;
  C_CAPTION_LEFT          = 50.01;
  C_CAPTION_CENTER        = 50.02;
  C_CAPTION_RIGHT         = 50.03; 
  C_ALIGNMENT             = 51.00;
  C_VERT_ALIGNMENT        = 51.01;

  C_BITMAP              = 70;
  C_METAFILE              = 71;
  C_METAFILE_AS_BITMAP    = 72;

var
  DRAWING_DPI     : integer = DEFAULT_DRAW_DPI;

implementation

end.
