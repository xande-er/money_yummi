import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart';

Socket socket;

class ConnectSocket {
  var url = 'https://a25df7bf219f.ngrok.io';

  connect() {
    socket = io(url, <String, dynamic>{
      'transports': ['websocket'],
      'forceNew': true
    });

    socket.connect();

//     socket.on('connect', (_) async {
//       print('conn');
//       socket.emit('auth/authorization', {
//   'email':'sashamot@gmail.com',
//   'pass':'123123',
//   'con_pass':'123123',
// });
//       socket.on('chat_mes', (res) async {
//         print(res);
//       });
//     });
  }
}
