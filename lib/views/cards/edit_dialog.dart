import 'package:flutter/material.dart';
import 'package:prova_flutter/model/user_card_model.dart';
import 'package:prova_flutter/views/widgets/input_add_user_card.dart';

Future<UserCard?> showEditDialog({
  required BuildContext context,
  required UserCard userCard,
}) async {
  UserCard tmpUserCard = userCard;
  UserCard? saveuserCard;

  AlertDialog alert = AlertDialog(
    title: Text(tmpUserCard.title),
    content: InputAddUserCard(
      controller: TextEditingController(text: tmpUserCard.content),
      showIcon: false,
      onChanged: (p0) {
        tmpUserCard.content = p0;
      },
    ),
    actions: [
      TextButton(
        child: const Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text('Salvar'),
        onPressed: () {
          saveuserCard = tmpUserCard;
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

  return saveuserCard;
}
