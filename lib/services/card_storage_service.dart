import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:prova_flutter/model/user_card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardStorageHelper {
  static const String _key = 'userCards';

  static Future<void> saveUserCard(UserCard userCard) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<UserCard> userCards = await getUserCards();
    userCards.add(userCard);

    final encodedUserCards =
        userCards.map((e) => json.encode(e.toJson())).toList();
    prefs.setStringList(_key, encodedUserCards);
  }

  static Future<List<UserCard>> getUserCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? encodedUserCards = prefs.getStringList(_key);

    if (encodedUserCards == null) {
      return [];
    }

    return encodedUserCards
        .map((e) => UserCard.fromJson(json.decode(e)))
        .toList();
  }

  static Future<void> updateUserCard(UserCard updatedUserCard) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<UserCard> userCards = await getUserCards();

    final index = userCards
        .indexWhere((userCard) => userCard.title == updatedUserCard.title);

    if (index != -1) {
      userCards[index] = updatedUserCard;
      final encodedUserCards =
          userCards.map((e) => json.encode(e.toJson())).toList();
      prefs.setStringList(_key, encodedUserCards);
    } else {
      if (kDebugMode) {
        print('userCard-notfound');
      }
    }
  }

  static Future<void> deleteUserCard(UserCard userCard) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<UserCard> userCards = await getUserCards();

    userCards.removeWhere((element) => userCard.title == element.title);

    final encodedUserCards =
        userCards.map((e) => json.encode(e.toJson())).toList();
    prefs.setStringList(_key, encodedUserCards);
  }
}
