library;

import 'package:country_calling_code_picker_plus/src/model/country.dart';
import 'package:country_calling_code_picker_plus/src/widgets/country_calling_code_picker_widget.dart';
import 'package:flutter/material.dart';

Future<Country?> showCountryPickerSheet(
  BuildContext context, {
  Widget? title,
  Widget? cancelWidget,
  double cornerRadius = 35,
  bool focusSearchBox = false,
  double heightFactor = 0.9,
}) {
  assert(
    heightFactor <= 0.9 && heightFactor >= 0.4,
    'heightFactor must be between 0.4 and 0.9',
  );
  return showModalBottomSheet<Country?>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(cornerRadius),
        topRight: Radius.circular(cornerRadius),
      ),
    ),
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * heightFactor,
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            Stack(
              children: <Widget>[
                cancelWidget ??
                    Positioned(
                      right: 8,
                      top: 4,
                      bottom: 0,
                      child: TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                Center(
                  child: title ??
                      Text(
                        'Choose region',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: CountryPickerWidget(
                onSelected: (country) => Navigator.of(context).pop(country),
              ),
            ),
          ],
        ),
      );
    },
  );
}
