
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb{
  static Database? _db ;

  Future<Database?> get db async {
    if (_db == null){
      _db  = await intialDb() ;
      return _db ;
    }else {
      return _db ;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath() ;
    String path = join(databasepath , 'mohamed.db') ;
    Database mydb = await openDatabase(path , onCreate: _onCreate , version: 1  , onUpgrade:_onUpgrade ) ;
    return mydb ;
  }

  _onUpgrade(Database db , int oldversion , int newversion ) {

    print("onUpgrade =====================================") ;

  }

  _onCreate(Database db , int version) async
  {
    await db.execute('CREATE TABLE register ("id" INTEGER PRIMARY KEY, "name" TEXT ,"email" TEXT ,"university" TEXT ,"faculty" TEXT ,  "phone" INTEGER, "password" INTEGER)') ;
    print(" onCreate =====================================") ;

  }

  readData(String sql) async {
    Database? mydb = await db ;
    List<Map> response = await  mydb!.rawQuery(sql);
    return response ;
  }

  insertData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawInsert(sql);
    return response ;
  }

  updateData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawUpdate(sql);
    return response ;
  }

  deleteData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawDelete(sql);
    return response ;
  }

}