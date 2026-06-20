object frmOptions: TfrmOptions
  Left = 192
  Top = 103
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 88
  ClientWidth = 194
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlOptions: TPanel
    Left = 0
    Top = 0
    Width = 194
    Height = 88
    Align = alClient
    BorderStyle = bsSingle
    Color = clSilver
    TabOrder = 0
    object grpBoxLanguage: TGroupBox
      Left = 3
      Top = 3
      Width = 185
      Height = 46
      Caption = '[ Language ]'
      TabOrder = 0
      object comboBoxLanguage: TComboBox
        Left = 8
        Top = 16
        Width = 169
        Height = 21
        Style = csDropDownList
        Color = 9224443
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object bbtnOk: TBitBtn
      Left = 112
      Top = 56
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = bbtnOkClick
      Kind = bkOK
    end
  end
end
