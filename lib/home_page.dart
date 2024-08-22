import 'package:flutter/material.dart';
import 'dart:math';

class FriendsInApp extends StatelessWidget {
  const FriendsInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends.in',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'lib/assets/fzin_logo.png',
              height: 220,
            ),
            const SizedBox(width: 8),
            const Text('(DMV)'),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityPage()),
                );
              },
              icon: const Icon(Icons.group),
            ),
          ],
        ),
        // backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllFriendsPage()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 270,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Friends',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Events',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                EventCarousel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement the community page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
      ),
      body: const Center(
        child: Text('Community page'),
      ),
    );
  }
}

class AllFriendsPage extends StatelessWidget {
  const AllFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement the all friends page
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Friends'),
      ),
      body: const Center(
        child: Text('All friends page'),
      ),
    );
  }
}

class EventCarousel extends StatelessWidget {
  const EventCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultImages = [
      'lib/assets/fzin_default1.jpg',
      'lib/assets/fzin_default2.jpg',
      'lib/assets/fzin_default3.jpg',
      'lib/assets/fzin_default4.jpg',
      'lib/assets/fzin_default5.jpg',
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          final randomIndex = Random().nextInt(defaultImages.length);
          final defaultImage = defaultImages[randomIndex];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventPage(index)),
                );
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(defaultImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Event ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventPage extends StatelessWidget {
  final int eventIndex;

  const EventPage(this.eventIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    // Implement the event page
    return Scaffold(
      appBar: AppBar(
        title: Text('Event ${eventIndex + 1}'),
      ),
      body: Center(
        child: Text('Event page for event ${eventIndex + 1}'),
      ),
    );
  }
}

class BotAssistant extends StatelessWidget {
  const BotAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.chat),
          SizedBox(width: 8),
          Text('Chat with AI assistant'),
        ],
      ),
    );
  }
}

class ChatButton extends StatelessWidget {
  const ChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement the chat functionality
      },
      child: const Text('Chat'),
    );
  }
}
