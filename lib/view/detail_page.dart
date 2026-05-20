import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/detail_controller.dart';
import '../controller/favorite_controller.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(DetailController());

    final favoriteController =
        Get.find<FavoriteController>();

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Detail Show',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        // Loading State
        if (controller.isLoading.value) {
          return const Center(
            child:
                CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }

        if (controller
            .errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Text(
                controller
                    .errorMessage.value,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign:
                    TextAlign.center,
              ),
            ),
          );
        }

        final data =
            controller.detailShow;

        final image =
            data['image']?['original'] ??
                data['image']
                    ?['medium'];
        final title =
            data['name'] ?? '-';
        final rating =
            data['rating']?['average'];
        final genres =
            data['genres'] ?? [];
        final summaryRaw =
            data['summary'] ?? '-';
        final summary = controller
            .stripHtmlTags(
          summaryRaw.toString(),
        );

        return SingleChildScrollView(
          padding:
              const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // IMAGE
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  22,
                ),

                child: image != null
                    ? Image.network(
                        image,
                        width:
                            double.infinity,
                        height: 430,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 430,
                        width:
                            double.infinity,
                        color:
                            Colors.grey
                                .shade800,

                        child:
                            const Icon(
                          Icons
                              .image_not_supported,
                          color:
                              Colors.white,
                          size: 50,
                        ),
                      ),
              ),

              const SizedBox(
                height: 20,
              ),

              Text(
                title,
                style:
                    const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // RATING
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color:
                        Colors.amber,
                    size: 20,
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  Text(
                    rating != null
                        ? rating
                            .toString()
                        : 'N/A',

                    style:
                        const TextStyle(
                      color:
                          Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 16,
              ),

              const Text(
                'Genre',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Wrap(
                spacing: 10,
                runSpacing: 10,

                children:
                    List.generate(
                  genres.length,
                  (index) => Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFF1E1E1E,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        30,
                      ),

                      border:
                          Border.all(
                        color: Colors
                            .white12,
                      ),
                    ),

                    child: Text(
                      genres[index]
                          .toString(),

                      style:
                          const TextStyle(
                        color:
                            Colors
                                .white,
                        fontSize:
                            13,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              Row(
                children: [
                  // BUTTON NONTON
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child:
                          ElevatedButton.icon(
                        onPressed: () {},
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                            0xFFFF443A,
                          ),

                          foregroundColor:
                              Colors.white,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),

                        icon: const Icon(
                          Icons.play_arrow,
                          size: 22,
                        ),

                        label: const Text(
                          "Nonton",
                          style: TextStyle(
                            fontWeight:
                                FontWeight
                                    .w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  // BUTTON FAVORITE
                  Container(
                    height: 55,
                    width: 55,

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFF1E1E1E,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        14,
                      ),

                      border:
                          Border.all(
                        color: Colors
                            .white12,
                      ),
                    ),

                    child: IconButton(
                      onPressed: () {
                        favoriteController
                            .addFavorite(
                          id: data['id'],

                          title: title,

                          imageUrl:
                              image ?? '',

                          rating:
                              rating !=
                                      null
                                  ? double.parse(
                                      rating
                                          .toString(),
                                    )
                                  : 0.0,
                        );
                      },

                      icon: Icon(
                        favoriteController
                                .isFavorite(
                          data['id'],
                        )
                            ? Icons
                                .favorite
                            : Icons
                                .favorite_border,

                        color: favoriteController
                                .isFavorite(
                          data['id'],
                        )
                            ? Colors.red
                            : Colors
                                .white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 28,
              ),

              const Text(
                'Summary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Text(
                summary,
                style:
                    const TextStyle(
                  color: Colors.white70,
                  height: 1.7,
                  fontSize: 15,
                ),

                textAlign:
                    TextAlign.justify,
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      }),
    );
  }
}