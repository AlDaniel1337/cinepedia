import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum AnimationType { fadeInLeft, fadeInDown, elasticIn, zoomIn, zoomOut, bounceInDown, bounceInUp, bounce }

/// Implementacion del paquete animate_do
class Animations extends StatelessWidget {

  final AnimationType? typeAnimation;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool animated;
  final double? from;
  final Function(AnimationController)? controller;
   
  const Animations({
    super.key, 
    this.typeAnimation, 
    required this.child, 
    this.duration = const Duration( milliseconds: 250),
    this.delay = Duration.zero, 
    this.animated = true, 
    this.from, 
    this.controller,
  });
  
  @override
  Widget build(BuildContext context) {
    return _getAnimation(child: child, typeAnimation: typeAnimation, duration: duration, delay: delay, animated: animated, from: from, controller: controller,);
  }

  Widget _getAnimation({AnimationType? typeAnimation, required Widget child, required Duration duration, required Duration delay, required bool animated, double? from, Function(AnimationController)? controller}){
    switch (typeAnimation) {
      case AnimationType.fadeInLeft: return FadeInLeft(from: from ?? 100, animate: animated, duration: duration, delay: delay, child: child);
      case AnimationType.fadeInDown: return FadeInDown(from: from ?? 100, animate: animated, duration: duration, delay: delay, child: child);    
      case AnimationType.elasticIn: return ElasticIn(animate: animated, duration: duration, delay: delay, child: child);    
      case AnimationType.zoomIn: return ZoomIn(from: from ?? 1.0, animate: animated, duration: duration, delay: delay, child: child);    
      case AnimationType.zoomOut: return ZoomOut(from: from ?? 0.0, animate: animated, duration: duration, delay: delay, child: child);    
      case AnimationType.bounceInDown: return BounceInDown(from: from ?? 75, animate: animated, duration: duration, delay: delay, child: child);    
      case AnimationType.bounceInUp: return BounceInUp(from: from ?? 75, animate: animated, duration: duration, delay: delay, child: child);    
      case AnimationType.bounce: return Bounce(from: from ?? 50, animate: animated, duration: duration, delay: delay, controller: controller, child: child);  
      default: return FadeInLeft(child: child);      
    }

  }

}

class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final bool animate;
  const FadeInAnimation({
    super.key, 
    required this.child,  
    this.animate = true
  });

  @override
  Widget build(BuildContext context) => FadeIn(animate: animate, child: child,);
}

class FadeInRightAnimation extends StatelessWidget {
  final Widget child;
  const FadeInRightAnimation({super.key, required this.child});
  @override
  Widget build(BuildContext context) => FadeInRight(child: child);
}

class SpinPerfectAnimation extends StatelessWidget {

  final Duration duration;
  final bool infinite;
  final Widget child;

  const SpinPerfectAnimation({
    super.key, 
    required this.child,  
    this.duration = const Duration(seconds: 2), 
    this.infinite = true
  });

  @override
  Widget build(BuildContext context) => SpinPerfect(
    infinite: infinite,
    duration: duration,
    spins: 25,
    child: child,
  );
} 

class FadeInUpAnimation extends StatelessWidget {

  final Widget child;
   
  const FadeInUpAnimation({
    super.key, 
    required this.child,  
  });
  
  @override
  Widget build(BuildContext context) => FadeInUp(
    child: child,
  );
}