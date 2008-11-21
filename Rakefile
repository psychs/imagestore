task :clean do |t|
  sh "rm -rf build check"
end

task :check => :clean do |t|
  sh "scan-build -o ./check --view xcodebuild -configuration Debug"
end
