import 'package:aplicacion1/homepage.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion1/home.dart';
import 'package:aplicacion1/registrar.dart';
import 'package:aplicacion1/bd/operaciones.dart';
import 'package:aplicacion1/modelo/note.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _usuarioController = TextEditingController();
  final _contrasenaController = TextEditingController();
  bool ocultarContrasena = true;

  void _verificarLogin() async {
    String usuario = _usuarioController.text.trim();
    String contrasena = _contrasenaController.text.trim();

    if (usuario.isEmpty || contrasena.isEmpty) {
      _mostrarMensaje("Completa todos los campos");
      return;
    }

    List<Note> usuarios = await Operaciones.consulta();

    bool encontrado = usuarios.any((u) =>
        u.usuario == usuario && u.contrasena == contrasena);

    if (encontrado) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text("Bienvenido"),
          content: Text("Hola $usuario, ¡has iniciado sesión correctamente!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const home()),
                );
              },
              child: const Text("Continuar"),
            ),
          ],
        ),
      );
    } else {
      _mostrarMensaje("Usuario o contraseña incorrectos");
    }
  }

  void _mostrarMensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("asset/img/logoa.jpg", width: 150, height: 150),
                  const SizedBox(height: 20),
                  const Text("Iniciar Sesión",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1))),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(
                      labelText: "Usuario",
                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _contrasenaController,
                    obscureText: ocultarContrasena,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(ocultarContrasena
                            ? Icons.visibility_off_outlined
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            ocultarContrasena = !ocultarContrasena;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _verificarLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D47A1),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Ingresar",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const registrar()),
                      );
                    },
                    child: const Text("¿No tienes cuenta? Registrarse"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
