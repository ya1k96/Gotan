import 'dart:convert';

Horario horarioFromJson(String str) => Horario.fromJson(json.decode(str));

String horarioToJson(Horario data) => json.encode(data.toJson());

class Horario {
    String id;
    String nombre;
    String hora;
    String desde;
    String hacia;
    int cupo;
    dynamic idAdmin;
    bool pedidoCerrado;

    Horario({
        this.id,
        this.nombre = '',
        this.hora,
        this.desde,
        this.hacia,
        this.cupo,
        this.idAdmin,
        this.pedidoCerrado
    });

    factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id      : json["_id"],
        nombre  : json["nombre"],
        hora    : json["hora"],
        desde   : json["desde"],
        hacia   : json["hacia"],
        cupo    : json["cupo"],
        idAdmin : json["id_admin"],
        pedidoCerrado : json["pedido_cerrado"],
    );

    Map<String, dynamic> toJson() => {
        "id"      : id,
        "nombre"  : nombre,
        "hora"    : hora,
        "desde"   : desde,
        "hacia"   : hacia,
        "cupo"    : cupo,
        "id_admin": idAdmin,
        "pedido_cerrado": pedidoCerrado,
    };
}