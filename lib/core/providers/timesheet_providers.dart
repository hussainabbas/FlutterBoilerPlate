import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProviders = <StateProvider<int>>[];

final timeSheetDataListProvider =
    StateNotifierProvider((ref) => TimeSheetDataListNotifier());

final expenseSheetDataListProvider =
    StateNotifierProvider((ref) => ExpenseSheetDataListNotifier());

final paymentsSheetDataListProvider =
    StateNotifierProvider((ref) => PaymentsDataListNotifier());

class TimeSheetDataListNotifier extends StateNotifier<List<String>> {
  TimeSheetDataListNotifier() : super([]);

  void addItem(String item) {
    state.add(item);
    state = [...state];
  }

  void removeItem(String item) {
    state.remove(item);
    state = [...state];
  }

  void clearItems() {
    state.clear();
  }
}

class ExpenseSheetDataListNotifier extends StateNotifier<List<String>> {
  ExpenseSheetDataListNotifier() : super([]);

  void addItem(String item) {
    state.add(item);
    state = [...state];
  }

  void removeItem(String item) {
    state.remove(item);
    state = [...state];
  }

  void clearItems() {
    state.clear();
  }
}

class PaymentsDataListNotifier extends StateNotifier<List<String>> {
  PaymentsDataListNotifier() : super([]);

  void addItem(String item) {
    state.add(item);
    state = [...state];
  }

  void removeItem(String item) {
    state.remove(item);
    state = [...state];
  }

  void clearItems() {
    state.clear();
  }
}
