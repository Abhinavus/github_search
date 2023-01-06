


import 'package:flutter/material.dart';
import 'package:github_search/repo.dart';

import 'api.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<Post> futureAlbum;
    final TextEditingController searchController = TextEditingController();

  
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: (searchController) {
            // Trigger a search when the text changes
            fetchAlbum(searchController);}

        ),
      ),
      body: FutureBuilder(
        future:  fetchAlbum(searchController.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Display the search results in a list view
            return ListView.builder(
              itemCount: snapshot.data!.totalCount,
              itemBuilder: (context, index) {
              
                return ListTile(
                  leading: Image.network(snapshot.data!.items[index].avatarUrl),
                  title: Text(snapshot.data!.items[index].login),
                 
                  );
                
              },
            );
          } else {
            // Display a loading spinner while the search results are being fetched
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}