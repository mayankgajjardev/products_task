import 'dart:io';
import 'package:flutter/material.dart';
import 'package:product_task/app_colors.dart';

class AppStyle {
  static appButton(
      {String? title, VoidCallback? onPresses, double? width, double? height}) {
    return InkWell(
      onTap: onPresses,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // Add Image Container
  static Widget addContainerTile({
    VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          Icons.add,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }

  static InputDecoration commanInputDecoration({String? labelText}) {
    return InputDecoration(
      labelText: labelText ?? '',
      labelStyle: TextStyle(
        color: AppColor.primaryColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(5),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
