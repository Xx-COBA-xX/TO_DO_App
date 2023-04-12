import 'package:flutter/material.dart';

import '../theme.dart';

  Column buildTItle(IconData icon, String title, String mainTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: white,
              size: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: titleStyle
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          mainTitle,
          style: subTitleStyle
        ),
      ],
    );
  }
