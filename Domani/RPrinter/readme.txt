RawPrinter - ver. 1.1

Files in this archive give you a very simplified way 
to send raw data to the printer using Windows API.
It works just like good old DOS-printing :)) 
but goes through the Windows Printer Spooler.
This means you can:
- print text in real text mode (which is usually much faster)
- include any commands your printer supports 
  (like PCL, IBM Proprinter or EPSON codes)

To use it, you have got two options:

1. RawPrinting.pas unit
   This one includes a one simple procedure to send 
   a whole print job as one string parameter,

2. TRawPrinter component
   You can put it on your form and use methods like: 
    BeginDoc, EndDoc, Write, NextPage etc.
   See the RawPrinter.pas file to find more info about it.
   
   To install the component on Delphi palette - just add 
   the RawPrinter unit to one of your packages.


All this stuff is freeware. 
You can do with it whatever you want to, 
just don't remove the copyright.

If you have any questions, comments or found any bugs
- feel free to send me an e-mail.

-----
Przemyslaw Jankowski
pjank@home.pl
