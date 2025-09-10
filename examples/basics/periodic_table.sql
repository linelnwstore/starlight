-- Periodic Table Database Schema
-- This SQL script creates a comprehensive periodic table database
-- demonstrating SQL syntax highlighting in Starlight documentation

-- Create the periodic table schema
CREATE SCHEMA IF NOT EXISTS chemistry;
USE chemistry;

-- Table to store element categories
CREATE TABLE element_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    color_code VARCHAR(7), -- Hex color code for visual representation
    description TEXT
);

-- Table to store electron configurations
CREATE TABLE electron_configurations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    configuration VARCHAR(100) NOT NULL UNIQUE,
    noble_gas_notation VARCHAR(50)
);

-- Main periodic table elements table
CREATE TABLE periodic_elements (
    atomic_number INT PRIMARY KEY,
    symbol VARCHAR(3) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    atomic_mass DECIMAL(10, 6),
    electron_configuration_id INT,
    category_id INT,
    period_number INT,
    group_number INT,
    block_type ENUM('s', 'p', 'd', 'f'),
    density DECIMAL(10, 4), -- g/cm³
    melting_point DECIMAL(10, 2), -- Kelvin
    boiling_point DECIMAL(10, 2), -- Kelvin
    electronegativity DECIMAL(3, 2),
    atomic_radius INT, -- picometers
    ionization_energy DECIMAL(10, 2), -- kJ/mol
    discovered_year INT,
    discovered_by VARCHAR(100),
    is_radioactive BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (electron_configuration_id) REFERENCES electron_configurations(id),
    FOREIGN KEY (category_id) REFERENCES element_categories(id),
    
    INDEX idx_symbol (symbol),
    INDEX idx_category (category_id),
    INDEX idx_period_group (period_number, group_number),
    INDEX idx_discovered_year (discovered_year)
);

-- Table for isotopes
CREATE TABLE isotopes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    atomic_number INT,
    mass_number INT,
    abundance DECIMAL(8, 5), -- percentage
    half_life VARCHAR(50),
    decay_mode VARCHAR(100),
    is_stable BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (atomic_number) REFERENCES periodic_elements(atomic_number),
    UNIQUE KEY unique_isotope (atomic_number, mass_number)
);

-- Insert element categories
INSERT INTO element_categories (name, color_code, description) VALUES
('Alkali metals', '#FF6B6B', 'Highly reactive metals in group 1'),
('Alkaline earth metals', '#4ECDC4', 'Reactive metals in group 2'),
('Transition metals', '#45B7D1', 'Elements with partially filled d orbitals'),
('Post-transition metals', '#96CEB4', 'Metals to the right of transition metals'),
('Metalloids', '#FFEAA7', 'Elements with properties of both metals and nonmetals'),
('Reactive nonmetals', '#DDA0DD', 'Highly reactive nonmetallic elements'),
('Noble gases', '#74B9FF', 'Unreactive gases in group 18'),
('Lanthanides', '#FD79A8', 'Inner transition metals, period 6'),
('Actinides', '#FDCB6E', 'Inner transition metals, period 7, mostly radioactive');

-- Insert some electron configurations
INSERT INTO electron_configurations (configuration, noble_gas_notation) VALUES
('1s¹', '[H] 1s¹'),
('1s²', '[He]'),
('1s² 2s¹', '[He] 2s¹'),
('1s² 2s²', '[He] 2s²'),
('1s² 2s² 2p¹', '[He] 2s² 2p¹'),
('1s² 2s² 2p²', '[He] 2s² 2p²'),
('1s² 2s² 2p³', '[He] 2s² 2p³'),
('1s² 2s² 2p⁴', '[He] 2s² 2p⁴'),
('1s² 2s² 2p⁵', '[He] 2s² 2p⁵'),
('1s² 2s² 2p⁶', '[Ne]'),
('1s² 2s² 2p⁶ 3s¹', '[Ne] 3s¹'),
('1s² 2s² 2p⁶ 3s²', '[Ne] 3s²');

