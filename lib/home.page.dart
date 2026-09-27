import 'package:coffee_order_app_flutter/config/services_locator.dart';
import 'package:coffee_order_app_flutter/models/coffee_item.model.dart';
import 'package:coffee_order_app_flutter/models/treat_item.model.dart';
import 'package:coffee_order_app_flutter/services/navigation.service.dart';
import 'package:coffee_order_app_flutter/widgets/checkout.widget.dart';
import 'package:coffee_order_app_flutter/widgets/intro.widget.dart';
import 'package:coffee_order_app_flutter/widgets/sweet_treats.widget.dart';
import 'package:flutter/material.dart';

import 'coffe_details.page.dart';
import 'widgets/coffee_list.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              locator.get<NavigationService>().navigatorKey.currentState!.maybePop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          clipBehavior: Clip.none,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Navigator(
                  key: locator.get<NavigationService>().navigatorKey,
                  observers: [locator.get<NavigationService>().heroController],
                  onGenerateRoute: (settings) {
                    NavigationArguments? args = settings.arguments as NavigationArguments?;
                    late Widget currentPage;
                    bool toHome = false;

                    if (args == null) {
                      if (settings.name == 'home') {
                        toHome = true;
                      }
                      currentPage = settings.name == 'home' ? const CofeeListWidget() : const IntroWidget();
                    } else {
                      currentPage = CoffeeDetailsPage(
                        coffee: CoffeeItem.mockItems[args.coffee],
                      );
                      if (args.isSweetTreats) {
                        currentPage =
                            SweetTreatsWidget(coffee: CoffeeItem.mockItems[args.coffee], size: args.size);
                      }
                      if (args.isCheckout) {
                        currentPage = CheckoutWidget(
                          coffee: CoffeeItem.mockItems[args.coffee],
                          treat: args.treat != null ? TreatItem.mockItems[args.treat!] : null,
                          size: args.size,
                        );
                      }
                    }

                    return PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: toHome ? 800 : 300),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: Container(color: Colors.white, child: currentPage),
                          );
                        });
                  }),
            ],
          ),
        ));
  }
}
