package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.Files;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fileName = req.getParameter("file");

        File file = new File("C:\\BoardingFinderUploads", fileName);

        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String type = getServletContext().getMimeType(file.getName());
        if (type == null) {
            type = "application/octet-stream";
        }

        resp.setContentType(type);
        Files.copy(file.toPath(), resp.getOutputStream());
    }
}