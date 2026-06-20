program Agenda;

uses
  Forms, Dialogs,
  WndAgenda in 'Wnd\WndAgenda.pas' {frmAgenda},
  WndContact in 'Wnd\WndContact.pas' {frmContact},
  WndOptions in 'Wnd\WndOptions.pas' {frmOptions},
  ContactType in 'Lib\ContactType.pas',
  libUtil in 'Lib\libUtil.pas',
  libPK in 'Lib\libPK.pas',
  libFiles in 'Lib\libFiles.pas',
  WndAlarm in 'Wnd\WndAlarm.pas' {frmAlarm};

{$R *.res}

begin
   Application.Initialize;
   Application.Title := 'RRD : Agenda';
  if ParamCount=0 then
   begin
      Application.CreateForm(TfrmAgenda, frmAgenda);
  end
   else
   begin
      if ParamStr(1)='/alarm' then
         Application.CreateForm(TfrmAlarm, frmAlarm);
   end;
   Application.Run;
end.
