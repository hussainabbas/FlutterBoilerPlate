import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/widgets/text_view.dart';

class AnnouncementsMenuScreen extends HookConsumerWidget {
  const AnnouncementsMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
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
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const AnnouncementItem();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  const AnnouncementItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            width: 4.0, // Set the width of the left border
            color: AppColors.primaryColor, // Set the color of the border
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
              text: "Newsletter",
              textColor: AppColors.primaryColor,
              textFontWeight: FontWeight.bold,
              fontSize: 16),
          const TextView(
              text:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              textColor: Colors.black,
              textFontWeight: FontWeight.normal,
              fontSize: 13),
        ],
      ),
    );
  }
}
