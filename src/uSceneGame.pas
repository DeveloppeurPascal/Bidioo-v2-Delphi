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
  File last update : 2025-06-01T17:58:26.000+02:00
  Signature : 9fa57e19dd9525371a0ee6149be9466b34cd4164
  ***************************************************************************
*)

unit uSceneGame;

interface

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
  cMatch3Game,
  FMX.Layouts,
  Olf.FMX.TextImageFrame,
  cImageButton,
  USVGIconesKolopach;

type
  TGameScene = class(T__SceneAncestor)
    lGameZone: TLayout;
    cadMatch3Game1: TcadMatch3Game;
    lScoreAndBonus: TLayout;
    txtScore: TOlfFMXTextImageFrame;
    lScore: TLayout;
    vsBonus: TVertScrollBox;
    flBonus: TFlowLayout;
    procedure lGameZoneResized(Sender: TObject);
    procedure FrameResized(Sender: TObject);
    procedure lScoreResized(Sender: TObject);
    procedure vsBonusResized(Sender: TObject);
  private
    procedure SetNbLives(const Value: cardinal);
    procedure SetScore(const Value: cardinal);
    function GetNbLives: cardinal;
    function GetScore: cardinal;
    procedure SetGameLevel(const Value: cardinal);
    function GetGameLevel: cardinal;
  protected
    procedure ClearBonusLayout;
    procedure RepaintBonusLayout;
    function AddBonus(const BonusType: TSVGIconesKolopachIndex)
      : TbtnImageButton;
    procedure RemoveBonus(const BonusType: TSVGIconesKolopachIndex);
    function GetBonus(const BonusType: TSVGIconesKolopachIndex)
      : TbtnImageButton;
    procedure DoPause(Sender: TObject);
    procedure DoMusicOnOff(Sender: TObject);
    procedure DoSoundsOnOff(Sender: TObject);
  public
    procedure AfterConstruction; override;
    property Score: cardinal read GetScore write SetScore;
    property NbLives: cardinal read GetNbLives write SetNbLives;
    property GameLevel: cardinal read GetGameLevel write SetGameLevel;
    procedure ShowScene; override;
    procedure HideScene; override;
  end;

implementation

{$R *.fmx}

uses
  System.Math,
  uScene,
  uConsts,
  USVGFruitsKolopach,
  uBidiooGameData,
  uUIElements,
  Gamolf.RTL.UIElements,
  Gamolf.RTL.Joystick,
  udmAdobeStock_257148021,
  uSoundEffects,
  uConfig,
  uBackgroundMusic,
  uBidiooConfig;

{ TGameScene }

function TGameScene.AddBonus(const BonusType: TSVGIconesKolopachIndex)
  : TbtnImageButton;
begin
  result := GetBonus(BonusType);
  if not assigned(result) then
  begin
    result := TbtnImageButton.Create(self);
    result.Parent := flBonus;
    result.Kind := BonusType;
    result.ShowNumber := true;
  end;
end;

procedure TGameScene.AfterConstruction;
begin
  inherited;
  txtScore.BeginUpdate;
  try
    txtScore.Font := dmAdobeStock_257148021.ImageList;
    txtScore.AutoSize := true;
    txtScore.Text := '0';
  finally
    txtScore.EndUpdate;
  end;
end;

procedure TGameScene.ClearBonusLayout;
begin
  while flBonus.ChildrenCount > 0 do
    flBonus.Children[0].free;
end;

procedure TGameScene.FrameResized(Sender: TObject);
begin
  if width > height then
  begin
    lScoreAndBonus.BeginUpdate;
    try
      lScoreAndBonus.Align := TAlignLayout.Left;
      lScoreAndBonus.width := min(4 * CMaximalHeightForBonusButtons, width / 5);
    finally
      lScoreAndBonus.EndUpdate;
    end;
  end
  else
  begin
    lScoreAndBonus.BeginUpdate;
    try
      lScoreAndBonus.Align := TAlignLayout.bottom;
      lScoreAndBonus.height := min(3 * CMaximalHeightForBonusButtons,
        height / 5);
    finally
      lScoreAndBonus.EndUpdate;
      lScore.height := min(CMaximalHeightForBonusButtons,
        lScoreAndBonus.height / 2 - lScore.Margins.Top - lScore.Margins.bottom);
    end;
  end;
end;

function TGameScene.GetBonus(const BonusType: TSVGIconesKolopachIndex)
  : TbtnImageButton;
