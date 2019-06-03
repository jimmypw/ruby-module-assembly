# ruby-module-assembly

## Requirements
- x86_64 compatable Linux (Developed on centos 7.5)
- Ruby 2.5.1p57 (any ruby >2.0 should work) with development headers
- GNU build system
- Nasm (2.10.07)

## Building
```
yum group install "Development Tools"
yum install ruby ruby-devel nasm
gem install bundler
# Assemble the critical functionusing NASM
cd <source file location>
bundle install
cd ext/quantbet
ruby extconf.rb
make
```
