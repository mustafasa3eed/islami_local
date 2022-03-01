import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({Key? key, required this.icon, required this.onPressed,required this.color}) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 1.0,
      child: Icon(icon),
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(
        width: 30.0,
        height: 30.0,
      ),
      shape: const CircleBorder(),
      fillColor: color,
      // fillColor: const Color(0xFF4C4F5E),
    );
  }
}