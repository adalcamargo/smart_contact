class Note {
  final int? id;
  String usuario;
  String contrasena;

  Note({this.id, required this.usuario, required this.contrasena});

  Map<String, Object?> toMap() {
    return {'id': id, 'usuario': usuario, 'contrasena': contrasena};
  }

}