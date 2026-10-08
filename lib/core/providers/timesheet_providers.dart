import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/data/models/get_timesheet_initials_er_response.dart';
import 'package:manawanui/data/models/get_timesheet_transaction_periods_response.dart';
import 'package:manawanui/data/models/timesheet_employee_dropdown_response.dart';
import 'package:manawanui/data/models/timesheet_hours_model.dart';
import 'package:manawanui/screens/mobile/dashboard/timesheet/timesheet_view_model.dart';

final timesheetViewModelProvider = Provider<TimesheetViewModel>(
  (ref) {
    final repository = ref.read(repositoryProvider);
    return TimesheetViewModel(repository: repository);
  },
);

final currentPageProviders = <StateProvider<int>>[];

final timeSheetDataListProvider =
    StateNotifierProvider((ref) => TimeSheetDataListNotifier());

final expenseSheetDataListProvider =
    StateNotifierProvider((ref) => ExpenseSheetDataListNotifier());

final paymentsSheetDataListProvider =
    StateNotifierProvider((ref) => PaymentsDataListNotifier());

final selectedTimesheetPayeeProvider =
    StateProvider<EligibalEmployeesModal?>((ref) => null);

final selectedTimesheetFortnightProvider =
    StateProvider<TransPeriodModal?>((ref) => null);

///TIMESHEET BLOCK PROVIDERS
final selectedTimesheetPersonSupportedProvider =
    <StateProvider<EmployeeModel?>>[];

final selectedTimesheetPayComponentProvider =
    <StateProvider<PayComponentsModel?>>[];

///EXPENSE BLOCK PROVIDERS
final selectedTimesheetExpensePersonSupportedProvider =
    <StateProvider<EmployeeModel?>>[];

final selectedTimesheetExpenseExpensePayeeProvider =
    <StateProvider<ExpensePayeeListModel?>>[];

final selectedTimesheetExpenseTypeProvider =
    <StateProvider<ExpenseTypeModel?>>[];

final selectedTimesheetExpenseDateProvider = <StateProvider<DateTime?>>[];

///PAYMENTS BLOCK PROVIDERS
final selectedTimesheetPaymentPersonSupportedProvider =
    <StateProvider<EmployeeModel?>>[];

final selectedTimesheetPaymentsDateProvider = <StateProvider<DateTime?>>[];
final selectedTimesheetPaymentsProviderNameProvider =
    <StateProvider<ExpensePayeeListModel?>>[];

// final selectedTimesheetSelectedHoursProvider =
// <StateProvider<double?>>[];

// final List<StateProvider<double?>> selectedTimesheetSelectedHoursProviders = List.generate(
//   timesheetTimeModel?.timesheetHoursModel?.length ?? 0,
//       (index) => StateProvider<double?>((ref) => null),
// );

class TimesheetHoursController {
  final List<StateProvider<double?>> selectedTimesheetSelectedHoursProviders;

  TimesheetHoursController(int numTimeBlocks)
      : selectedTimesheetSelectedHoursProviders = List.generate(
          numTimeBlocks,
          (index) => StateProvider<double?>((ref) => null),
        );
}

class TimeSheetDataListNotifier
    extends StateNotifier<List<TimesheetTimeModel>> {
  TimeSheetDataListNotifier() : super([]);

  void addItem(TimesheetTimeModel item) {
    state.add(item);
    state = [...state];
  }

  void removeItem(TimesheetTimeModel item) {
    state.remove(item);
    state = [...state];
  }

  void clearItems() {
    state.clear();
  }
}

class ExpenseSheetDataListNotifier
    extends StateNotifier<List<ExpenseItemModel>> {
  ExpenseSheetDataListNotifier() : super([]);

  void addItem(ExpenseItemModel item) {
    state.add(item);
    state = [...state];
  }

  void removeItem(ExpenseItemModel item) {
    state.remove(item);
    state = [...state];
  }

  void clearItems() {
    state.clear();
  }
}

class PaymentsDataListNotifier extends StateNotifier<List<PaymentsItemModel>> {
  PaymentsDataListNotifier() : super([]);

  void addItem(PaymentsItemModel item) {
    state.add(item);
    state = [...state];
  }

  void removeItem(PaymentsItemModel item) {
    state.remove(item);
    state = [...state];
  }

  void clearItems() {
    state.clear();
  }
}
