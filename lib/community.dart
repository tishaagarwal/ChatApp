import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<String> groups = [
    'Group 1',
    'Group 2',
    'Group 3',
    // Add more groups as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(groups[index]),
            onTap: () {
              // Navigate to the selected group page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => GroupDetailsPage(groups[index])));
            },
          );
        },
      ),
    );
  }
}
