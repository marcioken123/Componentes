R&A Library 1.51
================

The Set of Native Delphi Components for Borland Delphi.
100% Source Code.

Last revision date Jan, 21, 2000.

PLEASE FOLLOW THE INSTRUCTIONS PROVIDED IN THE INSTALLATION SECTION!

TABLE OF CONTENTS
-----------------
Overview
History
License Agreement
Compatibility
Installation
Demonstration Programs
Source Files
Credits
Copyright Notes


Overview
--------

R&A Library contains a number of components, classes and routines
for Borland Delphi with full source code. This library is compatible
with Borland Delphi 2, 3, 4, 5 and Borland C++ Builder 1, 4.
Read Compatibility section for more information.


This collection includes over 30 native Delphi components and special
packages for run-time form designing.

R&A Library is a freeware product. Feel free to distribute the library as
long as all files are unmodified and kept together.

The authors disclaim all warranties as to this software, whether express
or implied, including without limitation any implied warranties of
merchantability or fitness for a particular purpose. Use under your own
responsibility, but comments (even critique) in English (or in Russian)
are welcome.


1. Components:

TRegAuto allows you to read and write virtually any component published
property to an INI file or the system Registry with virtually no code.
Works with 3rd party and your own custom controls as well. Don't be stuck
with dozens of INI-Aware components, use TRegAuto and let it manage all
that for you. Also allows to save and restore form size, position and
window state.

TRAProgressForm is a "Progress" dialog with customizable caption and message
label. When method Execute called, form will be displayed and OnShow
events occured. You must write all specific code in this event and
periodically update ProgressPosition property.

TRADBTreeView - data-aware TreeView.
TRADBLookupTreeView and TRADBLookupTreeViewCombo are special versions of
TRADBTreeView component.

TRASQLScript allows multiple SQL statements in one query. "Set term" and
"Commit work" statements response.

TRAEditor is "Delphi-IDE"-like editor. Single symbol can be displayed with
it own font color, style, background color. Customizable keystroke mapping
scheme. Undo. Bookmarks. Code completion. Gutter.
None: Column blocks, Redo.

TRAHLEditor - special version of TRAEditor with built-in highlighting
for pascal, cbuilder, sql, html, java, phyton, basic.

TRAHint allows show custom hint at any time and place.

TRAScrollMax work like 3DMax panels. Add few TRAScrollMaxBand
on it and you can expand or collapse bands by click at band
caption button. If height of all bands is greather than TRAScrollMax
height, scrolling feature will on and you can scroll TRAScrollMax
by drag it at any point.

TRACaptionButton jumps to the caption of the form.

TRADBRadioGroupS is a TDBRadioGroup descendant with Beveled property.
If Beveled set to true, it looks like standard TDBRadioGroup.
If Beveled set to false, frame not painted.

TRADBTextS is a TDBText descendant with published Layot property
(In Delphi 3 Borland add this property to TCustomLabel, but forget publish
Layot in it descendants).
Compatibility note: Delphi 3, 4, 5, Builder 3.

TRACombo - button with drop down menu - work like combobox, but
looks differently.

TRADBMove - data-aware component for batch moving databases (few
tables with dependencies). It's automatically fixups links beetween
tables. You must define tables names and references. Also available
field mappings.

TRAhtListBox - listbox, what can display items with several font
styles and colors (but only one font size). Few colors may be used
in one item.

TRAhtComboBox, TRAhtLabel, TRAhtButton - similar to TRAhtListBox.

TRAScrollText - displays scrolling text.

TRADoubleCombo - this is the new generation combobox.
It contains two drop down lists.


2. Simple components (not interesting for advanced programmers):

TRAStatusBar can accept other controls.

TRAColorButton is a TBitBtn descendant, having color and OnPaint event.

TRANoFrameButton is inherited from TSpeedButton with color and
(optional) without border.

TRAScrollBar95 implements win 95 scrollbar feature - this is TScrollBar
with Page property.

TRAScrollBar - vertical scrollbar, looks like 3dMax scrollbar.

TRAWaitPanel - show progress, indicating processing long operation.

TRATreeView and TRAComboBox4Tree components work together and looks like
Tree in Windows Explorer. When user select an item in TRATreeView, this
item is showing in TRAComboBox4Tree.

TRAImage can receive focus and processing keyboard events.


3. RAI2 Components:

RAI2 is a small pascal-like language interpreter.
Very more features.

TRAI2Program - RAI2 runner.
See RAI2 demo in RALib\Demo\RAi2 folder.

