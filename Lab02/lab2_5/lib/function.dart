import 'package:flutter/material.dart';

void showLanguageSelectionDialog(BuildContext context, String selectedLanguage, Function(String) onLanguageSelected) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Language'),
        content: Column(
          children: [
            _buildLanguageOption(context, 'English', selectedLanguage, onLanguageSelected),
            _buildLanguageOption(context, 'Spanish', selectedLanguage, onLanguageSelected),
            _buildLanguageOption(context, 'French', selectedLanguage, onLanguageSelected),
            _buildLanguageOption(context, 'German', selectedLanguage, onLanguageSelected),
            _buildLanguageOption(context, 'Chinese', selectedLanguage, onLanguageSelected),
          ],
        ),
      );
    },
  );
}
Widget _buildLanguageOption(BuildContext context, String language, String selectedLanguage, Function(String) onLanguageSelected) {
  return GestureDetector(
    onTap: () {
      onLanguageSelected(language);
      Navigator.pop(context); // Close the dialog after selection
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        language,
        style: TextStyle(
          color: language == selectedLanguage ? Colors.blue : Colors.black, // Highlight the selected language
        ),
      ),
    ),
  );
}

void showEnvSelectionDialog(BuildContext context, String selectedEnv, Function(String) onEnvSelected) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select environment'),
        content: Column(
          children: [
            _buildEnvOption(context, 'Production', selectedEnv, onEnvSelected),
            _buildEnvOption(context, 'Test', selectedEnv, onEnvSelected),
          ],
        ),
      );
    },
  );
}
Widget _buildEnvOption(BuildContext context, String env, String selectedEnv, Function(String) onEnvSelected) {
  return GestureDetector(
    onTap: () {
      onEnvSelected(env);
      Navigator.pop(context); // Close the dialog after selection
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        env,
        style: TextStyle(
          color: env == selectedEnv ? Colors.blue : Colors.black, // Highlight the selected language
        ),
      ),
    ),
  );
}

void showPlatformSelectionDialog(BuildContext context, String selectedPlatform, Function(String) onPlatformSelected) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select platform'),
        content: Column(
          children: [
            _buildEnvOption(context, 'Default', selectedPlatform, onPlatformSelected),
            _buildEnvOption(context, 'Website', selectedPlatform, onPlatformSelected),
            _buildEnvOption(context, 'Application', selectedPlatform, onPlatformSelected),
          ],
        ),
      );
    },
  );
}
Widget _buildPlatformOption(BuildContext context, String platform, String selectedPlatform, Function(String) onPlatformSelected) {
  return GestureDetector(
    onTap: () {
      onPlatformSelected(platform);
      Navigator.pop(context); // Close the dialog after selection
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        platform,
        style: TextStyle(
          color: platform == selectedPlatform ? Colors.blue : Colors.black, // Highlight the selected language
        ),
      ),
    ),
  );
}

