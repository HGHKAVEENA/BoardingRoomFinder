package servlet;

import dao.UserDAO;
import model.Owner;
import model.Student;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String firstName = req.getParameter("firstName");
        String lastName  = req.getParameter("lastName");
        String email     = req.getParameter("email");
        String phone     = req.getParameter("phone");
        String password  = req.getParameter("password");
        String role      = req.getParameter("role"); // Student / Owner

        // Basic validation
        if (firstName == null || lastName == null || email == null || password == null || role == null
                || firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }
        if (!email.matches("^[\\w.+-]+@[\\w-]+\\.[\\w.-]+$")) {
            req.setAttribute("error", "Please enter a valid email.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }
        try {
            UserDAO dao = new UserDAO();
            if (dao.emailExists(email)) {
                req.setAttribute("error", "Email is already registered.");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }
            User user = "Owner".equalsIgnoreCase(role)
                    ? new Owner(0, firstName, lastName, email, phone, password)
                    : new Student(0, firstName, lastName, email, phone, password);

            int id = dao.register(user);
            if (id > 0) {
                resp.sendRedirect("login.jsp?registered=1");
            } else {
                req.setAttribute("error", "Registration failed. Try again.");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
