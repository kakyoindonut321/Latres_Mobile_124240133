import 'package:flutter/material.dart';

import '/models/show_model.dart';

import 'package:flutter/material.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;
  final VoidCallback onTap;

  const ShowCard({required this.show, required this.onTap});

  Widget _placeholder() {
    return Container(
      color: Colors.grey[850],
      child: const Center(
        child: Icon(Icons.movie, size: 40, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar mengisi sisa ruang
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: show.imageUrl == null
                    ? _placeholder()
                    : Image.network(
                        show.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _placeholder(),
                      ),
              ),
            ),
            // Judul + rating
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    show.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        show.rating?.toString() ?? '-',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
