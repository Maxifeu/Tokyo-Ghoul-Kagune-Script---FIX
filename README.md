Base script : https://steamcommunity.com/workshop/filedetails/?l=french&id=1705175813

Tout les crédits vont à remigius, script modifié avec sa permission.

A refaire (pas encore finis) :

- Formulaire lors de la première connexion.
- Fix le Médecin.
- Quinque Armure (arata).
- Catégorie Quinx menu admin.


J'ai refait quelques commandes :

Celles de base :
console: tkgquinx [action (ajouter, éditer, supprimer)] [joueur] [kagune (rinkaku, koukaku, bikaku, ukaku)] [RC] [efficacité de la kagune, vous utilisez une valeur entre 0.20 et 1, je conseil d'utilisé 0.20 pour F1, 0.40 pour F2, 0.60 pour F3, 0.80 pour F4 et 1 pour F5]
chat: !addrc [joueur] [rc à ajouter| pour en enlever, utilisé un nombre négatif]
chat: !editkagune [joueur] [kagune (nombre)]
chat: !addhazardpoint [joueur] [point à ajouter]
chat: !addccgprofil [joueur] [rang]
chat: !rc
chat: !kagune

Celle modifiée :
chat: !tkgmenu ==> !admintkg

De base, un humain a entre 250 et 500 RC tandis qu'une ghoul en a plus de 1000 au minimum
Niveau kagune, Chaque kagune a un ensemble de nombre qui définit la définit, pour faire plus simple, vous faite juste !editkagune [joueur] [l'un des nombres plus bas selon la kagune]
rinkaku: 0-100
koukaku: 101-200
bikaku: 201-300
ukaku: 301-400

Le reste des fonctionnalités restent les mêmes.

J'ai fait un overhaul de l'UI

https://steamcommunity.com/sharedfiles/filedetails/?id=2484805123
