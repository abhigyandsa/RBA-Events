import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rba/services/user_information.dart';

final userProvider =
    NotifierProvider<UserNotifier, UserInformation?>(UserNotifier.new);

class UserNotifier extends Notifier<UserInformation?> {
  @override
  UserInformation? build() {
    return null;
  }

  void initUsrData(String email) {
    state = UserInformation(email: email);
  }

  void getnsetData() async {
    final email = state!.email;
    final userInformation = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    // final String? name = userInformation.docs.first.data()['name'];
    // final String? phone = userInformation.docs.first.data()['phone'];
    // final int? adminlevel = userInformation.docs.first.data()['adminlevel'];

    state = UserInformation(
      email: email,
      name: 'name',
      adminlevel: 1,
      phone: 'phone',
    );
  }

  void setNull() {
    state = null;
  }

  void userInformationUpdate() {
    throw UnimplementedError;
  }
}
