import 'package:proje_ders_notu_hesaplama/notlar.dart';
import 'package:proje_ders_notu_hesaplama/veritabaniErisim.dart';

class Notlardao{
  Future<List<Notlar>> tumNotlar() async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps= await db.rawQuery("SELECT * FROM notlar");
    return List.generate(maps.length, (index){
      var satir=maps[index];
      return Notlar(satir["not_id"], satir["ders_adi"], satir["not1"], satir["not2"]);

    });
  }


}