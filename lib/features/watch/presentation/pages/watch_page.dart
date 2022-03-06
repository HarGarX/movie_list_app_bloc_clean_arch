import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/watch_bloc.dart';
import '../widgets/movie_widget.dart';

// KEY   259f88559587d69d838d005f57b77929
// Image Url http://image.tmdb.org/t/p/w500/
class WatchPage extends StatefulWidget {
  const WatchPage({Key? key}) : super(key: key);

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  late WatchBloc watchBloc;
  @override
  void initState() {
    super.initState();
    print("Firing The Event");
    watchBloc = BlocProvider.of<WatchBloc>(context);
    watchBloc.add(LoadUpcomingMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0xFF2E2739).withOpacity(0.1),
    ));
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF2E2739).withOpacity(0.1),
          appBar: AppBar(
            // shadowColor: Colors.white,
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Watch',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF202C43),
                  fontSize: 19.sp,
                  height: 0.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            centerTitle: true,
            toolbarHeight: 15.h,
            titleSpacing: 2.w,

            actions: [
              GestureDetector(
                // onTap: (() => Get.toNamed(Routes.SEARCH_RESULT)),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, right: 15.0, bottom: 15.0, left: 15.0),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF202C43),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body:
              // !!!! LOADER
              BlocConsumer<WatchBloc, WatchState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is WatchLoading) {
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: const Color(0xFF2E2739),
                    backgroundColor: const Color(0xFF2E2739).withOpacity(0.1),
                  ),
                );
              } else if (state is WatchSuccess) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(4.0.w).copyWith(top: 3.5.h),
                    child: ListView.builder(
                      itemCount: state.movieModel.length,
                      itemBuilder: ((context, index) {
                        // return Text(index.toString());
                        return MovieWidget(
                          movieModel: state.movieModel[index],
                        );
                      }),
                    ),
                  ),
                );
              } else if (state is WatchFailed) {
                return GestureDetector(
                  onTap: (() => watchBloc.add(LoadUpcomingMoviesEvent())),
                  child: Center(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.error,
                          color: AppColors.darkPurple,
                          size: 50,
                        ),
                        Text('Somthing Went Wrong'),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  child: const Center(child: Text('Inital')),
                );
              }
            },
          )
          //  !!! MOVIES
          // Center(
          //     child: Padding(
          //       padding: EdgeInsets.all(4.0.w).copyWith(top: 3.5.h),
          //       child: ListView.builder(
          //         itemCount: watchController
          //             .movieService.upComingMoviesList.length,
          //         itemBuilder: ((context, index) {
          //           return MovieWidget(
          //             movieModel: watchController
          //                 .movieService.upComingMoviesList[index],
          //           );
          //         }),
          //       ),
          //     ),
          //   ),
          ),
    );
  }
}