-- Insert the first 20 elements of the periodic table
INSERT INTO periodic_elements (
    atomic_number, symbol, name, atomic_mass, electron_configuration_id, 
    category_id, period_number, group_number, block_type, density, 
    melting_point, boiling_point, electronegativity, atomic_radius, 
    ionization_energy, discovered_year, discovered_by, is_radioactive
) VALUES
(1, 'H', 'Hydrogen', 1.008, 1, 6, 1, 1, 's', 0.0899, 14.01, 20.28, 2.20, 53, 1312.0, 1766, 'Henry Cavendish', FALSE),
(2, 'He', 'Helium', 4.003, 2, 7, 1, 18, 's', 0.1785, 0.95, 4.22, NULL, 31, 2372.3, 1895, 'Pierre Janssen and Norman Lockyer', FALSE),
(3, 'Li', 'Lithium', 6.941, 3, 1, 2, 1, 's', 0.534, 453.69, 1615, 0.98, 167, 520.2, 1817, 'Johan August Arfwedson', FALSE),
(4, 'Be', 'Beryllium', 9.012, 4, 2, 2, 2, 's', 1.85, 1560, 2742, 1.57, 112, 899.5, 1797, 'Louis-Nicolas Vauquelin', FALSE),
(5, 'B', 'Boron', 10.811, 5, 5, 2, 13, 'p', 2.34, 2349, 4200, 2.04, 87, 800.6, 1808, 'Joseph Louis Gay-Lussac and Louis Jacques Thénard', FALSE),
(6, 'C', 'Carbon', 12.011, 6, 6, 2, 14, 'p', 2.267, 3823, 4098, 2.55, 67, 1086.5, NULL, 'Ancient', FALSE),
(7, 'N', 'Nitrogen', 14.007, 7, 6, 2, 15, 'p', 1.251, 63.15, 77.36, 3.04, 56, 1402.3, 1772, 'Daniel Rutherford', FALSE),
(8, 'O', 'Oxygen', 15.999, 8, 6, 2, 16, 'p', 1.429, 54.36, 90.20, 3.44, 48, 1313.9, 1774, 'Joseph Priestley and Carl Wilhelm Scheele', FALSE),
(9, 'F', 'Fluorine', 18.998, 9, 6, 2, 17, 'p', 1.696, 53.53, 85.03, 3.98, 42, 1681.0, 1886, 'Henri Moissan', FALSE),
(10, 'Ne', 'Neon', 20.180, 10, 7, 2, 18, 'p', 0.900, 24.56, 27.07, NULL, 38, 2080.7, 1898, 'William Ramsay and Morris Travers', FALSE),
(11, 'Na', 'Sodium', 22.990, 11, 1, 3, 1, 's', 0.968, 370.95, 1156, 0.93, 190, 495.8, 1807, 'Humphry Davy', FALSE),
(12, 'Mg', 'Magnesium', 24.305, 12, 2, 3, 2, 's', 1.738, 923, 1363, 1.31, 145, 737.7, 1755, 'Joseph Black', FALSE),
(13, 'Al', 'Aluminum', 26.982, NULL, 4, 3, 13, 'p', 2.70, 933.47, 2792, 1.61, 118, 577.5, 1825, 'Hans Christian Ørsted', FALSE),
(14, 'Si', 'Silicon', 28.085, NULL, 5, 3, 14, 'p', 2.329, 1687, 3538, 1.90, 111, 786.5, 1824, 'Jöns Jacob Berzelius', FALSE),
(15, 'P', 'Phosphorus', 30.974, NULL, 6, 3, 15, 'p', 1.823, 317.30, 553.65, 2.19, 98, 1011.8, 1669, 'Hennig Brand', FALSE),
(16, 'S', 'Sulfur', 32.065, NULL, 6, 3, 16, 'p', 1.960, 388.36, 717.75, 2.58, 88, 999.6, NULL, 'Ancient', FALSE),
(17, 'Cl', 'Chlorine', 35.453, NULL, 6, 3, 17, 'p', 3.214, 171.6, 239.11, 3.16, 79, 1251.2, 1774, 'Carl Wilhelm Scheele', FALSE),
(18, 'Ar', 'Argon', 39.948, NULL, 7, 3, 18, 'p', 1.784, 83.80, 87.30, NULL, 71, 1520.6, 1894, 'Lord Rayleigh and William Ramsay', FALSE),
(19, 'K', 'Potassium', 39.098, NULL, 1, 4, 1, 's', 0.862, 336.53, 1032, 0.82, 243, 418.8, 1807, 'Humphry Davy', FALSE),
(20, 'Ca', 'Calcium', 40.078, NULL, 2, 4, 2, 's', 1.540, 1115, 1757, 1.00, 194, 589.8, 1808, 'Humphry Davy', FALSE);

