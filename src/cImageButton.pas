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
  USVGIconesKolopach, FMX.Effects;

type
  TbtnImageButton = class(T__ButtonAncestor)
    rImage: TRectangle;
    ShadowEffect1: TShadowEffect;
  private
    FKind: TSVGIconesKolopachIndex;
    procedure SetKind(const Value: TSVGIconesKolopachIndex);
  public
    constructor Create(AOwner: TComponent); override;
    property Kind: TSVGIconesKolopachIndex read FKind write SetKind;
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}

uses
  uSVGBitmapManager_InputPrompts;

constructor TbtnImageButton.Create(AOwner: TComponent);
begin
  inherited;
  FKind := TSVGIconesKolopachIndex.Coeur;
end;

procedure TbtnImageButton.Repaint;
begin
  if IsDown then
    rImage.Opacity := 0.5
  else
    rImage.Opacity := 1;
  rImage.Fill.Bitmap.Bitmap.Assign(getBitmapFromSVG(FKind, rImage.Width,
    rImage.Height, rImage.Fill.Bitmap.Bitmap.BitmapScale));
end;

procedure TbtnImageButton.SetKind(const Value: TSVGIconesKolopachIndex);
begin
  FKind := Value;
  Repaint;
end;

end.
