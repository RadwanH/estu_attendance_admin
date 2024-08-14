import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMacroWidgetField extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final TextEditingController controller;
  final Color? color;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const MyMacroWidgetField(
      {required this.title,
      required this.icon,
      this.iconColor,
      required this.controller,
      this.color,
      this.inputFormatters,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(2, 2),
                blurRadius: 5)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16,
        ),
        child: Column(
          children: [
            FaIcon(
              icon,
              color: iconColor,
              size: 40,
            ),
            const SizedBox(height: 4),
            TextFormField(
              validator: validator,
              inputFormatters: inputFormatters,
              keyboardType: TextInputType.number,
              controller: controller,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ));
  }
}
