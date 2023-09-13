import 'package:flutter/material.dart';

class AddTaskFlatButton extends StatelessWidget {

  final VoidCallback onpress;
  const AddTaskFlatButton({required this.onpress,super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: null,
        onPressed: onpress,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          weight: 300,
        ),
      );
  }
}
