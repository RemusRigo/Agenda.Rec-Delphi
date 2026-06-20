unit WndAgenda;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
   ContactType, ComCtrls, ToolWin, Menus, ImgList, ExtCtrls, StdCtrls,
   Buttons, ZLib, Registry, iniFiles;

type TfrmAgenda = class(TForm)
   tbMain            : TToolBar;
   tbBtnNew          : TToolButton;
   tbBtnView         : TToolButton;
   tbBtnEdit         : TToolButton;
   tbBtnSep1         : TToolButton;
   tbBtnOptions      : TToolButton;
   tbBtnSep2         : TToolButton;
   tbBtnExit         : TToolButton;
   tbBtnSep3         : TToolButton;
   tbBtnAbout        : TToolButton;
    lvContacts: TListView;
   pbLoading         : TProgressBar;
   StatusBar         : TStatusBar;
   imgLstTB          : TImageList;
   imgLstTBDisabled  : TImageList;
   imgLstTBHot       : TImageList;
   imgLstLVColSort   : TImageList;
   popColumn         : TPopupMenu;
   popColumn_Phone   : TMenuItem;
   popColumn_Mobile  : TMenuItem;
   popAction         : TPopupMenu;
   popAction_View    : TMenuItem;
   popAction_Edit    : TMenuItem;
   popAction_Delete  : TMenuItem;
    tbBtnListView: TToolButton;
    popListView: TPopupMenu;
    popListView_Details: TMenuItem;
    popListView_Icons: TMenuItem;
   procedure tbBtnNewClick(Sender: TObject);
   procedure tbBtnViewClick(Sender: TObject);
   procedure tbBtnEditClick(Sender: TObject);
   procedure tbBtnOptionsClick(Sender: TObject);
   procedure tbBtnExitClick(Sender: TObject);
   procedure lvContactsColumnClick(Sender: TObject; Column: TListColumn);
   procedure lvContactsColumnRightClick(Sender: TObject; Column: TListColumn; Point: TPoint);
   procedure lvContactsDblClick(Sender: TObject);
   procedure popAction_ViewClick(Sender: TObject);
   procedure popAction_EditClick(Sender: TObject);
   procedure popAction_DeleteClick(Sender: TObject);
   procedure FormCreate(Sender : TObject);
    procedure FormResize(Sender: TObject);
    procedure popListView_DetailsClick(Sender: TObject);
    procedure popListView_IconsClick(Sender: TObject);
   private
   public
      path        : String;
      crtLng      : String;
      cnt         : Integer;
      procedure ResizeColumns;
      procedure LoadLanguage;
      procedure CountContacts;
      procedure LoadContacts;
end;

var
   frmAgenda : TfrmAgenda;

implementation

uses
   libUtil, libPK, libFiles, WndContact, WndOptions;

{$R *.dfm}

var
   srtAsc         : Boolean;
   lastSortCol    : Integer;
   sContactsFound : String;

//-------------------------------------------------------------------------------------------------

function SortByColumn(Item1, Item2: TListItem; Data: integer): integer; stdcall;
begin
   if Data = 0 then
      Result:=AnsiCompareText(Item1.Caption, Item2.Caption)
   else
      Result:=AnsiCompareText(Item1.SubItems[Data-1], Item2.SubItems[Data-1]);
   if not srtAsc then
      Result:=-Result;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.lvContactsColumnClick(Sender: TObject; Column: TListColumn);
begin
   if lvContacts.Columns[Column.ID].ImageIndex=-1  then
      lvContacts.Columns[Column.ID].ImageIndex:=0
   else if lvContacts.Columns[Column.ID].ImageIndex=0 then
      lvContacts.Columns[Column.ID].ImageIndex:=1
   else if lvContacts.Columns[Column.ID].ImageIndex=1 then
      lvContacts.Columns[Column.ID].ImageIndex:=0;

   case Column.ID of

      0:
      begin
         lvContacts.Columns[1].ImageIndex:=-1;
         lvContacts.Columns[2].ImageIndex:=-1;
         lvContacts.Columns[3].ImageIndex:=-1;
      end;

      1:
      begin
         lvContacts.Columns[0].ImageIndex:=-1;
         lvContacts.Columns[2].ImageIndex:=-1;
         lvContacts.Columns[3].ImageIndex:=-1;
      end;

      2:
      begin
         lvContacts.Columns[0].ImageIndex:=-1;
         lvContacts.Columns[1].ImageIndex:=-1;
         lvContacts.Columns[3].ImageIndex:=-1;
      end;

      3:
      begin
         lvContacts.Columns[0].ImageIndex:=-1;
         lvContacts.Columns[1].ImageIndex:=-1;
         lvContacts.Columns[2].ImageIndex:=-1;
      end;
   end;
   if Column.Index=lastSortCol then
      srtAsc:=not srtAsc
   else
      lastSortCol:=Column.Index;
   TListView(Sender).CustomSort(@SortByColumn, Column.Index);
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.ResizeColumns;
var
   colW : Integer;
