#ifndef SAILBUSDUBLIN_H
#define SAILBUSDUBLIN_H

#include <QObject>
#include <QSettings>

class SailBusDublin : public QObject
{
    Q_OBJECT

public:
    explicit SailBusDublin(QObject *parent = 0);
//    Q_INVOKABLE bool validateUrl(QString url);

private:
    QSettings settings;

signals:

public slots:
    Q_INVOKABLE void setSetting(const QString &key, const QVariant &value);
    Q_INVOKABLE QVariant getSetting(const QString &key, const QVariant &defaultValue = QVariant());

};

#endif // SAILBUSDUBLIN_H
