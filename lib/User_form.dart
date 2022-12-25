import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prajwol/Btn.dart';
import 'package:prajwol/Field.dart';

class user_form extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final EmailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  void Update() {
    final user = FirebaseAuth.instance.currentUser!;
    final dispName;
    final E;
    final phone;

    (firstNameController.text.trim() == null &&
            lastNameController.text.trim() == null)
        ? dispName = user.displayName
        : dispName = firstNameController.text + " " + lastNameController.text;
    (EmailController.text.trim() == null)
        ? E = user.email
        : E = EmailController.text;

    (phoneNumberController == null)
        ? phone = user.phoneNumber
        : phone = phoneNumberController.text;
    user.updateDisplayName(dispName);
    user.updateEmail(E);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Field(firstNameController, context, "First Name"),
                  Field(lastNameController, context, "Last name"),
                  Field(EmailController, context, "Email"),
                  Center(
                    child: Btn(Update, Icons.update),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
