import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/screens/mobile/dashboard/payees/payees_view_model.dart';
import 'package:manawanui/widgets/payee_type_widget.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);
final isPayeeEditingProvider = StateProvider<bool>((ref) => false);

final selectedPayeeProvider = StateProvider<PayeeTypeWidget?>((ref) => null);

final selectedMailIndexProvider = StateProvider<int>((ref) => 1);

final payeesViewModelProvider = Provider<PayeesViewModel>(
  (ref) {
    final repository = ref.read(repositoryProvider);
    return PayeesViewModel(repository: repository);
  },
);
