import 'package:flutter/material.dart';

class PageManager {
  final PageController _pageController;

  PageManager({required PageController pageController}) : _pageController = pageController;

  int page = 0;

  void setPage(int value) {
    if (value == page) return;
    page = value;
    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }
}