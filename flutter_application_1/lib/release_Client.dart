import 'package:flutter/material.dart';

class Release_Client extends StatefulWidget {
  final Function(Map<String, String>) onSave;
  final Map<String, String>? client;

  Release_Client({required this.onSave, this.client});

  @override
  _ReleaseClientState createState() => _ReleaseClientState();
}

class _ReleaseClientState extends State<Release_Client> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _representativeController =
      TextEditingController();
  final TextEditingController _rfcController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _nameController.text = widget.client!['name'] ?? '';
      _emailController.text = widget.client!['email'] ?? '';
      _representativeController.text = widget.client!['representative'] ?? '';
      _rfcController.text = widget.client!['rfc'] ?? '';
      _addressController.text = widget.client!['address'] ?? '';
      _phoneController.text = widget.client!['phone'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8470A1),
      body: SafeArea(
        child: Column(
          children: [
            buildTitle(context),
            buildFormContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            widget.client == null
                ? 'Registro de Clientes'
                : 'Modificar Cliente',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget buildFormContainer() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF2F2740),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              buildTextField(_nameController, 'Nombre del Cliente'),
              buildTextField(_representativeController, 'Representante'),
              buildTextField(_rfcController, 'RFC'),
              buildTextField(_addressController, 'Dirección'),
              buildTextField(_phoneController, 'Teléfono'),
              buildTextField(_emailController, 'Correo Electrónico'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF463D5E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  widget.client == null ? 'Registrar' : 'Guardar Cambios',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Color(0xFF463D5E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void submitForm() {
    final clientData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'representative': _representativeController.text,
      'rfc': _rfcController.text,
      'address': _addressController.text,
      'phone': _phoneController.text,
    };
    widget.onSave(clientData);
    Navigator.pop(context);
  }
}
