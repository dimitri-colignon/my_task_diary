import 'package:flutter/material.dart';

class InterfaceProvider with ChangeNotifier {
  int _indexDrawer = 0;
  int _indexButtonBottomNavigationBar = 0;
  DateTime _datePickerSelectedDate = DateTime.now();

  int get indexDrawer => _indexDrawer;
  int get indexButtonBottomNavigationBar => _indexButtonBottomNavigationBar;
  DateTime get datePickerSelectedDate => _datePickerSelectedDate;

  void changeDrawer(int newValue) {
    _indexDrawer = newValue;
    notifyListeners();
  }

  void changeButtonBottomNavigationBar(int newValue) {
    _indexButtonBottomNavigationBar = newValue;
    notifyListeners();
  }

  void changeDatePickerSelectedDate(DateTime newValue) {
    _datePickerSelectedDate = newValue;
    notifyListeners();
  }
}
