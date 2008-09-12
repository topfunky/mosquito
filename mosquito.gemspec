Gem::Specification.new do |s|
  s.name = %q{mosquito}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Geoffrey Grosenbach"]
  s.date = %q{2008-09-12}
  s.description = %q{A library for writing tests for your Camping app.}
  s.email = %q{boss@topfunky.com}
  s.extra_rdoc_files = ["Manifest.txt", "README.txt"]
  s.files = ["CHANGELOG", "MIT-LICENSE", "Manifest.txt", "README.txt", "Rakefile", "lib/mosquito.rb", "public/bare.rb", "public/blog.rb", "public/blog/controllers.rb", "public/blog/models.rb", "public/blog/views.rb", "test/fixtures/blog_comments.yml", "test/fixtures/blog_posts.yml", "test/fixtures/blog_users.yml", "test/sage_advice_cases/parsing_arrays.rb", "test/test_bare.rb", "test/test_blog.rb", "test/test_helpers.rb", "test/test_mock_request.rb", "test/test_mock_upload.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://mosquito.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{mosquito}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A Camping test library.}
  s.test_files = ["test/test_bare.rb", "test/test_blog.rb", "test/test_helpers.rb", "test/test_mock_request.rb", "test/test_mock_upload.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<camping>, [">= 0"])
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<camping>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<camping>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
