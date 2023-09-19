# zotero-beta-deb

鉴于 Zotero 6 所使用的 firefox 60.9esr 在 Debian GNU/Linux 12 (bookworm) 下难以成功编译（链接过程需要 debug 的问题过于繁杂，因此我个人决定暂时搁置这方面的工作）。同时从我个人意愿角度出发，我并不认可通过 make install 旧版 GCC 的方式进行编译工作，这样的做法及其不干净。同时 Zotero 开发团队宣称他们将在 2023 年推出 Zotero 7 并且所使用的 firefox 版本在此后将与 firefox esr 版本保持同步，为此他们对源码进行了大规模的重写与整合，而如今已是 2023 年的第三季度末尾了，Zotero 团队的 Zotero 7 beta 也已经历了多个版本的迭代。因此我决定等待 Zotero 7 的发布，并在此前将其打包为 deb 包，并上传至 Debian GNU/Linux 13 (trixie/sid) 下进行安装。

## TODO

在该部分完成后我们可以着手为 AUR 提供 zotero-beta 及 zotero-git 的 PKGBUILD 文件。