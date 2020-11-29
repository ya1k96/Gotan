class Usuario {
  String id;
  bool isGoogle;
  bool isFacebook;
  bool isAdmin;
  Null busName;
  String usuario;
  String email;
  String password;
  int iV;

  Usuario(
      {this.id,
      this.isGoogle,
      this.isFacebook,
      this.isAdmin,
      this.busName,
      this.usuario,
      this.email,
      this.password,
      this.iV});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ?  json['_id'] : null;
    isGoogle = json['is_google'];
    isFacebook = json['is_facebook'];
    isAdmin = json['is_admin'];
    busName = json['bus_name'];
    usuario = json['usuario'];
    email = json['email'];
    password = json['password'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['is_google'] = this.isGoogle;
    data['is_facebook'] = this.isFacebook;
    data['is_admin'] = this.isAdmin;
    data['bus_name'] = this.busName;
    data['usuario'] = this.usuario;
    data['email'] = this.email;
    data['password'] = this.password;
    data['__v'] = this.iV;
    return data;
  }
}
