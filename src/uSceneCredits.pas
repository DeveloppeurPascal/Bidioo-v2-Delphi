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
  File last update : 2026-06-19T18:19:18.195+02:00
  Signature : 1a4a014694444f377ace7a3b3bbdd936933f5e13
  ***************************************************************************
*)

unit uSceneCredits;

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
  TCreditsScene = class(TcadDialogBox)
    Text1: TText;
    procedure btnOkClick(Sender: TObject);
  private
  public
    procedure AfterConstruction; override;
    procedure TranslateTexts(const Language: string); override;

  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  uTxtAboutDescription,
  uTxtAboutLicense;

{ TCreditsScene }

procedure TCreditsScene.AfterConstruction;
begin
  inherited;
  Text1.TextSettings.Font.Size := Text1.TextSettings.Font.Size * 2;
end;

procedure TCreditsScene.btnOkClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Home;
end;

procedure TCreditsScene.TranslateTexts(const Language: string);
var
  txtLicense: string;
begin
  inherited;

  if (Language = 'fr') then
  begin
    txtLicense := 'Licence';
    txttitle.Text := 'Credits';
  end
  else
  begin
    txtLicense := 'License';
    txttitle.Text := 'Credits';
  end;

  Text1.Text := GetTxtAboutDescription(Language).trim + sLineBreak + sLineBreak
    + '**********' + sLineBreak + '* ' + txtLicense + sLineBreak + sLineBreak +
    GetTxtAboutLicense(Language).trim + sLineBreak + sLineBreak +
    application.MainForm.Caption + ' ' + CAboutCopyright + sLineBreak;

end;

initialization

TScene.RegisterScene<TCreditsScene>(TSceneType.Credits);

end.
