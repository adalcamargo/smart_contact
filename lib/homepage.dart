import 'package:flutter/material.dart';
import 'agregar.dart';
import 'editar.dart';
import 'ver_contacto.dart';
import 'contact.dart';
import 'database_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    refreshContacts();
  }

  Future<void> refreshContacts() async {
    contacts = await DatabaseHelper.instance.readAllContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contactos'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[50],
      body: contacts.isEmpty
          ? const Center(child: Text('No hay contactos.'))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Text(
                        contact.nombre.isNotEmpty ? contact.nombre[0] : '?',
                        style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(contact.nombre),
                    subtitle: Text('Tel: ${contact.telefono}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                          tooltip: 'Ver contacto',
                          onPressed: () async {
                            // Espera a que regrese de VerContactoPage y refresca
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VerContactoPage(
                                  contact: contact,
                                  onDelete: () async {
                                    await DatabaseHelper.instance.delete(contact.id!);
                                  },
                                ),
                              ),
                            );
                            // Al volver (por editar o borrar), refrescamos la lista
                            await refreshContacts();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          tooltip: 'Editar contacto',
                          onPressed: () async {
                            final updated = await Navigator.push<Contact>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditarContactoPage(contact: contact),
                              ),
                            );
                            if (updated != null) {
                              await DatabaseHelper.instance.update(updated);
                              await refreshContacts();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AgregarContacto()));
          await refreshContacts();
        },
      ),
    );
  }
}
