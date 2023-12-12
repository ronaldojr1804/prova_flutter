// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserCardStore on UserCardStoreData, Store {
  late final _$userCardsAtom =
      Atom(name: 'UserCardStoreData.userCards', context: context);

  @override
  ObservableList<UserCard> get userCards {
    _$userCardsAtom.reportRead();
    return super.userCards;
  }

  @override
  set userCards(ObservableList<UserCard> value) {
    _$userCardsAtom.reportWrite(value, super.userCards, () {
      super.userCards = value;
    });
  }

  late final _$loadUserCardsAsyncAction =
      AsyncAction('UserCardStoreData.loadUserCards', context: context);

  @override
  Future<void> loadUserCards() {
    return _$loadUserCardsAsyncAction.run(() => super.loadUserCards());
  }

  late final _$addUserCardAsyncAction =
      AsyncAction('UserCardStoreData.addUserCard', context: context);

  @override
  Future<void> addUserCard(UserCard userCard) {
    return _$addUserCardAsyncAction.run(() => super.addUserCard(userCard));
  }

  late final _$updateUserCardAsyncAction =
      AsyncAction('UserCardStoreData.updateUserCard', context: context);

  @override
  Future<void> updateUserCard(UserCard updatedUserCard) {
    return _$updateUserCardAsyncAction
        .run(() => super.updateUserCard(updatedUserCard));
  }

  late final _$removeUserCardAsyncAction =
      AsyncAction('UserCardStoreData.removeUserCard', context: context);

  @override
  Future<void> removeUserCard(UserCard userCard) {
    return _$removeUserCardAsyncAction
        .run(() => super.removeUserCard(userCard));
  }

  @override
  String toString() {
    return '''
userCards: ${userCards}
    ''';
  }
}
