import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/project_model.dart';
import 'package:portfolio_website/utils/theme_selector.dart';
import 'package:portfolio_website/utils/view_wrapper.dart';
import 'package:portfolio_website/widgets/navigation_arrow.dart';
import 'package:portfolio_website/widgets/project_entry.dart';
import 'package:portfolio_website/widgets/project_image.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({Key key}) : super(key: key);

  @override
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  double screenWidth;
  double screenHeight;
  int selectedIndex = 0;
  List<Project> projects = [
    Project(
        title: 'Categorias',
        imageURL: 'livro1.jpg',
        description:
            'Cadastrar as categorias dos livros disponíveis no sistema.'),
    Project(
        title: 'Idiomas',
        imageURL: 'autores.jpg',
        description: 'Cadastrar os idiomas dos livros disponíveis no sistema.'),
    Project(
        title: 'Editoras',
        imageURL: 'escritor1.jpg',
        description:
            'Cadastrar as editoras dos livros disponíveis no sistema.'),
    Project(
        title: 'Livros',
        imageURL: 'livro.jpg',
        description: 'Cadastrar os livros disponíveis no sistema.'),
  ];

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage('project1.jpg'), context);
    precacheImage(AssetImage('project2.jpg'), context);
    precacheImage(AssetImage('project3.jpg'), context);
    precacheImage(AssetImage('project3.jpg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
    );
  }

  Widget desktopView() {
    double space = MediaQuery.of(context).size.height * 0.03;
    List<Widget> images =
        List.generate((projects.length * 1.5).ceil(), (index) {
      if (index.isEven) {
        return ProjectImage(
            project: projects[index ~/ 2],
            onPressed: () => updateIndex(index ~/ 2));
      } else {
        return SizedBox(height: space);
      }
    });

    return Stack(
      children: [
        NavigationArrow(isBackArrow: true),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.05, horizontal: screenWidth * 0.1),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: images,
              ),
              SizedBox(width: space),
              Container(
                height: screenHeight * 0.5 * 1.5 + space * 2,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/categoria');
                          },
                          child: Text('Cadastrar'),
                        ),
                        SizedBox(height: 200),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/idioma');
                          },
                          child: Text('Cadastrar'),
                        ),
                        SizedBox(height: 200),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/editora');
                          },
                          child: Text('Cadastrar'),
                        ),
                      ],
                    ),
                    AnimatedAlign(
                      alignment: selectedIndex == 0
                          ? Alignment.topCenter
                          : selectedIndex == 1
                              ? Alignment.center
                              : Alignment.bottomCenter,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.fastOutSlowIn,
                      child: Container(
                        color: Colors.white,
                        width: screenWidth * 0.05,
                        height: 3,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: space),
              Expanded(child: ProjectEntry(project: projects[selectedIndex]))
            ],
          ),
        )
      ],
    );
  }

  Widget mobileView() {
    List<Widget> projectList = List.generate(projects.length, (index) {
      return Column(
        children: [
          Text(
            projects[index].title,
            style: ThemeSelector.selectSubHeadline(context),
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            height: screenHeight * 0.1,
            width: screenWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                projects[index].imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            projects[index].description,
            style: ThemeSelector.selectBodyText(context),
          ),
          SizedBox(height: screenHeight * 0.1),
        ],
      );
    });
    return Column(children: projectList);
  }

  void updateIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }
}
