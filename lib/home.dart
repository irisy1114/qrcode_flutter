// import 'package:flutter/material.dart';

// import 'generator.dart';
// import 'history.dart';
// import 'scanner.dart';

// class Home extends StatefulWidget {  
//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//     var selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     Widget page;
//     switch (selectedIndex) {
//       case 0:
//         page = Generator();
//         break;
//       case 1:
//         page = Scanner();
//         break;
//       case 2:
//         page = History();
//         break;
//       default:
//         throw UnimplementedError('no widget for $selectedIndex');
//     }
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scaffold(
//           backgroundColor: Color.fromARGB(255, 240, 247, 240),
//           body: Row(            
//             children: [
//               SafeArea(                
//                 child: NavigationRail(
//                   backgroundColor:Color.fromARGB(255, 240, 247, 240),
//                   extended: constraints.maxWidth >= 600,
//                   destinations: [
//                     NavigationRailDestination(
//                       icon: Icon(Icons.home),
//                       label: Text('Generator'),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(Icons.qr_code_scanner),
//                       label: Text('Scanner'),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(Icons.history),
//                       label: Text('History'),
//                     ),
//                   ],
//                   selectedIndex: selectedIndex,
//                   onDestinationSelected: (value) {
//                     setState(() {
//                       selectedIndex = value;
//                     });                
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: Theme.of(context).colorScheme.onPrimaryContainer,
//                   child: page,
//                 ),
//               ),
//             ],
//           ),           
//         );
//       }    
//     );
//   }
// }