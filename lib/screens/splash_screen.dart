import 'package:flutter/material.dart';
import 'package:movies/api/movies_api.dart';
import 'package:movies/screens/movies_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = MoviesApi.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return loadingWidget();
          if (snapshot.hasError) return splashErrorWidget('Something went wrong');
          if (!snapshot.hasData) return splashErrorWidget('No data');
          getMoviesScreen(snapshot.data);
          return loadingWidget();
        },
      ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/ic_launcher.png'),
          Text('Loading..', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget splashErrorWidget(String body) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(body, style: TextStyle(fontSize: 20)),
          ElevatedButton(
            onPressed: () => refreshMovies(),
            child: Text('Refresh'),
          ),
        ],
      ),
    );
  }

  void refreshMovies() {
    MoviesApi.getMovies().then((value) {
      futureMovies = Future.value(value);
      setState(() {});
    });
  }

  void getMoviesScreen(movies) {
    Future.delayed(Duration(milliseconds: 1000), () {
      return Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => MoviesScreen(movies)));
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Close the connection if app closed before the data arrived
    MoviesApi.client?.close();
  }
}
