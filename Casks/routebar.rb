# frozen_string_literal: true

cask "routebar" do
  version "1.1.0"
  sha256 "beac62fa160e1fdf9ac1912bc8babc047b3925d6e9ddacee7374d4d4ac9db512"

  url "https://github.com/spilneo/RouteBar/releases/download/v#{version}/RouteBar.zip"
  name "RouteBar"
  desc "Menu bar endpoint, usage and model picker for OmniRoute"
  homepage "https://github.com/spilneo/RouteBar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "node"
  depends_on macos: :sonoma

  app "RouteBar.app"

  # RouteBar is ad-hoc signed, not notarized. Clearing the quarantine flag lets
  # it open on first launch without a Gatekeeper prompt.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/RouteBar.app"],
        must_succeed: false
  end

  uninstall quit: "com.spilneo.RouteBar"

  zap trash: [
    "~/Library/Logs/RouteBar",
    "~/Library/Preferences/com.spilneo.RouteBar.plist",
  ]
end
