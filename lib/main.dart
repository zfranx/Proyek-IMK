import 'package:flutter/material.dart';
import 'package:projek_gede/rinci.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Etalase Produk',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: ProductShowcase(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Etalase',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Riwayat & Transaksi',
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ProductShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2, // Set the number of rows per page (2 products per row).
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Expanded(
              child: ProductItem(
                image: 'pisang 1.jpg',
                title: 'Pisang coklat',
                description: 'Pisang Goreng Enak',
                price: 'Rp 10.000',
              ),
            ),
            Expanded(
              child: ProductItem(
                image: 'pisang2.jpg',
                title: 'Pisang Goreng Keju',
                description: 'Description for Product 2',
                price: 'Rp 20.000',
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;

  ProductItem({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            print("ki");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Rincian(),
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/$image', // Assuming images are in the "assets" directory
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(description),
                    Text(
                      'Price: $price',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
