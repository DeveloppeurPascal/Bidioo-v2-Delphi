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
  Signature : af3252886a83d8dfcb51666191cdbb92af5c8125
  ***************************************************************************
*)

unit uSceneHallOfFame;

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
  THallOfFameScene = class(TcadDialogBox)
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
  uBidiooScores;

procedure THallOfFameScene.btnOkClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Home;
end;

procedure THallOfFameScene.ShowScene;
var
  i, nb: integer;
  PrecScore: int64;
begin
  inherited;

  TBidiooScores.Current.SortByPointsDesc;

  FlowLayout1.BeginUpdate;
  try
    // Empty the FlowLayout
    while FlowLayout1.ChildrenCount > 0 do
      FlowLayout1.Children[0].Free;
    FlowLayout1.height := 0;
  finally
    FlowLayout1.EndUpdate;
  end;

  // Add scores to the FlowLayout
  i := 0;
  nb := 0;
  PrecScore := 0;
  while (i < TBidiooScores.Current.count) and (nb < 100) do
  begin
    if (PrecScore <> TBidiooScores.Current[i].Points) then
    begin
      PrecScore := TBidiooScores.Current[i].Points;
      inc(nb);

      AddText(TBidiooScores.Current[i].Points.ToString);
    end;
    inc(i);
  end;
end;

procedure THallOfFameScene.TranslateTexts(const Language: string);
begin
  inherited;

  if (Language = 'fr') then
  begin
    txttitle.Text := 'Meilleurs scores';
  end
  else
  begin
    txttitle.Text := 'Hall of fame';
  end;
end;

initialization

TScene.RegisterScene<THallOfFameScene>(TSceneType.HallOfFame);

end.
