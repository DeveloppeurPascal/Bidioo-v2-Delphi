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
  File last update : 2025-05-31T15:33:10.000+02:00
  Signature : af3252886a83d8dfcb51666191cdbb92af5c8125
  ***************************************************************************
*)

unit uSceneHallOfFame;

interface

// TODO : prendre en charge le changement de bouton "close" de la boite de dialogue anc�tre

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
