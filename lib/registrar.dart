import 'package:aplicacion1/bd/operaciones.dart';
import 'package:aplicacion1/modelo/note.dart';
import 'package:flutter/material.dart';

class registrar extends StatefulWidget {
  const registrar({super.key});

  @override
  State<registrar> createState() => _registrarState();
}

class _registrarState extends State<registrar> {
  final _keyForm = GlobalKey<FormState>();
  final usuarioControlador = TextEditingController();
  final contrasenaControlador = TextEditingController();
  final confcontrasenaControlador = TextEditingController();

  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset("asset/img/logoa.jpg", width: 200, height: 200),
              const SizedBox(height: 20),
              _campoTexto("Usuario", usuarioControlador, Icons.person_outline),
              _campoPassword("Contraseña", contrasenaControlador,
                  _obscurePassword1, (value) {
                if (value!.isEmpty) return "Por favor ingrese su contraseña";
                if (value.length < 6) return "Mínimo 6 caracteres";
                return null;
              }, () {
                setState(() {
                  _obscurePassword1 = !_obscurePassword1;
                });
              }),
              _campoPassword("Confirmar Contraseña", confcontrasenaControlador,
                  _obscurePassword2, (value) {
                if (value!.isEmpty) return "Confirme su contraseña";
                if (value != contrasenaControlador.text) {
                  return "Las contraseñas no coinciden";
                }
                return null;
              }, () {
                setState(() {
                  _obscurePassword2 = !_obscurePassword2;
                });
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () async {
                    if (_keyForm.currentState!.validate()) {
                      await Operaciones.insertar(Note(
                        usuario: usuarioControlador.text,
                        contrasena: contrasenaControlador.text,
                      ));

                      // Mensaje emergente de éxito y regreso automático
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AlertDialog(
                          title: const Text("Registro exitoso"),
                          content: const Text("Tu usuario fue registrado correctamente."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // cerrar alert
                                Navigator.pop(context); // regresar a login
                              },
                              child: const Text("Aceptar"),
                            ),
                          ],
                        ),
                      );

                      usuarioControlador.clear();
                      contrasenaControlador.clear();
                      confcontrasenaControlador.clear();
                    }
                  },
                  child: const Text(
                    'REGISTRARSE',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoTexto(String label, TextEditingController controller, IconData icono) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) return "Por favor ingrese su $label";
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icono, color: Colors.blue[800]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _campoPassword(String label, TextEditingController controller,
      bool obscure, FormFieldValidator<String> validator, VoidCallback toggle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.lock_outline, color: Colors.blue[800]),
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.blue[800]),
            onPressed: toggle,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
