unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI, ExtCtrls, jpeg, StdCtrls, About, TlHelp32, train_lib;

type
  TThePunisher = class(TForm)
    GameDialog: TOpenDialog;
    BackGround: TImage;
    UnlimitedHealth: TLabel;
    UnlimitedAmmo: TLabel;
    SlaughterMode: TLabel;
    BlackAndWhite: TLabel;
    UpgradePoints: TLabel;
    StylePoints: TLabel;
    Molotov: TLabel;
    MaxHealth: TLabel;
    MaxSlaughterMode: TLabel;
    FreezeTimer: TLabel;
    AntiTankMine: TLabel;
    BullsEyeKnife: TLabel;
    RawMine: TLabel;
    Flashbangs: TLabel;
    NoReload: TLabel;
    RunGame: TButton;
    About: TButton;
    FragGrenade: TLabel;
    BulletproofGondola: TLabel;
    OneHitKill: TLabel;
    Invisibility: TLabel;
    CrazyDeath: TLabel;
    Gondola: TTimer;
    Slaughter: TTimer;
    InvisTimer: TTimer;
    NoreloadTimer: TTimer;
    CrzyDeathTimer: TTimer;
    OnehitKillTimer: TTimer;
    UnlimHealthTimer: TTimer;
    Timer1: TTimer;
    procedure RunGameClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UnlimitedHealthClick(Sender: TObject);
    procedure UnlimitedHealthDblClick(Sender: TObject);
    procedure UnlimitedAmmoClick(Sender: TObject);
    procedure UnlimitedAmmoDblClick(Sender: TObject);
    procedure MaxSlaughterModeClick(Sender: TObject);
    procedure BlackAndWhiteClick(Sender: TObject);
    procedure BlackAndWhiteDblClick(Sender: TObject);
    procedure SlaughterTimer(Sender: TObject);
    procedure GondolaTimer(Sender: TObject);
    procedure BulletproofGondolaClick(Sender: TObject);
    procedure BulletproofGondolaDblClick(Sender: TObject);
    procedure UpgradePointsClick(Sender: TObject);
    procedure FreezeTimerClick(Sender: TObject);
    procedure FreezeTimerDblClick(Sender: TObject);
    procedure SlaughterModeClick(Sender: TObject);
    procedure SlaughterModeDblClick(Sender: TObject);
    procedure CrazyDeathClick(Sender: TObject);
    procedure CrazyDeathDblClick(Sender: TObject);
    procedure OneHitKillClick(Sender: TObject);
    procedure OneHitKillDblClick(Sender: TObject);
    procedure InvisibilityClick(Sender: TObject);
    procedure InvisibilityDblClick(Sender: TObject);
    procedure NoReloadClick(Sender: TObject);
    procedure NoReloadDblClick(Sender: TObject);
    procedure MolotovClick(Sender: TObject);
    procedure FragGrenadeClick(Sender: TObject);
    procedure AntiTankMineClick(Sender: TObject);
    procedure BullsEyeKnifeClick(Sender: TObject);
    procedure RawMineClick(Sender: TObject);
    procedure FlashbangsClick(Sender: TObject);
    procedure StylePointsClick(Sender: TObject);
    procedure MaxHealthClick(Sender: TObject);
    procedure InvisTimerTimer(Sender: TObject);
    procedure CrzyDeathTimerTimer(Sender: TObject);
    procedure OnehitKillTimerTimer(Sender: TObject);
    procedure NoreloadTimerTimer(Sender: TObject);
    procedure UnlimHealthTimerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ThePunisher: TThePunisher;
  hWin : DWORD;

  //////////////////////
      WindowName: integer;
      ProcessId: integer;
      ThreadId: integer;
      HandleWindow: Integer;
      write: cardinal;
      readwrite:cardinal;
      b:dword;
  //////////////////////
      MaxSlaughterValue: dword;
      MaxHealthValue: dword;
      BlackAndWhiteValue: dword;
      NormalModeValue: dword;
      UpgradePointsValue: dword;
      UnlimitedHealthON: dword;
      UnlimitedHealthOFF: dword;
      BulletProofGondolaValue: dword;
      NoReloadON,NoReloadOFF: dword;
      InvisibilityON,InvisibilityOFF: dword;
      CrazyDeathON,CrazyDeathOFF: dword;
      OneHitKillON,OneHitKillOFF: dword;
      ThrownWeaponCountValue,
      ThrownWeaponObjectCreateValue,
      ThrownWeaponTypeValue,
      ThrownWeaponVisibilityOfCountValue,
      ThrownWeaponVisibilityOfTypeValue,
      ThrownWeaponGetFlagValue: dword;
      StylePointsValue: dword;
