//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_controle_casa/mqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({
    Key? key,
    required this.titulo,
    required this.icone,
    required this.icone2,
    required this.infor,
    required this.infor2,
    required this.topico,
    required this.valor,
    //required this.status
  }) : super(key: key);

  final String titulo;
  final String infor;
  final String infor2;
  final IconData icone;
  final IconData icone2;
  final String topico;
  final bool valor;
  //final String status;

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  double _valorSlider = 0; // Valor inicial do slider
  bool valorSwitch = false; // Valor inicial do switch
  bool valorJanela = false;
  bool valorLuzQuarto = false;
  bool valorLuzClosed = false;

  int counter = 0;

  late Broker broker; // Declare a variável broker
  final client = MqttServerClient('mqtt.eclipseprojects.io', '');

  void atualizarEstadoBotao(bool estado) {
    setState(() {
      valorSwitch = estado;
    });
  }

  @override
  void initState() {
    super.initState();
    broker = Broker(client); // Inicialize broker dentro do initState
    broker.conectar(); // Chame o método conectar do Broker
    valorSwitch = widget.valor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      "${widget.titulo} - ${widget.infor} ${valorSwitch ? 'On' : 'Off'} ",
                      style:
                          TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        widget.icone,
                        size: 30,
                      ),
                      Switch(
                        activeColor: const Color.fromARGB(255, 56, 210, 252),
                        value: widget.titulo == "Janela" ? valorJanela : widget.titulo == "Luz quarto" ? valorLuzQuarto : widget.titulo == "Luz closed" ? valorLuzClosed : valorSwitch,
                        onChanged: (bool newValue) {
                          do {
                            if (client.connectionStatus!.state !=
                                MqttConnectionState.connected) {
                              broker.conectar();
                            } else {
                              if (newValue == true) {
                                broker.publishMessages("1", "${widget.topico}");
                              } else {
                                broker.publishMessages("0", "${widget.topico}");
                              }
                            }
                            counter++;
                          } while (client.connectionStatus!.state !=
                                  MqttConnectionState.connected &&
                              counter < 10);
                          counter = 0;
                          setState(() {
                            if (widget.titulo == "Janela") {
                              valorJanela = newValue;
                              valorSwitch = newValue;
                              print("valor da janela $valorJanela");
                              print("valor do quarto $valorLuzQuarto");
                              print("valor do closed $valorLuzClosed");
                            } 
                            else if (widget.titulo == "Luz quarto") {
                              valorLuzQuarto = newValue;
                              valorSwitch = newValue;
                              print("valor da janela $valorJanela");
                              print("valor do quarto $valorLuzQuarto");
                              print("valor do closed $valorLuzClosed");
                            }
                            else if (widget.titulo == "Luz closed") {
                              valorLuzClosed = newValue;
                              valorSwitch = newValue;
                              print("valor da janela $valorJanela");
                              print("valor do quarto $valorLuzQuarto");
                              print("valor do closed $valorLuzClosed");
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
            visible: widget.valor,
            child: Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 15, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.titulo} - ${widget.infor2} ${_valorSlider.round()} %",
                      style:
                          TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(widget.icone2),
                        Slider(
                          divisions: 10,
                          min: 0,
                          max: 100,
                          value: _valorSlider,
                          onChanged: (double value) {
                            setState(() {
                              _valorSlider = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
