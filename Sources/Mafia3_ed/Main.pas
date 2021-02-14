unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, crc32, ComCtrls, Menus, Gauges;

type
  TMainForm = class(TForm)
    OpenDialog1: TOpenDialog;
    MoneyBox: TGroupBox;
    CheckSumBox: TGroupBox;
    ChecksumLabel: TLabel;
    ChecksumValue: TLabel;
    WalletLabel: TLabel;
    BankLabel: TLabel;
    WalletEdit: TMemo;
    BankEdit: TMemo;
    AmmoBox: TGroupBox;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Checksum1: TMenuItem;
    Get1: TMenuItem;
    Fix1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    HowToUse1: TMenuItem;
    Ammo1Label: TLabel;
    Ammo2Label: TLabel;
    Ammo1Edit: TMemo;
    Ammo2Edit: TMemo;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StatusLabel: TLabel;
    MedBox: TGroupBox;
    MedkitsEdit: TMemo;
    procedure Get1Click(Sender: TObject);
    procedure Fix1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure HowToUse1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  SaveGame: File of byte;
  CrcValue:dword;
  Wallet,Bank,Ammo1,Ammo2,Medkits,MoneyOffset,AmmoOffset:integer;
implementation

uses HTU, About;

{$R *.dfm}

procedure TMainForm.About1Click(Sender: TObject);
begin
  AboutForm.Show;
end;

procedure TMainForm.Fix1Click(Sender: TObject);
var
  SaveGame: file of byte;
  NewCrc:integer;
begin
  if not Savedialog1.Execute then
  begin
    exit;
  end
  else
  begin
    AssignFile(SaveGame,OpenDialog1.FileName);
    Reset(SaveGame);
    Seek(SaveGame, FileSize(SaveGame)-4);
    NewCrc:=CrcValue;
    BlockWrite(SaveGame,NewCRC,4);
  end;
  CloseFile(SaveGame);
end;

procedure TMainForm.Get1Click(Sender: TObject);
var
  TotalBytes:TInteger8;
  error:word;
begin
  ChecksumValue.Caption:='00000000';
  if not OpenDialog2.Execute then
  begin
    exit;
  end
  else
  begin
    CalcFileCrc32(OpenDialog1.FileName,CrcValue,TotalBytes,error);
    ChecksumValue.Caption:=IntToHex(CrcValue,8);
  end;
end;


procedure TMainForm.HowToUse1Click(Sender: TObject);
begin
  HTUForm.Show;
end;

procedure TMainForm.Open1Click(Sender: TObject);
var
  i,j,CurrentOffset,CurrentOffset2: integer;
  MoneySignBuf: array [0..12] of char;
  AmmoSignBuf: array [0..11] of char;
begin
  Ammo1Edit.text:='00000000';
  Ammo2Edit.text:='00000000';
  MedkitsEdit.Text:='00000000';
  WalletEdit.text:='00000000';
  BankEdit.Text:='00000000';
  Wallet:=0;
  Bank:=0;
  MoneySignBuf:='';
  AmmoSignBuf:='';
  CurrentOffset:=0;
  MoneyOffset:=0;
//  CurrentOffset2:=0;
  AmmoOffset:=0;
  StatusLabel.Caption:='Status: Iddle';
if not Opendialog1.Execute then
begin
  WalletEdit.Enabled:=False;
  BankEdit.Enabled:=False;
  Ammo1Edit.Enabled:=False;
  MedkitsEdit.Enabled:=False;
  Ammo2Edit.Enabled:=False;
  Save1.Enabled:=False;
  Open1.Enabled:=True;
  Get1.Enabled:=False;
  Fix1.Enabled:=False;
  exit;
end
else
begin
  Save1.Enabled:=True;
  Open1.Enabled:=False;
  Get1.Enabled:=True;
  Fix1.Enabled:=True;
  AssignFile(SaveGame, Opendialog1.FileName);
  Reset(SaveGame);
//  CopyFile(PAnsiChar(OpenDialog1.Filename),PAnsiChar(OpenDialog1.Filename+'.bak'),true);
  CopyFile(PAnsiChar(OpenDialog1.Filename),PAnsiChar(OpenDialog1.Filename+'.bak'),false);
  StatusLabel.Caption:='Status: Reading';   
