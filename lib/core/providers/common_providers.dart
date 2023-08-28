import 'package:app_name/core/network/api_client.dart';
import 'package:app_name/core/network/network_operations.dart';
import 'package:app_name/data/repository/repository.dart';
import 'package:app_name/data/repository/repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<NetworkOperations>(
  (ref) => ApiClient("BASE_URL"),
);

final repositoryProvider = Provider<Repository>(
  (ref) {
    final apiClient = ref.watch(apiClientProvider);
    return RepositoryImpl(apiClient);
  },
);
