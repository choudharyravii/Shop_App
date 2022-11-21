import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  Product item;

  UserProductItem({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(
                  EditScreenProduct.routeName,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
