object Form3: TForm3
  Left = 563
  Top = 244
  Width = 614
  Height = 448
  Caption = 'Data Graphic'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 606
    Height = 395
    HorzScrollBar.Tracking = True
    Align = alClient
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 395
    Width = 606
    Height = 19
    Panels = <
      item
        Text = 'X='
        Width = 100
      end
      item
        Text = 'Y='
        Width = 150
      end>
  end
end
