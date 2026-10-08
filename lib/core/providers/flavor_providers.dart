import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final environmentProvider = Provider<String>((ref) {
  const environment = String.fromEnvironment('FLAVOR', defaultValue: 'staging');
  return environment;
});

final flavorProvider = FutureProvider<String>((ref) async {
  final environment = ref.watch(environmentProvider);
  await dotenv.load(fileName: 'lib/.env.$environment');
  final flavor = dotenv.env['FLAVOR_NAME'] ?? 'uat';
  return flavor.toLowerCase(); // Ensure consistency by converting to lowercase
});

final flavorBaseUrlProvider = FutureProvider<String>((ref) async {
  final environment = ref.watch(environmentProvider);
  await dotenv.load(fileName: 'lib/.env.$environment');
  final baseUrl = dotenv.env['BASE_URL'] ?? 'base-url';
  return baseUrl.toLowerCase(); // Ensure consistency by converting to lowercase
});
