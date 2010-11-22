unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    tkol: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  filename:string;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
Filename:=OpenDialog1.FileName;
end;

procedure TForm1.Button2Click(Sender: TObject);
var i,p:integer;
    x,sum,dt,t:real;
    s:string;
    f,f2:textfile;
begin
if FileName<>'' then
 begin
   assignfile(f,filename);
   reset(f);
   assignfile(f2,ChangeFileExt(FileName,'.sum'));
   rewrite(f2);
   readln(f,s);
   decimalSeparator:='.';
   p:=pos('dt=',s);
   dt:=strtofloat(copy(s,p+3,10));
   dt:=dt*10;
   Insert(floattostr(dt),s,p+3);
   Delete(s,p+3+length(floattostr(dt)),length(s)-p+3+length(floattostr(dt)));
   writeln(f2,s);
   while not eof(f) do
    begin
     sum:=0;
     for i:=1 to 10 do
     if tkol.Checked then
      begin readln(f,t,x); sum:=sum+x;end else
      begin  readln(f,x); sum:=sum+x; end;
     if tkol.Checked then writeln(f2,t:10:5,sum:20:5)
      else writeln(f2,sum:10:5);
    end;
  closefile(f);
  closefile(f2);
 end;
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
openDialog1.InitialDir:=ExtractFilePAth(Application.ExeName);
end;

end.
