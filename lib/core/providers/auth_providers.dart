import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/data/models/user_details_response.dart';
import 'package:manawanui/main_view_model.dart';
import 'package:manawanui/screens/mobile/auth/login/login_view_model.dart';

final mainViewModelProvider = Provider<MainViewModel>(
  (ref) {
    final apiClient = ref.read(apiClientProvider);
    final repository = ref.read(repositoryProvider);
    return MainViewModel(repository: repository);
  },
);
//Login View Model Provider
final loginViewModelProvider = Provider<LoginViewModel>(
  (ref) {
    final repository = ref.read(repositoryProvider);
    return LoginViewModel(repository: repository);
  },
);

final userDetailsProvider = StateProvider<UserDetailsResponse?>((ref) => null);
