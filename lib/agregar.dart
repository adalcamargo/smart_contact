import 'package:flutter/material.dart';
import 'contact.dart';
import 'database_helper.dart';
import 'package:aplicacion1/notificaciones.dart'; // ← importa el servicio

class AgregarContacto extends StatefulWidget {
  const AgregarContacto({super.key});

  @override
  State<AgregarContacto> createState() => _AgregarContactoState();
}

class _AgregarContactoState extends State<AgregarContacto> {
  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();
  final direccionController = TextEditingController();

  String grupoSeleccionado = 'Amigos';
  final List<String> grupos = ['Familia', 'Amigos', 'Trabajo', 'Otros'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Agregar Contacto'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[100],
                  border: Border.all(
                    color: Colors.blue[800]!,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(controller: nombreController, label: "Nombre", icon: Icons.person_outline),
              const SizedBox(height: 16),
              _buildTextField(controller: telefonoController, label: "Teléfono", icon: Icons.phone_outlined, keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              _buildTextField(controller: correoController, label: "Correo electrónico", icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField(controller: direccionController, label: "Dirección", icon: Icons.home_outlined),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: grupoSeleccionado,
                decoration: InputDecoration(
                  labelText: 'Grupo',
                  prefixIcon: Icon(Icons.group_outlined, color: Colors.grey[600]),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                items: grupos.map((grupo) {
                  return DropdownMenuItem(value: grupo, child: Text(grupo));
                }).toList(),
                onChanged: (value) => setState(() => grupoSeleccionado = value!),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  if (nombreController.text.isEmpty ||
                      telefonoController.text.isEmpty ||
                      correoController.text.isEmpty ||
                      direccionController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Por favor, complete todos los campos.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    );
                    return;
                  }

                  final nuevoContacto = Contact(
                    nombre: nombreController.text,
                    telefono: telefonoController.text,
                    correo: correoController.text,
                    direccion: direccionController.text,
                    grupo: grupoSeleccionado,
                  );

                  await DatabaseHelper.instance.create(nuevoContacto);

                  // 🔔 ENVÍA LA NOTIFICACIÓN (el smartwatch la reflejará)
                  await mostrarNotificacionContactoGuardado(nuevoContacto.nombre);

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Contacto guardado'),
                      content: const Text('El contacto ha sido guardado exitosamente.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        )
                      ],
                    ),
                  );
                },
                child: const Text("GUARDAR CONTACTO", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
