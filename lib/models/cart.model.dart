import 'package:flutter/foundation.dart';

import 'coffee_item.model.dart';
import 'treat_item.model.dart';

class CartItem {
  final CoffeeItem coffee;
  final String size;
  final TreatItem? treat;

  const CartItem({required this.coffee, required this.size, this.treat});

  double get price => coffee.priceFor(size) + (treat?.price ?? 0);
}

class Cart extends ValueNotifier<List<CartItem>> {
  Cart() : super(const []);

  double get total => value.fold(0, (sum, item) => sum + item.price);

  void add(CartItem item) => value = [...value, item];

  void remove(CartItem item) => value = [...value]..remove(item);

  void clear() => value = const [];
}
