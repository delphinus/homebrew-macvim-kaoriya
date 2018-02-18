cask 'macvim-kaoriya' do
  conflicts_with cask: 'macvim-kaoriya-override'

  if MacOS.version <= :lion
    version '7.4:20130911'
    sha256 'd9fc6e38de1852e4ef79e9ea78afa60e606bf45066cff031e349d65748cbfbce'
  else
    version '8.0:20180218'
    sha256 '2335fd3f372751cbcaea64b809f42827de5774b7e4117ae14c79f432b5896a6e'
  end

  url "https://github.com/splhack/macvim-kaoriya/releases/download/#{version.after_colon}/MacVim-KaoriYa-#{version.after_colon}.dmg"
  appcast 'https://github.com/splhack/macvim-kaoriya/releases.atom',
          checkpoint: 'e9575c0256ed2d95a297228d2fbaeaa12f03fd38fb8064b464edab10e78528d1'
  name 'MacVim KaoriYa'
  homepage 'https://github.com/splhack/macvim-kaoriya'

  depends_on macos: '>= :lion'

  app 'MacVim.app'

  mvim = "#{appdir}/MacVim.app/Contents/bin/mvim"
  executables = %w[macvim-askpass mvim mvimdiff mview mvimex gvim gvimdiff gview gvimex]
  executables.each { |e| binary mvim, target: e }

  zap delete: [
                '~/Library/Preferences/org.vim.MacVim.LSSharedFileList.plist',
                '~/Library/Preferences/org.vim.MacVim.plist',
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
        gvim / gvimdiff / gview / gvimex

      If you want to override the system Vim, use `macvim-kaoriya-override`
      cask instead. This was the `OVERRIDE_SYSTEM_VIM=1` option in the previous
      build.
    EOS
  end
end
