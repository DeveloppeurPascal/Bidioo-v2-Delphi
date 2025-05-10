# 20250510 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* mise à jour de l'image d'illustration de la boite de dialog "à propos" à partir de l'icone du jeu
* recréation des scènes GameOver, HallOfFame, Options à partir des crédits du jeu pour utiliser la boite de dialogue comme fond
* ajout d'une scène pour le tutoriel d'intro du jeu
* finaliser la scène de fin de partie avec enregistrement du score
* ajout d'une classe de gestion des scores (copiée depuis Ok Ducky)
* finaliser la scène d'affichage des meilleurs scores
* changement de la fonte graphique (AdobeStock_180834041) utilisée pour le titre en remplacée par AdobeStock_119308227
* export de la fonte graphique "MUGSHOT" de couleur noir (AdobeStock_257148021) depuis Adobe Illustrator
* utilisation de la fonte graphique "MUGSHOT" blanche (AdobeStock_257147901) pour les titres des boites de dialogue en remplacement de AdobeStock_176314025
* utilisation de la fonte graphique "MUGSHOT" noire (AdobeStock_257148021) pour l'affichage du score
* modification du cadre servant à afficher le titre du jeu
* modification du cadre servant à afficher les boites de dialogue
* remplacement du text de l'écran de fin de partie par une fonte graphique
* création d'une classe de paramétrage des infos du jeu en tant que helper tu TConfig du starter kit
* mise en place de la scène des réglages de l'application (musique, effets sonores, mode de jeu, (ré)activation du tutoriel, choix du mode graphique)

* modification rapide dans TConfig sur le projet du starter kit pour pouvoir s'en servir dans les jeux vidéo qui voudraient ajouter des options

* ajout des paramètres de Bidioo dans TConfigHelpers
* mise à jour de la scène des réglages pour afficher rubriques et boutons de changement de valeur des options
* modification des boutons icones pour avoir un mode normal et un mode "bouton pressé" qui conserve son état up ou down
* traitement du choix du mode de jeu (classique, mixte, master) dans les options de configuration
* traitement de l'activation / désactivation de la musique d'ambiance
* traitement de l'activation / désactivation des effets sonores
* sélection de nouvelles images pour les boutons "mode classic", "mode mixte" et "mode master" et regénération des SVG correspondants
* remplacement des images des boutons de footer de la boite de dialogue d'origine (du CEI en bitmap) par des images du "UI Pack" de Kenney, ajoutées au SVG de Kolopach pour être utilisées dans le TBtnImageButton
* ajout de l'option d'activation du tutoriel et de l'aide en cours de partie dans les options du jeu

* export de la documentation développeur du jeu


Reste à faire :

* faire le dessin de l'écran de jeu (zone de jeu, zone de boutons, zone d'infos) et gérer les changements d'orientation
* gérer les données d'une partie en cours d'utilisation et en sauvergarde/restauration
* mettre en place le jeu en mode classic (inversion de cases)

* mettre en place le jeu en mode master (déplacement de lignes)
* mettre en place le jeu en mode mixte (activation des deux modes)
* gérer les actions des bonus disponibles et leur affichage

* mettre en place les écrans du tutoriel au démarrage d'une partie
* mettre en place les écrans d'infos lors des changements de niveau, gains de bonus, ...

* choisir les sons à conserver et implémenter leur utilisation

* traiter les TODOs dans le projet

* retrouver les références exactes des sons utilisés (et leur licence) + mettre à jour les crédits du jeu

* trouver d'autres séries d'images utilisables sur le jeu en tant que tuiles (pierres précieuses, animaux, smileys, ...)
* ajouter le choix dans l'écran des réglages

* faire une boite de dialogue de confirmation/refus suite à question

* ajouter une alerte au niveau de la scéne de réglage pour informer que le changement de mode de jeu fera perdre la partie en cours (s'il y en a une en pause)
* ajouter une alerte au niveau de la scéne de réglage pour informer que le changement de design (ambiance graphique/tuiles) fera perdre la partie en cours (s'il y en a une en pause)

* trouver des images sympas pour les badges de niveau (une série pour chaque mode de jeu)
* gérer les badges de niveaux obtenus / à obtenir
* faire un écran d'affichge des badges disponibles et ceux obtenus

* basculer sur la version jaune des flèches provenant de UI Pack de Kenney pour les boites de dialogue
