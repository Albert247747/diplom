import 'package:flutter/material.dart';

class CustomLabelWidget extends StatelessWidget {
  const CustomLabelWidget({
    super.key,
    required this.title,
    required this.current,
    required this.total,
    this.height = 2,
    this.color = const Color(0xFF7A9A7A),
    this.backgroundColor = const Color(0xFFE5E5E5),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  });

  final String title;
  final int current;
  final int total;

  final double height;
  final Color color;
  final Color backgroundColor;
  final EdgeInsets padding;

  double get progress {
    if (total == 0) return 0;
    return (current / total).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: textStyle,
                ),
              ),
              Text(
                '$current/$total',
                style: textStyle,
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(height),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: height,
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}