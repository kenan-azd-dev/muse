import 'package:flutter/material.dart';

class LanguageDropdownButton extends StatelessWidget {
  const LanguageDropdownButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(18.0),
      value: 'English',
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 10,
      underline: Container(),
      onChanged: (value) {},
      items: <String>['English', 'Arabic', 'Italian', 'French']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}
