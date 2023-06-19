import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rba/services/user_information.dart';
import 'package:rba/widgets/cute_qrcode.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
  });

  final UserInformation user;
  static const circleRadius = 100.0;
  static const circleBorderWidth = 8.0;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Padding(
        padding: const EdgeInsets.only(top: circleRadius / 2.0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.only(top: 56.0),
            child: Column(
              children: [
                Text(
                  user.name ?? 'N/A',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  user.phone ?? '+91 1234567890',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(user.email,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        )),
                SizedBox(
                  height: 256 + 8,
                  child: QRCode(text: user.email),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        width: circleRadius,
        height: circleRadius,
        child: Padding(
            padding: const EdgeInsets.all(circleBorderWidth),
            child: Lottie.asset('assets/lottie/female-avatar.json')),
      ),
    ]);
  }
}
