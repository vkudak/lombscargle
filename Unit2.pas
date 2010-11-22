unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    StatBar: TStatusBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  dp,p1:double;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_escape then close;
end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if (X>=20) and (X<=520) then
 begin
 if form1.JDchB.Checked and form1.RezSec.Checked then
  statbar.Panels[0].Text:='P='+
  floattostrf((x-20)*form1.dp*24*3600/500 +form1.p1*24*3600
              ,ffgeneral,5,4)
 else
 statbar.Panels[0].Text:='P='+
  floattostrf((x-20)*form1.dp/500 +form1.p1
              ,ffgeneral,5,4);
 statbar.Panels[1].Text:='Power='+
  floattostrf((320-y)*(form1.p_lomb[form1.mai]-form1.p_lomb[form1.mii])/300
                                                     +form1.p_lomb[form1.mii]
              ,ffgeneral,5,4);
 end;

end;

end.
