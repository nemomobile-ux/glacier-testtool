#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QtGui/QGuiApplication>
#include <QApplication>
#include <QtQml>
#include <QtQuick/QQuickView>

#include <glacierapp.h>


Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication *app = new QApplication(argc, argv);

    QFileInfo exe = QFileInfo(app->applicationFilePath());
    app->setApplicationName(exe.fileName());

    QTranslator* myappTranslator = new QTranslator(app);
    if (myappTranslator->load(QLocale(), app->applicationName(), QLatin1String("_"), QLatin1String("/usr/share/%1/translations/").arg(app->applicationName()) )) {
        qDebug() << "translation.load() success" << QLocale::system().name();
        if (app->installTranslator(myappTranslator)) {
            qDebug() << "installTranslator() success" << QLocale::system().name();
        } else {
            qDebug() << "installTranslator() failed" << QLocale::system().name();
        }
    } else {
        qDebug() << "translation.load() failed" << QLocale::system().name();
    }


// QGuiApplication *app = GlacierApp::app(argc, argv);
    app->setOrganizationName("NemoMobile");
    QQuickWindow *window = GlacierApp::showWindow();
    window->setTitle(QObject::tr("Hardware test"));
    window->setIcon(QIcon("/usr/share/glacier-testtool/icons/glacier-testtool.png"));

    return app->exec();
}
