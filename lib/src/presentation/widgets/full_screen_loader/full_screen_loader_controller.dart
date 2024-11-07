import 'dart:async';

class FullScreenLoaderController{
    
  static final _messages = <String>[
    'Espere por favor.',
    'Espere por favor..',
    'Espere por favor...',
    'Espere por favor....',
    'Espere por favor.....',
  ];

  /// Regresar mensaje, el cual cambia cada cierto tiempo
  static Stream<String> getLoadingMessages(){
    return Stream.periodic( const Duration( milliseconds: 1200), (step){
      return _messages[step];
    })
    .take(_messages.length);
  }
}