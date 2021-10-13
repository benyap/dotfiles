#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# See links below for a list of official Apple UTIs (uniform type identifiers)
# https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html
# https://developer.apple.com/documentation/uniformtypeidentifiers/system_declared_uniform_type_identifiers


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


setup_vscode_file_associations() {
  local -r vscodeId="com.microsoft.VSCode"
  local -r vscodeName="Visual Studio Code"
  _setup_file_association public.text "$vscodeId" "$vscodeName"
  _setup_file_association public.plain-text "$vscodeId" "$vscodeName"
  _setup_file_association public.utf8-plain-text "$vscodeId" "$vscodeName"
  _setup_file_association public.utf16-plain-text "$vscodeId" "$vscodeName"
  _setup_file_association public.utf16-external-plain-text "$vscodeId" "$vscodeName"
  _setup_file_association public.delimited-values-text "$vscodeId" "$vscodeName"
  _setup_file_association public.comma-separated-values-text "$vscodeId" "$vscodeName"
  _setup_file_association public.tab-separated-values-text "$vscodeId" "$vscodeName"
  _setup_file_association public.utf8-tab-separated-values-text "$vscodeId" "$vscodeName"
  _setup_file_association public.source-code "$vscodeId" "$vscodeName"
  _setup_file_association public.script "$vscodeId" "$vscodeName"
  _setup_file_association public.shell-script "$vscodeId" "$vscodeName"
  _setup_file_association public.python-script "$vscodeId" "$vscodeName"
  _setup_file_association public.ruby-script "$vscodeId" "$vscodeName"
  _setup_file_association public.perl-script "$vscodeId" "$vscodeName"
  _setup_file_association public.php-script "$vscodeId" "$vscodeName"
  _setup_file_association public.rtf "$vscodeId" "$vscodeName"
  _setup_file_association public.xml "$vscodeId" "$vscodeName"
  _setup_file_association public.yaml "$vscodeId" "$vscodeName"
  _setup_file_association public.json "$vscodeId" "$vscodeName"
  _setup_file_association public.log "$vscodeId" "$vscodeName"
  _setup_file_association com.netscape.javascript-source "$vscodeId" "$vscodeName"
  _setup_file_association com.apple.applescript.script "$vscodeId" "$vscodeName"
  _setup_file_association com.apple.applescript.script-bundle "$vscodeId" "$vscodeName"
  _setup_file_association com.apple.applescript.text "$vscodeId" "$vscodeName"
  _setup_file_association com.apple.property-list "$vscodeId" "$vscodeName"
  _setup_file_association com.apple.xml-property-list "$vscodeId" "$vscodeName"
  
  # Not documented
  _setup_file_association public.bash-script "$vscodeId" "$vscodeName"
  _setup_file_association com.apple.terminal.shell-script "$vscodeId" "$vscodeName"
  _setup_file_association public.zsh-script "$vscodeId" "$vscodeName"
  _setup_file_association public.unix-executable "$vscodeId" "$vscodeName"  

  # FIXME: known issues
  # - unable to associate net.daringfireball.markdown with VSCode
}


setup_iina_file_associations() {
  local -r iinaId="com.colliderli.iina"
  local -r iinaName="IINA"
  _setup_file_association "public.mpeg" "$iinaId" "$iinaName"
  _setup_file_association "public.mpeg-2-video" "$iinaId" "$iinaName"
  _setup_file_association "public.mpeg-2-transport-stream" "$iinaId" "$iinaName"
  _setup_file_association "public.mpeg-4" "$iinaId" "$iinaName"
  _setup_file_association "public.mpeg-4-audio" "$iinaId" "$iinaName"
  _setup_file_association "public.avchd-mpeg-2-transport-stream" "$iinaId" "$iinaName"
  _setup_file_association "public.ac3-audio" "$iinaId" "$iinaName"
  _setup_file_association "public.3gpp" "$iinaId" "$iinaName"
  _setup_file_association "public.aiff-audio" "$iinaId" "$iinaName"
  _setup_file_association "public.mp3" "$iinaId" "$iinaName"
  _setup_file_association "public.avi" "$iinaId" "$iinaName"
  _setup_file_association "public.pls-playlist" "$iinaId" "$iinaName"
  _setup_file_association "public.m3u-playlist" "$iinaId" "$iinaName"
  _setup_file_association "public.3gpp2" "$iinaId" "$iinaName"
  _setup_file_association "public.aac-audio" "$iinaId" "$iinaName"
  _setup_file_association "public.midi-audio" "$iinaId" "$iinaName"
  _setup_file_association "io.iina.mkv" "$iinaId" "$iinaName"
  _setup_file_association "io.iina.cue" "$iinaId" "$iinaName"
  _setup_file_association "io.iina.mka" "$iinaId" "$iinaName"
  _setup_file_association "io.iina.opus" "$iinaId" "$iinaName"
  _setup_file_association "com.apple.m4a-audio" "$iinaId" "$iinaName"
  _setup_file_association "com.apple.m4v-video" "$iinaId" "$iinaName"
  _setup_file_association "com.apple.protected-mpeg-4-audio" "$iinaId" "$iinaName"
  _setup_file_association "com.apple.protected-mpeg-4-video" "$iinaId" "$iinaName"
  _setup_file_association "com.apple.quicktime-movie" "$iinaId" "$iinaName"
  _setup_file_association "com.apple.coreaudio-format" "$iinaId" "$iinaName"
  _setup_file_association "com.adobe.flash.video" "$iinaId" "$iinaName"
  _setup_file_association "com.microsoft.windows-media-wma" "$iinaId" "$iinaName"
  _setup_file_association "com.microsoft.waveform-audio" "$iinaId" "$iinaName"
  _setup_file_association "com.microsoft.windows-media-wmv" "$iinaId" "$iinaName"
  _setup_file_association "com.real.realmedia-vbr" "$iinaId" "$iinaName"
  _setup_file_association "com.real.realaudio" "$iinaId" "$iinaName"
  _setup_file_association "com.real.realmedia" "$iinaId" "$iinaName"
  _setup_file_association "org.xiph.ogv" "$iinaId" "$iinaName"
  _setup_file_association "org.xiph.ogg-audio" "$iinaId" "$iinaName"
  _setup_file_association "org.xiph.flac" "$iinaId" "$iinaName"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


_setup_file_association() {
  local -r uti="$1"
  local -r application="$2"
  local -r name="$3"
  if ! _is_file_association_set "$uti" "$application" &> /dev/null; then
    execute "duti -s $application $uti all" "Set $uti to open with $name"
  # else
  #   print_ok "$uti already set to open with $name"
  fi
}


_is_file_association_set() {
  local -r uti="$1"
  local -r application="$2"
  duti -l "$uti" | head -n 1 | grep "$application"
}