//////////////////////
  
Const
 GameCap = 'The Punisher'; //заголовок процесса игры
 ///////////////////
 //////////////////

 {Оружие}
 AmmoAddress1 = $4FD65B; //крупнокалиберное оружие
 AmmoAddress2 = $505945; //пистолеты
 AmmoAddress3 = $4FB20B; //гранатамет
 AmmoAddress4 = $4FBEED; //огнемет
 Ammo : Array[1..3] of byte = ($FF,$4E,$30);
 FreezeAmmo : Array[1..3] of byte = ($90,$90,$90);

 {Метательное оружие / Мины}
 ThrownWeaponCountAddress = $7CF808;
 ThrownWeaponObjectCreateAddress = $7366C0;
 ThrownWeaponTypeAddress = $7CF804;
 ThrownWeaponVisibilityOfCountAddress = $736714;
 ThrownWeaponVisibilityOfTypeAddress = $7CF964;
 ThrownWeaponGetFlagAddress = $7CF968;

 {Очки улучшений}
 UpgradePointsAddress = $66E4C0;
 UpgradePointsVisualAddress = $6759B0;
 
 {Здоровье}
 HealthAddress = $61F8F4;
 HealthPointer = $6B707C; //288
 MainHealthAddress = $420D09;
 Health : Array[1..6] of byte = ($D9,$96,$88,$02,$00,$00);
 FreezeHealth : Array[1..6] of byte = ($90,$90,$90,$90,$90,$90);

 {Убийство одним выстрелом}
 OneHitKillAddress = $61F90C;

 {Дикая смерть}
 CrazyDeathAddress = $61F924;

 {Невидимость}
 InvisibilityAddress = $61F914;

 {Без перезарядки}
 NoReloadAddress = $61F8FC;

 {Очки за убийство}
 StylePointsAddress = $7D0EE0;

 {Гондола}
 GondolaAddress = $7F0AF4;

 {Таймер}
 TimerAddress = $0045E02F;
 Time : Array[1..6] of byte = ($D9,$15,$78,$9B,$75,$00);
 FreezeTime : Array[1..6] of byte = ($90,$90,$90,$90,$90,$90);

 {Карательный режим}
 SlaughterModeAddress = $7D0E3C;

 {Черно-белый режим}
 BWModeAddress = $70E1B1;


 NumberOfBytes = 4;

 implementation

{$R *.dfm}

{Этой процедурой мы будем проверять, запущена ли процесс игры до трейнера,
проверив соответствие/несоответствие заголовка с тем, что был определен в константе}
{Инициализируем ее при старте трейнера, чтобы было понятно юзеру, что он делает не так}
{В случае, если игра не запущена, то будет доступна кнопка Run Game, по нажатию которой пользователю
будет предложено выбрать exe файл с игрой.}

procedure Checker;
begin
  if GetGameProcessID(GameProc) = 0 then
   begin
     exit;
   end
   else
   ThePunisher.RunGame.enabled:=false;
end;

procedure TThePunisher.AboutClick(Sender: TObject);
begin
AboutBox.Show;
end;

