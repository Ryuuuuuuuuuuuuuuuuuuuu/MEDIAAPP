import 'package:flutter/material.dart';

void main() {
  runApp(FBCloneBetterUI());
}

class FBCloneBetterUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FB Clone Modern UI',
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

// Dummy Data
final List<Map<String, String>> stories = [
  {'name': 'Alice', 'image': 'https://i.pravatar.cc/150?img=1'},
  {'name': 'Bob', 'image': 'https://i.pravatar.cc/150?img=2'},
  {'name': 'Charlie', 'image': 'https://i.pravatar.cc/150?img=3'},
  {'name': 'Diana', 'image': 'https://i.pravatar.cc/150?img=4'},
];

class Post {
  final String name;
  final String profile;
  final String time;
  final String postImage;
  final String text;
  String? reaction;
  List<String> comments;

  Post({
    required this.name,
    required this.profile,
    required this.time,
    required this.postImage,
    required this.text,
    this.reaction,
    List<String>? comments,
  }) : comments = comments ?? [];
}

final List<Post> posts = [
  Post(
      name: 'Alice',
      profile: 'https://i.pravatar.cc/150?img=1',
      time: '2h',
      postImage: 'https://picsum.photos/400/250?random=1',
      text: 'Enjoying the beautiful sunset!'),
  Post(
      name: 'Bob',
      profile: 'https://i.pravatar.cc/150?img=2',
      time: '5h',
      postImage: 'https://picsum.photos/400/250?random=2',
      text: 'Had an amazing lunch today.'),
  Post(
      name: 'Charlie',
      profile: 'https://i.pravatar.cc/150?img=3',
      time: '1d',
      postImage: 'https://picsum.photos/400/250?random=3',
      text: 'Workout completed 💪'),
];

// Dummy users for "Add Friend"
class User {
  final String name;
  final String profile;
  bool isFriend;
  User({required this.name, required this.profile, this.isFriend = false});
}

final List<User> users = [
  User(name: 'Eva', profile: 'https://i.pravatar.cc/150?img=5'),
  User(name: 'Frank', profile: 'https://i.pravatar.cc/150?img=6'),
  User(name: 'Grace', profile: 'https://i.pravatar.cc/150?img=7'),
  User(name: 'Henry', profile: 'https://i.pravatar.cc/150?img=8'),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // This is the main feed logic you had in your body
    SingleChildScrollView(
      child: Column(
        children: [
          StoriesSection(),
          SizedBox(height: 10),
          ...posts.map((post) => PostCard(post: post)).toList(),
          SizedBox(height: 10),
          PeopleYouMayKnow(),
        ],
      ),
    ),
    Center(child: Text("Chat Page")),
    Center(child: Text("Create Page")),
    Center(child: Text("Notifications Page")),
    Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConnectHub'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wechat_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class StoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Add to Your Story")),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?img=9',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.add, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Your Story", style: TextStyle(fontSize: 12)),
                ],
              ),
            );
          }
          final story = stories[index - 1];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.orange],
                    ),
                  ),
                  padding: EdgeInsets.all(3),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(story['image']!),
                  ),
                ),
                SizedBox(height: 5),
                Text(story['name']!, style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;
  PostCard({required this.post});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final TextEditingController _commentController = TextEditingController();

  void _showReactions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _reactionItem("👍"),
              _reactionItem("❤️"),
              _reactionItem("😂"),
              _reactionItem("😮"),
              _reactionItem("😢"),
              _reactionItem("😡"),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Add custom reaction")),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: Icon(Icons.add, size: 24, color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _reactionItem(String emoji) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.post.reaction = emoji;
        });
        Navigator.pop(context);
      },
      child: Text(emoji, style: TextStyle(fontSize: 28)),
    );
  }

  void _addComment(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      widget.post.comments.add(text.trim());
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.post.profile),
              ),
              title: Text(widget.post.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(widget.post.time),
              trailing: Icon(Icons.more_horiz),
            ),
            if (widget.post.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(widget.post.text),
              ),
            if (widget.post.postImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(widget.post.postImage, fit: BoxFit.cover),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    icon: widget.post.reaction != null
                        ? Text(widget.post.reaction!,
                        style: TextStyle(fontSize: 20))
                        : Icon(Icons.thumb_up_outlined, color: Colors.grey[800]),
                    label: Text(
                      widget.post.reaction ?? 'Like',
                      style: TextStyle(
                        color: widget.post.reaction != null
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                    onPressed: _showReactions,
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.comment_outlined, color: Colors.grey[800]),
                    label: Text('Comment',
                        style: TextStyle(color: Colors.grey[800])),
                    onPressed: () {},
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.share_outlined, color: Colors.grey[800]),
                    label:
                    Text('Share', style: TextStyle(color: Colors.grey[800])),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            if (widget.post.comments.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.post.comments
                      .map((c) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text('- $c'),
                  ))
                      .toList(),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () => _addComment(_commentController.text),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PeopleYouMayKnow extends StatefulWidget {
  @override
  _PeopleYouMayKnowState createState() => _PeopleYouMayKnowState();
}

class _PeopleYouMayKnowState extends State<PeopleYouMayKnow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text('People You May Know',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.profile),
                    ),
                    SizedBox(height: 5),
                    Text(user.name),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          user.isFriend = !user.isFriend;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        user.isFriend ? Colors.grey : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      ),
                      child: Text(user.isFriend ? 'Friends' : 'Add Friend'),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}