import 'package:flutter/material.dart';
import 'contact.dart';

class EditarContactoPage extends StatefulWidget {
  final Contact contact;

  const EditarContactoPage({super.key, required this.contact});

  @override
  State<EditarContactoPage> createState() => _EditarContactoPageState();
}

class _EditarContactoPageState extends State<EditarContactoPage> {
  late TextEditingController nombreController;
  late TextEditingController telefonoController;
  late TextEditingController correoController;
  late TextEditingController direccionController;
  late String grupoSeleccionado;

  final List<String> grupos = ['Familia', 'Amigos', 'Trabajo', 'Otros'];

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.contact.nombre);
    telefonoController = TextEditingController(text: widget.contact.telefono);
    correoController = TextEditingController(text: widget.contact.correo);
    direccionController = TextEditingController(text: widget.contact.direccion);
    grupoSeleccionado = widget.contact.grupo;
  }

  @override
  void dispose() {
    nombreController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Contacto'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextField(controller: nombreController, label: 'Nombre', icon: Icons.person),
            const SizedBox(height: 20),
            _buildTextField(controller: telefonoController, label: 'Teléfono', icon: Icons.phone, keyboardType: TextInputType.phone),
            const SizedBox(height: 20),
            _buildTextField(controller: correoController, label: 'Correo electrónico', icon: Icons.email, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            _buildTextField(controller: direccionController, label: 'Dirección', icon: Icons.home),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: grupoSeleccionado,
              decoration: InputDecoration(
                labelText: 'Grupo',
                prefixIcon: Icon(Icons.group, color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: grupos.map((grupo) {
                return DropdownMenuItem(
                  value: grupo,
                  child: Text(grupo),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  grupoSeleccionado = value!;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                final contactoEditado = Contact(
                  id: widget.contact.id, // 🔹 Agregado para que se actualice en BD
                  nombre: nombreController.text,
                  telefono: telefonoController.text,
                  correo: correoController.text,
                  direccion: direccionController.text,
                  grupo: grupoSeleccionado,
                );
                Navigator.pop(context, contactoEditado);
              },
              icon: const Icon(Icons.save),
              label: const Text("Guardar Cambios", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
