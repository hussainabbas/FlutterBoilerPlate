import 'package:app_name/core/providers/common_providers.dart';
import 'package:app_name/screens/mobile/auth/login/login_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Login View Model Provider
final loginViewModelProvider = Provider<LoginViewModel>(
  (ref) {
    final repository = ref.read(repositoryProvider);
    return LoginViewModel(repository: repository);
  },
);
