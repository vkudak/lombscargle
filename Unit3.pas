unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls,math,AstroUnit;

type
  TForm3 = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    StatusBar1: TStatusBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift:
        TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift:
        TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  cc,dob,min,max:double;

implementation
uses xygraph, xycopy, xygraph3d,Unit1;

{$R *.dfm}

procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
if key=vk_escape then close;

end;

procedure TForm3.FormShow(Sender: TObject);
var i:integer;
     UT:double;
     xt:array of double;
     tm:boolean;
     h,m,s,ms:word;
     dtime:TdateTime;
begin
setlength(xt,form1.n);
for i:=0 to form1.n-1 do
 begin
  if form1.UTrb.Checked then
   UT:=form1.t[i]
   else if form1.JDchB.Checked then
        UT:=frac(form1.t[i]-0.5)*24
   else UT:=form1.UTst+(form1.timestep*i)/3600; /// Prostij variant
  H60(UT,h,m,s,ms);
  TryEncodeTime(h,m,s,ms,dtime);
  xt[i]:=dtime;
 end;
if form1.n-1<=2000 then Image1.width:=form1.n-1 else Image1.width:=2000;
if form1.n-1<Form3.ClientWidth then Image1.Width:=form3.ClientWidth-10;
///////////////////////////////////
 xycanvasgraph(image1.Canvas,Image1.Width,Image1.Height,
                                             clWhite,clWhite,8/8,true);
    xystartgraph(3,100,3,100,35,35,20,35,clipon);
    xyTimeAxis(clblack,xt[0],xt[form1.n-1],'Time',-2,0,0,0,0,gridoff,tm);

 if form1.mChb.Checked then
 xyyaxis(clblack,maxValue(form1.x),
                 minvalue(form1.x),0,0,'m',1,gridoff,lin,fixed)
 else
 xyyaxis(clblack,minValue(form1.x),
                 maxvalue(form1.x),0,0,'Imp',1,gridoff,lin,fixed);
 image1.Canvas.Pen.Color:=clRed;
 for i:=1 to length(xt)-1 do
    begin
    xymove(xt[i-1],form1.x[i-1]);
    xydraw(xt[i],  form1.x[i]);
    end;
 image1.Canvas.Pen.Color:=clBlack;

xyfinish;
/////////////////////////////////
end;

procedure TForm3.Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift:
    TShiftState; X, Y: Integer);
begin
  xyexportd.xp := -1;
  xymousedown(button,shift,x,y);
  if (xyexportd.xp>=0) and (xyexportd.igr=1) and
   not (ssCtrl in shift) then
     begin
       statusBar1.Panels[0].Text:='X='+Timetostr(xyexportd.xw);
       statusBar1.Panels[1].Text:='Y='+floattostr(xyexportd.yw[1]);
     end;
end;

procedure TForm3.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y:
    Integer);
begin
 xymousemove(shift,x,y);
  if (xyexportd.xp>=0) and (xyexportd.igr=1) and
   not (ssCtrl in shift) then
    begin
     statusBar1.Panels[0].Text:='X='+TimeTostr(xyexportd.xw);
     statusBar1.Panels[1].Text:='Y='+floattostr(xyexportd.yw[1]);
    end;
end;

procedure TForm3.Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift:
    TShiftState; X, Y: Integer);
begin
  xyexportd.xp := -1;
  xymouseup(button,shift,x,y);
end;

end.
