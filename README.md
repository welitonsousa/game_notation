# Game Notion


Este é um aplicativo Flutter que utiliza o pacote GetX para gerenciamento de estado e integração com a API da Twitch e IGDB (Internet Game Database). O aplicativo permite aos usuários acessar informações sobre jogos, streams e outros conteúdos relacionados à Twitch, através da API da IGDB.

<br>

Além disso, este aplicativo permite que os dados do usuário sejam salvos no Firebase Storage, possibilitando o acesso a esses dados em outros dispositivos. Ele oferece suporte às plataformas Android, iOS, macOS, Windows e Linux.

<br>

<a href="https://github.com/welitonsousa/game_notation/raw/main/assets/files/android.apk">Baixe o app para Android 🤖</a>

<br>

<h2 align="center">Android - Light/Dark mode</h2>
<p align="center">
    <img src="./assets/screenshots/android-light.png" width="250" height="500"/>
    <img src="./assets/screenshots/android-dark.png" width="250" height="500"/>
</p>

<h2 align="center">IOS - Light/Dark mode</h2>
<p align="center">
    <img src="./assets/screenshots/ios-light.png" width="250" height="500"/>
    <img src="./assets/screenshots/ios-dark.png" width="270" height="520"/>
</p>

<h2 align="center">Windows - App rodando</h2>

<p align="center">
    <img src="./assets/screenshots/game-notion.gif" />

</p>


## Como executar:
- Adicione um arquivo na raiz do projeto chamado `firebase.json`. Este arquivo contém as configurações de autenticação para o Firebase. Você pode usar o arquivo `firebase.json.example` na raiz do projeto como exemplo para sua estrutura.

- Adicione outro arquivo em `/lib/core/settings/env.dart`. Este arquivo contém as variáveis de ambiente necessárias para o aplicativo. Você pode usar o arquivo `env.dart.example` em `/lib/core/settings/` como exemplo para sua estrutura.


```dart
flutter pub get
```
```dart
flutter run
```

<br>
<br>
<p align="center">
   Feito com ❤️ by <b>welitonsousa</b>
</p>
