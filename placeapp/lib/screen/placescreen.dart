import 'package:favouriteplace/screen/addplaces.dart';
import 'package:flutter/material.dart';
import 'package:favouriteplace/widget/placelist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favouriteplace/providers/userplace.dart';

class Placescreen extends ConsumerStatefulWidget {
  const Placescreen({super.key});
  @override
  ConsumerState<Placescreen> createState() {
    return _PlacescreenState();
  }
}

// void _addplaces() {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (ctx) => const Addplaces(),
//     ),
//   );
// }
class _PlacescreenState extends ConsumerState<Placescreen> {
  late Future<void> _placesfuture;
  @override
  void initState() {
    super.initState();
    _placesfuture = ref.read(userplaceprovider.notifier).loadplace();
  }

  @override
  Widget build(
      BuildContext
          context /*,WidgetRef ref* because it's include in ful widget*/) {
    final userplace = ref.watch(userplaceprovider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favourite Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const Addplaces(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: _placesfuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : Placelist(
                      places: userplace,
                    ),
        ),
      ),
    );
  }
}
