object frm_main: Tfrm_main
  Left = 26
  Top = 108
  Align = alClient
  BorderStyle = bsSingle
  Caption = #35843#24230#20013#24515
  ClientHeight = 563
  ClientWidth = 978
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 978
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    Caption = #25968#25454#22788#29702#20013#24515
    Color = clBtnShadow
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 544
    Width = 978
    Height = 19
    Panels = <
      item
        Width = 175
      end
      item
        Width = 125
      end
      item
        Width = 115
      end
      item
        Width = 85
      end
      item
        Width = 115
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 40
    Width = 978
    Height = 504
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 300
      Top = 0
      Width = 8
      Height = 504
      Cursor = crHSplit
      Beveled = True
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 300
      Height = 504
      Align = alLeft
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 0
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 298
        Height = 48
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 39
          Height = 13
          Caption = #30719#21035#65306
        end
        object cmbox_kb: TComboBox
          Left = 72
          Top = 16
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cmbox_kbChange
        end
      end
      object DBGrid1: TDBGrid
        Left = 1
        Top = 49
        Width = 298
        Height = 454
        Align = alClient
        DataSource = DataSource1
        PopupMenu = PopupMenu1
        TabOrder = 1
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'sn'
            Title.Caption = #36742#24207
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'total_weight1'
            ReadOnly = True
            Title.Caption = #24635#37325
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'suttle1'
            Title.Caption = #20928#37325
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'car_marque'
            ReadOnly = True
            Title.Caption = #36710#22411
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'car_number'
            ReadOnly = True
            Title.Caption = #36710#21495
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'carry_weight1'
            ReadOnly = True
            Title.Caption = #36733#37325
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'self_weight1'
            ReadOnly = True
            Title.Caption = #33258#37325
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'yk_weight'
            ReadOnly = True
            Title.Caption = #30408#20111
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'breed'
            ReadOnly = True
            Title.Caption = #23186#31181
            Width = 45
            Visible = True
          end
          item
            Color = clRed
            Expanded = False
            FieldName = 'Pstation'
            Title.Caption = #21040#31449
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'past_date'
            ReadOnly = True
            Title.Caption = #26085#26399
            Width = 45
            Visible = True
          end>
      end
    end
    object Panel4: TPanel
      Left = 308
      Top = 0
      Width = 670
      Height = 504
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = 'Panel4'
      TabOrder = 1
      object judgmentStation: TDBEdit
        Left = 320
        Top = 152
        Width = 121
        Height = 21
        DataField = 'station'
        DataSource = DataSource2
        TabOrder = 2
        Visible = False
      end
      object Panel6: TPanel
        Left = 1
        Top = 456
        Width = 668
        Height = 47
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          668
          47)
        object btn_print: TButton
          Left = 476
          Top = 14
          Width = 83
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #25968#25454#25171#21360'(&P)'
          TabOrder = 0
          OnClick = btn_printClick
        end
        object btn_csv: TButton
          Left = 572
          Top = 14
          Width = 83
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #25968#25454#19978#25253'(&D)'
          TabOrder = 1
          OnClick = btn_csvClick
        end
      end
      object DBGrid2: TDBGrid
        Left = 1
        Top = 1
        Width = 668
        Height = 455
        Align = alClient
        DataSource = DataSource2
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        PopupMenu = Popup2
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
            FieldName = 'sn'
            Title.Caption = #36742#24207
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'total_weight1'
            Title.Caption = #24635#37325
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'suttle1'
            Title.Caption = #20928#37325
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'car_marque'
            Title.Caption = #36710#22411
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'car_number'
            Title.Caption = #36710#21495
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'carry_weight1'
            Title.Caption = #36733#37325
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'self_weight1'
            Title.Caption = #33258#37325
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'yk_weight'
            Title.Caption = #30408#20111
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'breed'
            Title.Caption = #29028#31181
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Pstation'
            Title.Caption = #21040#31449
            Width = 99
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'past_date'
            Title.Caption = #26085#26399
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'past_time'
            Title.Caption = #26102#38388
            Width = 70
            Visible = True
          end>
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 256
    Top = 136
    object N8: TMenuItem
      Caption = #28155#21152#32534#36710#32452
      OnClick = N8Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = #25968#25454#27719#24635
      OnClick = N5Click
    end
    object N7: TMenuItem
      Caption = #32534#36753#21040#31449
      OnClick = N7Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N13: TMenuItem
      Caption = #21024#38500#35760#24405
      OnClick = N13Click
    end
    object N4: TMenuItem
      Caption = #20851#20110
      OnClick = N4Click
    end
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnection1
    Parameters = <>
    Left = 352
    Top = 8
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 312
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet2
    Left = 272
    Top = 48
  end
  object ADODataSet2: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandText = 
      'select sn,total_weight1,suttle1,car_marque,car_number,carry_weig' +
      'ht1,self_weight1,yk_weight,breed,Pstation,past_date,past_time fr' +
      'om lt04'
    Parameters = <>
    Left = 240
    Top = 48
    object ADODataSet2total_weight1: TBCDField
      FieldName = 'total_weight1'
      Precision = 9
      Size = 3
    end
    object ADODataSet2suttle1: TBCDField
      FieldName = 'suttle1'
      Precision = 9
      Size = 3
    end
    object ADODataSet2car_marque: TStringField
      FieldName = 'car_marque'
      Size = 25
    end
    object ADODataSet2car_number: TStringField
      FieldName = 'car_number'
      Size = 25
    end
    object ADODataSet2carry_weight1: TBCDField
      FieldName = 'carry_weight1'
      Precision = 9
      Size = 3
    end
    object ADODataSet2self_weight1: TBCDField
      FieldName = 'self_weight1'
      Precision = 9
      Size = 3
    end
    object ADODataSet2yk_weight: TBCDField
      FieldName = 'yk_weight'
      Precision = 9
      Size = 3
    end
    object ADODataSet2breed: TStringField
      FieldName = 'breed'
      Size = 25
    end
    object ADODataSet2Pstation: TStringField
      FieldName = 'Pstation'
      Size = 25
    end
    object ADODataSet2past_date: TDateTimeField
      FieldName = 'past_date'
    end
    object ADODataSet2past_time: TStringField
      FieldName = 'past_time'
      Size = 25
    end
    object ADODataSet2sn: TAutoIncField
      FieldName = 'sn'
      ReadOnly = True
    end
  end
  object dispatchTemplate: TADODataSet
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandText = 
      'select sn,total_weight1,suttle1,car_marque,car_number,carry_weig' +
      'ht1,self_weight1,yk_weight,breed,Pstation,past_date,past_time,st' +
      'ation from dispatchTemplate'
    Parameters = <>
    Left = 536
    Top = 88
    object dispatchTemplatesn: TAutoIncField
      FieldName = 'sn'
      ReadOnly = True
    end
    object dispatchTemplatetotal_weight1: TBCDField
      FieldName = 'total_weight1'
      Precision = 9
      Size = 3
    end
    object dispatchTemplatesuttle1: TBCDField
      FieldName = 'suttle1'
      Precision = 9
      Size = 3
    end
    object dispatchTemplatecar_marque: TStringField
      FieldName = 'car_marque'
      Size = 25
    end
    object dispatchTemplatecar_number: TStringField
      FieldName = 'car_number'
      Size = 25
    end
    object dispatchTemplatecarry_weight1: TBCDField
      FieldName = 'carry_weight1'
      Precision = 9
      Size = 3
    end
    object dispatchTemplateself_weight1: TBCDField
      FieldName = 'self_weight1'
      Precision = 9
      Size = 3
    end
    object dispatchTemplateyk_weight: TBCDField
      FieldName = 'yk_weight'
      Precision = 9
      Size = 3
    end
    object dispatchTemplatebreed: TStringField
      FieldName = 'breed'
      Size = 25
    end
    object dispatchTemplatePstation: TStringField
      FieldName = 'Pstation'
      Size = 25
    end
    object dispatchTemplatepast_date: TDateTimeField
      FieldName = 'past_date'
    end
    object dispatchTemplatepast_time: TStringField
      FieldName = 'past_time'
      Size = 25
    end
    object dispatchTemplatestation: TStringField
      FieldName = 'station'
      Size = 25
    end
  end
  object DataSource2: TDataSource
    DataSet = dispatchTemplate
    Left = 568
    Top = 88
  end
  object Popup2: TPopupMenu
    Left = 520
    Top = 184
    object N1: TMenuItem
      Caption = #21024#38500#36710#36742#32534#32452
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N9: TMenuItem
      Caption = #25968#25454#27719#24635
      OnClick = N5Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object N11: TMenuItem
      Caption = #32534#36753#21040#31449
      OnClick = N7Click
    end
    object N12: TMenuItem
      Caption = #20851#20110
      OnClick = N4Click
    end
  end
  object addDispatch: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 256
    Top = 176
  end
  object delDispatch: TADOQuery
    Connection = add1del
    Parameters = <>
    Left = 520
    Top = 224
  end
  object add1del: TADOConnection
    LoginPrompt = False
    Left = 392
    Top = 8
  end
  object clock: TTimer
    OnTimer = clockTimer
    Left = 520
    Top = 512
  end
  object Timer1: TTimer
    Interval = 7000
    OnTimer = Timer1Timer
    Left = 8
    Top = 488
  end
end
