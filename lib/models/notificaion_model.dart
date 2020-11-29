class Notificaciones {
  String titulo;
  String cantidad;
  String estado;

  Notificaciones({this.titulo, this.cantidad, this.estado});

  Notificaciones.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    cantidad = json['cantidad'];
    estado = json['Estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['cantidad'] = this.cantidad;
    data['Estado'] = this.estado;
    return data;
  }
}