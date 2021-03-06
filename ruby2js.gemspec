# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby2js}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Macario Ortega"]
  s.date = %q{2009-06-11}
  s.description = %q{FIX (describe your package)}
  s.email = ["macarui@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/ruby2js.rb", "script/console", "script/destroy", "script/generate", "spec/spec_helper.rb", "spec/transliteration_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/maca/ruby2js}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ruby2js}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{FIX (describe your package)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sexp_processor>, [">= 3.0.1"])
      s.add_development_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<sexp_processor>, [">= 3.0.1"])
      s.add_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_dependency(%q<rspec>, [">= 1.2.6"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<sexp_processor>, [">= 3.0.1"])
    s.add_dependency(%q<newgem>, [">= 1.4.1"])
    s.add_dependency(%q<rspec>, [">= 1.2.6"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
