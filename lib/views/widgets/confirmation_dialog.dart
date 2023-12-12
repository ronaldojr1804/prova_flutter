import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  String title = 'Atenção!',
  String content = 'Confirmar ?',
  String okTextButton = 'Ok',
}) async {
  bool isConfirmed = false;
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        child: const Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: Text(okTextButton),
        onPressed: () {
          isConfirmed = true;
          Navigator.of(context).pop();
        },
      ),
    ],
  );

  // exibe o dialog
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  return isConfirmed;
}
