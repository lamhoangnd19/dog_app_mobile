import 'package:bai3/model/dog.dart';
import 'package:flutter/material.dart';


class DogSearchDelegate extends SearchDelegate {
  final List<Dog> dogBreeds;
  final List<Dog> favoriteDogs;
  final Function toggleFavorite;

  DogSearchDelegate(this.dogBreeds, this.favoriteDogs, this.toggleFavorite);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Dog> matchQuery = [];
    for (var dog in dogBreeds) {
      if (dog.name!.toLowerCase().contains(query.toLowerCase()) ||
          (dog.bredFor != null &&
              dog.bredFor!.toLowerCase().contains(query.toLowerCase())) ||
          (dog.breedGroup != null &&
              dog.breedGroup!.toLowerCase().contains(query.toLowerCase())) ||
          (dog.origin != null &&
              dog.origin!.toLowerCase().contains(query.toLowerCase()))) {
        matchQuery.add(dog);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final dog = matchQuery[index];
        return ListTile(
          title: _highlightSearchTerm(dog.name ?? 'Unknown', query),
          subtitle: _highlightSearchTerm(
              'ID: ${dog.id ?? 'N/A'}\n'
                  'Breed Group: ${dog.breedGroup ?? 'N/A'}\n'
                  'Bred For: ${dog.bredFor ?? 'N/A'}\n'
                  'Origin: ${dog.origin ?? 'N/A'}\n'
                  'Reference Image ID: ${dog.referenceImageId ?? 'N/A'}',
              query
          ),
          trailing: IconButton(
            icon: Icon(favoriteDogs.contains(dog) ? Icons.favorite : Icons.favorite_border,
              color: dog.isFavorite ? Colors.red : null,),
            onPressed: () {
              toggleFavorite(dog);
            },
          ),

        );
      },
    );
  }


  Widget _highlightSearchTerm(String text, String searchTerm) {
    if (searchTerm.isEmpty) {
      return Text(text);
    }
    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    while ((indexOfHighlight = text.toLowerCase().indexOf(searchTerm.toLowerCase(), start)) != -1) {
      if (indexOfHighlight > start) {
        spans.add(TextSpan(text: text.substring(start, indexOfHighlight)));
      }
      spans.add(TextSpan(
        text: text.substring(indexOfHighlight, indexOfHighlight + searchTerm.length),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
      start = indexOfHighlight + searchTerm.length;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    return RichText(text: TextSpan(children: spans, style: TextStyle(color: Colors.black)));
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    // Hiển thị gợi ý tìm kiếm ở đây
    return Container();
  }
}