object FmReports: TFmReports
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rios'
  ClientHeight = 192
  ClientWidth = 457
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
  object Label1: TLabel
    Left = 208
    Top = 10
    Width = 66
    Height = 13
    Caption = 'Data de In'#237'cio'
  end
  object Label2: TLabel
    Left = 208
    Top = 61
    Width = 57
    Height = 13
    Caption = 'Data de Fim'
  end
  object RgReports: TRadioGroup
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 185
    Height = 172
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alLeft
    Caption = 'Selecione o Relat'#243'rio'
    Items.Strings = (
      'Bancos'
      'Clientes'
      'Cheques - Emiss'#227'o'
      'Cheques - Pagos'
      'Cheques - Em Aberto')
    TabOrder = 0
    OnClick = RgReportsClick
  end
  object DtpInicio: TDateTimePicker
    Left = 208
    Top = 29
    Width = 97
    Height = 21
    Date = 41954.822585462960000000
    Time = 41954.822585462960000000
    TabOrder = 1
  end
  object DtpFim: TDateTimePicker
    Left = 208
    Top = 80
    Width = 97
    Height = 21
    Date = 41954.822585462960000000
    Time = 41954.822585462960000000
    TabOrder = 2
  end
  object BtnPreview: TButton
    Left = 374
    Top = 159
    Width = 75
    Height = 25
    Action = AcPreview
    TabOrder = 3
  end
  object BtnPrint: TButton
    Left = 293
    Top = 159
    Width = 75
    Height = 25
    Action = AcPrint
    TabOrder = 4
  end
  object BtnClose: TButton
    Left = 212
    Top = 159
    Width = 75
    Height = 25
    Action = AcClose
    TabOrder = 5
  end
  object AlReports: TActionList
    OnExecute = AlReportsExecute
    Left = 416
    Top = 80
    object AcPreview: TAction
      Caption = 'Visualizar'
      OnExecute = AcPreviewExecute
    end
    object AcPrint: TAction
      Caption = 'Imprimir'
    end
    object AcClose: TAction
      Caption = 'Fechar'
      OnExecute = AcCloseExecute
    end
  end
end