-- Insert some isotopes
INSERT INTO isotopes (atomic_number, mass_number, abundance, half_life, decay_mode, is_stable) VALUES
(1, 1, 99.985, NULL, NULL, TRUE),
(1, 2, 0.015, NULL, NULL, TRUE),
(1, 3, 0.000, '12.32 years', 'beta decay', FALSE),
(2, 3, 0.000137, NULL, NULL, TRUE),
(2, 4, 99.999863, NULL, NULL, TRUE),
(6, 12, 98.93, NULL, NULL, TRUE),
(6, 13, 1.07, NULL, NULL, TRUE),
(6, 14, 0.000, '5,730 years', 'beta decay', FALSE),
(8, 16, 99.757, NULL, NULL, TRUE),
(8, 17, 0.038, NULL, NULL, TRUE),
(8, 18, 0.205, NULL, NULL, TRUE);

-- Create views for common queries
CREATE VIEW v_element_summary AS
SELECT 
    pe.atomic_number,
    pe.symbol,
    pe.name,
    pe.atomic_mass,
    ec.name as category,
    pe.period_number,
    pe.group_number,
    pe.discovered_year,
    pe.discovered_by
FROM periodic_elements pe
LEFT JOIN element_categories ec ON pe.category_id = ec.id
ORDER BY pe.atomic_number;

-- Create a view for elements by period
CREATE VIEW v_elements_by_period AS
SELECT 
    period_number,
    GROUP_CONCAT(
        CONCAT(symbol, ' (', name, ')') 
        ORDER BY atomic_number 
        SEPARATOR ', '
    ) as elements
FROM periodic_elements
GROUP BY period_number
ORDER BY period_number;

-- Sample queries demonstrating database usage

-- 1. Find all noble gases
SELECT pe.symbol, pe.name, pe.atomic_number
FROM periodic_elements pe
JOIN element_categories ec ON pe.category_id = ec.id
WHERE ec.name = 'Noble gases'
ORDER BY pe.atomic_number;

-- 2. Get elements discovered in the 18th century
SELECT symbol, name, discovered_year, discovered_by
FROM periodic_elements
WHERE discovered_year BETWEEN 1700 AND 1799
ORDER BY discovered_year;

-- 3. Find the lightest and heaviest elements (by atomic mass)
(SELECT 'Lightest' as type, symbol, name, atomic_mass
 FROM periodic_elements
 WHERE atomic_mass IS NOT NULL
 ORDER BY atomic_mass ASC
 LIMIT 1)
UNION ALL
(SELECT 'Heaviest' as type, symbol, name, atomic_mass
 FROM periodic_elements
 WHERE atomic_mass IS NOT NULL
 ORDER BY atomic_mass DESC
 LIMIT 1);

-- 4. Count elements by category
SELECT ec.name as category, COUNT(*) as element_count
FROM periodic_elements pe
JOIN element_categories ec ON pe.category_id = ec.id
GROUP BY ec.name
ORDER BY element_count DESC;

