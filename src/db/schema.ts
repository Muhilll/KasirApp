import {
  int,
  longtext,
  mysqlEnum,
  mysqlTable,
  foreignKey,
  serial,
  varchar,
  datetime,
} from "drizzle-orm/mysql-core";
import { sql } from "drizzle-orm/sql/sql";

export const users = mysqlTable("users", {
  id: int().primaryKey().autoincrement(),
  nama: varchar({ length: 255 }).notNull(),
  email: varchar({ length: 255 }).notNull().unique(),
  password: varchar({ length: 255 }).notNull(),
  role: mysqlEnum("role", ["user", "admin"]).notNull(),
  created_at: datetime()
    .default(sql`CURRENT_TIMESTAMP`)
    .notNull(), 
  updated_at: datetime()
    .default(sql`CURRENT_TIMESTAMP`)
    .notNull(),
});





