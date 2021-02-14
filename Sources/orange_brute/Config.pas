unit Config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RbDrawCore, RbButton, inifiles;

type
  TForm2 = class(TForm)
    RbButton1: TRbButton;
    RbButton2: TRbButton;
    RbButton3: TRbButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    GroupBox2: TGroupBox;
    Edit8: TEdit;
    Edit9: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    RadioButton3: TRadioButton;
    Edit10: TEdit;
    RadioButton4: TRadioButton;
    Edit11: TEdit;
    Edit12: TEdit;
    procedure RbButton2Click(Sender: TObject);
    procedure RbButton1Click(Sender: TObject);
    procedure RbButton3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.RadioButton1Click(Sender: TObject);
begin
  Edit8.Enabled := True;
  Edit9.Enabled := False;
  Edit10.Enabled := False;
  Edit11.Enabled := False;
  Edit12.Enabled := False;
end;

procedure TForm2.RadioButton2Click(Sender: TObject);
begin
  Edit9.Enabled := True;
  Edit8.Enabled := False;
  Edit10.Enabled := False;
  Edit11.Enabled := False;
  Edit12.Enabled := True;
end;

procedure TForm2.RadioButton3Click(Sender: TObject);
begin
  Edit10.Enabled := True;
  Edit8.Enabled := False;
  Edit9.Enabled := False;
  Edit11.Enabled := False;
  Edit12.Enabled := False;
end;

procedure TForm2.RadioButton4Click(Sender: TObject);
begin
  Edit11.Enabled := True;
  Edit8.Enabled := False;
  Edit9.Enabled := False;
  Edit10.Enabled := False;
  Edit12.Enabled := False;
end;

procedure TForm2.RbButton1Click(Sender: TObject);
var
  Ini: Tinifile;
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  OpenDialog1.Filter := 'Ini files (*.ini)|*.ini';
  if OpenDialog1.Execute then
  begin
    Ini := Tinifile.Create(OpenDialog1.FileName);
    Edit1.Text := Ini.ReadString('Page', 'Path', Edit1.Text);
    Edit2.Text := Ini.ReadString('Parameters', 'Username', Edit2.Text);
    Edit3.Text := Ini.ReadString('Parameters', 'Password', Edit3.Text);
    Edit4.Text := Ini.ReadString('Parameters', 'Additional1', Edit4.Text);
    Edit5.Text := Ini.ReadString('Parameters', 'Additional2', Edit5.Text);
    Edit6.Text := Ini.ReadString('Parameters', 'Additional3', Edit6.Text);
    Edit7.Text := Ini.ReadString('Parameters', 'Additional4', Edit7.Text);
    Edit8.Text := Ini.ReadString('Identification', 'GoodKeyword', Edit8.Text);
    Edit9.Text := Ini.ReadString('Identification', 'BadKeyword1', Edit9.Text);
    Edit12.Text := Ini.ReadString('Identification', 'BadKeyword2', Edit12.Text);
    Edit10.Text := Ini.ReadString('Identification', 'SetCookieFailed',
      Edit10.Text);
    Edit11.Text := Ini.ReadString('Identification', 'SetCookieSuccess',
      Edit11.Text);
    if Edit8.Text <> '' then
      RadioButton1.Checked := True
    else if Edit9.Text <> '' then
      RadioButton2.Checked := True
    else if Edit10.Text <> '' then
      RadioButton3.Checked := True
    else if Edit11.Text <> '' then
      RadioButton4.Checked := True;
    Ini.Free;
  end;
end;

procedure TForm2.RbButton2Click(Sender: TObject);
begin
  Form2.close;
end;

procedure TForm2.RbButton3Click(Sender: TObject);
var
  Ini: Tinifile;
begin
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  SaveDialog1.Filter := 'Ini files (*.ini)|*.ini';
  if SaveDialog1.Execute then
  begin
    Ini := Tinifile.Create(SaveDialog1.FileName);
    Ini.WriteString('Page', 'Path', Edit1.Text);
    Ini.WriteString('Parameters', 'Username', Edit2.Text);
    Ini.WriteString('Parameters', 'Password', Edit3.Text);
    Ini.WriteString('Parameters', 'Additional1', Edit4.Text);
    Ini.WriteString('Parameters', 'Additional2', Edit5.Text);
    Ini.WriteString('Parameters', 'Additional3', Edit6.Text);
    Ini.WriteString('Parameters', 'Additional4', Edit7.Text);
    Ini.WriteString('Identification', 'GoodKeyword', Edit8.Text);
    Ini.WriteString('Identification', 'BadKeyword1', Edit9.Text);
    Ini.WriteString('Identification', 'BadKeyword2', Edit12.Text);
    Ini.WriteString('Identification', 'SetCookieFailed', Edit10.Text);
    Ini.WriteString('Identification', 'SetCookieSuccess', Edit11.Text);
    Ini.Free;
  end;
end;

end.
