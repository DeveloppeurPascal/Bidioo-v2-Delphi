﻿(* C2PP
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
  File last update : 2025-07-13T16:31:28.000+02:00
  Signature : 0acdd6ea5946f880cb1c5e079874df5579bcf9e9
  ***************************************************************************
*)

unit cImageButton;

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
  _ButtonsAncestor,
  FMX.Objects,
  USVGIconesKolopach,
  FMX.Effects,
  Olf.FMX.TextImageFrame,
  FMX.Layouts;

type
  TbtnImageButton = class(T__ButtonAncestor)
    rImage: TRectangle;
    ShadowEffect1: TShadowEffect;
    txtExposant: TOlfFMXTextImageFrame;
    GlowEffect1: TGlowEffect;
    lExposant: TLayout;
    procedure FrameResized(Sender: TObject);
    procedure lExposantResized(Sender: TObject);
  private
    FKind: TSVGIconesKolopachIndex;
    FIsPressed: boolean;
    FIsPressedButton: boolean;
    FNumber: integer;
    FShowNumber: boolean;
    procedure SetKind(const Value: TSVGIconesKolopachIndex);
    procedure SetIsPressed(const Value: boolean);
    procedure SetIsPressedButton(const Value: boolean);
    procedure SetNumber(const Value: integer);
    procedure SetShowNumber(const Value: boolean);
  protected
  public
    property Number: integer read FNumber write SetNumber;
    property ShowNumber: boolean read FShowNumber write SetShowNumber;
    property Kind: TSVGIconesKolopachIndex read FKind write SetKind;
    property IsPressedButton: boolean read FIsPressedButton
      write SetIsPressedButton;
    property IsPressed: boolean read FIsPressed write SetIsPressed;
    constructor Create(AOwner: TComponent); override;
    procedure Repaint; override;
    procedure AfterConstruction; override;
    procedure Click; override;
  end;

implementation

{$R *.fmx}

uses
  udmAdobeStock_257147901,
  uSoundEffects;

procedure TbtnImageButton.AfterConstruction;
begin
  inherited;
  txtExposant.BeginUpdate;
  try
    txtExposant.Font := dmAdobeStock_257147901.ImageList;
    txtExposant.AutoSize := true;
    txtExposant.Text := '';
  finally
    txtExposant.EndUpdate;
  end;
end;

procedure TbtnImageButton.Click;
begin
  if IsPressedButton then
    IsPressed := not IsPressed;
  inherited;
  // Don't play any sound on the "Sound On/Off" button, it has to be played
  // after changing the "Sound On/Off" value in the settings. Play the sound
  // in the "Sound On/Off" click event.
  if not(Kind = TSVGIconesKolopachIndex.Micro) then
    if IsPressedButton then
      TSoundEffects.Current.Play(TSoundEffectType.ClicOption)
    else
      TSoundEffects.Current.Play(TSoundEffectType.Clic);
end;

constructor TbtnImageButton.Create(AOwner: TComponent);
begin
  inherited;
  FKind := TSVGIconesKolopachIndex.Coeur;
  FIsPressed := false;
  FIsPressedButton := false;
  FNumber := 0;
  FShowNumber := false;
end;

procedure TbtnImageButton.FrameResized(Sender: TObject);
begin
  lExposant.BeginUpdate;
  try
    lExposant.margins.top := height * 35 / 100;
    lExposant.margins.bottom := height * 35 / 100;
    lExposant.margins.left := width * 5 / 100;
    lExposant.margins.right := width * 5 / 100;
  finally
    lExposant.EndUpdate;
  end;
end;

procedure TbtnImageButton.lExposantResized(Sender: TObject);
begin
  if lExposant.visible then
    txtExposant.Refresh;
end;

procedure TbtnImageButton.Repaint;
begin
  if IsPressedButton then
  begin
    if IsPressed then
      rImage.Opacity := 0.5
    else
      rImage.Opacity := 1;
  end
  else
  begin
    if IsDown then
      rImage.Opacity := 0.5
    else
      rImage.Opacity := 1;
  end;
  rImage.Fill.Bitmap.Bitmap.Assign(getBitmapFromSVG(FKind, rImage.width,
    rImage.height, rImage.Fill.Bitmap.Bitmap.BitmapScale));
  if not FShowNumber then
    lExposant.visible := false
  else
  begin
    lExposant.visible := true;
    txtExposant.Text := FNumber.ToString;
  end;
end;

procedure TbtnImageButton.SetIsPressed(const Value: boolean);
begin
  FIsPressed := Value;
  Repaint;
end;

procedure TbtnImageButton.SetIsPressedButton(const Value: boolean);
begin
  FIsPressedButton := Value;
  Repaint;
end;

procedure TbtnImageButton.SetKind(const Value: TSVGIconesKolopachIndex);
begin
  FKind := Value;
  Repaint;
end;

procedure TbtnImageButton.SetNumber(const Value: integer);
begin
  FNumber := Value;
  if FShowNumber then
    visible := FNumber > 0;
  Repaint;
end;

procedure TbtnImageButton.SetShowNumber(const Value: boolean);
begin
  FShowNumber := Value;
  Repaint;
end;

end.
