import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';

/// [Item]
class Item extends StatelessWidget {
  final Country? country;
  final bool? useEmoji;
  final TextStyle? textStyle;
  final bool withCountryNames;
  final bool trailingSpace;

  const Item({
    super.key,
    this.country,
    this.useEmoji,
    this.textStyle,
    this.withCountryNames = false,
    this.trailingSpace = true,
  });

  @override
  Widget build(BuildContext context) {
    String dialCode = (country?.dialCode ?? '');
    // if (trailingSpace) {
    //   dialCode = dialCode.padRight(5, "   ");
    // }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   width: 12,
        // ),
        Text(
          '${country!.alpha2Code} $dialCode',
          textDirection: TextDirection.ltr,
          style: textStyle,
        ),
      ],
    );
  }
}
