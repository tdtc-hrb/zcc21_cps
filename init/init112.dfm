object frm_init: Tfrm_init
  Left = 292
  Top = 219
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frm_init'
  ClientHeight = 213
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
  object Gauge1: TGauge
    Left = 24
    Top = 176
    Width = 313
    Height = 25
    ForeColor = clRed
    Progress = 22
    Visible = False
  end
  object Label1: TLabel
    Left = 37
    Top = 28
    Width = 80
    Height = 13
    AutoSize = False
    Caption = #26381#21153#22120#21517#31216#65306
  end
  object Label3: TLabel
    Left = 25
    Top = 60
    Width = 96
    Height = 13
    AutoSize = False
    Caption = #25968#25454#24211#31649#29702#21592#65306
  end
  object Label4: TLabel
    Left = 38
    Top = 96
    Width = 72
    Height = 13
    Caption = #31649#29702#21592#23494#30721#65306
  end
  object btn_start: TButton
    Left = 24
    Top = 136
    Width = 75
    Height = 25
    Caption = #24320#22987'(&B)'
    Enabled = False
    TabOrder = 4
    OnClick = btn_startClick
  end
  object edt_dbpass: TEdit
    Left = 136
    Top = 94
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object edt_dbusername: TEdit
    Left = 136
    Top = 57
    Width = 201
    Height = 21
    TabOrder = 2
  end
  object edt_srv: TEdit
    Left = 136
    Top = 24
    Width = 201
    Height = 21
    TabOrder = 1
    Text = 'ZLNR1SERVER'
  end
  object btnPrepared: TButton
    Left = 264
    Top = 136
    Width = 75
    Height = 25
    Caption = #39044#22788#29702'(&P)'
    TabOrder = 0
    OnClick = btnPreparedClick
  end
  object ADOConnection_init: TADOConnection
    LoginPrompt = False
  end
  object ADOCommand1: TADOCommand
    Connection = ADOConnection_init
    Parameters = <>
    Left = 40
  end
  object ADOStoredProc1: TADOStoredProc
    Connection = ADOConnection_init
    Parameters = <>
    Left = 80
  end
end
