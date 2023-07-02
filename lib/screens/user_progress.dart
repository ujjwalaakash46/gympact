import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProgress extends ConsumerStatefulWidget {
  const UserProgress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProgressState();
}

class _UserProgressState extends ConsumerState<UserProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("progress"),
      ),
    );
  }
}
