import 'package:flutter/material.dart';
import 'package:product_task/app_colors.dart';
import 'package:product_task/app_style.dart';
import 'package:product_task/modules/company/widget/widget_company_list_item.dart';
import 'package:product_task/services/sql_light_service.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  var categoryController = TextEditingController();
  List<Map<String, dynamic>> allCategory = [];
  bool isLoading = true;

  void getAllCategory() async {
    final data = await SqlightService.getAllCategory();
    setState(() {
      allCategory = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        backgroundColor: const Color(0xFF6D7072),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: categoryController,
                  decoration: AppStyle.commanInputDecoration(
                      labelText: "Category Name"),
                ),
                const SizedBox(height: 30),
                // Save Button
                AppStyle.appButton(
                  title: "Add",
                  onPresses: () async {
                    await SqlightService.addCategory(categoryController.text);
                    categoryController.clear();
                    getAllCategory();
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "List of categories",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Expanded(
              child: isLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : allCategory.isEmpty
                      ? Center(
                          child: Text(
                            "No Category Found.",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: allCategory.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemBuilder: (context, index) {
                            return WidgetCompanyListItem(
                              title: allCategory[index]['cat_name'],
                              onDelete: () async {
                                await SqlightService.categoryDelete(
                                    allCategory[index]['id']);
                                getAllCategory();
                                setState(() {});
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                        ),
            )
          ],
        ),
      )),
    );
  }
}
