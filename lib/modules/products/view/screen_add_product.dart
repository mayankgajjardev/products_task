// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_task/app_colors.dart';
import 'package:product_task/app_style.dart';
import 'package:product_task/services/sql_light_service.dart';

class ScreenAddProduct extends StatefulWidget {
  final int? pId;
  final bool? isFromEdit;
  final String? productName;
  final String? categoryName;
  final String? companyName;
  final String? imagePath;
  final String? description;
  final String? qty;
  final String? price;

  const ScreenAddProduct({
    super.key,
    this.pId,
    this.productName,
    this.categoryName,
    this.companyName,
    this.description,
    this.qty,
    this.price,
    this.isFromEdit = false,
    this.imagePath,
  });

  @override
  State<ScreenAddProduct> createState() => _ScreenAddProductState();
}

class _ScreenAddProductState extends State<ScreenAddProduct> {
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  var isShowImage = false;

  var productController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var qtyController = TextEditingController();

  List<Map<String, dynamic>> allCategory = [];
  List<Map<String, dynamic>> allCompany = [];
  var selectedCategoryId = '';
  var selectedCompanyId = '';

  void getAllCategory() async {
    final data = await SqlightService.getAllCategory();
    setState(() {
      allCategory = data;
    });
  }

  void getAllCompany() async {
    final data = await SqlightService.getAllCompany();
    setState(() {
      allCompany = data;
    });
  }

  void addProduct() async {
    if (selectedCategoryId.isNotEmpty && selectedCompanyId.isNotEmpty) {
      await SqlightService.addProduct(
        categoryId: selectedCategoryId,
        companyId: selectedCompanyId,
        descrption: descriptionController.text,
        imagePath: selectedImage?.path ?? "",
        price: priceController.text,
        productName: productController.text,
        qty: qtyController.text,
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Selected Category Or Company"),
        ),
      );
    }
  }

  void updateProduct() async {
    if (selectedCategoryId.isNotEmpty && selectedCompanyId.isNotEmpty) {
      await SqlightService.updateProduct(
        id: widget.pId,
        categoryId: selectedCategoryId,
        companyId: selectedCompanyId,
        descrption: descriptionController.text,
        imagePath: selectedImage?.path ?? "",
        price: priceController.text,
        productName: productController.text,
        qty: qtyController.text,
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Selected Category Or Company"),
        ),
      );
    }
  }

  prefillData() {
    productController.text = widget.productName ?? "";
    descriptionController.text = widget.description ?? "";
    qtyController.text = widget.qty ?? "";
    priceController.text = widget.price ?? "";
    selectedCategoryId = widget.categoryName ?? "";
    selectedCompanyId = widget.companyName ?? "";
    selectedImage = XFile(widget.imagePath ?? "");
  }

  void imageSelect() async {
    await _picker.pickImage(source: ImageSource.gallery).then((res) {
      if (res!.path.isNotEmpty) {
        selectedImage = res;
        isShowImage = true;
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    prefillData();
    getAllCategory();
    getAllCompany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: productController,
                  decoration:
                      AppStyle.commanInputDecoration(labelText: "Product Name"),
                ),
                const SizedBox(height: 20),

                // Category
                DropdownButtonFormField(
                  value: selectedCategoryId.isEmpty ? null : selectedCategoryId,
                  items: allCategory.map((e) {
                    return DropdownMenuItem(
                      value: e['cat_name'],
                      child: Text(e['cat_name']),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCategoryId = val as String;
                    });
                    debugPrint(
                        "Mayank :: selectedCategoryId :: $selectedCategoryId");
                  },
                  decoration:
                      AppStyle.commanInputDecoration(labelText: "Category"),
                ),

                const SizedBox(height: 20),

                // Company
                DropdownButtonFormField(
                  value: selectedCompanyId.isEmpty ? null : selectedCompanyId,
                  items: allCompany.map((e) {
                    return DropdownMenuItem(
                      value: e['company_name'],
                      child: Text(e['company_name']),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCompanyId = val as String;
                    });
                    debugPrint(
                        "Mayank :: selectedCompanyId :: $selectedCompanyId");
                  },
                  decoration:
                      AppStyle.commanInputDecoration(labelText: "Company Name"),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 6,
                  decoration:
                      AppStyle.commanInputDecoration(labelText: "Description"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: priceController,
                  decoration:
                      AppStyle.commanInputDecoration(labelText: "Price"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: qtyController,
                  decoration: AppStyle.commanInputDecoration(labelText: "Qty"),
                ),
                const SizedBox(height: 20),

                Text(
                  "Upload Image :",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),

                if (isShowImage == true)
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(selectedImage?.path ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                if (isShowImage == false)
                  AppStyle.addContainerTile(
                    onPressed: () {
                      imageSelect();
                    },
                  ),
                const SizedBox(height: 30),

                // Save Button
                AppStyle.appButton(
                  title: "Save",
                  onPresses: () {
                    if (widget.isFromEdit == true) {
                      updateProduct();
                    } else {
                      addProduct();
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
