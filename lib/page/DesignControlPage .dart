import 'package:flutter/material.dart';

class DesignControlPage extends StatefulWidget {
  const DesignControlPage({super.key});

  @override
  _DesignControlPageState createState() => _DesignControlPageState();
}

class _DesignControlPageState extends State<DesignControlPage> {
  Color _backgroundColor = Colors.white;
  Color _iconColor = Colors.teal;
  double _iconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Diseño'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Container(
            color: _backgroundColor,
            height: 200,
            child: Center(
              child: Icon(
                Icons.star,
                color: _iconColor,
                size: _iconSize,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Color de Fondo'),
                Row(
                  children: [
                    _colorButton(Colors.white),
                    _colorButton(Colors.blue),
                    _colorButton(Colors.green),
                    _colorButton(Colors.yellow),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Color del Icono'),
                Row(
                  children: [
                    _colorButton(Colors.teal, isIcon: true),
                    _colorButton(Colors.red, isIcon: true),
                    _colorButton(Colors.purple, isIcon: true),
                    _colorButton(Colors.orange, isIcon: true),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Tamaño del Icono'),
                Slider(
                  value: _iconSize,
                  min: 24.0,
                  max: 100.0,
                  divisions: 10,
                  label: _iconSize.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _iconSize = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorButton(Color color, {bool isIcon = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isIcon) {
            _iconColor = color;
          } else {
            _backgroundColor = color;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black),
        ),
      ),
    );
  }
}