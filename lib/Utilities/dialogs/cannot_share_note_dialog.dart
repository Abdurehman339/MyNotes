import 'package:flutter/material.dart';
import 'package:my_notes/Utilities/dialogs/generic_dialog.dart';

Future<void> showCanNotShareEmptyNote(BuildContext context) async {
  return showGenericDialog<void>(
    context: context,
    title: 'Cannot Share',
    content: 'You cannot share an empty note',
    optionsBuilder: () => {
      'ok': 'null',
    },
  );
}
