import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_employ_by_response.dart';
import 'package:manawanui/data/models/get_employee_documents_response.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/api_error_widget.dart';
import 'package:manawanui/widgets/fixed_width_column.dart';
import 'package:manawanui/widgets/payee_type_widget.dart';
class PayeesMenuScreen extends HookConsumerWidget {
  const PayeesMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final viewModel = ref.watch(payeesViewModelProvider);
    final userDetails = ref.watch(userDetailsProvider);
    final scrollController = useScrollController();
    var pageNo = 1;
    var totalPages = 0;
    List<EmployByModel> list = [];
    List<EmployByModel> filteredList = [];

    void getEmployBy(int page) {
      viewModel.getEmployBy({
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_IS_SELF_MANAGED: userDetails?.isSelfManaged ?? "",
        ApiParamKeys.KEY_PAGE_NO: page,
      });
    }

    useEffect(() {
      getEmployBy(pageNo);
      return null;
    }, []);

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (pageNo < totalPages) {
            pageNo++;
            getEmployBy(pageNo);
          }
        }
      }

      scrollController.addListener(onScroll);

      return () {
        scrollController.removeListener(onScroll);
      };
    }, [pageNo]);

    useEffect(() {
      final subscription =
          viewModel.responseGetEmployByStream.listen((response) async {
        if (response.error != null) {
          if (response.error?.contains("401") == true) {
            logout(ref, context);

            return;
          }
        }
        if (response.data?.status == true) {
          final data = response.data;
          totalPages = data?.totalPage ?? 0;
          if (pageNo == 1) {
            // filteredList.clear();
            list = data!.response!;
          } else {
            list.addAll(data!.response!);
          }
          filteredList = list;
        }
      });

      return subscription.cancel;
    }, [viewModel.responseGetEmployByStream]);

    void filterData(String query) {
      // filteredList.clear();
      // if (query.isEmpty) {
      //   filteredList.addAll(list);
      // } else {
      //   filteredList
      //       .addAll(list.where((item) => item.fullName!.contains(query)));
      //   console("filteredList -> ${filteredList.length}");
      // }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context, Routes.ADD_EDIT_PAYEE);
          ref.watch(isPayeeEditingProvider.notifier).state = true;
          context.go("${Routes.HOME_ROUTE}/${Routes.ADD_EDIT_PAYEE}");
          //context.push(Routes.ADD_EDIT_PAYEE);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<ApiResult<GetEmployByResponse>>(
        stream: viewModel.responseGetEmployByStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: ApiErrorWidget(message: snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            final response = snapshot.data;
            final data = response?.data;
            totalPages = data?.totalPage ?? 0;

            if (response?.error != null) {
              if (response?.error?.contains("401") == true) {
                logout(ref, context);
              }
              return Center(
                  child: ApiErrorWidget(
                      message: response?.data?.message.toString() ?? ""));
            }

            if (response?.data?.status == true) {
              // list = [...list, ...?data?.response];
              //filteredList.addAll(data!.response!);
              //filteredList.sort((a, b) => a.fullName!.compareTo(b.fullName ?? ""));
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FixedWidthColumn(
                          text: 'Name',
                          multiplier: 0.2,
                          isShowing: true,
                        ),
                        FixedWidthColumn(
                          text: 'Type',
                          multiplier: 0.2,
                        ),
                        FixedWidthColumn(
                          text: 'Supported',
                          multiplier: 0.3,
                        ),
                        FixedWidthColumn(
                          text: 'Status',
                          multiplier: 0.2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 0, 16, 8),
                    child: TextField(
                      controller: searchController,
                      onChanged: (query) {
                        //ref.read(filteredData).value.clear();
                        filterData(query);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search by Name',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await viewModel.getEmployBy({
                          ApiParamKeys.KEY_USER_ID_SMALL:
                              userDetails?.userId ?? "",
                          ApiParamKeys.KEY_EMPLOYER_ID:
                              userDetails?.employerId ?? "",
                          ApiParamKeys.KEY_IS_SELF_MANAGED:
                              userDetails?.isSelfManaged ?? "",
                          ApiParamKeys.KEY_PAGE_NO: 1,
                        });
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: (filteredList.length) +
                            (pageNo < totalPages ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < filteredList.length) {
                            final item = filteredList[index];
                            return PayeeItem(item: item);
                          } else if (pageNo < totalPages) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
                child: ApiErrorWidget(
                    message: response?.data?.message.toString() ?? ""));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PayeeItem extends ConsumerWidget {
  final EmployByModel? item;

  const PayeeItem({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        console("message -> ${item?.employeeTypeDisplay ?? ""}");
        ref.watch(selectedPayeeProvider.notifier).state = PayeeTypeWidget(
          title: item?.employeeTypeDisplay ?? "",
          isEditable: false,
        );
        final List<EmployeeDocumentsItem> list = [];
        item?.documents?.forEach((document) {
          var mEmployeeDocument = EmployeeDocumentsItem(
            employeeDocumentTypeId: document.employeeDocumentId,
            employeeName: document.documentTitle,
            employeeTypeCode: "",
            urlLink: null,
            employeeDocumentId: document.employeeDocumentId,
            documentName: document.documentName,
            documentType: document.documentType,
            documentTitle: document.documentTitle,
            documentData: document.documentData,
            employeeDocumentTypeName: document.employeeDocumentTypeName,
            isPicked: true,
          );

          list.add(mEmployeeDocument);
        });
        ref.watch(selectedDocumentsProvider.notifier).state = list;
        context.go("${Routes.HOME_ROUTE}/${Routes.ADD_EDIT_PAYEE}",
            extra: item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 4.0, // Set the width of the left border
              color: getPayeeStatusColor(item?.employeeStatusName ??
                  ""), // Set the color of the border
            ),
          ),
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FixedWidthColumn(
              text: item?.fullName ?? "",
              multiplier: 0.2,
            ),
            FixedWidthColumn(
              text: item?.isAgent ?? false
                  ? "Agent Profile"
                  : item?.employeeTypeDisplay ?? "",
              multiplier: 0.2,
            ),
            FixedWidthColumn(
              text: item?.supportingDisplay ?? "",
              multiplier: 0.24,
            ),
            FixedWidthColumn(
              text: item?.employeeStatusName ?? "",
              multiplier: 0.2,
              status: item?.employeeStatusName ?? "",
              isStatus: true,
            ),
          ],
        ),
      ),
    );
  }
}
