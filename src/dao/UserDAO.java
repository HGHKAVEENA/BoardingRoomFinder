package dao;

import model.Owner;
import model.Student;
import model.User;

import java.sql.*;

public class UserDAO {

    /** Insert a new user; returns generated id or -1. */
    public int register(User user) throws SQLException {
        String sql = "INSERT INTO users (first_name, last_name, email, phone, password, role) VALUES (?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getPassword()); // NOTE: hash in production
            ps.setString(6, user.getRole());
            if (ps.executeUpdate() == 0) return -1;
            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    /** Authenticate; returns Student/Owner or null. Demonstrates POLYMORPHISM. */
    public User login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                String role = rs.getString("role");
                User u = "Owner".equalsIgnoreCase(role) ? new Owner() : new Student();
                u.setId(rs.getInt("id"));
                u.setFirstName(rs.getString("first_name"));
                u.setLastName(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setPassword(rs.getString("password"));
                u.setRole(role);
                return u;
            }
        }
    }
    
    public User getUserById(int id) throws SQLException {

    String sql = "SELECT * FROM users WHERE id=?";

    try (Connection c = DBConnection.getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {

        ps.setInt(1, id);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                User u;

                if ("Owner".equalsIgnoreCase(rs.getString("role"))) {
                    u = new Owner();
                } else {
                    u = new Student();
                }

                u.setId(rs.getInt("id"));
                u.setFirstName(rs.getString("first_name"));
                u.setLastName(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));

                return u;
            }
        }
    }

    return null;
}

    public boolean emailExists(String email) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT 1 FROM users WHERE email=?")) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        }
    }
}
