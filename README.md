# Mobile

Repository pour le rendu mobile du challenge IW5 S2

## Setup le projet

Afin de pouvoir lancer le projet en local, vous devez tout d'abord setup les variables d'environnement en copiant le fichier `dotenv.example` et en le renommant `dotenv`.
Il faut ensuite set les variables d'environnement qui ne sont que les points d'accès à l'API, il est donc nécessaire de lancer l'API avant, la doc est disponible à ce [lien](https://github.com/esgi-challenge/backend)

Une fois les variables d'environnement mise, pour pouvez build l'application mobile de cette manière :
```
flutter build apk --release --dart-define APPLICATION_ID=$GMAP_API_KEY
```
Attention à bien remplacer la variable $GMAP_API_KEY par une clé d'api google map valide. Sinon ça ne marchera pas.

Si vous souhaitez lancer l'application en local il faudra les dépendances, installez les avec cette commande :
```
flutter pub get
```

ensuite pour lancer en local vous pouvez exécuter :
```
flutter run --dart-define APPLICATION_ID=$GMAP_API_KEY
```

## Features :
Groupe :
- Antoine Lorin [AtoLrn](https://github.com/AtoLrn)
- Lucas Campistron [Redeltaz](https://github.com/Redeltaz)
- Izïa Crinier [19946-Dresden-St](https://github/19946-Dresden-St)

Liste des features :
|   |   |
|---|---|
| auth, register | Antoine Lorin |
| chat temps réel | Lucas Campistron |
| matière/notes | Lucas Campistron |
| profil (api, BLoC) | Lucas Campistron |
