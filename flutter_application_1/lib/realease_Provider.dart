import 'package:flutter/material.dart';

class Release_Provider extends StatefulWidget {
  final Function(Map<String, String>) onSave;
  final Map<String, String>? providers;

  Release_Provider({required this.onSave, this.providers});

  @override
  _ReleaseProviderState createState() => _ReleaseProviderState();
}

class _ReleaseProviderState extends State<Release_Provider> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _representativeController =
      TextEditingController();
  final TextEditingController _rfcController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing data if available
    if (widget.providers != null) {
      _nameController.text = widget.providers!['Nombre'] ?? '';
      _representativeController.text = widget.providers!['Representante'] ?? '';
      _rfcController.text = widget.providers!['RFC'] ?? '';
      _addressController.text = widget.providers!['Direccion'] ?? '';
      _phoneController.text = widget.providers!['Telefono'] ?? '';
      _emailController.text = widget.providers!['Correo Electronico'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8470A1),
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            widget.providers == null
                ? 'Registro Proveedor'
                : 'Modificar Proveedor',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget buildFormContainer() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2F2740),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              buildTextField(_nameController, 'Nombre Proveedor'),
              buildTextField(_representativeController, 'Representante'),
              buildTextField(_rfcController, 'RFC'),
              buildTextField(_addressController, 'Direccion'),
              buildTextField(_phoneController, 'Telefono'),
              buildTextField(_emailController, 'Correo'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF463D5E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                child: Text(
                  widget.providers == null ? 'Registrar' : 'Guardar Cambios',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Campo de texto personalizado
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
    final providerData = {
      'Nombre': _nameController.text,
      'Representante': _representativeController.text,
      'RFC': _rfcController.text,
      'Direccion': _addressController.text,
      'Telefono': _phoneController.text,
      'Correo Electronico': _emailController.text,
    };

    widget.onSave(providerData);
    Navigator.pop(context);
  }
}
