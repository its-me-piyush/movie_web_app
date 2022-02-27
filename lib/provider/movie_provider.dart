import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_web_app/constants.dart';

import '../models/movie_model.dart';


// ███╗░░░███╗░█████╗░██╗░░░██╗██╗███████╗
// ████╗░████║██╔══██╗██║░░░██║██║██╔════╝
// ██╔████╔██║██║░░██║╚██╗░██╔╝██║█████╗░░
// ██║╚██╔╝██║██║░░██║░╚████╔╝░██║██╔══╝░░
// ██║░╚═╝░██║╚█████╔╝░░╚██╔╝░░██║███████╗
// ╚═╝░░░░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝╚══════╝

// ██████╗░██████╗░░█████╗░██╗░░░██╗██╗██████╗░███████╗██████╗░
// ██╔══██╗██╔══██╗██╔══██╗██║░░░██║██║██╔══██╗██╔════╝██╔══██╗
// ██████╔╝██████╔╝██║░░██║╚██╗░██╔╝██║██║░░██║█████╗░░██████╔╝
// ██╔═══╝░██╔══██╗██║░░██║░╚████╔╝░██║██║░░██║██╔══╝░░██╔══██╗
// ██║░░░░░██║░░██║╚█████╔╝░░╚██╔╝░░██║██████╔╝███████╗██║░░██║
// ╚═╝░░░░░╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝╚═════╝░╚══════╝╚═╝░░╚═╝

class MovieProvider with ChangeNotifier {
  Future<List<MovieResults>> fetchNowPlayingMovies() async {
    try {
      // var url = Uri.parse('uri');
      var url = Uri.parse(
          '$baseUrl/movie/now_playing?api_key=$apiKey&language=en-US&page=1');
      var response = await http.get(url);
      var results = moviesFromJson(response.body);
      return results.results;
    } catch (e) {
      rethrow;
    }
  }
}
