import 'package:flutter/material.dart';
import 'package:product_task/app_colors.dart';
import 'package:product_task/app_style.dart';
import 'package:product_task/modules/company/widget/widget_company_list_item.dart';
import 'package:product_task/services/sql_light_service.dart';

class ScreenCompany extends StatefulWidget {
  const ScreenCompany({super.key});

  @override
  State<ScreenCompany> createState() => _ScreenCompanyState();
}

class _ScreenCompanyState extends State<ScreenCompany> {
  var companyController = TextEditingController();
  List<Map<String, dynamic>> allCompany = [];
  bool isLoading = true;

  void getAllCompany() async {
    final data = await SqlightService.getAllCompany();
    setState(() {
      allCompany = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAllCompany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company"),
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
                  controller: companyController,
                  decoration:
                      AppStyle.commanInputDecoration(labelText: "Company Name"),
                ),
                const SizedBox(height: 30),
                // Save Button
                AppStyle.appButton(
                  title: "Add",
                  onPresses: () async {
                    await SqlightService.addCompany(companyController.text);
                    companyController.clear();
                    getAllCompany();
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "List of companies",
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
                  : allCompany.isEmpty
                      ? Center(
                          child: Text(
                            "No Company Found.",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: allCompany.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemBuilder: (context, index) {
                            return WidgetCompanyListItem(
                              title: allCompany[index]["company_name"],
                              onDelete: () async {
                                await SqlightService.companyDelete(
                                    allCompany[index]['id']);
                                getAllCompany();
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
