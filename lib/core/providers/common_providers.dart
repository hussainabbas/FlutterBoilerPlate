import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/network/api_client.dart';
import 'package:manawanui/core/network/api_client_nz_post.dart';
import 'package:manawanui/core/network/api_client_nz_search.dart';
import 'package:manawanui/core/network/network_operations.dart';
import 'package:manawanui/core/network/network_operations_headers.dart';
import 'package:manawanui/core/providers/flavor_providers.dart';
import 'package:manawanui/data/repository/repository.dart';
import 'package:manawanui/data/repository/repository_impl.dart';
import 'package:manawanui/data/repository/repository_nz.dart';
import 'package:manawanui/data/repository/repository_nz_impl.dart';
import 'package:manawanui/data/repository/repository_nz_search.dart';

import '../../data/repository/repository_nz_search_impl.dart';

final repositoryProvider = Provider<Repository>(
  (ref) {
    final baseUrl = ref.watch(flavorBaseUrlProvider).value ?? "";
    final apiClient = ref.watch(apiClientProvider).value;
    return RepositoryImpl(apiClient ?? ApiClient(baseUrl));
  },
);

final apiClientProvider = FutureProvider<NetworkOperations>((ref) async {
  final baseURl = ref.watch(flavorBaseUrlProvider).value ?? "base-url";
  return ApiClient(baseURl);
});

final repositoryProviderNZPost = Provider<RepositoryNZPost>(
  (ref) {
    final apiClient = ref.watch(apiClientNZProvider).value;
    return RepositoryNZPostImpl(apiClient ?? ApiClientNZPost());
  },
);

final apiClientNZProvider = FutureProvider<NetworkOperations>((ref) async {
  return ApiClientNZPost();
});

final repositoryProviderNZSearch = Provider<RepositoryNZSearch>(
  (ref) {
    final apiClient = ref.watch(apiClientNZSearchProvider).value;
    return RepositoryNZSearchImpl(apiClient ?? ApiClientNZSearch());
  },
);

final apiClientNZSearchProvider =
    FutureProvider<NetworkOperationsWithHeaders>((ref) async {
  return ApiClientNZSearch();
});

final currencySymbolProvider = StateProvider<String>((ref) => "\$");
