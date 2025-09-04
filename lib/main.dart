import 'package:flutter/material.dart';
import 'package:aplicacion1/inicio.dart';
import 'package:aplicacion1/notificaciones.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications(); // ← inicializa y pide permiso en Android 13+
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: inicio(),
      debugShowCheckedModeBanner: false,
    );
  }
}
