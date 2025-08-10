import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool showSuffix;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.showSuffix,
    required this.controller,
    required this.validator,
    required this.icon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.showSuffix;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      cursorColor: Colors.grey,

      obscureText: _isObscured, // Use the built-in obscureText property
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Color.fromARGB(255, 115, 113, 113)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey, // Border color for light mode
            // Border color for dark mode
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey, // Border color for light mode
          ), // Active (focused) border color
        ),
        labelText: widget.hintText,
        prefixIcon: Icon(widget.icon, color: Colors.grey.shade700),
        suffixIcon:
            widget.showSuffix
                ? IconButton(
                  icon: Icon(
                    _isObscured
                        ? Icons.visibility_off
                        : Icons
                            .visibility, // Change icon based on visibility state
                    color: const Color.fromARGB(255, 82, 79, 79),
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured; // Toggle the obscure state
                    });
                  },
                )
                : null,
      ),
    );
  }
}
