import java.sql.*;

public class BDD {
    private ResultSet rs;
	private Connection connex;
	private Statement st;

    public BDD(String nameDB) throws Exception {
        Class.forName("org.sqlite.JDBC"); 
        Connection connex = DriverManager.getConnection("jdbc:sqlite:base/"+nameDB+".db"); 
        connex.setAutoCommit(true);
		st = connex.createStatement();
        connex.close();
    }


    public ResultSet getRs() {return rs;}

    public Statement getSt() {return st;}

    public Connection getConnex() {return connex;}

    public ResultSet Requette(BDD db,String sql) throws Exception{
        st=getSt(); 
        ResultSet rs = st.executeQuery(sql); ; 
        return rs ; 
    }

    public int Modif_BDD(BDD db,String sql) throws Exception{
        st=getSt(); 
        int nb_modif = st.executeUpdate(sql); 
        return nb_modif; 
    }

}

