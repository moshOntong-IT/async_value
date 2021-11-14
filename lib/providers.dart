import 'package:async_value/Controllers/item_state.dart';
import 'package:async_value/models/item.dart';
import 'package:async_value/screens/fake_items_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repoProvider = Provider<ItemRepository>((ref) => FakeItemRepository());

//TODO try daw e dli e pass ang parameter sa read
final itemStateProvider =
    StateNotifierProvider<ItemState, AsyncValue<List<Item>>>((ref) {
  final repo = ref.watch(repoProvider);
  return ItemState(repo);
});
