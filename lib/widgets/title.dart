import 'package:flutter/material.dart';
import 'package:tudolar/helpers/colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'Tu',
          style: DefaultTextStyle.of(context).style.copyWith(
                color: AppColors.primary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
          children: const <TextSpan>[
            TextSpan(
              text: 'Dólar',
              style: TextStyle(
                color: AppColors.letterDark,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
