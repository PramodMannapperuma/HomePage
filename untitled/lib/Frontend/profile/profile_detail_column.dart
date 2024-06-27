import 'package:flutter/material.dart';


class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(value, style: Theme.of(context).textTheme.bodyMedium),

            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(thickness: 1.0),
            )
          ],
        ),
        const Icon(Icons.lock_outline, size: 10.0),
      ],
    );
  }
}