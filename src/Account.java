import java.io.Serializable;
import java.util.ArrayList;

/**
 * COPYRIGHT 2014 InfiniteLoops. All Rights Reserved. 
 * Hotel Management
 * CS151 Group Project
 * @author Mike Phe, Ly Dang, Andrew Yobs
 * @version 1.00 2014/10/30
 */

/**
 * A user's account.
 */
@SuppressWarnings("serial")
public class Account implements Serializable {
	final private String userID; // cannot be changed once account is created
	private String name;
	private String password;
	private int age;
	private String gender;
	private String phone;
	private String address;
	private String role;
	private String secQuestion;
	private String secAnswer;
	private ArrayList<Reservation> reservations;

	/**
	 * Create an account with a userID and name.
	 * @param userID the user's ID
	 * @param name the user's name
	 */
	public Account(String name, String userID) {
		this.userID = userID;
		this.name = name;
		reservations = new ArrayList<Reservation>();
	}

	/**
	 * Create an account with the given values
	 * @param name - the user's name
	 * @param userId - the user's ID
	 * @param password - the user's password
	 * @param birthDate - the user's birthdate
	 * @param gender - the user's gender
	 * @param phone - the user's phone
	 * @param address - the user's address
	 */
	public Account(String name, String userId, String password, 
			       int age, String gender, String phone,
			       String address, String role, String secQuestion, String secAnswer) {
		this.userID = userId;
		this.name = name;
		this.password = password;
		this.age = age;
		this.gender = gender;
		this.phone = phone;
		this.address = address;
		this.role = role;
		this.secQuestion = secQuestion;
		this.secAnswer = secAnswer;
		reservations = new ArrayList<Reservation>();
	}
	
	/**
	 * Returns the user's ID.
	 * @return the userID
	 */
	public String getUserID() {
		return userID;
	}

	/**
	 * Gets the user's name.
	 * @return the name
	 */
	public String getName() {
		return name.toUpperCase();
	}
	
	public String getFirstName() {
		return name.split(" ")[0];
	}

	public String getLastName() {
		return name.split(" ")[1];
	}
	
	/**
	 * Sets the user's name.
	 * @param name the name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}
	
	public void setRole(String role) {
		this.role = role;
	}
	
	public String getRole() {
		return role;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getSecurityQuestion() {
		return secQuestion;
	}
	
	public void setSecurityQuestion(String secQuestion) {
		this.secQuestion = secQuestion;
	}
	
	public String getSecurityAnswer() {
		return secAnswer;
	}
	
	public void getSecurityAnswer(String secAnswer) {
		this.secAnswer = secAnswer;
	}

	/**
	 * Gets the reservations.
	 * @return the reservations
	 */
	public ArrayList<Reservation> getReservations() {
		return reservations;
	}

	/**
	 * Adds the reservation.
	 * @param r the reservation
	 */
	public void addReservation(Reservation r) {
		reservations.add(r);
	}

	/**
	 * Cancels the reservation.
	 * @param r the reservation
	 */
	public void cancelReservation(Reservation r) {
		reservations.remove(r);
	}

	@Override
	public int hashCode() {
		return userID.hashCode(); // user ID is the hash code
	}

	@Override
	public boolean equals(Object obj) {
		if (this.hashCode() == obj.hashCode()) return true; 
		else return false;
	}
}
