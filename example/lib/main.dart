import 'package:country_calling_code_picker_plus/country_calling_code_picker_plus.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Country? _selectedCountry;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    final country = _selectedCountry;
    return Scaffold(
      appBar: AppBar(title: Text('Country Calling Code Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            country == null
                ? Container()
                : Column(
                  children: <Widget>[
                    Image.asset(
                      country.flag,
                      package: countryCodePackageName,
                      width: 100,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${country.callingCode} ${country.name} (${country.countryCode})',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
            SizedBox(height: 100),
            MaterialButton(
              color: Colors.amber,
              onPressed: _onPressed,
              child: Text('Select Country using full screen'),
            ),
            SizedBox(height: 24),
            MaterialButton(
              color: Colors.orange,
              onPressed: _onPressedShowBottomSheet,
              child: Text('Select Country using bottom sheet'),
            ),
            SizedBox(height: 24),
            MaterialButton(
              color: Colors.deepOrangeAccent,
              onPressed: _onPressedShowDialog,
              child: Text('Select Country using dialog'),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed() async {
    final country = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PickerPage();
        },
      ),
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(context);
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  void _onPressedShowDialog() async {
    final country = await showCountryPickerDialog(context);
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
}

class PickerPage extends StatelessWidget {
  const PickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Country')),
      body: CountryPickerWidget(
        onSelected: (country) => Navigator.pop(context, country),
      ),
    );
  }
}
