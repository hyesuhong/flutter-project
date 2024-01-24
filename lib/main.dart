import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/button.dart' show Button;
import 'package:flutter_application_1/widgets/currency_card.dart';

void main() {
  runApp(const MyApp());
}

var dummyCurrency = [
  Currency(
    currency: 'Euro',
    unit: 'EUR',
    amount: 6428,
    icon: Icons.euro,
  ),
  Currency(
    currency: 'Dollar',
    unit: 'USD',
    amount: 55622,
    icon: Icons.attach_money,
  ),
  Currency(
    currency: 'Rupee',
    unit: 'INR',
    amount: 5534622,
    icon: Icons.currency_rupee,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff181818),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 56,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Hey, Selena',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              Text(
                '\$5 194 482',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    label: 'Transfer',
                    backgroundColor: const Color(0xfff2b33a),
                  ),
                  Button(
                    label: 'Request',
                    backgroundColor: const Color(0xff1f2123),
                    textColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Wallets',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ...List.generate(
                dummyCurrency.length,
                (index) => CurrencyCard(
                    currencyData: dummyCurrency[index],
                    isInverted: index.isOdd),
              )
            ],
          ),
        ),
      ),
    );
  }
}
