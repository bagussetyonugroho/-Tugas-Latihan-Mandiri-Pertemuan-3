
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================= APLIKASI UTAMA =================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bagus Store',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF4F7FC),
      ),

      home: const MainPage(),

      // LATIHAN 3: NAMED ROUTES
      routes: {
        '/beranda': (context) => const BerandaPage(),
        '/tentang': (context) => const TentangPage(),
        '/profil': (context) => const ProfilPage(),
      },

      // NAMED ROUTE DENGAN ARGUMEN
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final data = settings.arguments as Map<String, dynamic>;

          return MaterialPageRoute(
            builder: (context) => DetailPage(
              nama: data['nama'],
              harga: data['harga'],
              gambar: data['gambar'] ?? '',
            ),
          );
        }

        return null;
      },
    );
  }
}

// ================= BOTTOM NAVIGATION =================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final pages = const [
    BerandaPage(),
    CariPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages,
      ),

      // BONUS: BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        onTap: (value) {
          setState(() {
            index = value;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// ================= BERANDA =================

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bagus Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag,
                size: 100,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Temukan produk terbaik di Bagus Store.',
              ),

              const SizedBox(height: 25),

              // LATIHAN 1: PUSH
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TentangPage(),
                    ),
                  );
                },
                child: const Text('Halaman Tentang'),
              ),

              // LATIHAN 3: NAMED ROUTE
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profil');
                },
                child: const Text('Halaman Profil'),
              ),

              // NAMED ROUTE DENGAN ARGUMEN
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: {
                      'nama': 'Laptop',
                      'harga': 7500000,
                      'gambar': '',
                    },
                  );
                },
                child: const Text('Coba Named Route'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= TENTANG =================

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag,
                size: 80,
                color: Colors.orange,
              ),

              const SizedBox(height: 20),

              const Text(
                'Bagus Store',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Aplikasi toko sederhana untuk menampilkan '
                    'daftar produk, harga, dan detail produk.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              // LATIHAN 1: POP
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= DAFTAR PRODUK =================

class CariPage extends StatefulWidget {
  const CariPage({super.key});

  @override
  State<CariPage> createState() => _CariPageState();
}

class _CariPageState extends State<CariPage> {

  // DATA PRODUK
  final List<Map<String, dynamic>> produk = [
    {
      'nama': 'Laptop',
      'harga': 7500000,
      'gambar': '',
    },
    {
      'nama': 'Smartphone',
      'harga': 3500000,
      'gambar': '',
    },
    {
      'nama': 'Headphone',
      'harga': 500000,
      'gambar': '',
    },
  ];

  // ================= TAMBAH PRODUK =================

  void tambahProduk() {
    final namaController = TextEditingController();
    final hargaController = TextEditingController();
    final gambarController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Produk'),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // INPUT NAMA
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Produk',
                    hintText: 'Masukkan nama produk',
                    prefixIcon: Icon(Icons.shopping_bag),
                  ),
                ),

                const SizedBox(height: 10),

                // INPUT HARGA
                TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Harga Produk',
                    hintText: 'Masukkan harga produk',
                    prefixIcon: Icon(Icons.money),
                  ),
                ),

                const SizedBox(height: 10),

                // INPUT URL GAMBAR
                TextField(
                  controller: gambarController,
                  decoration: const InputDecoration(
                    labelText: 'URL Gambar',
                    hintText: 'https://...',
                    prefixIcon: Icon(Icons.image),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Masukkan link gambar produk.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          actions: [
            // TOMBOL BATAL
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),

            // TOMBOL TAMBAH
            ElevatedButton(
              onPressed: () {
                final nama = namaController.text.trim();

                final harga = int.tryParse(
                  hargaController.text,
                );

                final gambar = gambarController.text.trim();

                // VALIDASI
                if (nama.isNotEmpty &&
                    harga != null &&
                    harga > 0) {

                  setState(() {
                    produk.add({
                      'nama': nama,
                      'harga': harga,
                      'gambar': gambar,
                    });
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Produk berhasil ditambahkan',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Masukkan nama dan harga yang benar',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    ).then((_) {
      namaController.dispose();
      hargaController.dispose();
      gambarController.dispose();
    });
  }

  // ================= TAMPILAN PRODUK =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Produk',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // LIST PRODUK
      body: produk.isEmpty
          ? const Center(
        child: Text('Belum ada produk'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: produk.length,

        itemBuilder: (context, index) {
          final item = produk[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 10),

            child: ListTile(
              // GAMBAR PRODUK
              leading: gambarProduk(item['gambar']),

              // NAMA PRODUK
              title: Text(
                item['nama'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              // HARGA PRODUK
              subtitle: Text(
                'Rp ${item['harga']}',
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),

              // LATIHAN 2: KIRIM DATA
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      nama: item['nama'],
                      harga: item['harga'],
                      gambar: item['gambar'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),

      // TOMBOL PLUS
      floatingActionButton: FloatingActionButton(
        onPressed: tambahProduk,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ================= GAMBAR PRODUK =================

Widget gambarProduk(String? url) {
  if (url == null || url.isEmpty) {
    return const CircleAvatar(
      backgroundColor: Color(0xFFE3F2FD),
      child: Icon(
        Icons.shopping_bag,
        color: Colors.blue,
      ),
    );
  }

  return Image.network(
    url,
    width: 50,
    height: 50,
    fit: BoxFit.cover,

    errorBuilder: (context, error, stackTrace) {
      return const CircleAvatar(
        backgroundColor: Color(0xFFE3F2FD),
        child: Icon(
          Icons.image_not_supported,
          color: Colors.blue,
        ),
      );
    },
  );
}

// ================= DETAIL PRODUK =================

class DetailPage extends StatelessWidget {
  final String nama;
  final int harga;
  final String gambar;

  const DetailPage({
    super.key,
    required this.nama,
    required this.harga,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Card(
          margin: const EdgeInsets.all(25),

          child: Padding(
            padding: const EdgeInsets.all(30),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // GAMBAR DETAIL
                if (gambar.isNotEmpty)
                  Image.network(
                    gambar,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.shopping_bag,
                        size: 80,
                        color: Colors.blue,
                      );
                    },
                  )
                else
                  const Icon(
                    Icons.shopping_bag,
                    size: 80,
                    color: Colors.blue,
                  ),

                const SizedBox(height: 20),

                // NAMA PRODUK
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // HARGA PRODUK
                Text(
                  'Harga: Rp $harga',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= PROFIL =================

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xFFE1BEE7),

              child: Icon(
                Icons.person,
                size: 65,
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Bagus Setyo Nugroho',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Informatika - UISI',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // NAMED ROUTE
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tentang');
              },
              child: const Text('Ke Halaman Tentang'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/beranda');
              },
              child: const Text('Ke Halaman Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}
