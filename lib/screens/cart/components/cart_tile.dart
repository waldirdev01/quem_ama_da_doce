import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_iconbutton.dart';
import '../../../models/cart/cart_product.dart';


class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct, {super.key});

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product!.images.first),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        cartProduct.product!.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho: ${cartProduct.size}',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProduct>(builder: (_, cartProduct, __) {
                        if(cartProduct.hasStock)
                        return Text(
                          'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0, fontWeight: FontWeight.bold),
                        );
                        else
                          return Text(
                          'Sem estoque disponível.',
                          style: TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold),
                        );
                      })
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(
                  builder: (_, cartProductManager, __) => Column(
                        children: <Widget>[
                          CustomIconButton(
                            iconData: Icons.add,
                            color: Theme.of(context).primaryColor,
                            onTap: cartProduct.hasStock ? cartProduct.increment : null,
                          ),
                          Text(
                            '${cartProduct.quantity}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          CustomIconButton(
                            iconData: Icons.remove,
                            color: cartProduct.quantity > 1 ?Theme.of(context).primaryColor: Colors.redAccent,
                            onTap: cartProduct.decrement,
                          ),
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
