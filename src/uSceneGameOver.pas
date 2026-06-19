(* C2PP
  ***************************************************************************

  Bidioo
  Copyright (c) 2013-2026 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://bidioo.gamolf.fr

  Project site :
  https://github.com/DeveloppeurPascal/Bidioo-v2-Delphi

  ***************************************************************************
  File last update : 2026-06-19T18:19:18.197+02:00
  Signature : 98767d3c8cec731db215c7cd1fb8c2655f3bcba1
  ***************************************************************************
*)

unit uSceneGameOver;

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
  _ButtonsAncestor,
  cImageButton;

type
  TGameOverScene = class(TcadDialogBox)
    procedure btnOkClick(Sender: TObject);
  private
  public
    procedure TranslateTexts(const Language: string); override;
    procedure ShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  uBidiooGameData,
  uBidiooScores,
  uSoundEffects;

procedure TGameOverScene.btnOkClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Home;
end;

procedure TGameOverScene.ShowScene;
begin
  inherited;

  TBidiooScores.Current.Add(TBidiooGameData.Current.Score);

  TSoundEffects.Current.StopAll;
  TSoundEffects.Current.Play(TSoundEffectType.FinDePartie);
end;

procedure TGameOverScene.TranslateTexts(const Language: string);
begin
  inherited;

  FlowLayout1.BeginUpdate;
  try
    // Empty the FlowLayout
    while FlowLayout1.ChildrenCount > 0 do
      FlowLayout1.Children[0].Free;
    FlowLayout1.height := 0;
  finally
    FlowLayout1.EndUpdate;
  end;

  if (Language = 'fr') then
  begin
    txtTitle.Text := 'Game Over';
    AddText('Votre score final:');
    AddText(TBidiooGameData.Current.Score.ToString);
  end
  else
  begin
    txtTitle.Text := 'Game Over';
    AddText('Your final score:');
    AddText(TBidiooGameData.Current.Score.ToString);
  end;
end;

initialization

TScene.RegisterScene<TGameOverScene>(TSceneType.GameOver);

end.
