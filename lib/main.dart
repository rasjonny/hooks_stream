import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MaterialApp(
    title: 'Home page',
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.dark,
    home: const HomePage(),
  ));
}

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

const url =
    'https://cdn.britannica.com/26/58626-050-3B2B1DA0/Simien-Mountains-Ethiopian-Plateau-Ethiopia.jpg';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((data) => data.buffer.asUint8List())
        .then((data) => Image.memory(data)));
    final snapshot = useFuture(future);
    return Scaffold(
      appBar: AppBar(title: const Text("homepage")),
      body: Column(
        children: [snapshot.data].compactMap().toList(),
      ),
    );
  }
}
