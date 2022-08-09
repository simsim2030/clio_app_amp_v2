import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:clio_chess_amp_v2/Screens/ChessClock/components/button/chessclocksettingbtn.dart';
import 'package:clio_chess_amp_v2/services/api_service.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:ndialog/ndialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'chessclocktimer.dart';
import 'chessclockfunction.dart';
import 'dart:async';

class ChessClockBody extends StatefulWidget {
  @override
  State<ChessClockBody> createState() => _ChessClockBodyState();
}

class _ChessClockBodyState extends State<ChessClockBody> {
  String statusText = "Status Text";
  bool isConnected = false;
  TextEditingController idTextController = TextEditingController();

  final MqttServerClient client = MqttServerClient(
      'a3s43fchdeum50-ats.iot.ap-southeast-2.amazonaws.com', '');

  ChessBoardController controller = ChessBoardController();
  APIService apiservice = APIService();

  ChessClock _topClock = ChessClock(
    getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
    timeControlMillis: 5 * 60 * 1000,
    incrementsMillis: 0,
  );

  ChessClock _bottomClock = ChessClock(
    getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
    timeControlMillis: 5 * 60 * 1000,
    incrementsMillis: 0,
  );

  String timecontrol = '';

  late Timer _timer;

  String deviceID = '12345';

  @override
  void initState() {
    super.initState();
    apiservice.unsubscribe;

    // _connect();

    _timer = Timer.periodic(
      Duration(milliseconds: 200),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    _timer.cancel();
  }

  int movenumber = 0;
  int _firstpress = 0;
  int _presscount_top = 0;
  int _presscount_bot = 0;

  void _onTopPressed() {
    _topClock.pause();
    _bottomClock.start();

    if (_presscount_top <= 0) {
      apiservice.createChessMove(movenumber);
      movenumber++;
      if (_firstpress == 0) {
        _presscount_top++;
        _firstpress++;
      } else {
        _presscount_top++;
        _presscount_bot--;
      }
    }
    // Trigger
    const pubTopic = 'esp32/sub';
    final builder = MqttClientPayloadBuilder();
    builder.addString('0');
    client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
  }

  void _onBottomPressed() {
    _topClock.start();
    _bottomClock.pause();

    if (_presscount_bot <= 0) {
      apiservice.createChessMove(movenumber);
      movenumber++;
      if (_firstpress == 0) {
        _presscount_bot++;
        _firstpress++;
      } else {
        _presscount_bot++;
        _presscount_top--;
      }
    }
    // Trigger
    const pubTopic = 'esp32/sub';
    final builder = MqttClientPayloadBuilder();
    builder.addString('1');
    client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _connect();
            },
            icon: Icon(Icons.connect_without_contact_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ChessClockTimer(
                onPressed: _onTopPressed,
                isReversed: true,
                isTicking: _topClock.isTicking(),
                isTimeup: _topClock.isTimeUp(),
                availableTime:
                    Duration(milliseconds: _topClock.getAvailableMillis()),
              ),
            ),
          ),
          chessClockSettingBtn(topClock: _topClock, bottomClock: _bottomClock),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChessClockTimer(
                onPressed: _onBottomPressed,
                isTicking: _bottomClock.isTicking(),
                isTimeup: _bottomClock.isTimeUp(),
                availableTime:
                    Duration(milliseconds: _bottomClock.getAvailableMillis()),
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     apiservice.unsubscribe();
          //   },
          //   child: Text('unsubcribe'),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: TextFormField(
          //       enabled: !isConnected,
          //       controller: idTextController,
          //       decoration: InputDecoration(
          //           border: UnderlineInputBorder(),
          //           labelText: 'MQTT Client Id',
          //           labelStyle: TextStyle(fontSize: 10),
          //           suffixIcon: IconButton(
          //             icon: Icon(Icons.subdirectory_arrow_left),
          //             onPressed: _connect,
          //           ))),
          // ),
          // ElevatedButton(
          //   onPressed: _connect,
          //   child: Text('connect device'),
          // ),
          isConnected
              ? TextButton(onPressed: _disconnect, child: Text('Disconnect'))
              : Container()
        ],
      ),
    );
  }

  Widget footer() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Text(
          statusText,
          style: TextStyle(
              fontWeight: FontWeight.normal, color: Colors.amberAccent),
        ),
      ),
      flex: 1,
    );
  }

  _connect() async {
    // if (idTextController.text.trim().isNotEmpty) {
    ProgressDialog progressDialog = ProgressDialog(context,
        blur: 0,
        dialogTransitionType: DialogTransitionType.Shrink,
        dismissable: false);
    progressDialog.setLoadingWidget(CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.red),
    ));
    progressDialog
        .setMessage(Text("Please Wait, Connecting to IoT MQTT Broker"));
    progressDialog.setTitle(Text("Connecting"));
    progressDialog.show();

    isConnected = await mqttConnect(deviceID);
    progressDialog.dismiss();
    // }
  }

  _disconnect() {
    client.disconnect();
  }

  Future<bool> mqttConnect(String uniqueID) async {
    setStatus("Connecting MQTT Broker");
    ByteData rootCA = await rootBundle.load('assets/certs/RootCA.pem');
    ByteData deviceCert =
        await rootBundle.load('assets/certs/DeviceCertificate.crt');
    ByteData privateKey = await rootBundle.load('assets/certs/Private.key');

    SecurityContext context = SecurityContext.defaultContext;
    context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

    client.securityContext = context;
    client.logging(on: true);
    client.keepAlivePeriod = 50000;
    client.port = 8883;
    client.secure = true;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.pongCallback = pong;

    final MqttConnectMessage connMess =
        MqttConnectMessage().withClientIdentifier(uniqueID).startClean();
    client.connectionMessage = connMess;

    await client.connect();
    if (client != null &&
        client.connectionStatus!.state == MqttConnectionState.connected) {
      print("Connected to AWS Successfully");
    } else {
      return false;
    }

    // const topic = 'esp32/sub';
    // print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
    // client.subscribe(topic, MqttQos.atMostOnce);

    // final builder1 = MqttClientPayloadBuilder();
    // builder1.addString('Hello from mqtt_client topic 1 sadafweegsegwg');
    // print('EXAMPLE:: <<<< PUBLISH 1 >>>>');
    // client.publishMessage(
    //   topic,
    //   MqttQos.atMostOnce,
    //   builder1.payload!,
    // );

    return true;
  }

  void setStatus(String content) {
    setState(() {
      statusText = content;
    });
  }

  void onConnected() {
    setStatus("Client connection was successful");
  }

  void onDisconnected() {
    setStatus("Client Disconnected");
    isConnected = false;
  }

  void pong() {
    print('Ping respone client callback invoked');
  }
}
