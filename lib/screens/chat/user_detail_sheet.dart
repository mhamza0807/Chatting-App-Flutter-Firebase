import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/user_model.dart';

void showUserDetailSheet(BuildContext context, UserModel user) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Important for setting custom height
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      final height = MediaQuery.of(context).size.height * 0.4;

      return SizedBox(
        height: height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) =>
                          FullscreenImageViewer(imageUrl: user.imgUrl),
                    ),
                  );
                },
                child: Hero(
                  tag: 'user-image-${user.imgUrl}',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.imgUrl),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                user.email,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class FullscreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullscreenImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final dim =  Get.width * 0.9;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'user-image-$imageUrl',
            child: Image.network(
              width: dim,
              height: dim,
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
