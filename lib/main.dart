import 'package:provider/provider.dart';

import 'scanner.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'QR Code App',
//         theme: ThemeData(
//           useMaterial3: true,
//           colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 240, 247, 240)),
//         ),
//         home: Home(),
//       );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'QR Code App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 240, 247, 240)),
        ),
        home: Home(),
      )
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = '';
  var history = <String>[];
  void toggleHistory(var text) {
    current = text;
    if (history.contains(current)) {
      return;
    } else {
      history.add(current);
    }
    notifyListeners();
  }

  void removeHistory(var text) {
    if (history.contains(text)) {
      history.remove(text);
    }
    notifyListeners();
  }

}

class Home extends StatefulWidget {  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Generator();
        break;
      case 1:
        page = Scanner();
        break;
      case 2:
        page = History();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 240, 247, 240),
          body: Row(            
            children: [
              SafeArea(                
                child: NavigationRail(
                  backgroundColor:Color.fromARGB(255, 240, 247, 240),
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Generator'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.qr_code_scanner),
                      label: Text('Scanner'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.history),
                      label: Text('History'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });                
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  child: page,
                ),
              ),
            ],
          ),           
        );
      }    
    );
  }
}

class Generator extends StatefulWidget {
  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  var input = '';
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(            
      body: Center(
        child: SingleChildScrollView(          
          child: Column(                       
            children: [              
              Padding(
                padding: EdgeInsets.all(35),
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextFormField(
                    controller: title,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                    hintText: 'Enter data ',
                    ),
                  ),
                ),
              ),
              MaterialButton(
                color: Color.fromARGB(255, 33, 158, 79),
                onPressed: () {
                  setState(() {
                    input = title.text; 
                    appState.toggleHistory(input);           

                  });
                },
                child: Text(
                  "Generate QR Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height:20),
              input == '' ? Text('') : 
                BarcodeWidget(
                  barcode: Barcode.qrCode(
                    errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                  ),
                  data: input,
                  width: 200,
                  height: 200,           
                  margin: EdgeInsets.only(bottom: (30)),                                        
                  ),
              input == '' ? Text('') : 
                Text("QR Code generated at ${DateFormat('yyyy-MM-dd-kk:mm:ss').format(DateTime.now())}")              
            ],            
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var list = appState.history;
    if (list.isEmpty) {
      return Scaffold( 
        appBar: AppBar(
          title: const Text("History List"),
          backgroundColor: Color.fromARGB(255, 168, 224, 170),),       
        body: Text('No history yet.') 
        );
    }

    list.sort((a, b) => a.compareTo(b));
    return Scaffold(
      appBar: AppBar(
        title: const Text("History List"),
        backgroundColor: Color.fromARGB(255, 168, 224, 170),),
        body: ListView.builder(
        itemCount: list.length,
        prototypeItem: ListTile(
          title: Text(list.first),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.qr_code),
            title: Text(list[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.preview_outlined,
                    size: 20.0,
                    color: Color.fromARGB(255, 28, 134, 72),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context, barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('QR code for ${list[index]}:'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                SizedBox(height: 20),
                                BarcodeWidget(                      
                                barcode: Barcode.qrCode(errorCorrectLevel: BarcodeQRCorrectionLevel.high,),                  
                                data: list[index],
                                width: 200,
                                height: 150,                                                                      
                                )
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );                                   
                  },                    
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20.0,
                    color: Color.fromARGB(255, 156, 36, 15),
                  ),
                  onPressed: () {
                    appState.removeHistory(list[index]);
                  },
                ),                
              ],
            ), 
          );
        },
      )
    );
  }
}
