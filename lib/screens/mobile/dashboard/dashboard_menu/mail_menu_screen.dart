import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/payees_response.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/widgets/fixed_width_column.dart';
import 'package:manawanui/widgets/text_view.dart';

class MailMenuScreen extends HookConsumerWidget {
  const MailMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final selectedMailIndexState =
        ref.watch(selectedMailIndexProvider.notifier);
    final data = useState<List<PayeesResponse>>([
      PayeesResponse(
          name: 'John Doe',
          type: 'Third Party Provider',
          supported: "Maria Test",
          status: 'Active'),
      PayeesResponse(
          name: 'John Dane',
          type: 'Permanent Employee',
          supported: "Maria Test",
          status: 'Active'),
      PayeesResponse(
          name: 'Dale Kerrigane',
          type: 'Permanent Employee',
          supported: "Maria Test",
          status: 'Active'),
      // Add more data items here
    ]);
    final filteredData = useState<List<PayeesResponse>>(data.value);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
            decoration: const BoxDecoration(color: Colors.white),
            child: StreamBuilder<int>(
                stream: selectedMailIndexState.stream,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedMailIndexState.state = 1;
                        },
                        child: Container(
                          color: Colors.white,
                          child: FixedWidthColumn(
                            text: 'Received',
                            multiplier: 0.4,
                            isShowing: selectedMailIndexState.state == 1
                                ? true
                                : false,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedMailIndexState.state = 2;
                        },
                        child: Container(
                          color: Colors.white,
                          child: FixedWidthColumn(
                            text: 'Sent',
                            multiplier: 0.4,
                            isShowing: selectedMailIndexState.state == 2
                                ? true
                                : false,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.6,
            height: 1,
          ),
          Container(
            color: Colors.white,
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                //ref.read(filteredData).value.clear();
                //filterData(query);
              },
              decoration: const InputDecoration(
                labelText: 'Search Here',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.value.length,
              itemBuilder: (context, index) {
                final item = filteredData.value[index];
                return const MailItem();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context, Routes.ADD_EDIT_PAYEE, arguments: -1);
          Navigator.pushNamed(context, Routes.ADD_VIEW_MAIL_SCREEN,
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

class MailItem extends StatelessWidget {
  const MailItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16),
        margin: const EdgeInsets.all(8),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, Routes.ADD_VIEW_MAIL_SCREEN,
                arguments: 1);
          },
          tileColor: Colors.white,
          titleAlignment: ListTileTitleAlignment.center,
          contentPadding: const EdgeInsets.all(0),
          leading: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: const TextView(
                text: "J",
                textColor: Colors.black,
                textFontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          title: const TextView(
              text: "Jane Doe",
              textColor: Colors.black,
              textFontWeight: FontWeight.bold,
              fontSize: 16),
          subtitle: const TextView(
              text: "Employee Timesheet Submitted",
              textColor: Colors.black,
              textFontWeight: FontWeight.normal,
              fontSize: 14),
          trailing: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextView(
                  text: "09:30 PM",
                  textColor: Colors.black,
                  textFontWeight: FontWeight.normal,
                  fontSize: 12),
              TextView(
                  text: "Jul 23, 2023",
                  textColor: Colors.black,
                  textFontWeight: FontWeight.normal,
                  fontSize: 12),
            ],
          ),
        ));
  }
}