procedure TThePunisher.AntiTankMineClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    ThrownWeaponCountValue:=$9;
    ThrownWeaponObjectCreateValue:=$101;
    ThrownWeaponTypeValue:=$1F;
    ThrownWeaponVisibilityOfCountValue:=$FFFFFFFF;
    ThrownWeaponVisibilityOfTypeValue:=$1;
    ThrownWeaponGetFlagValue:=$0;
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponCountAddress), @ThrownWeaponCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponObjectCreateAddress), @ThrownWeaponObjectCreateValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponTypeAddress), @ThrownWeaponTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfCountAddress), @ThrownWeaponVisibilityOfCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfTypeAddress), @ThrownWeaponVisibilityOfTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponGetFlagAddress), @ThrownWeaponGetFlagValue, 4, write);
end;

procedure TThePunisher.BlackAndWhiteClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    BlackAndWhite.Font.Color:=clGreen;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    BlackAndWhiteValue:=$1;
    WriteProcessMemory(HandleWindow, ptr(BWModeAddress), @BlackAndWhiteValue, 4, write);
end;

procedure TThePunisher.BlackAndWhiteDblClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    BlackAndWhite.Font.Color:=clRed;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    NormalModeValue:=$0;
    WriteProcessMemory(HandleWindow, ptr(BWModeAddress), @NormalModeValue, 4, write);
end;

procedure TThePunisher.BulletproofGondolaClick(Sender: TObject);
begin
Checker;
Gondola.Enabled:=true;
end;

procedure TThePunisher.BulletproofGondolaDblClick(Sender: TObject);
begin
Checker;
BulletproofGondola.Font.Color:=clRed;
Gondola.Enabled:=False;
end;

procedure TThePunisher.BullsEyeKnifeClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    ThrownWeaponCountValue:=$9;
    ThrownWeaponObjectCreateValue:=$101;
    ThrownWeaponTypeValue:=$22;
    ThrownWeaponVisibilityOfCountValue:=$FFFFFFFF;
    ThrownWeaponVisibilityOfTypeValue:=$1;
    ThrownWeaponGetFlagValue:=$0;
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponCountAddress), @ThrownWeaponCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponObjectCreateAddress), @ThrownWeaponObjectCreateValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponTypeAddress), @ThrownWeaponTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfCountAddress), @ThrownWeaponVisibilityOfCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfTypeAddress), @ThrownWeaponVisibilityOfTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponGetFlagAddress), @ThrownWeaponGetFlagValue, 4, write);
end;

procedure TThePunisher.CrazyDeathClick(Sender: TObject);
begin
Checker;
CrzyDeathTimer.Enabled:=true;
end;

procedure TThePunisher.CrazyDeathDblClick(Sender: TObject);
begin
Checker;
CrzyDeathTimer.Enabled:=false;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    CrazyDeath.Font.Color:=clRed;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    CrazyDeathOFF:=$100;
    WriteProcessMemory(HandleWindow, ptr(CrazyDeathAddress), @CrazyDeathOFF, 4, write);
end;

procedure TThePunisher.CrzyDeathTimerTimer(Sender: TObject);
begin
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    CrazyDeath.Font.Color:=clGreen;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    CrazyDeathON:=$101;
    WriteProcessMemory(HandleWindow, ptr(CrazyDeathAddress), @CrazyDeathON, 4, write);
end;

procedure TThePunisher.FlashbangsClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    ThrownWeaponCountValue:=$9;
    ThrownWeaponObjectCreateValue:=$101;
    ThrownWeaponTypeValue:=$20;
    ThrownWeaponVisibilityOfCountValue:=$FFFFFFFF;
    ThrownWeaponVisibilityOfTypeValue:=$1;
    ThrownWeaponGetFlagValue:=$0;
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponCountAddress), @ThrownWeaponCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponObjectCreateAddress), @ThrownWeaponObjectCreateValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponTypeAddress), @ThrownWeaponTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfCountAddress), @ThrownWeaponVisibilityOfCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfTypeAddress), @ThrownWeaponVisibilityOfTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponGetFlagAddress), @ThrownWeaponGetFlagValue, 4, write)
end;

