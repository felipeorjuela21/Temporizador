class Application {
  final String appName;
  final String packageName;
  final String icon;
  Duration? timerDuration;

  Application({
    required this.appName,
    required this.packageName,
    required this.icon,
    this.timerDuration,
  });
}

class TemporizadorViewModel {
  Future<List<Application>> getInstalledApps() async {
    // Datos estáticos para demostración en iOS
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        Application(
          appName: 'Flutter App',
          packageName: 'com.example.flutterapp',
          icon: 'assets/flutter_icon.png',
        ),
        Application(
          appName: 'Another App',
          packageName: 'com.example.anotherapp',
          icon: 'assets/another_icon.png',
        ),
        // Agrega más aplicaciones según sea necesario
      ];
    });
  }
}