unit XLSReadWrite;

{
********************************************************************************
******* XLSReadWrite V1.36                                               *******
*******                                                                  *******
******* Copyright(C) 1999, 2000 Lars Arvidsson, Axolot Data              *******
*******                                                                  *******
******* email: components@axolot.com                                     *******
******* URL:   http://www.axolot.com                                     *******
********************************************************************************
** Users of the XLSReadWrite component must accept the following disclaimer   **
** of warranty:                                                               **
**                                                                            **
** XLSReadWrite is supplied as is. The author disclaims all warranties,       **
** expressedor implied, including, without limitation, the warranties of      **
** merchantability and of fitness for any purpose. The author assumes no      **
** liability for damages, direct or consequential, which may result from the  **
** use of XLSReadWrite.                                                       **
********************************************************************************
}

{$I XLSRW.inc}

interface

uses Classes, XLSRead, XLSWrite, BIFFRecs,
{$ifdef OLD_COMPILER}
DsgnIntf,
{$else}
DesignIntf,
{$endif}

{$ifdef OLD_COMPILER}
PropEdExcelColorsD30;
{$else}
PropEdExcelColorsD40;
{$endif}

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('XLS', [TXLSRead]);
  RegisterComponents('XLS', [TXLSWrite]);
  RegisterPropertyEditor(TypeInfo(TExcelColor), nil, '', TExcelColorsProperty);
end;

end.
