import 'package:coffee_order_app_flutter/models/cart.model.dart';
import 'package:coffee_order_app_flutter/models/coffee_item.model.dart';
import 'package:coffee_order_app_flutter/models/treat_item.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final coffee = CoffeeItem.mockItems.first; // 2.00€

  test('size changes coffee price', () {
    expect(coffee.priceFor('S'), closeTo(1.2, 1e-9));
    expect(coffee.priceFor('M'), 2.0);
    expect(coffee.priceFor('L'), closeTo(3.2, 1e-9));
  });

  test('cart totals sizes and treats, supports remove and clear', () {
    final treat = TreatItem.mockItems.first; // 6.34€
    final large = CartItem(coffee: coffee, size: 'L');
    final smallWithTreat = CartItem(coffee: coffee, size: 'S', treat: treat);
    final cart = Cart()
      ..add(large)
      ..add(smallWithTreat);
    expect(cart.total, closeTo(3.2 + 7.54, 1e-9));

    cart.remove(large);
    expect(cart.value, [smallWithTreat]);

    cart.clear();
    expect(cart.total, 0);
  });
}
