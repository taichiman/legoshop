# Spree::Core::Engine.load_seed if defined?(Spree::Core)

# Loads seed data out of default dir
default_path = File.join(File.dirname(__FILE__), 'default')

Rake::Task['db:load_dir'].reenable
Rake::Task['db:load_dir'].invoke(default_path)

Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
