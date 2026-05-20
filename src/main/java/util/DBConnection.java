package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Parametri di configurazione del database
    private static final String URL = "jdbc:mysql://localhost:3306/woodly_db?serverTimezone=UTC&useSSL=false";
    private static final String USERNAME = "root"; 
    private static final String PASSWORD = "ROOT";  
    private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver";

  
    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName(DRIVER_CLASS);
            
            // 2. Tenta la connessione al database
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Connessione a woodly_db riuscita con successo!");
            
        } catch (ClassNotFoundException e) {
            System.err.println("Errore: Driver JDBC non trovato");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Errore: Impossibile connettersi al database");
            e.printStackTrace();
        }
        
        return connection;
    }
}