procedure TThePunisher.FormActivate(Sender: TObject);
begin
Checker;
end;

procedure TThePunisher.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//if key = VK_ESCAPE then
if (GetAsyncKeyState(VK_ESCAPE) <> 0) then
begin
Application.Terminate;
end;
end;

procedure TThePunisher.GondolaTimer(Sender: TObject);
begin
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    BulletproofGondola.Font.Color:=clGreen;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    BulletProofGondolaValue:=$64;
    WriteProcessMemory(HandleWindow, ptr(GondolaAddress), @BulletProofGondolaValue, 4, write);
end;

procedure TThePunisher.InvisibilityClick(Sender: TObject);
begin
Checker;
InvisTimer.Enabled:=true;
end;

procedure TThePunisher.InvisibilityDblClick(Sender: TObject);
begin
Checker;
InvisTimer.Enabled:=false;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    Invisibility.Font.Color:=clRed;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    InvisibilityOFF:=$100;
    WriteProcessMemory(HandleWindow, ptr(InvisibilityAddress), @InvisibilityOFF, 4, write);
end;

procedure TThePunisher.InvisTimerTimer(Sender: TObject);
begin
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    Invisibility.Font.Color:=clGreen;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    InvisibilityON:=$101;
    WriteProcessMemory(HandleWindow, ptr(InvisibilityAddress), @InvisibilityON, 4, write);
end;

procedure TThePunisher.MaxHealthClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    ReadProcessMemory(HandleWindow,ptr(HealthPointer),@b,4,readwrite);
    b:=b+648;
    MaxHealthValue:=$44020000;
    WriteProcessMemory(HandleWindow, ptr(b), @MaxHealthValue, 4, readwrite);
end;

procedure TThePunisher.MaxSlaughterModeClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    MaxSlaughterValue:=$41F00000;
    WriteProcessMemory(HandleWindow, ptr(SlaughterModeAddress), @MaxSlaughterValue, 4, write);
end;

procedure TThePunisher.MolotovClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    ThrownWeaponCountValue:=$9;
    ThrownWeaponObjectCreateValue:=$101;
    ThrownWeaponTypeValue:=$21;
    ThrownWeaponVisibilityOfCountValue:=$FFFFFFFF;
    ThrownWeaponVisibilityOfTypeValue:=$1;
    ThrownWeaponGetFlagValue:=$0;
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponCountAddress), @ThrownWeaponCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponObjectCreateAddress), @ThrownWeaponObjectCreateValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponTypeAddress), @ThrownWeaponTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfCountAddress), @ThrownWeaponVisibilityOfCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfTypeAddress), @ThrownWeaponVisibilityOfTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponGetFlagAddress), @ThrownWeaponGetFlagValue, 4, write);
end;

procedure TThePunisher.NoReloadClick(Sender: TObject);
begin
Checker;
NoreloadTimer.Enabled:=true;
end;

procedure TThePunisher.NoReloadDblClick(Sender: TObject);
begin
Checker;
NoreloadTimer.Enabled:=false;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    NoReload.Font.Color:=clRed;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    NoReloadON:=$100;
    WriteProcessMemory(HandleWindow, ptr(NoReloadAddress), @NoReloadON, 4, write);
end;

procedure TThePunisher.NoreloadTimerTimer(Sender: TObject);
begin
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    NoReload.Font.Color:=clGreen;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    NoReloadON:=$101;
    WriteProcessMemory(HandleWindow, ptr(NoReloadAddress), @NoReloadON, 4, write);
end;

procedure TThePunisher.OneHitKillClick(Sender: TObject);
begin
Checker;
OnehitKillTimer.Enabled:=true;
end;

procedure TThePunisher.OneHitKillDblClick(Sender: TObject);
begin
Checker;
OnehitKillTimer.Enabled:=false;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    OneHitKill.Font.Color:=clRed;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    OneHitKillOFF:=$100;
    WriteProcessMemory(HandleWindow, ptr(OneHitKillAddress), @OneHitKillOFF, 4, write);
