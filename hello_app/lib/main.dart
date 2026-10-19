import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Proba',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Hello world!',
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Caveat',
            color: Colors.blue[600],
          ),
        ),
        
      )
    ),
  ));
}