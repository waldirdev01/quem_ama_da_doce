import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../models/home_section/section_item.dart';
import '../../../models/products/product_manager.dart';

class ItemTile extends StatelessWidget {

  ItemTile({required this.item, this.valueKey, this.height});

  final SectionItem item;
  ValueKey<dynamic>? valueKey;
  double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product = context.read<ProductManager>()
              .findProductById(item.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      child: Card(
        key: ValueKey(valueKey),
        child: SizedBox(
          height:height,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}