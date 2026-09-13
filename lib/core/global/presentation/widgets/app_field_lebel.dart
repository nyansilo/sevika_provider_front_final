import 'package:flutter/material.dart';

import '../../../extensions/build_context_extensions.dart';

class AppFieldLabel extends StatelessWidget {
  final String text;

  const AppFieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onSurface,
      ),
    );
  }
}
