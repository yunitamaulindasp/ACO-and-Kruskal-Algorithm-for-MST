object Form2: TForm2
  Left = 413
  Top = 59
  Width = 630
  Height = 716
  BorderStyle = bsSizeToolWin
  Caption = 'ACO and Kruskal'#39's Algorithm for MST'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object StatusBar1: TStatusBar
    Left = 0
    Top = 961
    Width = 597
    Height = 19
    Panels = <
      item
        Text = 'Copyright '#169' 2022 Yunita Maulinda'
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 8
    Width = 593
    Height = 953
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Input Data'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 585
        Height = 433
        Caption = 'Input Titik'
        TabOrder = 0
        object imgTitik: TImage
          Left = 4
          Top = 20
          Width = 577
          Height = 409
          OnMouseUp = ImgTitikMouseUp
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 440
        Width = 585
        Height = 345
        Caption = 'Input Bobot'
        TabOrder = 1
        object sgMatriks: TStringGrid
          Left = 8
          Top = 24
          Width = 569
          Height = 313
          ColCount = 2
          DefaultColWidth = 50
          DefaultRowHeight = 25
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          TabOrder = 0
          OnDrawCell = SgMatriksDrawCell
          OnKeyPress = SgMatriksKeyPress
          OnSelectCell = SgMatriksSelectCell
          OnSetEditText = SgMatriksSetEditText
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 792
        Width = 305
        Height = 121
        Caption = 'Input Parameter'
        TabOrder = 2
        object Label1: TLabel
          Left = 16
          Top = 32
          Width = 28
          Height = 20
          Caption = 'Alfa'
        end
        object Label2: TLabel
          Left = 16
          Top = 64
          Width = 34
          Height = 20
          Caption = 'Beta'
        end
        object Label3: TLabel
          Left = 16
          Top = 96
          Width = 15
          Height = 20
          Caption = 'Tij'
        end
        object edA: TEdit
          Left = 64
          Top = 24
          Width = 65
          Height = 28
          TabOrder = 0
          OnKeyPress = edAKeyPress
        end
        object edB: TEdit
          Left = 64
          Top = 56
          Width = 65
          Height = 28
          TabOrder = 1
          OnKeyPress = edBKeyPress
        end
        object edT: TEdit
          Left = 64
          Top = 88
          Width = 65
          Height = 28
          TabOrder = 2
        end
      end
      object Tbhitung: TButton
        Left = 336
        Top = 808
        Width = 225
        Height = 41
        Caption = 'Hitung MST'
        TabOrder = 3
        OnClick = TbhitungClick
      end
      object btHapus: TButton
        Left = 336
        Top = 864
        Width = 105
        Height = 33
        Caption = 'Hapus'
        TabOrder = 4
        OnClick = btHapusClick
      end
    end
  end
  object btBuka: TButton
    Left = 472
    Top = 8
    Width = 115
    Height = 25
    Caption = 'Buka'
    TabOrder = 2
    OnClick = btBukaClick
  end
  object TbSave: TButton
    Left = 456
    Top = 903
    Width = 105
    Height = 33
    Caption = 'Save'
    TabOrder = 3
    OnClick = TbSaveClick
  end
  object OpenDialog1: TOpenDialog
    Left = 564
    Top = 686
  end
  object SaveDialog1: TSaveDialog
    Left = 540
    Top = 686
  end
end
