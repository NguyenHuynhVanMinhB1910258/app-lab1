// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/products/edit_product_screen.dart';
import 'package:flutter_application_1/ui/screens.dart';
import 'package:provider/provider.dart';
import '../products/products_manager.dart';
import '../../models/product.dart';
class UserProductListTile extends StatelessWidget {
  final Product product;

  const UserProductListTile(
    this.product, {
      super.key,
    });
    @override
    Widget build(BuildContext context) {
      return ListTile(
        title: Text(product.title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              buildEditButton(context),
              buildDeleButton(context),
            ],
          ),
        ),
      );
    }
    Widget buildDeleButton(BuildContext context){
      return IconButton(
        icon: const Icon(Icons.delete),
        onPressed:(){
          context.read<ProductsManager>().deleteProduct(product.id!);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Product deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        color: Theme.of(context).errorColor,
        );
    }
    Widget buildEditButton(BuildContext context){
      return IconButton(
        icon: const Icon(Icons.edit),
        onPressed: (){
          Navigator.of(context).pushNamed(
            EditProductScreen.routeName,
            arguments: product.id,
          );
        },
        color: Theme.of(context).primaryColor,
      );
    }
}