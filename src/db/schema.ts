import { pgTable, serial, text, pgEnum, numeric } from "drizzle-orm/pg-core";

export function enumToPgEnum<T extends Record<string, any>>(
  myEnum: T,
): [T[keyof T], ...T[keyof T][]] {
  return Object.values(myEnum).map((value: any) => `${value}`) as any
}

export const organizationsTable = pgTable('organizations', {
  id: serial('id').primaryKey(),
  name: text('name').notNull(),
  plan_id: serial('plan_id').references(() => plansTable.id),
});

export type InsertOrganization = typeof organizationsTable.$inferInsert;
export type SelectOrganization = typeof organizationsTable.$inferSelect;

export const usersTable = pgTable('users', {
  id: serial('id').primaryKey(),
  name: text('name').notNull(),
  email: text('email').notNull().unique(),
  organization_id: serial('organization_id').references(() => organizationsTable.id),
});

export type InsertUser = typeof usersTable.$inferInsert;
export type SelectUser = typeof usersTable.$inferSelect;

export enum Priority {
  CRITICAL = 'critical',
  MAJOR = 'major',
  MEDIUM = 'medium',
  SMALL = 'small'
}

export enum Status {
  OPEN = 'open',
  IN_PROGRESS = 'in_progress',
  RESOLVED = 'resolved',
  CLOSED = 'closed'
}

export const priorityEnum = pgEnum('priority', enumToPgEnum(Priority))
export const statusEnum = pgEnum('status', enumToPgEnum(Status))

export const bugsTable = pgTable('bugs', {
  id: serial('id').primaryKey(),
  assignee: serial('assignee').references(() => usersTable.id),
  organization_id: serial('organization_id').references(() => organizationsTable.id),
  title: text('title').notNull(),
  description: text('description').notNull(),
  priority: priorityEnum('small').notNull(),
  status: statusEnum('open').notNull(),
  user_id: text('user_id'),
  email: text('email'),
});

export type InsertBug = typeof bugsTable.$inferInsert;
export type SelectBug = typeof bugsTable.$inferSelect;

export const plansTable = pgTable('plans', {
  id: serial('id').primaryKey(),
  name: text('name').notNull(),
  price: numeric('price').notNull(),
  description: text('description').notNull(),
});
