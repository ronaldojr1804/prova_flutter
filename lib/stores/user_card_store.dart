import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:prova_flutter/model/user_card_model.dart';
import 'package:prova_flutter/services/card_storage_service.dart';

part 'user_card_store.g.dart';

class UserCardStore = UserCardStoreData with _$UserCardStore;
// flutter pub run build_runner build --delete-conflicting-outputs

abstract class UserCardStoreData with Store {
  UserCardStoreData() {
    loadUserCards();
  }

  @observable
  ObservableList<UserCard> userCards = ObservableList<UserCard>();

  @action
  Future<void> loadUserCards() async {
    userCards = ObservableList.of([]);
    if (kDebugMode) {
      print('loadUserCards');
    }
    final cards = await CardStorageHelper.getUserCards();
    userCards = ObservableList.of(cards);
  }

  @action
  Future<void> addUserCard(UserCard userCard) async {
    if (kDebugMode) {
      print('addUserCard');
    }
    await CardStorageHelper.saveUserCard(userCard);
    await loadUserCards();
  }

  @action
  Future<void> updateUserCard(UserCard updatedUserCard) async {
    if (kDebugMode) {
      print('updateUserCard');
    }
    await CardStorageHelper.updateUserCard(updatedUserCard);
    await loadUserCards();
  }

  @action
  Future<void> removeUserCard(UserCard userCard) async {
    if (kDebugMode) {
      print('removeUserCard');
    }
    await CardStorageHelper.deleteUserCard(userCard);
    await loadUserCards();
  }
}
