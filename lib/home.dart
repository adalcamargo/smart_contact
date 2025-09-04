import 'package:aplicacion1/listausuarios.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion1/homepage.dart';
import 'package:aplicacion1/login.dart';
import 'package:aplicacion1/registrar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            "App-9B",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(1, 1),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          centerTitle: true,
          elevation: 6,
          shadowColor: Colors.blueAccent.shade100,
          iconTheme: IconThemeData(color: Colors.white, size: 28),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade400],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(3, 3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: SingleChildScrollView(  // <-- hace que el contenido pueda desplazarse si es necesario
                  child: SafeArea(            // <-- para evitar top padding molesto
                    child: Column(
                      mainAxisSize: MainAxisSize.min,  // <-- ocupa sólo el espacio necesario
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "asset/img/logoa.jpg",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),  // reducimos un poco el espacio
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone, size: 16, color: Colors.white70),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                "(772) 129 8987",
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                                overflow: TextOverflow.ellipsis, // evita overflow de texto
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email, size: 16, color: Colors.white70),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                "adalcama@gmail.com",
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              _buildDrawerItem(
                icon: Icons.home,
                text: "Inicio",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => home()),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.app_registration,
                text: "Registrar",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => registrar()),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.list,
                text: "Lista de Usuarios",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Listausuarios()),
                  );
                },
              ),
              Divider(color: Colors.white54, indent: 20, endIndent: 20),
              _buildDrawerItem(
                icon: Icons.exit_to_app,
                text: "Salir",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Homepage(),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      hoverColor: Colors.blue.shade900,
      splashColor: Colors.blueAccent.shade100,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
