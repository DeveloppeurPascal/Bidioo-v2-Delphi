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
  File last update : 2025-05-10T19:18:12.742+02:00
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
