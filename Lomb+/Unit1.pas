unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,AstroUnit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
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

procedure TForm1.Button1Click(Sender: TObject);
var dat,pass,rez:textfile;
    T:Double;
    dt,ss,UT,jday,x:extended;
    dd,mm,yy,h,m,poss,n,i:integer;
    pasfn,filen,s:string;
begin
//open kr file
if openDialog1.Execute then
 begin
 filen:=Opendialog1.FileName;
 poss:=pos('kr',Opendialog1.FileName);
 if poss=0 then
  poss:=pos('KR',Opendialog1.FileName);
 pasfn:=filen;
 delete(pasfn,poss,2);
 insert('is',pasfn,poss);
 assignFile(pass,pasfn);
 reset(pass);
 AssignFile(dat,Opendialog1.FileName);
 reset(dat);
 assignFile(rez,Opendialog1.FileName+'.JD');
 rewrite(rez);
 /////////////////////////////
 readln(pass,s);
 dd:=strtoint(s[13]+s[14]);
 mm:=strtoint(s[15]+s[16]);
 yy:=strtoint(s[17]+s[18]+s[19]+s[20]);
 h:=strtoint(s[24]+s[25]);
 m:=strtoint(s[26]+s[27]);
 ss:=strtofloat(s[28]+s[29]+s[30]+s[31]);
 UT:=h+m/60+ss/3600;
 write(rez,dd,'  ',mm,'  ',yy); ///////
 write(rez,'    UT=',h,'  ',m,'  ',ss:2:2,'  ');   ///////
 jday:=JD(dd,mm,yy)+UT/24;
 write(rez,'JD= ',jday:10:4,'   ');  ////////
 readln(pass,s);
// n:=strtoint(s[7]+s[8]+s[9]+s[10]);
 dt:=strtoFloat(s[18]+s[19]+s[20]+s[21]+s[22]+s[23]);
 writeln(rez,'n=',n,' dt=',dt:2:4);  /////////////

// For i:=1 to n do
i:=1;
While Not eof(dat)do
  begin
  readln(dat,x);
  T:=(Jday+((dt*i)/3600)/24);
  writeln(rez,T:15:10,x:15:1);
  i:=i+1;
  end;
 ////////////////////////////////
 Closefile(dat);
 closefile(pass);
 closefile(rez)
 end;

end;

end.
