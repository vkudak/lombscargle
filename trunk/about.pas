unit about;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;
  fVerBlk : TVSFixedFileInfo;

implementation

{$R *.dfm}
function GetFileVersion(AFileName: string): boolean;
var
  InfoSize, puLen: DWord;
  Pt, InfoPtr: Pointer;

begin
  InfoSize := GetFileVersionInfoSize( PChar(AFileName), puLen );
  fillchar( fVerBlk, sizeof(TVSFixedFileInfo), 0);
  if InfoSize > 0 then
  begin
    GetMem(Pt,InfoSize);
    GetFileVersionInfo( PChar(AFileName), 0, InfoSize, Pt);
    VerQueryValue(Pt,'\',InfoPtr,puLen);
    move(InfoPtr^, fVerBlk, sizeof(TVSFixedFileInfo) );
    FreeMem(Pt);
    result := true;
  end
  else
    result := false;
end;


procedure TAboutBox.FormCreate(Sender: TObject);
var s:string;
begin
 if GetFileVersion( Application.ExeName ) then
    s := Format('%u.%u.%u.%u',
    [HiWord(fVerBlk.dwProductVersionMS),
    LoWord(fVerBlk.dwProductVersionMS),
    HiWord(fVerBlk.dwProductVersionLS),
    LoWord(fVerBlk.dwProductVersionLS)])
  else
    s := '';

Version.Caption:='Version: '+s;
end;

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
close;
end;

end.
 
