# 20250531 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* edited the game credits to add Kenney.nl and change the game description
* moved AddText() and AddButton() to the dialog ancestor (from the game options, hall of fame and gave over scene)
* forced the fullscreen mode on iPadOS / iOS to allow the orientation choice (if it's not present, Apple reject the binary on the AppStore)
* use Metal graphic library from Apple for macOS and iOS
* use Vulkan graphic library for Android
* added a maximal number of different tiles on screen
* managed the game level and change the score and the maximal number of tiles on screen depending on the current level
* removed the click on NbLives icon during a game
* fixed the lives number really available
* hide the Image Buttons with an exposant when the value is less than 1
* moved the game grid default size from the BidiooGameData unit to the Consts unit
* fixed the Music On/Off button on game screen (it changed the status but not the configuration)
* fixed the sound played or not when clicking the Sound On/Off button
* fixed the sounds effects on Windows (except for the clic on buttons because they are on 2 different folders)
* fixed the Play/Continue button which was linked to NbLives>0 instead of an existing (or not) game data file

* added a "swap tile" mode in the match-3 game frame
* added a "move line" mode in the match-3 game frame
* enabled the good mode in the match-3 game frame depending on Bidioo game mode option

* deployed release 2.0b - 20250531
* updated developer docs


Reste à faire :

* réfléchir à comment présenter l'écran en mode portrait
* ajouter un tuto sur l'écran des options et en démarrage de partie pour le mode de jeu choisi
* prise en charge des bonus (au niveau de la sauvegarde des parties, de l'affichage et du calcul des scores)
* soumission de la version 2.0 aux magasins d'application

--

* traiter les TODOs dans le projet

* gérer les actions des bonus disponibles et leur affichage

* mettre en place les écrans du tutoriel au démarrage d'une partie
* mettre en place les écrans d'infos lors des changements de niveau, gains de bonus, ...

* trouver d'autres séries d'images utilisables sur le jeu en tant que tuiles (pierres précieuses, animaux, smileys, ...)
* ajouter le choix dans l'écran des réglages

* faire une boite de dialogue de confirmation/refus suite à question

* trouver des images sympas pour les badges de niveau (une série pour chaque mode de jeu)
* gérer les badges de niveaux obtenus / à obtenir
* faire un écran d'affichage des badges disponibles et ceux obtenus

* basculer sur la version jaune des flèches provenant de UI Pack de Kenney pour les boites de dialogue (à réexporter des SVG)

* faire une version sans ombrage de AdobeStock_257147901
* faire une version sans ombrage de AdobeStock_257148021
* dans Bibioo, remplacer AdobeStock_257147901 par la version sans l'ombre pour les exposants des "boutons images"

Mettre les sons en place et retirer les fichiers inutilisés :

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
