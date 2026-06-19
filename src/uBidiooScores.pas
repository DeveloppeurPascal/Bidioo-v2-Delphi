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
  File last update : 2026-06-19T18:19:18.185+02:00
  Signature : 96886f20d8d18b81e1044067992f27532828183e
  ***************************************************************************
*)

unit uBidiooScores;

interface

uses
  Gamolf.RTL.Scores;

Type
  TBidiooScores = class(TScoreList)
  private
  protected
  public
    class function Current: TBidiooScores;
  end;

implementation

uses
  uConsts;

var
  BidiooScores: TBidiooScores;

  { TBidiooScores }

class function TBidiooScores.Current: TBidiooScores;
begin
  if not assigned(BidiooScores) then
  begin
    // TODO : prendre en charge le chiffrement du fichier de stockage des scores
    BidiooScores := TBidiooScores.Create(CEditorFolderName, CGameFolderName);
    BidiooScores.load;
  end;
  result := BidiooScores;
end;

initialization

BidiooScores := nil;

finalization

BidiooScores.Free;

end.
