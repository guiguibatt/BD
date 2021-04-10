import java.sql.*;

public class ConnexionBD {
    private Statement st = null;
    private ResultSet rs = null;
    private Connection cn = null;
    private PreparedStatement pst=null;


    public ConnexionBD() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }catch (ClassNotFoundException e){
            System.out.println("Ya un pb avec le driver");
        }

        try {
            cn= DriverManager.getConnection("jdbc:oracle:thin:@162.38.222.149:1521:iut","agussolg","21092020");
            st=cn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            rs=st.executeQuery("SELECT codePersonne,nomPersonne,prenomPersonne,agePersonne FROM Personnes ORDER BY agePersonne DESC NULLS LAST");
            pst=cn.prepareStatement("SELECT codePersonne,nomPersonne,prenomPersonne,agePersonne FROM Personnes WHERE agePersonne>=? ORDER BY agePersonne DESC NULLS LAST",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

        }catch (SQLException e ){

            e.printStackTrace();
        }
    }

    public Personne premier(){
        Personne p = null;
        try {
            rs.first();
            p=recuperationNouvellePersonne();

        }catch (SQLException e){e.printStackTrace();}
        return p;
    }

    public Personne dernier(){
        Personne p = null;
        try {
            rs.last();
            p=recuperationNouvellePersonne();
        }catch (SQLException e){e.printStackTrace();}
        return p;
    }

    public Personne suivant(){
        Personne p = null;
        try {
            if(!rs.isLast()) {
                rs.next();
                p=recuperationNouvellePersonne();
            }else{
                p=recuperationNouvellePersonne();
            }

        }catch (SQLException e){e.printStackTrace();}
        return p;
    }

    public Personne precedent(){
        Personne p = null;
        try {
            if(!rs.isFirst()) {
                rs.previous();
                p=recuperationNouvellePersonne();
            }else {
                p=recuperationNouvellePersonne();
            }

        }catch (SQLException e){e.printStackTrace();}
        return p;
    }

    public void recherche(int age){
        try {
            pst.setInt(1,age);
            rs=pst.executeQuery();
        }catch (SQLException e){e.printStackTrace();}

    }

    public void tous(){
        try {
            rs=st.executeQuery("SELECT codePersonne,nomPersonne,prenomPersonne,agePersonne FROM Personnes ORDER BY agePersonne DESC NULLS LAST");
        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    public Personne recuperationNouvellePersonne(){
        Personne p = null;
        String nom, prenom;
        int num,age;
        try{
            num = rs.getInt(1);
            nom = rs.getString(2);
            prenom = rs.getString(3);
            age = rs.getInt(4);
            if (rs.wasNull()) {
                age = -1;
            }
            p = new Personne(num, nom, prenom, age);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return p;
    }

    public void deconnexion(){
        try {
            cn.close();
        }catch (SQLException e){}

    }
}
