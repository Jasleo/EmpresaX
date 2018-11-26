package controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Data;
import model.Producto;

@WebServlet(name = "UpdateProductoServlet", urlPatterns = {"/updateProducto.do"})
public class UpdateProductoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Data d = new Data();
                Gson g = new Gson();

                String accion = request.getParameter("accion");
                String id = request.getParameter("id");

                Producto updateP = new Producto();

                switch (accion) {
                    case "traerProducto":
                        out.print(g.toJson(d.getProductoById(id)));
                        break;
                    case "editarProducto":
                        String txtNombreProductoE = request.getParameter("proNom");
                        String txtCantidadProductoE = request.getParameter("proCantidad");
                        String txtPrecioProductoE = request.getParameter("proPrecio");
                        
                        updateP.setNombre(txtNombreProductoE);
                        updateP.setCantidad(Integer.parseInt(txtCantidadProductoE));
                        updateP.setPrecio(Integer.parseInt(txtPrecioProductoE));
                        
                        updateP.setId(Integer.parseInt(id));
                        d.updateProducto(updateP);

                        break;

                }
            } catch (SQLException ex) {
                Logger.getLogger(UpdateProductoServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UpdateProductoServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
