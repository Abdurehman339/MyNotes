import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(136, 171, 142, 100.0)),
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                optionTitle,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
      );
    },
  );
}
