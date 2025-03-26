import 'package:fit_food/Constants/export.dart';
import '../../Models/foodsubcat_model.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SafeArea(
          child: Column(
            children: [
              buildSearchBar(),
              const SizedBox(height: defaultPadding),
              searchController.text.isEmpty
                  ? Container()
                  : Expanded(
                      child: FutureBuilder<FoodSubCategoryModel>(
                        future: HomeUtils().getSearch(searchController.text),
                        builder: (context, snapshot) => snapshot.hasData
                            ? snapshot.data!.data!.isEmpty
                                ? Center(
                                    child: Text('No Result found',
                                        style: Style.largeTextStyle),
                                  )
                                : Scrollbar(
                                    interactive: true,
                                    thickness: 8,
                                    trackVisibility: true,
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.data!.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          buildFoodsCard(size, snapshot, index),
                                    ),
                                  )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextFormField(
        controller: searchController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(
              Radius.circular(12.00),
            ),
          ),
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
        ),
      ),
    );
  }
}
