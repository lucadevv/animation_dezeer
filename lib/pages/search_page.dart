import 'package:dezeer_animation/models/music.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              suffix: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: musicProvider.length,
              itemBuilder: (context, index) {
                final item = musicProvider[index];

                return ListTile(
                  leading: Image.asset(item.imagePath),
                  title: Text(item.name),
                  subtitle: Text(item.author),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
