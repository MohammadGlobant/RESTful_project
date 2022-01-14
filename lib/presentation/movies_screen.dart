import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:restful_project/business_logic/movies_cubit.dart';
import 'package:restful_project/constants/project_colors.dart';
import 'package:restful_project/data/models/Results.dart';

import 'items/movie_item.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);
  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late List<Results> allMovies;
  late List<Results> searchedForMovies;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: ProjectColors.projectBlackColor,
      decoration: const InputDecoration(
        hintText: 'Find movie ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: ProjectColors.projectBlackColor, fontSize: 18),
      ),
      style: const TextStyle(color: ProjectColors.projectBlackColor, fontSize: 18),
      onChanged: (searchedMovie) {
        addSearchedFOrItemsToSearchedList(searchedMovie);
      },
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedMovie) {
    searchedForMovies = allMovies
        .where((movie) =>
        movie.originalTitle.toString().toLowerCase().startsWith(searchedMovie))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: ProjectColors.projectBlackColor),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: ProjectColors.projectBlackColor,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesCubit>(context).getAllMovies();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          allMovies = (state).movies;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: ProjectColors.projectBlackColor,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildMovieList(),
        ],
      ),
    );
  }

  Widget buildMovieList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allMovies.length
          : searchedForMovies.length,
      itemBuilder: (ctx, index) {
        return MovieItem(
          movie: _searchTextController.text.isEmpty
              ? allMovies[index]
              : searchedForMovies[index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Movies',
      style: TextStyle(color: ProjectColors.projectBlackColor),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: ProjectColors.projectBlackColor,
              ),
            ),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.projectBlackColor,
      appBar: AppBar(
        backgroundColor: ProjectColors.projectRedColor,
        leading: _isSearching
            ? const BackButton(
          color: ProjectColors.projectBlackColor,
        )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
