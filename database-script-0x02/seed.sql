-- Insert Users
INSERT INTO "User" (
    user_id, first_name, last_name, email, password_hash, role
) VALUES
    (uuid_generate_v4(), 'Alice', 'Smith', 'alice@example.com', 'hashed_pw_1', 'host'),
    (uuid_generate_v4(), 'Bob', 'Jones', 'bob@example.com', 'hashed_pw_2', 'guest');

-- Get user IDs for use in foreign keys
-- (For clarity, this uses CTEs, but in practice you'd store UUIDs in your app)

WITH user_ids AS (
    SELECT user_id FROM "User" ORDER BY created_at LIMIT 2
)
-- Insert Properties (owned by first user)
INSERT INTO Property (
    property_id, host_id, name, description, location, pricepernight
) VALUES
    (uuid_generate_v4(), (SELECT user_id FROM user_ids LIMIT 1), 'Sunny Apartment', 'Cozy 2-bedroom in city center', 'Nairobi', 50.00),
    (uuid_generate_v4(), (SELECT user_id FROM user_ids LIMIT 1), 'Beach House', 'Oceanfront view with Wi-Fi', 'Mombasa', 120.00);

-- Get property and guest IDs
WITH user_ids AS (
    SELECT user_id FROM "User" ORDER BY created_at LIMIT 2
),
property_ids AS (
    SELECT property_id FROM Property ORDER BY created_at LIMIT 2
)
-- Insert Bookings (made by second user)
INSERT INTO Booking (
    booking_id, property_id, user_id, start_date, end_date, total_price, status
) VALUES
    (
        uuid_generate_v4(),
        (SELECT property_id FROM property_ids LIMIT 1),
        (SELECT user_id FROM user_ids OFFSET 1 LIMIT 1),
        '2025-08-01', '2025-08-03', 100.00, 'confirmed'
    ),
    (
        uuid_generate_v4(),
        (SELECT property_id FROM property_ids OFFSET 1 LIMIT 1),
        (SELECT user_id FROM user_ids OFFSET 1 LIMIT 1),
        '2025-08-10', '2025-08-13', 360.00, 'pending'
    );

-- Insert Payments
WITH booking_ids AS (
    SELECT booking_id FROM Booking ORDER BY created_at LIMIT 2
)
INSERT INTO Payment (
    payment_id, booking_id, amount, payment_method
) VALUES
    (uuid_generate_v4(), (SELECT booking_id FROM booking_ids LIMIT 1), 100.00, 'credit_card'),
    (uuid_generate_v4(), (SELECT booking_id FROM booking_ids OFFSET 1 LIMIT 1), 360.00, 'paypal');

-- Insert Reviews
WITH user_ids AS (
    SELECT user_id FROM "User" ORDER BY created_at
),
property_ids AS (
    SELECT property_id FROM Property ORDER BY created_at
)
INSERT INTO Review (
    review_id, property_id, user_id, rating, comment
) VALUES
    (uuid_generate_v4(), (SELECT property_id FROM property_ids LIMIT 1), (SELECT user_id FROM user_ids OFFSET 1 LIMIT 1), 5, 'Amazing place!'),
    (uuid_generate_v4(), (SELECT property_id FROM property_ids OFFSET 1 LIMIT 1), (SELECT user_id FROM user_ids OFFSET 1 LIMIT 1), 4, 'Very nice but a bit noisy.');

-- Insert Messages
WITH user_ids AS (
    SELECT user_id FROM "User" ORDER BY created_at
)
INSERT INTO Message (
    message_id, sender_id, recipient_id, message_body
) VALUES
    (uuid_generate_v4(), (SELECT user_id FROM user_ids LIMIT 1), (SELECT user_id FROM user_ids OFFSET 1 LIMIT 1), 'Hi Bob, your booking is confirmed!'),
    (uuid_generate_v4(), (SELECT user_id FROM user_ids OFFSET 1 LIMIT 1), (SELECT user_id FROM user_ids LIMIT 1), 'Thanks Alice!');

