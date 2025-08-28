-- Create users table
CREATE TABLE users (
    id serial PRIMARY KEY,
    email text UNIQUE NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT now()
);

-- Create transactions table
CREATE TABLE transactions (
    id serial PRIMARY KEY,
    user_id integer REFERENCES users(id),
    amount decimal(15,2) NOT NULL,
    status text DEFAULT 'pending',
    created_at timestamp with time zone DEFAULT now()
);

-- Create logs table
CREATE TABLE logs (
    id serial PRIMARY KEY,
    name text NOT NULL,
    level text NOT NULL,
    properties jsonb DEFAULT '{}',
    user_id integer REFERENCES users(id),
    created_at timestamp with time zone DEFAULT now()
);

---
-- Populate data
---

-- Insert users (25 users with diverse profiles)
INSERT INTO users (email, name) VALUES
('john.smith@email.com', 'John Smith'),
('sarah.johnson@email.com', 'Sarah Johnson'),
('mike.wilson@email.com', 'Mike Wilson'),
('emma.davis@email.com', 'Emma Davis'),
('robert.brown@email.com', 'Robert Brown'),
('lisa.garcia@email.com', 'Lisa Garcia'),
('david.miller@email.com', 'David Miller'),
('jennifer.lee@email.com', 'Jennifer Lee'),
('chris.anderson@email.com', 'Chris Anderson'),
('amanda.taylor@email.com', 'Amanda Taylor'),
('kevin.martinez@email.com', 'Kevin Martinez'),
('rachel.white@email.com', 'Rachel White'),
('alex.thompson@email.com', 'Alex Thompson'),
('maria.rodriguez@email.com', 'Maria Rodriguez'),
('james.williams@email.com', 'James Williams'),
('sophia.chen@email.com', 'Sophia Chen'),
('daniel.kim@email.com', 'Daniel Kim'),
('olivia.jones@email.com', 'Olivia Jones'),
('michael.davis@email.com', 'Michael Davis'),
('emily.wilson@email.com', 'Emily Wilson'),
('ryan.moore@email.com', 'Ryan Moore'),
('ashley.taylor@email.com', 'Ashley Taylor'),
('brandon.jackson@email.com', 'Brandon Jackson'),
('hannah.martin@email.com', 'Hannah Martin'),
('tyler.lee@email.com', 'Tyler Lee'),
('madison.garcia@email.com', 'Madison Garcia');

-- Insert normal transactions (40 legitimate transactions)
INSERT INTO transactions (user_id, amount, status) VALUES
(1, 45.99, 'completed'),
(2, 1500.00, 'completed'),
(3, 23.50, 'completed'),
(4, 89.99, 'completed'),
(5, 2500.00, 'completed'),
(6, 156.78, 'completed'),
(7, 899.99, 'completed'),
(8, 3200.00, 'completed'),
(9, 67.40, 'completed'),
(10, 1200.00, 'completed'),
(11, 34.99, 'completed'),
(12, 750.00, 'completed'),
(1, 800.00, 'completed'),
(2, 199.99, 'completed'),
(3, 299.99, 'completed'),
(13, 125.50, 'completed'),
(14, 450.00, 'completed'),
(15, 78.25, 'completed'),
(16, 1200.75, 'completed'),
(17, 89.99, 'completed'),
(18, 567.30, 'completed'),
(19, 234.56, 'completed'),
(20, 789.12, 'completed'),
(21, 345.67, 'completed'),
(22, 123.45, 'completed'),
(23, 678.90, 'completed'),
(24, 456.78, 'completed'),
(25, 234.56, 'completed'),
(13, 890.12, 'completed'),
(14, 123.45, 'completed'),
(15, 567.89, 'completed'),
(16, 345.67, 'completed'),
(17, 789.01, 'completed'),
(18, 234.56, 'completed'),
(19, 456.78, 'completed'),
(20, 123.45, 'completed'),
(21, 678.90, 'completed'),
(22, 345.67, 'completed'),
(23, 567.89, 'completed'),
(24, 234.56, 'completed'),
(25, 789.01, 'completed');

