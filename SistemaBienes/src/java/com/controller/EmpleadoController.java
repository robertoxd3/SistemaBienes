/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.DaoEmpleado;
import com.model.Empleado;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author RobertoPC
 */
@WebServlet(name = "EmpleadoController", urlPatterns = {"/empleadoController"})
public class EmpleadoController extends HttpServlet {
    private final Empleado emp = new Empleado();
    private final DaoEmpleado daoE = new DaoEmpleado();

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
        
        int tipo = 0;
        PrintWriter out = response.getWriter();
        String accion = request.getParameter("accion");
        RequestDispatcher rd = null;
        try {

            if (accion != null) {

                switch (accion) {
                    
                    case "insertar":
                        emp.setIdEmpleado(Integer.parseInt(request.getParameter("idEmpleado")));
                        emp.setNombres(request.getParameter("txtNombres"));
                        emp.setApellidos(request.getParameter("txtApellidos"));
                        emp.setDui(request.getParameter("dui"));
                        emp.setArea(request.getParameter("txtArea"));
                        resp = daoE.AddEmpleado(emp);
                        response.getWriter().print(resp);
                        break;

                    case "modificar":
                       emp.setIdEmpleado(Integer.parseInt(request.getParameter("idEmpleado")));
                        emp.setNombres(request.getParameter("txtNombres"));
                        emp.setApellidos(request.getParameter("txtApellidos"));
                        emp.setDui(request.getParameter("dui"));
                        emp.setArea(request.getParameter("txtArea"));
                       resp = daoE.updateEmpleado(emp);
                        response.getWriter().print(resp);
                        break;

                    case "eliminar":
                        emp.setIdEmpleado(Integer.parseInt(request.getParameter("codigo")));
                        try {
                            resp = daoE.deleteEmpleado(emp);
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
                response.getWriter().print("Action nula xd");
            }

            //response.sendRedirect("paginas/ejercicio2.jsp");
            rd = request.getRequestDispatcher("index.jsp");
            
        } catch (Exception e) {
            response.getWriter().print("Error Controlador" + e);

        }
        
        
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