begin
   colW:=frmAgenda.ClientWidth div 3 - 1;
   lvContacts.Columns[0].Width:=colW;
   lvContacts.Columns[1].Width:=colW;
   lvContacts.Columns[2].Width:=colW;
   lvContacts.Columns[3].Width:=0;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.LoadLanguage;
var
   regKey     : Tregistry;
   iniLng     : TiniFile;
   frmOptions : TfrmOptions;
   lngFound   : Boolean;
begin
   lngFound:=True;
   regKey:=TRegistry.Create;
   regKey.RootKey:=HKEY_CURRENT_USER;
   if regKey.KeyExists('Software\Remus Rigo Software\Agenda') then
   begin
      regKey.OpenKeyReadOnly('Software\Remus Rigo Software\Agenda');
      if regKey.ValueExists('Language') then
      begin
         crtLng:=regKey.ReadString('Language');
         iniLng:=TiniFile.Create(path+'\Language\'+crtLng);

         tbBtnNew.Caption:=iniLng.ReadString('Language', 'New', 'New');
         tbBtnNew.Hint:=tbBtnNew.Caption;
         tbBtnView.Caption:=iniLng.ReadString('Language', 'View', 'View');
         tbBtnView.Hint:=tbBtnView.Caption;
         tbBtnEdit.Caption:=iniLng.ReadString('Language', 'Edit', 'Edit');
         tbBtnEdit.Hint:=tbBtnEdit.Caption;
         tbBtnOptions.Caption:=iniLng.ReadString('Language', 'Options', 'Options');
         tbBtnOptions.Hint:=tbBtnOptions.Caption;
         tbBtnAbout.Caption:=iniLng.ReadString('Language', 'About', 'About');
         tbBtnAbout.Hint:=tbBtnAbout.Caption;
         lvContacts.Column[0].Caption:=iniLng.ReadString('Language', 'FirstName', 'FirstName');
         lvContacts.Column[1].Caption:=iniLng.ReadString('Language', 'LastName', 'LastName');
         lvContacts.Column[2].Caption:=iniLng.ReadString('Language', 'BirthDate', 'BirthDate');
         lvContacts.Column[3].Caption:=iniLng.ReadString('Language', 'File', 'File');
         popAction_View.Caption:=iniLng.ReadString('Language', 'View', 'View');
         sContactsFound:=iniLng.ReadString('Language', 'ContactFound', 'Contacts found');
         iniLng.Free;
      end
      else
         lngFound:=False;
   end
   else
      lngFound:=False;

   if not lngFound then
   begin
      frmOptions:=TfrmOptions.Create(Self);
      frmOptions.path:=path;
      frmOptions.ShowModal;
      LoadLanguage;
      crtLng:='';
   end;
   
   regKey.CloseKey;
   regKey.Free;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.CountContacts;
var
   sr  : TSearchRec;
begin
   if FindFirst(path+'\Contacts\*.pk', faAnyFile-faDirectory, sr)=0 then
   begin
      repeat
         cnt:=cnt+1;
      until FindNext(sr)<>0;
      FindClose(sr);
   end;
   StatusBar.Panels[0].Text:=sContactsFound+' : '+IntToStr(cnt);
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.LoadContacts;
var
   sr  : TSearchRec;
   li  : TListItem;
   fs  : TStream;
   ds  : TDecompressionStream;
   id  : ContactSheet;
begin
   lvContacts.Items.Clear;
   pbLoading.Position:=0;
   pbLoading.Min:=0;
   CountContacts;
   pbLoading.Max:=cnt;
   DeleteFilesFromPath(path+'\Temp\', '*.*');
   if cnt<>0 then
   begin
      if FindFirst(path+'\Contacts\*.pk', faAnyFile-faDirectory, sr)=0 then
      begin
         repeat
            ResizeColumns;
            DecompressFiles(path+'\Contacts\'+sr.Name, path+'\Temp\');
            fs:=TFileStream.Create(path+'\Temp\'+ChangeFileExt(sr.Name, '.id'), fmOpenRead);
            ds:=TDecompressionStream.Create(fs);
            ds.ReadBuffer(id, sizeOf(ContactSheet));
            li:=lvContacts.Items.Add;
            li.Caption:=id.Name.FirstName;
            li.SubItems.Add(id.Name.LastName);
            li.SubItems.Add(IntToStr(id.BirthDate.Year)+
               '.'+IntToStr(id.BirthDate.Month)+'.'+IntToStr(id.BirthDate.Day));
            li.SubItems.Add(sr.Name);
            ds.Free;
            fs.Free;
            pbLoading.Position:=pbLoading.Position+1;
//            Application.ProcessMessages;
            DeleteFilesFromPath(path+'\Temp\', '*.*');
         until FindNext(sr)<>0;
         FindClose(sr);
      end;
      tbBtnView.Enabled:=True;
      tbBtnEdit.Enabled:=True;
   end
   else
   begin
      tbBtnView.Enabled:=False;
      tbBtnEdit.Enabled:=False;
   end;
   cnt:=0;
   lvContacts.CustomSort(@SortByColumn, 0);
   lvContacts.CustomSort(@SortByColumn, 1);
end;


//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.lvContactsColumnRightClick(Sender: TObject; Column: TListColumn; Point: TPoint);
var
   pt : TPoint;
begin
   ShowMessage(Sender.ClassName);
   case Column.ID of

      0:
      begin

      end;

      1:
      begin
      end;

      2:
      begin
         GetCursorPos(pt);
         popColumn.Popup(pt.X, pt.Y);
      end;

      3:
      begin
      end;

   end;
   lastSortCol:=Column.ID;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.tbBtnNewClick(Sender: TObject);
var
   frmNew  : TfrmContact;
begin
   frmNew:=TfrmContact.Create(Self);
   frmNew.fm:=fmNew;
   frmNew.path:=path;
   frmNew.crtLng:=crtLng;
   frmNew.Show;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.tbBtnViewClick(Sender: TObject);
var
   crtLine  : Integer;
   frmView  : TfrmContact;
begin
   frmView:=TfrmContact.Create(Self);
   crtLine:=lvContacts.Items.IndexOf(lvContacts.Selected);
   frmView.fm:=fmView;
   frmView.srcPK:=lvContacts.Items.Item[crtLine].SubItems.Strings[2];
   frmView.path:=path;
   frmView.crtLng:=crtLng;
   frmView.Show;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.tbBtnEditClick(Sender: TObject);
var
   crtLine  : Integer;
   frmEdit  : TfrmContact;
begin
   frmEdit:=TfrmContact.Create(Self);
   crtLine:=lvContacts.Items.IndexOf(lvContacts.Selected);
   frmEdit.fm:=fmEdit;
   frmEdit.srcPK:=lvContacts.Items.Item[crtLine].SubItems.Strings[2];
   frmEdit.path:=path;
   frmEdit.crtLng:=crtLng;
   frmEdit.Show;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.tbBtnOptionsClick(Sender: TObject);
var
   frmOptions : TfrmOptions;
begin
   frmOptions:=TfrmOptions.Create(Self);
   frmOptions.path:=path;
   frmOptions.ShowModal;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.tbBtnExitClick(Sender: TObject);
begin
   Application.Terminate;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.popAction_ViewClick(Sender: TObject);
begin
   tbBtnView.Click;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.popAction_EditClick(Sender: TObject);
begin
   tbBtnEdit.Click;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.popAction_DeleteClick(Sender: TObject);
var
   crtLine : Integer;
   delFile : String;
begin
   crtLine:=lvContacts.Items.IndexOf(lvContacts.Selected);
   delFile:=lvContacts.Items.Item[crtLine].SubItems.Strings[2];
   if MessageDlg('Do you want to delete the file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      if DeleteFile(path+'\Contacts\'+delFile) then
         LoadContacts;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.lvContactsDblClick(Sender: TObject);
begin
   tbBtnView.Click;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.FormCreate(Sender : TObject);
begin

   // initialize vars
   path:=ExtractFileDir(Application.ExeName);
   srtAsc:=True;
   lastSortCol:=-1;
   srtAsc:=True;
   lastSortCol:=-1;
   cnt:=0;

   // Check dirs
   if not DirectoryExists(path+'\Contacts') then
      CreateDirectory(PChar(path+'\Contacts'), nil);
   if not DirectoryExists(path+'\Language') then
      CreateDirectory(PChar(path+'\Language'), nil);
   if not DirectoryExists(path+'\Temp') then
      CreateDirectory(PChar(path+'\Temp'), nil);

   LoadLanguage;
   LoadContacts;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.FormResize(Sender: TObject);
begin
   ResizeColumns;
end;

procedure TfrmAgenda.popListView_DetailsClick(Sender: TObject);
begin
   lvContacts.ViewStyle:=vsReport;
end;

procedure TfrmAgenda.popListView_IconsClick(Sender: TObject);
begin
   lvContacts.ViewStyle:=vsIcon;
end;

end.
