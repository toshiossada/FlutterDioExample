import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: controller.downloadPDF),
        ],
      ),
      body: Observer(builder: (_) {
        if (controller.loading || controller.listProducts == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: controller.listProducts.length,
              itemBuilder: (_, i) {
                return ListTile(
                  title: Text(controller.listProducts[i].description),
                  onTap: () async {
                    await Modular.link
                        .pushNamed('/product/${controller.listProducts[i].id}');
                    controller.load();
                  },
                );
              },
            ),
            onRefresh: () async {
              await controller.load();
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Modular.link.pushNamed('/product/-1');
          controller.load();
        },
      ),
    );
  }
}
