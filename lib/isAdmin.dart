import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final adminToken = "7ghhBVKMCSQFeHNAHBMAuwAupQ93";
bool isAdmin(Token) {
  if (adminToken.toString() == Token.toString()) {
    print('===============================');
    print("userToken:${Token}");
    print('===============================');

    print("admintokern :${adminToken}");
    print('===============================');

    return true;
  } else {
    print('===============================');
    print("userToken:${Token}");
    print('===============================');

    print("admintokern :${adminToken}");
    print('===============================');
    return false;
  }
  ;
}
