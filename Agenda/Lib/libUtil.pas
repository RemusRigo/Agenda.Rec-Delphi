unit libUtil;

interface

uses
   ContactType;

function GetContactSheetVersion(inFile : String) : _Ver;

implementation

uses
   Classes, SysUtils, ZLib, Dialogs;

function GetContactSheetVersion(inFile : String) : _Ver;
var
   fs  : TStream;
   ds  : TDeCompressionStream;
   str : String;
   ver : _Ver;
begin
   fs:=TFileStream.Create(inFile, fmOpenRead);
   ds:=TDeCompressionStream.Create(fs);
   SetString(str, nil, SizeOf(ContactSheet));
   ds.ReadBuffer(str[1], SizeOf(ContactSheet));
   ver.Major:=Byte(str[1]);
   ver.Minor:=Byte(str[2]);
   Result:=ver;
   ds.Free;
   fs.Free;
end;

end.
