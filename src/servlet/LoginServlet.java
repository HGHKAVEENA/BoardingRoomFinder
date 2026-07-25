package servlet;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        try {
            User user = new UserDAO().login(email.trim(), password);
            if (user == null) {
                req.setAttribute("error", "Invalid credentials.");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                return;
            }
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());
            // POLYMORPHIC dispatch — Student vs Owner decide their own dashboard.
            resp.sendRedirect(user.getDashboardPage());
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
