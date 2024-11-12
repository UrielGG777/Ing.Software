import 'package:flutter/material.dart';
import 'package:flutter_application_1/Detalles%20cliente/ProviderDetailsScreen.dart';
import 'package:flutter_application_1/realease_Provider.dart';
import 'package:hexcolor/hexcolor.dart';

class SeeSupplier extends StatefulWidget {
  final List<Map<String, String>> providers;

  const SeeSupplier({
    Key? key,
    required this.providers,
  }) : super(key: key);

  @override
  State<SeeSupplier> createState() => _SeeSupplierState();
}

class _SeeSupplierState extends State<SeeSupplier> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8470A1),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2740),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Proveedores',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            buildSearchContainer(),
            buildContentContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchContainer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF463D5E),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    hintText: 'Buscar Proveedor',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    setState(() {
                      _searchText = text;
                    });
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.search, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContentContainer() {
    List<Map<String, String>> filteredProviders = widget.providers
        .where((provider) => provider['Nombre']!
            .toLowerCase()
            .contains(_searchText.toLowerCase()))
        .toList();

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2F2740),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            if (_searchText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Resultado para "$_searchText"',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Expanded(
              child: filteredProviders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.white, size: 50),
                          const SizedBox(height: 10),
                          Text(
                            'No hay proveedores',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: filteredProviders.length,
                      itemBuilder: (context, index) {
                        final provider = filteredProviders[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: HexColor('#E6E0F8'),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: ListTile(
                            title: Text(
                              provider['Nombre'] ?? '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              provider['Representante'] ?? '',
                              style: const TextStyle(color: Colors.black87),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Providerdetailsscreen(
                                      providers: filteredProviders[index]),
                                ),
                              );
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Release_Provider(
                                          providers: filteredProviders[index],
                                          onSave: (updatedProviderData) {
                                            setState(() {
                                              // Locate the correct index in widget.providers based on a unique field
                                              int originalIndex = widget
                                                  .providers
                                                  .indexWhere((provider) =>
                                                      provider[
                                                          'Correo Electronico'] ==
                                                      filteredProviders[index][
                                                          'Correo Electronico']);
                                              if (originalIndex != -1) {
                                                // Update the provider at the located index
                                                widget.providers[
                                                        originalIndex] =
                                                    updatedProviderData;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      widget.providers.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
