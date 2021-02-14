unit train_lib;

interface

uses
  Windows,
  TlHelp32;

const
error_cap = 'Are You Mad ?';
error_mem = 'Run The Game First';
GameProc  = 'pun.exe';                                       //Your game process name (F.e. Game.exe)

var
win : hWnd;

//work whith process and memory
function GetGameProcessID(FileName : String) : Cardinal;

function PatchMem(WndName         : pChar;
                   BaseAddress    : Dword;
                   Buffer         : Pointer;
                   LengthOfBuffer : Dword) : Boolean;

function PatchMem2(GameID          : Cardinal;
                    PokeAddr        : Integer;
                    PokeVal         : Array of Byte;
                    NumBytesToWrite : Integer) : Boolean;

implementation

function GetGameProcessID(FileName:String):Cardinal;
var
  hSnap:THandle;
  prEntry:PROCESSENTRY32;
begin
  Result:=0;
  hSnap:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  prEntry.dwSize:=SizeOf(prEntry);
if Process32First(hSnap,prEntry) then
  begin
    while Process32Next(hSnap,prEntry) do
  begin
    if prEntry.szExeFile = FileName then
       Result:=Cardinal(prEntry.th32ProcessID);
   end;
  end;
  CloseHandle(hSnap);
end;

function PatchMem(WndName : pChar; BaseAddress : Dword; Buffer : Pointer; LengthOfBuffer : Dword) : Boolean;
var
  hWnd, id, ph : dword;
  written      : cardinal;
  successful   : longbool;
begin
 asm
  xchg eax,written
  mov  eax,0
 end;
   written:=0;
   hwnd:=findwindowexa(0, 0, nil, WndName);
   if hwnd=0 then
       begin
          //MessageBox(win, error_mem, error_cap, MB_OK or MB_ICONINFORMATION);
          patchmem:=false;
          exit;
       end;
     getwindowthreadprocessid(hwnd,@id);
     ph:=openprocess(generic_read or generic_write,false,id);
     asm
     cmp ph,0
     end;
     begin 
          patchmem:=false; 
          exit;
     end;
     asm 
        push written 
        push LengthOfBuffer
        push buffer 
        push BaseAddress
        push ph 
        call WriteProcessMemory 
        mov successful, eax
     end; 
     patchmem:=successful; 
     closehandle(0); 
end;

function PatchMem2(GameID : Cardinal; PokeAddr : Integer; PokeVal : Array of Byte; NumBytesToWrite : Integer) : Boolean;
var
  pHandle:LongInt;
  numwritten:Cardinal;
begin
  if GetGameProcessID(GameProc) = 0 then
   begin
     exit;
  end;
  pHandle:=OpenProcess(PROCESS_VM_READ or PROCESS_VM_WRITE or PROCESS_VM_OPERATION,false,GameID);
  WriteProcessMemory(pHandle,ptr(PokeAddr),@PokeVal,NumBytesToWrite,numwritten);
  CloseHandle(pHandle);
end;
end.
