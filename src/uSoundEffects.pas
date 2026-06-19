(* C2PP
  ***************************************************************************

  Bidioo
  Copyright (c) 2013-2026 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://bidioo.gamolf.fr

  Project site :
  https://github.com/DeveloppeurPascal/Bidioo-v2-Delphi

  ***************************************************************************
  File last update : 2026-06-19T18:19:18.197+02:00
  Signature : 69565785216d5b07c93cc8efdf06511ee4f8d518
  ***************************************************************************
*)

unit uSoundEffects;

interface

type
{$SCOPEDENUMS ON}
  TSoundEffectType = (
    /// <summary>
    /// no sound
    /// </summary>
    None,
    /// <summary>
    /// clic on a button (normal button)
    /// </summary>
    Clic,
    /// <summary>
    /// clic on an option button (pressed button)
    /// </summary>
    ClicOption,
    /// <summary>
    /// win a new bonus
    /// </summary>
    BonusEnPlus,
    /// <summary>
    /// sound for "bomb" bonus
    /// </summary>
    BonusBombes,
    /// <summary>
    /// sound for "blend" bonus
    /// </summary>
    BonusMelanges,
    /// <summary>
    /// sound for "swap" bonus
    /// </summary>
    BonusSwap,
    /// <summary>
    /// sound for "delete" bonus
    /// </summary>
    BonusSuppr,
    /// <summary>
    /// sound for "help" bonus
    /// </summary>
    BonusBouees,
    /// <summary>
    /// lost a life
    /// </summary>
    PerteDUneVie,
    /// <summary>
    /// game over sound
    /// </summary>
    FinDePartie,
    /// <summary>
    /// match-3 found, cells destroyed
    /// </summary>
    CaseEnMoins);

  TSoundEffects = class;
  TSoundEffectsClass = class of TSoundEffects;

  TSoundEffects = class
  private
  protected
    class procedure RegisterSounds;
  public
    class procedure Play(const Sound: TSoundEffectType);
    class procedure StopAll;
    class procedure Volume(AVolume: integer);
    class function Current: TSoundEffectsClass;
  end;

implementation

{ TSoundEffects }

uses
  uConfig,
  Gamolf.FMX.MusicLoop,
  System.SysUtils,
  System.IOUtils,
  uConsts;

class procedure TSoundEffects.StopAll;
begin
  TSoundList.Current.MuteAll;
end;

class function TSoundEffects.Current: TSoundEffectsClass;
begin
  result := TSoundEffects;
end;

class procedure TSoundEffects.Play(const Sound: TSoundEffectType);
begin
  if tconfig.Current.SoundEffectsOnOff then
    TSoundList.Current.Play(ord(Sound));
end;

class procedure TSoundEffects.RegisterSounds;
var
  Sound: TSoundEffectType;
  Folder, FileName, FilePath: string;
begin
{$IF defined(ANDROID)}
  // deploy in .\assets\internal\
  Folder := tpath.GetDocumentsPath;
{$ELSEIF defined(MSWINDOWS)}
  // deploy in .\
{$IFDEF DEBUG}
  Folder := CDefaultSoundEffectsPath;
{$ELSE}
  Folder := extractfilepath(paramstr(0));
{$ENDIF}
{$ELSEIF defined(IOS)}
  // deploy in .\
  Folder := extractfilepath(paramstr(0));
{$ELSEIF defined(MACOS)}
  // deploy in Contents\MacOS
  Folder := extractfilepath(paramstr(0));
{$ELSEIF Defined(LINUX)}
  // deploy in .\
  Folder := extractfilepath(paramstr(0));
{$ELSE}
{$MESSAGE FATAL 'OS non supporté'}
{$ENDIF}
  for Sound := low(TSoundEffectType) to high(TSoundEffectType) do
  begin
    case Sound of
      TSoundEffectType.None:
        FileName := '';
      TSoundEffectType.ClicOption:
        FileName := 'BoxComplete.wav';
      TSoundEffectType.BonusEnPlus:
        FileName := 'MagicStars.wav';
      TSoundEffectType.BonusBombes:
        FileName := 'ExploMixLong.wav';
      TSoundEffectType.BonusMelanges:
        FileName := 'LoopAngryFlies.wav';
      TSoundEffectType.BonusSwap:
        FileName := 'LoopInSpace.wav';
      TSoundEffectType.BonusSuppr:
        FileName := 'LaserShot.wav';
      TSoundEffectType.BonusBouees:
        FileName := 'SparkleCave.wav';
      TSoundEffectType.PerteDUneVie:
        FileName := 'Moan.wav';
      TSoundEffectType.FinDePartie:
        FileName := 'GameOverRobot.wav';
      TSoundEffectType.Clic:
        FileName := '16GUNDRY.wav';
      TSoundEffectType.CaseEnMoins:
        FileName := 'IceCubeExploding.wav';
    else
      raise Exception.Create('Missing a sound effect !');
    end;
    if (not FileName.isempty) then
    begin
      FilePath := tpath.combine(Folder, FileName);
      if tfile.exists(FilePath) then
        TSoundList.Current.add(ord(Sound), FilePath);
    end;
  end;
  TSoundList.Current.Volume := tconfig.Current.SoundEffectsVolume;
end;

class procedure TSoundEffects.Volume(AVolume: integer);
begin
  if AVolume in [0 .. 100] then
  begin
    TSoundList.Current.Volume := AVolume;
    if tconfig.Current.SoundEffectsVolume <> AVolume then
      tconfig.Current.SoundEffectsVolume := AVolume;
  end;

end;

initialization

TSoundEffects.RegisterSounds;

end.
