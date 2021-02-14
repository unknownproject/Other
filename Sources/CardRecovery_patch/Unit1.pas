unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, About,Registry;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    Button1: TButton;
    Image1: TImage;
    Button3: TButton;
    Label1: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
Division:Char;
MainProgrammFile:File of Byte;
RegistryPatch: TRegistry;
File_size: longint;
begin
Assignfile(MainProgrammFile,'CardRecovery.exe');
Reset(MainProgrammFile);
  if ioresult<>0 then
  label1.caption:='Not found'
  else
  begin
   File_Size:=filesize(MainProgrammFile);
   if File_Size<>1684744 then
   label1.caption:='Mismatch'
  else
  begin
   if checkbox1.checked=true then
   CopyFile('CardRecovery.exe','CardRecovery.exe.bak', true );
   Seek(MainProgrammFile,$0009D9B5);
   Division:=Char($74);
   Blockwrite(MainProgrammFile,Division,1);
   Seek(MainProgrammFile,$0009DE86);
   Division:=Char($74);
   Blockwrite(MainProgrammFile,Division,1);
   Seek(MainProgrammFile,$0009DF02);
   Division:=Char($74);
   Blockwrite(MainProgrammFile,Division,1);
   Seek(MainProgrammFile,$000A3430);
   Division:=Char($74);
   Blockwrite(MainProgrammFile,Division,1);
   Seek(MainProgrammFile,$000A4651);
   Division:=Char($85);
   Blockwrite(MainProgrammFile,Division,1);
   RegistryPatch:=TRegistry.Create;
   RegistryPatch.RootKey:=HKEY_CURRENT_USER;
   RegistryPatch.OpenKey('SOFTWARE\WinRecovery\CardRecovery',true);
   RegistryPatch.WriteString('KeyName','unknown project');
   RegistryPatch.WriteString('AffID','CARDRECOVERY');
   RegistryPatch.WriteString('Version','5.30.1206');
   RegistryPatch.WriteString('Key','Lamer detected ;D');
label1.caption:='Enjoy ;D';
   end;
  end;

  closefile(MainProgrammFile);

end;


procedure TForm1.Button3Click(Sender: TObject);
begin
Aboutbox.Show;
end;
end.
