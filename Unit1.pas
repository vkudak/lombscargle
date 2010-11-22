unit Unit1;
/////////////////////!!!!!!
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,LS, Grids, Buttons,math,
  XStringGrid, Menus,shellAPI;
type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    P_Prop: TGroupBox;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Edit4: TEdit;
    Label4: TLabel;
    PBar: TProgressBar;
    StatusBar1: TStatusBar;
    File_prop: TGroupBox;
    onerb: TRadioButton;
    tworb: TRadioButton;
    sigma: TGroupBox;
    sig: TRadioButton;
    noll: TRadioButton;
    sign2: TRadioButton;
    Button3: TButton;
    StringGrid1: TXStringGrid;
    mChb: TCheckBox;
    JDchB: TCheckBox;
    UTrb: TCheckBox;
    JDbox: TGroupBox;
    RezSec: TCheckBox;
    Button4: TButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Action1: TMenuItem;
    Aboute1: TMenuItem;
    ConverttoJD1: TMenuItem;
    Sumingfile1: TMenuItem;
    procedure Aboute1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ConverttoJD1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sumingfile1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    x,t,p_lomb,f:array{[1..nn]} of double;
    n,np,mai,mii:integer;
    xf,xser,timestep:double;
    dp,p1:double;
    UTst:double;
    h_st,m_st,sec_st:integer;

  end;

var
  Form1: TForm1;
  FileN:string;
  k:integer;
  fil:textfile;
  UT1,UT2:double;

implementation

uses Unit2, Unit3, about;

{$R *.dfm}
procedure mdev (a:array of double; n:integer; var m,dev:double);
var i:integer;
    s:double;
begin
s:=0;
for i:=1 to n do s:=s+a[i];
m:=s/n;
s:=0;
for i:=1 to n do s:=s+sqr(a[i]-m);
dev:=s/(n-1);
end;

function CompareProcF(Sender: TXStringGrid; SortCol, row1, row2: integer): Integer;
var x1,x2:double;
begin
  with Sender do
  begin
   x1:=strtofloatdef(Cells[SortCol, row1],0);
   x2:=strtofloatdef(Cells[SortCol, row2],0);
    result := CompareValue(x1, x2,0);
  end;
end;

function DescSortCompareProc(Sender: TXStringGrid; SortCol, row1, row2: integer): Integer;
begin
  result := - CompareProcF(Sender, SortCol, row1, row2);
end;


procedure WholeRowSwapProc(Sender: TXStringGrid; SortCol, row1, row2: integer);
var
  r: TStringList;
begin
  r := TStringList.Create;
  try
    with Sender do begin
      r.Assign(Rows[row1]);
      Rows[row1].Assign(Rows[row2]);
      Rows[row2].Assign(r);
    end;
  finally
    r.free;
  end;
end;

procedure TForm1.Aboute1Click(Sender: TObject);
begin
aboutBox.show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
openDialog1.InitialDir:=ExtractFilePAth(Application.ExeName);
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,j,k:integer;
    f1,f2,step,xP,stepp,pp1,pp2:double;
    fo:textfile;
    devp,mean,crit:double;
      c: TCompareProc;
      s: TSwapProc;
begin
  setlength(x,0);
  setlength(t,0);
  setlength(p_lomb,0);
  setlength(f,0);
form2.image1.Canvas.Rectangle(0,0,form2.image1.Width,form2.image1.Height);
if fileN='' then
   begin Application.MessageBox('no file name!','error',0); exit; end;
f1:=strtofloat(edit1.text);
f2:=strtofloat(edit2.text);

if (jdChB.Checked) and (rezSec.Checked) then
 begin
  f1:=f1/24/3600;
  f2:=f2/24/3600;
 end;
f1:=1/f1;
f2:=1/f2;

step:=strtofloat(edit3.text);
//step:=1/step;
TimeStep:=strtofloat(edit4.text);
dp:=1/f2-1/f1;
p1:=1/f1;

