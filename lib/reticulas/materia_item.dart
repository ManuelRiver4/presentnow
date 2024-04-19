import 'package:flutter/material.dart';

class Materia {
  final String nombre;
  final String grupo;
  final String grado;
  final String maestro;
  final String horario;

  Materia({
    required this.nombre,
    required this.grupo,
    required this.grado,
    required this.maestro,
    required this.horario,
  });
}

class MateriaItem extends StatelessWidget {
  final Materia materia;

  const MateriaItem({
    required this.materia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue.withOpacity(0.2),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            materia.nombre,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 8),
          Text('Grupo: ${materia.grupo}'),
          Text('Grado: ${materia.grado}'),
          Text('Maestro: ${materia.maestro}'),
          Text('Horario: ${materia.horario}'),
        ],
      ),
    );
  }
}
