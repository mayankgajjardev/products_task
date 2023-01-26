import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_task/modules/category/view/screen_category.dart';
import 'package:product_task/modules/company/view/screen_company.dart';
import 'package:product_task/modules/products/view/screen_products.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color(0xFF6D7072),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _containerTile(
                title: "Products",
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => const ScreenProducts(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _containerTile(
                title: "Manage Category",
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => const ScreenCategory(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _containerTile(
                title: "Manage Company",
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => const ScreenCompany(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerTile({String? title, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        height: 170,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF6D7072),
        ),
        child: Text(
          title ?? "",
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
