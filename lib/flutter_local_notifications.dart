import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // icono de notificación

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // Para iOS también puedes agregar configuración si quieres
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> mostrarNotificacionContactoGuardado(String nombreContacto) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'contactos_channel',
    'Contactos',
    channelDescription: 'Notificaciones relacionadas con contactos',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // ID de la notificación
    '✅ Contacto guardado',
    'Contacto "$nombreContacto" guardado correctamente.',
    platformChannelSpecifics,
    payload: nombreContacto,
  );
}
