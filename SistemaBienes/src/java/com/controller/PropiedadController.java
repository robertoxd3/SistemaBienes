package com.controller;

import com.dao.DaoPropiedad;
import com.model.Propiedad;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "PropiedadController", urlPatterns = {"/propiedadController"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100, // 100 MB
        location = Globales.rutaPropiedades
)
public class PropiedadController extends HttpServlet {

    private final Propiedad pro = new Propiedad();
    private final DaoPropiedad daoP = new DaoPropiedad();
  


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //response.setContentType("text/html;charset=UTF-8");
        //  doPost(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String resp = "";
        PrintWriter out = response.getWriter();
        String accion = request.getParameter("accion");
        RequestDispatcher rd = null;
        try {

            if (accion != null) {

                switch (accion) {
                    
                     case "upload": 
                        resp=uploadFile(request, response);
                        response.getWriter().print(resp);
                        break;

                    case "insertar":
                        System.out.println(request.getParameter("foto"));
                        pro.setIdPropiedad(Integer.parseInt(request.getParameter("idPropiedad")));
                        pro.setNombre(request.getParameter("txtNombre"));
                        pro.setDireccion(request.getParameter("txtDireccion"));
                        pro.setTelefono(request.getParameter("txtTelefono"));
                        pro.setFoto(request.getParameter("foto"));
                        pro.setEstado(request.getParameter("cmbEstado"));
                        resp = daoP.AddPropiedad(pro);
                        response.getWriter().print(resp);
                        break;

                    case "modificar":
                    pro.setIdPropiedad(Integer.parseInt(request.getParameter("idPropiedad")));
                        pro.setNombre(request.getParameter("txtNombre"));
                        pro.setDireccion(request.getParameter("txtDireccion"));
                        pro.setTelefono(request.getParameter("txtTelefono"));
                        pro.setFoto(request.getParameter("foto"));
                        pro.setEstado(request.getParameter("cmbEstado"));
                        resp = daoP.UpdatePropiedad(pro);
                        response.getWriter().print(resp);
                     break;

                     case "eliminar":
                     pro.setIdPropiedad(Integer.parseInt(request.getParameter("codigo")));
                     try {
                     resp = daoP.deletePropiedad(pro);
                     response.getWriter().print(resp);

                     } catch (SQLException ex) {
                     Logger.getLogger(UsuarioController.class.getName()).log(Level.SEVERE, null, ex);
                     }
                     break;
                    default:
                        response.sendRedirect("index.jsp");
                        break;
                }
            } else {
                response.getWriter().print("Action nula");
            }

            //response.sendRedirect("paginas/ejercicio2.jsp");
            rd = request.getRequestDispatcher("index.jsp");
        } catch (Exception e) {
            response.getWriter().print("Error Controlador" + e);

        }
    }
    
      public String uploadFile(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       try{
        /* Receive file uploaded to the Servlet from the HTML5 form */
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName().trim();

        for (Part part : request.getParts()) {
            part.write(fileName);
        }
        //retornar el nombre de el archivo
        return fileName;
       }
       catch(IOException | ServletException e){
        return "error al subir";
       }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

  
}
