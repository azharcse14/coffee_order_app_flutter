import 'package:coffee_order_app_flutter/widgets/treats_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors_constants.dart';
import '../config/services_locator.dart';
import '../models/coffee_item.model.dart';
import '../services/navigation.service.dart';

class SweetTreatsWidget extends StatefulWidget {
  final CoffeeItem coffee;
  final String size;
  const SweetTreatsWidget({super.key, required this.coffee, required this.size});

  @override
  State<SweetTreatsWidget> createState() => _SweetTreatsWidgetState();
}

class _SweetTreatsWidgetState extends State<SweetTreatsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle titleStyle = GoogleFonts.montserrat(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      height: 1,
      color: kTitleColor,
    );
    return Stack(
      children: [
        _buildBackground(),
        TreatsListWidget(coffee: widget.coffee, size: widget.size),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: size.width * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Hero(
                            tag: "coffee_${widget.coffee.id}_name",
                            child: Text(
                              widget.coffee.name,
                              style: titleStyle,
                              textAlign: TextAlign.right,
                            )),
                        const SizedBox(height: 30),
                        Text("Would you like to add some sweet treats?",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.questrial(
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
                                color: kTitleColor.withValues(alpha: .5))),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kTitleColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                                  alignment: Alignment.centerLeft,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                onPressed: () {
                                  locator<NavigationService>().navigateTo(NavigationArguments(
                                      coffee: CoffeeItem.mockItems.indexOf(widget.coffee),
                                      isCheckout: true,
                                      size: widget.size));
                                },
                                child: Text("No, thanks!"))),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildBackground() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topLeft,
              begin: Alignment.bottomRight,
              stops: [0.0, .50],
              colors: [kBrownColor.withValues(alpha: .7), kBrownColor.withValues(alpha: 0.0)],
            ),
          )),
        ),
        Expanded(
          flex: 1,
          child: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, .4],
              colors: [kBrownColor.withValues(alpha: .5), kBrownColor.withValues(alpha: 0.0)],
            ),
          )),
        ),
      ],
    );
  }
}
