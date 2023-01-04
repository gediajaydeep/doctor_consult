import 'package:flutter/material.dart';

import '../../../../domain/user/entities/user.dart';

class HomeUserGreetingView extends StatelessWidget {
  final User user;

  const HomeUserGreetingView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ${user.name},',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text('How are you doing today?',
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          SizedBox(
            height: 48,
            width: 48,
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.5),
              child: ClipOval(
                child: Image.network(
                  user.image ?? '',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
