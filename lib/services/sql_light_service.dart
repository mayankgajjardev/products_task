import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SqlightService {
  static Future<void> createTables(Database database) async {
    // Products Table
    await database.execute("""CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        product_name TEXT,
        category_name TEXT,
        company_name TEXT,
        description TEXT,
        price TEXT,
        qty TEXT,
        image_path TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    // Category Table
    await database.execute("""CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        cat_name TEXT, 
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    // Company Table
    await database.execute("""CREATE TABLE company(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        company_name TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  // Initial DB
  static Future<Database> db() async {
    return openDatabase(
      'product.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Add Product
  static Future<int> addProduct({
    String? productName,
    String? categoryId,
    String? companyId,
    String? descrption,
    String? price,
    String? qty,
    String? imagePath,
  }) async {
    final db = await SqlightService.db();

    final data = {
      'product_name': productName,
      'category_name': categoryId,
      'company_name': companyId,
      'description': descrption,
      'price': price,
      'qty': qty,
      'image_path': imagePath
    };
    final id = await db.insert(
      'products',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // Read all Prodcuts
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SqlightService.db();
    return db.query('products', orderBy: "id");
  }

  // Get Single Item
  static Future<List<Map<String, dynamic>>> getProductById(int id) async {
    final db = await SqlightService.db();
    return db.query('products', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update Product By id
  static Future<int> updateProduct({
    int? id,
    String? productName,
    String? categoryId,
    String? companyId,
    String? descrption,
    String? price,
    String? qty,
    String? imagePath,
  }) async {
    final db = await SqlightService.db();

    final data = {
      'product_name': productName,
      'category_name': categoryId,
      'company_name': companyId,
      'description': descrption,
      'price': price,
      'qty': qty,
      'image_path': imagePath,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('products', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete Product
  static Future<void> deleteItem(int id) async {
    final db = await SqlightService.db();
    try {
      await db.delete("products", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Add Catgory
  static Future<int> addCategory(
    String? categoryName,
  ) async {
    final db = await SqlightService.db();

    final data = {
      'cat_name': categoryName,
    };
    final id = await db.insert(
      'category',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // Read all Categories
  static Future<List<Map<String, dynamic>>> getAllCategory() async {
    final db = await SqlightService.db();
    return db.query('category', orderBy: "id");
  }

  // Delete Category
  static Future<void> categoryDelete(int id) async {
    final db = await SqlightService.db();
    try {
      await db.delete("category", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Delete Company
  static Future<void> companyDelete(int id) async {
    final db = await SqlightService.db();
    try {
      await db.delete("company", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Add Company
  static Future<int> addCompany(
    String? categoryName,
  ) async {
    final db = await SqlightService.db();

    final data = {
      'company_name': categoryName,
    };
    final id = await db.insert(
      'company',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // Read all Company
  static Future<List<Map<String, dynamic>>> getAllCompany() async {
    final db = await SqlightService.db();
    return db.query('company', orderBy: "id");
  }
}
