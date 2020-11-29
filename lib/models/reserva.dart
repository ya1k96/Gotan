import 'dart:convert';

Reserva reservaFromJson(String str) => Reserva.fromJson(json.decode(str));

String reservaToJson(Reserva data) => json.encode(data.toJson());
class Reserva {
    String id;
    String horarioId;
    String usuarioReservado;
    int cantidad;    
    String dondeSube;
    bool aprobado;

    Reserva({
        this.id,
        this.horarioId,
        this.cantidad,
        this.usuarioReservado,
        this.dondeSube,
        this.aprobado
    });

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        id              : json["id"],
        horarioId       : json["horario_id"],
        cantidad        : json["cantidad"],
        usuarioReservado: json["usuario_reservado"],
        dondeSube       : json["donde_sube"],
        aprobado        : json["aprobado"]  
    );

    Map<String, dynamic> toJson() => {
        "horario_id"       : horarioId,
        "cantidad"         : cantidad,
        "usuario_reservado": usuarioReservado, 
        "donde_sube"       : dondeSube,
        "aprobado"         : aprobado
    };
}
