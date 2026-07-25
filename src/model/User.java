package model;

/**
 * Abstract base class demonstrating ABSTRACTION and ENCAPSULATION.
 * Common fields for every system user (Student / Owner).
 */
public abstract class User {
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String password;
    private String role;

    public User() {}

    public User(int id, String firstName, String lastName, String email,
                String phone, String password, String role) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
    }

    // Abstract method — every subclass MUST describe its dashboard target.
    public abstract String getDashboardPage();

    // Polymorphic hook — subclasses may override.
    public String getFullName() {
        return firstName + " " + lastName;
    }

    // ---- Getters / Setters (ENCAPSULATION) ----
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
