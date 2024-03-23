import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/view/completed_task.dart';
import 'package:todo_app_flutter/view/to_do.dart';
import 'package:todo_app_flutter/view/widgets/add_task.dart';
import 'package:todo_app_flutter/view/widgets/search_delegatte.dart';
import 'package:todo_app_flutter/viewmodel/getx_controller.dart';

void main() {
  Get.put(ApiController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  String searchValue = '';
  final controller = Get.find<ApiController>();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TabBar(
            controller: _tabController,
            labelColor: Colors.green,
            tabAlignment: TabAlignment.fill,
            indicatorColor: Colors.green,
            dividerColor: Colors.transparent,
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task_alt),
                    Text("To Do"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.done_outline_rounded),
                    Text("Completed"),
                  ],
                ),
              ),
            ]),
      ),
      appBar: AppBar(
        title: Text(
          "To Do App",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(), // Replace with your data list
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: TabBarView(controller: _tabController, children: const [
          TodoPageScreen(),
          CompletedTaskPageScreen(),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IconButton.filledTonal(
        color: Colors.white,
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green)),
        onPressed: () {
          Get.to(() => const AddTaskPage());
        },
        icon: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
    );
  }
}

/*

appBar: EasySearchBar(
          title: const Text('Example'),
          onSearch: (value) => setState(() => searchValue = value),
          suggestions: _suggestions
        ),
*/
