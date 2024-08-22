import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    // Fetch user data from the API or cache
    user = await ApiService.getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 16),
                _buildUserBadges(),
                const SizedBox(height: 16),
                _buildUserInterests(),
                const SizedBox(height: 16),
                _buildVoiceNote(),
                const SizedBox(height: 16),
                _buildLookingFor(),
                const SizedBox(height: 16),
                _buildInterests(),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'wall st, nyc',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserBadges() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        children: user.badges.map((badge) => Chip(label: Text(badge))).toList(),
      ),
    );
  }

  Widget _buildUserInterests() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interests',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: user.interests
                .take(3)
                .map((interest) => Chip(label: Text(interest)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceNote() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Icon(Icons.mic),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              user.voiceNote,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLookingFor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Looking for:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children:
                user.lookingFor.map((tag) => Chip(label: Text(tag))).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInterests() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interests:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: user.interests
                .map((interest) => Chip(label: Text(interest)))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class User {
  final String name;
  final int age;
  final String avatarUrl;
  final List<String> badges;
  final List<String> interests;
  final String voiceNote;
  final List<String> lookingFor;

  User({
    required this.name,
    required this.age,
    required this.avatarUrl,
    required this.badges,
    required this.interests,
    required this.voiceNote,
    required this.lookingFor,
  });
}

class ApiService {
  static Future<User> getUserData() async {
    // Fetch user data from the API or cache
    return User(
      name: 'Aimie, 24',
      age: 24,
      avatarUrl: 'https://example.com/avatar.jpg',
      badges: ['Music', 'Fashion', 'Lifestyle'],
      interests: ['Music', 'Fashion', 'Lifestyle'],
      voiceNote: 'This is a voice note from the user.',
      lookingFor: ['Interests', 'New friends', 'New community'],
    );
  }
}
