import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3))],
          border: Border.all(color: Colors.grey[400]!, width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ),
            value: selectedValue, // ✅ Show selected category or subcategory
            isExpanded: true,
            items: items.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(e, style: const TextStyle(fontSize: 14, color: Colors.black)),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600], size: 24),
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
