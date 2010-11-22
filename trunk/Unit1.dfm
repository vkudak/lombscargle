object Form1: TForm1
  Left = 194
  Top = 112
  Width = 433
  Height = 403
  Caption = 'Lomb-Scargle Period Analyse'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 160
    Top = 49
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 2
    OnClick = Button1Click
  end
  object P_Prop: TGroupBox
    Left = 8
    Top = 17
    Width = 137
    Height = 121
    Caption = ' Parameters'
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 16
      Width = 32
      Height = 13
      Caption = 'P start'
    end
    object Label2: TLabel
      Left = 22
      Top = 42
      Width = 27
      Height = 13
      Caption = 'P end'
    end
    object Label3: TLabel
      Left = 28
      Top = 69
      Width = 22
      Height = 13
      Caption = 'Step'
    end
    object Label4: TLabel
      Left = 7
      Top = 93
      Width = 46
      Height = 13
      Caption = 'Time step'
    end
    object Edit2: TEdit
      Left = 56
      Top = 41
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '25'
    end
    object Edit3: TEdit
      Left = 56
      Top = 66
      Width = 65
      Height = 21
      Hint = 'Resolution=(Pend-Pstart)/Step'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '1300'
    end
    object Edit1: TEdit
      Left = 56
      Top = 16
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '15'
    end
    object Edit4: TEdit
      Left = 56
      Top = 91
      Width = 65
      Height = 21
      Hint = 'dt=t(n)- t(n-1). If you use JD as Time then leave "1"  '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '1'
    end
  end
  object Button2: TButton
    Left = 160
    Top = 17
    Width = 75
    Height = 25
    Caption = 'File'
    TabOrder = 3
    OnClick = Button2Click
  end
  object PBar: TProgressBar
    Left = 16
    Top = 155
    Width = 217
    Height = 16
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 330
    Width = 425
    Height = 19
    Panels = <
      item
        Text = 'Filename'
        Width = 50
      end>
  end
  object File_prop: TGroupBox
    Left = 8
    Top = 185
    Width = 129
    Height = 89
    Caption = 'FileType'
    TabOrder = 5
    object onerb: TRadioButton
      Left = 16
      Top = 24
      Width = 105
      Height = 17
      Caption = '- One column (x)'
      TabOrder = 0
    end
    object tworb: TRadioButton
      Left = 16
      Top = 56
      Width = 105
      Height = 17
      Caption = '- Two column (t,x)'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object sigma: TGroupBox
    Left = 152
    Top = 185
    Width = 89
    Height = 89
    Hint = 'Power of Period is more then...'
    Caption = 'Output result'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    object sig: TRadioButton
      Left = 8
      Top = 16
      Width = 73
      Height = 17
      Caption = '> sigma'
      TabOrder = 0
    end
    object noll: TRadioButton
      Left = 8
      Top = 64
      Width = 65
      Height = 17
      Caption = '> 0 (ALL)'
      TabOrder = 1
    end
    object sign2: TRadioButton
      Left = 8
      Top = 40
      Width = 73
      Height = 17
      Caption = '> sigma/2'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
  end
  object Button3: TButton
    Left = 152
    Top = 121
    Width = 89
    Height = 17
    Caption = 'Show File Data'
    Enabled = False
    TabOrder = 7
    OnClick = Button3Click
  end
  object StringGrid1: TXStringGrid
    Left = 248
    Top = 4
    Width = 161
    Height = 281
    ColCount = 2
    FixedCols = 0
    TabOrder = 8
    FixedLineColor = clBlack
    Columns = <
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        EditorInheritsCellProps = False
      end
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        EditorInheritsCellProps = False
      end>
    MultiLine = False
    ImmediateEditMode = False
  end
  object mChb: TCheckBox
    Left = 8
    Top = 282
    Width = 121
    Height = 25
    Caption = 'inverse Scale ( m )'
    TabOrder = 9
  end
  object UTrb: TCheckBox
    Left = 8
    Top = 309
    Width = 73
    Height = 17
    Caption = 'UT as Time'
    TabOrder = 10
  end
  object JDbox: TGroupBox
    Left = 176
    Top = 284
    Width = 241
    Height = 41
    Caption = 'Julian Day'
    TabOrder = 11
    object JDchB: TCheckBox
      Left = 56
      Top = 16
      Width = 73
      Height = 17
      Caption = 'JD as Time'
      TabOrder = 0
    end
    object RezSec: TCheckBox
      Left = 144
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Rez in sec'
      TabOrder = 1
    end
  end
  object Button4: TButton
    Left = 160
    Top = 92
    Width = 75
    Height = 17
    Caption = 'Periodogram'
    Enabled = False
    TabOrder = 12
    OnClick = Button4Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Text files (*.txt)|*.txt| All files (*.*)|*.*'
    FilterIndex = 2
    Left = 160
    Top = 65520
  end
  object MainMenu1: TMainMenu
    Left = 112
    Top = 65528
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Action1: TMenuItem
      Caption = 'Action'
      object ConverttoJD1: TMenuItem
        Caption = 'Convert to JD'
        OnClick = ConverttoJD1Click
      end
      object Sumingfile1: TMenuItem
        Caption = 'Suming file'
        OnClick = Sumingfile1Click
      end
    end
    object Aboute1: TMenuItem
      Caption = 'About'
      OnClick = Aboute1Click
    end
  end
end
