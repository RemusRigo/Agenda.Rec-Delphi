unit WndOptions;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, ExtCtrls, StdCtrls, Buttons,
   Registry;

//-------------------------------------------------------------------------------------------------

type TfrmOptions = class(TForm)
   pnlOptions       : TPanel;
   grpBoxLanguage   : TGroupBox;
   comboBoxLanguage : TComboBox;
   bbtnOk           : TBitBtn;
   procedure bbtnOkClick(Sender: TObject);
   procedure FormShow(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
   public
      path   : String;
      regKey : TRegistry;
      crtLng : String;
end;

//-------------------------------------------------------------------------------------------------

var
   frmOptions : TfrmOptions;

//-------------------------------------------------------------------------------------------------

implementation

uses
   WndAgenda;

{$R *.dfm}

//-------------------------------------------------------------------------------------------------

procedure TfrmOptions.bbtnOkClick(Sender: TObject);
begin
   regKey.WriteString('Language', comboBoxLanguage.Items.Strings[comboBoxLanguage.ItemIndex]);
   frmAgenda.LoadLanguage;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmOptions.FormShow(Sender: TObject);
var
   sr  : TSearchRec;
begin
   comboBoxLanguage.Items.Add('English (default)');
   if FindFirst(path+'\Language\*.ini', faAnyFile-faDirectory, sr)=0 then
   begin
      repeat
         comboBoxLanguage.Items.Add(sr.Name);
      until FindNext(sr)<>0;
      FindClose(sr);
   end;
   comboBoxLanguage.ItemIndex:=comboBoxLanguage.Items.IndexOf(crtLng);
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
   regKey:=TRegistry.Create;
   regKey.RootKey:=HKEY_CURRENT_USER;
   regKey.OpenKey('Software\Remus Rigo Software\Agenda', TRUE);
   if regKey.ValueExists('Language') then
      crtLng:=regKey.ReadString('Language')
   else
      crtLng:='';
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   regKey.CloseKey;
   regKey.Free;
end;

//-------------------------------------------------------------------------------------------------

end.
