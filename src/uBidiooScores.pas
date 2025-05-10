/// <summary>
/// ***************************************************************************
///
/// Bidioo
///
/// Copyright 2013-2025 Patrick PREMARTIN under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://bidioo.gamolf.fr
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Bidioo-v2-Delphi
///
/// ***************************************************************************
/// File last update : 2025-05-10T14:29:46.000+02:00
/// Signature : e50c7705bc11c333046fb1b043aefafb973d6c0a
/// ***************************************************************************
/// </summary>

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
