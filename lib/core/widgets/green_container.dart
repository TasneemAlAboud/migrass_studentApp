import 'package:flutter/material.dart';
import 'package:student/core/function/function.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/my_lesson.dart';

class greenContainer extends StatelessWidget {
  const greenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 120,
    );}}


Widget defauilButton({
  required Color background,
  required Color textcolorbutton,
  required Function function,
  required String text,
})=>MaterialButton(
  onPressed :  () => function(),
  color:background,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),),
  child: Text(
    text,
    style: TextStyle(
      color: textcolorbutton,
      fontWeight: FontWeight.bold,
    ),
  ),
);


Widget defaultTextFormField({
  required TextEditingController controller,
  required String labelText,
  required bool isPassword,
  required bool isObscure,
  required VoidCallback onToggleVisibility,
  required String suffixIconPath,
  required TextInputType keyboardType,
  required String? Function(String?) validator,
  required Function(String) onChanged,
  required Color textStyle,
  required Color fillColor ,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? isObscure : false,
      style: TextStyle(
        color: textStyle,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: onToggleVisibility,
        )
            : null,
        suffixIcon: Image.asset(suffixIconPath),
      ),
      validator: validator,
      onChanged: onChanged,
    );


class WaveformWidget extends StatelessWidget {
  final List<double> waveData;
  const WaveformWidget({super.key, required this.waveData});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaveformPainter(waveData),
      size: const Size(double.infinity, 50),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> waveData;
  WaveformPainter(this.waveData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorManager.successText
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;
    final spacing = size.width / (waveData.isEmpty ? 1 : waveData.length);

    for (int i = 0; i < waveData.length; i++) {
      final x = i * spacing;
      final y = waveData[i] * size.height / 2;
      canvas.drawLine(Offset(x, centerY - y), Offset(x, centerY + y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) =>
      oldDelegate.waveData != waveData;
}







