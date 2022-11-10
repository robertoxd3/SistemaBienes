/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.DaoUsuario;
import com.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.jasper.tagplugins.jstl.ForEach;

@WebServlet(name = "LoginController", urlPatterns = {"/loginController"})
public class LoginController extends HttpServlet {

    private final Usuario usu = new Usuario();
    private final DaoUsuario daoL = new DaoUsuario();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
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
        HttpSession sesion;
        String resp = "";
        boolean bandera = false;
        String nombreUsuario = "";
        String clave = "";
        int tipo = 0;
        PrintWriter out = response.getWriter();
        String accion = request.getParameter("accion");
        RequestDispatcher rd = null;
        try {

            if (accion != null) {

                switch (accion) {
                    
                    case "nuevoUsuario":
                        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                        Calendar cal = Calendar.getInstance();
                        String date = dateFormat.format(Calendar.getInstance().getTime());
                        usu.setNombre(request.getParameter("nombre"));
                        usu.setClave(request.getParameter("clave"));
                        usu.setTipo(Integer.parseInt(request.getParameter("tipo")));
                        usu.setEstado("Revision");
                        usu.setCreado_en(date.toString());
                        resp = daoL.AddUsuario(usu);
                        response.getWriter().print(resp);
                            break;

                    case "login":
                        Usuario usu = new Usuario();
                        usu.setNombre(request.getParameter("txtNombre"));
                        usu.setClave(request.getParameter("txtClave"));
                        usu = daoL.identificar(usu);
                        //añadir acceso
                        String accesoAccion = "Inicio Sesion";
                        daoL.addAcesso(usu.getIdUsuario(), accesoAccion);
                        //verificar el tipo de usuario 1. administrador, 2. empleado, 3. vendedor
                        if (usu != null && usu.getTipo() == 1) {

                            sesion = request.getSession();
                            sesion.setMaxInactiveInterval(1000); //600 secs = 10 mins
                            sesion.setAttribute("usuario", usu);
                            response.getWriter().print("Encontrado");
                            //this.getServletConfig().getServletContext().getRequestDispatcher("/views/menu.jsp").forward(request, response);
                        } else if (usu != null && usu.getTipo() == 2) {
                            sesion = request.getSession();
                            sesion.setMaxInactiveInterval(1000); //600 secs = 10 mins
                            sesion.setAttribute("vendedor", usu);
                            response.getWriter().print("Encontrado");
                            //this.getServletConfig().getServletContext().getRequestDispatcher("/views/menu.jsp").forward(request, response);

                        } else if (usu != null && usu.getTipo() == 3) {
                             sesion = request.getSession();
                            sesion.setMaxInactiveInterval(1000); //600 secs = 10 mins
                            sesion.setAttribute("gerente", usu);
                            response.getWriter().print("Encontrado");
                           // this.getServletConfig().getServletContext().getRequestDispatcher("/views/menu.jsp").forward(request, response);
                        } else{
                          //this.getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
                        }

                        break;

                    case "salir":
                        sesion = request.getSession();
                        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
                        Usuario vendedor = (Usuario) sesion.getAttribute("vendedor");
                        Usuario gerente = (Usuario) sesion.getAttribute("gerente");

                        //añadir acceso
                        accesoAccion = "Logout";
                        if (usuario != null) {
                            daoL.addAcesso(usuario.getIdUsuario(), accesoAccion);
                        } else if (vendedor != null) {
                           daoL.addAcesso(vendedor.getIdUsuario(), accesoAccion);
                        } else {
                            daoL.addAcesso(gerente.getIdUsuario(), accesoAccion);
                        }
                        

                        //borrar variables de sesión
                        request.getSession().removeAttribute("usuario");
                        sesion.setAttribute("usuario", null);
                        sesion.setAttribute("vendedor", null);
                        sesion.setAttribute("gerente", null);
                        sesion.invalidate();
                        response.getWriter().print("OK");
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
