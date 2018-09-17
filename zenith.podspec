
Pod::Spec.new do |s|
  s.name          = "Zenith"
  s.version       = File.read("VERSION")
  s.summary       = "Functional-ish platform witha touch of the fluxes"
  s.description   = "A nice little library for introducing a few things from Elixir land"
  s.homepage      = "https://github.com/wess/zenith"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = "Wess Cope"
  s.platform      = :ios, '11.0'
  s.source        = { :git => "https://github.com/wess/zenith.git", :tag => s.version.to_s }
  s.source_files  = ["Sources/**/*.swift", "Sources/*.swift"]
end