TRAI2Fm - Delphi form runner. Allows run Delphi forms
placed in external files without compiling.
See RAI2 demo in RALib\Demo\RAI2 folder. Usefull to
create plug-ins, such as reports.


4. Run-time form designer.
Please read file RALIB\DOC\RAFD.TXT.


5. Design packages for form designer.
Please read file RALIB\DOC\RAFD.TXT.


6. Delphi ide tools:

Zoom - With Zoom you can maximize and restore edit window by pressing
"Alt+Z" key.
Compatibility: Delphi 3, 4, 5, Builder 3, 4

TRAIntegerProperty - Property editor for all integer properties. It
based on RAI2 and use it features. When editor is installed you can
type in Object Inspector expressions for all integer properties, such
as '2+2' and expression will be calculated and replaced with it result.
For example, for Button1.Width property valid expressions are '100+10',
'Width+20', 'Label1.Left + Label1.Width'. If multiple components are
selected, expression evaluates for each of them. For example, if you
select a few components and type for width property string 'Width + 10',
widths of all selected components will be increased to 10 pixels.


7. Units that provide functions and classes to work with databases,
images, strings, files, INI-files.


8. A couple of simple demo applications.
Please read file RALIB\DEMOS\!README.TXT.


9. There are no help files for R&A Library. Sorry.


History
-------

RALib 1.00 (Dec 1998).
  Initial release available on internet.

RALib 1.10 (Feb 1999).
  New components TRAHLEditor, TRAhtListBox, TRAhtComboBox,
  TRAScrollText.
  New interpreter RAI2 and components TRAI2Program, TRAI2Fm.
  Improvements in existing components:
  TRAEditor - new properties: SmartTab, KeepTrailingBlanks,
  CursorBeyondEOF, AutoIndent, BackSpaceUnindents; two-key commands,
  automatically expands tabs when setting Lines property; Some bugs
  fixed.
  TRADBMove - new property: Mappings.

RALib 1.15 (Mar 1999).
  Mainly bug-fix release.
  Fixed: RAI2.pas, RAEditor.pas, RAHLEditor.pas.
  Updated:
    TRAScrollMax - new method AddBand;
  New:
    Color Hints.

RALib 1.20 (Apr 1999)
  Fixed many bugs in RAI2 components and RAEditor component.
  New features and highlighters for RAEditor.
  New:
    RADoubleCombo.
    R&A Form Designer.

RALib 1.21 (Apr 1999)
  Some bugs fixed in language resources.

RALib 1.22 (Jun 1999)
  Fixed many bugs in RAI2 and RAEditor. Some new rai2-functions in
  RAI2_System.

RALib 1.30 (Oct 1999)
  Delphi 5 compatibility.

RALib 1.31 (Oct 1999)
  Fixed one bug in RACtrl package.

RALib 1.40 (Jan 2000)
  Many fixes in RAI2, Delphi 5 R&A Form Designer compatibility.

RALib 1.50 (Jan 2000)
  All packages were split into separate run-time and design-time packages.
  Many fixes in RAI2 (see rai2.pas header) and R&A Form Designer.
  Adding support for Builder 4.

RALib 1.51 (Jan 2000)
  All components arranged at 3 pallete entries: R&A Controls, R&A Additional,
  R&A DBAware.
  - Changes in RAI2:
    - arrays as local and global variables - added by Andrej Olejnik.
    - type casting with integer, string, TObject, etc. keywords.
  - fixed Delphi5-bug in design-time component editor for TRegAuto component.


License Agreement
-----------------

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appears in all copies and
that both the above copyright notice and this permission notice appear
in supporting documentation, and that the name of R&A Library authors
not be used in advertising or publicity pertaining to distribution of
the software without specific, written prior permission. This
software is made available "as is", and R&A LIBRARY AUTHORS DISCLAIM
ALL WARRANTIES, EXPRESS OR IMPLIED, WITH REGARD TO THIS SOFTWARE,
INCLUDING WITHOUT LIMITATION ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE, AND IN NO EVENT SHALL AUTHORS BE
LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY
DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, TORT (INCLUDING NEGLIGENCE) OR
STRICT LIABILITY, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.

You can find full text of R&A Library Software License agreement in the
file LICENSE.TXT.


Compatibility
-------------

This version of R&A Library is writen and full tested with
Borland Delphi 3 Client/Server Edition and
Borland Delphi 5 Enterprise Edition.

