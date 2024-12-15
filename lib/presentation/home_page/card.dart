part of 'home_page.dart';

typedef OnLikeCallback = void Function(String? id, String title, bool isLiked)?;

class _CardPost extends StatelessWidget {
  final String description;
  final String? imageUrl;
  final String? id;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;
  final bool isLiked;

  const _CardPost(this.description, {this.imageUrl, this.onLike, this.onTap, this.id, this.isLiked = false});

  factory _CardPost.fromData(CardPostData data, {OnLikeCallback onLike, VoidCallback? onTap, bool isLiked = false}) =>
      _CardPost(
        data.description ?? "Описание съел енот",
        imageUrl: data.imageUrl,
        onLike: onLike,
        onTap: onTap,
        isLiked: isLiked,
        id: data.id,
      );


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minHeight: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.teal,
          border: Border.all(
            color: const Color.fromARGB(255, 64, 46, 9),
            width: 0.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(
                0.0,
                5.0,
              ),
              blurRadius: 4.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              // IMAGE ROW

              const SizedBox(height: 10),
              if (imageUrl != null)
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              imageUrl!,
                              // height: 200,
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                          )),
                        ],
                      ),
                    )),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () => onLike?.call(id, description, isLiked),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: !isLiked
                          ? const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              key: ValueKey<int>(0),
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.orange,
                              key: ValueKey<int>(1),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
