part of 'home_page.dart';

typedef OnLikeCallback = void Function(String title, bool isLiked)?;

class _CardPost extends StatefulWidget {
  final String description;
  final String? imageUrl;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;

  const _CardPost(this.description, {this.imageUrl, this.onLike, this.onTap});

  factory _CardPost.fromData(CardPostData data,
          {OnLikeCallback onLike, VoidCallback? onTap}) =>
      _CardPost(
        data.description,
        imageUrl: data.imageUrl,
        onLike: onLike,
        onTap: onTap,
      );

  @override
  State<_CardPost> createState() => _CardPostState();
}

class _CardPostState extends State<_CardPost> {
  bool isLiked = false;
  double iconScale = 1.0;

  void _onLikeTap() {
    setState(() {
      isLiked = !isLiked;
      iconScale = 2.0; // Increase scale temporarily
    });

    // Reset the scale back to normal after 250 milliseconds
    Timer(const Duration(milliseconds: 110), () {
      setState(() {
        iconScale = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                      widget.description,
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
              if (widget.imageUrl != null)
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
                            child: Image.asset(
                              widget.imageUrl!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20)),
                                  color: Colors.orange),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  "ОЧЕНЬ! вкусные мемы",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      // _onLikeTap;
                      setState(() {
                        isLiked = !isLiked;
                        iconScale = 2.0; // Increase scale temporarily
                      });

                      // Reset the scale back to normal after 250 milliseconds
                      Timer(const Duration(milliseconds: 110), () {
                        setState(() {
                          iconScale = 1.0;
                        });
                      });
                      widget.onLike?.call(widget.description, isLiked);
                    },
                    child: AnimatedScale(
                      scale: iconScale,
                      duration: const Duration(milliseconds: 250),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CardPostData {
//   final String description;
//   final String? imageUrl;
//
//   CardPostData(this.description, {this.imageUrl});
// }
