import 'package:aplicacion1/bd/operaciones.dart';
import 'package:aplicacion1/modelo/note.dart';
import 'package:flutter/material.dart';

class actualizar extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();
  final Note nota;
  
  final TextEditingController usuarioControlador;
  final TextEditingController contrasenaControlador;
  final TextEditingController confcontrasenaControlador;
  
  actualizar({super.key, required this.nota})
      : usuarioControlador = TextEditingController(text: nota.usuario),
        contrasenaControlador = TextEditingController(text: nota.contrasena),
        confcontrasenaControlador = TextEditingController(text: nota.contrasena);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Actualizar Usuario'),
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
              Image.asset(
                "asset/img/logoa.jpg", 
                width: 200, 
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: TextFormField(
                  controller: usuarioControlador,
                  validator: (value) {
                    if (value!.isEmpty) return "Por favor ingrese su usuario";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Usuario",
                    prefixIcon: Icon(Icons.person_outline, color: Colors.blue[800]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: TextFormField(
                  controller: contrasenaControlador,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return "Por favor ingrese su contraseña";
                    if (value.length < 6) return "La contraseña debe tener al menos 6 caracteres";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.blue[800]),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.blue[800],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: TextFormField(
                  controller: confcontrasenaControlador,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return "Por favor confirme su contraseña";
                    if (value != contrasenaControlador.text) return "Las contraseñas no coinciden";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Confirmar Contraseña",
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.blue[800]),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.blue[800],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
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
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      if (contrasenaControlador.text == confcontrasenaControlador.text) {
                        // Actualizar el objeto nota con los nuevos valores
                        nota.usuario = usuarioControlador.text;
                        nota.contrasena = contrasenaControlador.text;
                        
                        // Llamar a la operación de actualización
                        Operaciones.actualizar(nota);
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuario actualizado exitosamente'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        
                        // Opcional: regresar a la pantalla anterior
                        Navigator.pop(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(Icons.error, color: Colors.red, size: 40),
                              content: const Text("Las contraseñas no coinciden"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text(
                    'ACTUALIZAR',
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
}