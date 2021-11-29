import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'home_controller.dart';
export 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
        IconButton(
          icon: const Icon(LineIcons.sign),
          onPressed: () => controller.logOut(),
        ),
        const Text('Inicio'),
        const TestDataBaseConnection(),
      ]).p3.safeArea(),
    );
  }
}

class TestDataBaseConnection extends StatefulWidget {
  const TestDataBaseConnection({Key? key}) : super(key: key);

  @override
  _TestDataBaseConnectionState createState() => _TestDataBaseConnectionState();
}

class _TestDataBaseConnectionState extends State<TestDataBaseConnection> {
  String name =
      'Buscar el ID 1 en la base de datos. Si les aparece un error en la conexión a la base de datos, intenten poner en las credenciales la dirección ip de su computadora y/o actualizar los privilegios de xampp';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(name),
          OutlinedButton(
            onPressed: () async {
              var a = (await Student.findById(269547)).name;
              setState(() {
                name = a;
              });
            },
            child: const Text('Buscar'),
          ),
        ],
      ),
    );
  }
}
