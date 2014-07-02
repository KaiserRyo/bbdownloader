import bb.cascades 1.2
import bb.data 1.0

Sheet {
    property string radver
    property string osver
    property string swrel
    id: osRepo
    content: Page {
        titleBar: TitleBar {
            title: "Known Software List"
            dismissAction: ActionItem {
                title: "Close"
                onTriggered: {
                    osRepo.close()
                }
            }
        }
        Container {
            Header {
                title: "Info"
            }
            Label {
                text: "If there's a new OS, notify me or fork this repo, update xml/repo.xml and make a pull request:\nhttps://github.com/thurask/thurask.github.io"
                content.flags: TextContentFlag.ActiveText
                textStyle.textAlign: TextAlign.Center
                multiline:true
            }
            Header {
                title: "Known Software (Be Patient, It's Retrieving A Database)"
            }
            ListView {
                id: listView
                dataModel: repoDataModel
                listItemComponents: [
                    ListItemComponent {
                        type: "header"
                        Container {
                            Label {
                                text: ""
                            }
                        }
                    },
                    ListItemComponent {
                        type: "item"
                        Container {
                            Label {
                                text: "OS: " + (ListItemData.trueos == "" ? ListItemData.os : ListItemData.trueos)
                                textStyle.fontWeight: FontWeight.Bold
                                multiline: true
                            }
                            Label {
                                text: "Software Release: " + ListItemData.software + " | Radio: " + ListItemData.radio
                            }
                            Label {
                                text: ListItemData.notes
                                textStyle.fontSize: FontSize.Small
                                multiline: true
                            }
                            Divider {
                            }
                        }
                    }
                ]
            }
        }
    }
    attachedObjects: [
        GroupDataModel {
            id: repoDataModel
            sortingKeys: [
            "os"
            ]
            sortedAscending: false
            grouping: ItemGrouping.ByFullValue
        },
        DataSource {
            id: repoDataSource
            remote: true
            source: "http://thurask.github.io/xml/repo.xml"
            query: "repo/release"
            type: DataSourceType.Xml
            onDataLoaded: {
                repoDataModel.clear();
                repoDataModel.insertList(data)
            }
        }
    ]
    onCreationCompleted: {
        repoDataSource.load();
    }
}