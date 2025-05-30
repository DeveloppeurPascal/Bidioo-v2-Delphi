﻿(* C2PP
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
  File last update : 2025-05-30T15:47:50.000+02:00
  Signature : 0a801ac18e79a34ec315fe62ab4dcb542fb41f2e
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
    flBonus: TFlowLayout;
    procedure lGameZoneResized(Sender: TObject);
    procedure FrameResized(Sender: TObject);
  private
    procedure SetNbLives(const Value: cardinal);
    procedure SetScore(const Value: cardinal);
    function GetNbLives: cardinal;
    function GetScore: cardinal;
  protected
    procedure ClearBonusLayout;
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
    procedure ShowScene; override;
    procedure HideScene; override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  USVGFruitsKolopach,
  uBidiooGameData,
  uUIElements,
  Gamolf.RTL.UIElements,
  Gamolf.RTL.Joystick,
  udmAdobeStock_257148021,
  Gamolf.FMX.MusicLoop,
  uSoundEffects,
  uConfig;

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
      lScoreAndBonus.width := 350;
      if lScoreAndBonus.width > width / 5 then
        lScoreAndBonus.width := width / 5;
    finally
      lScoreAndBonus.EndUpdate;
    end;
  end
  else
  begin
    lScoreAndBonus.BeginUpdate;
    try
      lScoreAndBonus.Align := TAlignLayout.bottom;
      lScoreAndBonus.height := 200;
      if lScoreAndBonus.height > height / 5 then
        lScoreAndBonus.height := height / 5;
    finally
      lScoreAndBonus.EndUpdate;
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

function TGameScene.GetNbLives: cardinal;
begin
  result := TBidiooGameData.Current.NbLives;
end;

function TGameScene.GetScore: cardinal;
begin
  result := TBidiooGameData.Current.Score;
end;

procedure TGameScene.DoMusicOnOff(Sender: TObject);
begin
  if TMusicLoop.Current.IsPlaying then
    TMusicLoop.Current.Stop
  else
    TMusicLoop.Current.Play;
  GetBonus(TSVGIconesKolopachIndex.Music).IsPressed :=
    TMusicLoop.Current.IsPlaying;
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
    TSoundEffects.Current.StopAll;
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

procedure TGameScene.RemoveBonus(const BonusType: TSVGIconesKolopachIndex);
var
  btn: TbtnImageButton;
begin
  btn := GetBonus(BonusType);
  if assigned(btn) then
    btn.free;
end;

procedure TGameScene.SetNbLives(const Value: cardinal);
begin
  if (Value <> TBidiooGameData.Current.NbLives) then
  begin
    TBidiooGameData.Current.NbLives := Value;
    if TBidiooGameData.Current.NbLives < 1 then
    begin
      TBidiooGameData.Current.StopGame;
      TScene.Current := TSceneType.GameOver;
    end;
  end;
  AddBonus(TSVGIconesKolopachIndex.Coeur).Number :=
    TBidiooGameData.Current.NbLives;
end;

procedure TGameScene.SetScore(const Value: cardinal);
begin
  TBidiooGameData.Current.Score := Value;
  txtScore.Text := Score.ToString;
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
      Score := Score + Nb * item;
      TSoundEffects.Play(TSoundEffectType.CaseEnMoins);
    end;
  cadMatch3Game1.OnMoveButNoMatch3Proc := procedure
    begin
      NbLives := NbLives - 1;
      TSoundEffects.Play(TSoundEffectType.PerteDUneVie);
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
    IsPressed := TMusicLoop.Current.IsPlaying;
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
  AddBonus(TSVGIconesKolopachIndex.Coeur).OnClick := nil;
  // TODO : charger les boutons des bonus disponibles dans la partie en cours

  Score := TBidiooGameData.Current.Score;
  NbLives := TBidiooGameData.Current.NbLives;
  TBidiooGameData.Current.GameGridToScreenGrid(cadMatch3Game1);

  cadMatch3Game1.StartGame;
end;

initialization

TScene.RegisterScene<TGameScene>(TSceneType.Game);

end.
