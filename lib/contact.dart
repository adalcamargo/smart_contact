class Contact {
  final int? id;
  final String nombre;
  final String telefono;
  final String correo;
  final String direccion;
  final String grupo;

  Contact({
    this.id,
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.direccion,
    required this.grupo,
  });

  Contact copyWith({
    int? id,
    String? nombre,
    String? telefono,
    String? correo,
    String? direccion,
    String? grupo,
  }) {
    return Contact(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      correo: correo ?? this.correo,
      direccion: direccion ?? this.direccion,
      grupo: grupo ?? this.grupo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'correo': correo,
      'direccion': direccion,
      'grupo': grupo,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      telefono: map['telefono'] as String,
      correo: map['correo'] as String,
      direccion: map['direccion'] as String,
      grupo: map['grupo'] as String,
    );
  }
}
