# 20250529 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* updated the submodules fter a serie of changed in all of them for developer documentation and a few TODOs/issues
* added the Match-3 game frame from Delphi FMX Game Snippets repository to use it as a base for Bidioo
* added the Match3 frame to the game scene and initialized the screen and game
* managed the screen size (portrait or landscape) in a game
* added the game grid to the game data class and managed the load/save/pause processus
* added the score on the game screen and managed its value
* updated the Image Button to add a number (and use them as bonus buttons)
* added the lives number on the game screen and managed its value
* added a pause button on the game screen
* added a music on/off button on the game screen
* added a sounds on/off button on the game screen
* added the WAV files for sound effects into the project deployment wizard
* added the sounds effects to the TSoundEffects class
* added sounds effects on different actions (lost a life, lost a game, clic on a button, clic on a pressed button)


Reste à faire :

* prendre en charge le sens de remplissage selon le sens de swap du joueur
* ajouter des animations pour l'explosion des cases
* ajouter des animations pour le remplissage de la grille


* réfléchir à comment présenter l'écran en mode portrait


* mettre en place le jeu en mode master (déplacement de lignes)
* mettre en place le jeu en mode mixte (activation des deux modes)
* gérer les actions des bonus disponibles et leur affichage

* mettre en place les écrans du tutoriel au démarrage d'une partie
* mettre en place les écrans d'infos lors des changements de niveau, gains de bonus, ...

* traiter les TODOs dans le projet

* trouver d'autres séries d'images utilisables sur le jeu en tant que tuiles (pierres précieuses, animaux, smileys, ...)
* ajouter le choix dans l'écran des réglages

* faire une boite de dialogue de confirmation/refus suite à question

* trouver des images sympas pour les badges de niveau (une série pour chaque mode de jeu)
* gérer les badges de niveaux obtenus / à obtenir
* faire un écran d'affichge des badges disponibles et ceux obtenus

* basculer sur la version jaune des flèches provenant de UI Pack de Kenney pour les boites de dialogue

* sur bouton image avec nombre affiché, pouvoir désactiver complètement le clic (et resté on ou off au choix)
* pour le texte d'expodsant des boutons image, changer la police pour une version sans ombrage

* mettre à jour les crédits du jeu

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
