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
  File last update : 2025-05-29T19:29:26.000+02:00
  Signature : 28491f08370f4aa6d80b317b51b892695aa4525d
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
  uBidiooGameData,
  uBidiooScores,
  udmAdobeStock_257148021, uSoundEffects;

procedure TGameOverScene.AddText(const Text: String);
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
    FlowLayout1.height := FlowLayout1.height + txt.height + txt.margins.Bottom;
end;

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
