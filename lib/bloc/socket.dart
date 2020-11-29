// Auxilio para sockets
// //import 'package:adhara_socket_io/manager.dart';
// import 'package:flutter_login_page_ui/bloc/notification.dart';
// //import 'package:adhara_socket_io/options.dart';
// //import 'package:adhara_socket_io/socket.dart';
// //import 'package:socket_io_client/socket_io_client.dart' as IO;

// class Socket {
//   SocketIOManager manager = SocketIOManager();
//   IO.Socket socket;
//   //SocketIOManager manager = SocketIOManager();
//   //SocketIO socket;
  
//   void init() async {
//     //adhara plugin
//    // socket = await manager.createInstance(
//    // SocketOptions('http://192.168.1.10:3000', 
//    //     nameSpace: '/chat',
//    //     enableLogging: true,
//    //     transports: [Transports.POLLING])
//    // );

//     //socket.connect();
//     //socket.on('connect', (client) { print('conectado'); });
//   }

//   void connect() {
//     socket = IO.io('http://192.168.1.10:3000/', <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': false,
//       });  
//     socket.connect();

//     socket.on('connect', (client) {
//       print('conectado');
//     });

//   }

//   registroUsuario(dynamic usuario) {
//     this.desconectar();

//     this._conect('user');
//     socket.emit('registroU', usuario);
//   }
  
//   registroAdmin(dynamic admin) {
//     this.desconectar();

//     this._conect('admin');
//     socket.emit('registroA', admin);

//     socket.on('notif-reserva', (data)  {
//       print(data.toString());
//       //Notificacion().showNotification('¡Nueva reserva!', 'Te llego un pedido. revisalo.','payload');
//     });
//   }

//   nuevaReserva(dynamic reserva) {
//     socket.emit('reserva-client', reserva);
//   }

//   void desconectar() {
//     print('desconectando');
//     socket.io.destroy(socket);

//   }

//   conectado() {
//     print('conectado');
//   }

//   _conect( String nsps ) {
//     socket = IO.io('http://192.168.1.10:3000/$nsps', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     socket.connect();
//   }
// }

// final Socket blocS = new Socket();