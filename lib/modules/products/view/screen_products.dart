import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_task/app_colors.dart';
import 'package:product_task/modules/products/view/screen_add_product.dart';
import 'package:product_task/modules/products/view/screen_product_detail.dart';
import 'package:product_task/modules/products/widget/widget_products_list_item.dart';
import 'package:product_task/services/sql_light_service.dart';

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({super.key});

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  List<Map<String, dynamic>> allProducts = [];
  bool isLoading = true;

  void getAllCompany() async {
    final data = await SqlightService.getItems();
    setState(() {
      allProducts = data;
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
        title: const Text("Products"),
        backgroundColor: const Color(0xFF6D7072),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => const ScreenAddProduct(),
                ),
              ).then((value) {
                if (value == true) {
                  setState(() {
                    getAllCompany();
                  });
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
          child: isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : allProducts.isEmpty
                  ? Center(
                      child: Text(
                        "No Product Found.",
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: allProducts.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemBuilder: (context, index) {
                        return WidgetProductsListItem(
                          onCardPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => ScreenProductDetail(
                                  categoryName: allProducts[index]
                                      ['category_name'],
                                  companyName: allProducts[index]
                                      ['company_name'],
                                  description: allProducts[index]
                                      ['description'],
                                  price: allProducts[index]['price'],
                                  productName: allProducts[index]
                                      ['product_name'],
                                  qty: allProducts[index]['qty'],
                                  imagePath: allProducts[index]['image_path'],
                                ),
                              ),
                            );
                          },
                          onDelete: () async {
                            await SqlightService.deleteItem(
                                allProducts[index]['id']);
                            getAllCompany();
                            setState(() {});
                          },
                          onEdit: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => ScreenAddProduct(
                                    pId: allProducts[index]['id'],
                                    categoryName: allProducts[index]
                                        ['category_name'],
                                    companyName: allProducts[index]
                                        ['company_name'],
                                    description: allProducts[index]
                                        ['description'],
                                    price: allProducts[index]['price'],
                                    productName: allProducts[index]
                                        ['product_name'],
                                    qty: allProducts[index]['qty'],
                                    imagePath: allProducts[index]['image_path'],
                                    isFromEdit: true,
                                  ),
                                )).then((value) {
                              if (value == true) {
                                setState(() {
                                  getAllCompany();
                                });
                              }
                            });
                          },
                          categoryName: allProducts[index]['category_name'],
                          companyName: allProducts[index]['company_name'],
                          imagePath: allProducts[index]['image_path'],
                          productName: allProducts[index]['product_name'],
                          qty: allProducts[index]['qty'],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                    )),
    );
  }
}
