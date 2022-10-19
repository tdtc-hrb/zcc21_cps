object frm_station: Tfrm_station
  Left = 192
  Top = 107
  BorderStyle = bsSingle
  Caption = #32534#36753#21040#31449
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Caption = #32534#36753#21040#31449
    Color = clBtnShadow
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 40
    Width = 688
    Height = 353
    Align = alClient
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Jan'
        Title.Caption = #21040#31449#31616#31216
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ArriveStation'
        Title.Caption = #21040#31449#20840#31216
        Width = 200
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 393
    Width = 688
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      688
      41)
    object Button1: TButton
      Left = 488
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #32534#36753'(&E)'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 584
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 392
      Top = 8
      Width = 75
      Height = 25
      Caption = #28155#21152'(&A)'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 304
      Top = 8
      Width = 75
      Height = 25
      Caption = #21024#38500'(&D)'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 434
    Width = 688
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object ADODataSet1: TADODataSet
    Connection = frm_main.ADOConnection1
    CursorType = ctStatic
    CommandText = 'SELECT Jan, ArriveStation FROM arrivestation'
    Parameters = <>
    Left = 424
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 464
    Top = 8
  end
end
