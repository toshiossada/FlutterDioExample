import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  final String title;

  const ProductPage({Key key, this.title = "Product"}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ModularState<ProductPage, ProductController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text(controller.id == null || controller.id == "-1"
              ? 'Cadastrar'
              : 'Editar #${controller.product?.id ?? ''}');
        }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: controller.save,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (_) {
          if (controller.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: <Widget>[
                TextField(
                  onChanged: controller.setDescription,
                  controller: controller.txtDescricao,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descrição",
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
