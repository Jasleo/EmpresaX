/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
import model.Area;
import model.Data;

/**
 *
 * @author nloyola
 */
@WebServlet(name = "UpdateArea", urlPatterns = {"/updateArea.do"})
public class UpdateArea extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            try {
                Data d = new Data();
                Gson g = new Gson();

                String accion = request.getParameter("accion");
                String id = request.getParameter("id");

                Area upA = new Area();
                
                
                System.out.println(accion);
                switch (accion) {
                    case "traerArea":
                        out.print(g.toJson(d.getAreaId(id)));
                        break;
                    case "editarArea":
                        String txtAreaE = request.getParameter("are");
                        upA.setNombre(txtAreaE);
                        upA.setId(Integer.parseInt(id));
                        d.updateArea(upA);
                        
                        break;

                }

                //System.out.println(d.getAreaId(id));
            } catch (SQLException ex) {
                Logger.getLogger(UpdateArea.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UpdateArea.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