R&A Library was some tested on
Borland Delphi 2 Developer Edition,
Borland Delphi 4 Client/Server Edition,
Borland C++ Builder 1.0 Client/Server Edition.
Borland C++ Builder 4 Enterprise Edition.
R&A Library is not tested properly with this products.
Use at your own risk.


Installation
------------

Unzip ralib.zip.

Before installing R&A Library components into Delphi, check out RA.INC
file located in RALIB\LIB subdirectory. This file is included in all R&A
Library units and contains conditional defines that affects compilation.
You can change some of these defines or specify global compiler options
there.

1. Delphi 5:

Uninstall previous installed version of R&A Library from Delphi 5 IDE.
Remove previously compiled R&A packages (if any) RACTRL50.BPL, RADB50.BPL,
RAI2_50.BPL, RAFD50.BPL, RACTL5.BPL, RADB5.BPL, RAI5.BPL, RAIA5.BPL,
RAFD5.BPL from your hard disk.

Run file RALIB\RESOURCE\RUSSIAN\RES.BAT (russian resources) or
RALIB\RESOURCE\ENGLISH\RES.BAT (english resources).

Use "File\Open..." menu item of Delphi IDE to open R&A' runtime
package RACTL5.DPK. In "Package..." window click "Compile" button to
compile packages RACTL5.DPK. After compiling repeat that for other R&A
Library run-time packages RADB5.DPK, RAI5.DPK, RAIA5.DPK. Put compiled
BPL files into directory that is accessible through the search PATH
(i.e. DOS "PATH" environment variable; for example, in the Windows\System
directory or $DELPHI\PROJECTS\BPL directory). After compiling R&A
run-time packages you must install R&A design-time packages into the IDE.

Use "File\Open..." menu item to open consistently R&A design-time
packages DCLRACTL5.DPK, DCLRADB5.DPK and DCLRAI5.DPK.
In "Package..." window click "Install" button to register R&A Library
components on the "R&A Controls" and "R&A DB" pages.

For instructions for installing R&A Form Designer please read
RALIB\DOC\RAFD.TXT file.

TIP: Move all PAS-files from RALIB\LIB folder into RALIB\SOURCE.


2. Delphi 4:

Uninstall previous installed version of R&A Library from Delphi 4 IDE.
Remove previously compiled R&A packages (if any) RACTRL40.BPL, RADB40.BPL,
RAI2_40.BPL, RAFD40.BPL, RACTL4.BPL, RADB4.BPL, RAI4.BPL, RAIA4.BPL,
RAFD4.BPL from your hard disk.

Run file RALIB\RESOURCE\RUSSIAN\RES.BAT (russian resources) or
RALIB\RESOURCE\ENGLISH\RES.BAT (english resources).

Use "File\Open..." menu item of Delphi IDE to open R&A' runtime
package RACTL4.DPK. In "Package..." window click "Compile" button to
compile packages RACTL4.DPK. After compiling repeat that for other R&A
Library run-time packages RADB4.DPK, RAI4.DPK, RAIA4.DPK. Put compiled
BPL files into directory that is accessible through the search PATH
(i.e. DOS "PATH" environment variable; for example, in the Windows\System
directory). After compiling R&A run-time packages you must install R&A
design-time packages into the IDE.

Use "File\Open..." menu item to open consistently R&A design-time
packages DCLRACTL4.DPK, DCLRADB4.DPK and DCLRAI4.DPK.
In "Package..." window click "Install" button to register R&A Library
components on the "R&A Controls" and "R&A DB" pages.

For instructions for installing R&A Form Designer please read
RALIB\DOC\RAFD.TXT file.

TIP: Move all PAS-files from RALIB\LIB folder into RALIB\SOURCE.


3. Delphi 3.x:

Uninstall previous installed version of R&A Library from Delphi 3 IDE.
Remove previously compiled R&A packages (if any) RACTRL30.DPL, RADB30.DPL,
RAI2_30.DPL, RAFD30.DPL, RACTL3.DPL, RADB3.DPL, RAI3.DPL, RAIA3.DPL,
RAFD3.DPL from your hard disk.

Run file RALIB\RESOURCE\RUSSIAN\RES.BAT (russian resources) or
RALIB\RESOURCE\ENGLISH\RES.BAT (english resources).

Use "File\Open..." menu item of Delphi IDE to open R&A' runtime
package RACTL3.DPK. In "Package..." window click "Compile" button to
compile packages RACTL3.DPK. After compiling repeat that for other R&A
Library run-time packages RADB3.DPK, RAI3.DPK, RAIA3.DPK. Put compiled
BPL files into directory that is accessible through the search PATH
(i.e. DOS "PATH" environment variable; for example, in the Windows\System
directory). After compiling R&A run-time packages you must install R&A
design-time packages into the IDE.

