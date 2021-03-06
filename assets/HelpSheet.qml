/*HelpSheet.qml
 * --------------
 * Help menu, including credits and notes.
 *
 --Thurask*/

import bb.cascades 1.4
import bb 1.3

Sheet {
    id: helpSheet
    content: Page {
        titleBar: TitleBar {
            title: qsTr("Help") + Retranslate.onLanguageChanged
            dismissAction: ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                onTriggered: {
                    helpSheet.close()
                    if (helpSheet) helpSheet.destroy();
                }
            }
        }
        Container {
            Label {
                text: qsTr("BB10 OS Downloader %1").arg(appinfo.version)
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontWeight: FontWeight.Bold
                textStyle.fontSize: FontSize.Large
            }
            Label {
                text: qsTr("https://github.com/thurask/bbdownloader") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                textFit.mode: LabelTextFitMode.Default
                textStyle.textAlign: TextAlign.Center
                content.flags: TextContentFlag.ActiveText
                multiline: true
            }
            Header {
                title: qsTr("README") + Retranslate.onLanguageChanged //Markdown to HTML: http://stackedit.io/
            }
            ScrollView {
                scrollRole: ScrollRole.Main
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                scrollViewProperties.pinchToZoomEnabled: false
                scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
                WebView {
                    id: wview
                    url: "local:///assets/html/README.html"
                    settings.activeTextEnabled: false
                    settings.background: Color.Transparent
                    onNavigationRequested: {
                        if (request.url == "local:///assets/html/README.html") {
                            request.action = WebNavigationRequestAction.Accept
                        } else {
                            request.action = WebNavigationRequestAction.Ignore //open in browser, but do it yourself
                        }
                    }
                    onLoadingChanged: {
                        if (loadProgress == 100) {
                            wview.postMessage(Settings.getValueFor("theme", "bright"))
                        }
                    }
                }
            }
        }
    }
    attachedObjects: [
        ApplicationInfo {
            id: appinfo
        }
    ]
}