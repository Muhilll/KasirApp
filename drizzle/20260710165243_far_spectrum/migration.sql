CREATE TABLE `categoris` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`name` varchar(255) NOT NULL,
	`description` longtext NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `customers` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`nama` varchar(255) NOT NULL,
	`phone` varchar(255) NOT NULL,
	`address` longtext NOT NULL,
	`member_id` int NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `members` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`nama` varchar(255) NOT NULL,
	`phone` varchar(255) NOT NULL,
	`member_point` int NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `menus` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`name` varchar(255) NOT NULL,
	`path` varchar(255) NOT NULL,
	`permission_path` varchar(255),
	`icon` varchar(255),
	`parent_id` int,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `products` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`category_id` int NOT NULL,
	`barcode` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` longtext NOT NULL,
	`purchase_price` int NOT NULL,
	`selling_price` int NOT NULL,
	`stock` int NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `purchase_details` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`purchase_id` int NOT NULL,
	`product_id` int NOT NULL,
	`price` int NOT NULL,
	`qty` int NOT NULL,
	`subtotal` int NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `purchases` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`supplier_id` int NOT NULL,
	`invoice` varchar(255) NOT NULL,
	`purchase_date` datetime,
	`total` int NOT NULL,
	`user_id` int NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `role_permissions` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`role_id` int NOT NULL,
	`menu_id` int NOT NULL,
	`can_read` boolean NOT NULL DEFAULT false,
	`can_update` boolean NOT NULL DEFAULT false,
	`can_delete` boolean NOT NULL DEFAULT false,
	`can_report` boolean NOT NULL DEFAULT false,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `roles` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`code` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT `code_unique` UNIQUE INDEX(`code`)
);
--> statement-breakpoint
CREATE TABLE `stocks_logs` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`product_id` int NOT NULL,
	`user_id` int NOT NULL,
	`type` enum('in','out','adjustment') NOT NULL,
	`quantity` int NOT NULL,
	`stock_before` int NOT NULL,
	`stock_after` int NOT NULL,
	`note` longtext NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `store_settings` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`store_name` varchar(255) NOT NULL,
	`address` longtext NOT NULL,
	`email` varchar(255) NOT NULL,
	`logo` longtext NOT NULL,
	`tax` int NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `suppliers` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`name` varchar(255) NOT NULL,
	`phone` varchar(255) NOT NULL,
	`address` longtext NOT NULL,
	`email` varchar(255) NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `transaction_details` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`transaction_id` int NOT NULL,
	`product_id` int NOT NULL,
	`quantity` int NOT NULL,
	`stock_before` int NOT NULL,
	`stock_after` int NOT NULL,
	`subtotal` int NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `transactions` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`invoice_number` varchar(255) NOT NULL,
	`customer_id` int NOT NULL,
	`transaction_date` datetime,
	`subtotal` int NOT NULL,
	`discount` int NOT NULL,
	`grand_total` int NOT NULL,
	`payment_method` enum('cash','transfer','qris') NOT NULL,
	`paid_amount` int NOT NULL,
	`change_amount` int NOT NULL,
	`status` enum('pending','paid','cancelled') NOT NULL,
	`tax` int NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `units` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`name` varchar(255) NOT NULL,
	`description` longtext NOT NULL,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
CREATE TABLE `users` (
	`id` int AUTO_INCREMENT PRIMARY KEY,
	`name` varchar(255) NOT NULL,
	`password` varchar(255) NOT NULL,
	`role_id` int NOT NULL,
	`is_active` boolean NOT NULL DEFAULT false,
	`created_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	`updated_at` datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);
--> statement-breakpoint
ALTER TABLE `customers` ADD CONSTRAINT `customers_member_id_members_id_fkey` FOREIGN KEY (`member_id`) REFERENCES `members`(`id`);--> statement-breakpoint
ALTER TABLE `menus` ADD CONSTRAINT `menus_parent_id_menus_id_fkey` FOREIGN KEY (`parent_id`) REFERENCES `menus`(`id`);--> statement-breakpoint
ALTER TABLE `products` ADD CONSTRAINT `products_category_id_categoris_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `categoris`(`id`);--> statement-breakpoint
ALTER TABLE `purchase_details` ADD CONSTRAINT `purchase_details_purchase_id_purchases_id_fkey` FOREIGN KEY (`purchase_id`) REFERENCES `purchases`(`id`);--> statement-breakpoint
ALTER TABLE `purchase_details` ADD CONSTRAINT `purchase_details_product_id_products_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products`(`id`);--> statement-breakpoint
ALTER TABLE `purchases` ADD CONSTRAINT `purchases_supplier_id_suppliers_id_fkey` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers`(`id`);--> statement-breakpoint
ALTER TABLE `purchases` ADD CONSTRAINT `purchases_user_id_users_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);--> statement-breakpoint
ALTER TABLE `role_permissions` ADD CONSTRAINT `role_permissions_role_id_roles_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`);--> statement-breakpoint
ALTER TABLE `role_permissions` ADD CONSTRAINT `role_permissions_menu_id_menus_id_fkey` FOREIGN KEY (`menu_id`) REFERENCES `menus`(`id`);--> statement-breakpoint
ALTER TABLE `stocks_logs` ADD CONSTRAINT `stocks_logs_product_id_products_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products`(`id`);--> statement-breakpoint
ALTER TABLE `stocks_logs` ADD CONSTRAINT `stocks_logs_user_id_users_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);--> statement-breakpoint
ALTER TABLE `transaction_details` ADD CONSTRAINT `transaction_details_transaction_id_transactions_id_fkey` FOREIGN KEY (`transaction_id`) REFERENCES `transactions`(`id`);--> statement-breakpoint
ALTER TABLE `transaction_details` ADD CONSTRAINT `transaction_details_product_id_products_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products`(`id`);--> statement-breakpoint
ALTER TABLE `transactions` ADD CONSTRAINT `transactions_customer_id_customers_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`);--> statement-breakpoint
ALTER TABLE `users` ADD CONSTRAINT `users_role_id_roles_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`);