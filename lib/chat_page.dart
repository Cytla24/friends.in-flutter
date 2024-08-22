import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _selectedIndex = 0;
  final List<Chat> _generalChats = [
    Chat(
      sender: 'John Doe',
      senderAvatarUrl: 'https://example.com/avatar1.jpg',
      message: 'Hey, whats up',
    ),
    Chat(
      sender: 'Jane Smith',
      senderAvatarUrl: 'https://example.com/avatar2.jpg',
      message: 'Just chilling, you?',
    ),
    // Add more general chats
  ];
  final List<Friend> _friends = [
    Friend(
      name: 'Alice',
      avatarUrl: 'https://example.com/avatar3.jpg',
      lastMessage: 'See you later!',
    ),
    Friend(
      name: 'Bob',
      avatarUrl: 'https://example.com/avatar4.jpg',
      lastMessage: 'Sounds good!',
    ),
    // Add more friends
  ];
  final _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex =
                          0; // Update the selected index to 0 (General)
                    });
                  },
                  child: Container(
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        'General',
                        style: TextStyle(
                          color:
                              _selectedIndex == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex =
                          1; // Update the selected index to 1 (Friends)
                    });
                  },
                  child: Container(
                    color: _selectedIndex == 1 ? Colors.blue : Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        'Friends',
                        style: TextStyle(
                          color:
                              _selectedIndex == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? _buildGeneralChat()
          : _buildFriendsList(), // Render the appropriate content based on the selected index
      bottomNavigationBar: _selectedIndex == 0 ? _buildChatInput() : null,
    );
  }

  Widget _buildGeneralChat() {
    return ListView.builder(
      itemCount: _generalChats.length,
      itemBuilder: (context, index) {
        final chat = _generalChats[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(chat.senderAvatarUrl),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.sender,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(chat.message),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFriendsList() {
    return ListView.builder(
      itemCount: _friends.length,
      itemBuilder: (context, index) {
        final friend = _friends[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(friend.avatarUrl),
          ),
          title: Text(friend.name),
          subtitle: Text(friend.lastMessage),
          onTap: () {
            // Navigate to the friend's chat page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FriendChatPage(friend: friend),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _chatController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              // Send the message
              _sendMessage();
            },
            icon: const Icon(Icons.send),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              // Open the emoji selector
              _showEmojiSelector();
            },
            icon: const Icon(Icons.emoji_emotions),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _chatController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _generalChats.add(
          Chat(
            sender: 'You',
            senderAvatarUrl: 'https://example.com/avatar.jpg',
            message: message,
          ),
        );
        _chatController.clear();
      });
    }
  }

  void _showEmojiSelector() {
    // Implement the emoji selector functionality
  }
}

class Chat {
  final String sender;
  final String senderAvatarUrl;
  final String message;

  Chat({
    required this.sender,
    required this.senderAvatarUrl,
    required this.message,
  });
}

class Friend {
  final String name;
  final String avatarUrl;
  final String lastMessage;

  Friend({
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
  });
}

class FriendChatPage extends StatefulWidget {
  final Friend friend;

  FriendChatPage({required this.friend});

  @override
  _FriendChatPageState createState() => _FriendChatPageState();
}

class _FriendChatPageState extends State<FriendChatPage> {
  final _chatController = TextEditingController();
  final _messages = <Chat>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.friend.avatarUrl),
            ),
            const SizedBox(width: 8),
            Text(widget.friend.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(message.senderAvatarUrl),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.sender,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(message.message),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    _sendMessage();
                  },
                  icon: const Icon(Icons.send),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    _showEmojiSelector();
                  },
                  icon: const Icon(Icons.emoji_emotions),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _chatController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add(
          Chat(
            sender: 'You',
            senderAvatarUrl: 'https://example.com/avatar.jpg',
            message: message,
          ),
        );
        _chatController.clear();
      });
    }
  }

  void _showEmojiSelector() {
    // Implement the emoji selector functionality
  }
}
