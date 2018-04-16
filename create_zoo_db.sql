/* Create basic table layout */
/* 
TEMP Notes: 
- Looking into geographic coords. Easier just to split in two.
- Defaulted to a varchar, size 20 -- Needs reviewing.
- Using not null on most things. This hasn't been checked methodically
    for sensibility so may need to tighten/relax constraints.
- Some attributes could use a set of defined options to choose from when
    entering information; Either a table of reference, or on the UI
    side (e.g. selectors, dropdowns, etc.) Same for item_type, member_lvl,
- All primary keys are INT types. Still need to check if anything
	about this could be suboptimal.
- Reasonable to expect all employees and vendors have phone number?
- Decide if member_lvl in Membership should be int or varchar.
- In general, decide when alphanumeric identifiers are more appropriate.
- Type for phone numbers may need changed for validation purposes, and
	issues with leading zeros.
-
*/

CREATE TABLE Diet (
  a_id INT not null,
  diet_type VARCHAR(20) not null,
  diet_freq VARCHAR(20) not null,
  PRIMARY KEY (diet_type) );

CREATE TABLE Enclosure (
  enclosure_id INT not null,
  a_id INT not null,
  region VARCHAR(20) not null,
  map_coords INT not null, /* Look into geographic type */
  enclosure_type VARCHAR(20) not null,
  PRIMARY KEY (enclosure_id) );

CREATE TABLE Animal (
  a_id INT not null,
  a_name INT not null,
  sci_name INT,
  com_name INT not null,
  a_gender CHAR(1) not null, /* char type for hermaphroditism */
  a_dob DATE, /* YYYY-MM-DD */
  diet_type VARCHAR(20) not null,
  enclosure_id INT not null,
  PRIMARY KEY (a_id),
  FOREIGN KEY (diet_type) REFERENCES Diet(diet_type),
  FOREIGN KEY (enclosure_id) REFERENCES Enclosure(enclosure_id) );

CREATE TABLE Membership (
  member_id INT not null,
  start_date DATE not null,
  member_lvl varchar(20) not null,
  vis_id INT not null,
  PRIMARY KEY (member_id) );

CREATE TABLE Employee (
  e_id INT not null,
  e_name VARCHAR(20) not null,
  e_position VARCHAR(20) not null,
  hire_date DATE not null,
  e_address VARCHAR(80) not null,
  e_phone INT not null,
  PRIMARY KEY (e_id) );

CREATE TABLE Vendor (
  vend_id INT not null,
  vend_name VARCHAR(20) not null,
  vend_address VARCHAR(80) not null,
  vend_phone INT not null,
  PRIMARY KEY (vend_id) );

CREATE TABLE Visitor (
  vis_id INT not null,
  vis_address VARCHAR(80),
  vis_phone INT,
  member_id INT,
  PRIMARY KEY (vis_id),
  FOREIGN KEY (member_id) REFERENCES Membership(member_id));

CREATE TABLE Merchandise (
  item_id INT not null,
  item_name VARCHAR(20) not null,
  vend_id INT not null,
  item_type VARCHAR(20) not null,
  PRIMARY KEY (item_id),
  FOREIGN KEY (vend_id) REFERENCES Vendor(vend_id) );

CREATE TABLE Purchase (
  order_id INT not null,
  item_id INT not null,
  order_date DATE not null,
  vis_id INT,
  PRIMARY KEY (order_id),
  FOREIGN KEY (vis_id) REFERENCES Visitor(vis_id) );

/* Reference Table */
CREATE TABLE cares_for (
  a_id INT not null,
  e_id INT not null,
  PRIMARY KEY (a_id, e_id),
  FOREIGN KEY (a_id) REFERENCES Animal(a_id),
  FOREIGN KEY (e_id) REFERENCES Employee(e_id) );

/* Reference Table */
CREATE TABLE describes (
  order_id INT not null,
  item_id INT not null,
  PRIMARY KEY (order_id, item_id),
  FOREIGN KEY (order_id) REFERENCES Purchase(order_id),
  FOREIGN KEY (item_id) REFERENCES Merchandise(item_id) );

  