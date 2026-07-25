package dao;

import model.University;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UniversityDAO {
    public List<University> getAll() throws SQLException {
        List<University> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM universities ORDER BY university_name")) {
            while (rs.next()) {
                list.add(new University(
                    rs.getInt("university_id"),
                    rs.getString("university_name"),
                    rs.getString("city")
                ));
            }
        }
        return list;
    }

    public University getById(int id) throws SQLException {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM universities WHERE university_id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? new University(rs.getInt("university_id"),
                        rs.getString("university_name"), rs.getString("city")) : null;
            }
        }
    }
}