////file
assignfile(fil,fileN);
reset(fil);
readln(fil); i:=0;
while not eof(fil) do
 begin
 if (tworb.Checked) and (UTrb.Checked=false) then
  begin
  setlength(x,i+1);
  setlength(t,i+1);
  setlength(p_lomb,i+1);
  setlength(f,i+1);
  readln(fil,t[i],x[i]);
  i:=i+1;
  end;
 if (tworb.Checked)and(UTrb.checked) then
  begin
    setlength(x,i+1);  ///
    setlength(t,i+1);  ////
    setlength(p_lomb,i+1);
    setlength(f,i+1);
    readln(fil,t[i],x[i]);
    if i=0 then UT1:=t[i];
    if i=1 then UT2:=t[i];
    t[i]:=i;
    i:=i+1;
  end;
 if onerb.Checked then
  begin
  setlength(x,i+1);  ///
  setlength(t,i+1);  ////
  setlength(p_lomb,i+1);
  setlength(f,i+1);
  readln(fil,x[i]); t[i]:=i;
  i:=i+1;
  end;
 end;
closefile(fil);
if UTrb.checked then
 begin
 edit4.text:=floattostr((UT2-UT1)*3600);
 Timestep:=(UT2-UT1)*3600;
 end;
////////
n:=i-1;

if timestep<>1 then
 for j:=0 to n do t[j]:=t[j]*timestep;


Assignfile(fo,ChangeFileExt(FileN,'.zp'));
rewrite(fo);
writeln(fo,'     P          Power     ',edit1.text+' - '+edit2.text);

///////////////
pp1:=1/f1; pp2:=1/f2;
stepp:=(pp2-pp1)/step;
k:=round((pp2-pp1)/stepp);
setlength(P_lomb,k+10);
setlength(f,k+10);
///////////////

lombScargle(@x,@t,n,f1,f2,step,pBar,np,P_lomb,f);  //////////////LOMB-SCARGLE
np:=np-1;
mai:=1; mii:=1;
for i:=0 to np do
  begin
   if p_lomb[i]>p_lomb[mai] then mai:=i;
   if p_lomb[i]<p_lomb[mii] then mii:=i;
  end;
mdev(p_lomb,np,mean,devp);
crit:=0;
if noll.Checked then crit:=0;
if sig.Checked then crit:=devp;
if sign2.Checked then crit:=devp/2;

xf:=500/(1/f2-1/f1);
xP:=300/(p_lomb[mai]-p_lomb[mii]);
k:=1;
for i:=0 to np-1 do
 begin
  if (p_lomb[i-1]<p_lomb[i]) and (p_lomb[i]>p_lomb[i+1])
      and(p_lomb[i]>crit) then
   begin
       StringGrid1.Cells[0,k]:=floattostrf(P_lomb[i],ffgeneral,8,6);
       if not rezSec.Checked then   ////////////////////////
        StringGrid1.Cells[1,k]:=floattostrF(1/f[i],ffgeneral,10,8)
        else StringGrid1.Cells[1,k]:=floattostrF((1/f[i])*24*3600,ffgeneral,10,8);
     k:=k+1;
   end;
 end;

StringGrid1.RowCount:=k;

     s := WholeRowSwapProc;
     c := DescSortCompareProc;
StringGrid1.sort(0,c,s);      // SORT!!!

 for j:=1 to k-1 do
 begin
  writeln(fo,strtofloat(StringGrid1.cells[1,j]):10:6,
            strtofloat(StringGrid1.cells[0,j]):12:6);
 end;
 closefile(fo);

