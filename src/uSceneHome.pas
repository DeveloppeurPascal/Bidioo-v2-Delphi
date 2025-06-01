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
  File last update : 2025-06-01T18:28:08.000+02:00
  Signature : 74b14a813c3fdcd1a537b14dba9f599793f2248c
  ***************************************************************************
*)

unit uSceneHome;

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
  uUIElements,
  uBidiooGameData;

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
  if TBidiooGameData.Current.IsPaused then
    TBidiooGameData.Current.ContinueGame
  else
    TBidiooGameData.Current.StartANewGame;
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
