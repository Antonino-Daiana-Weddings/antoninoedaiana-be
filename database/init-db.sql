DELIMITER $$

CREATE PROCEDURE InitializeDatabase()
BEGIN
    CREATE TABLE IF NOT EXISTS users (
      user_id INT AUTO_INCREMENT PRIMARY KEY,
      username VARCHAR(50) NOT NULL UNIQUE,
      hash VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS invitations (
        invitation_id VARCHAR(6) PRIMARY KEY,
        invitation_number INT NOT NULL UNIQUE AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL,
        status ENUM('Pending', 'Partially Accepted', 'Accepted', 'Declined') NOT NULL DEFAULT 'Pending',
        comment TEXT
    );

    CREATE TABLE IF NOT EXISTS guests (
        guest_id INT AUTO_INCREMENT PRIMARY KEY,
        invitation_id VARCHAR(6),
        full_name VARCHAR(100) NOT NULL,
        menu_type ENUM('Standard', 'Vegetarian', 'Vegan', 'Gluten-Free', 'Lactose-Free') NOT NULL DEFAULT 'Standard',
        menu_kids BOOLEAN NOT NULL DEFAULT FALSE,
        needs ENUM('Autonomous', 'Bus-Only', 'Bus-And-Hotel', 'Hotel-Only') NOT NULL DEFAULT 'Autonomous',
        status ENUM('Pending', 'Accepted', 'Declined') NOT NULL DEFAULT 'Pending',
        nights_needed ENUM('Both','21-Only','22-Only','None') NOT NULL DEFAULT 'None',
        estimated_partecipation BOOLEAN NOT NULL DEFAULT TRUE,
        FOREIGN KEY (invitation_id) REFERENCES invitations(invitation_id) ON DELETE SET NULL
    );    

    END IF;
END$$

DELIMITER ;

-- Call the procedure to initialize the database if not already done
CALL InitializeDatabase();

-- Drop the procedure as it's no longer needed
DROP PROCEDURE IF EXISTS InitializeDatabase();