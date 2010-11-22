object Form2: TForm2
  Left = 625
  Top = 108
  Width = 614
  Height = 417
  Caption = 'Lomb-Scargle Periodogram'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 606
    Height = 364
    Cursor = crCross
    Align = alClient
    OnMouseMove = Image1MouseMove
  end
  object StatBar: TStatusBar
    Left = 0
    Top = 364
    Width = 606
    Height = 19
    Panels = <
      item
        Text = 'P'
        Width = 50
      end
      item
        Text = 'Power'
        Width = 50
      end>
  end
end
