import 'package:get_it/get_it.dart';

import '../models/cart.model.dart';
import '../services/navigation.service.dart';

GetIt locator = GetIt.instance;

void initServicesLocator() {
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<Cart>(Cart());
}
