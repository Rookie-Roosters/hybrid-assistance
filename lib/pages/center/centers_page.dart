import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
import 'package:hybrid_assistance/config/app_pages.dart';
import 'package:hybrid_assistance/config/app_themes.dart';
import 'package:hybrid_assistance/models/center.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';

class CentersPage extends StatefulWidget {
  const CentersPage({Key? key}) : super(key: key);

  @override
  _CentersPageState createState() => _CentersPageState();
}

class _CentersPageState extends State<CentersPage> {
  List<Center> centers = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final a = await Center.getAll();
    setState(() {
      centers = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Centros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Agregar un Centro',
            onPressed: () async {
              await Get.toNamed(Routes.CENTERFORM, arguments: {"update": null, "initialId": await Center.getId()});
              loadData();
            },
          ),
        ],
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(kBorderRadius)),
        child: Container(
          color: kSurfaceColor,
          child: ListView.builder(
            itemCount: centers.length,
            physics: kBouncyScroll,
            padding: kPadding,
            itemBuilder: (context, index) {
              return CenterCard(
                center: centers[index],
                onChanged: loadData,
              ).pb2;
            },
          ),
        ),
      ),
    );
  }
}

class CenterCard extends StatelessWidget {
  final Center center;
  final void Function() onChanged;
  const CenterCard({Key? key, required this.center, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(center.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await center.delete();
              onChanged();
            },
          ),
          onTap: () async {
            await Get.toNamed(Routes.CENTERFORM, arguments: {"update": center, "initialId": null});
            onChanged();
          }),
    );
  }
}
