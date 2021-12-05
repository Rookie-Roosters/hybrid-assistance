import 'package:flutter/material.dart' hide Center;
import 'package:get/get.dart';
// import 'package:hybrid_assistance/models/career.dart';
// import 'package:hybrid_assistance/models/center.dart';
// import 'package:hybrid_assistance/models/academic_load.dart';
// import 'package:hybrid_assistance/models/department.dart';
// import 'package:hybrid_assistance/models/group.dart';
// import 'package:hybrid_assistance/models/subject.dart';
import 'package:hybrid_assistance/models/student.dart';
import 'academic_load_controller.dart';
export 'academic_load_controller.dart';

class AcademicLoadForm extends GetView<AcademicLoadController> {
  const AcademicLoadForm({Key? key}) : super(key: key);

  String? validateStudent(String? value) {
    if (!controller.academicLoad.validateId6(value)) {
      return 'ID no válido';
    } else {
      Student.exist(int.tryParse(value!)!).then((value) {
        if (value) {
          return null;
        } else {
          return 'No existe ningún estudiante con ese ID';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final update = Get.arguments;
    if (update != null) controller.academicLoad = update;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: update == null
            ? const Text('Agregar Curso')
            : const Text('Modificar Curso'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formStateKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                    initialValue:
                        update == null ? '' : controller.academicLoad.id.toString(),
                    validator: (value) =>
                        controller.academicLoad.validateNumber(value)
                            ? null
                            : 'ID no válido',
                    onSaved: (value) => controller.academicLoad.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ID Estudiante',
                    ),
                    initialValue:
                        update == null ? '' : controller.academicLoad.student!.id.toString(),
                    validator: validateStudent,
                    onSaved: (value) => controller.academicLoad.id =
                        value == null ? 0 : int.tryParse(value)!,
                  ),
                  const Divider(height: 36.0,),
                  ElevatedButton(
                    child: update == null
                        ? const Text('Agregar')
                        : const Text('Modificar'),
                    onPressed: () {
                      if (update == null) {
                        controller.add();
                      } else {
                        controller.update();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class GroupDropdownButtons extends StatefulWidget {
//   final AcademicLoadController controller;
//   final AcademicLoad? update;

//   const GroupDropdownButtons(
//       {Key? key, required this.controller, required this.update})
//       : super(key: key);

//   @override
//   _GroupDropdownButtonsState createState() => _GroupDropdownButtonsState();
// }

// class _GroupDropdownButtonsState extends State<GroupDropdownButtons> {
//   List<Center> centers = [];
//   List<Department> departments = [];
//   List<Career> careers = [];
//   List<Group> groups = [];
//   Center? centerValue;
//   Department? departmentValue;
//   Career? careerValue;
//   Group? groupValue;
//   bool show = false;

//   @override
//   void initState() {
//     super.initState();
//     loadData().then((value) {
//       setState(() {
//         show = true;
//       });
//     });
//   }

//   Future<void> loadData() async {
//     centers = await Center.getAll();
//     if (centers.isNotEmpty) {
//       centerValue = centers[0];
//       if (widget.update != null) {
//         final index = centers.indexWhere((element) =>
//             element.id == widget.update!.group!.career!.department!.center!.id);
//         if (index != -1) centerValue = centers[index];
//       }
//       departments = await Department.getByCenter(centerValue!.id);
//       if (departments.isNotEmpty) {
//         departmentValue = departments[0];
//         if (widget.update != null) {
//           final index = departments.indexWhere((element) =>
//               element.id == widget.update!.group!.career!.department!.id);
//           if (index != -1) departmentValue = departments[index];
//         }
//         careers = await Career.getByDepartment(departmentValue!.id);
//         if (careers.isNotEmpty) {
//           careerValue = careers[0];
//           if (widget.update != null) {
//             final index = careers.indexWhere(
//                 (element) => element.id == widget.update!.group!.career!.id);
//             if (index != -1) careerValue = careers[index];
//           }
//           groups = await Group.getByCareer(careerValue!.id);
//           if (groups.isNotEmpty) {
//             groupValue = groups[0];
//             if (widget.update != null) {
//               final index = groups.indexWhere(
//                   (element) => element.id == widget.update!.group!.id);
//               if (index != -1) groupValue = groups[index];
//             }
//           }
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!show) {
//       return const Text('No se encontraron datos.');
//     }
//     return Column(
//       children: [
//         DropdownButtonFormField<Center>(
//           decoration: const InputDecoration(labelText: 'Centro'),
//           items: centers.map<DropdownMenuItem<Center>>((Center value) {
//             return DropdownMenuItem<Center>(
//               value: value,
//               child: Text(value.name),
//             );
//           }).toList(),
//           value: centerValue,
//           onChanged: (Center? newValue) async {
//             centerValue = newValue;
//             if (centerValue != null) {
//               departments = await Department.getByCenter(centerValue!.id);
//               if (departments.isNotEmpty) {
//                 departmentValue = departments[0];
//                 careers = await Career.getByDepartment(departmentValue!.id);
//                 if (careers.isNotEmpty) {
//                   careerValue = careers[0];
//                   groups = await Group.getByCareer(careerValue!.id);
//                   if (groups.isNotEmpty) {
//                     groupValue = groups[0];
//                   } else {
//                     groupValue = null;
//                   }
//                 } else {
//                   careerValue = groupValue = null;
//                 }
//               } else {
//                 departmentValue = careerValue = groupValue = null;
//               }
//             }
//             setState(() {});
//           },
//           validator: (value) => value != null ? null : 'Centro no válido',
//         ),
//         const SizedBox(
//           height: 20.0,
//         ),
//         DropdownButtonFormField<Department?>(
//           decoration: const InputDecoration(labelText: 'Departamento'),
//           items: departments
//               .map<DropdownMenuItem<Department?>>((Department? value) {
//             return DropdownMenuItem<Department?>(
//               value: value,
//               child: Text(value!.name),
//             );
//           }).toList(),
//           value: departmentValue,
//           onChanged: (Department? newValue) async {
//             departmentValue = newValue;
//             careers = await Career.getByDepartment(departmentValue!.id);
//             if (careers.isNotEmpty) {
//               careerValue = careers[0];
//               groups = await Group.getByCareer(careerValue!.id);
//               if (groups.isNotEmpty) {
//                 groupValue = groups[0];
//               } else {
//                 groupValue = null;
//               }
//             } else {
//               careerValue = groupValue = null;
//             }
//             setState(() {});
//           },
//           validator: (value) => value != null ? null : 'Departamento no válido',
//         ),
//         const SizedBox(
//           height: 20.0,
//         ),
//         DropdownButtonFormField<Career?>(
//           decoration: const InputDecoration(labelText: 'Carrera'),
//           items: careers.map<DropdownMenuItem<Career?>>((Career? value) {
//             return DropdownMenuItem<Career?>(
//               value: value,
//               child: Text(value!.name),
//             );
//           }).toList(),
//           value: careerValue,
//           onChanged: (Career? newValue) async {
//             careerValue = newValue;
//             groups = await Group.getByCareer(careerValue!.id);
//             if (groups.isNotEmpty) {
//               groupValue = groups[0];
//             } else {
//               groupValue = null;
//             }
//             setState(() {});
//           },
//           validator: (value) => value != null ? null : 'Carrera no válida',
//         ),
//         const SizedBox(
//           height: 20.0,
//         ),
//         DropdownButtonFormField<Group?>(
//           decoration: const InputDecoration(labelText: 'Grupo'),
//           items: groups.map<DropdownMenuItem<Group?>>((Group? value) {
//             return DropdownMenuItem<Group?>(
//               value: value,
//               child: Text(value!.generation + " " + value.letter),
//             );
//           }).toList(),
//           value: groupValue,
//           onChanged: (Group? newValue) async {
//             groupValue = newValue;
//             setState(() {});
//           },
//           validator: (value) => value != null ? null : 'Grupo no válido',
//           onSaved: (value) => widget.controller.academicLoad.group = groupValue,
//         ),
//       ],
//     );
//   }
// }

// class SubjectDropdownButtons extends StatefulWidget {
//   final AcademicLoadController controller;
//   final AcademicLoad? update;

//   const SubjectDropdownButtons(
//       {Key? key, required this.controller, required this.update})
//       : super(key: key);

//   @override
//   _SubjectDropdownButtonsState createState() => _SubjectDropdownButtonsState();
// }

// class _SubjectDropdownButtonsState extends State<SubjectDropdownButtons> {
//   List<Center> centers = [];
//   List<Department> departments = [];
//   List<Subject> subjects = [];
//   Center? centerValue;
//   Department? departmentValue;
//   Subject? subjectValue;
//   bool show = false;

//   @override
//   void initState() {
//     super.initState();
//     loadData().then((value) {
//       setState(() {
//         show = true;
//       });
//     });
//   }

//   Future<void> loadData() async {
//     centers = await Center.getAll();
//     if (centers.isNotEmpty) {
//       centerValue = centers[0];
//       if (widget.update != null) {
//         final index = centers.indexWhere((element) =>
//             element.id == widget.update!.group!.career!.department!.center!.id);
//         if (index != -1) centerValue = centers[index];
//       }
//       departments = await Department.getByCenter(centerValue!.id);
//       if (departments.isNotEmpty) {
//         departmentValue = departments[0];
//         if (widget.update != null) {
//           final index = departments.indexWhere((element) =>
//               element.id == widget.update!.group!.career!.department!.id);
//           if (index != -1) departmentValue = departments[index];
//         }
//         subjects = await Subject.getByDepartment(departmentValue!.id);
//         if (subjects.isNotEmpty) {
//           subjectValue = subjects[0];
//           if (widget.update != null) {
//             final index = subjects.indexWhere(
//                 (element) => element.id == widget.update!.group!.career!.id);
//             if (index != -1) subjectValue = subjects[index];
//           }
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!show) {
//       return const Text('No se encontraron datos.');
//     }
//     return Column(
//       children: [
//         DropdownButtonFormField<Center>(
//           decoration: const InputDecoration(labelText: 'Centro'),
//           items: centers.map<DropdownMenuItem<Center>>((Center value) {
//             return DropdownMenuItem<Center>(
//               value: value,
//               child: Text(value.name),
//             );
//           }).toList(),
//           value: centerValue,
//           onChanged: (Center? newValue) async {
//             centerValue = newValue;
//             if (centerValue != null) {
//               departments = await Department.getByCenter(centerValue!.id);
//               if (departments.isNotEmpty) {
//                 departmentValue = departments[0];
//                 subjects = await Subject.getByDepartment(departmentValue!.id);
//                 if (subjects.isNotEmpty) {
//                   subjectValue = subjects[0];
//                 } else {
//                   subjectValue = null;
//                 }
//               } else {
//                 departmentValue = subjectValue = null;
//               }
//             }
//             setState(() {});
//           },
//           validator: (value) => value != null ? null : 'Centro no válido',
//         ),
//         const SizedBox(
//           height: 20.0,
//         ),
//         DropdownButtonFormField<Department?>(
//           decoration: const InputDecoration(labelText: 'Departamento'),
//           items: departments
//               .map<DropdownMenuItem<Department?>>((Department? value) {
//             return DropdownMenuItem<Department?>(
//               value: value,
//               child: Text(value!.name),
//             );
//           }).toList(),
//           value: departmentValue,
//           onChanged: (Department? newValue) async {
//             departmentValue = newValue;
//             subjects = await Subject.getByDepartment(departmentValue!.id);
//             if (subjects.isNotEmpty) {
//               subjectValue = subjects[0];
//             } else {
//               subjectValue = null;
//             }
//             setState(() {});
//           },
//           validator: (value) => value != null ? null : 'Departamento no válido',
//         ),
//         const SizedBox(
//           height: 20.0,
//         ),
//         DropdownButtonFormField<Subject?>(
//           decoration: const InputDecoration(labelText: 'Materia'),
//           items: subjects.map<DropdownMenuItem<Subject?>>((Subject? value) {
//             return DropdownMenuItem<Subject?>(
//               value: value,
//               child: Text(value!.name),
//             );
//           }).toList(),
//           value: subjectValue,
//           onChanged: (Subject? newValue) async {
//             subjectValue = newValue;
//             setState(() {});
//           },
//           validator: (value) => value != null ? null : 'Materia no válida',
//           onSaved: (value) => widget.controller.academicLoad.subject = subjectValue,
//         ),
//       ],
//     );
//   }
// }