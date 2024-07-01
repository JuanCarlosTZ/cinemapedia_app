# cinemapedia_app

# Dev

1. Copiar el archivo .env.template y nombrarlo como .dev
2. Cambiar las variables de entorno
3. Cambios en la entidad, hay que ejecutar el comando
```
flutter pub run build_runner build
```
4. para cambiar el id del app usar el paquete package_rename corriendo el comando:
```
dart run package_rename
```
5. usar flutter_launcher_icons para cambiar los iconos del app con el comando:
```
flutter pub run flutter_launcher_icons
```

6. usar flutter_native_splash. Usar el commando para ejecutar los cambios:
```
dart run flutter_native_splash:create
```

7. usar los id de google ads en el .env 
y en su respectiva configuracion en el androidManifest y PodFile

8. Para crear al Android AAB
```
flutter build appbundle
```

Para crear al iOS ipa
```
flutter build ipa
```