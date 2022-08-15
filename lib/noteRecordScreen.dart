import 'package:flutter/material.dart';
import 'package:proje_ders_notu_hesaplama/main.dart';
import 'package:proje_ders_notu_hesaplama/notlardao.dart';

class NoteRecordPage extends StatefulWidget {
  const NoteRecordPage({Key? key}) : super(key: key);

  @override
  State<NoteRecordPage> createState() => _NoteRecordPageState();
}

class _NoteRecordPageState extends State<NoteRecordPage> {

  var tfDers=TextEditingController();
  var tfNot1=TextEditingController();
  var tfNot2=TextEditingController();

  Future<void> dersKayit(String ders_adi, int not1, int not2) async{
    await Notlardao().notEkle(ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notlar Kayıt"),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          dersKayit(tfDers.text,int.parse(tfNot1.text), int.parse(tfNot2.text));
        },
        tooltip: 'Kaydet',
        label: Text("Kaydet"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
