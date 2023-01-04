import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ChatScreenSearchBar extends StatelessWidget {
  final Function(String) onSearchChanged;

  const ChatScreenSearchBar({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearchChanged,
      decoration: const InputDecoration(
        hintText: 'Search Here....',
        prefixIcon: Icon(Icons.search),
        hintStyle: TextStyle(fontSize: 12, color: AppTheme.greyDark),
      ),
    );
  }
}
