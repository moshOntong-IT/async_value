import 'package:async_value/models/item.dart';
import 'package:async_value/providers.dart';
import 'package:async_value/screens/fake_items_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemState extends StateNotifier<AsyncValue<List<Item>>> {
  ItemState(this.read) : super(const AsyncValue.loading()) {
    getItems();
  }

  Future<void> getItems() async {
    state = const AsyncValue.loading();
    try {
      final items = await read(repoProvider).fetchItems();
      state = AsyncValue.data(items);
    } on ItemException catch (message, st) {
      state = AsyncValue.error(message, stackTrace: st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final items = await read(repoProvider).fetchItems();
      state = AsyncValue.data(items);
    } on ItemException catch (message, st) {
      state = AsyncValue.error(message, stackTrace: st);
    }
  }

  final Reader read;
}
