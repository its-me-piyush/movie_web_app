import 'package:flutter/material.dart';
import 'package:movie_web_app/provider/artists_provider.dart';
import 'package:movie_web_app/provider/movie_provider.dart';
import 'package:movie_web_app/provider/popular_movies_provider.dart';
import 'package:movie_web_app/provider/upcomming_movies_provider.dart';
import 'package:movie_web_app/screens/home_screen.dart';
import 'package:movie_web_app/theme.dart';
import 'package:provider/provider.dart';


// ░░░██╗░██╗░███╗░░░███╗░█████╗░██╗███╗░░██╗
// ██████████╗████╗░████║██╔══██╗██║████╗░██║
// ╚═██╔═██╔═╝██╔████╔██║███████║██║██╔██╗██║
// ██████████╗██║╚██╔╝██║██╔══██║██║██║╚████║
// ╚██╔═██╔══╝██║░╚═╝░██║██║░░██║██║██║░╚███║
// ░╚═╝░╚═╝░░░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MovieProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ArtistsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PopularMoviesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UpcommingMoviesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Web App',
        theme: theme(),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
