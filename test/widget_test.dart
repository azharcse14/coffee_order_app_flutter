import 'package:coffee_order_app_flutter/models/coffee_item.model.dart';
import 'package:coffee_order_app_flutter/models/treat_item.model.dart';
import 'package:coffee_order_app_flutter/widgets/checkout.widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final coffee = CoffeeItem.mockItems.first; // 2.00€

  test('size changes coffee price', () {
    expect(coffee.priceFor('S'), closeTo(1.2, 1e-9));
    expect(coffee.priceFor('M'), 2.0);
    expect(coffee.priceFor('L'), closeTo(3.2, 1e-9));
  });

  test('checkout total includes size and treat', () {
    final treat = TreatItem.mockItems.first; // 6.34€
    expect(CheckoutWidget(coffee: coffee, size: 'L').total, closeTo(3.2, 1e-9));
    expect(CheckoutWidget(coffee: coffee, treat: treat, size: 'S').total, closeTo(7.54, 1e-9));
  });
}
