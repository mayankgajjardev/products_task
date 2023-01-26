import 'package:flutter/material.dart';
import 'package:product_task/app_colors.dart';

class WidgetCompanyListItem extends StatelessWidget {
  final String? title;
  final VoidCallback onDelete;
  const WidgetCompanyListItem({super.key, this.title, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          InkWell(
            onTap: onDelete,
            child: const Icon(
              Icons.delete_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
