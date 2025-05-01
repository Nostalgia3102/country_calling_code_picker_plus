library;

import 'package:country_calling_code_picker_plus/src/model/country.dart';
import 'package:country_calling_code_picker_plus/src/widgets/country_calling_code_picker_widget.dart';
import 'package:flutter/material.dart';

Future<Country?> showCountryPickerDialog(
  BuildContext context, {
  Widget? title,
  double cornerRadius = 35,
  bool focusSearchBox = false,
}) {
  return showDialog<Country?>(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(cornerRadius),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Stack(
            children: <Widget>[
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
    ),
  );
}
