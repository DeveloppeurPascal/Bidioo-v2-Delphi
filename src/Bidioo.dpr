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
  File last update : 2025-07-13T16:29:10.000+02:00
  Signature : 35970daf13a415dfc3e62e2c9a4ac3f8272a398d
  ***************************************************************************
*)

program Bidioo;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Types,
  FMX.Skia,
  fMain in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\fMain.pas' {frmMain},
  Olf.FMX.AboutDialog in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  u_urlOpen in '..\lib-externes\librairies\src\u_urlOpen.pas',
  uConsts in 'uConsts.pas',
  Olf.RTL.Language in '..\lib-externes\librairies\src\Olf.RTL.Language.pas',
  Olf.RTL.CryptDecrypt in '..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Params in '..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  Olf.Skia.SVGToBitmap in '..\lib-externes\librairies\src\Olf.Skia.SVGToBitmap.pas',
  uDMAboutBox in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uDMAboutBox.pas' {AboutBox: TDataModule},
  uDMAboutBoxLogoStorrage in 'uDMAboutBoxLogoStorrage.pas' {dmAboutBoxLogo: TDataModule},
  uTxtAboutLicense in 'uTxtAboutLicense.pas',
  uTxtAboutDescription in 'uTxtAboutDescription.pas',
  Gamolf.FMX.HelpBar in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.HelpBar.pas',
  Gamolf.FMX.Joystick in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.Joystick.pas',
  Gamolf.FMX.MusicLoop in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.MusicLoop.pas',
  Gamolf.RTL.GamepadDetected in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.GamepadDetected.pas',
  Gamolf.RTL.Joystick.DirectInput.Win in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.DirectInput.Win.pas',
  Gamolf.RTL.Joystick.Helpers in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Helpers.pas',
  Gamolf.RTL.Joystick.Mac in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Mac.pas',
  Gamolf.RTL.Joystick in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.pas',
  Gamolf.RTL.Scores in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Scores.pas',
  Gamolf.RTL.UIElements in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.UIElements.pas',
  iOSapi.GameController in '..\lib-externes\Delphi-Game-Engine\src\iOSapi.GameController.pas',
  Macapi.GameController in '..\lib-externes\Delphi-Game-Engine\src\Macapi.GameController.pas',
  uTranslate in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uTranslate.pas',
  uConfig in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uConfig.pas',
  _ScenesAncestor in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\_ScenesAncestor.pas' {__SceneAncestor: TFrame},
  uScene in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uScene.pas',
  uUIElements in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uUIElements.pas',
  uGameData in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uGameData.pas',
  Olf.RTL.Streams in '..\lib-externes\librairies\src\Olf.RTL.Streams.pas',
  Olf.RTL.Maths.Conversions in '..\lib-externes\librairies\src\Olf.RTL.Maths.Conversions.pas',
  uBackgroundMusic in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uBackgroundMusic.pas',
  uSoundEffects in 'uSoundEffects.pas',
  USVGInputPrompts in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\assets\kenney_nl\InputPrompts\USVGInputPrompts.pas',
  uDMGameControllerCenter in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uDMGameControllerCenter.pas' {DMGameControllerCenter: TDataModule},
  uDMHelpBarManager in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uDMHelpBarManager.pas' {HelpBarManager: TDataModule},
  _ButtonsAncestor in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\_ButtonsAncestor.pas' {__ButtonAncestor: TFrame},
  uSceneBackground in '..\_PRIVATE\assets\Fotolia\fond-de-page.fotolia\uSceneBackground.pas' {SceneBackground: TFrame},
  uSceneHome in 'uSceneHome.pas' {HomeScene: TFrame},
  uSceneGame in 'uSceneGame.pas' {GameScene: TFrame},
  cImageButton in 'cImageButton.pas' {btnImageButton: TFrame},
  USVGIconesKolopach in '..\_PRIVATE\assets\Fotolia\icones.fotolia\IconesKolopach\USVGIconesKolopach.pas',
  cGameTitle in 'cGameTitle.pas' {cadGameTitle: TFrame},
  Olf.FMX.TextImageFrame in '..\lib-externes\librairies\src\Olf.FMX.TextImageFrame.pas' {OlfFMXTextImageFrame: TFrame},
  USVGFruitsKolopach in '..\_PRIVATE\assets\Fotolia\motif-fruits.fotolia\FruitsKolopach\USVGFruitsKolopach.pas',
  cDialogBox in '..\_PRIVATE\assets\NicheEmpire\303-OTO-Ultimate-Marketing-Graphics-Collection-NE\cDialogBox.pas' {cadDialogBox: TFrame},
  uSceneOptions in 'uSceneOptions.pas' {OptionsScene: TFrame},
  uSceneTutoriel in 'uSceneTutoriel.pas' {TutorielScene: TFrame},
  uSceneGameOver in 'uSceneGameOver.pas' {GameOverScene: TFrame},
  uSceneHallOfFame in 'uSceneHallOfFame.pas' {HallOfFameScene: TFrame},
  uSceneCredits in 'uSceneCredits.pas' {CreditsScene: TFrame},
  uBidiooGameData in 'uBidiooGameData.pas',
  uBidiooScores in 'uBidiooScores.pas',
  udmAdobeStock_257147901 in '..\_PRIVATE\assets\AdobeStock\AdobeStock_257147901\udmAdobeStock_257147901.pas' {dmAdobeStock_257147901: TDataModule},
  udmAdobeStock_257148021 in '..\_PRIVATE\assets\AdobeStock\AdobeStock_257148021\udmAdobeStock_257148021.pas' {dmAdobeStock_257148021: TDataModule},
  uBidiooConfig in 'uBidiooConfig.pas',
  cMatch3Game in 'cMatch3Game.pas' {cadMatch3Game: TFrame},
  udmAdobeStock_443346276Bidioo in '..\_PRIVATE\assets\AdobeStock\AdobeStock_443346276-Bidioo\udmAdobeStock_443346276Bidioo.pas' {dmAdobeStock_443346276Bidioo: TDataModule};

{$R *.res}

begin
  GlobalUseSkia := True;
  {$IF Defined(OSX) or Defined(IOS)}
  GlobalUseMetal := true;
  {$ENDIF}
  {$IFDEF ANDROID}
  GlobalUseVulkan := true;
  GlobalUseSkiaRasterWhenAvailable:=false;
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  GlobalUseSkiaRasterWhenAvailable:=false;
  {$ENDIF}
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMGameControllerCenter, DMGameControllerCenter);
  Application.CreateForm(TdmAdobeStock_257147901, dmAdobeStock_257147901);
  Application.CreateForm(TdmAdobeStock_257148021, dmAdobeStock_257148021);
  Application.CreateForm(TdmAdobeStock_443346276Bidioo, dmAdobeStock_443346276Bidioo);
  Application.Run;
end.
