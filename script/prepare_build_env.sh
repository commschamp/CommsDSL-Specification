sudo apt install ruby-bundler
bundle init
bundle config set --local path 'vendor/bundle'
bundle add asciidoctor-pdf
bundle add rouge
bundle install
