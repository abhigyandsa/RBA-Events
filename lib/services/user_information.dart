import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class UserInformation {
  final String? name;
  final String email;
  final String? phone;
  final int? adminlevel;

  const UserInformation({
    required this.email,
    this.name,
    this.phone,
    this.adminlevel,
  });

  // Future<Map<String, dynamic>> getUserInformation(String email) async {
  //   final userInformation = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('email', isEqualTo: email)
  //       .get();

  //   return userInformation.docs.first.data();
  //   // name = userInformationData['name'];
  //   // phone = userInformationData['phone'];
  // }

  Future<void> postUserInformation() async {
    await FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'name': name,
      'phone': phone,
    });
  }

  @override
  String toString() {
    return 'UserInformation{email: $email, name: $name, phone: $phone, adminlevel: $adminlevel}';
  }
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final userList = snapshot.data?.docs ?? [];
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            final userData = userList[index].data() ?? {};
            final name = (userData as Map)['name'];
            return ListTile(
              title: Text(name ?? ''),
            );
          },
        );
      },
    );
  }
}
