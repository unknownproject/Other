unit Addon;

interface

uses
  Classes,Main;

type
  BotThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure ExecuteTimer;
  end;

implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure BotThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ BotThread }
procedure BotThread.ExecuteTimer;
begin

end;

procedure BotThread.Execute;
begin
  Synchronize(ExecuteTimer);
end;

end.
