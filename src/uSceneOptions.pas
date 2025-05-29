(* C2PP
  ***************************************************************************

  Bidioo

  Copyright 2013-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://bidioo.gamolf.fr

  Project site :
  https://github.com/DeveloppeurPascal/Bidioo-v2-Delphi

  ***************************************************************************
  File last update : 2025-05-29T17:10:14.000+02:00
  Signature : 3cf4249ac6c91726ed505c4b3bc1e1e3cccde473
  ***************************************************************************
*)

unit uSceneOptions;

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
  FMX.Objects,
  cImageButton,
  USVGIconesKolopach,
  _ButtonsAncestor;

type
  TOptionsScene = class(TcadDialogBox)
    FlowLayout1: TFlowLayout;
    procedure btnOkClick(Sender: TObject);
  private
  protected
  var
    FBtnClassic, FBtnMixte, FBtnMaster: TbtnImageButton;
    procedure btnClassicClick(Sender: TObject);
    procedure btnMixteClick(Sender: TObject);
    procedure btnMasterClick(Sender: TObject);
    procedure btnMusicClick(Sender: TObject);
    procedure btnSoundEffectClick(Sender: TObject);
    procedure btnShowTutorialClick(Sender: TObject);
  public
    procedure TranslateTexts(const Language: string); override;
    procedure AddText(const Text: String);
    function AddButton(const ButtonType: TSVGIconesKolopachIndex;
      const Value: boolean; const OnClick: TNotifyEvent;
      const AddLineBreak: boolean = false): TbtnImageButton;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  udmAdobeStock_257148021,
  uConfig,
  uBidiooConfig,
  uBackgroundMusic,
  uSoundEffects,
  uBidiooGameData;

function TOptionsScene.AddButton(const ButtonType: TSVGIconesKolopachIndex;
  const Value: boolean; const OnClick: TNotifyEvent;
  const AddLineBreak: boolean): TbtnImageButton;
begin
  result := TbtnImageButton.Create(Self);
  result.Parent := FlowLayout1;
  result.Margins.Right := 10;
  result.Margins.bottom := 10;
  result.Kind := ButtonType;
  result.IsPressedButton := true;
  result.IsPressed := Value;
  result.OnClick := OnClick;

  if AddLineBreak then
  begin
    TFlowLayoutBreak.Create(Self).Parent := FlowLayout1;

    if FlowLayout1.height < result.position.y + result.height + result.Margins.bottom
    then
      FlowLayout1.height := FlowLayout1.height + result.height +
        result.Margins.bottom;
  end;
end;

procedure TOptionsScene.AddText(const Text: String);
var
  txt: TOlfFMXTextImageFrame;
begin
  txt := TOlfFMXTextImageFrame.Create(Self);
  txt.Parent := FlowLayout1;
  txt.height := 40;
  txt.Margins.bottom := 10;
  txt.Font := dmAdobeStock_257148021.ImageList;
  txt.Text := Text;

  TFlowLayoutBreak.Create(Self).Parent := FlowLayout1;

  if FlowLayout1.height < txt.position.y + txt.height + txt.Margins.bottom then
    FlowLayout1.height := FlowLayout1.height + txt.height + txt.Margins.bottom;
end;

procedure TOptionsScene.btnClassicClick(Sender: TObject);
begin
  if not assigned(FBtnClassic) then
    exit;

  if FBtnClassic.IsPressed then
  begin
    FBtnMixte.IsPressed := false;
    FBtnMaster.IsPressed := false;
    tconfig.Current.PlayMode := TBidiooPlayMode.Classic;
    TBidiooGameData.Current.Load;
  end
  else
    FBtnClassic.IsPressed := true;
end;

procedure TOptionsScene.btnMasterClick(Sender: TObject);
begin
  if not assigned(FBtnMaster) then
    exit;

  if FBtnMaster.IsPressed then
  begin
    FBtnClassic.IsPressed := false;
    FBtnMixte.IsPressed := false;
    tconfig.Current.PlayMode := TBidiooPlayMode.Master;
    TBidiooGameData.Current.Load;
  end
  else
    FBtnMaster.IsPressed := true;
end;

