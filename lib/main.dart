import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String currentTime = "";
  String currentDate = "";
  int currentMateriaIndex = 0;
  double progress = 0.0;
  late AnimationController progressController;
  Color barColor = Colors.blue;
  List<Color> materiaColors = [Colors.blue, Colors.blue, Colors.blue];
  List<String> materiaTimes = [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM"
  ]; // Horas personalizadas para cada materia

  List<String> materias = ["Materia 1", "Materia 2", "Materia 3"];
  bool showAttendance = false;
  bool daySaved = false;

  @override
  void initState() {
    super.initState();
    updateDateTime();
    calculateProgress();

    progressController = AnimationController(
      vsync: this,
      duration: Duration(minutes: 60),
    );

    progressController.forward();

    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        updateDateTime();
        calculateProgress();
      });

      if (DateTime.now().minute == 0) {
        progressController.reset();
        progressController.forward();
        // Cambiar de materia
        setState(() {
          currentMateriaIndex = (currentMateriaIndex + 1) % materias.length;
          // Restablecer el color de la materia a azul cuando cambia de materia
          for (int i = 0; i < materiaColors.length; i++) {
            materiaColors[i] = Colors.blue;
          }
        });
        // Guardar el día
        if (!daySaved) {
          daySaved = true;
          saveDay();
        }
      } else {
        daySaved = false; // Restablecer la bandera para guardar el día
      }
    });
  }

  @override
  void dispose() {
    progressController.dispose();
    super.dispose();
  }

  void calculateProgress() {
    int currentMinute = DateTime.now().minute;
    progress = currentMinute / 60.0;

    // Actualizar el índice de la materia actual según la hora del día
    int hour = DateTime.now().hour;
    if (hour == 8 && currentMinute >= 0 && currentMinute <= 15) {
      currentMateriaIndex = 0;
    } else if (hour == 9 && currentMinute >= 0 && currentMinute <= 15) {
      currentMateriaIndex = 1;
    } else if (hour == 10 && currentMinute >= 0 && currentMinute <= 15) {
      currentMateriaIndex = 2;
    } else {
      currentMateriaIndex = -1; // Fuera del horario de las materias
    }

    // Verificar si el horario actual está dentro del rango de alguna materia
    if (currentMateriaIndex >= 0 && currentMateriaIndex < materias.length) {
      if (currentMinute >= 15 && currentMinute < 20) {
        barColor = Colors.yellow;
        materiaColors[currentMateriaIndex] = Colors.yellow;
      } else if (currentMinute >= 20 && currentMinute < 40) {
        barColor = Colors.red;
        materiaColors[currentMateriaIndex] = Colors.red;
      } else if (currentMinute <= 15) {
        barColor = Colors.green;
        materiaColors[currentMateriaIndex] = Colors.green;
      } else {
        barColor = Colors.blue; // Restablecer a azul fuera del rango de tiempo
        materiaColors[currentMateriaIndex] = Colors.blue;
      }
    } else {
      // Si no hay ninguna materia programada para el horario actual, restablecer a azul
      barColor = Colors.blue;
    }
  }

  void updateDateTime() {
    setState(() {
      currentTime = DateFormat('hh:mm a').format(DateTime.now());
      currentDate = DateFormat('EEEE dd/MM/yyyy').format(DateTime.now());
    });
  }

  void saveDay() {
    // Implementa aquí la lógica para guardar el día actual
    print('Día guardado: $currentDate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Present Now'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('URL_DE_TU_FOTO'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nombre del Usuario',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Correo Institucional',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Mis archivos'),
              onTap: () {
                // Implementa la lógica para "Mis archivos"
              },
            ),
            ListTile(
              title: Text('Charlar'),
              onTap: () {
                // Implementa la lógica para "Charlar"
              },
            ),
            ListTile(
              title: Text('Materias'),
              onTap: () {
                // Implementa la lógica para "Materias"
              },
            ),
            ListTile(
              title: Text('Avisos recientes'),
              onTap: () {
                // Implementa la lógica para "Avisos recientes"
              },
            ),
            ListTile(
              title: Text('Modo desconectado'),
              onTap: () {
                // Implementa la lógica para "Modo desconectado"
              },
            ),
            ListTile(
              title: Text('Justificantes'),
              onTap: () {
                // Implementa la lógica para "Justificantes"
              },
            ),
            ListTile(
              title: Text('Cerrar sesión'),
              onTap: () {
                // Implementa la lógica para "Cerrar sesión"
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recordatorios de Materias',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 5.0),
                      for (var i = 0; i < materias.length; i++)
                        ListTile(
                          title: Text(
                            '${materias[i]}: ${materiaTimes[i]}', // Mostrar la hora personalizada para cada materia
                            style: TextStyle(
                              color: materiaColors[i], // Color de la materia
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              if (showAttendance && currentMateriaIndex >= 0)
                Container(
                  color: currentMateriaIndex < materias.length
                      ? materiaColors[
                          currentMateriaIndex] // Color de fondo según la materia actual
                      : Colors.grey,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentMateriaIndex < materias.length
                        ? materias[currentMateriaIndex]
                        : 'Todavía no ha comenzado el día',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black, // Texto de la materia en negro
                    ),
                  ),
                ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Text(currentTime),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Calcular el progreso y actualizar los colores de las materias
                      calculateProgress();

                      // Verificar el intervalo de tiempo y actualizar los colores de las materias
                      if (DateTime.now().minute <= 15 &&
                          currentMateriaIndex >= 0) {
                        // Cambiar el color de la barra y el recuadro de la materia a verde
                        setState(() {
                          materiaColors[currentMateriaIndex] = Colors.green;
                          showAttendance = true;
                        });
                        // Mostrar mensaje de éxito en el registro de asistencia con retraso de 2 segundos
                        Future.delayed(Duration(seconds: 2), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Éxito en registrar asistencia'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        });
                      } else if (DateTime.now().minute >= 15 &&
                          DateTime.now().minute < 20 &&
                          currentMateriaIndex >= 0) {
                        // Cambiar el color de la barra y el recuadro de la materia a amarillo
                        setState(() {
                          materiaColors[currentMateriaIndex] = Colors.yellow;
                          showAttendance = true;
                        });
                        // Mostrar mensaje de asistencia registrada con retraso de 2 segundos
                        Future.delayed(Duration(seconds: 2), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Asistencia registrada con retraso'),
                              backgroundColor: Colors.yellow,
                            ),
                          );
                        });
                      } else if (DateTime.now().minute >= 20 &&
                          DateTime.now().minute < 40 &&
                          currentMateriaIndex >= 0) {
                        // Cambiar el color de la barra y el recuadro de la materia a rojo
                        setState(() {
                          materiaColors[currentMateriaIndex] = Colors.red;
                          showAttendance = true;
                        });
                        // Mostrar mensaje de error en el registro de asistencia con retraso de 2 segundos
                        Future.delayed(Duration(seconds: 2), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al registrar asistencia'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        });
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Asistencia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  AnimatedBuilder(
                    animation: progressController,
                    builder: (context, child) {
                      return SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(barColor),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
