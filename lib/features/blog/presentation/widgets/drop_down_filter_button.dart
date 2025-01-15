import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:clean_code_app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class DropDownFilterButton extends StatelessWidget {
  final List<String> filters;
  final void Function(String?)? onChanged;
  final String selectedFilter;
  const DropDownFilterButton(
      {super.key,
      required this.filters,
      this.onChanged,
      required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: selectedFilter,
        decoration: InputDecoration(
          border: AppTheme.border(),
          focusedBorder: AppTheme.border(AppPallete.gradient2),
          enabledBorder: AppTheme.border(),
          errorBorder: AppTheme.border(AppPallete.errorColor),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          filled: true,
          fillColor: AppPallete.backgroundColor,
        ),
        dropdownColor: AppPallete.backgroundColor, // Dropdown menu background
        iconEnabledColor: AppPallete.whiteColor, // Icon color
        style: const TextStyle(color: AppPallete.whiteColor), // Text style
        items: filters.map((filter) {
          return DropdownMenuItem<String>(
            value: filter,
            child: Text(
              filter,
              style: const TextStyle(color: AppPallete.whiteColor),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
