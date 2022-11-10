/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.DaoActivo;
import com.dao.DaoEmpleado;
import com.dao.DaoPropiedad;
import com.dao.DaoTraspaso;
import com.model.Activo;
import com.model.Empleado;
import com.model.Propiedad;
import com.model.Traspaso;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

@WebServlet(name = "TraspasoController", urlPatterns = {"/traspasoController"})
public class TraspasoController extends HttpServlet {

    private final Traspaso tra = new Traspaso();
    private final Activo act = new Activo();
    private final DaoTraspaso daoT = new DaoTraspaso();
    private final DaoActivo daoA = new DaoActivo();
     
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
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

                    case "getActivoId":
                        int idEmpleado= Integer.parseInt(request.getParameter("idEncargado"));
                        resp = daoT.getActivoId(idEmpleado);
                        response.getWriter().print(resp);
                        break;

                    case "insertar":
                        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                        Calendar cal = Calendar.getInstance();
                        String date = dateFormat.format(Calendar.getInstance().getTime());
                         tra.setActivo(Integer.parseInt(request.getParameter("activo")));
                         tra.setEncargadoAnterior(Integer.parseInt(request.getParameter("cmbEncargadoAnterior")));
                         tra.setEncargadoNuevo(Integer.parseInt(request.getParameter("cmbEncargadoNuevo")));
                         tra.setFechaTraspaso(date.toString());
                         
                         //actualizar el encargado nuevo en tabla activos.
                         act.setCodigo(Integer.parseInt(request.getParameter("activo")));
                         act.setEncargado(Integer.parseInt(request.getParameter("cmbEncargadoNuevo")));
                         daoA.UpdateActivoTraspaso(act);
                         //añadir traspaso 
                         resp = daoT.AddTraspaso(tra);
                         response.getWriter().print(resp);
                        break;

                    case "eliminar":
                        /* act.setCodigo(Integer.parseInt(request.getParameter("codigo")));
                         try {
                         resp = daoA.deleteActivo(act);
                         response.getWriter().print(resp);

                         } catch (SQLException ex) {
                         Logger.getLogger(UsuarioController.class.getName()).log(Level.SEVERE, null, ex);
                         }*/
                        break;
                    default:
                        response.sendRedirect("movimientos.jsp");
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void cargarSelects(HttpServletRequest request, HttpServletResponse response) {
        //Instancias de las clases y Dao
        DaoPropiedad daoP = new DaoPropiedad();
        DaoEmpleado daoE = new DaoEmpleado();
        List<Propiedad> propiedades = null;
        List<Empleado> empleados = null;
        try {
            propiedades = daoP.getPropiedad();
            empleados = daoE.getEmpleados();
            //Crear Objeto de la clase con la informacion para llenar el combo
            getServletContext().setAttribute("propiedades", propiedades);
            getServletContext().setAttribute("empleados", empleados);
            request.getRequestDispatcher("/views/movimientos.jsp").forward(request, response);
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

}
