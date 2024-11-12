import 'package:flutter/material.dart';
import 'package:flutter_application_1/Detalles%20cliente/ClientDetailsScreen.dart';
import 'package:flutter_application_1/disable_Client.dart';
import 'package:flutter_application_1/disable_Supplier.dart';
import 'package:flutter_application_1/realease_Provider.dart';
import 'package:flutter_application_1/release_Client.dart';
import 'package:flutter_application_1/see_Supplier.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({super.key});

  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  List<Map<String, String>> clients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8470A1),
      drawer: buildNavigationDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF2F2740),
        title: Text(
          "Principal",
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
      bottomNavigationBar: buildCurvedBottomNavigationBar(),
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
                    hintText: 'Buscar Cliente',
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
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.search, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContentContainer() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF2F2740),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _searchText.isNotEmpty
                  ? Text(
                      'Resultados para "$_searchText"',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      '',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
              const SizedBox(height: 16),
              Expanded(
                child: _buildClientList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _filterClients() {
    if (_searchText.isEmpty) {
      return clients;
    } else {
      return clients
          .where((client) =>
              client['Nombre']!
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()) ||
              client['Correo Electronico']!
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()))
          .toList();
    }
  }

  Widget _buildClientList(BuildContext context) {
    List<Map<String, String>> filteredClients = _filterClients();

    if (filteredClients.isEmpty) {
      return Center(
          child:
              Text('No hay clientes', style: TextStyle(color: Colors.white)));
    } else {
      return ListView.builder(
        itemCount: filteredClients.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: HexColor('#E6E0F8'),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListTile(
              title: Text(filteredClients[index]['Nombre']!,
                  style: TextStyle(color: Colors.black)),
              subtitle: Text(filteredClients[index]['Correo Electronico']!,
                  style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClientDetailsScreen(client: filteredClients[index]),
                  ),
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: () async {
                      final updatedClient = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Release_Client(
                            client: filteredClients[index],
                            onSave: (updatedClientData) {
                              setState(() {
                                int originalIndex = clients.indexWhere(
                                    (client) =>
                                        client['Correo Electronico'] ==
                                        filteredClients[index]
                                            ['Correo Electronico']);
                                clients[originalIndex] = updatedClientData;
                              });
                            },
                          ),
                        ),
                      );

                      if (updatedClient != null &&
                          updatedClient is Map<String, String>) {
                        setState(() {
                          int originalIndex = clients.indexWhere((client) =>
                              client['Correo Electronico'] ==
                              filteredClients[index]['Correo Electronico']);
                          clients[originalIndex] = updatedClient;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        clients.removeWhere((client) =>
                            client['Correo Electronico'] ==
                            filteredClients[index]['Correo Electronico']);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget buildCurvedBottomNavigationBar() {
    return ClipPath(
      clipper: BottomNavClipper(),
      child: Container(
        color: const Color(0xFF2F2740),
        height: 72,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.person, size: 28),
              ),
              label: 'Altas Clientes',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.group, size: 28),
              ),
              label: 'Altas Proveedor',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.chat_bubble_outline, size: 28),
              ),
              label: '',
            ),
          ],
          onTap: (index) async {
            if (index == 0) {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Release_Client(onSave: addClient)),
              );

              if (result != null && result is Map<String, String>) {
                setState(() {
                  clients.add(result);
                });
              }
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Release_Provider()),
              );
            }
          },
        ),
      ),
    );
  }

  void addClient(Map<String, String> clientData) {
    setState(() {
      clients.add(clientData);
    });
  }

  Widget buildNavigationDrawer() {
    return Drawer(
      child: Container(
        color: Color(0xFF2F2740),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF463D5E),
              ),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_box_sharp, color: Colors.white),
              title: Text('Proveedores', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SeeSupplier()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person_off_rounded, color: Colors.white),
              title: Text('Proveedores inhabilitados',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DisableSupplier()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person_off, color: Colors.white),
              title: Text('Clientes inhabilitados',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DisableClient()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 20);
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 0);
    path.quadraticBezierTo(3 * size.width / 4, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
