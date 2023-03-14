import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prajwol/paymentSuccess.dart';

class checkout_screen extends StatefulWidget {
  @override
  State<checkout_screen> createState() => _checkout_screenState();
}

class _checkout_screenState extends State<checkout_screen> {
  String? _errorMessage;
  Map<String, dynamic>? paymentIntent;
  var amt = Get.arguments;
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        addOrder(amt[1]);
        Get.snackbar("title", "pay success");
      });
      // paymentIntent = null;
    } catch (e) {
      print(e);
    }
  }

  createPaymentIntent(String amount, String Currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculate(amount),
        'currency': Currency,
        'payment_method_types[]': 'card'
      };
      var respose = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization':
                'Bearer sk_test_51MQDM6KWlepehOjhIZ0QMgodxNHy1lZPajTGYksmNcjUe2yiMd9GZ57omHdz8DVdnKWz322NlBFBK18E6ZFU5Pxz00MU2q3piA',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: body);
      return jsonDecode(respose.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
        onPressed: () async {
          await makePayment();
        },
        child: Text("checkout ${amt[0]}"),
      )),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10', 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
                  customerId: paymentIntent!['customer'],
                  merchantDisplayName: "cyclemandu"))
          .then((value) {});
      displayPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  calculate(amountToConv) {
    var finalAmount = int.parse(amountToConv) * 100;
    return finalAmount.toString();
  }
}
