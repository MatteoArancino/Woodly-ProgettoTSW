package util; // <-- Assicurati che il package sia questo

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnection {
    private static DataSource ds;

    static {
        try {
            InitialContext ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/woodly_db");
            System.out.println("DataSource woodly_db inizializzato in util");
        } catch (NamingException e) {
            System.err.println("ERRORE");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        if (ds != null) {
            return ds.getConnection();
        }
        throw new SQLException("DataSource non disponibile.");
    }
}