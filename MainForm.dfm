object Main: TMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'sendinblueAPIDemo'
  ClientHeight = 91
  ClientWidth = 493
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
end
