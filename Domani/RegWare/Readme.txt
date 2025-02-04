WAK Productions Presents:
TRegware    version 2.00
Copyright ©2001 - WAK Productions
---------------------------------
Programmed by Winston Kotzan
Email: waksoftware@hotmail.com
Website URL: http://wak.cjb.net/


This program helps developers of shareware include a timebomb/registration
for their program.  The end-user will enter their a name representing their
license, and a serial number (kinda like Winzip).  If their registration info.
is correct, then the program becomes registered.  TRegware hides data in the Windows
registry to check if program was registered.


Release Notes
-------------

Version 2 of TRegware uses a different, more secure method of encoding
data in the registry.  Unfortunately, this makes version 1 of TRegware
incompatible with version 2.  To provide backwards compatibility, the
class name for TRegware in version 2 has been changed to TRegwareII.


New features in version 2.0:

-Detects if the user attempted to deceive the timebomb by setting their
computer's clock backwards.  In this case, the component will signal an
OnClockChange event and report that the program has expired.  When the
user decides to put his clock back within the remaining 'x' days of his
evaluation period, the timebomb will continue to operate.

-TRegware now comes packaged with a Perl file (regware200.pl) so that 
registration codes can be generated on a UNIX-based web server.  You 
can use the Perl script if you would like to give registration codes 
to customers via a CGI program.


Bug reports? Suggestions? Comments?
Email to: waksoftware@hotmail.com

or visit website

http://wak.cjb.net/

