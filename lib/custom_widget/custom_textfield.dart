import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  bool obscureText;
  final String? errorMsg;
  final String? Function(String?) validator;
  final TextAlign textAlign;
  final bool isPassword;
  CustomTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.obscureText,
    required this.errorMsg,
    required this.validator,
    required this.textAlign,
    required this.isPassword,
  }) : super(key: key);

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onChanged: widget.onChanged,
      cursorColor: Colors.black,
      obscureText: _obscureText,
      textAlign: widget.textAlign,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        errorMaxLines: 3,
        errorText: widget.errorMsg,
        errorStyle: const TextStyle(
            fontSize: 14,
            height: 1),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 14,
        ),
        suffixIconColor: const Color.fromARGB(255, 118, 118, 118),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  color: const Color.fromARGB(255, 118, 118, 118),
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
        filled: true,
        fillColor: const Color.fromARGB(255, 241, 246, 246),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.red,
            )),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
