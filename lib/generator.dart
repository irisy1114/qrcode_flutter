// import 'package:barcode_widget/barcode_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// // import 'package:qrcode_flutter/database_helper.dart';
// import '../model/qrcode.dart';
// import 'database_helper.dart';

// class Generator extends StatefulWidget {
//   final QRCode? qrCode;

//   const Generator({Key? key, this.qrCode}) : super(key: key);
  
//   @override
//   State<Generator> createState() => _GeneratorState();
// }

// class _GeneratorState extends State<Generator> {
//   TextEditingController title = TextEditingController();
//   // TextEditingController content = TextEditingController();
//   QRCode? qrCode;
//   // var image = '';
//   // File? file;

//   // _GeneratorState({required this.qrCode});

//   @override
//   void initState() {
//     super.initState();
//     if(qrCode != null) {
//       title.text = qrCode!.text;
//     }    
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     title.dispose();
//     // titleTextController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var appState = context.watch<MyAppState>();
//     return Scaffold(            
//       body: Center(
//         child: SingleChildScrollView(          
//           child: Column(                       
//             children: [              
//               Padding(
//                 padding: EdgeInsets.all(35),
//                 child: Container(
//                   decoration: BoxDecoration(border: Border.all()),
//                   child: TextFormField(
//                     controller: title,
//                     textAlign: TextAlign.center,
//                     decoration: const InputDecoration(
//                     hintText: 'Enter data ',
//                     ),
//                   ),
//                 ),
//               ),
//               MaterialButton(
//                 color: Color.fromARGB(255, 33, 158, 79),
//                 onPressed: () async {
//                   saveQrcode(title.text);
//                   setState(() {});

//                   // setState(() {
//                     // input = title.text; 
//                     // appState.toggleHistory(input);           

//                   // });
//                 },
//                 child: Text(
//                   "Generate QR Code",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               SizedBox(height:20),
//               qrCode == Object()
//                   ? Text('')
//                   : BarcodeWidget(
//                       barcode: Barcode.qrCode(
//                         errorCorrectLevel: BarcodeQRCorrectionLevel.high,
//                       ),
//                       data: qrCode!.text,
//                       width: 200,
//                       height: 200,   
//                       margin: EdgeInsets.only(bottom: (30)),                     
//                   ),          
//               qrCode == Object() ? Text('') : 
//                 Text("QR Code generated at ${DateFormat('yyyy-MM-dd-kk:mm:ss').format(DateTime.now())}")            
//             ],                    
//           ),          
//         ),
//       ),
//     );
//   }

//   saveQrcode(String text) async {
//     if(qrCode == null) {
//       DatabaseHelper.instance.insertQrcode(QRCode(
//         id: 1,
//         text: text
//         ));
//     } else {
//       await DatabaseHelper.instance.updateQrcode(QRCode(
//         id: qrCode!.id, 
//         text: text
//       ));
//       // Navigator.pop(context);
//     }
//   }
// }