end;

procedure TThePunisher.OnehitKillTimerTimer(Sender: TObject);
begin
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    OneHitKill.Font.Color:=clGreen;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    OneHitKillON:=$101;
    WriteProcessMemory(HandleWindow, ptr(OneHitKillAddress), @OneHitKillON, 4, write);
end;

{Данной процедурой мы инициализируем диалоговое окно, предоставляя возможность выбрать exe файл игры и запустить его}
{Попутно проверяем, если все ок и мы нашли окно с заголовком игры, то делаем кнопку недоступной}
procedure TThePunisher.RawMineClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    ThrownWeaponCountValue:=$9;
    ThrownWeaponObjectCreateValue:=$101;
    ThrownWeaponTypeValue:=$1D;
    ThrownWeaponVisibilityOfCountValue:=$FFFFFFFF;
    ThrownWeaponVisibilityOfTypeValue:=$1;
    ThrownWeaponGetFlagValue:=$0;
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponCountAddress), @ThrownWeaponCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponObjectCreateAddress), @ThrownWeaponObjectCreateValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponTypeAddress), @ThrownWeaponTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfCountAddress), @ThrownWeaponVisibilityOfCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfTypeAddress), @ThrownWeaponVisibilityOfTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponGetFlagAddress), @ThrownWeaponGetFlagValue, 4, write);
end;

procedure TThePunisher.RunGameClick(Sender: TObject);
begin
     if GameDialog.execute then
     begin
     ShellExecute(Self.Handle, 'open', PChar(GameDialog.FileName), nil, nil, SW_SHOWNORMAL);
     ThePunisher.RunGame.enabled:=false;
     end
     else
     ThePunisher.RunGame.enabled:=true;
end;

procedure TThePunisher.SlaughterModeClick(Sender: TObject);
begin
Checker;
Slaughter.Enabled:=true;
end;

procedure TThePunisher.SlaughterModeDblClick(Sender: TObject);
begin
Checker;
SlaughterMode.Font.Color:=clRed;
Slaughter.Enabled:=false;
end;

procedure TThePunisher.SlaughterTimer(Sender: TObject);
begin
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    SlaughterMode.Font.Color:=clGreen;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    MaxSlaughterValue:=$41F00000;
    WriteProcessMemory(HandleWindow, ptr(SlaughterModeAddress), @MaxSlaughterValue, 4, write);
end;

procedure TThePunisher.StylePointsClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    StylePointsValue:=$2710;
    WriteProcessMemory(HandleWindow, ptr(StylePointsAddress), @StylePointsValue, 4, write);
end;

procedure TThePunisher.Timer1Timer(Sender: TObject);
begin
if (GetAsyncKeyState($71) <> 0) then
if BlackAndWhite.Font.Color=clRed then
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    BlackAndWhite.Font.Color:=clGreen;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    BlackAndWhiteValue:=$1;
    WriteProcessMemory(HandleWindow, ptr(BWModeAddress), @BlackAndWhiteValue, 4, write);
end
else
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    BlackAndWhite.Font.Color:=clRed;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    BlackAndWhiteValue:=$0;
    WriteProcessMemory(HandleWindow, ptr(BWModeAddress), @BlackAndWhiteValue, 4, write);
end;
end;

procedure TThePunisher.UnlimHealthTimerTimer(Sender: TObject);
begin
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    UnlimitedHealth.Font.Color:=clGreen;
    PatchMem2(GetGameProcessID(GameProc), MainHealthAddress, FreezeHealth, sizeof(FreezeHealth));
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    UnlimitedHealthON:=$101;
    WriteProcessMemory(HandleWindow, ptr(HealthAddress), @UnlimitedHealthON, 4, write);
end;

