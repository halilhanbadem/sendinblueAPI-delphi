object Main: TMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'sendinblueAPIDemo'
  ClientHeight = 239
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnSend: TButton
    Left = 128
    Top = 17
    Width = 241
    Height = 49
    Caption = 'Send Mail'
    TabOrder = 0
    OnClick = btnSendClick
  end
  object Button1: TButton
    Left = 128
    Top = 92
    Width = 241
    Height = 49
    Caption = 'Send Mail With PDF File'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 128
    Top = 147
    Width = 241
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object Button2: TButton
    Left = 128
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Selected'
    TabOrder = 3
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'PDF File|*.pdf'
    Left = 468
    Top = 113
  end
end
