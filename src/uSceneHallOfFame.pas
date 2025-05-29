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
  File last update : 2025-05-10T19:18:12.762+02:00
  Signature : 73b6ff93c3c92e183c5102145fb1181a7adf6105
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
    FlowLayout1: TFlowLayout;
    procedure btnOkClick(Sender: TObject);
  private
  public
    procedure TranslateTexts(const Language: string); override;
    procedure ShowScene; override;
    procedure AddText(const Text: String);
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  uBidiooScores,
  udmAdobeStock_257148021;

procedure THallOfFameScene.AddText(const Text: String);
var
  txt: TOlfFMXTextImageFrame;
begin
  txt := TOlfFMXTextImageFrame.Create(self);
  txt.Parent := FlowLayout1;
  txt.height := 40;
  txt.margins.Bottom := 10;
  txt.Font := dmAdobeStock_257148021.ImageList;
  txt.Text := Text;

  TFlowLayoutBreak.Create(self).Parent := FlowLayout1;

  if FlowLayout1.height < txt.position.y + txt.height + txt.margins.Bottom then
    FlowLayout1.height := txt.position.y + txt.height + txt.margins.Bottom;
end;

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
