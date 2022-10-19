object data_abstract: Tdata_abstract
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  Dependencies = <
    item
      Name = 'MSSQLSERVER'
      IsGroup = False
    end>
  DisplayName = 'CPS_abstract'
  WaitHint = 0
  OnContinue = ServiceContinue
  OnPause = ServicePause
  OnStart = ServiceStart
  OnStop = ServiceStop
  Left = 378
  Top = 202
  Height = 121
  Width = 291
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 32
    Top = 8
  end
end