procedure TOptionsScene.btnMixteClick(Sender: TObject);
begin
  if not assigned(FBtnMixte) then
    exit;

  if FBtnMixte.IsPressed then
  begin
    FBtnClassic.IsPressed := false;
    FBtnMaster.IsPressed := false;
    tconfig.Current.PlayMode := TBidiooPlayMode.Mixte;
    TBidiooGameData.Current.Load;
  end
  else
    FBtnMixte.IsPressed := true;
end;

procedure TOptionsScene.btnMusicClick(Sender: TObject);
begin
  if not(Sender is TbtnImageButton) then
    exit;
  TBackgroundMusic.Current.OnOff((Sender as TbtnImageButton).IsPressed);
end;

procedure TOptionsScene.btnOkClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Home;
end;

procedure TOptionsScene.btnShowTutorialClick(Sender: TObject);
begin
  if not(Sender is TbtnImageButton) then
    exit;
  tconfig.Current.ShowTutorial := (Sender as TbtnImageButton).IsPressed;
end;

procedure TOptionsScene.btnSoundEffectClick(Sender: TObject);
begin
  if not(Sender is TbtnImageButton) then
    exit;
  tconfig.Current.SoundEffectsOnOff := (Sender as TbtnImageButton).IsPressed;
  if tconfig.Current.SoundEffectsOnOff then
    // TODO : si son actif, jouer un son pour le confirmer
  else
    TSoundEffects.Current.StopAll;
end;

constructor TOptionsScene.Create(AOwner: TComponent);
begin
  inherited;
  FBtnClassic := nil;
  FBtnMixte := nil;
  FBtnMaster := nil;
end;

procedure TOptionsScene.TranslateTexts(const Language: string);
var
  sGraphicMode, sPlayMode, sMusic, sSoundEffets, sTutorial: string;
begin
  inherited;

  if (Language = 'fr') then
  begin
    txttitle.Text := 'Réglages';
    sGraphicMode := 'Type de tuiles';
    sPlayMode := 'Mode de jeu';
    sMusic := 'Musique';
    sSoundEffets := 'Effets sonores';
    sTutorial := 'Tutoriel et aide';
  end
  else
  begin
    txttitle.Text := 'Options';
    sGraphicMode := 'Tiles type';
    sPlayMode := 'Game mode';
    sMusic := 'Music';
    sSoundEffets := 'Sound effects';
    sTutorial := 'Tutorial and help';
  end;

  FlowLayout1.BeginUpdate;
  try
    // Empty the FlowLayout
    while FlowLayout1.ChildrenCount > 0 do
      FlowLayout1.Children[0].Free;
    FlowLayout1.height := 0;
  finally
    FlowLayout1.EndUpdate;
  end;

  // addtext(sGraphicMode);
  // TODO : à compléter quand on aura plusieurs séries d'éléments graphiques

  AddText(sPlayMode);
  // Mixte : active "classic" et "master"
  FBtnMixte := AddButton(TSVGIconesKolopachIndex.GraphicGreen,
    (tconfig.Current.PlayMode = TBidiooPlayMode.Mixte), btnMixteClick);
  // Classic : mode habituel par swap de tuiles
  FBtnClassic := AddButton(TSVGIconesKolopachIndex.GraphicOrange,
    (tconfig.Current.PlayMode = TBidiooPlayMode.Classic), btnClassicClick);
  // Master : déplacement de lignes complètes
  FBtnMaster := AddButton(TSVGIconesKolopachIndex.GraphicRed,
    (tconfig.Current.PlayMode = TBidiooPlayMode.Master), btnMasterClick, true);

  AddText(sMusic);
  AddButton(TSVGIconesKolopachIndex.Music, TBackgroundMusic.Current.isOn,
    btnMusicClick, true);
  // TODO : ajouter la gestion du volume de la musique d'ambiance

  AddText(sSoundEffets);
  AddButton(TSVGIconesKolopachIndex.Micro, tconfig.Current.SoundEffectsOnOff,
    btnSoundEffectClick, true);
  // TODO : ajouter la gestion du volume des effets sonores

  AddText(sTutorial);
  AddButton(TSVGIconesKolopachIndex.Help, tconfig.Current.ShowTutorial,
    btnShowTutorialClick, true);
end;

initialization

TScene.RegisterScene<TOptionsScene>(TSceneType.Options);

end.
