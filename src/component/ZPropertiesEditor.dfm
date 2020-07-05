object frmPropertyEditor: TfrmPropertyEditor
  Left = 352
  Top = 176
  Width = 691
  Height = 481
  Caption = 'Edit Properties ...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 262
    Width = 675
    Height = 4
    Cursor = crVSplit
    Align = alBottom
  end
  object pnlProps: TPanel
    Left = 0
    Top = 0
    Width = 675
    Height = 262
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 8
    TabOrder = 0
    object spltProps: TSplitter
      Left = 305
      Top = 8
      Width = 4
      Height = 246
    end
    object bgPropsUsed: TGroupBox
      Left = 8
      Top = 8
      Width = 297
      Height = 246
      Align = alLeft
      Caption = 'Used properties'
      TabOrder = 0
      DesignSize = (
        297
        246)
      object lbUsed: TListBox
        Left = 8
        Top = 16
        Width = 249
        Height = 222
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbUsedClick
      end
      object btnAdd: TButton
        Left = 264
        Top = 16
        Width = 25
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '<'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnAddClick
      end
      object btnRemove: TButton
        Left = 264
        Top = 48
        Width = 25
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnRemoveClick
      end
    end
    object gbAvailable: TGroupBox
      Left = 309
      Top = 8
      Width = 358
      Height = 246
      Align = alClient
      TabOrder = 1
      DesignSize = (
        358
        246)
      object lbAvailable: TListBox
        Left = 8
        Top = 15
        Width = 342
        Height = 222
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbAvailableClick
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 266
    Width = 675
    Height = 176
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      675
      176)
    object lblProtocol: TLabel
      Left = 8
      Top = 144
      Width = 104
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Protocol: <undefined>'
    end
    object lblServerProvider: TLabel
      Left = 136
      Top = 144
      Width = 135
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'ServerProvider: <undefined>'
      Visible = False
    end
    object lblHostversion: TLabel
      Left = 304
      Top = 144
      Width = 68
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Hostversion: 0'
      Visible = False
    end
    object lblClientVersion: TLabel
      Left = 408
      Top = 144
      Width = 73
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'ClientVersion: 0'
      Visible = False
    end
    object pnlValDesc: TPanel
      Left = 0
      Top = 0
      Width = 675
      Height = 137
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      BorderWidth = 8
      TabOrder = 0
      object Splitter2: TSplitter
        Left = 305
        Top = 8
        Height = 121
      end
      object gbVal: TGroupBox
        Left = 8
        Top = 8
        Width = 297
        Height = 121
        Align = alLeft
        Caption = 'Value'
        TabOrder = 0
        DesignSize = (
          297
          121)
        object cbEnum: TComboBox
          Left = 8
          Top = 48
          Width = 281
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 0
        end
        object cbBoolean: TCheckBox
          Left = 8
          Top = 72
          Width = 281
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Boolean'
          TabOrder = 1
          OnClick = cbBooleanClick
        end
        object edString: TEdit
          Left = 8
          Top = 16
          Width = 281
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
      end
      object gbDescription: TGroupBox
        Left = 308
        Top = 8
        Width = 359
        Height = 121
        Align = alClient
        Caption = 'Purpose/Description'
        TabOrder = 1
        DesignSize = (
          359
          121)
        object mmDescrption: TMemo
          Left = 8
          Top = 16
          Width = 343
          Height = 97
          Anchors = [akLeft, akTop, akRight, akBottom]
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
    object btnOK: TButton
      Left = 512
      Top = 144
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 592
      Top = 144
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
end
