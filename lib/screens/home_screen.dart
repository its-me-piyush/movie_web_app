import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_web_app/constants.dart';
import 'package:movie_web_app/models/artists_model.dart';
import 'package:movie_web_app/models/movie_model.dart';
import 'package:movie_web_app/models/popular_movies_model.dart';
import 'package:movie_web_app/models/upcomming_movies_model.dart';
import 'package:movie_web_app/provider/artists_provider.dart';
import 'package:movie_web_app/provider/movie_provider.dart';
import 'package:movie_web_app/provider/popular_movies_provider.dart';
import 'package:movie_web_app/provider/upcomming_movies_provider.dart';
import 'package:provider/provider.dart';

import '/size_config.dart';


// ██╗░░██╗░█████╗░███╗░░░███╗███████╗
// ██║░░██║██╔══██╗████╗░████║██╔════╝
// ███████║██║░░██║██╔████╔██║█████╗░░
// ██╔══██║██║░░██║██║╚██╔╝██║██╔══╝░░
// ██║░░██║╚█████╔╝██║░╚═╝░██║███████╗
// ╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚═╝╚══════╝

// ░██████╗░█████╗░██████╗░███████╗███████╗███╗░░██╗
// ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝████╗░██║
// ╚█████╗░██║░░╚═╝██████╔╝█████╗░░█████╗░░██╔██╗██║
// ░╚═══██╗██║░░██╗██╔══██╗██╔══╝░░██╔══╝░░██║╚████║
// ██████╔╝╚█████╔╝██║░░██║███████╗███████╗██║░╚███║
// ╚═════╝░░╚════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░╚══╝

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Row(
        children: [
          const HomeOptions(),
          VerticalDivider(
            color: mwaGreyishColor.withOpacity(0.3),
            width: 1,
            thickness: 1,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenWidth(15),
                left: getProportionateScreenWidth(15),
                right: getProportionateScreenWidth(15),
              ),
              child: ListView(
                children: [
                  const MainColumnHeadings(),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  FutureBuilder(
                    future: Provider.of<MovieProvider>(context, listen: false)
                        .fetchNowPlayingMovies(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<MovieResults> movieList =
                          snapshot.data as List<MovieResults>;
                      return SizedBox(
                        height: getProportionateScreenHeight(315),
                        // width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieList.length,
                          itemBuilder: (context, index) => Stack(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                margin: EdgeInsets.only(
                                    right: getProportionateScreenWidth(10)),
                                height: getProportionateScreenHeight(315),
                                width: SizeConfig.screenWidth * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(10),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original/${movieList[index].backdropPath}',
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => SizedBox(
                                    width: getProportionateScreenWidth(10),
                                    child: const CircularProgressIndicator(
                                      color: mwaReddishColor,
                                    ),
                                  ),
                                  // error widgit
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            ''), // find a nice image
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: getProportionateScreenWidth(5),
                                left: getProportionateScreenWidth(5),
                                child: Text(
                                  movieList[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionateScreenWidth(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  const CustomHomeCategoryDesign(title: 'Best Artists'),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(250),
                    child: FutureBuilder(
                      future:
                          Provider.of<ArtistsProvider>(context, listen: false)
                              .fetchNowPlayingMovies(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List<Cast> artistsList = snapshot.data as List<Cast>;

                        return SizedBox(
                          height: getProportionateScreenHeight(100),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: artistsList.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(
                                right: getProportionateScreenWidth(10),
                              ),
                              width: getProportionateScreenWidth(50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(10),
                                ),
                                // color: mwaReddishColor,
                              ),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                width: SizeConfig.screenWidth * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(10),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original${artistsList[index].profilePath}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => SizedBox(
                                        width: getProportionateScreenWidth(10),
                                        child: const CircularProgressIndicator(
                                          color: mwaReddishColor,
                                        ),
                                      ),
                                      // error widgit
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                ''), // find a nice image
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: getProportionateScreenHeight(35),
                                      left: getProportionateScreenWidth(3),
                                      child: Text(
                                        artistsList[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                getProportionateScreenWidth(5)),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: getProportionateScreenHeight(15),
                                      left: getProportionateScreenWidth(3),
                                      child: Text(
                                        'Charecter: ${artistsList[index].charecter}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                getProportionateScreenWidth(5)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: mwaGreyishColor.withOpacity(0.3),
            width: 1,
            thickness: 1,
          ),
          const HomeOptions2(),
        ],
      ),
    );
  }
}

class CustomHomeCategoryDesign extends StatelessWidget {
  const CustomHomeCategoryDesign({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(5),
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
            ),
          ),
          padding: EdgeInsets.all(getProportionateScreenWidth(1)),
          child: Center(
            child: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
              size: getProportionateScreenWidth(8),
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(5),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
            ),
          ),
          padding: EdgeInsets.all(getProportionateScreenWidth(1)),
          child: Center(
            child: Icon(
              FontAwesomeIcons.angleRight,
              color: Colors.white,
              size: getProportionateScreenWidth(8),
            ),
          ),
        ),
      ],
    );
  }
}

class MainColumnHeadings extends StatelessWidget {
  const MainColumnHeadings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'TV Series',
          style: TextStyle(
            color: mwaGreyishColor,
            fontSize: getProportionateScreenWidth(5),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(2),
        ),
        Text(
          'Movies',
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(5),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(2),
        ),
        Text(
          'Animes',
          style: TextStyle(
            color: mwaGreyishColor,
            fontSize: getProportionateScreenWidth(5),
          ),
        ),
      ],
    );
  }
}

