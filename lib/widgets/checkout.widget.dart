import 'package:coffee_order_app_flutter/models/coffee_item.model.dart';
import 'package:coffee_order_app_flutter/models/treat_item.model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors_constants.dart';

class CheckoutWidget extends StatelessWidget {
  final CoffeeItem coffee;
  final TreatItem? treat;
  final String size;
  const CheckoutWidget({super.key, required this.coffee, this.treat, this.size = 'M'});

  double get total => coffee.priceFor(size) + (treat?.price ?? 0);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildBackground(),
        Hero(
          tag: "coffee_${coffee.id}",
          child: Image.asset(
            coffee.image,
            fit: BoxFit.contain,
          ),
        ),
        if (treat != null)
          Align(
            alignment: const Alignment(2, 0.5),
            child: SizedBox(
              width: screen.width * 0.8,
              child: Hero(
                tag: "treat_${treat!.id}",
                child: Image.asset(
                  treat!.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("My Order",
                  style: GoogleFonts.montserrat(
                      fontSize: 30, fontWeight: FontWeight.w700, height: 1, color: kTitleColor)),
              const SizedBox(height: 25),
              _line("${coffee.name} · ${CoffeeItem.sizeNames[size]}", coffee.priceFor(size)),
              if (treat != null) _line(treat!.name, treat!.price),
              Divider(height: 24, color: kTitleColor.withValues(alpha: .15)),
              _line("Total", total, bold: true),
              const Spacer(),
              SafeArea(
                top: false,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kTitleColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _placeOrder(context),
                  child: Text("Checkout (${total.toStringAsFixed(2)}€)",
                      style: GoogleFonts.questrial(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _line(String label, double price, {bool bold = false}) {
    final style = GoogleFonts.questrial(
        fontSize: 18,
        letterSpacing: 1,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        color: kTitleColor);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text("${price.toStringAsFixed(2)}€",
              style: style.copyWith(
                  fontWeight: FontWeight.w700, color: kTitleColor.withValues(alpha: bold ? 1 : .7))),
        ],
      ),
    );
  }

  Future<void> _placeOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: kBrownColor,
                child: Icon(Icons.check, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 20),
              Text("Order placed!",
                  style:
                      GoogleFonts.montserrat(fontSize: 26, fontWeight: FontWeight.w700, color: kTitleColor)),
              const SizedBox(height: 8),
              Text("Your ${coffee.name} will be ready in a few minutes.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.questrial(fontSize: 16, color: kTitleColor.withValues(alpha: .6))),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kTitleColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text("Back to menu", style: GoogleFonts.questrial(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    navigator.popUntil(ModalRoute.withName('home'));
  }
}

Widget _buildBackground() {
  return Column(
    children: [
      Expanded(
        child: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
            stops: const [0.0, .50],
            colors: [kBrownColor.withValues(alpha: .7), kBrownColor.withValues(alpha: 0.0)],
          ),
        )),
      ),
      Expanded(
        child: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, .4],
            colors: [kBrownColor.withValues(alpha: .5), kBrownColor.withValues(alpha: 0.0)],
          ),
        )),
      ),
    ],
  );
}
