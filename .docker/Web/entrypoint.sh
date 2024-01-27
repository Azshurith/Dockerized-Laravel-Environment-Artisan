#!/bin/sh

# Load environment variables
source .env

# Export all variables loaded from .env# Export variables from .env file
export $(grep -v '^#' .env | grep -v '^\s*$' | sed 's/\r$//' | xargs)

# Change to the Web directory
cd Web

# Clone your laravel repository
git clone "$PROJECT_REPOSITORY" .

# Start PHP-FPM in the background
php-fpm -D

# Install or update Composer dependencies
composer install

# Copy .env.example to .env
cp .env.example .env

# Generate Laravel application key
php artisan key:generate

# Start Laravel's built-in development server
php artisan serve --host 0.0.0.0 --port 8000