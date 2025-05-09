unit uSceneHome;

interface

// TODO : agrandir le titre du jeu si la taille de l'écran le permet
// TODO : augmenter la marge entre les boutons de menu si la taille de l'écran le permet (et adapter la taille de leur conteneur)
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
  _ScenesAncestor,
  FMX.Layouts,
  _ButtonsAncestor,
  cImageButton,
  cGameTitle;

type
  THomeScene = class(T__SceneAncestor)
    FlowLayout1: TFlowLayout;
    btnPlay: TbtnImageButton;
    btnScores: TbtnImageButton;
    FlowLayoutBreak1: TFlowLayoutBreak;
    btnOptions: TbtnImageButton;
    btnCredits: TbtnImageButton;
    btnQuit: TbtnImageButton;
    cadGameTitle1: TcadGameTitle;
    Layout1: TLayout;
    procedure btnCreditsClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure btnScoresClick(Sender: TObject);
  private
  public
    procedure ShowScene; override;
    procedure HideScene; override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  USVGIconesKolopach,
  uUIElements;

procedure THomeScene.btnCreditsClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Credits;
end;

procedure THomeScene.btnOptionsClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Options;
end;

procedure THomeScene.btnPlayClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Game;
end;

procedure THomeScene.btnQuitClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Exit;
end;

procedure THomeScene.btnScoresClick(Sender: TObject);
begin
  TScene.Current := TSceneType.HallOfFame;
end;

procedure THomeScene.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure THomeScene.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddQuit;

  btnPlay.Kind := TSVGIconesKolopachIndex.Drapeau;
  btnScores.Kind := TSVGIconesKolopachIndex.Podium;
  btnOptions.Kind := TSVGIconesKolopachIndex.Engrenage;
  btnCredits.Kind := TSVGIconesKolopachIndex.Info;
{$IF Defined(IOS) or Defined(ANDROID)}
  btnQuit.Visible := false;
{$ELSE}
  btnQuit.Kind := TSVGIconesKolopachIndex.Eteindre;
{$ENDIF}
end;

initialization

TScene.RegisterScene<THomeScene>(TSceneType.Home);

end.
