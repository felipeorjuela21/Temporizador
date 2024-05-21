import 'package:flutter/material.dart';
import 'package:myapp/viewmodel/temporizador.viewmodel.dart';

class TemporizadorPage extends StatefulWidget {
  const TemporizadorPage({super.key});

  @override
  _TemporizadorPageState createState() => _TemporizadorPageState();
}

class _TemporizadorPageState extends State<TemporizadorPage> {
  final TemporizadorViewModel _viewModel = TemporizadorViewModel();
  Future<List<Application>>? _appsFuture;
  final List<Application> _selectedApps = [];

  @override
  void initState() {
    super.initState();
    _appsFuture = _viewModel.getInstalledApps();
  }

  void _startTimer(Application app) {
    showDialog(
      context: context,
      builder: (context) {
        int minutes = 0;
        return AlertDialog(
          title: Text('Establecer tiempo para ${app.appName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Selecciona el tiempo en minutos'),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Minutos',
                ),
                onChanged: (value) {
                  minutes = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Iniciar'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  app.timerDuration = Duration(minutes: minutes);
                });
                if (app.timerDuration != null) {
                  Future.delayed(app.timerDuration!, () {
                    _showTimeUpDialog(app);
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showTimeUpDialog(Application app) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tiempo terminado para ${app.appName}'),
          content: const Text('¿Deseas cerrar la aplicación o continuar usándola?'),
          actions: [
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
                // Acción para cerrar la aplicación (puedes implementar el cierre si es posible)
              },
            ),
            TextButton(
              child: const Text('Continuar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicaciones Instaladas'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Application>>(
        future: _appsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar aplicaciones'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron aplicaciones'));
          }

          List<Application> apps = snapshot.data!;
          return ListView.builder(
            itemCount: apps.length,
            itemBuilder: (context, index) {
              Application app = apps[index];
              bool isSelected = _selectedApps.contains(app);

              return Card(
                color: isSelected ? Colors.teal[100] : Colors.white,
                child: ListTile(
                  leading: app.icon != null
                      ? Image.asset(app.icon, width: 40, height: 40)
                      : const Icon(Icons.device_unknown, size: 40),
                  title: Text(app.appName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(app.packageName),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.teal) : null,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedApps.remove(app);
                      } else {
                        _selectedApps.add(app);
                        _startTimer(app);
                      }
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}