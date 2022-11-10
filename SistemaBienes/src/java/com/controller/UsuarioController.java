package com.controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import com.dao.DaoUsuario;
import com.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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

@WebServlet(urlPatterns = {"/usuarioController"})
public class UsuarioController extends HttpServlet {
    private final Usuario usu = new Usuario();
    private final DaoUsuario daoU = new DaoUsuario();
    
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
        String nombreUsuario = "";
        String clave = "";
        int tipo = 0;
        PrintWriter out = response.getWriter();
        String accion = request.getParameter("accion");
        RequestDispatcher rd = null;
        try {

            if (accion != null) {

                switch (accion) {
                    
                    case "cargarUsuario":
                        cargarUsuario(request, response);
                        break;

                    case "insertar":
                        usu.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
                        usu.setNombre(request.getParameter("txtNombre"));
                        usu.setClave(request.getParameter("txtClave"));
                        usu.setTipo(Integer.parseInt(request.getParameter("cmbTipo")));
                        usu.setEstado(request.getParameter("cmbEstado"));
                        usu.setCreado_en(request.getParameter("creado_en"));
                        resp = daoU.AddUsuario(usu);
                        response.getWriter().print(resp);
                        break;

                    case "modificar":
                       usu.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
                        usu.setNombre(request.getParameter("txtNombre"));
                        usu.setClave(request.getParameter("txtClave"));
                        usu.setTipo(Integer.parseInt(request.getParameter("cmbTipo")));
                        usu.setEstado(request.getParameter("cmbEstado"));
                        usu.setCreado_en(request.getParameter("creado_en"));
                        resp = daoU.updateUsuario(usu);
                        response.getWriter().print(resp);
                        break;
                        
                         case "modificarPerfil":
                        usu.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
                        usu.setNombre(request.getParameter("txtNombre"));
                        usu.setClave(request.getParameter("txtClave"));
                        usu.setTipo(Integer.parseInt(request.getParameter("txtTipo")));
                        usu.setEstado(request.getParameter("txtEstado"));
                        resp = daoU.updatePerfilUsuario(usu);
                        sesion = request.getSession();
                       //borrar variables de sesión
                        request.getSession().removeAttribute("usuario");
                        sesion.setAttribute("usuario", null);
                        sesion.setAttribute("vendedor", null);
                        sesion.setAttribute("gerente", null);
                        sesion.invalidate();
                        response.getWriter().print(resp);
                        break;

                    case "eliminar":
                       
                        try {
                             usu.setIdUsuario(Integer.parseInt(request.getParameter("codigo")));
                            resp = daoU.deleteUsuario(usu);
                            response.getWriter().print(resp);

                        } catch (SQLException ex) {
                            Logger.getLogger(UsuarioController.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        break;
                        
                        
                        case "acceso":
                        usu.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
                        resp = daoU.getAcceso(usu);
                        response.getWriter().print(resp);
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
    
     private void cargarUsuario(HttpServletRequest request, HttpServletResponse response) {
        //Instancias de las clases y Dao
        DaoUsuario daoU = new DaoUsuario();
        List<Usuario> usu = null;
        try {

            //request.getSession(false).getAttribute("usuario");
            Usuario usuario=(Usuario)request.getSession(false).getAttribute("usuario");
             usu = daoU.getUsuarioById(usuario.getIdUsuario());
            //Crear Objeto de la clase con la informacion para llenar el combo
            getServletContext().setAttribute("usuPerfil", usu);
            request.getRequestDispatcher("/views/perfil.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("msje", "No se pudo cargar los cargos :( " + e.getMessage());
        } finally {
            //Al final limpiamos las listas.
            usu = null;
            daoU = null;

        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
