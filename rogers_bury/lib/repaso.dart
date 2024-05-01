import 'package:flutter/material.dart';

class CalculadoraOperacionesPantalla extends StatefulWidget {
  const CalculadoraOperacionesPantalla({Key? key}) : super(key: key);


  @override
  State<CalculadoraOperacionesPantalla> createState() =>
      _CalculadoraOperacionesPantallaState();
}

class _CalculadoraOperacionesPantallaState
    extends State<CalculadoraOperacionesPantalla> {
  TextEditingController numero1Controlador = TextEditingController();
  TextEditingController numero2Controlador = TextEditingController();
  List<String> operacionesHistorial = [];

  String sumar(String num1, String num2) {
    int sobrante = 0;
    String resultado = '';
    int longitud1 = num1.length - 1;
    int longitud2 = num2.length - 1;

    while (longitud1 >= 0 || longitud2 >= 0 || sobrante > 0) {
      int digito1;
      if (longitud1 >= 0) {
        digito1 = int.parse(num1[longitud1]); // Corregido
      } else {
        digito1 = 0;
      }

      int digito2;
      if (longitud2 >= 0) {
        digito2 = int.parse(num2[longitud2]); // Corregido
      } else {
        digito2 = 0;
      }

      int suma = digito1 + digito2 + sobrante;
      sobrante = suma ~/ 10;
      suma %= 10;

      resultado = '$suma$resultado';

      longitud1--;
      longitud2--;
    }
    return resultado;
  }

  String restar(String num1, String num2) {
  int prestamo = 0;
  String resultado = ''; // Inicializamos el resultado como una cadena vacía
  int i = num1.length - 1;
  int j = num2.length - 1;

  // Mientras haya dígitos en num1 o num2 o haya un préstamo pendiente
  while (i >= 0 || j >= 0 || prestamo > 0) {
    // Obtenemos los dígitos de num1 y num2 (o 0 si ya no quedan dígitos)
    int digito1 = i >= 0 ? int.parse(num1[i]) : 0;
    int digito2 = j >= 0 ? int.parse(num2[j]) : 0;

    // Calculamos la diferencia, sumándole el préstamo
    int diferencia = digito1 - digito2 - prestamo;

    // Si la diferencia es negativa, pedimos prestado 1 a la siguiente posición
    if (diferencia < 0) {
      diferencia += 10; // Sumamos 10 para compensar la resta
      prestamo = 1; // Pedimos prestado 1
    } else {
      prestamo = 0; // No hay préstamo en esta posición
    }

    // Añadimos el dígito de la diferencia al resultado
    resultado = '$diferencia$resultado';

    // Pasamos al siguiente dígito
    i--;
    j--;
  }

  // Eliminamos los ceros sobrantes al inicio
  resultado = resultado.replaceFirst(RegExp('^0+'), '');

  // Si el resultado es una cadena vacía, entonces el resultado es 0
  return resultado.isEmpty ? '0' : resultado;
}




  void realizarOperacion(String operacion) {
    String num1 = numero1Controlador.text;
    String num2 = numero2Controlador.text;
    String resultado = '';

    if (operacion == "Sumar") {
      resultado = sumar(num1, num2);
    } else if (operacion == "Restar") {
      resultado = restar(num1, num2);
    }

    setState(() {
      operacionesHistorial.add("$num1 $operacion $num2 = $resultado");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de números Grandes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: numero1Controlador,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Número 1'),
            ),
            TextField(
              controller: numero2Controlador,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Número 2'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => realizarOperacion("Sumar"),
                  child: const Text('Sumar'),
                ),
                ElevatedButton(
                  onPressed: () => realizarOperacion("Restar"),
                  child: const Text('Restar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: operacionesHistorial.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(operacionesHistorial[index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
