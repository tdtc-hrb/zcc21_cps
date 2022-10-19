object frm_init: Tfrm_init
  Left = 302
  Top = 332
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frm_init'
  ClientHeight = 117
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn_star: TButton
    Left = 16
    Top = 80
    Width = 75
    Height = 25
    Caption = #24320#22987'(&B)'
    Enabled = False
    TabOrder = 0
    OnClick = btn_starClick
  end
  object btn_stop: TButton
    Left = 280
    Top = 80
    Width = 75
    Height = 25
    Caption = #39044#22788#29702'(&P)'
    TabOrder = 1
    OnClick = btn_stopClick
  end
  object Panel1: TPanel
    Left = 16
    Top = 24
    Width = 337
    Height = 41
    BevelOuter = bvNone
    Caption = #35831#27491#30830#37197#32622#38142#25509#25991#20214#65292#28982#21518#36827#34892#31995#32479#21021#22987#21270#24037#20316#65281
    TabOrder = 2
    object Gauge1: TGauge
      Left = 0
      Top = 8
      Width = 337
      Height = 25
      ForeColor = clRed
      Progress = 12
      Visible = False
    end
  end
  object ADOConnection_init: TADOConnection
    LoginPrompt = False
  end
  object ADOCommand1: TADOCommand
    Connection = ADOConnection_init
    Parameters = <>
    Left = 40
  end
  object AdataSet_query: TADODataSet
    Connection = ADOConnection_init
    Parameters = <>
    Left = 80
  end
end
