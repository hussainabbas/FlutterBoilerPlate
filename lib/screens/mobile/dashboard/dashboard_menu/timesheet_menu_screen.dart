import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/network/api_result.dart';
import 'package:manawanui/core/providers/auth_providers.dart';
import 'package:manawanui/core/providers/common_providers.dart';
import 'package:manawanui/core/providers/timesheet_providers.dart';
import 'package:manawanui/data/models/get_timesheet_response.dart';
import 'package:manawanui/helpers/extension/double_functions.dart';
import 'package:manawanui/helpers/extension/string_extensions.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';
import 'package:manawanui/widgets/api_error_widget.dart';
import 'package:manawanui/widgets/fixed_width_column.dart';

class TimesheetMenuScreen extends HookConsumerWidget {
  const TimesheetMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(timesheetViewModelProvider);
    final userDetails = ref.watch(userDetailsProvider);
    final scrollController = useScrollController();
    var pageNo = 1;
    var totalPages = 0;
    List<TimesheetItemModel> list = [];
    List<TimesheetItemModel> filteredList = [];

    final searchController = useTextEditingController();

    void getTimeSheets(int page) {
      viewModel.getTimeSheets({
        ApiParamKeys.KEY_USER_ID_SMALL: userDetails?.userId ?? "",
        ApiParamKeys.KEY_EMPLOYER_ID: userDetails?.employerId ?? "",
        ApiParamKeys.KEY_PAGE_NO: page,
      });
    }

    useEffect(() {
      getTimeSheets(pageNo);
      return null;
    }, []);

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (pageNo < totalPages) {
            pageNo++;
            getTimeSheets(pageNo);
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
          viewModel.responseGetTimesheetStream.listen((response) async {
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
    }, [viewModel.responseGetTimesheetStream]);

    // void filterData(String query) {
    //   filteredData.value.clear();
    //   if (query.isEmpty) {
    //     filteredData.value.addAll(data.value);
    //   } else {
    //     filteredData.value
    //         .addAll(data.value.where((item) => item.name.contains(query)));
    //   }
    // }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder<ApiResult<GetTimesheetResponse>>(
        stream: viewModel.responseGetTimesheetStream,
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
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FixedWidthColumn(
                          text: 'Date',
                          multiplier: 0.2,
                          isShowing: true,
                        ),
                        FixedWidthColumn(
                          text: 'Name',
                          multiplier: 0.2,
                        ),
                        FixedWidthColumn(
                          text: 'HRS',
                          multiplier: 0.18,
                        ),
                        FixedWidthColumn(
                          text: 'Cost',
                          multiplier: 0.2,
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
                        //filterData(query);
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
                        await viewModel.getTimeSheets({
                          ApiParamKeys.KEY_USER_ID_SMALL:
                              userDetails?.userId ?? "",
                          ApiParamKeys.KEY_EMPLOYER_ID:
                              userDetails?.employerId ?? "",
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
                            return TimesheetListItem(item: item);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go("${Routes.HOME_ROUTE}/${Routes.ADD_EDIT_TIMESHEET}");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TimesheetListItem extends ConsumerWidget {
  final TimesheetItemModel? item;

  const TimesheetListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencySymbol = ref.watch(currencySymbolProvider);
    return GestureDetector(
      onTap: () {
        context.go("${Routes.HOME_ROUTE}/${Routes.ADD_EDIT_TIMESHEET}",
            extra: item);
        // context.go(Routes.ADD_EDIT_TIMESHEET, extra: item);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 4.0, // Set the width of the left border
              color: getPayeeStatusColor(
                  item?.statusCodeDisplay ?? ""), // Set the color of the border
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FixedWidthColumn(
              text:
                  "${item?.transactionStartDate?.convertStringDateToMMM()}\n${item?.transactionStartDate?.convertStringDateToDD()}\n${item?.transactionStartDate?.convertStringDateToYYYY()}",
              multiplier: 0.15,
            ),
            FixedWidthColumn(
              text: item?.employeeName ?? "",
              multiplier: 0.2,
            ),
            FixedWidthColumn(
              text: "${item?.totalHours.toString()}",
              multiplier: 0.15,
            ),
            FixedWidthColumn(
              text: "$currencySymbol${item?.grossPay?.convertToAmount()}",
              multiplier: 0.18,
            ),
            FixedWidthColumn(
              text: item?.statusCodeDisplay ?? "",
              multiplier: 0.2,
              status: item?.statusCodeDisplay ?? "",
              isStatus: true,
            ),
          ],
        ),
      ),
    );
  }
}
