import 'package:flutter/material.dart';

class MateriasScreen extends StatefulWidget {
  @override
  _MateriasScreenState createState() => _MateriasScreenState();
}

class _MateriasScreenState extends State<MateriasScreen> {
  List<String> materias = [
    "Materia 1",
    "Materia 2",
    "Materia 3",
    "Materia 4",
    "Materia 5",
    "Materia 6"
  ];

  // Lista para controlar si se asistió a cada materia
  List<bool> asistencias = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Materias:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            // Mostrar cada materia en un recuadro separado
            for (var i = 0; i < materias.length; i++)
              MateriaItem(
                title: materias[i],
                asistio: asistencias[i],
                index: i,
                onChanged: (bool newValue) {
                  setState(() {
                    asistencias[i] = newValue;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}

class MateriaItem extends StatelessWidget {
  final String title;
  final bool asistio;
  final int index;
  final ValueChanged<bool> onChanged;

  const MateriaItem({
    required this.title,
    required this.asistio,
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color color; // Color del recuadro
    Color textColor; // Color del texto

    // Determinar el color del recuadro según el estado de asistencia y el intervalo de tiempo
    if (asistio) {
      color = Colors.green.withOpacity(0.2);
      textColor = Colors.green;
    } else {
      DateTime now = DateTime.now();
      int currentMinute = now.minute;
      if (currentMinute >= 0 && currentMinute <= 15) {
        color = Colors.blue.withOpacity(0.2); // Azul para 0-15 minutos
      } else if (currentMinute > 15 && currentMinute <= 20) {
        color = Colors.yellow.withOpacity(0.2); // Amarillo para 15-20 minutos
      } else {
        color = Colors.red.withOpacity(0.2); // Rojo para 20-60 minutos
      }
      textColor = Colors.black; // Texto negro por defecto
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: asistio ? Colors.green : Colors.red),
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          IconButton(
            icon: Icon(
              asistio ? Icons.check : Icons.close,
              color: asistio ? Colors.green : Colors.red,
            ),
            onPressed: () {
              onChanged(!asistio);
            },
          ),
        ],
      ),
    );
  }
}
