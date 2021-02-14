unit Settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSettingsForm = class(TForm)
    IntervalLabel: TLabel;
    OKButton: TButton;
    IntervalEdit: TMemo;
    FlooDInterval: TMemo;
    PickEdit: TMemo;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

procedure TSettingsForm.OKButtonClick(Sender: TObject);
begin
  SettingsForm.Hide;
end;

end.
