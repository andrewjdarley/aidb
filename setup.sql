
CREATE TABLE Nation (
    nation_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    alliance VARCHAR(50) -- 'Entente', 'Central Powers', 'Neutral'
);

CREATE TABLE Location (
    location_id INT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    country VARCHAR(100),
    type VARCHAR(100) -- town, ridge, mountain
);

CREATE TABLE Battle (
    battle_id INT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    start_date DATE,
    end_date DATE,
    location_id INT,
    outcome VARCHAR(100), -- 'Entente Victory', 'German Victory', 'Stalemate'
    total_casualties INT,
    allied_casualties INT,
    central_casualties INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

CREATE TABLE Military_Unit (
    unit_id INT PRIMARY KEY,
    name VARCHAR(200) NOT NULL, -- "British 4th Army", "German XV Reserve Corps"
    nation_id INT,
    unit_type VARCHAR(50), -- 'Army', 'Corps', 'Division'
    estimated_size INT,
    FOREIGN KEY (nation_id) REFERENCES Nation(nation_id)
);

CREATE TABLE Commander (
    commander_id INT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    nation_id INT,
    rank VARCHAR(100),
    service_start_date DATE,
    service_end_date DATE,
    FOREIGN KEY (nation_id) REFERENCES Nation(nation_id)
);

CREATE TABLE Battle_Unit (
    battle_id INT,
    unit_id INT,
    casualties INT,
    PRIMARY KEY (battle_id, unit_id),
    FOREIGN KEY (battle_id) REFERENCES Battle(battle_id),
    FOREIGN KEY (unit_id) REFERENCES Military_Unit(unit_id)
);

CREATE TABLE Unit_Commander (
    unit_id INT,
    commander_id INT,
    battle_id INT,
    PRIMARY KEY (unit_id, commander_id, battle_id),
    FOREIGN KEY (unit_id) REFERENCES Military_Unit(unit_id),
    FOREIGN KEY (commander_id) REFERENCES Commander(commander_id),
    FOREIGN KEY (battle_id) REFERENCES Battle(battle_id)
);