var
  i: integer;
begin
  result := nil;
  for i := 0 to flBonus.ChildrenCount - 1 do
    if (flBonus.Children[i] is TbtnImageButton) and
      ((flBonus.Children[i] as TbtnImageButton).Kind = BonusType) then
    begin
      result := flBonus.Children[i] as TbtnImageButton;
      break;
    end;
end;

function TGameScene.GetGameLevel: cardinal;
begin
  result := TBidiooGameData.Current.Level;
end;

function TGameScene.GetNbLives: cardinal;
begin
  result := TBidiooGameData.Current.NbLives;
end;

function TGameScene.GetScore: cardinal;
begin
  result := TBidiooGameData.Current.Score;
end;

procedure TGameScene.DoMusicOnOff(Sender: TObject);
var
  btn: TbtnImageButton;
begin
  btn := GetBonus(TSVGIconesKolopachIndex.Music);
  TBackgroundMusic.Current.OnOff(not TBackgroundMusic.Current.IsOn);
  btn.IsPressed := TBackgroundMusic.Current.IsOn;
end;

procedure TGameScene.DoPause(Sender: TObject);
begin
  cadMatch3Game1.StopGame;
  TBidiooGameData.Current.ScreenGridToGameGrid(cadMatch3Game1);
  TBidiooGameData.DefaultGameData.PauseGame;
  TScene.Current := TSceneType.Home;
end;

procedure TGameScene.DoSoundsOnOff(Sender: TObject);
begin
  TConfig.Current.SoundEffectsOnOff := not TConfig.Current.SoundEffectsOnOff;
  if not TConfig.Current.SoundEffectsOnOff then
    TSoundEffects.Current.StopAll
  else
    TSoundEffects.Current.Play(TSoundEffectType.ClicOption);
  GetBonus(TSVGIconesKolopachIndex.Micro).IsPressed :=
    TConfig.Current.SoundEffectsOnOff;
end;

procedure TGameScene.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TGameScene.lGameZoneResized(Sender: TObject);
begin
  cadMatch3Game1.FitInParent;
end;

procedure TGameScene.lScoreResized(Sender: TObject);
begin
  txtScore.Refresh;
end;

procedure TGameScene.RemoveBonus(const BonusType: TSVGIconesKolopachIndex);
var
  btn: TbtnImageButton;
begin
  btn := GetBonus(BonusType);
  if assigned(btn) then
    btn.free;
end;

procedure TGameScene.RepaintBonusLayout;
var
  i: integer;
  h, NewH: single;
  btn: TbtnImageButton;
begin
  // Resize the images buttons in this area (FlowLayout in VertScroll)
  h := min(vsBonus.height, CMaximalHeightForBonusButtons);
  for i := 0 to flBonus.ChildrenCount - 1 do
    if (flBonus.Children[i] is TbtnImageButton) and
      ((flBonus.Children[i] as TbtnImageButton).height <> h) then
      with (flBonus.Children[i] as TbtnImageButton) do
      begin
        BeginUpdate;
        try
          width := h;
          height := h;
        finally
          EndUpdate;
          Repaint;
        end;
      end;

  // Resize the FlowLayout to enable or disable the scroll bar of its parent
  NewH := 0;
  for i := 0 to flBonus.ChildrenCount - 1 do
    if (flBonus.Children[i] is TbtnImageButton) then
    begin
      btn := flBonus.Children[i] as TbtnImageButton;
      h := btn.position.y + btn.height + btn.Margins.bottom;
      if NewH < h then
        NewH := h;
    end;
  flBonus.height := NewH;
end;

procedure TGameScene.SetGameLevel(const Value: cardinal);
begin
  if (Value < 1) then
    exit;

  TBidiooGameData.Current.Level := Value;
  cadMatch3Game1.NbMaxDifferentTiles := CDefaultNbMaxDifferentTiles +
    TBidiooGameData.Current.Level;
  // TODO : jouer un son pour signaler le changement de niveau de jeu
  // TODO : afficher une info lors du premier passage à ce nouveau niveau (gain d'un badge ou autre)
end;

procedure TGameScene.SetNbLives(const Value: cardinal);
begin
  TBidiooGameData.Current.NbLives := Value;

  AddBonus(TSVGIconesKolopachIndex.Coeur).Number :=
    TBidiooGameData.Current.NbLives;
end;

