import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Condition;
import 'package:my_portfolio_ui/constants/colors.dart';
import 'package:my_portfolio_ui/controllers/projects_controller.dart';
import 'package:my_portfolio_ui/controllers/single_project_controller.dart';
import 'package:my_portfolio_ui/widgets/custom_text.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  ProjectsController projectsController = Get.find();
  SingleProjectController singleProjectController = Get.find();

  _buildSkill({imagePath}) => Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          // color: Colors.blue,
          image: DecorationImage(
            image: AssetImage(imagePath!),
            fit: BoxFit.fill,
            // colorFilter: ColorFilter.mode(Colors.blue, BlendMode.dstATop),
          ),
        ),
        // child: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.green.withOpacity(.9),
        //   ),
        // ),
      );

  _buildProject(context, index) => Center(
        child: Stack(
          children: [
            Container(
              height: ResponsiveValue(context, defaultValue: 520.0, valueWhen: [
                Condition.smallerThan(name: "600", value: 460.0)
              ]).value,
              width: ResponsiveValue(context, defaultValue: 650.0, valueWhen: [
                Condition.largerThan(name: "900", value: 550.0)
              ]).value,
              margin: EdgeInsets.only(top: 20, right: 15, left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: lightPurple),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    height: ResponsiveValue(context,
                        defaultValue: 360.0,
                        valueWhen: [
                          Condition.smallerThan(name: "430", value: 200.0),
                          Condition.smallerThan(name: "470", value: 250.0),
                          Condition.smallerThan(name: "500", value: 280.0),
                          Condition.smallerThan(name: "600", value: 300.0)
                        ]).value,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Image(
                      image: NetworkImage(
                          projectsController.projects[index].image!),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: projectsController.projects[index].name!,
                    size: 25,
                    weight: FontWeight.bold,
                    color: lightPurple,
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(right: 15, left: 15, bottom: 5),
                    child: RichText(
                      text: TextSpan(
                        text: projectsController.projects[index].description!,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: dark,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: (() => singleProjectController.goToSingleProject(
                        slug: projectsController.projects[index].slug)),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(right: 20, left: 20),
                      decoration: BoxDecoration(
                        color: darkPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomText(
                          text: "Learn More",
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: "What I've Made - Projects",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(right: 7, left: 7),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 30),
              Center(
                child: CustomText(
                  text: "Projects",
                  size: 30,
                  weight: FontWeight.bold,
                  color: dark,
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Take a look at what I've been working on.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: lightGrey,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSkill(imagePath: "assets/images/all.png"),
                  _buildSkill(imagePath: "assets/images/django.png"),
                  _buildSkill(imagePath: "assets/images/node.png"),
                  _buildSkill(imagePath: "assets/images/laravel.png"),
                  _buildSkill(imagePath: "assets/images/flutter.png"),
                  _buildSkill(imagePath: "assets/images/gh.png"),
                ],
              ),
              SizedBox(height: 20),
              if (projectsController.projects.isEmpty)
                SizedBox(
                  height:
                      ResponsiveValue(context, defaultValue: 600.0, valueWhen: [
                    Condition.largerThan(name: "400", value: 300.0),
                  ]).value!,
                  child: Center(
                    child: Image(
                      height: 80,
                      width: 80,
                      image: AssetImage("assets/images/loader.gif"),
                    ),
                  ),
                ),
              if (projectsController.projects.isNotEmpty)
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/projectsBackground.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveValue(
                        context,
                        defaultValue: 1,
                        valueWhen: [
                          Condition.largerThan(name: "900", value: 2)
                        ],
                      ).value!,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: ResponsiveValue(context,
                          defaultValue: 1.0,
                          valueWhen: [
                            Condition.largerThan(name: "500", value: 1.12),
                            Condition.largerThan(name: "600", value: 1.25),
                            Condition.largerThan(name: "700", value: 1.48),
                            Condition.largerThan(name: "800", value: 1.57),
                            Condition.largerThan(name: "900", value: 0.9),
                          ]).value!,
                    ),
                    itemCount: projectsController.projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildProject(context, index);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
