import 'package:flutter/material.dart';

class SeeAllCat extends StatelessWidget {
 SeeAllCat({super.key});

  // Define a list of categories
  final List<String> catList = [
    'Category 1',
    'Category 2',
    'Category 3',
    // Add more categories as needed
  ];

  // Function to generate a list of widgets based on the category list
  List<Widget> _buildCategoryList() {
    List<Widget> widgets = [];
    for (var category in catList) {
      widgets.add(
        ListTile(
          title: Text(category),
          onTap: () {
            // You can add navigation logic here if needed
          },
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Category'),
      ),
      body: ListView(
        children: _buildCategoryList(), // Call the function to build the list of widgets
      ),
    );
  }
}