class HomeOptions extends StatelessWidget {
  const HomeOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(80),
      child: Padding(
        padding: EdgeInsets.only(
          top: getProportionateScreenWidth(8),
          bottom: getProportionateScreenWidth(8),
          left: getProportionateScreenWidth(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Icon
            Container(
              margin: EdgeInsets.only(right: getProportionateScreenWidth(8)),
              height: getProportionateScreenHeight(100),
              child: const Image(
                image: AssetImage(
                  '${(kDebugMode && kIsWeb) ? "" : "assets/"}images/icon.jpg',
                ),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            // Menu Text
            const Text(
              'MENU',
              style: TextStyle(
                color: mwaGreyishColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Menu Options
            _homeMenuOptions(
              iconData: Icons.home_rounded,
              title: 'Home',
              isSelected: true,
              size: 7,
            ),
            _homeMenuOptions(
              iconData: Icons.location_city_rounded,
              title: 'Community',
              size: 7,
            ),
            _homeMenuOptions(
              iconData: FontAwesomeIcons.compass,
              title: 'Discovery',
              size: 7,
            ),
            _homeMenuOptions(
              iconData: Icons.timer,
              title: 'Comming Soon',
              size: 7,
            ),
            SizedBox(
              height: getProportionateScreenHeight(60),
            ),
            // Socials Options
            const Text(
              'SOCIAL',
              style: TextStyle(
                color: mwaGreyishColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Social Options
            _homeMenuOptions(
              iconData: FontAwesomeIcons.userAlt,
              title: 'Friends',
              size: 5,
            ),
            _homeMenuOptions(
              iconData: FontAwesomeIcons.userFriends,
              title: 'Parties',
              size: 5,
            ),
            _homeMenuOptions(
              iconData: FontAwesomeIcons.adn,
              title: 'Media',
              size: 5,
            ),
            SizedBox(
              height: getProportionateScreenHeight(60),
            ),
            // General Text
            const Text(
              'GENERAL',
              style: TextStyle(
                color: mwaGreyishColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            // General Options
            _homeMenuOptions(
              iconData: Icons.settings_rounded,
              title: 'Settings',
              size: 5,
            ),
            _homeMenuOptions(
              iconData: Icons.logout_rounded,
              title: 'Logout',
              size: 5,
            ),
          ],
        ),
      ),
    );
  }

  Container _homeMenuOptions(
      {required IconData iconData,
      required String title,
      required double size,
      bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(
        top: title == 'Home'
            ? getProportionateScreenHeight(40)
            : getProportionateScreenHeight(20),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(
              iconData,
              color: isSelected ? mwaReddishColor : mwaGreyishColor,
              size: getProportionateScreenWidth(size),
            ),
            Container(
              margin: EdgeInsets.only(
                left: getProportionateScreenWidth(3),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : mwaGreyishColor,
                ),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(1),
                color: mwaReddishColor,
              ),
          ],
        ),
      ),
    );
  }
}

class HomeOptions2 extends StatelessWidget {
  const HomeOptions2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(80),
      child: Padding(
        padding: EdgeInsets.only(
          top: getProportionateScreenWidth(8),
          bottom: getProportionateScreenWidth(8),
          left: getProportionateScreenWidth(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Container(
              margin: EdgeInsets.only(right: getProportionateScreenWidth(8)),
              height: getProportionateScreenHeight(50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(20),
                ),
                border: Border.all(
                  color: mwaGreyishColor,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(2),
                  ),
                  const Icon(
                    FontAwesomeIcons.search,
                    color: mwaGreyishColor,
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(3),
                  ),
                  const Text(
                    'Search',
                    style: TextStyle(
                      color: mwaGreyishColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            // Menu Text
            Text(
              'Popular Movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(4),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            SizedBox(
              height: getProportionateScreenHeight(350),
              child: FutureBuilder(
                  future:
                      Provider.of<PopularMoviesProvider>(context, listen: false)
                          .fetchNowPlayingMovies(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<PopularMoviesResults> popularMoviesList =
                        snapshot.data as List<PopularMoviesResults>;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: popularMoviesList.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(
                              bottom: getProportionateScreenWidth(5),
                            ),
                            width: getProportionateScreenWidth(30),
                            height: getProportionateScreenHeight(150),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(2),
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${popularMoviesList[index].backdropPath}',
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => SizedBox(
                                width: getProportionateScreenWidth(10),
                                child: const CircularProgressIndicator(
                                  color: mwaReddishColor,
                                ),
                              ),
                              // error widgit
                              errorWidget: (context, url, error) => Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(''), // find a nice image
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    popularMoviesList[index].originalTitle,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: getProportionateScreenHeight(20),
                                      width: getProportionateScreenWidth(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenWidth(2),
                                        ),
                                        color: const Color(0xFFDBB91D),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "IMDb",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(2),
                                    ),
                                    Text(
                                      '${popularMoviesList[index].voteAverage}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              'Upcomming Movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(4),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Expanded(
              child: FutureBuilder(
                  future: Provider.of<UpcommingMoviesProvider>(context,
                          listen: false)
                      .fetchNowPlayingMovies(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<UpcommingMoviesResults> upcommingMoviesList =
                        snapshot.data as List<UpcommingMoviesResults>;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: upcommingMoviesList.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(
                              bottom: getProportionateScreenWidth(5),
                            ),
                            width: getProportionateScreenWidth(30),
                            height: getProportionateScreenHeight(150),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(2),
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${upcommingMoviesList[index].backdropPath}',
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => SizedBox(
                                width: getProportionateScreenWidth(10),
                                child: const CircularProgressIndicator(
                                  color: mwaReddishColor,
                                ),
                              ),
                              // error widgit
                              errorWidget: (context, url, error) => Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(''), // find a nice image
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  upcommingMoviesList[index].originalTitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: getProportionateScreenHeight(20),
                                      width: getProportionateScreenWidth(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenWidth(2),
                                        ),
                                        color: const Color(0xFFDBB91D),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "IMDb",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(2),
                                    ),
                                    Text(
                                      '${upcommingMoviesList[index].voteAverage}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Container _homeMenuOptions(
      {required IconData iconData,
      required String title,
      required double size,
      bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(
        top: title == 'Home'
            ? getProportionateScreenHeight(40)
            : getProportionateScreenHeight(20),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(
              iconData,
              color: isSelected ? mwaReddishColor : mwaGreyishColor,
              size: getProportionateScreenWidth(size),
            ),
            Container(
              margin: EdgeInsets.only(
                left: getProportionateScreenWidth(3),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : mwaGreyishColor,
                ),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(1),
                color: mwaReddishColor,
              ),
          ],
        ),
      ),
    );
  }
}
