import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:telofrota/screens/webview_screen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isConnectionSuccessful = false;
  late bool _isConnected;

  @override
  void initState() {
    super.initState();

    //_checkConnectivity();
  }

  // Future<void> _checkConnectivity() async {
  //   final ConnectivityResult connectivityResult =
  //   await Connectivity().checkConnectivity();
  //   setState(() {
  //     _isConnected = (connectivityResult == ConnectivityResult.mobile ||
  //         connectivityResult == ConnectivityResult.wifi);
  //   });
  //   _checkInternet(_isConnected);
  // }


  // void _checkInternet(bool _isConnected) async {
  //
  //   if(_isConnected){
  //
  //     try {
  //       final response = await http.head(Uri.parse('https://taxinahorah.online/fle'));
  //       setState(() {
  //         _isConnectionSuccessful = true;
  //         print('_isConnectionSuccessful');
  //         print(_isConnectionSuccessful);
  //       });
  //     } catch (e) {
  //       setState(() {
  //         print('_isConnectionSuccessful1');
  //         print(_isConnectionSuccessful);
  //         _isConnectionSuccessful = false;
  //       });
  //     }
  //   }else {
  //     print('_isConnectionSuccessful2');
  //     print(_isConnectionSuccessful);
  //     _isConnectionSuccessful = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      splashTransition: SplashTransition.fadeTransition,
      splash: Column(children: [
        Image.asset('assets/images/telefrota_logo.png',width: 140, height: 140),
        const Text('Telefrota', style: TextStyle(fontSize: 25, color: Colors.white),),
        //const Text('A Vehicle Mgmt System', style: TextStyle(fontSize: 12, color: Colors.grey),)
      ]),
      splashIconSize: 200.0,
      animationDuration: const Duration(seconds: 4),
      nextScreen: WebViewScreen(),
    );
  }
}