-- Insert fraudulent transactions (20 suspicious transactions)
INSERT INTO transactions (user_id, amount, status) VALUES
(3, 75000.00, 'failed'),
(3, 50000.00, 'failed'),
(3, 45000.00, 'failed'),
(8, 25000.00, 'cancelled'),
(1, 99999.99, 'failed'),
(6, 15000.00, 'failed'),
(5, 12000.00, 'failed'),
(11, 65000.00, 'pending'),
(13, 85000.00, 'failed'),
(14, 35000.00, 'cancelled'),
(15, 95000.00, 'failed'),
(16, 28000.00, 'pending'),
(17, 72000.00, 'failed'),
(18, 42000.00, 'cancelled'),
(19, 88000.00, 'failed'),
(20, 33000.00, 'pending'),
(21, 78000.00, 'failed'),
(22, 38000.00, 'cancelled'),
(23, 92000.00, 'failed'),
(24, 29000.00, 'pending'),
(25, 68000.00, 'failed');

-- Insert logs for normal transactions
INSERT INTO logs (name, level, properties, user_id) VALUES
('transaction_created', 'INFO', '{"transaction_id": 1, "amount": 45.99, "type": "purchase"}', 1),
('transaction_completed', 'INFO', '{"transaction_id": 1, "processing_time_ms": 2500}', 1),
('transaction_created', 'INFO', '{"transaction_id": 2, "amount": 1500.00, "type": "transfer"}', 2),
('transaction_completed', 'INFO', '{"transaction_id": 2, "processing_time_ms": 3200}', 2),
('transaction_created', 'INFO', '{"transaction_id": 3, "amount": 23.50, "type": "purchase"}', 3),
('transaction_completed', 'INFO', '{"transaction_id": 3, "processing_time_ms": 1800}', 3),
('large_transaction_alert', 'WARN', '{"transaction_id": 5, "amount": 2500.00, "threshold": 2000.00}', 5),
('transaction_completed', 'INFO', '{"transaction_id": 5, "processing_time_ms": 4500}', 5),
('transaction_created', 'INFO', '{"transaction_id": 7, "amount": 899.99, "type": "purchase"}', 7),
('transaction_completed', 'INFO', '{"transaction_id": 7, "processing_time_ms": 2100}', 7),
('transaction_created', 'INFO', '{"transaction_id": 13, "amount": 125.50, "type": "purchase"}', 13),
('transaction_completed', 'INFO', '{"transaction_id": 13, "processing_time_ms": 1900}', 13),
('transaction_created', 'INFO', '{"transaction_id": 14, "amount": 450.00, "type": "transfer"}', 14),
('transaction_completed', 'INFO', '{"transaction_id": 14, "processing_time_ms": 2800}', 14),
('transaction_created', 'INFO', '{"transaction_id": 15, "amount": 78.25, "type": "purchase"}', 15),
('transaction_completed', 'INFO', '{"transaction_id": 15, "processing_time_ms": 1600}', 15),
('transaction_created', 'INFO', '{"transaction_id": 16, "amount": 1200.75, "type": "transfer"}', 16),
('transaction_completed', 'INFO', '{"transaction_id": 16, "processing_time_ms": 3400}', 16),
('transaction_created', 'INFO', '{"transaction_id": 17, "amount": 89.99, "type": "purchase"}', 17),
('transaction_completed', 'INFO', '{"transaction_id": 17, "processing_time_ms": 2200}', 17),
('transaction_created', 'INFO', '{"transaction_id": 18, "amount": 567.30, "type": "purchase"}', 18),
('transaction_completed', 'INFO', '{"transaction_id": 18, "processing_time_ms": 2600}', 18),
('transaction_created', 'INFO', '{"transaction_id": 19, "amount": 234.56, "type": "purchase"}', 19),
('transaction_completed', 'INFO', '{"transaction_id": 19, "processing_time_ms": 2400}', 19),
('transaction_created', 'INFO', '{"transaction_id": 20, "amount": 789.12, "type": "transfer"}', 20),
('transaction_completed', 'INFO', '{"transaction_id": 20, "processing_time_ms": 3100}', 20);

