import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prova_flutter/model/user_card_model.dart';
import 'package:prova_flutter/stores/user_card_store.dart';
import 'package:prova_flutter/views/cards/edit_dialog.dart';
import 'package:prova_flutter/views/widgets/confirmation_dialog.dart';
import 'package:prova_flutter/views/widgets/input_add_user_card.dart';
import 'package:prova_flutter/views/widgets/politica_widget.dart';

class CardViewPage extends StatefulWidget {
  const CardViewPage({super.key});

  @override
  State<CardViewPage> createState() => _CardViewPageState();
}

class _CardViewPageState extends State<CardViewPage> {
  final userCardStore = UserCardStore();

  TextEditingController controllerAddInput = TextEditingController();
  FocusNode focusNodeAddInput = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF004D40),
              Color(0xFF00796B),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Observer(
                  builder: (context) {
                    return ListView.builder(
                      itemCount: userCardStore.userCards.length,
                      itemBuilder: (context, index) {
                        var userCard = userCardStore.userCards[index];
                        return Card(
                          key: Key(userCard.toString()),
                          elevation: 5,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  // height: 30,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child:
                                            Center(child: Text(userCard.title)),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showEditDialog(
                                            context: context,
                                            userCard: userCard,
                                          ).then((value) {
                                            if (value != null) {
                                              userCardStore.updateUserCard(
                                                value,
                                              );
                                            }
                                          });
                                        },
                                        splashRadius: 20,
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showConfirmationDialog(
                                            context: context,
                                            title: 'Atenção!',
                                            content:
                                                'Deseja realmente excluir o item "${userCard.title}"?',
                                          ).then((value) {
                                            if (value) {
                                              userCardStore
                                                  .removeUserCard(userCard);
                                            }
                                          });
                                        },
                                        splashRadius: 20,
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SelectableText(userCard.content),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: double.infinity,
                  child: InputAddUserCard(
                    controller: controllerAddInput,
                    onSave: (text) => addItem(text),
                  ),
                ),
              ),
              const WdPoliticaPrivacidadeButton(),
            ],
          ),
        ),
      ),
    );
  }

  void addItem(String item) {
    userCardStore
        .addUserCard(UserCard(
            title: 'Texto Digitado ${userCardStore.userCards.length + 1}',
            content: item))
        .then((value) {
      controllerAddInput.clear();
      focusNodeAddInput.requestFocus();
    });
  }
}
