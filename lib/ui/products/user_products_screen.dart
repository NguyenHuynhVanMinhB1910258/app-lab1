// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/products/edit_product_screen.dart';
import 'user_product_list_tile.dart';
import 'products_manager.dart';
import '../shared/app_drawer.dart';
import 'package:provider/provider.dart';
import 'edit_product_screen.dart';
class UserProductsScreen extends StatelessWidget{
  static const routeName = '/user-products';
  const UserProductsScreen ({super.key});

  @override
  Widget build(BuildContext context){
    final productsManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
      title: const Text('Yor Products'),
      actions: <Widget>[
        buildAddButton(context),
      ],
      ),
    drawer: const AppDrawer(),
    body: RefreshIndicator(
      onRefresh: () async=> print('refresh products'),
      child: buildUserProductListView(),
    ),
    );
  }
  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }
  Widget buildUserProductListView() {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}