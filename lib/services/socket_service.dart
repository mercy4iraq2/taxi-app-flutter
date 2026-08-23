import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../config/app_constants.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;
  bool _isConnected = false;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal() {
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io(
      AppConstants.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.on('connect', (_) {
      print('Socket connected');
      _isConnected = true;
    });

    socket.on('disconnect', (_) {
      print('Socket disconnected');
      _isConnected = false;
    });

    socket.on('error', (error) {
      print('Socket error: $error');
    });
  }

  // Connect socket
  void connect() {
    if (!_isConnected) {
      socket.connect();
    }
  }

  // Disconnect socket
  void disconnect() {
    if (_isConnected) {
      socket.disconnect();
    }
  }

  // Emit event
  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  // Listen to event
  void on(String event, Function callback) {
    socket.on(event, callback);
  }

  // Off event
  void off(String event) {
    socket.off(event);
  }

  // Update driver location
  void updateDriverLocation(double latitude, double longitude) {
    emit('updateLocation', {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Listen to new ride request
  void onRideRequest(Function callback) {
    on('rideRequest', callback);
  }

  // Listen to driver accepted
  void onDriverAccepted(Function callback) {
    on('driverAccepted', callback);
  }

  // Listen to driver arrived
  void onDriverArrived(Function callback) {
    on('driverArrived', callback);
  }

  // Listen to ride started
  void onRideStarted(Function callback) {
    on('rideStarted', callback);
  }

  // Listen to ride ended
  void onRideEnded(Function callback) {
    on('rideEnded', callback);
  }

  // Check if connected
  bool get isConnected => _isConnected;
}
