unit libFiles;

interface

procedure DeleteFilesFromPath(path, mask : String);

implementation

uses
   SysUtils;

procedure DeleteFilesFromPath(path, mask : String);
var
   sr : TSearchRec;
begin
   if FindFirst(path+mask, faAnyFile-faDirectory, sr)=0 then
   begin
      repeat
         DeleteFile(path+sr.Name);
      until FindNext(sr)<>0;
      FindClose(sr);
   end;
end;

end.
