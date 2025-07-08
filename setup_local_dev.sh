#!/bin/bash

# Jekyll Local Development Environment Setup Script
# This script sets up a local development environment for your GitHub Pages Jekyll site

set -e  # Exit on any error

echo "🚀 Setting up Jekyll local development environment..."

# Check if Ruby is installed
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby is not installed. Please install Ruby first."
    exit 1
fi

echo "✅ Ruby found: $(ruby --version)"

# Check if Bundler is installed
if ! command -v bundle &> /dev/null; then
    echo "📦 Installing Bundler..."
    gem install bundler
else
    echo "✅ Bundler found: $(bundle --version)"
fi

# Update Bundler to latest version
echo "🔄 Updating Bundler..."
gem install bundler
bundle update --bundler

# Check if Gemfile exists
if [ ! -f "Gemfile" ]; then
    echo "❌ Gemfile not found. Make sure you're in the correct directory."
    exit 1
fi

# Backup original Gemfile if this is the first run
if [ ! -f "Gemfile.backup" ]; then
    echo "💾 Creating backup of original Gemfile..."
    cp Gemfile Gemfile.backup
fi

# Check if required gems are already in Gemfile
echo "🔍 Checking for required gems in Gemfile..."

# Add required gems for Ruby 3.4+ compatibility
if ! grep -q "gem \"csv\"" Gemfile; then
    echo "➕ Adding csv gem to Gemfile..."
    echo 'gem "csv"' >> Gemfile
fi

if ! grep -q "gem \"webrick\"" Gemfile; then
    echo "➕ Adding webrick gem to Gemfile..."
    echo 'gem "webrick"' >> Gemfile
fi

# Update nokogiri version if it's using an old version
if grep -q "nokogiri.*1\.10" Gemfile; then
    echo "🔄 Updating nokogiri version for compatibility..."
    sed -i '' 's/gem "nokogiri", "~> 1\.10\.[0-9]*"/gem "nokogiri", "~> 1.13.0"/' Gemfile
fi

# Remove old lockfile to avoid version conflicts
if [ -f "Gemfile.lock" ]; then
    echo "🗑️  Removing old Gemfile.lock..."
    rm Gemfile.lock
fi

# Install dependencies
echo "📦 Installing dependencies..."
bundle install

# Test if Jekyll can start
echo "🧪 Testing Jekyll installation..."
if bundle exec jekyll --version &> /dev/null; then
    echo "✅ Jekyll is working properly!"
else
    echo "❌ Jekyll installation failed. Check the output above for errors."
    exit 1
fi

# Create a convenience script to start the server
echo "📝 Creating start script..."
cat > start_server.sh << 'EOF'
#!/bin/bash
echo "🚀 Starting Jekyll development server..."
echo "📱 Your site will be available at: http://localhost:4000"
echo "⏹️  Press Ctrl+C to stop the server"
echo ""
bundle exec jekyll serve --port 4000 --host 0.0.0.0 --livereload
EOF

chmod +x start_server.sh

echo ""
echo "🎉 Setup complete! Your Jekyll development environment is ready."
echo ""
echo "📋 Next steps:"
echo "   1. To start the development server: ./start_server.sh"
echo "   2. Or run manually: bundle exec jekyll serve"
echo "   3. Visit your site at: http://localhost:4000"
echo ""
echo "💡 Tips:"
echo "   - The server will automatically reload when you make changes"
echo "   - Press Ctrl+C to stop the server"
echo "   - Your original Gemfile is backed up as Gemfile.backup"
echo ""
echo "🔧 If you encounter issues:"
echo "   - Make sure you're in the project directory"
echo "   - Try: bundle install"
echo "   - For port conflicts, use: bundle exec jekyll serve --port 4001"