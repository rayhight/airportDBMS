CREATE DATABASE `airportmsdb`;

create table employee
(
	empl_id 		int 		unsigned	not null,
	first_name 		varchar(255)	not null,
	second_name 		varchar(255)	not null,
	gender 			char,
	adress			varchar(255),
	phone_num  		int		unsigned,
	personal_email		varchar(255),
	
	primary key (empl_id),
	unique (empl_id)
);

create table employee_prof_info
(
	empl_id			int		unsigned,
	emp_position  		varchar(255)	not null,
	start_date		date,
	end_date		date,
	
	foreign key (empl_id) references employee(empl_id)
);

create table employee_salary_info
(
	empl_id			int		unsigned,
	payday  		datetime	not null,
	amount			int		not null,
	
	foreign key (empl_id) references employee(empl_id)
);

create table employee_login_info
(
	empl_id			int		unsigned,
	reg_date  		datetime	not null,
	username		varchar(255)	not null	unique,
	password		varchar(16)	not null,
	
	foreign key (empl_id) references employee(empl_id)
);

create table department
(
	dep_id 			int 		unsigned	not null,
	title 			varchar(255) 	not null,
	
	primary key (dep_id)
);

create table department_employee
(
	empl_id 		int		unsigned,
	dep_id 			int		unsigned,
	day_of_week		bit(7) 		not null,
	start_hour		time		not null,
	end_hour 		time		not null,
	
	foreign key (empl_id) references employee(empl_id), 
	foreign key (dep_id) references department(dep_id)	
);

create table airline_info
(
	airline_id		int 		unsigned	not null,
	al_name 		varchar(255)	not null,
	alias			varchar(255),
	origin_country		varchar(255),		
	IATA 			varchar(2),
	
	primary key (airline_id)
);

create table hangar
(
	hangar_id 		tinyint		unsigned	not null,
	dep_id			int		unsigned,
	location		varchar(255),
	han_capacity		int,
	number_planes		int,
	
	primary key(hangar_id),
	unique(hangar_id),
	foreign key(dep_id) references department(dep_id)
);

create table airplane_type
(
	IATA_code		varchar(5)	not null,
	name			varchar(255),
	max_capacity		int,
	
	primary key (IATA_code)
);

create table airplane
(
	plane_id 		int		unsigned	not null,
	hangar_id		tinyint		unsigned,
	plane_type		varchar(5),
	
	primary key(plane_id),
	unique(plane_id),
	foreign key(hangar_id) references hangar(hangar_id),
	foreign key(plane_type) references airplane_type(IATA_code)
);

create table flight
(
	flight_id 		int 		unsigned	not null	unique,
	airline_id		int		unsigned,
	plane_id		int		unsigned,
	flight_type		varchar(255)	not null,
	expected_load		int,
	actual_load		int,
	
	primary key (flight_id),
	foreign key	(airline_id) references airline_info(airline_id),
	foreign key (plane_id) references airplane(plane_id)
);

create table department_flight
(
	flight_id		int		unsigned,
	dep_id			int		unsigned,
	
	foreign key (flight_id) references flight(flight_id), 
	foreign key (dep_id) references department(dep_id)	
);

create table gate
(
	gate_num		char(3)		not null,
	dep_id			int		unsigned,
	location		varchar(255),
	gate_type		set('Jet bridge', 'Bus') not null,
	
	primary key (gate_num),
	foreign key (dep_id) references department(dep_id)
);

create table booking
(
	booking_id 		int 		unsigned	not null,
	airline_id   		int		unsigned,
	flight_id		int		unsigned,
	class			set('fc', 'bs', 'pe', 'ec')	not null,
	seat_num		varchar(5)	not null,
	bag_book		bool		not null	default(0),	
	
	primary key(booking_id),
	foreign key(airline_id) references airline_info(airline_id),
	foreign key(flight_id) references flight(flight_id)
);

create table passanger
(
	passanger_id		int		unsigned,
	first_name		varchar(30)	not null,
	last_name 		varchar(30)	not null,
	gender			char,
	document_num		int		unsigned	not null,
	
	unique(document_num),
	primary key (document_num),
	foreign key (passanger_id) references booking(booking_id)
);

create table baggage
(
	booking_id		int		unsigned,
	accepted_weight 	float,
	actual_weight		float,
	status 			bool		not null 	default(0),
	
	foreign key (booking_id) references booking(booking_id)
);

create table runway
(
	runway_id 		tinyint		unsigned,
	lenght			double,
	
	primary key(runway_id)
);

create table runway_accept_airplane
(
	runway_id		tinyint		unsigned,
	air_type		varchar(5),
	
	foreign key (runway_id) references runway(runway_id),
	foreign key (air_type) references airplane_type(IATA_code)
);

create table flight_schedule
(
	flight_id		int		unsigned,
	gate_num		char(3),
	runway_id		tinyint		unsigned,
	dep_from		varchar(30),
	arrive_to		varchar(30),
	dep_date_time		datetime,
	arr_date_time		datetime,
	status			varchar(30),
	
	foreign key	(flight_id) references flight(flight_id),
	foreign key (gate_num)	references gate(gate_num),
	foreign key (runway_id)	references runway(runway_id)
);



