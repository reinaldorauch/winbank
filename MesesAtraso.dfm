object FmMesesAtraso: TFmMesesAtraso
  Left = 0
  Top = 0
  Caption = 'FmMesesAtraso'
  ClientHeight = 182
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DtpData: TDateTimePicker
    Left = 120
    Top = 80
    Width = 89
    Height = 21
    Date = 41968.794983113420000000
    Time = 41968.794983113420000000
    TabOrder = 0
  end
  object BtnCalc: TButton
    Left = 240
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Calcula'
    TabOrder = 1
    OnClick = BtnCalcClick
  end
end
