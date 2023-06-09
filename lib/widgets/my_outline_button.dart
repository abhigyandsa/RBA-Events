import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final FaIcon icon;

  final String text;

  const MyOutlineButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 15),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
