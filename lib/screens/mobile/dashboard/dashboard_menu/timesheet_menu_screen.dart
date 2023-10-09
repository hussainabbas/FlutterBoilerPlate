import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/data/models/timesheet_response.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/widgets/fixed_width_column.dart';

class TimesheetMenuScreen extends HookConsumerWidget {
  const TimesheetMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = useState<List<TimesheetResponse>>([
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John Ahan',
          hrs: 8,
          cost: "\$23500.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed'),
      TimesheetResponse(
          date: '2023-09-01',
          name: 'John sadasdasdsad',
          hrs: 8,
          cost: "\$50.00",
          status: 'Completed')
      // Add more data items here
    ]);

    final filteredData = useState<List<TimesheetResponse>>(data.value);

    final searchController = useTextEditingController();

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
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
            child: ListView.builder(
              itemCount: filteredData.value.length,
              itemBuilder: (context, index) {
                final item = filteredData.value[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.ADD_EDIT_TIMESHEET,
                        arguments: index);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FixedWidthColumn(
                          text: item.date,
                          multiplier: 0.15,
                        ),
                        FixedWidthColumn(
                          text: item.name,
                          multiplier: 0.2,
                        ),
                        FixedWidthColumn(
                          text: item.hrs.toString(),
                          multiplier: 0.15,
                        ),
                        FixedWidthColumn(
                          text: item.cost.toString(),
                          multiplier: 0.18,
                        ),
                        FixedWidthColumn(
                          text: item.status,
                          multiplier: 0.2,
                          isStatus: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.ADD_EDIT_TIMESHEET,
              arguments: -1);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
