class Pedido {
  bool aprobado;
  bool cancelado;
  bool pendienteAprobacion;
  String sId;
  HorarioId horarioId;
  int cantidad;
  String usuarioReservado;
  String dondeSube;
  DateTime createdAt;
  int iV;

  Pedido(
      {this.aprobado,
      this.cancelado,
      this.pendienteAprobacion,
      this.sId,
      this.createdAt,
      this.horarioId,
      this.cantidad,
      this.usuarioReservado,
      this.dondeSube,
      this.iV});

  Pedido.fromJson(Map<String, dynamic> json) {
    aprobado = json['aprobado'];
    cancelado = json['cancelado'];
    createdAt = DateTime.parse(json['createdAt']);
    sId = json['_id'];
    pendienteAprobacion = json['pendiente_aprobacion'];
    horarioId = json['horario_id'] != null
        ? new HorarioId.fromJson(json['horario_id'])
        : null;
    cantidad = json['cantidad'];
    usuarioReservado = json['usuario_reservado'];
    dondeSube = json['donde_sube'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aprobado'] = this.aprobado;
    data['cancelado'] = this.cancelado;
    data['pendiente_aprobacion'] = this.pendienteAprobacion;
    data['createdAt'] = this.createdAt.toIso8601String();
    data['_id'] = this.sId;
    if (this.horarioId != null) {
      data['horario_id'] = this.horarioId.toJson();
    }
    data['cantidad'] = this.cantidad;
    data['usuario_reservado'] = this.usuarioReservado;
    data['donde_sube'] = this.dondeSube;
    data['__v'] = this.iV;
    return data;
  }
}

class HorarioId {
  String sId;
  String hora;
  String hacia;
  String precio;
  IdAdmin idAdmin;

  HorarioId({this.sId, this.hora, this.hacia, this.idAdmin});

  HorarioId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hora = json['hora'];
    hacia = json['hacia'];
    precio = json['precio'];
    idAdmin = json['id_admin'] != null
        ? new IdAdmin.fromJson(json['id_admin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['hora'] = this.hora;
    data['hacia'] = this.hacia;
    data['precio'] = this.precio;
    if (this.idAdmin != null) {
      data['id_admin'] = this.idAdmin.toJson();
    }
    return data;
  }
}

class IdAdmin {
  String sId;
  String usuario;

  IdAdmin({this.sId, this.usuario});

  IdAdmin.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    usuario = json['usuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['usuario'] = this.usuario;
    return data;
  }
}