-- 5. Find elements with high electronegativity (> 3.0)
SELECT symbol, name, electronegativity
FROM periodic_elements
WHERE electronegativity > 3.0
ORDER BY electronegativity DESC;

-- 6. Get all isotopes of carbon
SELECT 
    pe.symbol,
    pe.name,
    i.mass_number,
    i.abundance,
    i.is_stable,
    i.half_life
FROM isotopes i
JOIN periodic_elements pe ON i.atomic_number = pe.atomic_number
WHERE pe.symbol = 'C'
ORDER BY i.mass_number;

-- 7. Find transition metals in period 4
SELECT symbol, name, atomic_number
FROM periodic_elements pe
JOIN element_categories ec ON pe.category_id = ec.id
WHERE ec.name = 'Transition metals' AND pe.period_number = 4
ORDER BY atomic_number;

-- Stored procedures for common operations

DELIMITER //

-- Procedure to get element details by symbol
CREATE PROCEDURE GetElementBySymbol(IN element_symbol VARCHAR(3))
BEGIN
    SELECT 
        pe.*,
        ec.name as category_name,
        econf.configuration,
        econf.noble_gas_notation
    FROM periodic_elements pe
    LEFT JOIN element_categories ec ON pe.category_id = ec.id
    LEFT JOIN electron_configurations econf ON pe.electron_configuration_id = econf.id
    WHERE pe.symbol = element_symbol;
END //

-- Function to calculate molecular weight
CREATE FUNCTION CalculateMolecularWeight(formula TEXT) 
RETURNS DECIMAL(10,4)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE total_weight DECIMAL(10,4) DEFAULT 0;
    -- Simplified implementation for demonstration
    -- In a real scenario, this would parse the chemical formula
    RETURN total_weight;
END //

DELIMITER ;

-- Create indexes for better performance
CREATE INDEX idx_atomic_mass ON periodic_elements(atomic_mass);
CREATE INDEX idx_discovered_year ON periodic_elements(discovered_year);
CREATE INDEX idx_electronegativity ON periodic_elements(electronegativity);

-- Add some constraints for data integrity
ALTER TABLE periodic_elements 
ADD CONSTRAINT chk_atomic_number CHECK (atomic_number > 0 AND atomic_number <= 120),
ADD CONSTRAINT chk_period CHECK (period_number BETWEEN 1 AND 7),
ADD CONSTRAINT chk_group CHECK (group_number BETWEEN 1 AND 18),
ADD CONSTRAINT chk_electronegativity CHECK (electronegativity IS NULL OR electronegativity BETWEEN 0 AND 4);

-- Sample trigger to log changes
CREATE TABLE element_audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    atomic_number INT,
    action_type ENUM('INSERT', 'UPDATE', 'DELETE'),
    old_values JSON,
    new_values JSON,
    changed_by VARCHAR(100) DEFAULT USER(),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER tr_element_audit_update
AFTER UPDATE ON periodic_elements
FOR EACH ROW
BEGIN
    INSERT INTO element_audit_log (atomic_number, action_type, old_values, new_values)
    VALUES (
        NEW.atomic_number, 
        'UPDATE',
        JSON_OBJECT(
            'symbol', OLD.symbol,
            'name', OLD.name,
            'atomic_mass', OLD.atomic_mass
        ),
        JSON_OBJECT(
            'symbol', NEW.symbol,
            'name', NEW.name,
            'atomic_mass', NEW.atomic_mass
        )
    );
END //

DELIMITER ;

-- Final summary query
SELECT 
    'Database Summary' as info,
    (SELECT COUNT(*) FROM periodic_elements) as total_elements,
    (SELECT COUNT(*) FROM element_categories) as total_categories,
    (SELECT COUNT(*) FROM isotopes) as total_isotopes,
    (SELECT COUNT(*) FROM electron_configurations) as total_configurations;

-- End of periodic table database schema