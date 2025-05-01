library;

import 'dart:convert';

import 'package:country_calling_code_picker_plus/src/model/country.dart';
import 'package:device_region/device_region.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///This function returns list of countries
Future<List<Country>> getCountries(BuildContext context) async {
  String rawData = await rootBundle.loadString('assets/raw/country_codes.json');
  final parsed = json.decode(rawData.toString()).cast<Map<String, dynamic>>();
  return parsed.map<Country>((json) => Country.fromJson(json)).toList();
}

/// This function returns an user's current country. User's sim country code
/// is matched with the ones in the list.
/// If there is no sim in the device, first country in the list will
/// be returned.
/// This function returns an user's current country. User's sim
/// country code is matched with the ones in the list.
/// If there is no sim in the device, first country in the list will
/// be returned.
Future<Country> getDefaultCountry(BuildContext context) async {
  final list = await getCountries(context);
  try {
    final countryCode = await DeviceRegion.getSIMCountryCode();
    if (countryCode == null) {
      return list.first;
    }
    return list.firstWhere((element) =>
        element.countryCode.toLowerCase() == countryCode.toLowerCase());
  } catch (e) {
    return list.first;
  }
}

/// This function returns an country whose [countryCode] matches
/// with the passed one.
Future<Country?> getCountryByCountryCode(
    BuildContext context, String countryCode) async {
  final list = await getCountries(context);
  return list.firstWhere((element) => element.countryCode == countryCode);
}