procedure TThePunisher.UnlimitedAmmoClick(Sender: TObject);
begin
Checker;
    If WindowName = 0 then
    exit;
    UnlimitedAmmo.Font.Color:=clGreen;
    PatchMem2(GetGameProcessID(GameProc), AmmoAddress1, FreezeAmmo, sizeof(FreezeAmmo));
    PatchMem2(GetGameProcessID(GameProc), AmmoAddress2, FreezeAmmo, sizeof(FreezeAmmo));
    PatchMem2(GetGameProcessID(GameProc), AmmoAddress3, FreezeAmmo, sizeof(FreezeAmmo));
    PatchMem2(GetGameProcessID(GameProc), AmmoAddress4, FreezeAmmo, sizeof(FreezeAmmo));
end;

procedure TThePunisher.UnlimitedAmmoDblClick(Sender: TObject);
begin
Checker;
    If WindowName = 0 then
    exit;
    UnlimitedAmmo.Font.Color:=clRed;
    PatchMem2(GetGameProcessID(GameProc), AmmoAddress1, Ammo, Length(Ammo));
    PatchMem2(GetGameProcessID(GameProc), AmmoAddress2, Ammo, Length(Ammo));
    PatchMem2(GetGameProcessID(GameProc), AmmoAddress3, Ammo, Length(Ammo));
    PatchMem2(GetGameProcessID(GameProc), AmmoAddress4, Ammo, Length(Ammo));
end;

procedure TThePunisher.UnlimitedHealthClick(Sender: TObject);
begin
Checker;
UnlimHealthTimer.Enabled:=true;
end;

procedure TThePunisher.UnlimitedHealthDblClick(Sender: TObject);
begin
Checker;
UnlimHealthTimer.Enabled:=false;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    UnlimitedHealth.Font.Color:=clRed;
    PatchMem2(GetGameProcessID(GameProc), MainHealthAddress, Health, Length(Health));
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    UnlimitedHealthOFF:=$100;
    WriteProcessMemory(HandleWindow, ptr(HealthAddress), @UnlimitedHealthOFF, 4, write);
end;

procedure TThePunisher.UpgradePointsClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    UpgradePointsValue:=$186A0;
    WriteProcessMemory(HandleWindow, ptr(UpgradePointsAddress), @UpgradePointsValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(UpgradePointsVisualAddress), @UpgradePointsValue, 4, write);
end;

procedure TThePunisher.FragGrenadeClick(Sender: TObject);
begin
Checker;
    WindowName := FindWindow(nil,GameCap);
    If WindowName = 0 then
    exit;
    ThreadId := GetWindowThreadProcessId(WindowName,@ProcessId);
    HandleWindow := OpenProcess(PROCESS_ALL_ACCESS,False,ProcessId);
    ThrownWeaponCountValue:=$9;
    ThrownWeaponObjectCreateValue:=$101;
    ThrownWeaponTypeValue:=$1E;
    ThrownWeaponVisibilityOfCountValue:=$FFFFFFFF;
    ThrownWeaponVisibilityOfTypeValue:=$1;
    ThrownWeaponGetFlagValue:=$0;
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponCountAddress), @ThrownWeaponCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponObjectCreateAddress), @ThrownWeaponObjectCreateValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponTypeAddress), @ThrownWeaponTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfCountAddress), @ThrownWeaponVisibilityOfCountValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponVisibilityOfTypeAddress), @ThrownWeaponVisibilityOfTypeValue, 4, write);
    WriteProcessMemory(HandleWindow, ptr(ThrownWeaponGetFlagAddress), @ThrownWeaponGetFlagValue, 4, write);
end;

procedure TThePunisher.FreezeTimerClick(Sender: TObject);
begin
Checker;
    If WindowName = 0 then
    exit;
FreezeTimer.Font.Color:=clGreen;
PatchMem2(GetGameProcessID(GameProc), TimerAddress, FreezeTime, sizeof(FreezeTime));
end;

procedure TThePunisher.FreezeTimerDblClick(Sender: TObject);
begin
Checker;
    If WindowName = 0 then
    exit;
FreezeTimer.Font.Color:=clRed;
PatchMem2(GetGameProcessID(GameProc), TimerAddress, Time, Length(Time));
end;

end.