StringGrid1.Cells[0,0]:='Power';
StringGrid1.Cells[1,0]:='P';
button4.Enabled:=true;
with form2.image1 do
 begin
 canvas.Pen.Color:=clblack;
 canvas.MoveTo(20,20); canvas.LineTo(20,320); canvas.LineTo(520,320);
 canvas.MoveTo(15,320-round(P_lomb[mai]*xp));
 canvas.LineTo(20,320-round(P_lomb[mai]*xp));
 canvas.TextOut(2,320-round(P_lomb[mai]*xp)+2,floattostrF(P_lomb[mai],ffgeneral,2,3));
 canvas.MoveTo(15,320-round((P_lomb[mai]/2)*xp));
 canvas.LineTo(20,320-round((P_lomb[mai]/2)*xp));
 canvas.TextOut(2,320-round((P_lomb[mai]/2)*xp)+2,floattostrF(P_lomb[mai]/2,ffgeneral,2,3));

 canvas.MoveTo(20,320-round(P_lomb[0]*xp));
 for i:=0 to np do
 begin
 canvas.pen.Color:=clred;
 canvas.Lineto(round(20+(1/f[i]-1/f[0])*xf),320-round((P_lomb[i]-P_lomb[mii])*xp));
 end;
  canvas.Pen.Color:=clblack;
  canvas.MoveTo(20,315);
  canvas.LineTo(20,325);
  if not (JDChb.Checked) or (not rezsec.checked) then
  begin
  canvas.TextOut(20,330,floattostrF(1/f[0],ffgeneral,3,3));
  canvas.MoveTo(round(20+1/f[np]*xf-1/f[0]*xf),315);
  canvas.LineTo(round(20+1/f[np]*xf-1/f[0]*xf),325);
  canvas.TextOut(round(20+1/f[np]*xf-1/f[0]*xf),330,floattostrF(1/f[np],ffgeneral,6,3));
  canvas.MoveTo(270,315);
  canvas.LineTo(270,325);
  canvas.TextOut(270,330,floattostrF((1/f2-p1)/2+p1,ffgeneral,6,3));
  end
   else
  begin
  canvas.TextOut(20,330,floattostrF(1/f[0]*24*3600,ffgeneral,3,3));
  canvas.MoveTo(round(20+1/f[np]*xf-1/f[0]*xf),315);
  canvas.LineTo(round(20+1/f[np]*xf-1/f[0]*xf),325);
  canvas.TextOut(round(20+1/f[np]*xf-1/f[0]*xf),330,floattostrF(1/f[np]*24*3600,ffgeneral,6,3));
  canvas.MoveTo(270,315);
  canvas.LineTo(270,325);
  canvas.TextOut(270,330,floattostrF((1/f2*24*3600-p1*24*3600)/2+p1*24*3600,ffgeneral,6,3));
  end;
end;
button3.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var s:string;
begin
if OpenDialog1.Execute then
 begin
 FileN:=opendialog1.fileName;
 statusbar1.Panels[0].text:='Filename='+ExtractFileName(Filen);
 button3.Enabled:=false;
 button4.Enabled:=false;
 assignFile(fil,Filen);
 reset(fil);
 read(fil,s);
 closefile(fil);
  if length(s)>1 then
   begin
    if s[1]='1' then onerb.Checked:=true;

    try
     if pos('dt=',s)>0 then edit4.text:=(copy(s,pos('dt=',s)+3,10))
       else edit4.Text:='1';
     if pos('dT=',s)>0 then edit4.text:=(copy(s,pos('dT=',s)+3,10))
       else edit4.Text:='1';
     Except on E:exception do
     application.MessageBox('Wrong dT in File, Set dT manualy','Attention!',0);
     end;//try

    if (pos('Time=',s)>0)or(pos('time=',s)>0) then
     begin
      if pos('Time=',s)>0 then
        S:=(copy(s,pos('Time=',s)+5,6));
      if pos('time=',s)>0 then
        S:=(copy(s,pos('time=',s)+5,6));
     try
      h_st:=strtoint(s[1]+s[2]);
      m_st:=strtoint(s[3]+s[4]);
      sec_st:=strtoint(s[5]+s[6]);
      UTst:=h_st+m_st/60+sec_st/3600;
      except on E:Exception do
        application.MessageBox('Wrong Time in File, Time set to "0"','Attention!',0)
      end //try
     end else  UTst:=0;
   end;
 end;
 
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
form3.visible:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Form2.visible:=true;
end;

procedure TForm1.ConverttoJD1Click(Sender: TObject);
begin
if fileexists(extractFileDir(application.exeName)+'\toJD\ToJD.exe') then
 Winexec(Pchar(ExtractfileDir(Application.Exename)+'\toJD\ToJD.exe'),sw_show) else
  Application.MessageBox('Cant find "\ToJD\ToJD.exe" file','Eror',0)
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_escape then close;
end;

procedure TForm1.Sumingfile1Click(Sender: TObject);
begin
if fileexists(extractFileDir(application.exeName)+'\Sum\Summa.exe') then
 Winexec(Pchar(ExtractfileDir(Application.Exename)+'\Sum\Summa.exe'),sw_show) else
  Application.MessageBox('Cant find "\ToJD\ToJD.exe" file','Eror',0)
end;

end.
