package com.controller;

import com.dao.DaoActivo;
import com.dao.DaoEmpleado;
import com.dao.DaoPropiedad;
import com.model.Activo;
import com.model.Empleado;
import com.model.Propiedad;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "ActivoController", urlPatterns = {"/activoController"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100, // 100 MB
        location = Globales.rutaActivos
)
public class ActivoController extends HttpServlet {

    private final Activo act = new Activo();
    private final DaoActivo daoA = new DaoActivo();
    
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //response.setContentType("text/html;charset=UTF-8");
          doPost(request, response);
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

                    case "cargarSelect":
                       cargarSelects(request, response);
                        break;

                    case "upload":
                        resp = uploadFile(request, response);
                        response.getWriter().print(resp);
                        break;

                    case "insertar":
                        System.out.println(request.getParameter("foto"));
                        act.setCodigo(Integer.parseInt(request.getParameter("codigo")));
                        act.setSerial(request.getParameter("txtSerial"));
                        act.setNombre(request.getParameter("txtNombre"));
                        act.setDescripcion(request.getParameter("txtDescripcion"));
                        act.setPropiedad(Integer.parseInt(request.getParameter("cmbPropiedad")));
                        act.setEncargado(Integer.parseInt(request.getParameter("cmbEncargado")));
                        act.setEstado(request.getParameter("cmbEstado"));
                        act.setCategoria(request.getParameter("cmbCategoria"));
                         act.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
                        act.setFoto(request.getParameter("foto"));
                        act.setFechaCompra(Date.valueOf(request.getParameter("fechaCompra")));
                        resp = daoA.AddActivo(act);
                        response.getWriter().print(resp);
                        break;

                    case "modificar":
                        act.setCodigo(Integer.parseInt(request.getParameter("codigo")));
                        act.setSerial(request.getParameter("txtSerial"));
                        act.setNombre(request.getParameter("txtNombre"));
                        act.setDescripcion(request.getParameter("txtDescripcion"));
                        act.setPropiedad(Integer.parseInt(request.getParameter("cmbPropiedad")));
                        act.setEncargado(Integer.parseInt(request.getParameter("cmbEncargado")));
                        act.setEstado(request.getParameter("cmbEstado"));
                        act.setCategoria(request.getParameter("cmbCategoria"));
                         act.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
                        act.setFoto(request.getParameter("foto"));
                        act.setFechaCompra(Date.valueOf(request.getParameter("fechaCompra")));
                        resp = daoA.UpdateActivo(act);
                        response.getWriter().print(resp);
                        break;

                    case "eliminar":
                        act.setCodigo(Integer.parseInt(request.getParameter("codigo")));
                        try {
                            resp = daoA.deleteActivo(act);
                            response.getWriter().print(resp);

                        } catch (SQLException ex) {
                            Logger.getLogger(UsuarioController.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        break;
                    default:
                        response.sendRedirect("activos.jsp");
                        break;
                }
            } else {
                response.getWriter().print("Action nula");
            }

            //response.sendRedirect("paginas/ejercicio2.jsp");
            //rd = request.getRequestDispatcher("activos.jsp");
            //rd.forward(request, response);
        } catch (Exception e) {
            response.getWriter().print("Error Controlador" + e);
        }
    }

    public String uploadFile(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            /* Receive file uploaded to the Servlet from the HTML5 form */
            Part filePart = request.getPart("file");
            String fileName = filePart.getSubmittedFileName().trim();

            for (Part part : request.getParts()) {
                part.write(fileName);
            }
            //retornar el nombre de el archivo
            return fileName;
        } catch (IOException | ServletException e) {
            return "error al subir";
        }

    }

    private void cargarSelects(HttpServletRequest request, HttpServletResponse response) {
        //Instancias de las clases y Dao
        DaoPropiedad daoP = new DaoPropiedad();
        DaoEmpleado daoE = new DaoEmpleado();
        List<Propiedad> propiedades = null;
        List<Empleado> empleados = null;
        try {
            propiedades = daoP.getPropiedad();
            empleados=daoE.getEmpleados();
            //Crear Objeto de la clase con la informacion para llenar el combo
            getServletContext().setAttribute("propiedades",propiedades);
            getServletContext().setAttribute("empleados",empleados);
            request.getRequestDispatcher("/views/activos.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("msje", "No se pudo cargar los cargos :( " + e.getMessage());
        } finally {
            //Al final limpiamos las listas.
            propiedades = null;
            daoP = null;

            daoE = null;
            empleados = null;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
