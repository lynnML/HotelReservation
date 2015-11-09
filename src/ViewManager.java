import java.awt.CardLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.event.CaretEvent;
import javax.swing.event.CaretListener;

/**
 * COPYRIGHT 2014 InfiniteLoops. All Rights Reserved. 
 * Hotel Management 
 * CS151 Group Project
 * @author Mike Phe, Ly Dang, Andrew Yobs
 * @version 1.00 2014/10/30
 */

/**
 * The view manager. Contains the frame and all different panels.
 */
public class ViewManager {
	private Model model;
	private JPanel cards;
	private CardLayout cardLayout;

	/**
	 * Constructs the frame and adds panels to CardLayout.
	 */
	public ViewManager(Model model) {
		this.model = model;
		JFrame frame = new JFrame("InfiniteLoops Hotel Manager");
		cards = new JPanel(cardLayout = new CardLayout());

		// add panels to the card layout
		cards.add(new InitialPanel(this), "Initial");
		cards.add(new NewGuestPanel(this), "NGuest");
		cards.add(new ReturningGuestPanel(this), "RGuest");
		cards.add(new ForgotPasswordPanel(this), "FPassword");
		cards.add(new GuestMenuPanel(this), "GMenu");
		cards.add(new ManagerViewPanel(this), "Calendar");
		cards.add(new ManagerMenuPanel(this), "MMenu");
		cards.add(new MakeReservationPanel(this), "Make Reservation");
		cards.add(new ReceiptPanel(this), "Receipt");
		cards.add(new ViewCancelPanel(this), "View/Cancel");

		frame.add(cards); // add the panel with card layout to the frame

		// below are the frame's characteristics
		frame.setSize(800, 600);
		frame.setLocationRelativeTo(null);
		frame.setResizable(false);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}

	/**
	 * Gets the model of the view manager.
	 * @return the model
	 */
	public Model getModel() {
		return model;
	}

	/**
	 * Switches the current panel.
	 * @param panelName
	 */
	public void switchPanel(String panelName) {
		cardLayout.show(cards, panelName);
	}

	/**
	 * The main menu panel.
	 */
	@SuppressWarnings("serial")
	private class InitialPanel extends BasicPanel {
		/**
		 * Constructs the panel with a view manager.
		 * @param m the view manager
		 */
		public InitialPanel(ViewManager manager) {
			super(manager);

			addInstructions("<html>Welcome to InfiniteLoops Hotel Manager!<br>"
					+ "Please select a type of user.");
			c.weightx = 1;
			c.weighty = 1;
			addNavigationButton("Returning Guest", "RGuest", 0, 1);
			addNavigationButton("New Guest", "NGuest", 0, 2);
			addNavigationButton("Manager", "MMenu", 0, 3);
		}
	}
	
