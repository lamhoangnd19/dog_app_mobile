import 'package:flutter/material.dart';
import 'package:bai3/model/dog.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Dog> favoriteDogs;

  FavoritesScreen({required this.favoriteDogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        title: Row(
          children: [
            Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 30,
            ),
            Text('Favorite Dogs'),
          ],
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dog-cuoi.jpg'), // Đường dẫn đến hình ảnh trong thư mục assets
            fit: BoxFit.cover,
            //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop), // Lớp mờ
          ),
        ),
        child: ListView.builder(
          itemCount: favoriteDogs.length,
          itemBuilder: (context, index) {
            final dog = favoriteDogs[index];
            return Card(
              color: Colors.white.withOpacity(0.7), // Màu nền của card
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                title: Text(
                  dog.name ?? 'Unknown',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),
                ),
                subtitle: Text(
                  'ID: ${dog.id ?? 'N/A'}\n'
                      'Breed Group: ${dog.breedGroup ?? 'N/A'}\n'
                      'Bred For: ${dog.bredFor ?? 'N/A'}\n'
                      'Origin: ${dog.origin ?? 'N/A'}\n'
                      'Reference Image ID: ${dog.referenceImageId ?? 'N/A'}',
                  style: TextStyle(fontSize: 20.0, color: Colors.black87),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
