import 'package:async_value/models/item.dart';
import 'package:async_value/providers.dart';
import 'package:async_value/screens/fake_items_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemState extends StateNotifier<AsyncValue<List<Item>>> {
  ItemState(this.repo) : super(const AsyncValue.loading()) {
    getItems();
  }

  Future<void> getItems() async {
    try {
      final items = await repo.fetchItems();
      state = AsyncValue.data(items);
    } on ItemException catch (message, st) {
      state = AsyncValue.error(message, stackTrace: st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final items = await repo.fetchItems();
      state = AsyncValue.data(items);
    } on ItemException catch (message, st) {
      state = AsyncValue.error(message, stackTrace: st);
    }
  }

  Future<void> removeItem(int id) async {
    state = state.whenData((value) {
      return value.where((element) {
        print('${element.id} and $id');
        return element.id != id;
      }).toList();
    });

    state.whenData((value) => value.forEach((element) {
          print(element.toJson());
        }));
    try {
      await repo.removeItem(id);
    } on ItemException catch (message, st) {
      state = AsyncValue.error(message, stackTrace: st);
    }
  }

  final ItemRepository repo;
}
