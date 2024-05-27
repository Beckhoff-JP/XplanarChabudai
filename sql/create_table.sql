CREATE TABLE cordinates (
    id SERIAL,
    name varchar(64),
    position_unit VARCHAR(16),
	PRIMARY KEY (id)
);

CREATE TABLE axes (
    id SERIAL,
    name varchar(64),
    virtual boolean NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE activities (
    id SERIAL,
    name varchar(64),
	PRIMARY KEY (id)
);

CREATE TABLE axes_state (
    time timestamp NOT NULL,
    axis_id integer NOT NULL,
    cordinate_id integer NOT NULL,
    position double precision,
    activity_id integer NOT NULL,
    foreign key (axis_id) references axes(id),
    foreign key (cordinate_id) references cordinates(id),
    foreign key (activity_id) references activities(id)
);


SELECT create_hypertable('axes_state', by_range('time'));

INSERT INTO cordinates (name, position_unit) VALUES ('X', 'mm');
INSERT INTO cordinates (name, position_unit) VALUES ('Y', 'mm');
INSERT INTO cordinates (name, position_unit) VALUES ('Z', 'mm');
INSERT INTO cordinates (name, position_unit) VALUES ('A', 'deg');
INSERT INTO cordinates (name, position_unit) VALUES ('B', 'deg');
INSERT INTO cordinates (name, position_unit) VALUES ('C', 'deg');

INSERT INTO axes (name, virtual) VALUES ('Mover 1', false);

INSERT INTO activities (name) VALUES ('POWER OFF');
INSERT INTO activities (name) VALUES ('IDLE');
INSERT INTO activities (name) VALUES ('MOVING');
INSERT INTO activities (name) VALUES ('ERROR');