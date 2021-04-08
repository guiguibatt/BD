public class Personne {

	private int num;
	private String nom;
	private String prenom;
	private int age;

	public Personne(int num, String nom, String prenom, int age) {
		this.num = num;
		this.nom = nom;
		this.prenom = prenom;
		this.age = age;
	}

	public int getNum() {
		return this.num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public int getAge() {
		return this.age;
	}

	public void setAge(int age) {
		this.age = age;
	}
}
