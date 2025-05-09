# 20250509 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* mise en place du dépôt de code
* mise à jour des paramètres de DocInsight
* mise à jour des paramètres de Copyright Pascal Project
* mise à jour des docs en FR/EN
* ajout des sous-modules
* copie et personnalisation du dossier "_PRIVATE"
* copie des musiques, sons et images utilisées en version 1.x vers "_PRIVATE"
* mise en place du projet à partir du modèle provenant du starter kit
* => personnalisation des chemins d'inclusions (lib-externes)
* => personnalisation des chemins vers l'icone de débogage (/debuggameicon)
* => personnalisation des chemins vers l'icone du jeu (/gameicon)
* => personnalisation du package name (fr.gamolf.bidioo)
* => personnalisation du ProjectGUID (en ouvrant le projet modèle et sa copie du jeu dans l'IDE)
* copie des unités à personnaliser dans le dossier du jeu (celles du starter kit qui émettent des WARNINGs disant de les copier lors de la compilation)
* modification de l'image de background de la v1 et prise en charge dans la scène de background du jeu
* personnalisation des constantes, des textes de licences et de description du jeu
* création et référencement des 6 scènes du jeu
* découpage des images provenant de Fotolia d'icones utilisées sur les boutons de l'interface utilisateur pour en extraire des PNG et SVG
* import des SVG de ces images dans Delphi
* création d'un "bouton image" basé sur ces images vectorielles
* mise en place des boutons de l'écran d'accueil et codage de leur fonctionnement
* sélection de la fonte à utiliser pour le titre du jeu (AdobeStock_180834041) et import des lettres utiles sous forme de liste d'images bitmap
* création d'un cadre pour afficher le titre et paramétrage en AutoSize du texte graphique
* ajout du titre en écran d'accueil
* travail sur les images de fruits provenant de Kolopach via Fotolia et export en SVG pour générer l'unité Delphi correspondante
* référencement des SVG des fruits de Kolopach dans le projet
* mise à jour de l'image du fond de boite de dialogue depuis la version d'origine (sans texte ni ombre)
* choix de la fonte graphique pour les titres des boites de dialogue => AdobeStock_176314025
* création d'une scène servant à l'affichage des boites de dialogue avec un bouton de fermeture temporaire
* recréation de la scène des crédits du jeu en se servaut de la boite de dialogue comme base d'affichage
* mise en place d'un système de positionnement et retaillage automatique pour la boite de dialogue en fonction de la taille de sa zone d'affichage (responsivité du machin, sans garantie de lisibilité du contenu)
* finalisation d'une v1 de l'icone pour le jeu


Reste à faire :

* scène du hall of fame
* scène de fin de partie
* scène des options du jeu
* faire une case à cocher ou gérer les boutons d'activation / désactivation comme dans la version 1 (état cliqué / état non cliqué)
* scène du jeu
* gestion des données du jeu (fichier et classe)
* gestion d'une partie

* traiter les TODOs dans le projet
* remplacer les bitmaps des boutons "flèches", "ok", "cancel" (provenant du CEI) des boites de dialogue par des images vectorielles
* retrouver les références exactes des sons utilisés (et leur licence) + mettre à jour les crédits du jeu
* trouver d'autres séries d'images utilisables sur le jeu en tant que tuiles (pierres précieuses, animaux, smileys, ...)
