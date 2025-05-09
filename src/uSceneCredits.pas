unit uSceneCredits;

interface

// TODO : prendre en charge le changement de bouton "close" de la boite de dialogue ancêtre

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  cDialogBox,
  FMX.Effects,
  FMX.Layouts,
  FMX.Controls.Presentation,
  Olf.FMX.TextImageFrame,
  FMX.Objects;

type
  TCreditsScene = class(TcadDialogBox)
    Text1: TText;
    procedure btnCloseClick(Sender: TObject);
  private
  public
    procedure AfterConstruction; override;
    procedure TranslateTexts(const Language: string); override;

  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  uTxtAboutDescription,
  uTxtAboutLicense;

{ TCreditsScene }

procedure TCreditsScene.AfterConstruction;
begin
  inherited;
  Text1.TextSettings.Font.Size := Text1.TextSettings.Font.Size * 2;
end;

procedure TCreditsScene.btnCloseClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Home;
end;

procedure TCreditsScene.TranslateTexts(const Language: string);
var
  txtLicense: string;
begin
  inherited;

  if (Language = 'fr') then
  begin
    txtLicense := 'Licence';
    txttitle.Text := 'Credits';
  end
  else
  begin
    txtLicense := 'License';
    txttitle.Text := 'Credits';
  end;

  Text1.Text := GetTxtAboutDescription(Language).trim + sLineBreak + sLineBreak
    + '**********' + sLineBreak + '* ' + txtLicense + sLineBreak + sLineBreak +
    GetTxtAboutLicense(Language).trim + sLineBreak + sLineBreak +
    application.MainForm.Caption + ' ' + CAboutCopyright + sLineBreak;

end;

initialization

TScene.RegisterScene<TCreditsScene>(TSceneType.Credits);

end.
