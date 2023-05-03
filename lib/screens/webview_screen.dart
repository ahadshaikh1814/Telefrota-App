import 'dart:async';

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:telofrota/screens/no_internet_connection_screen.dart';
import 'package:http/http.dart' as http;

class WebViewScreen extends StatefulWidget {
  WebViewScreen({Key? key}) : super(key: key);


  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  late WebViewController webViewController;
  var loadingPercentage = 0;
  late final host;
  bool _isConnectionSuccessful = false;
  late var listener;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Future<bool> exit(BuildContext context) async {
    if (await webViewController.canGoBack()) {
      print('webViewController.canGoBack()');
      webViewController.goBack();
      return false;
    } else {
      print('webViewController.canGoBack(no)');

      return true;
    }
  }

  @override
  initState() {
    super.initState();
    
     // _checkConnectivity().then((value){
     //   setState(() {
     //     _initialized = true;
     //   });
     //   print('_initialized');
     //   print(_initialized);
     // });

    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
       setState(() {
        // _isConnected = (result == ConnectivityResult.mobile ||
        //     result == ConnectivityResult.wifi);

        _isConnectionSuccessful = (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi);
       });
      //_checkInternet();
      //widget.checkInternet(_isConnected);
    });

    // start this code works but without null safety (Package: data_connection_checker: ^0.3.4)
    //  listener = DataConnectionChecker().onStatusChange.listen((status) {
    //   switch (status) {
    //     case DataConnectionStatus.connected:
    //       print('Data connection is available.');
    //       setState(() {
    //         _isConnectionSuccessful = true;
    //       });
    //       break;
    //     case DataConnectionStatus.disconnected:
    //       print('You are disconnected from the internet.');
    //       setState(() {
    //         _isConnectionSuccessful = false;
    //       });
    //       break;
    //   }
    //
    //   //_isConnectionSuccessful = _tryConnection();
    // });
  //end
  }


  Future<void> _checkConnectivity() async {
    final ConnectivityResult connectivityResult =
    await Connectivity().checkConnectivity();
    setState(() {
      print('_checkConnectivity1');
      // _isConnected = (connectivityResult == ConnectivityResult.mobile ||
      //     connectivityResult == ConnectivityResult.wifi);

      _isConnectionSuccessful = (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi);
    });
    // _checkInternet().then((value){
    //   setState(() {
    //     _initialized = true;
    //   });
    // });
  }


  // Future<void> _checkInternet() async {
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
  print('buildobject');
    return WillPopScope(
      onWillPop: () => exit(context),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/telefrota_logo.png',width: 54, height: 44),
                  const Text(
                    'Telefrota',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
            ),
            //leading: Image.asset('assets/images/app_logo.png',width: 64, height: 64),
          ),
          body: _isConnectionSuccessful
              ? Builder(
                  builder: (BuildContext context) {
                    return Stack(children: [
                      WebView(
                        //initialUrl: "https://taxinahorah.online/fle",
                        initialUrl: "https://taxinahorah.online/fle",
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          //_controller.complete(webViewController);
                          this.webViewController = webViewController;
                        },
                        onProgress: (progress) {
                          setState(() {
                            loadingPercentage = progress;
                          });
                        },
                        onPageStarted: (String url) {
                          setState(() {
                            loadingPercentage = 0;
                          });
                        },
                        onPageFinished: (String url) {
                          setState(() {
                            loadingPercentage = 100;
                          });
                        },
                        gestureNavigationEnabled: true,
                      ),
                      if (loadingPercentage < 100)
                        LinearProgressIndicator(
                          value: loadingPercentage / 100.0,
                        ),
                    ]);
                  },
                )
              : const NoInternetScreen()),
    );
  }
}