-- Insert logs for fraudulent transactions
INSERT INTO logs (name, level, properties, user_id) VALUES
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 41, "amount": 75000.00, "fraud_score": 95}', 3),
('velocity_check_failed', 'ERROR', '{"user_id": 3, "transactions_in_timeframe": 3, "total_amount": 170000.00}', 3),
('transaction_blocked', 'WARN', '{"transaction_id": 42, "reason": "rapid_succession"}', 3),
('transaction_blocked', 'WARN', '{"transaction_id": 43, "reason": "velocity_limit_exceeded"}', 3),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 44, "amount": 25000.00, "fraud_score": 88}', 8),
('transaction_cancelled', 'WARN', '{"transaction_id": 44, "reason": "suspicious_activity"}', 8),
('maximum_amount_exceeded', 'ERROR', '{"transaction_id": 45, "amount": 99999.99, "limit": 10000.00}', 1),
('cryptocurrency_blocked', 'ERROR', '{"transaction_id": 46, "currency": "BTC", "amount": 15000.00}', 6),
('dormant_account_activity', 'WARN', '{"transaction_id": 47, "user_id": 5, "months_inactive": 8}', 5),
('manual_review_required', 'WARN', '{"transaction_id": 48, "amount": 65000.00, "risk_score": 78}', 11),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 49, "amount": 85000.00, "fraud_score": 92}', 13),
('transaction_blocked', 'WARN', '{"transaction_id": 49, "reason": "unusual_amount"}', 13),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 50, "amount": 35000.00, "fraud_score": 85}', 14),
('transaction_cancelled', 'WARN', '{"transaction_id": 50, "reason": "suspicious_merchant"}', 14),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 51, "amount": 95000.00, "fraud_score": 98}', 15),
('transaction_blocked', 'WARN', '{"transaction_id": 51, "reason": "maximum_limit_exceeded"}', 15),
('manual_review_required', 'WARN', '{"transaction_id": 52, "amount": 28000.00, "risk_score": 72}', 16),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 53, "amount": 72000.00, "fraud_score": 89}', 17),
('transaction_blocked', 'WARN', '{"transaction_id": 53, "reason": "velocity_check_failed"}', 17),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 54, "amount": 42000.00, "fraud_score": 87}', 18),
('transaction_cancelled', 'WARN', '{"transaction_id": 54, "reason": "suspicious_pattern"}', 18),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 55, "amount": 88000.00, "fraud_score": 94}', 19),
('transaction_blocked', 'WARN', '{"transaction_id": 55, "reason": "unusual_timing"}', 19),
('manual_review_required', 'WARN', '{"transaction_id": 56, "amount": 33000.00, "risk_score": 75}', 20),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 57, "amount": 78000.00, "fraud_score": 91}', 21),
('transaction_blocked', 'WARN', '{"transaction_id": 57, "reason": "rapid_succession"}', 21),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 58, "amount": 38000.00, "fraud_score": 86}', 22),
('transaction_cancelled', 'WARN', '{"transaction_id": 58, "reason": "suspicious_location"}', 22),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 59, "amount": 92000.00, "fraud_score": 96}', 23),
('transaction_blocked', 'WARN', '{"transaction_id": 59, "reason": "maximum_amount"}', 23),
('manual_review_required', 'WARN', '{"transaction_id": 60, "amount": 29000.00, "risk_score": 70}', 24),
('fraud_alert_high_amount', 'ERROR', '{"transaction_id": 61, "amount": 68000.00, "fraud_score": 90}', 25),
('transaction_blocked', 'WARN', '{"transaction_id": 61, "reason": "velocity_limit"}', 25);

-- Insert additional system logs
INSERT INTO logs (name, level, properties, user_id) VALUES
('user_login_success', 'INFO', '{"ip_address": "192.168.1.100", "location": "New York, NY"}', 2),
('failed_login_attempt', 'WARN', '{"ip_address": "203.0.113.45", "attempts_count": 3}', 8),
('password_reset_requested', 'INFO', '{"ip_address": "192.168.1.200"}', 4),
('database_connection_error', 'ERROR', '{"database": "primary", "retry_attempt": 2}', NULL),
('payment_processor_down', 'ERROR', '{"processor": "stripe", "downtime_minutes": 15}', NULL),
('suspicious_login_location', 'WARN', '{"usual_location": "San Francisco, CA", "current_location": "Moscow, RU"}', 11),
('api_rate_limit_exceeded', 'WARN', '{"requests_per_minute": 150, "limit": 100}', 7),
('kyc_verification_failed', 'ERROR', '{"verification_type": "identity", "attempt": 3}', 8),
('account_suspended', 'WARN', '{"reason": "fraud_suspicion", "admin_id": "admin-001"}', 3),
('system_maintenance_started', 'INFO', '{"maintenance_type": "scheduled", "duration_minutes": 30}', NULL);