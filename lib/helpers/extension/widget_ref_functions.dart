import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/login_form_provider.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/core/providers/timesheet_providers.dart';
import 'package:manawanui/screens/mobile/dashboard/dashboard_screen.dart';

extension WidgetRefX on WidgetRef {
  void invalidatePayeesScreenProvider() {
    invalidate(currentIndexProvider);
    invalidate(selectedPayeeProvider);
    invalidate(isPayeeEditingProvider);
    invalidate(selectedPayeeTitleProvider);
    invalidate(selectedPayeeDateOfBirthProvider);
    invalidate(selectedPayeeGenderProvider);
    invalidate(selectedPayeeStatusProvider);
    invalidate(selectedPayeeStartDateProvider);
    invalidate(selectedPayeeTaxCodeProvider);
    invalidate(selectedPayeeKiwisaverOptionProvider);
    invalidate(selectedPayeeLeaveEntitlementProvider);
    invalidate(selectedPayeePaySlipProvider);
    invalidate(selectedPayeeRegionProvider);
    invalidate(manuallyAddressPayeeProvider);
    invalidate(selectedAddressPayeeProvider);
    invalidate(selectedDocumentsProvider);
    invalidate(selectedThirdPartyProviderNameProvider);
    // invalidate(selectedPayeeDocumentProvider);
  }

  void invalidateSelectedPayeesFieldsProvider() {
    invalidate(selectedPayeeTitleProvider);
    invalidate(selectedThirdPartyProviderNameProvider);
    invalidate(selectedPayeeDateOfBirthProvider);
    invalidate(selectedPayeeGenderProvider);
    invalidate(selectedPayeeStatusProvider);
    invalidate(selectedPayeeStartDateProvider);
    invalidate(selectedPayeeTaxCodeProvider);
    invalidate(selectedPayeeKiwisaverOptionProvider);
    invalidate(selectedPayeeLeaveEntitlementProvider);
    invalidate(selectedPayeePaySlipProvider);
    invalidate(selectedPayeeRegionProvider);
    invalidate(manuallyAddressPayeeProvider);
    invalidate(selectedAddressPayeeProvider);
    invalidate(selectedDocumentsProvider);
    // invalidate(selectedPayeeDocumentProvider);
  }

  void invalidateTimeSheetProviders() {
    invalidate(timeSheetDataListProvider);
    invalidate(expenseSheetDataListProvider);
    invalidate(paymentsSheetDataListProvider);
    invalidate(selectedTimesheetPayeeProvider);
    invalidate(selectedTimesheetFortnightProvider);
  }

  void invalidateEverything() {
    invalidatePayeesScreenProvider();
    invalidateSelectedPayeesFieldsProvider();
    invalidate(selectedIndexProvider);
    invalidate(userDetailsProvider);
    invalidate(loginFormProviderNotifier);
    invalidate(loginViewModelProvider);
    invalidate(loginViewModelProvider);
    invalidate(selectedPayeeProvider);
    invalidate(currentIndexProvider);
    invalidate(timeSheetDataListProvider);
    invalidate(expenseSheetDataListProvider);
    invalidate(paymentsSheetDataListProvider);
    invalidate(selectedMailIndexProvider);
  }
}
