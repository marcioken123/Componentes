R&A Form Designer version same as R&A Library
=============================================

The run-time form designer.
100% Source Code.

Last revision date Jan, 5, 2000.

PLEASE FOLLOW THE INSTRUCTIONS PROVIDED IN THE INSTALLATION SECTION!

TABLE OF CONTENTS
-----------------
Overview
History
License Agreement
Installation
Source Files
Copyright Notes


Overview
--------

R&A Form Designer (RAFD) is run-time form designer for Delphi
programs. It can open, create, modifing, save native Delphi
forms stored in dfm/pas files. Full source code included.
This RAFD is compatible with Borland Delphi 3, 4, 5.

R&A Form Designer is part of R&A Library which is a freeware product.
R&A Form Designer distributed under R&A Library License Agreement.

The authors disclaim all warranties as to this software, whether express
or implied, including without limitation any implied warranties of
merchantability or fitness for a particular purpose. Use under your own
responsibility, but comments (even critique) in English (or in Russian)
are welcome.


1. Designer.
This is designer for Delphi native form files and units.
It can be used only as package.
Designer contains the following parts:
  - designer for manipulating with forms;
  - text editor for manipulating with unit sources;
  - project manager (very simple and not complete);
  - main window - AppBuilder for open, saving files,...;
  - component pallete and run-time package loading support
    for loading new packages without recompiling Form Designer;
  - implementation (not all) of Delphi ToolsAPI to make it possible
    to load native Delphi experts into Form Designer environment.    

2. Design Packages.
Due conflict with Borland Deploy licence we (and you) can't
distribute Delphi design packages with our applications.
This packages work fine in RAFD, but...
So we start to wrote our one design packages for standard Delphi
components. Those packages placed in RALIB\RAFD\DPACKAGES folder.
Those packages register standard Delphi components and contains
some property and component editors. The most harded editors
allready writen. This are Menu Builder, Dataset Designer,
Collection Editor, TStrings Property Editor and others.
Not all Delphi editors implemented, so we need your help on this way!
Contact with as!

3. RAd October demo project.
This demo project can be found in RALIB\RAFD\RAdOctober30.dpr
(RAdOctober40.dpr for Delphi 4, RAdOctober50.dpr for Delphi 4) file. 
It used by us to tests R&A Form Designer. This very simple 
project conatains only splash and create in run-time instance 
of TRAAppBuilder component and run it.

4. Demo forms.

5. There are no help files for R&A Form Designer now. Sorry.


History (R&A Library versions)
------------------------------

RALib 1.20 (Apr 1999).
  Initial release available as part of R&A Library.

RALib 1.40 (Jan 2000).
  Delphi 5 compatibility.

RALib 1.50 (Jan 2000).
  Bug fixes in internal package support.


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
file LICENSE.TXT. As writen above R&A Form Designer distributed according
to R&A Library License Agreement.


Compatibility
-------------

This version of R&A Form Designer is writen and full tested with
Borland Delphi 3 Client/Server Edition. After that we have ported
it to Borland Delphi 4 Client/Server Edition with update pack 3 and
Borland Delphi 5 Enterprise Edition.
RAFD is NOT compatible with Borland Delphi 2, Borland C++ Builder 1, 3, 4.


Installation
------------

All RAFD files placed in RALib\RAfd folder.

Before installing R&A Form Designer you must install R&A Library components
as described in RALib\!Readme.txt file.

1. Choosing resources.
Run file rafdres.bat from RALIB\RAFD\RESOURCE\RUSSIAN (russian resources) or
RALIB\RESOURCE\RAFD\ENGLISH (english resources) folder. This bat-file must
compile and install resources in appropriate folders.

2. Compiling Designer.

Use "File\Open..." menu item of Delphi IDE to open package
RALIB\RAFD\RAFD3.DPK (RAFD4.DPK for Delphi 4, RAFD5.DPK for Delphi 5).
In "Package.." window click "Compile" button.
RAFD package is run-time package only and you don't need install it.

3. Compiling Design Packages.

Use "File\Open..." menu item of Delphi IDE to open consistently RAFD
design-time packages RALIB\RAFD\DPACKAGES\DFDSTD3.DPK and
RALIB\RAFD\DPACKAGES\DFDSTD3.DPK (DFDSTD4.DPK and DFDDB4.DPK for
Delphi 4, DFDSTD5.DPK and DFDDB5.DPK for Delphi 4). In "Package.." 
window click "Compile" button.

4. Compiling RAd October demo project.
Use "File\Open..." menu item of Delphi IDE to open RALIB\RAFD\RAdOctober3.dpr
(RAdOctober4.dpr for Delphi 4, RAdOctober5.dpr for Delphi 5) file. 
Use "Project\Complie" command to make project.
NOTE: RAd October can be compiled only with run-time package support.

5. Running RAd October Demo.
Copy file RALIB\RAFD\DESIGNER\RAFD3.DPL (RAFD4.BPL for Delphi 4,
RAFD5.BPL for Delphi 5) to RAd October exe folder (RALIB\RAFD by default).
Copy files RALIB\RAFD\DPACKAGES\DFDSTD3.DPL and DFDDB3.DPL
(DFDSTD4.BPL and DFDDB4.BPL for Delphi 4, DFDSTD5.BPL and DFDDB5.BPL 
for Delphi 5) to RAd October exe folder (RALIB\RAFD by default).
Copy files RALIB\LIB\RACTL3.DPL and RAI3.DPL (RACTL4.BPL and
RAI4.BPL for Delphi 4, RACTL5.BPL and RAI5.BPL for Delphi 5) 
to RAd October exe folder (RALIB\RAFD by default).
Checkout file RALIB\RAFD\RAdOctober3.ini (RALIB\RAFD\RAdOctober4.ini for
Delphi 4, (RALIB\RAFD\RAdOctober5.ini for Delphi 5), look at sections 
"Experts" and "Packages", correct paths to files in this sections.
Check that file RAdOctober3.ini (RAdOctober4.ini for Delphi 4, 
RAdOctober5.ini for Delphi 5) exists in RAd October exe folder 
(RALIB\RAFD by default).
Run RAdOctober3.exe (RAdOctober4.exe for Delphi 4, RAdOctober5.exe 
for Delphi 5).

Source Files
------------

All sources (100%) of R&A Form Designer are available in RALIB\LIB and 
RALIB\RAFD directories. All language specific string constants used in 
RAFD are collected in Packconst.pas and RAFD.rc files. English and
russian versions of this files are available in RALIB\RAFD\RESOURCE
directory.


Copyright Notes
---------------

All modules in our Form Designer are written by us.

  Author:
    Andrey Prigunkov   (black@infa.ru, blacknbs@chat.ru)

  R&A Library Home Page:
    http://www.infa.ru/black/ralib.htm

    Infa-Soft,
      Stavropol, Russia.

