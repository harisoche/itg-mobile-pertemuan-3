import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color borderColor;
  final Color backgroundColor;

  const ChipWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.borderColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(width: 8),
          Text(label),
          Text(value, style: TextStyle(fontWeight: .bold)),
        ],
      ),
    );
  }
}
