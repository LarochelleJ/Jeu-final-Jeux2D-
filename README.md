# Jeu final pour Jeux 2D - Just Jump (Fiery mountain)
![header](https://i.imgur.com/0LKbSMX.png)
## Description du jeu
Il s'agit d'un jeu de plateformes dont le but est de monter le plus souvent possible jusqu'à la plateforme finale et toucher au drapeau qui indique la victoire. Chaque fois que l'on touche au drapeau, le joueur est renvoyé à la première plateforme pour recommencer son ascension et la lave monte plus vite.

Initialement, le joueur se trouve sur une plateforme et n'en voit que trois autres. Ces plateformes sont fixes et seront toujours les mêmes quand le joueur est renvoyé à la position initiale.

Lorsque le joueur se atteint la première plateforme, 5 plateformes sont générées aléatoirement à hauteur constante. Puis au prochain niveau, on ajoute 2 autres plateformes et ainsi de suite.

## Caractéristiques

 - [x] Il y a 3 types de plateformes, tous différente en longueur et couleur
 - [x] Une de ces plateformes a un effet spécial
 - [x] Un lac de lave suit le joueur, si il tombe dans la lave, il perds une vie et le niveau recommence
 - [x] La lave détruit les plateformes
 - [x] Le joueur dispose de 3 vies
 - [x] Le joueur recommence le jeu au complet lorsqu'il n'a plus de vies
 - [x] Les 3 plateformes initiales ne donnent pas de points. Les plateformes normales donne 10 points tandis que la plateforme avec effet spécial en donne 15 points
 - [x] Lorsque le niveau recommence, on ne recompte pas les points des plateformes déjà atteintes dans la précédente tentative
 
## La plateforme spéciale
![plateforme spéciale](https://i.imgur.com/8TZd9OZ.png)
 - La plateforme spéciale est la plus large des 3 plateformes
 - Elle se déplace de gauche à droite et peut changer de direction en plein milieu de sa course
 - Lorsque le joueur se trouve sur cette plateforme, sa vitesse de déplacement est augmenté

## Ressources utilisées
[Pixel Adventure (itch.io)](https://pixelfrog-assets.itch.io/pixel-adventure-1)
