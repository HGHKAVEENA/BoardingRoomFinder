package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * JDBC connection helper. Update USER / PASSWORD to match your MySQL setup.
 * Requires mysql-connector-j-*.jar on the server classpath (WEB-INF/lib).
 */
public class DBConnection {
    private static final String URL      = "jdbc:mysql://localhost:3306/boarding_system?useSSL=false&serverTimezone=UTC";
    private static final String USER     = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver not found. Add mysql-connector-j to WEB-INF/lib.", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
