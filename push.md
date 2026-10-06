0: pull latest changes with git pull --rebase origin <branch> (sync upstream changes)
1: update version name to today (YY.M.D) in pubspec.yaml
2: update version code (increment, also today: 21YYMMDDxx) in pubspec.yaml
3: update latest.md with release notes
4: clean and build release APKs locally:
   - remove old APKs from builds/ (`rm -f builds/*.apk`)
   - build split APKs: `flutter build apk --release --split-per-abi`
   - copy APKs: copy each `build/app/outputs/flutter-apk/app-<abi>-release.apk` to `builds/flow-v${VERSION}-${ABI}.apk`
5: update builds/latest.json, builds/latest.txt, and latest.txt with version name, version code, and APK URLs
6: copy latest.md to builds/latest.md and builds/whatsnew/${VERSION}.md
7: commit all changes and push (`git commit` and `git push origin HEAD:<branch>`)
