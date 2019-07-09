# frozen_string_literal: true

cask 'macvim-kaoriya-override' do
  conflicts_with cask: 'macvim-kaoriya'

  version '8.0:20180324'
  sha256 '1f02f5f23635d7e22b65366d45fb9794783e9fbd8b0118822c03879051517dae'

  url "https://github.com/splhack/macvim-kaoriya/releases/download/#{version.after_colon}/MacVim-KaoriYa-#{version.after_colon}.dmg"
  appcast 'https://github.com/splhack/macvim-kaoriya/releases.atom',
          checkpoint: 'a912201811add06a14cc0568e3e77ca924f0297f4c930cd6a69284b278d87366'
  name 'MacVim KaoriYa'
  homepage 'https://github.com/splhack/macvim-kaoriya'

  app 'MacVim.app'

  mvim = "#{appdir}/MacVim.app/Contents/bin/mvim"
  executables = %w[macvim-askpass mvim mvimdiff mview mvimex gvim gvimdiff gview gvimex]
  executables += %w[vi vim vimdiff view vimex] # overriding system Vim
  executables.each { |e| binary mvim, target: e }

  zap delete: [
    '~/Library/Preferences/org.vim.MacVim.LSSharedFileList.plist',
    '~/Library/Preferences/org.vim.MacVim.plist'
  ]

  caveats do
    files_in_usr_local
    <<~EOS
      Note that homebrew also provides a compiled macvim Formula that links its
      binary to /usr/local/bin/mvim. And the Cask MacVim also does. It's not
      recommended to install both the Cask MacVim KaoriYa and the Cask MacVim
      and the Formula of MacVim.

      This cask installs symlinks in /usr/local/bin that target to the binary
      MacVim.app/Contents/MacOS/mvim. Below is the list.
        macvim-askpass / mvim / mvimdiff / mview / mvimex /
        gvim / gvimdiff / gview / gvimex /
        vi / vim / vimdiff / view / vimex

      The last line means this cask overrides the system Vim. This was the
      `OVERRIDE_SYSTEM_VIM=1` option in the previous build.

      If you do not want to override, use the `macvim-kaoriya` cask instead.
    EOS
  end
end
