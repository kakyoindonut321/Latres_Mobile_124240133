import 'package:flutter/material.dart';

import '../services/tvmaze_service.dart';
import '../models/show_model.dart';
import 'detail_page.dart';
import '../widget/show_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TvMazeService _service = TvMazeService();
  late Future<List<ShowModel>> _futureShows;

  @override
  void initState() {
    super.initState();
    _futureShows = _service.fetchShows();
  }

  void _retry() {
    setState(() {
      _futureShows = _service.fetchShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skuy Nonton!')),
      body: FutureBuilder<List<ShowModel>>(
        future: _futureShows,
        builder: (context, snapshot) {
          // 1. Masih loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 8),
                  const Text('Gagal memuat data'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _retry,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            );
          }

          // 3. Sukses
          final List<ShowModel> shows = snapshot.data ?? [];

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemCount: shows.length,
            itemBuilder: (context, index) {
              final ShowModel show = shows[index];
              return ShowCard(
                show: show,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(showId: show.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
