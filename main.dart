import 'package:flutter/material.dart';

void main() {
  runApp(JuliaGymApp());
}

class JuliaGymApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Julia Gym',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, // Button background color
          textTheme: ButtonTextTheme.primary, // Button text color
        ),
      ),
      home: ExerciseSelectionScreen(),
    );
  }
}

class ExerciseSelectionScreen extends StatefulWidget {
  @override
  _ExerciseSelectionScreenState createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  List<String> selectedExercises = [];

  final Map<String, List<String>> exercises = {
    'Leg': ['Jumping Jack', 'Skipping', 'Mountain Climber', 'Squats', 'Lunges'],
    'Abs': ['Crunches', 'Plank', 'Bicycle Crunch', 'Leg Raises', 'Sit-ups'],
    'Shoulder': [
      'Shoulder Press',
      'Lateral Raise',
      'Front Raise',
      'Reverse Fly'
    ],
    'Chest': [
      'Push-ups',
      'Chest Press',
      'Chest Fly',
      'Incline Press',
      'Decline Press'
    ],
    'Waist': [
      'Side Bend',
      'Russian Twist',
      'Standing Oblique Crunch',
      'Side Plank'
    ],
    'Biceps': ['Bicep Curl', 'Hammer Curl', 'Concentration Curl', 'Cable Curl'],
    'Ribs': ['Side Stretch', 'Oblique Crunch', 'Rib Cage Pull', 'Torso Twist'],
    'Thighs': [
      'Thigh Adductor',
      'Thigh Abductor',
      'Leg Press',
      'Hamstring Curl'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Julia\'s Gym'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Which exercise do you want to do?',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: ListView(
                children: exercises.keys.map((category) {
                  return CheckboxListTile(
                    title: Text(category),
                    value: selectedExercises.contains(category),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedExercises.add(category);
                        } else {
                          selectedExercises.remove(category);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: selectedExercises.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetailsScreen(
                              selectedExercises: selectedExercises,
                              exercises: exercises),
                        ),
                      );
                    }
                  : null,
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseDetailsScreen extends StatelessWidget {
  final List<String> selectedExercises;
  final Map<String, List<String>> exercises;

  ExerciseDetailsScreen(
      {required this.selectedExercises, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: selectedExercises.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to $category exercises, enjoy fitness.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: exercises[category]!.map((exercise) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('- $exercise'),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
