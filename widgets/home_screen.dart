import 'package:bai3/model/dog.dart';
import 'package:bai3/widgets/dog_search.dart';
import 'package:bai3/widgets/liked_dog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Dog> _dogs = [];
  List<Dog> _favoriteDogs = [];

  @override
  void initState() {
    super.initState();
    _fetchDogs();
  }

  Future<void> _fetchDogs() async {
    final response =
    await http.get(Uri.parse('https://api.thedogapi.com/v1/breeds'));
    if (response.statusCode == 200) {
      final List<dynamic> dogJson = json.decode(response.body);
      setState(() {
        _dogs = dogJson.map((json) => Dog.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load dogs');
    }
  }

  Future<void> fetchDogImage(String? referenceImageId) async {
    final response = await http
        .get(Uri.parse('https://api.thedogapi.com/v1/images/$referenceImageId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> imageData = json.decode(response.body);
      final String imageUrl = imageData['url'];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Đóng dialog khi người dùng chạm vào bất kỳ nơi nào trên màn hình
              },
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover, // Đảm bảo rằng hình ảnh sẽ phù hợp với kích thước của dialog
              ),
            ),
          );
        },
      );
    } else {
      print('Failed to fetch the dog image');
    }
  }

  void toggleFavorite(Dog dog) {
    setState(() {
      dog.isFavorite = !dog.isFavorite;
      if (dog.isFavorite) {
        if (!_favoriteDogs.contains(dog)) {
          _favoriteDogs.add(dog);
        }
      } else {
        _favoriteDogs.remove(dog);
      }
    });
  }

  void _logout() {
    // Thực hiện các thao tác đăng xuất ở đây
    Navigator.pushReplacementNamed(context, '/login'); // Điều hướng đến màn hình đăng nhập
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black.withOpacity(0.2), // Đặt màu nền cho AppBar là màu đen
        title: Text('DOG BREEDS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DogSearchDelegate(_dogs, _favoriteDogs, toggleFavorite),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen(favoriteDogs: _favoriteDogs)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout), // Icon đăng xuất
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Đăng Xuất'), // Tiêu đề hộp thoại
                    content: Text('Bạn có muốn đăng xuất không?'), // Nội dung hộp thoại
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Đóng hộp thoại
                        },
                        child: Text('Không'), // Nút không
                      ),
                      TextButton(
                        onPressed: () {
                          _logout(); // Đăng xuất
                        },
                        child: Text('Có'), // Nút có
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dog-ngao.jpg'), // Đường dẫn đến hình ảnh trong thư mục assets
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: _dogs.length,
          itemBuilder: (context, index) {
            final dog = _dogs[index];
            return Card(
              color: Colors.white.withOpacity(0.5), // Đặt màu nền của thông tin chó với độ trong suốt là 0.5
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                title: Text(
                  dog.name ?? 'Unknown',
                  style: TextStyle(
                    color: Colors.black, // Đặt màu chữ là màu đen
                    fontWeight: FontWeight.bold, // Đặt đậm cho chữ
                    fontSize: 25,
                  ),
                ),
                subtitle: Text(
                  'ID: ${dog.id ?? 'N/A'}\n'
                      'Breed Group: ${dog.breedGroup ?? 'N/A'}\n'
                      'Bred For: ${dog.bredFor ?? 'N/A'}\n'
                      'Origin: ${dog.origin ?? 'N/A'}\n'
                      'Reference Image ID: ${dog.referenceImageId ?? 'N/A'}',
                  style: TextStyle(
                    color: Colors.black, // Đặt màu chữ là màu đen
                    fontSize: 20,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    dog.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: dog.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      toggleFavorite(dog);
                    });
                  },
                ),
                onTap: () {
                  fetchDogImage(dog.referenceImageId);
                },
              ),
            );
          },
        ),
      ),
    );
  }


}
