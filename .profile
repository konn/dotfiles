#
# Your previous .profile  (if any) is saved as .profile.mpsaved
# Setting the path for MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH="$HOME/.cargo/bin:$PATH"

if [ -d $HOME/.nix-profile ]; then
  source $HOME/.nix-profile/etc/profile.d/nix.export PATH="$HOME/.nix-profile/bin:$PATH"
fi
