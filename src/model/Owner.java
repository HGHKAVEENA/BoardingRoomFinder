package model;

/** INHERITANCE + POLYMORPHISM: Owner extends User. */
public class Owner extends User {

    public Owner() { super(); setRole("Owner"); }

    public Owner(int id, String firstName, String lastName, String email,
                 String phone, String password) {
        super(id, firstName, lastName, email, phone, password, "Owner");
    }

    @Override
    public String getDashboardPage() {
        return "owner-dashboard.jsp";
    }

    @Override
    public String getFullName() {
        return "Owner: " + super.getFullName();
    }
}
