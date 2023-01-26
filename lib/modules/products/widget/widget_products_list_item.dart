import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_task/app_colors.dart';
import 'package:product_task/app_style.dart';

class WidgetProductsListItem extends StatelessWidget {
  final String? productName;
  final String? categoryName;
  final String? companyName;
  final String? qty;
  final String? imagePath;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onCardPressed;

  const WidgetProductsListItem({
    super.key,
    this.productName,
    this.categoryName,
    this.companyName,
    this.qty,
    this.imagePath,
    required this.onEdit,
    required this.onDelete,
    required this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardPressed,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 100,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    height: 100,
                    child: Image.file(
                      File(imagePath ?? ""),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName ?? "",
                          style: TextStyle(
                              fontSize: 18, color: AppColor.primaryColor),
                        ),
                        Text(
                          categoryName ?? "",
                          style: TextStyle(
                              fontSize: 12, color: AppColor.primaryColor),
                        ),
                        Text(
                          "Qty : ${qty ?? ''}",
                          style: TextStyle(
                              fontSize: 12, color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // Edit Button
                        AppStyle.appButton(
                          width: 80,
                          height: 40,
                          title: "Edit",
                          onPresses: onEdit,
                        ),
                        const SizedBox(height: 20),
                        // Delete Button
                        AppStyle.appButton(
                          width: 80,
                          height: 40,
                          title: "Delete",
                          onPresses: onDelete,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
