import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EEDC), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
        
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 8.0), 
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 80),
            
            Container(
              height: 220, 
              width: double.infinity, 
              decoration: BoxDecoration(
                color: Color(0xFF7CDA54), 
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 80), 
            
           
            const Text(
              'No te preocupes, comunícate con nosotros y te ayudamos a recuperar tu cuenta.',
              style: TextStyle(
                fontSize: 21,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 100), 
            
            
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                backgroundColor: const Color(0xFFFFFFFF), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 2, 
              ),
              onPressed: () {
                
              },
              icon: const Icon(Icons.add_circle, color: Color(0xFF00C853)), 
              label: const Text(
                'Contáctanos',
                style: TextStyle(color: Colors.black), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
