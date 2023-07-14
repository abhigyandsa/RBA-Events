import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class UserInformation {
  final String? name;
  final String email;
  final String? phone;
  final int? adminlevel;
  final bool paid;
  final bool accepted_tnc;

  const UserInformation({
    required this.email,
    this.name,
    this.phone,
    this.adminlevel,
    this.paid = false,
    this.accepted_tnc = false,
  });

  Future<void> postUserInformation() async {
    var db = FirebaseFirestore.instance;
    var flag = false;
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['email'] == email) {
          doc.reference.update({
            'name': name,
            'phone': phone,
            'adminlevel': adminlevel,
            "paid": paid,
            "accepted_tnc": accepted_tnc,
          });
          flag = true;
        }
      }
      if (flag == false) {
        db.collection("users").doc(email).set({
          'name': name,
          'email': email,
          'phone': phone,
          'adminlevel': adminlevel,
          "paid": paid,
          "accepted_tnc": accepted_tnc,
        });
      }
    });
  }

  @override
  String toString() {
    return 'UserInformation{email: $email, name: $name, phone: $phone, adminlevel: $adminlevel, paid: $paid, accepted_tnc: $accepted_tnc}';
  }
}
