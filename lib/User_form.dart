import 'package:flutter/material.dart';
import 'package:prajwol/Field.dart';

class user_form extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Field(firstNameController, context, "First Name"),
                Field(lastNameController, context, "Last name"),
                Field(phoneNumberController, context, "Phone Number")
              ],
            )),
      ),
    );
  }
}
