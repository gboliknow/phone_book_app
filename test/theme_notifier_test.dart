import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_book_app/presentation/vm/theme_vm.dart';

void main() {
  test('Initial theme should be light mode', () {
    final themeNotifier = ThemeNotifier();

    expect(themeNotifier.isDarkMode, isFalse);
    expect(themeNotifier.currentTheme, equals(ThemeData.light()));
  });

  test('Toggling theme should switch to dark mode', () {
    final themeNotifier = ThemeNotifier();

    // Toggle to dark mode
    themeNotifier.toggleTheme();

    expect(themeNotifier.isDarkMode, isTrue);
    expect(themeNotifier.currentTheme, equals(ThemeData.dark()));
  });

  test('Toggling theme twice should switch back to light mode', () {
    final themeNotifier = ThemeNotifier();

    // Toggle to dark mode
    themeNotifier.toggleTheme();

    // Toggle back to light mode
    themeNotifier.toggleTheme();

    expect(themeNotifier.isDarkMode, isFalse);
    expect(themeNotifier.currentTheme, equals(ThemeData.light()));
  });
}
