import 'package:flutter/material.dart';

class SimpleSlideToCheckIn extends StatefulWidget {
  final VoidCallback onCheckInTriggered;

  const SimpleSlideToCheckIn({Key? key, required this.onCheckInTriggered}) : super(key: key);

  @override
  State<SimpleSlideToCheckIn> createState() => _SimpleSlideToCheckInState();
}

class _SimpleSlideToCheckInState extends State<SimpleSlideToCheckIn> {
  double _dragPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    // بنحسب عرض الشريط تلقائياً عشان الزرار يوصل للآخر بغض النظر عن حجم الموبايل
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth - 60; // بنطخص حجم الدائرة عشان تقف مظبوط في الآخر

        return Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xffF0F4F4),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // النص بيختفي تدريجياً أو فوراً أول ما المستخدم يبدأ يسحب
              Center(
                child: Opacity(
                  opacity: _dragPosition > 50 ? 0.0 : 1.0, // أول ما يبدأ يسحب النص يختفي
                  child: const Text(
                    "Slide to check in",
                    style: TextStyle(
                      color: Color(0xFF1F9A85),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _dragPosition,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _dragPosition += details.delta.dx;
                      if (_dragPosition < 0) {
                        _dragPosition = 0;
                      } else if (_dragPosition > maxWidth) {
                        _dragPosition = maxWidth;
                      }
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_dragPosition > maxWidth * 0.75) {
                      _dragPosition = maxWidth;
                      widget.onCheckInTriggered();
                       setState(() {
                        _dragPosition = 0.0;
                      });
                    } else {
                      setState(() {
                        _dragPosition = 0.0;
                      });
                    }
                  },
                  child: Container(
                    width: 55,
                    height: 55,
                    margin: const EdgeInsets.all(2.5),
                    decoration: const BoxDecoration(
                      color: Color(0xffFF7F73),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}