procedure TGameScene.SetScore(const Value: cardinal);
begin
  TBidiooGameData.Current.Score := Value;
  txtScore.Text := Score.ToString;

  if (GameLevel < length(CMinScoreForLevel)) and
    (TBidiooGameData.Current.Score > CMinScoreForLevel[GameLevel]) then
    GameLevel := GameLevel + 1;
end;

procedure TGameScene.ShowScene;
const
  CDefaultBlocSize = 256;
var
  item: TUIElement;
  i: integer;
begin
  inherited;

  TUIItemsList.Current.NewLayout;
  item := TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin // TODO : appeler directement GoPause() une fois TUIElements corrigé
      DoPause(Sender);
    end);
  item.KeyShortcuts.Add(vkEscape, #0, []);
  item.KeyShortcuts.Add(vkHardwareBack, #0, []);
  item.GamePadButtons := [TJoystickButtons.X];
  item.TagObject := self;

  cadMatch3Game1.Clear;
  cadMatch3Game1.EnableSwapTiles := TConfig.Current.PlayMode
    in [TBidiooPlayMode.Classic, TBidiooPlayMode.Mixte];
  cadMatch3Game1.EnableMoveLines := TConfig.Current.PlayMode
    in [TBidiooPlayMode.Mixte, TBidiooPlayMode.Master];
  cadMatch3Game1.NbMaxDifferentTiles := CDefaultNbMaxDifferentTiles +
    TBidiooGameData.Current.Level;
  cadMatch3Game1.UseMatchDirection := true;
  cadMatch3Game1.NbCol := TBidiooGameData.Current.ColCount;
  cadMatch3Game1.NbRow := TBidiooGameData.Current.RowCount;
  cadMatch3Game1.BackgroundColor := TAlphaColors.Darkcyan;
  cadMatch3Game1.SelectedBackgroundColor := TAlphaColors.cyan;
  for i := 0 to TSVGFruitsKolopach.Count - 1 do
    cadMatch3Game1.SVGItems[i] := TSVGFruitsKolopach.SVG(i);
  cadMatch3Game1.width := cadMatch3Game1.NbCol * CDefaultBlocSize;
  cadMatch3Game1.height := cadMatch3Game1.NbRow * CDefaultBlocSize;
  cadMatch3Game1.FitInParent;
  cadMatch3Game1.Initialize;
  cadMatch3Game1.OnMatch3Proc := procedure(const Nb, item: integer)
    begin
      Score := Score + trunc(Nb * item) + (TBidiooGameData.Current.Level - 1);
      TSoundEffects.Play(TSoundEffectType.CaseEnMoins);
    end;
  cadMatch3Game1.OnMoveButNoMatch3Proc := procedure
    begin
      if TBidiooGameData.Current.NbLives < 1 then
      begin // No more lives available
        TBidiooGameData.Current.StopGame;
        TScene.Current := TSceneType.GameOver;
      end
      else
      begin // Lost a live
        NbLives := NbLives - 1;
        TSoundEffects.Play(TSoundEffectType.PerteDUneVie);
      end;
    end;

  ClearBonusLayout;
  // Pause Button
  with AddBonus(TSVGIconesKolopachIndex.Pause) do
  begin
    ShowNumber := false;
    OnClick := DoPause;
  end;
  // Music On/Off button
  with AddBonus(TSVGIconesKolopachIndex.Music) do
  begin
    IsPressedButton := true;
    IsPressed := TBackgroundMusic.Current.IsOn;
    ShowNumber := false;
    OnClick := DoMusicOnOff;
  end;
  // Sound On/Off button
  with AddBonus(TSVGIconesKolopachIndex.Micro) do
  begin
    IsPressedButton := true;
    IsPressed := TConfig.Current.SoundEffectsOnOff;
    ShowNumber := false;
    OnClick := DoSoundsOnOff;
  end;
  // Nb Lives
  with AddBonus(TSVGIconesKolopachIndex.Coeur) do
  begin
    OnClick := nil;
    HitTest := false;
  end;
  // TODO : charger les boutons des bonus disponibles dans la partie en cours
  RepaintBonusLayout;

  Score := TBidiooGameData.Current.Score;
  NbLives := TBidiooGameData.Current.NbLives;
  TBidiooGameData.Current.GameGridToScreenGrid(cadMatch3Game1);

  cadMatch3Game1.StartGame;
end;

procedure TGameScene.vsBonusResized(Sender: TObject);
begin
  RepaintBonusLayout;
end;

initialization

TScene.RegisterScene<TGameScene>(TSceneType.Game);

end.
