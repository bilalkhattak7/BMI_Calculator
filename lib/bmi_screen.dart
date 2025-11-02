import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  double _height = 170;
  double _weight = 70;
  double _bmi = 0;
  String _bmiCategory = '';
  String _bmiDescription = '';

  void _calculateBMI() {
    setState(() {
      // BMI formula: weight (kg) / height (m) squared
      double heightInMeters = _height / 100;
      _bmi = _weight / (heightInMeters * heightInMeters);
      _updateBMICategory();
    });
  }

  void _updateBMICategory() {
    if (_bmi < 18.5) {
      _bmiCategory = 'Underweight';
      _bmiDescription = 'You may need to gain some weight. Consider consulting a nutritionist.';
    } else if (_bmi >= 18.5 && _bmi < 25) {
      _bmiCategory = 'Normal Weight';
      _bmiDescription = 'Great! You have a healthy body weight. Maintain your current lifestyle.';
    } else if (_bmi >= 25 && _bmi < 30) {
      _bmiCategory = 'Overweight';
      _bmiDescription = 'Consider some lifestyle changes like exercise and balanced diet.';
    } else {
      _bmiCategory = 'Obese';
      _bmiDescription = 'It\'s recommended to consult a healthcare professional for guidance.';
    }
  }

  Color _getBMIColor() {
    if (_bmi < 18.5) return Colors.blue;
    if (_bmi >= 18.5 && _bmi < 25) return Colors.green;
    if (_bmi >= 25 && _bmi < 30) return Colors.orange;
    return Colors.red;
  }

  @override
  void initState() {
    super.initState();
    _calculateBMI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Height Section
            _buildHeightSection(),
            SizedBox(height: 30),
            // Weight Section
            _buildWeightSection(),
            SizedBox(height: 40),
            // Calculate Button
            _buildCalculateButton(),
            SizedBox(height: 40),
            // Results Section
            _buildResultsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.height, color: Colors.blue, size: 24),
                SizedBox(width: 8),
                Text(
                  'HEIGHT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '${_height.toStringAsFixed(0)} cm',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Slider(
              value: _height,
              min: 100,
              max: 220,
              divisions: 120,
              label: '${_height.toStringAsFixed(0)} cm',
              onChanged: (value) {
                setState(() {
                  _height = value;
                  _calculateBMI();
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.grey[300],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('100 cm', style: TextStyle(color: Colors.grey)),
                Text('220 cm', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.monitor_weight, color: Colors.green, size: 24),
                SizedBox(width: 8),
                Text(
                  'WEIGHT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '${_weight.toStringAsFixed(0)} kg',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Slider(
              value: _weight,
              min: 30,
              max: 150,
              divisions: 120,
              label: '${_weight.toStringAsFixed(0)} kg',
              onChanged: (value) {
                setState(() {
                  _weight = value;
                  _calculateBMI();
                });
              },
              activeColor: Colors.green,
              inactiveColor: Colors.grey[300],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30 kg', style: TextStyle(color: Colors.grey)),
                Text('150 kg', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton.icon(
      onPressed: _calculateBMI,
      icon: Icon(Icons.calculate),
      label: Text(
        'CALCULATE BMI',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Card(
      elevation: 4,
      color: _getBMIColor().withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'YOUR BMI RESULT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _bmi.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: _getBMIColor(),
              ),
            ),
            SizedBox(height: 10),
            Text(
              _bmiCategory,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getBMIColor(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _getBMIColor().withOpacity(0.3)),
              ),
              child: Text(
                _bmiDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildBMIScale(),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIScale() {
    return Column(
      children: [
        Text(
          'BMI Scale',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            _buildScaleItem('Underweight', '<18.5', Colors.blue),
            _buildScaleItem('Normal', '18.5-24.9', Colors.green),
            _buildScaleItem('Overweight', '25-29.9', Colors.orange),
            _buildScaleItem('Obese', '30+', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildScaleItem(String label, String range, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              range,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}