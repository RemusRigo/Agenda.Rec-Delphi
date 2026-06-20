unit WndContact;

interface

//-------------------------------------------------------------------------------------------------

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
   ComCtrls, StdCtrls, Buttons, ExtCtrls, ExtDlgs,
   ZLib, ContactType;

//-------------------------------------------------------------------------------------------------

type _FormMode=(fmNew, fmEdit, fmView);

//-------------------------------------------------------------------------------------------------

type TfrmContact = class(TForm)
   // Caption
   pnlCaption        : TPanel;
   bbtnClose         : TBitBtn;

   pgCtrlContact     : TPageControl;

   //Main
   tsMain            : TTabSheet;

   grpName           : TGroupBox;
   lblFirstName      : TLabel;
   edFirstName       : TEdit;
   lblBirthName      : TLabel;
   edBirthName       : TEdit;
   lblLastName       : TLabel;
   edLastName        : TEdit;
   lblTitle          : TLabel;
   edTitle           : TEdit;
   lblSuffix         : TLabel;
   edSuffix          : TEdit;
   lblNickname       : TLabel;
   edNickname        : TEdit;

   grpBirth          : TGroupBox;
   lblBirthDate      : TLabel;
   lblBirthD         : TLabel;
   edBirthD          : TEdit;
   lblBirthM         : TLabel;
   edBirthM          : TEdit;
   lblBirthY         : TLabel;
   edBirthY          : TEdit;
   lblSign           : TLabel;
   cbSign            : TComboBox;
   lblGender         : TLabel;
   cbGender          : TComboBox;
   lblBirthCountry   : TLabel;
   edBirthCountry    : TEdit;
   lblBirthCounty    : TLabel;
   edBirthCounty     : TEdit;
   lblBirthCity      : TLabel;
   edBirthCity       : TEdit;

   grpBoxDeath       : TGroupBox;
   lblDeathDate      : TLabel;
   lblDeathD         : TLabel;
   edDeathD          : TEdit;
   lblDeathM         : TLabel;
   edDeathM          : TEdit;
   edDeathY          : TEdit;
   lblDeathY         : TLabel;
   lblDeathCountry   : TLabel;
   edDeathCountry    : TEdit;
   lblDeathCounty    : TLabel;
   edDeathCounty     : TEdit;
   lblDeathCity      : TLabel;
   edDeathCity       : TEdit;

   pnlImage          : TPanel;
   imgProfile        : TImage;

   //Personal
   tsPersonal        : TTabSheet;

   grpFather         : TGroupBox;
   lblFFirstName     : TLabel;
   edFFirstName      : TEdit;
   lblFBirthName     : TLabel;
   edFBirthName      : TEdit;
   lblFLastName      : TLabel;
   edFLastName       : TEdit;

   grpMother         : TGroupBox;
   lblMFirstName     : TLabel;
   edMFirstName      : TEdit;
   lblMBirthName     : TLabel;
   edMBirthName      : TEdit;
   lblMLastName      : TLabel;
   edMLastName       : TEdit;

   grpAddress        : TGroupBox;
   lblHAAddress      : TLabel;
   edHAAddress       : TEdit;
   lblHACountry      : TLabel;
   edHACountry       : TEdit;
   lblHACounty       : TLabel;
   edHACounty        : TEdit;
   lblHACity         : TLabel;
   edHACity          : TEdit;
   lblHAZip          : TLabel;
   edHAZip           : TEdit;
   lblHAPhone1       : TLabel;
   edHAPhone1        : TEdit;
   lblHAPhone2       : TLabel;
   edHAPhone2        : TEdit;

   grpMartialStatus  : TGroupBox;
   cbMartialStatus   : TComboBox;
   grpAnniv          : TGroupBox;
   lblAnnivD         : TLabel;
   edAnnivD          : TEdit;
   lblAnnivM         : TLabel;
   edAnnivM          : TEdit;
   lblAnnivY         : TLabel;
   edAnnivY          : TEdit;

   grpPartner        : TGroupBox;
   lblPFirstName     : TLabel;
   edPFirstName      : TEdit;
   lblPBirthName     : TLabel;
   edPBirthName      : TEdit;
   lblPLastName      : TLabel;
   edPLastName       : TEdit;

   grpPhone          : TGroupBox;
   lblPhone          : TLabel;
   lblPhoneInfo      : TLabel;
   edPhone1          : TEdit;
   edPhoneInfo1      : TEdit;
   edPhone2          : TEdit;
   edPhoneInfo2      : TEdit;
   edPhone3          : TEdit;
   edPhoneInfo3      : TEdit;
   edPhone4          : TEdit;
   edPhoneInfo4      : TEdit;
   edPhone5          : TEdit;
   edPhoneInfo5      : TEdit;
   edPhone6          : TEdit;
   edPhoneInfo6      : TEdit;

   // Contact
   tsContact         : TTabSheet;

   // Notes
   tsNotes           : TTabSheet;
   memoNotes         : TMemo;

   dlgOpenPic        : TOpenPictureDialog;
   dlgSave           : TSaveDialog;
   lblFileName       : TLabel;
   edFileName        : TEdit;
   bbtnOK            : TBitBtn;
    pnlID: TPanel;
    edPNC: TEdit;
    lblPNC: TLabel;
    edIDC: TEdit;
    lblIDC: TLabel;
    tsMisc: TTabSheet;
    lblAcuainted: TLabel;
    edAcuainted: TEdit;

   procedure pnlCaptionMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
   procedure bbtnOKClick(Sender: TObject);
   procedure bbtnCloseClick(Sender: TObject);
   procedure FormShow(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   private
      fs  : TStream;
      cs  : TCompressionStream;
      ds  : TDecompressionStream;
      id  : ContactSheet;
   public
      srcPK  : String;
      srcID  : String;
      srcNFO : String;
      path   : String;
      crtLng : String;
      fm     : _FormMode;
      procedure LoadLanguage;
      procedure LoadContact;
      procedure SaveContact;
end;

//-------------------------------------------------------------------------------------------------

var
   frmContact : TfrmContact;

//-------------------------------------------------------------------------------------------------

implementation

uses
   WndAgenda, libUtil, libPK, libFiles, INIFiles;

{$R *.dfm}

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.LoadLanguage;
var
   iniLng : TINIFile;
begin
   iniLng:=TiniFile.Create(path+'\Language\'+crtLng);

   // Main
   tsMain.Caption:=iniLng.ReadString('Language', 'Main', 'Main');

   grpName.Caption:=iniLng.ReadString('Language', 'Name', 'Name');
   lblFirstName.Caption:=iniLng.ReadString('Language', 'FirstName', 'First Name');
   lblBirthName.Caption:=iniLng.ReadString('Language', 'BirthName', 'Birth Name');
   lblLastName.Caption:=iniLng.ReadString('Language', 'LastName', 'Last Name');

   grpBirth.Caption:=iniLng.ReadString('Language', 'Birth', 'Birth');
   lblBirthDate.Caption:=iniLng.ReadString('Language', 'Date', 'Date');
   lblBirthCountry.Caption:=iniLng.ReadString('Language', 'Country', 'Country');
   lblBirthCounty.Caption:=iniLng.ReadString('Language', 'County', 'County');
   lblBirthCity.Caption:=iniLng.ReadString('Language', 'City', 'City');
   lblBirthD.Caption:=iniLng.ReadString('Language', 'DD', 'DD');
   lblBirthM.Caption:=iniLng.ReadString('Language', 'MM', 'MM');
   lblBirthY.Caption:=iniLng.ReadString('Language', 'YYYY', 'YYYY');
   lblSign.Caption:=iniLng.ReadString('Language', 'Sign', 'Sign');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign1', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign2', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign3', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign4', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign5', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign6', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign7', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign8', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign9', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign10', 'Libra'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign11', 'Sign1'));
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign12', 'Sign1'));
   lblGender.Caption:=iniLng.ReadString('Language', 'Gender', 'Gender');
   cbGender.Items.Add(iniLng.ReadString('Language', 'Male', 'Male'));
   cbGender.Items.Add(iniLng.ReadString('Language', 'Female', 'Female'));

   grpBoxDeath.Caption:=iniLng.ReadString('Language', 'Death', 'Death');
   lblDeathDate.Caption:=iniLng.ReadString('Language', 'Date', 'Date');
   lblDeathCountry.Caption:=iniLng.ReadString('Language', 'Country', 'Country');
   lblDeathCounty.Caption:=iniLng.ReadString('Language', 'County', 'County');
   lblDeathCity.Caption:=iniLng.ReadString('Language', 'City', 'City');
   lblDeathD.Caption:=iniLng.ReadString('Language', 'DD', 'DD');
   lblDeathM.Caption:=iniLng.ReadString('Language', 'MM', 'MM');
   lblDeathY.Caption:=iniLng.ReadString('Language', 'YYYY', 'YYYY');

   // Personal
   tsPersonal.Caption:=iniLng.ReadString('Language', 'Personal', 'Personal');

   grpFather.Caption:=iniLng.ReadString('Language', 'Father', 'Father');
   lblFFirstName.Caption:=iniLng.ReadString('Language', 'FirstName', 'First Name');
   lblFBirthName.Caption:=iniLng.ReadString('Language', 'BirthName', 'Birth Name');
   lblFLastName.Caption:=iniLng.ReadString('Language', 'LastName', 'Last Name');

   grpMother.Caption:=iniLng.ReadString('Language', 'Mother', 'Mother');
   lblMFirstName.Caption:=iniLng.ReadString('Language', 'FirstName', 'First Name');
   lblMBirthName.Caption:=iniLng.ReadString('Language', 'BirthName', 'Birth Name');
   lblMLastName.Caption:=iniLng.ReadString('Language', 'LastName', 'Last Name');

   grpAddress.Caption:=iniLng.ReadString('Language', 'Address', 'Address');
   lblHACountry.Caption:=iniLng.ReadString('Language', 'Country', 'Country');
   lblHACounty.Caption:=iniLng.ReadString('Language', 'County', 'County');
   lblHACity.Caption:=iniLng.ReadString('Language', 'City', 'City');
   lblHAZip.Caption:=iniLng.ReadString('Language', 'Zip', 'Zip Code');
   lblHAPhone1.Caption:=iniLng.ReadString('Language', 'Phone', 'Phone')+' 1';
   lblHAPhone2.Caption:=iniLng.ReadString('Language', 'Phone', 'Phone')+' 2';

   grpMartialStatus.Caption:=iniLng.ReadString('Language', 'MartialStatus', 'Martial Status');
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'MartialStatus1', 'Single'));
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'MartialStatus2', 'Commited'));
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'MartialStatus3', 'Married'));
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'MartialStatus4', 'Divorced'));
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'MartialStatus5', 'Widow'));

   grpAnniv.Caption:=iniLng.ReadString('Language', 'Anniv', 'Anniversary');
   lblAnnivD.Caption:=iniLng.ReadString('Language', 'DD', 'DD');
   lblAnnivM.Caption:=iniLng.ReadString('Language', 'MM', 'MM');
   lblAnnivY.Caption:=iniLng.ReadString('Language', 'YYYY', 'YYYY');

   grpPartner.Caption:=iniLng.ReadString('Language', 'Partner', 'Partner');
   lblPFirstName.Caption:=iniLng.ReadString('Language', 'FirstName', 'First Name');
   lblPBirthName.Caption:=iniLng.ReadString('Language', 'BirthName', 'Birth Name');
   lblPLastName.Caption:=iniLng.ReadString('Language', 'LastName', 'Last Name');

   grpPhone.Caption:=iniLng.ReadString('Language', 'Phone', 'Phone');
   lblPhone.Caption:=iniLng.ReadString('Language', 'Phone', 'Phone');
   lblPhoneInfo.Caption:=iniLng.ReadString('Language', 'Desc', 'Description');

   // Contact
   tsContact.Caption:=iniLng.ReadString('Language', 'Contact', 'Contact');

   // Notes
   tsNotes.Caption:=iniLng.ReadString('Language', 'Notes', 'Notes');


   lblFileName.Caption:=iniLng.ReadString('Language', 'SaveAs', 'Save as')+' :';

   iniLng.Free;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.LoadContact;
