//Login View Model Provider
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/screens/mobile/dashboard/budgeting/budgeting_view_model.dart';

final budgetingViewModelProvider = Provider<BudgetingViewModel>(
  (ref) {
    final repository = ref.read(repositoryProvider);
    return BudgetingViewModel(repository: repository);
  },
);
