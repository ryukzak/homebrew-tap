cask "wtf" do
  version "0.0.3"
  sha256 "caf0d58a849ba15d027148c07197841c421580136c75adc593ec6c373939eaac"

  url "https://github.com/ryukzak/wtf/archive/refs/tags/v#{version}.tar.gz"
  name "wtf"
  desc "Git client for reviewing what AI agents did"
  homepage "https://github.com/ryukzak/wtf"

  depends_on formula: "rust"
  depends_on macos: :sonoma

  app "wtf-#{version}/build/wtf.app", target: "wtf.app"
  binary "#{appdir}/wtf.app/Contents/Resources/wtf"

  # Built here, from source: Homebrew quarantines what it unpacks, not what
  # the build makes, so macOS opens the app without asking. Cargo's files
  # stay in the Caskroom, away from ~/.cargo, and need the network.
  preflight_steps do
    mkdir_p "tmp"
    run "/bin/sh",
        args:           ["{{staged_path}}/wtf-{{version}}/scripts/build.sh"],
        env:            {
          "CARGO_HOME"       => "{{staged_path}}/cargo",
          "CARGO_TARGET_DIR" => "{{staged_path}}/target",
          "PATH"             => "{{HOMEBREW_PREFIX}}/bin:/usr/bin:/bin",
          "TMPDIR"           => "{{staged_path}}/tmp",
        },
        print_stdout:   true,
        network_access: true
  end

  # The build leaves gigabytes in the Caskroom; only the app is kept.
  postflight_steps do
    remove %w[target cargo tmp], recursive: true
  end

  zap trash: [
    "~/Library/Application Support/dev.wtf.wtf",
    "~/Library/Preferences/dev.wtf.wtf.plist",
  ]
end
