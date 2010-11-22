object Form1: TForm1
  Left = 192
  Top = 114
  Width = 208
  Height = 155
  Caption = 'Summa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 39
    Height = 13
    Caption = #1057#1082#1083#1077#1111#1090#1080
  end
  object Label2: TLabel
    Left = 150
    Top = 21
    Width = 30
    Height = 13
    Caption = #1058#1086#1095#1086#1082
  end
  object Button1: TButton
    Left = 112
    Top = 80
    Width = 75
    Height = 25
    Caption = 'File'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 80
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 72
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 2
    Text = '10'
  end
  object UpDown1: TUpDown
    Left = 113
    Top = 16
    Width = 16
    Height = 21
    Associate = Edit1
    Position = 10
    TabOrder = 3
  end
  object tkol: TCheckBox
    Left = 61
    Top = 50
    Width = 81
    Height = 17
    Caption = '2 '#1082#1086#1083#1086#1085#1082#1080
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
  end
end
