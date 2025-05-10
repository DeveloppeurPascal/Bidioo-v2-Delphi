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
/// File last update : 2025-05-10T18:43:04.000+02:00
/// Signature : fe21b71cae1404ca1d03aaaf16d661d9cbcf427d
/// ***************************************************************************
/// </summary>

unit uSVGBitmapManager_InputPrompts;

interface

uses
  FMX.Graphics,
  USVGInputPrompts,
  USVGIconesKolopach,
  USVGFruitsKolopach;

/// <summary>
/// Returns a bitmap from a SVG Input Prompt images (from Kenney.nl)
/// </summary>
function getBitmapFromSVG(const Index: TSVGInputPromptsIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;

/// <summary>
/// Returns a bitmap from a SVG Icones images (from Kolopach - Fotolia.com)
/// </summary>
/// <remarks>
/// Images : Fotolia_55252771, Fotolia_55252817, Fotolia_55252819, Fotolia_55252823, Fotolia_55252825
/// </remarks>
function getBitmapFromSVG(const Index: TSVGIconesKolopachIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;

/// <summary>
/// Returns a bitmap from a SVG Fruits images (from Kolopach - Fotolia.com)
/// </summary>
/// <remarks>
/// Images : Fotolia_47056077
/// </remarks>
function getBitmapFromSVG(const Index: TSVGFruitsKolopachIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;

implementation

uses
  Olf.Skia.SVGToBitmap;

function getBitmapFromSVG(const Index: TSVGInputPromptsIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;
begin
  result := TOlfSVGBitmapList.Bitmap(ord(Index) + TSVGInputPrompts.Tag,
    round(width), round(height), BitmapScale);
end;

function getBitmapFromSVG(const Index: TSVGIconesKolopachIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;
begin
  result := TOlfSVGBitmapList.Bitmap(ord(Index) + TSVGIconesKolopach.Tag,
    round(width), round(height), BitmapScale);
end;

function getBitmapFromSVG(const Index: TSVGFruitsKolopachIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;
begin
  result := TOlfSVGBitmapList.Bitmap(ord(Index) + TSVGFruitsKolopach.Tag,
    round(width), round(height), BitmapScale);
end;

procedure RegisterSVGImages;
begin
  TSVGInputPrompts.Tag := TOlfSVGBitmapList.AddItem(SVGInputPrompts);
  TSVGIconesKolopach.Tag := TOlfSVGBitmapList.AddItem(SVGIconesKolopach);
  TSVGFruitsKolopach.Tag := TOlfSVGBitmapList.AddItem(SVGFruitsKolopach);
end;

initialization

RegisterSVGImages;

end.
