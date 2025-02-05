#!/usr/bin/env ruby
#
# Copyright 2016 Joe Block <jpb@unixorn.net>
#
# License: Apache 2.0, see LICENSE in this repository.
#
# Helper functions that are common across the git-bb-* scripts. Admittedly
# not very pretty.

def git_branch
  `git rev-parse --abbrev-ref HEAD`.chomp
end

def git_commit
  `git rev-parse HEAD`.chomp
end

def git_remote
  `git config --get remote.origin.url`.chomp
end

def repo_url
  remote = git_remote
  parts = remote[remote.index("@")+1..remote.index(".git")-1].split("/")  
  if remote.index("ssh") == 0
    return "#{parts[0]}/projects/#{parts[1]}/repos/#{parts[2]}"
  end
  return "#{parts[0]}/projects/#{parts[2]}/repos/#{parts[3]}"
end

def git_root
  `git rev-parse --show-toplevel`.chomp
end

def openURL(url)
  if RUBY_PLATFORM.index('darwin')
    open_command = 'open'
  end
  if RUBY_PLATFORM.index('linux')
    open_command = 'xdg-open'
  end
  system("#{open_command} #{url}")
end
