/*
 * the following is an example of the CREATE
 * TABLE command. take note of the multi-column
 * primary key, which requires a table constraint
 * to be set. Based on the primary key, the 
 * combination of role_id and user_id must be
 * unique
 */
CREATE TABLE account_role(
user_id integer NOT NULL,
role_id integer NOT NULL,
grant_date timestamp without time zone,
/* 
 * since the primary key is given a column
 * list, must use a table level constraint
 * as shown below
 */
PRIMARY KEY (user_id, role_id),

-- foreign key constraint for `role_id`
CONSTRAINT account_role_role_id_fkey FOREIGN KEY (role_id)
	REFERENCES role (role_id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,

-- foreign key constraint for `user_id`
CONSTRAINT account_role_user_id_fkey FOREIGN KEY (user_id)
	REFERENCES account (user_id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
);