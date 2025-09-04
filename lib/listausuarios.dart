import 'package:aplicacion1/bd/operaciones.dart';
import 'package:aplicacion1/modelo/actualizar.dart';
import 'package:aplicacion1/modelo/note.dart';
import 'package:flutter/material.dart';

class Listausuarios extends StatefulWidget {
  const Listausuarios({super.key});

  @override
  State<Listausuarios> createState() => _ListausuariosState();
}

class _ListausuariosState extends State<Listausuarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usuarios"),
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
      ),
      body: Milista(),
      backgroundColor: Colors.blue.shade50, // Fondo suave azul claro
    );
  }
}

class Milista extends StatefulWidget {
  @override
  State<Milista> createState() => _MilistaState();
}

class _MilistaState extends State<Milista> {
  List<Note> muestraUsuarios = [];

  @override
  void initState() {
    super.initState();
    _obtenerDatosBD();
  }

  @override
  Widget build(BuildContext context) {
    if (muestraUsuarios.isEmpty) {
      // Mostrar indicador de carga o mensaje si está vacío
      return Center(
        child: Text(
          "No hay usuarios para mostrar",
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      );
    }
    return ListView.builder(
      itemCount: muestraUsuarios.length,
      itemBuilder: (context, index) {
        return _cargarElementos(index);
      },
    );
  }

  _obtenerDatosBD() async {
    List<Note> auxMuestraUsuarios = await Operaciones.consulta();
    setState(() {
      muestraUsuarios = auxMuestraUsuarios;
    });
  }

  _cargarElementos(int index) {
    final usuario = muestraUsuarios[index];
    return Dismissible(
      key: Key(usuario.id.toString()), // Usar id único si tienes
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red.shade700,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Borrar",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        Operaciones.eliminar(usuario);
        setState(() {
          muestraUsuarios.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario borrado')),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            usuario.usuario,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade900,
              fontSize: 18,
            ),
          ),
          trailing: MaterialButton(
            minWidth: 40,
            height: 40,
            color: Colors.blue.shade700,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => actualizar(nota: usuario),
                ),
              );
            },
            child: Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
