import 'package:flutter/material.dart';
import 'function.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _selectedLanguage = 'English';
  String _selectedEnv = 'Production';
  String _selectedPlatform = 'Default';
  bool isEnable = false;
  bool isLockapp = false;
  bool isFingerprint = false;
  bool isChangePass = false;
  bool isEnableNoti = false;

  void toggleEnable() {
    setState(() {
      isEnable = !isEnable;
    });
  }
  void toggleLock() {
    setState(() {
      isLockapp = !isLockapp;
    });
  }
  void toggleFinger() {
    setState(() {
      isFingerprint = !isFingerprint;
    });
  }
  void togglePass() {
    setState(() {
      isChangePass = !isChangePass;
    });
  }
  void toggleEnableNoti() {
    setState(() {
      isEnableNoti = !isEnableNoti;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 25),
                Text(
                  'Common',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ), // Common
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Show language selection dialog
                              showLanguageSelectionDialog(
                                context,
                                _selectedLanguage,
                                    (String selectedLanguage) {
                                  setState(() {
                                    _selectedLanguage = selectedLanguage;
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Icon(Icons.language, color: Colors.grey.shade700,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Language', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                        Row(
                                          children: [
                                            Text(_selectedLanguage, style: TextStyle(color: Colors.grey.shade600, fontSize: 18),),
                                            const SizedBox(width: 10),
                                            Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 18),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), // Language
                        Divider(color: Colors.grey.shade200, height: 1), // Adjust the height to make it thinner),
        
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Show environment selection dialog
                              showEnvSelectionDialog(
                                context,
                                _selectedEnv,
                                    (String selectedEnv) {
                                  setState(() {
                                    _selectedEnv = selectedEnv;
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Icon(Icons.cloud, color: Colors.grey.shade700,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Environment', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                        Row(
                                          children: [
                                            Text(_selectedEnv, style: TextStyle(color: Colors.grey.shade600, fontSize: 18),),
                                            const SizedBox(width: 10),
                                            Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 18),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), // Environment
                        const Divider(color: Colors.grey, height: 1), // Adjust the height to make it thinner),
        
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showPlatformSelectionDialog(
                                context,
                                _selectedPlatform,
                                    (String selectedPlatform) {
                                  setState(() {
                                    _selectedPlatform = selectedPlatform;
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Icon(Icons.screen_search_desktop_outlined, color: Colors.grey.shade700,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Platform', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                        Row(
                                          children: [
                                            Text(_selectedPlatform, style: TextStyle(color: Colors.grey.shade600, fontSize: 18),),
                                            const SizedBox(width: 10),
                                            Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 18),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), // Platform
                        const Divider(color: Colors.grey, height: 1), // Adjust the height to make it thinner),
        
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.dashboard_customize, color: Colors.grey.shade700,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Enable custom theme', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                    ],
                                  ),
                                ),
                              ),
                              Switch(
                                value: isEnable,
                                onChanged: (value) {
                                  toggleEnable();
                                },
                                activeTrackColor: Colors.greenAccent, // Set the active track color to green
                                activeColor: Colors.green.shade600, // Set the active color to green
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                        // Enable custom theme
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
        
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 25),
                Text(
                  'Account',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ), // Account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.phone, color: Colors.grey.shade700,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Phone number', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 18),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), // Phone number
                        Divider(color: Colors.grey.shade200, height: 1), // Adjust the height to make it thinner),
        
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.mail, color: Colors.grey.shade700,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Email', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 18),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),  // Email
                        const Divider(color: Colors.grey, height: 1), // Adjust the height to make it thinner),
        
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.logout, color: Colors.grey.shade700,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Sign out', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 18),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),  // Sign out
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
        
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 25),
                Text(
                  'Security',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ), // Security
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.phonelink_lock_sharp, color: Colors.grey.shade700,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Lock app in background', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                    ],
                                  ),
                                ),
                              ),
                              Switch(
                                value: isLockapp,
                                onChanged: (value) {
                                  toggleLock();
                                },
                                activeTrackColor: Colors.greenAccent, // Set the active track color to green
                                activeColor: Colors.green.shade600, // Set the active color to green
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ), // Lock app in background
                        Divider(color: Colors.grey.shade200, height: 1), // Adjust the height to make it thinner),
        
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.fingerprint, color: Colors.grey.shade700,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Use fingerprint', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                    ],
                                  ),
                                ),
                              ),
                              Switch(
                                value: isFingerprint,
                                onChanged: (value) {
                                  toggleFinger();
                                },
                                activeTrackColor: Colors.greenAccent, // Set the active track color to green
                                activeColor: Colors.green.shade600, // Set the active color to green
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),  // Use fingerprint
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 25),
                Text(
                  'Allow application to access stored fingerprint',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ), // Allow application to access stored fingerprint
        
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.lock, color: Colors.grey.shade700,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Change password', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                    ],
                                  ),
                                ),
                              ),
                              Switch(
                                value: isChangePass,
                                onChanged: (value) {
                                  togglePass();
                                },
                                activeTrackColor: Colors.greenAccent, // Set the active track color to green
                                activeColor: Colors.green.shade600, // Set the active color to green
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ), // Change password
                        Divider(color: Colors.grey.shade200, height: 1), // Adjust the height to make it thinner),
        
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(Icons.notifications_active, color: Colors.grey.shade700,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Enable notifications', style: TextStyle(color: Colors.grey.shade700, fontSize: 18),),
                                    ],
                                  ),
                                ),
                              ),
                              Switch(
                                value: isEnableNoti,
                                onChanged: (value) {
                                  toggleEnableNoti();
                                },
                                activeTrackColor: Colors.greenAccent, // Set the active track color to green
                                activeColor: Colors.green.shade600, // Set the active color to green
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),  // Enable notifications
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
