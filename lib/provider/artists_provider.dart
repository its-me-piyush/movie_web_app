import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_web_app/constants.dart';
import 'package:movie_web_app/models/artists_model.dart';


// ░█████╗░██████╗░████████╗██╗░██████╗████████╗░██████╗
// ██╔══██╗██╔══██╗╚══██╔══╝██║██╔════╝╚══██╔══╝██╔════╝
// ███████║██████╔╝░░░██║░░░██║╚█████╗░░░░██║░░░╚█████╗░
// ██╔══██║██╔══██╗░░░██║░░░██║░╚═══██╗░░░██║░░░░╚═══██╗
// ██║░░██║██║░░██║░░░██║░░░██║██████╔╝░░░██║░░░██████╔╝
// ╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝╚═════╝░░░░╚═╝░░░╚═════╝░

// ██████╗░██████╗░░█████╗░██╗░░░██╗██╗██████╗░███████╗██████╗░
// ██╔══██╗██╔══██╗██╔══██╗██║░░░██║██║██╔══██╗██╔════╝██╔══██╗
// ██████╔╝██████╔╝██║░░██║╚██╗░██╔╝██║██║░░██║█████╗░░██████╔╝
// ██╔═══╝░██╔══██╗██║░░██║░╚████╔╝░██║██║░░██║██╔══╝░░██╔══██╗
// ██║░░░░░██║░░██║╚█████╔╝░░╚██╔╝░░██║██████╔╝███████╗██║░░██║
// ╚═╝░░░░░╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝╚═════╝░╚══════╝╚═╝░░╚═╝

class ArtistsProvider with ChangeNotifier {
  Future<List<Cast>> fetchNowPlayingMovies() async {
    try {
      // var url = Uri.parse('uri');
      var url = Uri.parse(
          '$baseUrl/movie/637649/credits?api_key=$apiKey&language=en-US');

      var response = await http.get(url);
      var results = artistsFromJson(response.body);
      return results.cast;
    } catch (e) {
      rethrow;
    }
  }
}
