import 'package:sqflite/sqflite.dart' as sqflite;

class Database {

  var db = null as sqflite.Database;

  void generateDatabase() async {
    var dbPath = await sqflite.getDatabasesPath();
    String path = dbPath+"database.db";

    sqflite.deleteDatabase(path);
    db = await sqflite.openDatabase(path);
    await db.execute("CREATE TABLE Pictures(id INTEGER PRIMARY KEY, name TEXT);");
    await db.execute("CREATE UNIQUE INDEX id ON Pictures(id);");

    var urls = ["https://images.pexels.com/photos/1000445/pexels-photo-1000445.jpeg",
                "https://images.pexels.com/photos/208165/pexels-photo-208165.jpeg",
                "https://images.pexels.com/photos/12211/pexels-photo-12211.jpeg"];

    var executeString = "" as String;
    urls.forEach((f)=>(var s){
      executeString+="("+s+"),";
    });
    executeString = executeString.substring(0,executeString.length-1);

    await db.execute("INSERT INTO Pictures(name) VALUES"+executeString+";");
  }

  dynamic getPicFromIndex(var index) async{
    var retVal = "" as String;
    db.rawQuery("SELECT name FROM Picture WHERE id ="+(index+1)).then((f)=>(var f){
      retVal = f[0][f[0].keys.toList()[0]].toString();
    });
    return retVal;
  }

}