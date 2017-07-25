cask 'macvim-kaoriya' do
  if MacOS.version <= :lion
    version '7.4:20130911'
    sha256 'd9fc6e38de1852e4ef79e9ea78afa60e606bf45066cff031e349d65748cbfbce'
  else
    version '8.0:20170724'
    sha256 '4684615a3b44f75dc6d6dd73efa32fa9fe91ea089029f792272685f29997d901'
  end

  url "https://github.com/splhack/macvim-kaoriya/releases/download/#{version.after_colon}/MacVim-KaoriYa-#{version.after_colon}.dmg"
  appcast 'https://github.com/splhack/macvim-kaoriya/releases.atom',
          checkpoint: '1345c8ae8e9e5bc7e6336463e7a9e19638524a1afc9c7a737d39517c36b519a8'
  name 'MacVim KaoriYa'
  homepage 'https://github.com/splhack/macvim-kaoriya'

  depends_on macos: '>= :lion'

  app 'MacVim.app'

  mvim = "#{appdir}/MacVim.app/Contents/bin/mvim"
  executables = %w[macvim-askpass mvim mvimdiff mview mvimex gvim gvimdiff gview gvimex]
  executables += %w[vi vim vimdiff view vimex] if ENV['OVERRIDE_SYSTEM_VIM']
  executables.each { |e| binary mvim, target: e }

  zap delete: [
                '~/Library/Preferences/org.vim.MacVim.LSSharedFileList.plist',
                '~/Library/Preferences/org.vim.MacVim.plist',
              ]

  caveats do
    files_in_usr_local
    <<-EOS.undent
      Note that homebrew also provides a compiled macvim Formula that links its
      binary to /usr/local/bin/mvim. And the Cask MacVim also does. It's not
      recommended to install both the Cask MacVim KaoriYa and the Cask MacVim
      and the Formula of MacVim.

      This cask installs symlinks in /usr/local/bin that target to the binary
      MacVim.app/Contents/MacOS/mvim. Below is the list.
        macvim-askpass / mvim / mvimdiff / mview / mvimex /
        gvim / gvimdiff / gview / gvimex

      With OVERRIDE_SYSTEM_VIM=1 environmental variable, you can have more
      symlinks to use macvim-kaoriya instead of the system vim.
        vi / vim / vimdiff / view / vimex

      Note: in previous version, it was `--override-system-vim` option to do
      this.
    EOS
  end
end
