import 'package:flutter/material.dart';

class Providerdetailsscreen extends StatelessWidget {
  final Map<String, String> providers;

  const Providerdetailsscreen({Key? key, required this.providers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8470A1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Detalles del Proveedor',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2F2740),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF2F2740), // Fondo de la caja
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: providers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}