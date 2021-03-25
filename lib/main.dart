import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:money_yummi/model_user/model_user.dart';
import 'package:money_yummi/server/socket/connect.dart';
import 'package:money_yummi/start/login/auto_login.dart';
import 'package:money_yummi/start/start.dart';
import 'package:path_provider/path_provider.dart';

bool startActive = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ModelUserAdapter());

  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  await Hive.openBox('modelUser');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartHook(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() {});
    return FutureBuilder<String>(
        future: future,
        builder: (context, snapshot) {
          if (!startActive) load(context);
          startActive = true;
          return Container(
            color: const Color(0xff2C304B),
          );
        });
  }

  Future load(context) async {
    await ConnectSocket().connect();
    ModelUser modelUser = await Hive.box('modelUser').get('modelUser');
    try {
      if (modelUser.email != null && modelUser.pass != null) {
        await autoLogin(modelUser, context);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Start()));
      }
    } catch (_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Start()));
    }

  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
