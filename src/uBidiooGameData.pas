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
/// File last update : 2025-05-10T14:27:10.000+02:00
/// Signature : 3153e1a2fb7b354ae0166740a60f5705fc058e1f
/// ***************************************************************************
/// </summary>

unit uBidiooGameData;

interface

uses
  uGameData;

Type
  TBidiooGameData = class(TGameData)
  private
  protected
  public
    class function Current: TBidiooGameData;
  end;

implementation

{ TBidiooGameData }

class function TBidiooGameData.Current: TBidiooGameData;
begin
  result := DefaultGameData<TBidiooGameData>;
end;

initialization

TBidiooGameData.Current.Score := 0;

end.
