import 'package:attendencesheet/apis/api_service.dart';
import 'package:attendencesheet/controllers/reporting_manager_controller.dart';
import 'package:attendencesheet/widgets/date_text_field.dart';
import 'package:attendencesheet/widgets/drop_down_textfield.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';


class ApplyLeaveScreen extends StatefulWidget {

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {

  bool isLoading = false;

  final ReportingManagerController reportingManagerController = Get.find();

  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final numberOfDaysController = SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
            'LEAVES EDIT',
            style: Ktextstyledaily),
      ),
      body: (isLoading) ? const Center(child: CircularProgressIndicator()) :Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Leave date
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'LEAVE DATE',
                        style: KtextstyleActivity,
                      )),
                  const SizedBox(height: 10),
                  ///Calendar textfield
                  DateTextField(dateController: dateController),
                  const SizedBox(height: 20),
                  ///description text
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'DESCRIPTION',
                        style: KtextstyleActivity,
                      )),
                  const SizedBox(height: 10),
                  ///description controller
                  TextFormField(
                    style:KtextstyleActivity1,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      hintStyle: KtextstyleActivity1,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ///Number of days text
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'NUMBER OF DAYS',
                        style: KtextstyleActivity,
                      )),
                  const SizedBox(height: 10),
                  ///Number of days textfield
                  DropDownTextFielD(
                      dropDownList: const [
                        DropDownValueModel(name: '0.5', value: '0.5'),
                        DropDownValueModel(name: '1', value: '1')
                      ],
                    hintText: 'Select Days',
                    controller: numberOfDaysController,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'APPROVING MANAGER',
                        style: KtextstyleActivity,
                      )),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("${reportingManagerController.reportingManagerFirstName.value} ${reportingManagerController.reporintManagerLastName.value}",style: KtextstyleActivity1,),
                    )),
                ],
              ),
              /// cancel and submit buttons
              Row(children: [
                Expanded(
                    flex: 4,
                    child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Card(
                              color: Colors.grey,
                              child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: Ktextstylecardbutton,
                                  ))),
                        ))),
                ///submit
                Expanded(
                  flex: 6,
                  child: SizedBox(
                      height: 60,
                      child: GestureDetector(
                          onTap: () async{
                            setState(() {
                              isLoading = true;
                            });
                            var  employeeLeaveModel = await ApiService.setLeaveData(
                                dateController.text,
                                numberOfDaysController.dropDownValue!.value.toString(),
                                descriptionController.text);
                            if(employeeLeaveModel.status == "1234567890"){
                              Get.snackbar("Unable to apply leave", "You have alredy applied for given date",
                                snackPosition: SnackPosition.TOP,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                            else{
                              setState(() {
                                isLoading = false;
                              });
                              Get.back();
                              Get.back();
                            }
                          },
                          child: const Card(
                              color: Colors.orangeAccent,
                              child: Center(
                                  child: Text(
                                    'SUBMIT',
                                    style: Ktextstylecardbutton,
                                  )))
                      )),
                )])
            ],
          ),
        ),
      ),
    );
  }
}
