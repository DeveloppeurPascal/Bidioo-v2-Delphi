unit cGameTitle;

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
  Olf.FMX.TextImageFrame, FMX.Effects;

type
  TcadGameTitle = class(TFrame)
    txtGameTitle: TOlfFMXTextImageFrame;
    GlowEffect1: TGlowEffect;
    procedure FrameResized(Sender: TObject);
  private
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  udmAdobeStock_180834041_titre,
  uConsts;

procedure TcadGameTitle.AfterConstruction;
begin
  inherited;
  txtGameTitle.BeginUpdate;
  try
    txtGameTitle.Font := dmAdobeStock_180834041.ImageList;
    txtGameTitle.AutoSize := true;
    txtGameTitle.Text := CAboutGameTitle;
  finally
    txtGameTitle.EndUpdate;
  end;
end;

procedure TcadGameTitle.FrameResized(Sender: TObject);
begin
  txtGameTitle.Refresh;
end;

end.
