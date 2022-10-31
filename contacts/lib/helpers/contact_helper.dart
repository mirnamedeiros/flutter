
import 'package:sqflite/sqflite.dart';

class ContactHelper{
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal;

  Database? _db;

  Future<Database> get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    if (databasesPath == null) databasesPath = "";
    String path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE ${Contact.contactTable}(${Contact.idColumn} INTEGER PRIMARY KEY,"
        "                                     ${Contact.nameColumn} TEXT, "
        "                                     ${Contact.emailColumn} TEXT,"
        "                                     ${Contact.phoneColumn} TEXT,"
        "                                     ${Contact.imgColumn} TEXT");
      });
  }

  Future<Contact> saveContact(Contact c) async {
    Database? dbContact = await db;
    if (dbContact != null)
      c.id = await dbContact.insert(Contact.contactTable, c.toMap());
    return c;
  }

  Future<Contact> getContact(int id) async {
    Database? dbContact = await db;
    if (dbContact != null) {
      List<Map>
    }
  }
}