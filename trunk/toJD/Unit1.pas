unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,AstroUnit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    CheckBox2: TCheckBox;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
opendialog1.InitialDir:=ExtractFilePAth(Application.ExeName);
end;

procedure TForm1.Button1Click(Sender: TObject);
var f,f2:textfile;
    date,pd,pt,p,y,m,d,h,min,No:integer;
    dt,sec,UT,jDay,data:real;
    s:string;
begin
if openDialog1.Execute then
 begin
  assignfile(f,openDialog1.FileName);
  //edit1.Text:=opendialog1.FileName;
  reset(f);
  readln(f,s);
  pd:=0;
  pd:=pos('date=',s);
  if pd=0 then pd:=pos('Date=',s);
  pt:=0;
  pt:=pos('Time=',s);
  if pt=0 then pt:=pos('time=',s);
  p:=0;
  p:=pos('dt=',s);
  if p=0 then p:=pos('dt=',s);

  y:=strtoint(copy(s,pd+5,4));
  m:=strtoint(copy(s,pd+9,2));
  d:=strtoint(copy(s,pd+11,2));
  jDay:=JD(d,m,y);

  h:=strtoint(copy(s,pt+5,2));
  min:=strtoint(copy(s,pt+7,2));
  sec:=strtofloat(copy(s,pt+9,3));
  UT:=h+min/60+sec/3600;
  Jday:=Jday+UT/24;
  dt:=strtofloat(copy(s,p+3,10));
   assignfile(f2,edit1.text);
   if checkbox1.Checked then append(f2)
   else rewrite(f2);
   while not EOF(f) do
   begin
   if checkbox2.Checked then
    readln (f, No, data)else  readln (f, data);
   writeln(f2, Jday:15:8, data:20:10);
   Jday:=Jday+(dt/3600)/24;
   end;
  closefile(f);
  closefile(f2);
 end;
end;

end.
