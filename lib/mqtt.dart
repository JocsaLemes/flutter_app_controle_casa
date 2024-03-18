import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Broker{
final MqttServerClient client;
Broker(this.client);

Future<void> conectar() async {
  client.setProtocolV311();
  client.logging(on: false);
  client.keepAlivePeriod = 20;
  client.onDisconnected = onDisconnected;
  client.onSubscribed = onSubscribed;
  final connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueIdQ1')
      //.withWillTopic('Andar_Inferior/Camera')
      //.withWillMessage('My Will message')
      .startClean()
      .withWillQos(MqttQos.atMostOnce);
  print('Conectando ao broker....');
  client.connectionMessage = connMess;

  try {
    await client.connect();
  } on Exception catch (e) {
    print('client exception - $e');
    client.disconnect();
    return; // Retornando sem completar para indicar falha na conexão
  }

  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('Conectado ao broker');
    
    // Aqui, as mensagens de publicação são enviadas após a conexão MQTT ser estabelecida com sucesso
    //await publishMessages(client);
  } else {
    print('ERROR falha de conexão ao broker ${client.connectionStatus!.state}');
    client.disconnect();
    exit(-1);
  }
}

Future<void> publishMessages(String valor, String topico,) async {
 //vai receber o valor referente e o topico
 String topic = topico;
 // Insira aqui as mensagens que deseja enviar
  final message1 = valor;
  final ligado = MqttClientPayloadBuilder();
  ligado.addString(message1);
  print('publicado no topico $topico: $message1');
  client.publishMessage(topic, MqttQos.atLeastOnce, ligado.payload!);  


  print('Sleeping for 60 seconds....');
  await Future.delayed(Duration(seconds: 60));

  //print('Unsubscribing');
  //client.unsubscribe(topic);
  

  //print('Disconnecting');
  //client.disconnect();
}

void subscribe(String topic, MqttQos qosLevel, Function(bool) onMessageReceived) {
  client.subscribe(topic, qosLevel);
  client.updates?.listen((List<MqttReceivedMessage<MqttMessage>>? event) {
    if (event != null && event.isNotEmpty) {
      final MqttPublishMessage message = event[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      if (topic == "luzes") {
        if (payload == "ligado") {
          // Chamar a função de retorno com true se a lâmpada estiver ligada
          onMessageReceived(true);
        } else if (payload == "desligado") {
          // Chamar a função de retorno com false se a lâmpada estiver desligada
          onMessageReceived(false);
        }
      }
    }
  });
}

void onSubscribed(String topic) {
  print('Subscription confirmed for topic $topic');
}

void onDisconnected() {
  print('OnDisconnected client callback - Client disconnection');
}
}