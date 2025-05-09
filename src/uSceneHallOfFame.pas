unit uSceneHallOfFame;

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
  _ScenesAncestor;

type
  THallOfFameScene = class(T__SceneAncestor)
  private
  public
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts;

initialization

TScene.RegisterScene<THallOfFameScene>(TSceneType.HallOfFame);

end.
