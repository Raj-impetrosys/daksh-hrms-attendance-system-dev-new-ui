import 'package:flutter/material.dart';

class White_splesh extends StatefulWidget {
  const White_splesh({Key? key}) : super(key: key);

  @override
  _White_spleshState createState() => _White_spleshState();
}

class _White_spleshState extends State<White_splesh> {
  final Gradient _gradient = LinearGradient(
    colors: [Color(0xffEE2B7A), Color(0xff6C2E91)],

    // begin: Alignment.topLeft,
    // end: Alignment.topRight,
  );
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(80),
            child: Image.asset(
              "images/logo.png",
              //color: Colors.pink,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          ShaderMask(
            blendMode: BlendMode.modulate,
            shaderCallback: (size) => _gradient.createShader(
              Rect.fromLTWH(0, 0, size.width, size.height),
            ),
            child: Text(
              "Monalisa",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
