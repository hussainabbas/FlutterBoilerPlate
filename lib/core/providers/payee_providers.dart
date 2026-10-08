import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/data/models/get_employee_documents_response.dart';
import 'package:manawanui/data/models/get_employee_payee_initials_response.dart';
import 'package:manawanui/screens/mobile/dashboard/payees/nz_post_view_model.dart';
import 'package:manawanui/screens/mobile/dashboard/payees/nz_search_view_model.dart';
import 'package:manawanui/screens/mobile/dashboard/payees/payees_view_model.dart';
import 'package:manawanui/widgets/payee_type_widget.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

final isPayeeEditingProvider = StateProvider<bool>((ref) => false);

final selectedPayeeProvider = StateProvider<PayeeTypeWidget?>((ref) => null);

final selectedPayeeDateOfBirthProvider =
    StateProvider<DateTime?>((ref) => null);

final selectedPayeeStartDateProvider = StateProvider<DateTime?>((ref) => null);

final selectedPayeeTitleProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final selectedPayeeGenderProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final selectedPayeeStatusProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final selectedPayeeTaxCodeProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final selectedPayeeKiwisaverOptionProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final selectedPayeeLeaveEntitlementProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);
final selectedPayeeRegionProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final selectedThirdPartyProviderNameProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final selectedPayeePayslipEmailsProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final selectedPayeePaySlipProvider =
    StateProvider<GenericIdValueModel?>((ref) => null);

final manuallyAddressPayeeProvider = StateProvider<bool>((ref) => false);
final selectedAddressPayeeProvider = StateProvider<String?>((ref) => null);

final selectedMailIndexProvider = StateProvider<int>((ref) => 1);

final selectedDocumentsProvider =
    StateProvider<List<EmployeeDocumentsItem?>>((ref) => []);

final payeesViewModelProvider = Provider<PayeesViewModel>(
  (ref) {
    final repository = ref.read(repositoryProvider);
    return PayeesViewModel(repository: repository);
  },
);

final nzPostViewModelProvider = Provider<NZPostViewModel>(
  (ref) {
    final repository = ref.read(repositoryProviderNZPost);
    return NZPostViewModel(repository: repository);
  },
);

final nzSearchViewModelProvider = Provider<NZSearchViewModel>(
  (ref) {
    final repository = ref.read(repositoryProviderNZSearch);
    return NZSearchViewModel(repository: repository);
  },
);
