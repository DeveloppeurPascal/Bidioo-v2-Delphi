# 20250530 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* added a different direction to fill the grid depending (or not) on the player direction move (by default from top to bottom)
* added a simple "destroy" animation of cells to remove
* changed the celles type from integer (= SVG Id) to the record TGridCell to manage movements of cells and other features
* fixed some compiler warnings and hints
* added the animation when cells moves

* deployed an alpha release for Windows and Mac ARM




Reste à faire :
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
