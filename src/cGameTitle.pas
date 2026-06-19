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
  Signature : 34f781d412e7def4d1441f15f450186f80f6d4fe
  ***************************************************************************
*)

unit cGameTitle;

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
  Olf.FMX.TextImageFrame,
  FMX.Effects;

type
  TcadGameTitle = class(TFrame)
    txtGameTitle: TOlfFMXTextImageFrame;
    GlowEffect1: TGlowEffect;
    procedure FrameResized(Sender: TObject);
  private
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  uConsts,
  udmAdobeStock_443346276Bidioo;

procedure TcadGameTitle.AfterConstruction;
begin
  inherited;
  txtGameTitle.BeginUpdate;
  try
    txtGameTitle.Font := dmAdobeStock_443346276Bidioo.ImageList;
    txtGameTitle.AutoSize := true;
    txtGameTitle.Text := CAboutGameTitle;
  finally
    txtGameTitle.EndUpdate;
  end;
end;

procedure TcadGameTitle.FrameResized(Sender: TObject);
begin
  txtGameTitle.Refresh;
end;

end.
