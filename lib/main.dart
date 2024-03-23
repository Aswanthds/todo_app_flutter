import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/viewmodel/getx_controller.dart';
import 'package:todo_app_flutter/view/home.dart';


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

/*

appBar: EasySearchBar(
          title: const Text('Example'),
          onSearch: (value) => setState(() => searchValue = value),
          suggestions: _suggestions
        ),
*/
