import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(height: 90,),
          const Text('OOPS!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
          const Text('No Internet', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          const SizedBox(height: 80),
          Center(
            child: Image.asset(
              'assets/images/no_internet_connection.png',
              width: 200,
              height: 200,
            ),
          ),
        ],
      );
  }
}