	/**
	 * The manager's menu panel.
	 */
	@SuppressWarnings("serial")
	private class ManagerMenuPanel extends BasicPanel {
		/**
		 * Constructs the panel with a view manager.
		 * @param m the view manager
		 */
		public ManagerMenuPanel(ViewManager m) {
			super(m);

			c.weighty = 1;
			addLabel("<html>User:<br>" + "Manager" + "</html>", 0, 0);
			addSignOutButton("Initial", 1, 0);
			c.gridwidth = 2;
			addNavigationButton("View", "Calendar", 0, 1);

			JButton save = new JButton("Save/Quit");
			save.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent e) {
					model.serialize();
					System.exit(0);
				}
			});
			addComponent(save, 0, 2);
		}
	}
	
	/**
	 * A panel in which a returning user can ask for password.
	 */
	@SuppressWarnings("serial")
	private class ForgotPasswordPanel extends BasicPanel {

		public ForgotPasswordPanel(ViewManager m) {
			super(m);
			
			c.insets = new Insets(20, 20, 20, 20);
			c.ipady = 25;
			c.gridwidth = 2;
			addInstructions("<html>Please enter your user security answer.</html>");

			c.weighty = 1;
			c.gridwidth = 1;
			addLabel("Enter your userID:", 0, 1);
			addLabel("Your security question:", 0, 2);
			addLabel("Enter your answer:", 0, 3);
			
			final JTextField userField = new JTextField();
			
			final JTextField questionField = new JTextField();
			
			final JTextField answerField = new JTextField();
			
			userField.addCaretListener(new CaretListener() {
				@Override
				public void caretUpdate(CaretEvent e) {
					String userId = userField.getText();
					String question = model.getUserSecurityQuestion(userId);
					if (question != null) {
						questionField.setText(question);
					}
				}
			});
			
			addComponent(userField, 1, 1);
			
			addComponent(questionField, 1, 2);
			
			addComponent(answerField, 1, 3);

			addNavigationButton("Back", "RGuest", 0, 4);
			
			JButton submitButton = new JButton("Submit");
			submitButton.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent e) {
					String password = null;
					String userId = userField.getText();
					String answer = answerField.getText();
					if ((password = model.checkSecurityAnswer(userId, answer)) != null) {
						JOptionPane.showMessageDialog(new JFrame(),
								"Your password is " + password, "Password",
								JOptionPane.INFORMATION_MESSAGE);
					} else {
						JOptionPane.showMessageDialog(new JFrame(),
								"Error: Wrong security answer.", "Error",
								JOptionPane.ERROR_MESSAGE);
					}
				}
			});
			addComponent(submitButton, 1, 4);
		}
		
	}
	
	/**
	 * A panel in which a returning user can log in.
	 */
	@SuppressWarnings("serial")
	private class ReturningGuestPanel extends BasicPanel {
		/**
		 * Constructs the panel with a view manager
		 * @param m the view
		 */
		public ReturningGuestPanel(ViewManager m) {
			super(m);
			
			c.insets = new Insets(20, 20, 20, 20);
			c.ipady = 25;
			c.gridwidth = 2;
			addInstructions("<html>Please enter your user ID and password to "
					+ "make, cancel, or view your reservations.<br><br>If you do not "
					+ "have an account please go back and create one.</html>");

			c.weighty = 1;
			c.gridwidth = 1;
			addLabel("Enter user ID:", 0, 1);
			addLabel("Enter password:", 0, 2);

			final JTextField userIDTextField = new JTextField();
			addComponent(userIDTextField, 1, 1);
			
			final JPasswordField passwordField = new JPasswordField();
			addComponent(passwordField, 1, 2);

			addNavigationButton("Back", "Initial", 0, 3);

			JButton submitButton = new JButton("Sign in");
			submitButton.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent e) {
					String userID = userIDTextField.getText();
					String password = new String(passwordField.getPassword());

					if (userID.length() < 6 || userID.length() > 12) {
						JOptionPane.showMessageDialog(new JFrame(),
								"Error: Entered user ID is invalid.", "Error",
								JOptionPane.ERROR_MESSAGE);
					//} else if (model.findUser(userID) == null) {
					} else if (!model.checkUserExistence(userID)) {	
						JOptionPane.showMessageDialog(new JFrame(), 
								"Error: User ID does not exist in the system.", "Error",
								JOptionPane.ERROR_MESSAGE);
					} else if (!model.checkUserPassword(userID, password)) {
						JOptionPane.showMessageDialog(new JFrame(), 
								"Error: Password is incorrect.", "Error",
								JOptionPane.ERROR_MESSAGE);
					} else {
						clearComponents();
						model.setCurrentUser(model.findUser(userID));
						manager.switchPanel("GMenu");
					}
				}
			});
			addComponent(submitButton, 2, 3);
			
			JButton forgotButton = new JButton("Forgot password");
			forgotButton.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent e) {
					manager.switchPanel("FPassword");
				}
			});
			addComponent(forgotButton, 1, 3);
		}
	}
}