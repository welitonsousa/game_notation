import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './sign_in_controller.dart';

class SignInPage extends GetView<SignInController> {
    
    const SignInPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('SignInPage'),),
            body: Container(),
        );
    }
}