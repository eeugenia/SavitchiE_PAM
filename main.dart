import 'package:flutter/material.dart';
void main() {
  runApp(HospitalApp());
}
class HospitalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hospital Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HospitalPage(),
    );
  }
}
class HospitalPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}
class _HospitalPageState extends State<HospitalPage> {
  bool _showAllCategories = false;
  bool _showAllCenters = false;
// Variabila pentru dropdown-ul țării
  String _selectedCountry = 'România';
// Listele de opțiuni pentru țări
  final List<String> _countries = [
    'România',
    'Moldova',
    'Ungaria',
    'Bulgaria',
    'Italia',
    'Germania',
    'Franța'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        backgroundColor: Color(0xFF90CAF9),
      ),
      body: Container(
        color: Colors.lightBlue[50], // Fundalul paginii
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// Locația spitalului
                Text(
                  'Adresa:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
// Dropdown pentru selectarea țării
                Container(
                  width: 150, // Dimensiune mai mică
                  child: DropdownButtonFormField<String>(
                    value: _selectedCountry,
                    items: _countries.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCountry = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Selectează Țara',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 16),
// Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Căutare doctor sau specialitate',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 16),
// Banner
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/banner.jpg'),
// Asigură-te că ai imaginea în assets
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Looking for a specialist doctor?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
// Categorii de specialități
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categorii',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllCategories = !_showAllCategories;
                        });
                      },
                      child: Text(
                        _showAllCategories ? 'Show Less' : 'Show All',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
// GridView pentru categorii
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: _showAllCategories ? categories.length : 8,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: categories[index]['name']!,
                      imageUrl: categories[index]['image']!,
                    );
                  },
                ),
                SizedBox(height: 16),
// Lista de medici
                Text(
                  'Medici Prezenți',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DoctorCard(
                  name: 'Dr. Marin Popescu',
                  specialty: 'Stomatologie',
                  imageUrl: 'assets/doctor1.jpg',
                  center: 'Spitalul Universitar București',
                  rating: '4.7',
                  reviews: '100 recenzii',
                ),
                DoctorCard(
                  name: 'Dr. Ion Ionescu',
                  specialty: 'Cardiologie',
                  imageUrl: 'assets/doctor2.jpg',
                  center: 'Clinica Medlife',
                  rating: '4.5',
                  reviews: '80 recenzii',
                ),
                DoctorCard(
                  name: 'Dr. Ana Georgescu',
                  specialty: 'Pediatrie',
                  imageUrl: 'assets/doctor3.jpg',
                  center: 'Spitalul Colțea',
                  rating: '4.9',
                  reviews: '120 recenzii',
                ),
                SizedBox(height: 16),
// Centre medicale apropiate
                Text(
                  'Centre medicale apropiate',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
// Centru medicale apropiate
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
// Container pentru lista de centre medicale
                      SizedBox(
                        height: 400, // Mărire a înălțimii (ajustează după cum este necesar)
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              _showAllCenters ? nearbyCenters.length : 2,
                                  (index) {
                                return NearbyCenterCard(
                                  name: nearbyCenters[index]['name']!,
                                  location: nearbyCenters[index]['location']!,
                                  imageUrl: nearbyCenters[index]['image']!,
                                  rating: nearbyCenters[index]['rating']!,
                                  reviews: nearbyCenters[index]['reviews']!,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
// Butonul Show All pentru centre medicale
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showAllCenters = !_showAllCenters; // Schimbă starea
                          });
                        },
                        child: Text(
                          _showAllCenters ? 'Show Less' : 'Show All',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Listă de categorii cu nume și imagini
final List<Map<String, String>> categories = [
  {'name': 'Stomatologie', 'image': 'assets/stomatologie.jpg'},
  {'name': 'Cardiologie', 'image': 'assets/cardiologie.png'},
  {'name': 'Pediatrie', 'image': 'assets/pediatrie.png'},
  {'name': 'Neurologie', 'image': 'assets/neurologie.png'},
  {'name': 'Dermatologie', 'image': 'assets/dermatologie.png'},
  {'name': 'Oncologie', 'image': 'assets/oncologie.png'},
  {'name': 'Chirurgie', 'image': 'assets/chirurgie.png'},
  {'name': 'Ortopedie', 'image': 'assets/ortopedie.png'},
  {'name': 'Ginecologie', 'image': 'assets/ginecologie.png'},
  {'name': 'Psihiatrie', 'image': 'assets/psihiatrie.png'},
];
// Listă de centre medicale (exemple reale)
final List<Map<String, String>> nearbyCenters = [
  {
    'name': 'Spitalul Universitar București',
    'location': 'Str. Nicolae Cajal 1, București, România',
    'image': 'assets/bucuresti.jpg', // Asigură-te că ai imaginea corespunzătoare
    'rating': '4.3',
    'reviews': '250 recenzii',
  },
  {
    'name': 'Clinica Medlife',
    'location': 'Str. Popa Petre 24, București, România',
    'image': 'assets/medlife_clinic.jpg', // Asigură-te că ai imaginea corespunzătoare
    'rating': '4.5',
    'reviews': '150 recenzii',
  },
  {
    'name': 'Spitalul Colțea',
    'location': 'Bulevardul I.C. Brătianu 1, București, România',
    'image': 'assets/spital_coltea.jpg', // Asigură-te că ai imaginea corespunzătoare
    'rating': '4.8',
    'reviews': '300 recenzii',
  },
];
// Card pentru categorii
class CategoryCard extends StatelessWidget {
  final String category;
  final String imageUrl;
  const CategoryCard({required this.category, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            category,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
// Card pentru doctori
class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;
  final String center;
  final String rating;
  final String reviews;
  const DoctorCard({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.center,
    required this.rating,
    required this.reviews,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(specialty),
                Text(center),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[600]),
                    Text('$rating ($reviews)'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Card pentru centre medicale
class NearbyCenterCard extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;
  final String rating;
  final String reviews;
  const NearbyCenterCard({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(location),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.yellow[600]),
                Text('$rating ($reviews)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
