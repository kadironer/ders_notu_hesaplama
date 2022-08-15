import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proje_ders_notu_hesaplama/noteDetailScreen.dart';
import 'package:proje_ders_notu_hesaplama/noteRecordScreen.dart';
import 'package:proje_ders_notu_hesaplama/notlar.dart';
import 'package:proje_ders_notu_hesaplama/notlardao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ders Notu Hesapla',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Notlar>> tumNotlarGoster() async{
    var notlarListesi= await Notlardao().tumNotlar();

    return notlarListesi;
  }
  Future<bool> appExit() async{
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed:(){
            appExit();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notlar Uygulaması",),
            FutureBuilder<List<Notlar>>(
              future: tumNotlarGoster(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var notlarListesi=snapshot.data;
                  double ortalama=0.0;
                  if(!notlarListesi!.isEmpty){
                    double toplam=0.0;
                    for(var n in notlarListesi){
                      toplam=toplam+(n.not1+ n.not2)/2;
                    }
                    ortalama= toplam/notlarListesi.length;
                  }
                  return Text("Ortalama: $ortalama",style: TextStyle(fontSize: 15),);

                }else{
                  return Text("Ortalama: ", style: TextStyle(fontSize: 15),);
                }
              },
            ),
          ],
        ),
      ),
      body:WillPopScope(
        onWillPop: appExit,
        child: FutureBuilder<List<Notlar>>(
          future:tumNotlarGoster(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var notlarListesi=snapshot.data;
              return ListView.builder(
                itemCount: notlarListesi!.length,
                itemBuilder: (context,indeks){
                  var not=notlarListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteDetailsPage(not: not,)));
                    },
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(not.ders_adi,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(not.not1.toString(),),
                            Text(not.not2.toString(),),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center();
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteRecordPage()));
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
