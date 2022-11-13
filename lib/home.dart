import 'package:belajar_matematika/addition.dart';
import 'package:belajar_matematika/division.dart';
import 'package:belajar_matematika/multiplication.dart';
import 'package:belajar_matematika/subtraction.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Learn Math'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Addition()),
                              );
                            },
                            child: Card(
                              elevation: 4, // Change this
                              shadowColor: Colors.black12, // Change this
                              child: Center(
                                  child: SizedBox(
                                height: 150,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      'assets/image/addition.png',
                                      height: 75,
                                    ),
                                    const Text('Addition')
                                  ],
                                )),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Subtraction()),
                              );
                            },
                            child: Card(
                              elevation: 4, // Change this
                              shadowColor: Colors.black12, // Change this
                              child: Center(
                                  child: SizedBox(
                                height: 150,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      'assets/image/subtraction.png',
                                      height: 75,
                                    ),
                                    const Text('Subtraction')
                                  ],
                                )),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Division()),
                              );
                            },
                            child: Card(
                              elevation: 4, // Change this
                              shadowColor: Colors.black12, // Change this
                              child: Center(
                                  child: SizedBox(
                                height: 150,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      'assets/image/division.png',
                                      height: 75,
                                    ),
                                    const Text('Division')
                                  ],
                                )),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Multiplication()),
                              );
                            },
                            child: Card(
                              elevation: 4, // Change this
                              shadowColor: Colors.black12, // Change this
                              child: Center(
                                  child: SizedBox(
                                height: 150,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      'assets/image/multiplication.png',
                                      height: 75,
                                    ),
                                    const Text('Multiplication')
                                  ],
                                )),
                              )),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Expanded(
              flex: 1,
              child: Stack(children: [
                Container(color: Colors.yellow),
                const Center(
                    child: Text(
                  "Loading Ads...",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ]),
            )
          ],
        ));
  }
}
