package model;

/** INHERITANCE + POLYMORPHISM: Student extends User and overrides methods. */
public class Student extends User {

    public Student() { super(); setRole("Student"); }

    public Student(int id, String firstName, String lastName, String email,
                   String phone, String password) {
        super(id, firstName, lastName, email, phone, password, "Student");
    }

    @Override
    public String getDashboardPage() {
        return "student-dashboard.jsp";
    }

    @Override
    public String getFullName() {
        return "Student: " + super.getFullName();
    }
}
