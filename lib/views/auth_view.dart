import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/components/auth_form.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(205, 79, 255, 0.898),
              Color.fromRGBO(205, 79, 255, 0.898),
              Color.fromRGBO(255, 42, 155, 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 70,
                ),
                transform: Matrix4.rotationZ(
                    -8 * pi / 180) // gira a posição  do container
                  ..translate(-10.0), // cascade para esquerda
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrange.shade900,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black26,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'Minha Loja',
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Anton',
                    color: Colors.white,
                  ),
                ),
              ),
              AuthForm(),
            ],
          ),
        ),
      ],
    ));
  }
}
