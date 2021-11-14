import 'dart:convert';
import 'dart:math';

import 'package:async_value/models/item.dart';

final _sampleJsonItem = [
  '''{ "id":123,"name":"Sugar"}''',
  '''{ "id":122,"name":"Rice"} ''',
  '''{ "id":152,"name":"Salt"} '''
];

abstract class ItemRepository {
  Future<List<Item>> fetchItems();
  Future<void> removeItem(int id);
}

class FakeItemRepository implements ItemRepository {
  FakeItemRepository() : random = Random() {
    itemLists = [
      ..._sampleJsonItem.map((e) {
        return Item.fromJson(jsonDecode(e) as Map<String, dynamic>);
      })
    ];
  }
  late List<Item> itemLists;
  late final Random random;
  @override
  Future<List<Item>> fetchItems() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    // print('test');
    double result = random.nextDouble();

    if (result < 0.3) {
      // print(result);
      throw ItemException('Cannot retrieve datas');
    } else {
      // print('wala');
      return itemLists;
    }
  }

  @override
  Future<void> removeItem(int id) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (random.nextDouble() < 0.3) {
      // print(result);
      throw ItemException('Cannot retrieve datas');
    } else {
      // print('wala');
      itemLists = itemLists.where((element) => element.id != id).toList();
    }
  }
}

class ItemException implements Exception {
  final String message;

  ItemException(this.message);

  @override
  String toString() {
    return message;
  }
}
