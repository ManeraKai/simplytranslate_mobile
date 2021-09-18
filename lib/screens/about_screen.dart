import 'package:flutter/material.dart';
import '../data.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            color: lightgreyColor,
            height: 2,
          ),
        ),
        backgroundColor: theme == Brightness.dark ? greyColor : whiteColor,
        iconTheme: IconThemeData(
            color: theme == Brightness.dark ? whiteColor : Colors.black),
        title: Text('About'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Developer information:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc molestie, tellus id tincidunt faucibus, odio ante tristique metus, id tincidunt dui mauris vel est.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Application version number: 1.0.0',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'Copyright:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc molestie, tellus id tincidunt faucibus, odio ante tristique metus.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Co-Authors:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc molestie, tellus id tincidunt faucibus, odio ante tristique metus.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Contributing:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc molestie, tellus id tincidunt faucibus, odio ante tristique metus.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
