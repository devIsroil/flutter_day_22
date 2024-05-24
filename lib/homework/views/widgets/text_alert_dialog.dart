import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../utils/app_constants.dart';


class TextAlertDialog extends StatelessWidget {
  final Function(Color, double) onTextChanged;

  TextAlertDialog({super.key, required this.onTextChanged});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color currentColor = AppConstants.textColor;
  double fontSize = AppConstants.textSize;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit text'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter size';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter new font size',
                ),
                onSaved: (newValue) {
                  if (newValue != null) {
                    fontSize = double.parse(newValue);
                  }
                },
              ),
            ),
            ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                currentColor = color;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              onTextChanged(currentColor, fontSize);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}