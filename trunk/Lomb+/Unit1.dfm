object Form1: TForm1
  Left = 192
  Top = 114
  Width = 277
  Height = 195
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 48
    Width = 76
    Height = 13
    Caption = 'Open KR# file!!!'
  end
  object Button1: TButton
    Left = 80
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Left = 128
    Top = 8
  end
end
