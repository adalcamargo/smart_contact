import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'contact.dart';
import 'editar.dart';
import 'database_helper.dart';

class VerContactoPage extends StatefulWidget {
  final Contact contact;
  final VoidCallback onDelete;

  const VerContactoPage({
    super.key,
    required this.contact,
    required this.onDelete,
  });

  @override
  State<VerContactoPage> createState() => _VerContactoPageState();
}

class _VerContactoPageState extends State<VerContactoPage> {
  late Contact contactoActual;

  @override
  void initState() {
    super.initState();
    contactoActual = widget.contact;
  }

  Future<void> _editarContacto() async {
    final actualizado = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(
        builder: (_) => EditarContactoPage(contact: contactoActual),
      ),
    );

    if (actualizado != null) {
      // Guardar cambios en la base de datos
      await DatabaseHelper.instance.update(actualizado);

      // Leer nuevamente desde la base de datos para asegurar datos frescos
      final contactoRecargado =
          await DatabaseHelper.instance.readContact(actualizado.id!);

      setState(() {
        contactoActual = contactoRecargado;
      });
    }
  }

  void _llamarContacto(String telefono) async {
    final Uri uri = Uri(scheme: 'tel', path: telefono);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir el marcador para $telefono';
    }
  }

  void _confirmarEliminar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Seguro que deseas eliminar a ${contactoActual.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDelete();
              Navigator.pop(context); // Volver atrás después de borrar
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:\n',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Contacto'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItem('Nombre', contactoActual.nombre),
                    _buildItem('Teléfono', contactoActual.telefono),
                    _buildItem('Correo electrónico', contactoActual.correo),
                    _buildItem('Dirección', contactoActual.direccion),
                    _buildItem('Grupo', contactoActual.grupo),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.call),
                  label: const Text("Llamar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _llamarContacto(contactoActual.telefono),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Editar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _editarContacto,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text("Eliminar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _confirmarEliminar(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