Use "File\Open..." menu item to open consistently R&A design-time
packages DCLRACTL3.DPK, DCLRADB3.DPK and DCLRAI3.DPK.
In "Package..." window click "Install" button to register R&A Library
components on the "R&A Controls" and "R&A DB" pages.

For instructions for installing R&A Form Designer please read
RALIB\DOC\RAFD.TXT file.

TIP: Move all PAS-files from RALIB\LIB folder into RALIB\SOURCE.


4. Delphi 2.x and C++ Builder 1:

Run file RALIB\RESOURCE\RUSSIAN\RES.BAT (russian resources) or
RALIB\RESOURCE\ENGLISH\RES.BAT (english resources).

Use the "Install..." item on Delphi's "Component" menu to add
the RACtlReg.PAS, RADBReg.PAS and RAi2Reg.PAS units to the component
library. These units registers all R&A Library components on the
"R&A Controls" and "R&A DB" pages accordingly.

TIP: Move all PAS-files from RALIB\LIB folder into RALIB\SOURCE.


5. C++ Builder 4:

Uninstall previous installed version of R&A Library from Delphi 4 IDE.
Remove previously compiled R&A packages (if any) RACTL45.BPL, RADB45.BPL,
RAI45.BPL, RAIA45.BPL from your hard disk.

Run file RALIB\RESOURCE\RUSSIAN\RES.BAT (russian resources) or
RALIB\RESOURCE\ENGLISH\RES.BAT (english resources).

Use "File\Open..." menu item of Delphi IDE to open R&A' runtime
package RACTL45.BPK. In "Package..." window click "Compile" button to
compile packages RACTL45.BPK. After compiling repeat that for other R&A
Library run-time packages RADB45.BPK, RAI45.BPK, RAIA45.BPK. Put compiled
BPL files into directory that is accessible through the search PATH
(i.e. DOS "PATH" environment variable; for example, in the Windows\System
directory or $BUILDER\Projects\Bpl). After compiling R&A run-time
packages you must install R&A design-time packages into the IDE.

Use "File\Open..." menu item to open consistently R&A design-time
packages DCLRACTL45.BPK, DCLRADB45.BPK and DCLRAI45.BPK.
In "Package..." window click "Install" button to register R&A Library
components on the "R&A Controls" and "R&A DB" pages.

For instructions for installing R&A Form Designer please read
RALIB\DOC\RAFD.TXT file.

TIP: Move all PAS-files from RALIB\LIB folder into RALIB\SOURCE.



Demonstration Programs
----------------------
Demos can be found in RALIB\DEMOS folder.


Source Files
------------

All sources (100%) of R&A Library are available in RALIB\LIB or
RALIB\SOURCE directories. All language specific string constants
used in R&A Library are collected in RAConst.pas file. English and
russian versions of this files are available in RALIB\RESOURCE
directory.


Credits
-------
Thanks to:
 - Antony Aloy Lypez for Spanish resources (1.0 version).
 - Tony L for idea of Color Hints.
 - Rafal Smotrzyk for many improvements in RAEditor and
   highlighers for RAHLEditor.
 - Dmitry Mokrushin for serious testing and improvements in RAI2.
 - Jaromir Solar for Czech resources.
 - Peter Fischer-Haaser for testing and some coding in RAI2.
 - Tony de Buys for RALib discussion group.
 - Knipper John for french resources.
 - Indranil Bandyopadhyay for bug fixes.
 - Jamie Frater for big testing of RAI2.
 - Andrej Olejnik for array-support coding in rai2.
 - and all guys who wrote to us.

Copyright Notes
---------------

Most of the modules in our library are written by us. We have to make
a note of units based on sources of other authors.

Unit RADBLookupTreeView is based on original Delphi VCL units
DBLOOKUP, DBCTRLS.

Unit RAButtons has big code portion from Delphi VCL unit Buttons.

Units RARegAuto and RARegAutoEditor based on samples from
Sergey Orlik Book.

"!Readme.txt" and "license.txt" files are based on RX Library's files.


  Authors:
    Andrey Prigunkov   (black@infa.ru, blacknbs@chat.ru)
    Roman  Tkachev     (roman@infa.ru, whiteman@mail.ru)

  R&A Library Home Page:
    http://www.infa.ru/black/ralib.htm,
    http://www.chat.ru/~blacknbs/ralib.htm

    Infa-Soft,
      Stavropol, Russia.

