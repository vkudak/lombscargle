unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls,math,AstroUnit;

type
  TForm3 = class(TForm)
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift:
        TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton; Shift:
        TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    Image1: TImage;
  end;

var
  Form3: TForm3;
  cc,dob,min,max:double;

implementation
uses xygraph, xycopy, xygraph3d,Unit1;

{$R *.dfm}

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
image1.Free;
end;

procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
if key=vk_escape then close;

end;

procedure TForm3.FormShow(Sender: TObject);
var i,d:integer;
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
///////////////////// Create Image1
image1:=TImage.Create(Form3);
image1.Parent := Form3.ScrollBox1;
image1.Height:=Form3.Clientheight-40{-statusBar1.Height};
if form3.ClientWidth<2000 then image1.Width:=2000
  else image1.width:=form3.clientwidth;
image1.Visible:=true;
image1.Canvas.Create;
image1.OnMouseDown:=form3.Image2mouseDown;
image1.OnMouseMove:=form3.Image2mousemove;
image1.OnMouseUp:=form3.Image2mouseup;
Image1.Cursor:=crCross;
image1.Repaint;
/////////////////////////////
///////////////////////////////////
 xycanvasgraph(image1.Canvas,Image1.Width,Image1.Height,
                                             clWhite,clWhite,8/8,true);
    xystartgraph(3,100,3,100,35,35,20,35,clipon);
    if xt[0]<xt[length(xt)-1] then
    xyTimeAxis(clblack,xt[0],xt[length(xt)-1],'Time',-1,0,0,0,0,gridoff,tm)
     else
     xyTimeAxis(clblack,xt[0],1+xt[length(xt)-1],'Time',-1,0,0,0,0,gridoff,tm);


 if form1.mChb.Checked then
 xyyaxis(clblack,maxValue(form1.x),
                 minvalue(form1.x),0,0,'m',1,gridoff,lin,fixed)
 else
 xyyaxis(clblack,minValue(form1.x),
                 maxvalue(form1.x),0,0,'Imp',1,gridoff,lin,fixed);
 image1.Canvas.Pen.Color:=clRed;
 d:=0;  /// Perexid cherez 24:00:00 + 1 den'
 for i:=1 to length(xt)-1 do
    begin
    xymove(d+xt[i-1],form1.x[i-1]);
     if xt[i]<xt[i-1] then d:=1;
    xydraw(d+xt[i],  form1.x[i]);
    end;
 image1.Canvas.Pen.Color:=clBlack;

xyfinish;
/////////////////////////////////
end;

procedure TForm3.Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift:
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

procedure TForm3.Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y:
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

procedure TForm3.Image2MouseUp(Sender: TObject; Button: TMouseButton; Shift:
    TShiftState; X, Y: Integer);
begin
  xyexportd.xp := -1;
  xymouseup(button,shift,x,y);
end;

end.
