import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import './screens/welcome_screen.dart';
import './screens/sign_in_screen.dart';
import './screens/sign_up_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.blue,
        primaryColor: Colors.grey[700],
        
        // backgroundColor: const Color.fromARGB(0xff, 0x33, 0x33, 0x33),
        backgroundColor: const Color.fromARGB(0xff, 0x1D, 0x19, 0x19),
        // backgroundColor: Colors.black87,
        fontFamily: 'roboto',
        textTheme: _themeData.textTheme.copyWith(
          bodyText1: TextStyle(
            fontFamily: 'oswald',
            fontSize: 38,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          button: TextStyle(
            fontFamily: 'archivo_narrow',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24,
          ),
          
        ).apply(
          // bodyColor: Colors.white,
          // displayColor: Colors.white,
        ),
      ),
      home: WelcomeScreen(),
      routes:{
        SignInScreen.routeName: (ctx)=>SignInScreen(),
        SignUpScreen.routeName: (ctx)=>SignUpScreen(),
      }
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text("firebase"),
      //   ),
      //   body: Column(
      //     children: <Widget>[
      //       Expanded(
      //         child: Center(
      //           child: StreamBuilder(
      //               stream: Firestore.instance
      //                   .collection('/chats/Vfw3kIGOAGdutqA5kC15/message')
      //                   .snapshots(),
      //               builder: (ctx, streamSnapshot) {
      //                 if (streamSnapshot.connectionState ==
      //                     ConnectionState.waiting)
      //                   return CircularProgressIndicator();

      //                 final _document = streamSnapshot.data.documents;
      //                 return ListView.builder(
      //                   itemCount: _document.length,
      //                   itemBuilder: (ctx, index) => Center(
      //                     child: Text(
      //                       _document[index]['text'],
      //                     ),
      //                   ),
      //                 );
      //               }),
      //         ),
      //       ),
      //       FloatingActionButton(
      //           child: Icon(Icons.add),
      //           onPressed: () {
      //             Firestore.instance
      //                 .collection('/chats/Vfw3kIGOAGdutqA5kC15/message')
      //                 .add({'text': "New Message Added"});
      //           }),
      //     ],
      //   ),
      // ),
    );
  }
}
