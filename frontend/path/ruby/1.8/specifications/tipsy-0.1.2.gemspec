# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tipsy}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brent Kirby"]
  s.date = %q{2012-04-21}
  s.default_executable = %q{tipsy}
  s.description = %q{Tipsy is a mini Rack application for working with static websites using Tilt, and Sprockets.}
  s.email = ["info@kurbmedia.com"]
  s.executables = ["tipsy"]
  s.files = [".gitignore", "Gemfile", "README.md", "Rakefile", "bin/tipsy", "lib/templates/server/htaccess.erb", "lib/templates/site/Gemfile", "lib/templates/site/assets/stylesheets/_config.css.scss", "lib/templates/site/assets/stylesheets/screen.css.scss", "lib/templates/site/compiled/.gitkeep", "lib/templates/site/config.rb", "lib/templates/site/deploy.yml", "lib/templates/site/helpers/site_helper.rb", "lib/templates/site/layouts/default.html.erb", "lib/templates/site/public/.gitkeep", "lib/templates/site/views/index.html.erb", "lib/tipsy.rb", "lib/tipsy/compressors/css_compressor.rb", "lib/tipsy/compressors/javascript_compressor.rb", "lib/tipsy/configuration.rb", "lib/tipsy/handler/all.rb", "lib/tipsy/handler/asset.rb", "lib/tipsy/handler/erb.rb", "lib/tipsy/handler/php.rb", "lib/tipsy/handler/sass.rb", "lib/tipsy/handler/sass/importer.rb", "lib/tipsy/handler/sass/resolver.rb", "lib/tipsy/handler/static.rb", "lib/tipsy/helpers.rb", "lib/tipsy/helpers/asset_paths.rb", "lib/tipsy/helpers/asset_tags.rb", "lib/tipsy/helpers/capture.rb", "lib/tipsy/helpers/rendering.rb", "lib/tipsy/helpers/sass.rb", "lib/tipsy/helpers/tag.rb", "lib/tipsy/runner.rb", "lib/tipsy/runners/compiler.rb", "lib/tipsy/runners/deployer.rb", "lib/tipsy/runners/generator.rb", "lib/tipsy/server.rb", "lib/tipsy/site.rb", "lib/tipsy/utils/logger.rb", "lib/tipsy/utils/system.rb", "lib/tipsy/utils/system_test.rb", "lib/tipsy/utils/tree.rb", "lib/tipsy/version.rb", "lib/tipsy/view.rb", "lib/tipsy/view/base.rb", "lib/tipsy/view/context.rb", "lib/tipsy/view/path.rb", "test/fixtures/capture.html.erb", "test/helpers/tag_test.rb", "test/root/config.rb", "test/root/layouts/default.html.erb", "test/root/public/normal/skipped.txt", "test/root/public/skipped/file.txt", "test/root/views/index.html.erb", "test/root/views/page.html.erb", "test/root/views/sub/page.html.erb", "test/root/views/sub/tertiary/index.html.erb", "test/runner/compiler_test.rb", "test/test_helper.rb", "test/unit/site_test.rb", "test/unit/tipsy_test.rb", "test/unit/utils/system_test.rb", "test/unit/utils/tree_test.rb", "test/view/base_test.rb", "test/view/path_test.rb", "tipsy.gemspec"]
  s.homepage = %q{https://github.com/kurbmedia/tipsy}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{tipsy}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A mini Rack application server for developing static sites.}
  s.test_files = ["test/fixtures/capture.html.erb", "test/helpers/tag_test.rb", "test/root/config.rb", "test/root/layouts/default.html.erb", "test/root/public/normal/skipped.txt", "test/root/public/skipped/file.txt", "test/root/views/index.html.erb", "test/root/views/page.html.erb", "test/root/views/sub/page.html.erb", "test/root/views/sub/tertiary/index.html.erb", "test/runner/compiler_test.rb", "test/test_helper.rb", "test/unit/site_test.rb", "test/unit/tipsy_test.rb", "test/unit/utils/system_test.rb", "test/unit/utils/tree_test.rb", "test/view/base_test.rb", "test/view/path_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["~> 1.3"])
      s.add_runtime_dependency(%q<rack-test>, ["~> 0.6"])
      s.add_runtime_dependency(%q<tilt>, ["~> 1.3"])
      s.add_runtime_dependency(%q<i18n>, ["~> 0.6"])
      s.add_runtime_dependency(%q<sass>, ["~> 3.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.1"])
      s.add_runtime_dependency(%q<sprockets>, ["~> 2.0"])
      s.add_runtime_dependency(%q<hike>, ["~> 1.2"])
      s.add_runtime_dependency(%q<erubis>, ["~> 2.7"])
      s.add_development_dependency(%q<minitest>, ["~> 2.5"])
    else
      s.add_dependency(%q<rack>, ["~> 1.3"])
      s.add_dependency(%q<rack-test>, ["~> 0.6"])
      s.add_dependency(%q<tilt>, ["~> 1.3"])
      s.add_dependency(%q<i18n>, ["~> 0.6"])
      s.add_dependency(%q<sass>, ["~> 3.1"])
      s.add_dependency(%q<activesupport>, [">= 3.1"])
      s.add_dependency(%q<sprockets>, ["~> 2.0"])
      s.add_dependency(%q<hike>, ["~> 1.2"])
      s.add_dependency(%q<erubis>, ["~> 2.7"])
      s.add_dependency(%q<minitest>, ["~> 2.5"])
    end
  else
    s.add_dependency(%q<rack>, ["~> 1.3"])
    s.add_dependency(%q<rack-test>, ["~> 0.6"])
    s.add_dependency(%q<tilt>, ["~> 1.3"])
    s.add_dependency(%q<i18n>, ["~> 0.6"])
    s.add_dependency(%q<sass>, ["~> 3.1"])
    s.add_dependency(%q<activesupport>, [">= 3.1"])
    s.add_dependency(%q<sprockets>, ["~> 2.0"])
    s.add_dependency(%q<hike>, ["~> 1.2"])
    s.add_dependency(%q<erubis>, ["~> 2.7"])
    s.add_dependency(%q<minitest>, ["~> 2.5"])
  end
end
