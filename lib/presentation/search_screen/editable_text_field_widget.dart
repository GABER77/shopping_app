import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/shared/constants/colors.dart';

class EditableTextFormField extends StatefulWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool isEditable;
  final bool isPassword;
  final Color disabledColor;

  const EditableTextFormField({
    super.key,
    required this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    required this.isEditable,
    this.isPassword = false,
    this.disabledColor = Colors.grey,
  });

  @override
  State<EditableTextFormField> createState() => _EditableTextFormFieldState();
}

class _EditableTextFormFieldState extends State<EditableTextFormField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            color: widget.isEditable
                ? AppColors.secondaryColor
                : widget.disabledColor,
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        TextFormField(
          style: TextStyle(
            color: widget.isEditable ? Colors.white : widget.disabledColor,
          ),
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: widget.validator,
          enabled: widget.isEditable,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.disabledColor,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.secondaryColor,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: widget.isEditable
                        ? AppColors.secondaryColor
                        : widget.disabledColor,
                    size: 20.sp,
                  )
                : null,
            suffixIcon: widget.isPassword == true
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: widget.isEditable
                          ? AppColors.secondaryColor
                          : widget.disabledColor,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}