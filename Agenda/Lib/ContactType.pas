unit ContactType;

interface

type _Ver = record
   Major : Byte;
   Minor : Byte;
end;

type _Name = record
   FirstName : String[50];
   LastName  : String[25];
   BirthName : String[25];
end;

type _Date = record
   Year      : Integer;
   Month     : Integer;
   Day       : Integer;
   Noticed   : Boolean;
   LastAlarm : Integer;
end;

type _Relative = record
   R1  : _Name;
   R2  : _Name;
   R3  : _Name;
   R4  : _Name;
   R5  : _Name;
   R6  : _Name;
   R7  : _Name;
   R8  : _Name;
   R9  : _Name;
   R10 : _Name;
   R11 : _Name;
   R12 : _Name;
   R13 : _Name;
end;

type _Location = record
   Country : String[20];
   County  : String[30];
   City    : String[50];
   ZIP     : String[10];
end;

type _Address = record
   Address  : String[255];
   Location : _Location;
   Phone1   : String[15];
   Phone2   : String[15];
end;

type _Work = record
   Company : String[50];
   Job     : String[50];
   Phone   : String[20];
end;

type _PhoneRec = record
   Number : String[15];
   Info   : String[25];
end;

type _Phone = record
   phone1  : _PhoneRec;
   phone2  : _PhoneRec;
   phone3  : _PhoneRec;
   phone4  : _PhoneRec;
   phone5  : _PhoneRec;
   phone6  : _PhoneRec;
   phone7  : _PhoneRec;
   phone8  : _PhoneRec;
   phone9  : _PhoneRec;
   phone10 : _PhoneRec;
end;

type _Account = record
   kind  : String[20];
   email : String[50];
   id    : String[50];
   chat  : String[50];
   web   : String[50];
end;

type _NetContact = record
   contact1  : _Account;
   contact2  : _Account;
   contact3  : _Account;
   contact4  : _Account;
   contact5  : _Account;
   contact6  : _Account;
   contact7  : _Account;
   contact8  : _Account;
   contact9  : _Account;
   contact10 : _Account;
   contact11 : _Account;
   contact12 : _Account;
   contact13 : _Account;
   contact14 : _Account;
   contact15 : _Account;
   contact16 : _Account;
   contact17 : _Account;
   contact18 : _Account;
   contact19 : _Account;
   contact20 : _Account;
end;

type _School = record
   Name   : String[255];
   Spec   : String[255];
   Origin : String[255];
end;

type ContactSheet = record
   Version       : _Ver;
   Name          : _Name;
   PNC           : String[13];    // absent
   IDC           : String[23];    // absent
   DriverLic     : String[23];    // absent
   Gender        : Integer;
   Father        : _Name;
   Mother        : _Name;
   Partner       : _Name;
   Sister        : _Relative;     // absent
   Brother       : _Relative;     // absent
   Child         : _Relative;     // absent
   Title         : String[25];
   Suffix        : String[20];
   Nickname      : String[25];
   BirthDate     : _Date;
   Sign          : Integer;
   BirthPlace    : _Location;
   DeathDate     : _Date;
   DeathPlace    : _Location;
   MartialStatus : Integer;
   Anniversary   : _Date;
   Acuainted     : String[255];   // absent
   BloodType     : Integer;       // absent
   Eyes          : Integer;       // absent
   Height        : Integer;       // absent
   Weight        : Integer;       // absent
   Etny          : Integer;       // absent
   Religion      : Integer;       // absent
   AddressH      : _Address;
   Phone         : _Phone;        // absent
   Contact       : _NetContact;   // absent
   School        : _School;       // absent
   HighSchool    : _School;       // absent
   Colegue       : _School;       // absent
   Faculty1      : _School;       // absent
   Faculty2      : _School;       // absent
   Faculty3      : _School;       // absent
   Category      : String[23];    // absent
end;



implementation

end.
