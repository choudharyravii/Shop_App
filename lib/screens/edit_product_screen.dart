// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditScreenProduct extends StatefulWidget {
  static const routeName = '/EditScreenProduct';
  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final urlFocusNode = FocusNode();
  final imageurlcontroller = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  void dispose() {
    //...
    descriptionFocusNode.dispose();
    priceFocusNode.dispose();
    imageurlcontroller.dispose();
    // super.dispose();
    //...
  }

  EditScreenProduct({super.key});

  @override
  State<EditScreenProduct> createState() => _EditScreenProductState();
}

class _EditScreenProductState extends State<EditScreenProduct> {
  void _saveForm(BuildContext context) {
    final isvalid = widget._form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    widget._form.currentState?.save();
    Provider.of<Products>(context, listen: false)
        .addProduct(widget._editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product "),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget._form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tittle'),
                textInputAction: TextInputAction.next,
                validator: (values) {
                  if (values!.isEmpty) {
                    return 'Please Provide A Value';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(widget.priceFocusNode);
                },
                onSaved: (value) {
                  widget._editedProduct = Product(
                    title: value!,
                    price: widget._editedProduct.price,
                    description: widget._editedProduct.description,
                    imageUrl: widget._editedProduct.imageUrl,
                    id: '',
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: widget.priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(widget.descriptionFocusNode);
                },
                validator: (values) {
                  if (values!.isEmpty) {
                    return 'Please Enter Price';
                  }
                  if (double.tryParse(values) == null) {
                    return 'Please Enter A Valid Number';
                  }
                  if (double.parse(values) <= 0) {
                    return 'Enter Value Grater Then 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget._editedProduct = Product(
                    title: widget._editedProduct.title,
                    price: double.parse(value!),
                    description: widget._editedProduct.description,
                    imageUrl: widget._editedProduct.imageUrl,
                    id: '',
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: widget.descriptionFocusNode,
                validator: (values) {
                  if (values!.isEmpty) {
                    return 'Please Provide A Description';
                  }
                  if (values.length < 10) {
                    return 'MiniMum Enter 10 Char';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget._editedProduct = Product(
                    title: widget._editedProduct.title,
                    price: widget._editedProduct.price,
                    description: value!,
                    imageUrl: widget._editedProduct.imageUrl,
                    id: '',
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                    child: widget.imageurlcontroller.text.isEmpty
                        ? Text("Enter Image Url")
                        : FittedBox(
                            child:
                                Image.network(widget.imageurlcontroller.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Enter Image Url'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      onFieldSubmitted: (text) {
                        setState(() {});
                      },
                      controller: widget.imageurlcontroller,
                      // maxLines: 3,
                      focusNode: widget.urlFocusNode,
                      validator: ((values) {
                        if (values!.isEmpty) {
                          return 'Please Enter Image Url';
                        }
                        if (!values.startsWith('http') &&
                            !values.startsWith('https')) {
                          return 'Enter A Valid Url - ex. https//';
                        }
                      }),
                      onSaved: (value) {
                        widget
                          .._editedProduct = Product(
                            title: widget._editedProduct.title,
                            price: widget._editedProduct.price,
                            description: widget._editedProduct.description,
                            imageUrl: value!,
                            id: '',
                          );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
