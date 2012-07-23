# Maintainer: nandub <dev@nandub-dev.tk>
pkgname=piratebox-ws-git
pkgver=20120723
pkgrel=1
pkgdesc="PirateBox Scriptcollection for running in Webserver"
arch=('i686', 'x86_64')
url="https://github.com/nandub/PirateBoxScripts_Webserver"
license=('GPL-3')
depends=('hostapd' 'dnsmasq' 'lighttpd' 'unzip')
makedepends=('git')

_gitroot=https://github.com/nandub/PirateBoxScripts_Webserver.git
_gitname=piratebox-ws-git

build() {
  cd "$srcdir"
  msg "Connecting to GIT server...."

  if [[ -d "$_gitname" ]]; then
    cd "$_gitname" && git pull origin
    msg "The local files are updated."
  else
    git clone --depth=1 "$_gitroot" "$_gitname"
  fi

  msg "GIT checkout done or server timeout"
  msg "Starting build..."

  cd "$_gitname"

  # Create directory structures                                                     
  install -m755 -d "$pkgdir/opt/piratebox/bin"                                                
  install -m655 -d "$pkgdir/opt/piratebox/rc.d"                             
  install -m655 -d "$pkgdir/opt/piratebox/conf"                                                
  # Copy files to their respective folders                                          
  cp -Rv piratebox "$pkgdir/opt"
  ln -s "$pkgdir/opt/piratebox/init.d/piratebox_arch" "$pkgdir/etc/rc.d/piratebox"
}
# vim:set ts=2 sw=2 et:
