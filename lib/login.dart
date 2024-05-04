// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:untitled1/router_observer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Check if the scroll position is at the top
      if (_scrollController.offset <= 0) {
        // Keyboard is hidden, disable scrolling
        _scrollController.jumpTo(0);
      } else if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        // Scrolled to the bottom, disable scrolling
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: GestureDetector(
          onTap: () {
            var navStack = CustomNavigatorObserver.navStack;
            var routeSettings = navStack.isEmpty ? null : navStack.last;
            print(routeSettings?.name);
          },
          behavior: HitTestBehavior.translucent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    var navStack = CustomNavigatorObserver.navStack;
                    var routeSettings = navStack.isEmpty ? null : navStack.last;
                    print(routeSettings?.name);
                  },
                  child: Container(
                    color: Colors.white,
                    height: 200,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
