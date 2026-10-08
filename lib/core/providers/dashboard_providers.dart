import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_view_model.dart';

//Login View Model Provider
final dashboardViewModelProvider = Provider<DashboardViewModel>(
  (ref) {
    final repository = ref.read(repositoryProvider);
    return DashboardViewModel(repository: repository);
  },
);
