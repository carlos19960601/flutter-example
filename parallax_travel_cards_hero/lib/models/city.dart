import 'package:flutter/material.dart';

class City {
  final String name;
  final String title;
  final String description;
  final String information;
  final Color color;
  final List<Hotel> hotels;

  City({
    required this.title,
    required this.name,
    required this.description,
    required this.information,
    required this.color,
    required this.hotels,
  });
}

class Hotel {
  final String name;
  final double rating;
  final int reviews;
  final double price;

  Hotel(
    this.name, {
    required this.reviews,
    required this.price,
    required this.rating,
  });
}

final City demoCity = City(
  name: 'Paris',
  title: 'Paris, France',
  description:
      'Get ready to explore the city of love filled with romantic scenery and experiences.',
  information:
      'Paris, located along the Seine River, in the north-central part of France. For centuries, Paris has been one of the world’s most important and attractive cities.',
  color: const Color(0xfffdeed5),
  hotels: [
    Hotel('Shangri-La Hotel Paris', reviews: 201, price: 593.0, rating: 5),
    Hotel('Hôtel Trinité Haussmann', reviews: 133, price: 391, rating: 3),
    Hotel('Maison Breguet', reviews: 128, price: 399, rating: 4),
  ],
);
