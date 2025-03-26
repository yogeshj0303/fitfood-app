import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GreetingWidget extends StatefulWidget {
  const GreetingWidget({super.key});

  @override
  State<GreetingWidget> createState() => _GreetingWidgetState();
}

class Particle {
  late List<Offset> points;
  late double radius1;
  late double radius2;
  late double speed;
  late double angle;
  late Color colour;
}

final List<Color> greenColor = [
  const Color(0xff27a300),
  const Color(0xff2a850e),
  const Color(0xff2d661b),
  const Color(0xff005c00)
];

class _GreetingWidgetState extends State<GreetingWidget> {
  List<Particle> particles = [];
  Timer? timer;
  @override
  void initState() {
    super.initState();
    final n = makeParticles();
    timer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      // update particles.
      const rad = pi / 180.0;
      final radD = 360.0 / n * rad;
      // var k = 0;
      setState(() {
        for (var p in particles) {
          p.angle += (p.speed * rad);
          for (var k = 0; k < p.points.length; k++) {
            p.points[k] = Offset(p.radius1 * cos(p.angle + k * radD),
                p.radius2 * sin(p.angle + k * radD));
          }
        } // foreach
      }); // setState
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final rng = Random();
  static const int count = 25;
  static const int edges = 24;
  int makeParticles() {
    const r1 = 150.0;
    const r2 = 100.0;
    const r = r1 / count;
    for (var i = 0; i < count; i++) {
      var p = Particle()
        ..angle = 0.0
        ..radius1 = r1 - r * i
        ..radius2 = r2 - r * i
        ..colour = greenColor[rng.nextInt(greenColor.length)]
        ..speed = (i + 1) * 0.2;
      p.points = Iterable.generate(edges, (_) => const Offset(0, 0)).toList();

      particles.add(p);
    }
    return edges;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: GreetingPainter(particles),
        child: Container(),
      ),
    );
  }
}

class GreetingPainter extends CustomPainter {
  final List<Particle> particles;
  GreetingPainter(this.particles);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawBackground(canvas, size);
    final center = Offset(size.width / 2, size.height / 2);
    drawFrame(canvas, center);
    drawParticles(canvas, center);
    drawText(canvas, center);
  }

  final W = 600.0;
  void drawFrame(Canvas canvas, Offset center) {
    final rect = Rect.fromCenter(center: center, width: W, height: W);
    final border = Paint()
      ..color = const Color(0xff01182b)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, border);
  }

  void drawBackground(Canvas canvas, Size size) {
    var gradient = RadialGradient(
      center: Alignment(-W / size.width + 0.2, W / size.height - 0.2),
      radius: 1.0,
      colors: const [Color(0xffa60112), Color(0xff01182b)],
      stops: const [0.0, 1.0],
    );
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    var paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  final b1 = Paint()
    ..color = Colors.red
    ..strokeWidth = 3.0
    ..style = PaintingStyle.fill;

  final b2 = Paint()
    ..color = const Color(0xff0b3720)
    ..strokeWidth = 3.0
    ..style = PaintingStyle.fill;

  final List<Color> lightCols = [
    const Color(0xffffbe0b),
    const Color(0xfffb5607),
    const Color(0xffff006e),
    const Color(0xff8338ec),
    const Color(0xff3a86ff)
  ];

  var rng = Random();
  void drawParticles(Canvas canvas, Offset center) {
    if (particles.isEmpty) return;
    var F = center + const Offset(0, 100.0);
    const w = 5.0;
    for (var i = 0; i < particles.length; i++) {
      final p = particles[i];
      final fd = F - Offset(0, 10.0 * i);
      for (var j = 0; j < p.points.length; j++) {
        b1.color = lightCols[rng.nextInt(lightCols.length)];
        b2.color = p.colour;
        canvas.drawCircle(p.points[j] + fd, w, b1);
        canvas.drawLine(fd, p.points[j] + fd, b2);
      }
    }
  }

  final textStyle =
      const TextStyle(color: Colors.red, fontFamily: "Rochester", fontSize: 40);
  void drawText(Canvas canvas, Offset center) {
    final textSpan = TextSpan(text: "Happy Diwali", style: textStyle);
    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(minWidth: 0, maxWidth: W);
    const padding = 10.0;
    final offset = Offset(center.dx - textPainter.width / 2.0,
        center.dy + W / 2.0 - textPainter.height - padding);
    textPainter.paint(canvas, offset);
  }
}
