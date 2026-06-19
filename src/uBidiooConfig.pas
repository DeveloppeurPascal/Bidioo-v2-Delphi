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
  Signature : 56969b59f78acd85b6e0ef491526071bb395f60a
  ***************************************************************************
*)

unit uBidiooConfig;

interface

uses
  uConfig;

Type
  TBidiooPlayMode = (Classic, Mixte, Master);
  TBidiooGraphicMode = (KolopachFruits);

  TConfigHelpers = class helper for TConfig
  private
    procedure SetGraphicMode(const Value: TBidiooGraphicMode);
    procedure SetPlayMode(const Value: TBidiooPlayMode);
    procedure SetShowTutorial(const Value: boolean);
    function GetGraphicMode: TBidiooGraphicMode;
    function GetPlayMode: TBidiooPlayMode;
    function GetShowTutorial: boolean;
  public
    property ShowTutorial: boolean read GetShowTutorial write SetShowTutorial;
    property PlayMode: TBidiooPlayMode read GetPlayMode write SetPlayMode;
    property GraphicMode: TBidiooGraphicMode read GetGraphicMode
      write SetGraphicMode;
  end;

implementation

{ TConfigHelpers }

function TConfigHelpers.GetGraphicMode: TBidiooGraphicMode;
begin
  result := TBidiooGraphicMode(GetParams.getValue('BidiooGraphicMode',
    ord(TBidiooGraphicMode.KolopachFruits)));
end;

function TConfigHelpers.GetPlayMode: TBidiooPlayMode;
begin
  result := TBidiooPlayMode(GetParams.getValue('BidiooPlayMode',
    ord(TBidiooPlayMode.Mixte)));
end;

function TConfigHelpers.GetShowTutorial: boolean;
begin
  result := GetParams.getValue('BidiooShowTutorial', true);
end;

procedure TConfigHelpers.SetGraphicMode(const Value: TBidiooGraphicMode);
begin
  GetParams.SetValue('BidiooGraphicMode', ord(Value));
  GetParams.Save;
end;

procedure TConfigHelpers.SetPlayMode(const Value: TBidiooPlayMode);
begin
  GetParams.SetValue('BidiooPlayMode', ord(Value));
  GetParams.Save;
end;

procedure TConfigHelpers.SetShowTutorial(const Value: boolean);
begin
  GetParams.SetValue('BidiooShowTutorial', Value);
  GetParams.Save;
end;

end.
