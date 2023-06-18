import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rba/widgets/user_information.dart';

final userProvider =
    NotifierProvider<UserNotifier, UserInformation?>(UserNotifier.new);

class UserNotifier extends Notifier<UserInformation?> {
  @override
  UserInformation? build() {
    return null;
  }

  void login(String email) async {
    final userInformation = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    final String? name = userInformation.docs.first.data()['name'];
    final String? phone = userInformation.docs.first.data()['phone'];
    final int? adminlevel = userInformation.docs.first.data()['adminlevel'];

    state = UserInformation(
      email: email,
      name: name,
      adminlevel: adminlevel,
      phone: phone,
    );
  }

  void userInformationUpdate() {
    throw UnimplementedError;
  }
}
