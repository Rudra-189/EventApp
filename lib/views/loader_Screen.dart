import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class loaderScreen extends StatefulWidget {
  const loaderScreen({super.key});

  @override
  State<loaderScreen> createState() => _loaderScreenState();
}

class _loaderScreenState extends State<loaderScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Lottie.asset('assets/images/Animation - 1741575601711.json'),
        ),
      ),
    );
  }
}
