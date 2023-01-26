import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_task/app_colors.dart';
import 'package:product_task/app_style.dart';

class ScreenProductDetail extends StatelessWidget {
  final String? productName;
  final String? categoryName;
  final String? companyName;
  final String? description;
  final String? imagePath;
  final String? qty;
  final String? price;
  const ScreenProductDetail(
      {super.key,
      this.productName,
      this.categoryName,
      this.companyName,
      this.description,
      this.qty,
      this.price,
      this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Screen"),
        backgroundColor: const Color(0xFF6D7072),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: AppColor.primaryColor,
                  height: 170,
                  width: double.infinity,
                  child: Image.file(
                    File(imagePath ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName ?? "",
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        categoryName ?? "",
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Price: ${price ?? ''}",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    companyName ?? "",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Qty: ${qty ?? ''}",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Description :",
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              // Decription
              Text(
                description ?? "",
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
