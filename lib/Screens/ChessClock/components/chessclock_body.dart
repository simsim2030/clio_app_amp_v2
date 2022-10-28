import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:clio_chess_amp_v2/Screens/ChessClock/components/button/chessclocksettingbtn.dart';
import 'package:clio_chess_amp_v2/Screens/ChessClock/components/customTimeControl/timecontrol_setting_dialog.dart';
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
  // Initialize Chess board Contorller
  ChessBoardController controller = ChessBoardController();

  // Initialize AWS api and IoT connection
  APIService apiservice = APIService();
  final MqttServerClient client = MqttServerClient(
      'a3s43fchdeum50-ats.iot.ap-southeast-2.amazonaws.com', '');
  String statusText = "Status Text";
  bool isConnected = false;

  // Initialize chess clock timer display
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

  // Timer Logic default values
  int movenumber = 0;
  int _firstpress = 0;
  int _presscount_top = 0;
  int _presscount_bot = 0;

  // Chessclock Play button logic default values
  int _clockState = 0;
  bool _gameRunning = false;
  bool _initializing = true;
  int _B_W = 0;

  // Take picture
  bool isGameStarted = false;

  // Uniqu device ID for each Clio
  String deviceID = '12345';

  // Init State
  @override
  void initState() {
    super.initState();
    apiservice.unsubscribe;

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

  // IoT Device inital connection value
  bool _iotConnected = false;
  void iotConnectionChange() {
    setState(() {
      _iotConnected = !_iotConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      // App Bar
      appBar: AppBar(
        actions: [
          (isGameStarted == false)
              ? IconButton(
                  onPressed: () {
                    // Trigger
                    const pubTopic = 'esp32/sub';
                    final builder = MqttClientPayloadBuilder();
                    builder.addString('0');
                    client.publishMessage(
                        pubTopic, MqttQos.atLeastOnce, builder.payload!);
                    isGameStarted = true;
                  },
                  icon: Icon(Icons.camera),
                )
              : IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera),
                  color: Colors.greenAccent[400],
                ),
          (_iotConnected == false)
              ? IconButton(
                  onPressed: () {
                    _connect();
                    iotConnectionChange();
                  },
                  icon: Icon(Icons.connect_without_contact_rounded),
                  color: Colors.grey,
                )
              : IconButton(
                  onPressed: () {
                    _disconnect();
                    iotConnectionChange();
                  },
                  icon: Icon(Icons.connect_without_contact_rounded),
                  color: Colors.greenAccent[400],
                ),
        ],
      ),
      body: Column(
        children: [
          // Top Timer Pad
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ChessClockTimer(
                onPressed: () {
                  _onTopPressed();
                  setState(() {
                    _gameRunning = true;
                    _initializing = false;
                    _B_W = -1;
                  });
                  print('gameRunning: ' + _gameRunning.toString());
                },
                colour: 'White',
                isReversed: true,
                isTicking: _topClock.isTicking(),
                isTimeup: _topClock.isTimeUp(),
                availableTime:
                    Duration(milliseconds: _topClock.getAvailableMillis()),
              ),
            ),
          ),
          // Middle Settings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Srtting Button
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    _topClock.pause();
                    _bottomClock.pause();
                    await createAlertDialog(context).then((value) {
                      // SnackBar mySnackbar =
                      //     SnackBar(content: Text("Hello $value"));
                      // Scaffold.of(context).showSnackBar(mySnackbar);
                      _topClock.timeControlMillis = value!;
                      _topClock.millisElapsed = 0;
                      _bottomClock.timeControlMillis = value;
                      _bottomClock.millisElapsed = 0;
                    });
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey[200],
                    size: 42,
                  ),
                ),
              ),
              //  Play/Pause Button
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    print('inti: ' + _initializing.toString());
                    print('gameRunning: ' + _gameRunning.toString());
                    print('BW: ' + this._B_W.toString());
                    if (_initializing == true) {
                      _bottomClock.pause();
                      _topClock.start();
                      _initializing = false;
                      _gameRunning = true;
                      _B_W = -1;
                    } else {
                      if (_gameRunning == true) {
                        _bottomClock.pause();
                        _topClock.pause();
                        _gameRunning = false;
                      } else if (_gameRunning == false && this._B_W == -1) {
                        _bottomClock.pause();
                        _topClock.start();
                        _gameRunning = true;
                      } else if (_gameRunning == false && _B_W == 1) {
                        _bottomClock.start();
                        _topClock.pause();
                        _gameRunning = true;
                      }
                    }
                  },
                  icon: Image.asset('assets/icons/pause.png'),
                ),
              ),
              // Reset Button
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _topClock = ChessClock(
                      getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
                      timeControlMillis: 5 * 60 * 1000,
                      incrementsMillis: 0,
                    );
                    _bottomClock = ChessClock(
                      getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
                      timeControlMillis: 5 * 60 * 1000,
                      incrementsMillis: 0,
                    );
                    print('gameRunning: ' + _gameRunning.toString());
                  },
                  icon: Icon(
                    Icons.restart_alt,
                    color: Colors.grey[200],
                    size: 42,
                  ),
                ),
              ),
            ],
          ),
          // Bottom Timer Pad
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChessClockTimer(
                onPressed: () {
                  _onBottomPressed();
                  setState(() {
                    _gameRunning = true;
                    _initializing = false;
                    _B_W = -1;
                  });
                },
                colour: 'Black',
                isTicking: _bottomClock.isTicking(),
                isTimeup: _bottomClock.isTimeUp(),
                availableTime:
                    Duration(milliseconds: _bottomClock.getAvailableMillis()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Timer Press Logic
  // Top Button Logic
  void _onTopPressed() {
    _topClock.pause();
    _bottomClock.start();
    setState(() {
      _gameRunning = true;
      _initializing = false;
      _B_W = 1;
    });

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
    builder.addString('-1');
    client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
  }

  // Bottom button logic
  void _onBottomPressed() {
    _topClock.start();
    _bottomClock.pause();
    setState(() {
      _gameRunning = true;
      _initializing = false;
      _B_W = -1;
    });

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

  // IOT Device Connection
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

  // IoT Device Disconnect
  _disconnect() {
    client.disconnect();
  }

  // IoT client setting
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

  void initalTrigger() {
    // Trigger
    const pubTopic = 'esp32/sub';
    final builder = MqttClientPayloadBuilder();
    builder.addString('0');
    client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
  }
}
