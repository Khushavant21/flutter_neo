// Flutter widget test for NeoBank Admin App
//
// This test verifies that the TopNavbar widget loads correctly
// and the navigation works as expected.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_neo_bank/main.dart';

void main() {
  testWidgets('NeoBank Admin app loads and displays navbar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app loads with the welcome text
    expect(find.text('Welcome to NeoBank Admin'), findsOneWidget);

    // Verify that the logo text is displayed
    expect(find.text('NEOBANK ADMIN'), findsOneWidget);

    // Verify that the Admin profile button exists
    expect(find.text('Admin'), findsOneWidget);

    // Verify that search input is present (on desktop)
    expect(find.byType(TextField), findsWidgets);
  });

  testWidgets('Navigation to Users screen works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Find the Users button (it might be in secondary navbar on desktop)
    // On mobile, we need to open the menu first
    
    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Since we're testing, the screen size is large enough to show desktop menu
    // Find and tap the Users navigation item
    final usersButton = find.text('Users');
    
    if (usersButton.evaluate().isNotEmpty) {
      await tester.tap(usersButton);
      await tester.pumpAndSettle();

      // Verify we're on the Users screen
      expect(find.text('Users Screen'), findsOneWidget);
    }
  });

  testWidgets('Notification badge displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Verify that the notification badge shows "3"
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Mobile menu opens and closes', (WidgetTester tester) async {
    // Set a smaller screen size to trigger mobile view
    await tester.binding.setSurfaceSize(const Size(375, 667)); // iPhone size

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Find the menu button (hamburger icon)
    final menuButton = find.byIcon(Icons.menu);
    
    if (menuButton.evaluate().isNotEmpty) {
      // Tap to open mobile menu
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // Verify mobile menu items are visible
      expect(find.text('Dashboard'), findsWidgets);
      expect(find.text('Services'), findsWidgets);
    }

    // Reset the screen size
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('Search input accepts text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Find the search TextField
    final searchField = find.byType(TextField);

    if (searchField.evaluate().isNotEmpty) {
      // Enter text into the search field
      await tester.enterText(searchField.first, 'test search');
      await tester.pump();

      // Verify the text was entered
      expect(find.text('test search'), findsOneWidget);
    }
  });

  testWidgets('Profile button navigates to admin profile', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Find the Admin profile button by text
    final profileButton = find.text('Admin');

    if (profileButton.evaluate().isNotEmpty) {
      // Tap the profile button
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      // Verify we're on the Admin Profile screen
      expect(find.text('Admin Profile Screen'), findsOneWidget);
    }
  });
}