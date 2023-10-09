import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/network/api_client.dart';
import 'package:manawanui/core/network/network_operations.dart';
import 'package:manawanui/core/providers/flavor_providers.dart';
import 'package:manawanui/data/repository/repository.dart';
import 'package:manawanui/data/repository/repository_impl.dart';

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

final currencySymbolProvider = StateProvider<String>((ref) => "\$");
