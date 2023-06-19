//
//  SchoolGrading.swift
//
//  Created by Jedidiah Alfred
//  Created on 2023-06-15
//  Version 1.0
//  Copyright (c) 2023 Jedidiah Alfred. All rights reserved.
//
//  This program gets the average of students marks and gives a report card.

class SchoolGrading {
    private var students: [Student]
    private var subjects: [Subject]

    init() {
        students = []
        subjects = []
    }

    func addStudent(_ student: Student) {
        // Append the student to the students array
        students.append(student)
    }

    func addSubject(_ subject: Subject) {
        // Append the subject to the subjects array
        subjects.append(subject)
    }

    func recordGrade(for student: Student, subject: Subject, grade: Grade) {
        // Set the grade for the student in the specified subject
        student.setGrade(for: subject, grade: grade)
    }

    func calculateAverageGrade(for student: Student) -> Double {
        // Calculate the average grade for the student
        let studentGrades = student.getGrades()
        var totalGrade = 0.0

        for grade in studentGrades.values {
            totalGrade += grade.getValue()
        }

        return totalGrade / Double(studentGrades.count)
    }

    func generateReportCard(for student: Student) {
        // Generate the report card for the student
        let studentGrades = student.getGrades()
        print("Report Card for \(student.getFullName()):")

        for (subject, grade) in studentGrades {
            print("\(subject.getName()): \(grade.getValue())")
        }
    }
}

class Student {
    private var id: Int
    private var firstName: String
    private var lastName: String
    private var grades: [Subject: Grade]

    init(id: Int, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        grades = [:]
    }

    func getId() -> Int {
        return id
    }

    func getFirstName() -> String {
        return firstName
    }

    func getLastName() -> String {
        return lastName
    }

    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }

    func getGrades() -> [Subject: Grade] {
        return grades
    }

    func setGrade(for subject: Subject, grade: Grade) {
        // Set the grade for the student in the specified subject
        grades[subject] = grade
    }
}

class Subject: Hashable {
    private var id: Int
    private var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func getId() -> Int {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func ==(lhs: Subject, rhs: Subject) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

class Grade {
    private var value: Double

    init(value: Double) {
        self.value = value
    }

    func getValue() -> Double {
        return value
    }
}

// Create a SchoolGrading object
let schoolGrading = SchoolGrading()

// Create some Student objects
let student1 = Student(id: 1, firstName: "John", lastName: "Doe")
let student2 = Student(id: 2, firstName: "Jane", lastName: "Smith")

// Create some Subject objects
let math = Subject(id: 1, name: "Mathematics")
let science = Subject(id: 2, name: "Science")

// Add students and subjects to the school grading system
schoolGrading.addStudent(student1)
schoolGrading.addStudent(student2)
schoolGrading.addSubject(math)
schoolGrading.addSubject(science)

// Record grades for students
schoolGrading.recordGrade(for: student1, subject: math, grade: Grade(value: 90))
schoolGrading.recordGrade(for: student1, subject: science, grade: Grade(value: 85))
schoolGrading.recordGrade(for: student2, subject: math, grade: Grade(value: 95))
schoolGrading.recordGrade(for: student2, subject: science, grade: Grade(value: 92))

// Calculate and display average grades for students
let averageGrade1 = schoolGrading.calculateAverageGrade(for: student1)
let averageGrade2 = schoolGrading.calculateAverageGrade(for: student2)

print("Average grade for \(student1.getFullName()): \(averageGrade1)")
print("Average grade for \(student2.getFullName()): \(averageGrade2)")

// Generate report cards for students
schoolGrading.generateReportCard(for: student1)
schoolGrading.generateReportCard(for: student2)