var
   ver        : _Ver;
   memoStream : TStream;
begin
   srcID:=ChangeFileExt(srcPK, '.id');
   srcNFO:=ChangeFileExt(srcPK, '.bin');
   if fm=fmNew then
   begin

   end
   else
   begin
      DecompressFiles(path+'\Contacts\'+srcPK, path+'\Temp\');
      ver:=GetContactSheetVersion(path+'\Temp\'+srcID);
      if fm=fmEdit then
         Caption:='Edit Contact : '+srcPK
      else if fm=fmView then
         Caption:='View Contact : '+srcPK;

      Caption:='View Contact : '+srcPK+' .: {RecVer : '+IntToStr(ver.Major)+'.'+IntToStr(ver.Minor)+'} :.';
      pnlCaption.Caption:=Caption;
      edFileName.Text:=srcPK;
      fs:=TFileStream.Create(path+'\Temp\'+srcID, fmOpenRead);
      ds:=TDecompressionStream.Create(fs);
      ds.Position:=0;
      ds.Size:=sizeOf(ContactSheet);

      ds.ReadBuffer(id, sizeOf(ContactSheet));

      // Name
      edFirstName.Text:=id.Name.FirstName;
      edBirthName.Text:=id.Name.BirthName;
      edLastName.Text:=id.Name.LastName;

      edTitle.Text:=id.Title;
      edSuffix.Text:=id.Suffix;
      edNickname.Text:=id.Nickname;

      // BirthDate
      if id.BirthDate.Year=0 then
         edBirthY.Text:=''
      else
         edBirthY.Text:=IntToStr(id.BirthDate.Year);
      if id.BirthDate.Month=0 then
         edBirthM.Text:=''
      else
         edBirthM.Text:=IntToStr(id.BirthDate.Month);
      if id.BirthDate.Day=0 then
         edBirthD.Text:=''
      else
         edBirthD.Text:=IntToStr(id.BirthDate.Day);

      // Sign
      cbSign.ItemIndex:=id.Sign;

      // Gender
      cbGender.ItemIndex:=id.Gender;

      // BirthPlace
      edBirthCountry.Text:=id.BirthPlace.Country;
      edBirthCounty.Text:=id.BirthPlace.County;
      edBirthCity.Text:=id.BirthPlace.City;

      // Death
      if id.DeathDate.Year=0 then
         edDeathY.Text:=''
      else
         edDeathY.Text:=IntToStr(id.DeathDate.Year);
      if id.DeathDate.Month=0 then
         edDeathM.Text:=''
      else
         edDeathM.Text:=IntToStr(id.DeathDate.Month);
      if id.DeathDate.Day=0 then
         edDeathD.Text:=''
      else
         edDeathD.Text:=IntToStr(id.DeathDate.Day);
      edDeathCountry.Text:=id.DeathPlace.Country;
      edDeathCounty.Text:=id.DeathPlace.County;
      edDeathCity.Text:=id.DeathPlace.City;

      // ID
      edPNC.Text:=id.PNC;
      edIDC.Text:=id.IDC;

      // Father
      edFFirstName.Text:=id.Father.FirstName;
      edFBirthName.Text:=id.Father.BirthName;
      edFLastName.Text:=id.Father.LastName;

      // Mother
      edMFirstName.Text:=id.Mother.FirstName;
      edMBirthName.Text:=id.Mother.BirthName;
      edMLastName.Text:=id.Mother.LastName;

      // Home Address
      edHAAddress.Text:=id.AddressH.Address;
      edHACountry.Text:=id.AddressH.Location.Country;
      edHACounty.Text:=id.AddressH.Location.County;
      edHACity.Text:=id.AddressH.Location.City;
      edHAZip.Text:=id.AddressH.Location.ZIP;
      edHAAddress.Text:=id.AddressH.Address;
      edHAAddress.Text:=id.AddressH.Address;

      // Martial Status
      cbMartialStatus.ItemIndex:=id.MartialStatus;

      // Anniversary
      if id.Anniversary.Year=0 then
         edAnnivY.Text:=''
      else
         edAnnivY.Text:=IntToStr(id.Anniversary.Year);
      if id.Anniversary.Month=0 then
         edAnnivM.Text:=''
      else
         edAnnivM.Text:=IntToStr(id.Anniversary.Month);
      if id.Anniversary.Day=0 then
         edAnnivD.Text:=''
      else
         edAnnivD.Text:=IntToStr(id.Anniversary.Day);

      // Partner
      edPFirstName.Text:=id.Partner.FirstName;
      edPBirthName.Text:=id.Partner.BirthName;
      edPLastName.Text:=id.Partner.LastName;

      // Phone 1-6
      edPhone1.Text:=id.Phone.phone1.Number;
      edPhoneInfo1.Text:=id.Phone.phone1.Info;
      edPhone2.Text:=id.Phone.phone2.number;
      edPhoneInfo2.Text:=id.Phone.phone2.Info;
      edPhone3.Text:=id.Phone.phone3.number;
      edPhoneInfo3.Text:=id.Phone.phone3.Info;
      edPhone4.Text:=id.Phone.phone4.number;
      edPhoneInfo4.Text:=id.Phone.phone4.Info;
      edPhone5.Text:=id.Phone.phone5.number;
      edPhoneInfo5.Text:=id.Phone.phone5.Info;
      edPhone6.Text:=id.Phone.phone6.number;
      edPhoneInfo6.Text:=id.Phone.phone6.Info;

      edAcuainted.Text:=id.Acuainted;

      ds.Free;
      fs.Free;

      if FileExists(path+'\Temp\'+srcNFO) then
      begin
         memoStream:=TFileStream.Create(path+'\Temp\'+srcNFO, fmOpenReadWrite);
         memoNotes.Lines.LoadFromStream(memoStream);
         memoStream.Free;
      end;
   end;
   DeleteFilesFromPath(path+'\Temp\', '*.*');
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.SaveContact;
var
   inFiles    : TStringList;
   memoStream : TStream;
begin
   if edFileName.Text='' then
   begin
      ShowMessage('Enter file name to save record');
      Exit;
   end;

   if fm=fmView then
      Close
   else
   begin
      inFiles:=TStringList.Create;
      if fm=fmNew then
      begin
         // Record Version
         id.Version.Major:=2;
         id.Version.Minor:=1;
         srcID:=edFileName.Text+'.id';
         srcPK:=edFileName.Text+'.pk';
         srcNFO:=edFileName.Text+'.bin';
      end
      else
      begin
         srcNFO:=ChangeFileExt(srcID, '.bin');
      end;

      // Name
      id.Name.FirstName:=edFirstName.Text;
      id.Name.BirthName:=edBirthName.Text;
      id.Name.LastName:=edLastName.Text;

      id.Title:=edTitle.Text;
      id.Suffix:=edSuffix.Text;
      id.Nickname:=edNickname.Text;

      // BirthDay
      if edBirthD.Text<>'' then
         if StrToInt(edBirthD.Text)>0 then
            id.BirthDate.Day:=StrToInt(edBirthD.Text)
         else
            id.BirthDate.Day:=0;
      if edBirthM.Text<>'' then
         if StrToInt(edBirthM.Text)>0 then
            id.BirthDate.Month:=StrToInt(edBirthM.Text)
         else
            id.BirthDate.Month:=0;
      if edBirthY.Text<>'' then
         if StrToInt(edBirthY.Text)>0 then
            id.BirthDate.Year:=StrToInt(edBirthY.Text)
         else
            id.BirthDate.Year:=0;

      // Sign
      if cbSign.Text<>'' then
         id.Sign:=cbSign.ItemIndex
      else
         id.Sign:=-1;

      // Gender
      if cbGender.Text<>'' then
         id.Gender:=cbGender.ItemIndex
      else
         id.Gender:=-1;

      // BirthPlace
      id.BirthPlace.Country:=edBirthCountry.Text;
      id.BirthPlace.County:=edBirthCounty.Text;
      id.BirthPlace.City:=edBirthCity.Text;
      id.BirthPlace.ZIP:='';

      // DeathDate
      if edDeathY.Text<>'' then
         if StrToInt(edDeathY.Text)>0 then
            id.DeathDate.Year:=StrToInt(edDeathY.Text)
         else
            id.DeathDate.Year:=0;
      if edDeathM.Text<>'' then
         if StrToInt(edDeathM.Text)>0 then
            id.DeathDate.Month:=StrToInt(edDeathM.Text)
         else
            id.DeathDate.Month:=0;
      if edDeathD.Text<>'' then
         if StrToInt(edDeathD.Text)>0 then
            id.DeathDate.Day:=StrToInt(edDeathD.Text)
         else
            id.DeathDate.Day:=0;

      // DeathPlace
      id.DeathPlace.Country:=edDeathCountry.Text;
      id.DeathPlace.County:=edDeathCounty.Text;
      id.DeathPlace.City:=edDeathCity.Text;

      // ID
      id.PNC:=edPNC.Text;
      id.IDC:=edIDC.Text;

      // Father
      id.Father.FirstName:=edFFirstName.Text;
      id.Father.BirthName:=edFBirthName.Text;
      id.Father.LastName:=edFLastName.Text;

      // Mother
      id.Mother.FirstName:=edMFirstName.Text;
      id.Mother.BirthName:=edMBirthName.Text;
      id.Mother.LastName:=edMLastName.Text;

      // Home Address
      id.AddressH.Address:=edHAAddress.Text;
      id.AddressH.Location.Country:=edHACountry.Text;
      id.AddressH.Location.County:=edHACounty.Text;
      id.AddressH.Location.City:=edHACity.Text;
      id.AddressH.Location.ZIP:=edHAZip.Text;
      id.AddressH.Address:=edHAAddress.Text;
      id.AddressH.Address:=edHAAddress.Text;

      // MartialStatus
      if cbMartialStatus.Text<>'' then
         id.MartialStatus:=cbMartialStatus.ItemIndex
      else
         id.MartialStatus:=-1;      

      //Anniversary
      if edAnnivD.Text<>'' then
         if StrToInt(edAnnivD.Text)>0 then
            id.Anniversary.Day:=StrToInt(edAnnivD.Text)
         else
            id.Anniversary.Day:=0;
      if edAnnivM.Text<>'' then
         if StrToInt(edAnnivM.Text)>0 then
            id.Anniversary.Month:=StrToInt(edAnnivM.Text)
         else
            id.Anniversary.Month:=0;
      if edAnnivY.Text<>'' then
         if StrToInt(edAnnivY.Text)>0 then
            id.Anniversary.Year:=StrToInt(edAnnivY.Text)
         else
            id.Anniversary.Year:=0;

      // Partner
      id.Partner.FirstName:=edPFirstName.Text;
      id.Partner.BirthName:=edPBirthName.Text;
      id.Partner.LastName:=edPLastName.Text;

      // Phone 1-6
      id.Phone.phone1.number:=edPhone1.Text;
      id.Phone.phone1.Info:=edPhoneInfo1.Text;
      id.Phone.phone2.number:=edPhone2.Text;
      id.Phone.phone2.Info:=edPhoneInfo2.Text;
      id.Phone.phone3.number:=edPhone3.Text;
      id.Phone.phone3.Info:=edPhoneInfo3.Text;
      id.Phone.phone4.number:=edPhone4.Text;
      id.Phone.phone4.Info:=edPhoneInfo4.Text;
      id.Phone.phone5.number:=edPhone5.Text;
      id.Phone.phone5.Info:=edPhoneInfo5.Text;
      id.Phone.phone6.number:=edPhone6.Text;
      id.Phone.phone6.Info:=edPhoneInfo6.Text;

      id.Acuainted:=edAcuainted.Text;

      fs:=TFileStream.Create(path+'\Temp\'+srcID, fmCreate or fmOpenReadWrite);
      cs:=TCompressionStream.Create(clMax, fs);
      cs.WriteBuffer(id, SizeOf(ContactSheet));
      cs.Free;
      fs.Free;

      inFiles.Add(path+'\Temp\'+srcID);

      if memoNotes.Lines.Count<>0 then
      begin
         memoStream:=TFileStream.Create(path+'\Temp\'+srcNFO, fmOpenReadWrite or fmCreate);
         memoNotes.Lines.SaveToStream(memoStream);
         memoStream.Free;
         inFiles.Add(path+'\Temp\'+srcNFO);
      end;

      CompressFiles(inFiles, path+'\Contacts\'+srcPK);
      frmAgenda.LoadContacts;
   end;
   DeleteFilesFromPath(path+'\Temp\', '*.*');
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.pnlCaptionMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
   SC_DRAGMOVE = $F012;
begin
   if Button=mbLeft then
   begin
      ReleaseCapture;
      Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
   end;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.bbtnOKClick(Sender: TObject);
begin
   SaveContact;
   Close;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.bbtnCloseClick(Sender: TObject);
begin
   Close;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.FormShow(Sender: TObject);
begin
   LoadLanguage;
   LoadContact;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.FormCreate(Sender: TObject);
begin
   pgCtrlContact.ActivePageIndex:=0;
end;

//-------------------------------------------------------------------------------------------------

end.
