import 'package:math_mate/common/utils/extensions.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Empty', style: context.textTheme.bodyLarge),
    );
  }
}
