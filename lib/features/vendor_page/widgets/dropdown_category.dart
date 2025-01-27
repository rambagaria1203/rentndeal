import 'package:flutter/material.dart';

Widget categoryDropdown(String hint, List<String> list) {
  String? selectedValue; 

  return StatefulBuilder(
    builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3),),],
            border: Border.all(color: Colors.grey[400]!, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(hint, style: const TextStyle(color: Colors.grey, fontSize: 14),),
              ),
              value: selectedValue, isExpanded: true,
              items: list.map((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Dropdown item background color
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(e, style: const TextStyle(fontSize: 14, color: Colors.black),),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {selectedValue = newValue;});
              },
              icon: Icon(Icons.arrow_drop_down,color: Colors.grey[600],size: 24,),
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ),
      );
    },
  );
}