for i := 0 to FileSize(SaveGame) - 1 do
begin
 try
   Application.ProcessMessages;
   Seek(SaveGame,CurrentOffset);
   BlockRead(SaveGame,MoneySignBuf,13);
   if Pos('m_WalletValue',MoneySignBuf) <> 0 then
   begin
//     ShowMessage(IntToHex(CurrentOffset,8));
     MoneyOffset:=CurrentOffset;
     break;
   end;
   inc(CurrentOffset,4);
 except
 end;
 end;
 end;
 CurrentOffset2:=CurrentOffset;
 for j := 0 to FileSize(SaveGame) - 1 do
 begin
 try
   Application.ProcessMessages;
   Seek(SaveGame,CurrentOffset2);
   BlockRead(SaveGame,AmmoSignBuf,12);
 if Pos('m_AmmoInWeap',AmmoSignBuf) <> 0 then
 begin
//   ShowMessage(IntToHex(CurrentOffset2,8));
   AmmoOffset:=CurrentOffset2;
   break;
 end;
   inc(CurrentOffset2,1);
 except
 end;
 end;
 Seek(SaveGame,MoneyOffset+94); //деньги в кошельке
 BlockRead(SaveGame,Wallet,4);
 WalletEdit.Text:=IntToStr(Wallet);
 Seek(SaveGame,MoneyOffset+110);
 BlockRead(SaveGame,Bank,4);
 bankEdit.Text:=IntToStr(Bank);
//////////////////////////////////
 Seek(SaveGame,AmmoOffset+219);   //аммуниция
 BlockRead(SaveGame,Ammo1,4);
 Ammo1Edit.text:=IntToStr(Ammo1);
 Seek(SaveGame,AmmoOffset+479);
 BlockRead(SaveGame,Ammo2,4);
 Ammo2Edit.text:=IntToStr(Ammo2);
 Seek(SaveGame,AmmoOffset+690);
 BlockRead(SaveGame,Medkits,4);
 MedkitsEdit.text:=IntToStr(Medkits);
 WalletEdit.Enabled:=True;
 BankEdit.Enabled:=True;
 Ammo1Edit.Enabled:=True;
 Ammo2Edit.Enabled:=True;
 MedkitsEdit.Enabled:=True;
 StatusLabel.Caption:='Status: Done'; 
 end;

procedure TMainForm.Save1Click(Sender: TObject);
var
  NewWallet,NewBank,NewAmmo1,NewAmmo2,NewMedkits:integer;
begin
//////////////////////////////////
 Seek(SaveGame,MoneyOffset+94); //деньги в кошельке
 NewWallet:=StrToInt(WalletEdit.Text);
 if NewWallet=Wallet then
 begin
 //не делаем ничего
 end
 else
 BlockWrite(SaveGame,NewWallet,4);
//////////////////////////////////
 Seek(SaveGame,MoneyOffset+110);
 NewBank:=StrToInt(BankEdit.Text);
 if NewBank=Bank then
 begin
 //
 end
 else
 BlockWrite(SaveGame,NewBank,4);
 //////////////////////////////////
 Seek(SaveGame,AmmoOffset+219);   //аммуниция
 NewAmmo1:=StrToInt(Ammo1Edit.text);
 if NewAmmo1=Ammo1 then
 begin
 //
 end
 else
 BlockWrite(SaveGame,NewAmmo1,4);
 //////////////////////////////////
 Seek(SaveGame,AmmoOffset+479);
 NewAmmo2:=StrToInt(Ammo2Edit.text);
 if NewAmmo2=Ammo2 then
 begin
 //
 end
 else
 BlockWrite(SaveGame,NewAmmo2,4);
 //////////////////////////////////
 Seek(SaveGame,AmmoOffset+690);
 NewMedkits:=StrToInt(MedkitsEdit.text);
 if NewMedkits=Medkits then
 begin
 //
 end
 else
 BlockWrite(SaveGame,NewMedkits,4);
 CloseFile(SaveGame);
 WalletEdit.Enabled:=False;
 BankEdit.Enabled:=False;
 Ammo1Edit.Enabled:=False;
 Ammo2Edit.Enabled:=False;
 MedkitsEdit.Enabled:=False;
 Save1.Enabled:=False;
 Open1.Enabled:=True;
 StatusLabel.Caption:='Status: Iddle';
end;

end.
