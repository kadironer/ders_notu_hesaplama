import 'package:flutter/material.dart';
import 'package:proje_ders_notu_hesaplama/main.dart';
import 'package:proje_ders_notu_hesaplama/notlar.dart';
import 'package:proje_ders_notu_hesaplama/notlardao.dart';

class NoteDetailsPage extends StatefulWidget {

  Notlar not;
  NoteDetailsPage({Key? key, required this.not}) : super(key: key);

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {

  var tfDers=TextEditingController();
  var tfNot1=TextEditingController();
  var tfNot2=TextEditingController();

  Future<void> notSil(int not_id) async{
    await Notlardao().notSil(not_id);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));

  }

  Future<void> notGuncelle(int not_id, String ders_adi, int not1, int not2) async{
    await Notlardao().notGuncelle(not_id, ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));

  }

  @override
  void initState() {
    var not=widget.not;
    tfDers.text=not.ders_adi;
    tfNot1.text=not.not1.toString();
    tfNot2.text=not.not2.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notlar Detay"),
        actions: [
         TextButton(
           child: Text("Sil", style: TextStyle(color: Colors.black),),
           onPressed:(){

             notSil(widget.not.not_id);
           },
         ),
          TextButton(
            child: Text("Güncelle", style: TextStyle(color: Colors.black),),
            onPressed:(){
              notGuncelle(widget.not.not_id, tfDers.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 315,
              height: 50,
              child: TextField(
                controller: tfDers,
                decoration: InputDecoration(
                  labelText: "Ders Adı",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            SizedBox(
              width: 315,
              height: 50,
              child: TextField(
                controller: tfNot1,
                decoration: InputDecoration(
                  labelText: "Not1",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            SizedBox(
              width: 315,
              height: 50,
              child: TextField(
                controller: tfNot2,
                decoration: InputDecoration(
                  labelText: "Not2",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
