# frozen_string_literal: true

cask "routebar" do
  version "1.5.1"
  sha256 "cc3cef8a0c36725c7df6ad22eb8e6e6460df8497572243fd10ea74de06ad188e"

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
