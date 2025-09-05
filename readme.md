## Custom Finder Sidebar Icons

An Xcode project to set custom icons for folders in the Finder sidebar. `Developer` is a built-in icon, but `Work` and `Ruminate` are using the [SF Symbols](https://developer.apple.com/sf-symbols/) `laptopcomputer` and `waveform` respectively:

![sidebar-example](sidebar-example.png)

This is a small Xcode project based on a combination of [this Reddit post](https://www.reddit.com/r/mac/comments/seig87/how_to_make_custom_finder_sidebar_icons_big_sur/) and this documentation about [CFBundleSymbolName](https://developer.apple.com/documentation/fileprovider/replicated_file_provider_extension/setting_the_finder_sidebar_icon). For each custom icon and folder, you need to run a [Finder Sync app](https://developer.apple.com/documentation/findersync#) (like Dropbox does) which allows the app to set custom sidebar icons, among other things.

## Limitations

- Folders inside Dropbox and Google Drive won't work. To make them work, create an alias to the folder and set _that_ as the path in `URLs`
- The `APPNAME` must be unique, or you will overwrite old icon apps
- To stop your icon app running, you need to delete the app or reboot.
- All of this is _very_ flaky. If it doesn't work, try cleaning the build folder in Xcode and rebuilding (Product > Clean Build Folder). As a last resort a reboot seemed to fix it on a few occasions.

## Setup

Clone or download this repository and then run the following with your options filled in:

- `APPNAME` is the name of your new app. This can be anything, I tend to do `FolderNameIcon`
- `PATH` is the folder you want to have a custom icon for
- `SFSYMBOL` is the SF Symbol you want to use, for example, `flame.fill`

```bash
# three arguments
bash iconify.sh APPNAME PATH SFSYMBOL

# real example
bash iconify.sh DownloadFolderIcon /Users/robb/Downloads flame.fill
```

- In the `dist` folder, open the new `APPNAME.app`
- Enable the extension. Sometimes it needs a toggle a few times to work.
  - On newer versions of macOS, this is in _Settings → General → Login Items and Extensions_.
  - On older versions of macOS, this is in _Settings → Privacy and Security → Extensions → Added Extensions_.
- Add your app to Login Items (_Settings → General → Login Items_) so it runs on boot.

Assuming everything worked correctly, if you drag your selected folder to the sidebar you should see the SF Symbol you selected as the icon.

## Using a custom SF Symbol

This does work, sometimes, but like all of this it's flaky.

- Open the `Media.xcassets` and drag your custom SF symbol into the left panel - the icon should be visible on the right panel in three sizes
- Change `NameOfYourApp/info.plist` icon entry to the name of your custom symbol
- Rebuild and pray to your favourite deity

## Using the same icon for multiple folders

If you want to use the same icon for multiple folders, the `URLs` file may be edited to contain multiple lines. Edit it as, for example:

```sh
APPNAME="DownloadFolderIcon"  # <- or whatever you called it
$EDITOR "dist/${APPNAME}.app/Contents/Plugins/${APPNAME}Sync.appex/Contents/Resources/URLs"
```

## Screencasts

### Standard SF Symbol

https://github.com/rknightuk/custom-finder-sidebar-icons/blob/main/SF%20Symbol.mp4

### Custom SF Symbol

https://github.com/rknightuk/custom-finder-sidebar-icons/blob/main/SF%20Symbol%20Custom.mp4

## Credits

- Code by [Robb Knight](https://rknight.me)
- Icon, screencasts, and making custom SF Symbols work by [Keir Ansell](https://www.keiransell.com)
