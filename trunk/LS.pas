unit LS;

interface
uses ComCtrls, Forms;

type ard = array of double;

procedure LombScargle(xp,tp:Pointer; n:integer; f1,f2,step:double;
                      pb:TProgressBar;
                      var np:integer; var P_lomb,f:array of double);

implementation
Uses math;
var     xser,sigma:extended;

procedure Pls(xp,tp:Pointer; n:integer; ff:double; var P:double);
var j,i:integer;
    tau,s1,s11,s2,s22:double;
    x,t:^ard;
begin
x:=xp; t:=tp;
////////////////////////   Для одної частоти!
s1:=0; s2:=0;
for i:=0 to n do
 begin
  s1:=s1+sin(4*pi*ff*t^[i]);
  s2:=s2+cos(4*pi*ff*t^[i]);
 end;
tau:=(1/(4*pi*ff))*arctan2(s1,s2);   //---> TAU

s1:=0; s2:=0; s11:=0; s22:=0;
for j:=0 to n do
 begin
 s1:=s1+(x^[j]-xser)*sin(2*pi*ff*(t^[j]-tau));
 s11:=s11+sqr(sin(2*pi*ff*(t^[j]-tau)));
 s2:=s2+(x^[j]-xser)*cos(2*pi*ff*(t^[j]-tau));
 s22:=s22+sqr(cos(2*pi*ff*(t^[j]-tau)));
 end;
 S1:=sqr(s1)/s11;
 S2:=sqr(s2)/s22;

  P:=S1+S2;
  P:=P/(2*sqr(sigma));     // nornalized  !!!
////////////////////////
end;


procedure LombScargle(xp,tp:Pointer; n:integer; f1,f2,step:double;
                      pb:TProgressBar;
                      var np:integer; var P_lomb,f:array of double);
var ff:double;
    i:integer;
    x,t:^ard;
begin
x:=xp;
t:=tp;
MeanAndStdDev(x^,xser,sigma);
ff:=f1;
i:=0;
step:=abs(f2-f1)/step;
pb.max:=round(abs(f2-f1)/step);
 while (ff>=(f2-step)) do
  begin
  pb.Position:=i;
  Application.ProcessMessages;////????????
  Pls(x,t,n,ff,P_lomb[i]);
  f[i]:=ff;
  ff:=ff-step;
  i:=i+1;
  end;
nP:=i;
end;



end.
 