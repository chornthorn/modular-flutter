import 'package:flutter/material.dart';
import 'package:modular_flutter/modular_flutter.dart';
import 'package:viewmodel/viewmodel.dart';
import '../providers/post_providers.dart';
import '../states/posts_list_state.dart';

class PostsListScreen extends ConsumerWidget {
  const PostsListScreen({super.key});

  Future<void> _refreshPosts(WidgetRef ref) async {
    await ref.read(postsListViewModelProvider.notifier).refreshPosts();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postsListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshPosts(ref),
          ),
        ],
      ),
      body: _buildBody(context, state, ref),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create post screen
          // This will be implemented later
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create post feature coming soon!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PostsListState state, WidgetRef ref) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading posts',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.errorMessage,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _refreshPosts(ref),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.posts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.post_add, size: 64),
            SizedBox(height: 16),
            Text('No posts found', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        final post = state.posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                post.id.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              post.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              post.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to post details
              context.push('/posts/${post.id}');
            },
          ),
        );
      },
    );
  }
}
