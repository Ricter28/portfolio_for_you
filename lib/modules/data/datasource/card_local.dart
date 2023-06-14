import 'package:flutter/foundation.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/data/model/item.model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

const String tableCard = 'card';
const String columnId = 'id';
const String columnName = 'name';
const String columnType = 'type';
const String columnIsSpotlight = 'isSpotlight';
const String columnImage = 'image';
const String columnDes = 'des';
const String columnCreatedAt = 'createdAt';
const String columnHeaderColor = 'headerColor';
const String columnBGClor = 'bgColor';
const String columnHeaderTextColor = 'headerTextColor';
const String columnBodyTextColor = 'bodyTextColor';
const String columnQAData = 'QRData';

const String tableItem = 'item';
const String columnItemId = 'id';
const String columnItemName = 'name';
const String columnItemDes = 'des';
const String columnItemIndex = 'indexItem';
const String columnItemImage = 'image';
const String columnCardId = 'cardId';

@injectable
class LocalDatabase {
  static Database? _database;
  static LocalDatabase? _userDatabase;

  LocalDatabase._createInstance();
  factory LocalDatabase() {
    _userDatabase ??= LocalDatabase._createInstance();
    return _userDatabase!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'portfolio_for_you.db');
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      // PROJECT
      await db.execute('''
          CREATE TABLE $tableCard (
          $columnId integer primary key autoincrement,
          $columnName text,
          $columnType text,
          $columnIsSpotlight text,
          $columnImage text,
          $columnDes text,
          $columnCreatedAt text,
          $columnHeaderColor text,
          $columnBGClor text,
          $columnHeaderTextColor text,
          $columnBodyTextColor text,
          $columnQAData text
          );
          ''');

      // Catalog
      await db.execute('''
          CREATE TABLE $tableItem (
          $columnItemId integer primary key autoincrement,
          $columnItemName text,
          $columnItemDes text,
          $columnItemIndex integer,
          $columnItemImage text,
          $columnCardId integer
          );
          ''');
    });
    return database;
  }

  Future<void> insertCard(CardModel cardModel) async {
    try {
      var db = await database;
      await db.insert(tableCard, cardModel.toJson());
      debugPrint('Insert card.');
    } catch (e) {
      debugPrint('Error on insert card.');
    }
  }

  Future<void> insertItem(ItemModel itemModel) async {
    try {
      var db = await database;
      print(itemModel.toJson());
      await db.insert(tableItem, itemModel.toJson());
      debugPrint('Insert item.');
    } catch (e) {
      debugPrint('Error on insert item.');
    }
  }

  Future<List<CardModel>> getCards() async {
    List<CardModel> cards = [];
    try {
      var db = await database;
      var result = await db.query(tableCard);
      for (var element in result) {
        var note = CardModel.fromJson(element);
        cards.add(note);
      }
      cards.sort((a, b) {
        return DateTime.parse(b.createdAt!)
            .compareTo(DateTime.parse(a.createdAt!));
      });
      debugPrint('Get transaction.');
    } catch (_) {
      debugPrint('Error on get transaction.');
    }
    return cards;
  }

  Future<List<ItemModel>> getItems() async {
    List<ItemModel> items = [];
    try {
      var db = await database;
      var result = await db.query(tableItem);
      for (var element in result) {
        var note = ItemModel.fromJson(element);
        items.add(note);
      }
      items.sort((a, b) => (a.index??0).compareTo(b.index??0));
      debugPrint('Get items.');
    } catch (e) {
      debugPrint('Error on get items.');
    }
    return items;
  }

  Future<int> updateCard(CardModel cardModel) async {
    try {
      var db = await database;
      var res = await db.update(
        tableCard,
        cardModel.toJson(),
        where: '$columnId = ?',
        whereArgs: [cardModel.id],
      );
      debugPrint('Update card.');
      return res;
    } catch (_) {
      debugPrint('Error on update card.');
    }
    return 0;
  }

  Future<int> deleteCard(int id) async {
    try {
      var db = await database;
      var res = await db
          .delete(tableCard, where: '$columnId = ?', whereArgs: [id]);
      debugPrint('Delete card.');
      return res;
    } catch (_) {
      debugPrint('Error on delete card.');
    }
    return 0;
  }

  Future<int> deleteItem(int id) async {
    try {
      var db = await database;
      var res = await db
          .delete(tableItem, where: '$columnId = ?', whereArgs: [id]);
      debugPrint('Delete item.');
      return res;
    } catch (_) {
      debugPrint('Error on delete item.');
    }
    return 0;
  }
}
