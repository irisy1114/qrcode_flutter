// import 'package:flutter/material.dart';
// import 'package:qrcode_flutter/generator.dart';
// import 'package:qrcode_flutter/model/qrcode.dart';
// import 'database_helper.dart';

// class  History extends StatefulWidget {
//   // final QRCode? qrCode;

//   // const History({Key? key, this.qrCode}) : super(key: key);

//   @override
//   State<History> createState() => HistoryState();
// }

// class HistoryState extends State<History> {  
//   @override
//   Widget build(BuildContext context) {
//     // var appState = context.watch<MyAppState>();
//     // var list = appState.history;
//     // if (list.isEmpty) {
//       return Scaffold( 
//         appBar: AppBar(
//           title: const Text("History List"),
//           backgroundColor: Color.fromARGB(255, 168, 224, 170),),       
//         body: FutureBuilder<List<QRCode>>(
//         future: DatabaseHelper.instance.retrieveQrcodes(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data?.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(snapshot.data![index].text),
//                   // leading: Text(snapshot.data[index].id.toString()),
//                   // subtitle: Text(snapshot.data[index].content),
//                   onTap: () => _navigateToDetail(context, snapshot.data![index]),
//                   trailing: IconButton(
//                       alignment: Alignment.center,
//                       icon: Icon(Icons.delete),
//                       onPressed: () async {
//                         _deleteQrcode(snapshot.data![index]);
//                         setState(() {});
//                       }),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text("Oops!");
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       )
//     );
    

//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: const Text("History List"),
//     //     backgroundColor: Color.fromARGB(255, 168, 224, 170),),
//     //     body: ListView.builder(
//     //     itemCount: list.length,
//     //     prototypeItem: ListTile(
//     //       title: Text(list.first),
//     //     ),
//     //     itemBuilder: (context, index) {
//     //       return ListTile(
//     //         leading: Icon(Icons.qr_code),
//     //         title: Text(list[index]),
//     //       );
//     //     },
//     //   )
//     // );
//   }
// }

// _deleteQrcode(QRCode qrCode) {
//   DatabaseHelper.instance.deleteQrcode(qrCode.id);
// }

// _navigateToDetail(BuildContext context, QRCode qrCode) async {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => Generator(qrCode: qrCode)),
//   );
// }