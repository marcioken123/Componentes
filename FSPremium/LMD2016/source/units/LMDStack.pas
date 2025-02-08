unit LMDStack;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDStack unit (JH)
------------------
Stack data structure
A stack is a LIFO buffer where you can only access the entry insert last

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDDynLIFOBuffer;

type
  TLMDStack = class(TLMDDynLIFOBuffer)
  public
    //inserts a new item as top item on the stack
    procedure Push (item : TObject); overload;
    //destroys the top item
    procedure Pop;
    //returns a pointer to the top item. Will be left on the stack
    function Top : TObject;
    //keep in mind that the extracted item has to be destroyed manually!!
    function ExtractTop : TObject; 

    procedure Push (item : Pointer); overload;

  end;

implementation

{ ---------------------------------------------------------------------------- }
procedure TLMDStack.Push (item : TObject);
begin
  Put(item);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStack.Pop;
var
  p : TObject;
begin
  p := Get;
  clearItem (p);
end;

{ ---------------------------------------------------------------------------- }
function TLMDStack.Top : TObject;
begin
  //S := Stack
  result := Get;
  //Stack := Stack - TopEntry
  Put (result);
  //Stack := Stack + result => Stack := Stack
end;

{ ---------------------------------------------------------------------------- }
function TLMDStack.ExtractTop : TObject;
begin
  //Stack
  result := Get;
  //Stack := Stack - TopEntry
end;

procedure TLMDStack.Push (item : Pointer);
begin
  Push(TObject(Item));
end;

end.
