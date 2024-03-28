import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/models/todo_model.dart';
import 'package:todo_app_flutter/view/home.dart';
import 'package:todo_app_flutter/view/widgets/preview.dart';
import 'package:todo_app_flutter/viewmodel/getx_controller.dart';

class MySearchDelegate extends SearchDelegate {
  final controller = Get.find<ApiController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
          Get.offAll(() => const MyHomePage());
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.offAll(() => const MyHomePage());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final dataList = controller.list.toList();
    final filteredList = query.isEmpty
        ? dataList // Show all data if no search query
        : dataList.where((item) => _matchesWordByWord(item, query)).toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final item = filteredList[index];
        // Access other properties from the dynamic data object here
        return ListTile(
          onTap: () {
            final data = TodoModel.fromJson(item);
            Get.to(() => TodoPreviewPage(data: data));
          },
          title: Text(item['title']), // Assuming 'title' is a property
          // Add other widgets based on your data structure
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final dataList = controller.list.toList();
    // Implement suggestions if needed (optional)
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final item = dataList[index];
        return ListTile(
          title: Text(item['title']),
        );
      },
    );
  }

  // Custom method for word-by-word search matching
  bool _matchesWordByWord(dynamic item, String query) {
    final lowercaseQuery = query.toLowerCase();
    final words = lowercaseQuery.split(' ');
    for (final word in words) {
      if (!item['title'].toLowerCase().contains(word)) {
        return false;
      }
    }
    return true;
  }
}
