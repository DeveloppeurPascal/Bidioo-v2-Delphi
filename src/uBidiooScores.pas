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
  File last update : 2025-05-10T19:18:12.744+02:00
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
