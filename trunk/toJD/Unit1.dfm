object Form1: TForm1
  Left = 192
  Top = 114
  Width = 169
  Height = 214
  Caption = 'Form1'
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
  object Button1: TButton
    Left = 42
    Top = 32
    Width = 75
    Height = 25
    Caption = 'To JD'
    TabOrder = 0
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 112
    Width = 97
    Height = 17
    Caption = 'Add to'
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 18
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'File name'
  end
  object CheckBox2: TCheckBox
    Left = 16
    Top = 80
    Width = 97
    Height = 17
    Caption = 'Two column'
    TabOrder = 3
  end
  object OpenDialog1: TOpenDialog
  end
end
