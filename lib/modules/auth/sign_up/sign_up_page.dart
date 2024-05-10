import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './sign_up_controller.dart';

class SignUpPage extends GetView<SignUpController> {
    
    const SignUpPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('SignUpPage'),),
            body: Container(),
        );
    }
}