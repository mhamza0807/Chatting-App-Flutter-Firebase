import 'package:chat_app/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final HomeController _homeController = Get.find<HomeController>();

  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search user by email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  _homeController.searchUserByEmail(value.trim());
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final value = _searchController.text.trim();
              if (value.isNotEmpty) {
                _homeController.searchUserByEmail(value);
              }
            },
          )
        ],
      ),
    );
  }

}
