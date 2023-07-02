// Based on MATERIAL package
//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ccb_br_mobt_00/commons/commons.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:totp/totp.dart';
import '../commons/custom_timer_painter.dart';
import '../commons/globalvars.dart' as globals;

class TokenGenerator extends StatefulWidget {
  const TokenGenerator({super.key});

  @override
  State<TokenGenerator> createState() => _TokenGeneratorState();
}

class _TokenGeneratorState extends State<TokenGenerator>
    with TickerProviderStateMixin {
  late AnimationController controller;
  //final totp = Totp.fromBase32(secret: 'GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ', digits: 6, period: 60);
  final totp = Totp(
      secret: 'PEhedStqb6X1xBM3VfM2iXs99Vdk3G'.codeUnits,
      digits: 6,
      period: globals.tokenPeriod - 2);

/*   String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
 */
  String _getToken([int interruptor = 0]) {
    if (interruptor == 1) {
      globals.tokenCCB = totp.now();
    }
    return globals.tokenCCB;
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: globals.tokenPeriod),
    );
    controller.addListener(() {
      if (controller.value <= 0.01) {
        _getToken(1);
      }
    });
    _getToken(1);
    controller.forward(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: customContainer(
        context,
        AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                children: <Widget>[
                  /*                 Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.amber,
                      height: controller.value * MediaQuery.of(context).size.height,
                    ),
                  ),
       */
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.center,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: CustomPaint(
                                        painter: CustomTimerPainter(
                                      animation: controller,
                                      backgroundColor: Colors.orange,
                                      color: themeData.indicatorColor,
                                    )),
                                  ),
                                  Align(
                                    alignment: FractionalOffset.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        /*                                       const Text(
                                          "Geração de token",
                                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                                        ),
                                        Text(
                                          timerString,
                                          style: const TextStyle(fontSize: 20.0, color: Colors.black),
                                        ),
       */
                                        Text(
                                          _getToken(0),
                                          style: const TextStyle(
                                              fontSize: 76.0,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.0)),
                                onPressed: () {
                                  if (controller.isAnimating) {
                                    controller.stop();
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        globals.routeHome, (route) => false);
                                  } else {
                                    //controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
                                    //controller.repeat(reverse: false);
                                  }
                                },
                                child: Column(children: [
                                  Icon(
                                    controller.isAnimating
                                        ? Icons.stop
                                        : Icons.play_arrow,
                                    size: 42,
                                  ),
                                  Text(
                                      controller.isAnimating
                                          ? "Parar"
                                          : "Gerar",
                                      style: const TextStyle(
                                          fontSize: 24.0, color: Colors.white)),
                                ]),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
