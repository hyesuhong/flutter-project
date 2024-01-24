import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Currency {
  final String currency, unit;
  final int amount;
  final IconData icon;

  Currency({
    required this.currency,
    required this.unit,
    required this.amount,
    required this.icon,
  });
}

class CurrencyCard extends StatelessWidget {
  final Currency currencyData;
  final int index;

  bool get isInverted => index.isOdd;

  final _darkColor = const Color(0xff1f2123);
  final _lightColor = Colors.white;

  CurrencyCard({
    super.key,
    required this.currencyData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var backgroundColor = isInverted ? _lightColor : _darkColor;
    var textColor = isInverted ? _darkColor : _lightColor;

    final formatCurrency = NumberFormat.simpleCurrency(
      locale: 'ko_KR',
      name: '',
      decimalDigits: 0,
    );

    return Transform.translate(
      offset: Offset(0, (-15 * index).toDouble()),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.elliptical(60, 40),
            bottomLeft: Radius.elliptical(60, 40),
          ),
        ),
        padding: EdgeInsets.only(
          top: 24,
          bottom: 32,
          left: 16,
          right: 16,
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currencyData.currency,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      formatCurrency.format(currencyData.amount),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      currencyData.unit,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(-5.0, 40.0)
                ..scale(2.5, 2.5, 2.5),
              alignment: Alignment.center,
              child: Icon(
                currencyData.icon,
                color: textColor,
                size: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
